FROM ruby:2.7.2

WORKDIR /myapp
# Installing curl
RUN apt-get install curl -y


# Installing nodejs
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get update -qq && apt-get install -y --no-install-recommends build-essential nodejs libpq-dev libc6-dev wget

# Install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list


RUN apt update && apt install yarn -y --no-install-recommends


COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
COPY entrypoint.sh entrypoint.sh

RUN gem install bundler -v "2.1.4"
RUN bundle install

COPY . .
RUN yarn install --check-files
RUN ls
# Add a script to be executed every time the container starts.


#RUN chmod +x /usr/bin/entrypoint.sh
#ENTRYPOINT ["entrypoint.sh"]
#EXPOSE 3000

# Start the main process.
#CMD ["rails", "server", "-b", "0.0.0.0"]
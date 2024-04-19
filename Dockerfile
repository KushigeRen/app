FROM ruby:3.1.4

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs default-mysql-client
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash - && apt-get install -y nodejs
RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install
ADD . /app

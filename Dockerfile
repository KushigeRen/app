FROM ruby:3.1.4

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs default-mysql-client
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash - && apt-get install -y nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn
RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install
ADD . /app
RUN bundle exec rails assets:precompile
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh
CMD ["/app/start.sh"]

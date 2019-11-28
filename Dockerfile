FROM ruby:2.5.1
WORKDIR /mymedia
COPY src ./src
COPY config.ru .
COPY Gemfile .
COPY Gemfile.lock .

EXPOSE 5000

RUN bundle install
CMD ["bundle","exec","rackup", "config.ru", "-p", "5000" ,"--host", "0.0.0.0"]

FROM ruby:3.1@sha256:91627f55e8969006aab67d15c92fb930500ff73948803da1330b8a853fecebb5

COPY Gemfile Gemfile

RUN gem install bundler && bundle install

COPY lib lib
COPY resources resources

CMD bundle exec ruby lib/playground.rb
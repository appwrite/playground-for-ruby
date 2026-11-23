FROM ruby:4.0@sha256:4de17567bc750e8a509fd2181e5c5eda3137bbb635b046943277c90271e4ec1c

COPY Gemfile Gemfile

RUN gem install bundler && bundle install

COPY lib lib
COPY resources resources

CMD bundle exec ruby lib/playground.rb
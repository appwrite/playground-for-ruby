FROM ruby:3.1

COPY Gemfile Gemfile

RUN gem install bundler && bundle install

COPY lib lib
COPY resources resources

CMD bundle exec ruby lib/playground.rb
FROM ruby:3.4@sha256:b3ea7616e6cb56f079befb439d304720396fba7802db25e55e6c983eed1800a1

COPY Gemfile Gemfile

RUN gem install bundler && bundle install

COPY lib lib
COPY resources resources

CMD bundle exec ruby lib/playground.rb
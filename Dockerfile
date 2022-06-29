FROM ruby:3.1-alpine
COPY Gemfile Gemfile
RUN bundle install --no-deployment
COPY . .
CMD bundle exec ruby lib/playground.rb
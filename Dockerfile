FROM ruby:3.1-alpine as build
COPY "Gemfile" "Gemfile"
RUN bundle install
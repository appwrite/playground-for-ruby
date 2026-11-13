FROM ruby:3.4@sha256:3acb7705baee45c4815270dbedf953e95c34e25d5440babadf5ae451a706d012

COPY Gemfile Gemfile

RUN gem install bundler && bundle install

COPY lib lib
COPY resources resources

CMD bundle exec ruby lib/playground.rb
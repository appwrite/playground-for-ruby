FROM ruby:3.4@sha256:4a8ce6f3fffaabf9ef030f091c8e9d0560b6381aa64949a043c83dc123a08433

COPY Gemfile Gemfile

RUN gem install bundler && bundle install

COPY lib lib
COPY resources resources

CMD bundle exec ruby lib/playground.rb
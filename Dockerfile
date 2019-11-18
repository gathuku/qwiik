FROM ruby:rc-alpine3.10
# update and upgrade packages
RUN apk update && apk upgrade

# Create non-root user
RUN addgroup -S admin -g 1000 && adduser -S -g '' -u 1000 -G admin deploy

# make a parent directory
RUN mkdir -p /qwiik

# let deploy user own the directory
RUN chown deploy /qwiik

# set the deploy user
USER deploy
# set the directory as working DIR
WORKDIR /qwiik

# install gem bundler
RUN gem install bundler

COPY --chown=deploy:admin . /qwiik

RUN bundle install

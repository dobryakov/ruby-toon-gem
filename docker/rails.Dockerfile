FROM ruby:3.2-alpine

WORKDIR /usr/src/app

RUN apk add --no-cache build-base git nodejs yarn tzdata postgresql-dev yaml-dev

# Rails app source will be mounted via docker-compose

ENV RAILS_ENV=test

CMD ["irb"]




FROM ruby:2.4-alpine

RUN apk update && apk add build-base git nodejs tzdata libxml2-dev libxslt-dev postgresql-dev

RUN bundle config build.nokogiri --use-system-libraries

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install --binstubs -j 20

COPY . .

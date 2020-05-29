FROM ruby:2.7-alpine

RUN apk update && apk add build-base git nodejs tzdata libxml2-dev libxslt-dev postgresql-dev

RUN bundle config build.nokogiri --use-system-libraries

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install --binstubs -j 20

COPY . .

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0", "-p", "3000"]

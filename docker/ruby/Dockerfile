FROM ruby:2.3.7-alpine3.7

RUN apk add --no-cache mysql-client
RUN apk add --no-cache git
RUN apk add --no-cache --virtual .build-deps make gcc g++ python
RUN apk add --no-cache mysql-dev
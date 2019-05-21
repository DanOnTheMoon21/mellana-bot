# builder
FROM ubuntu:16.04 AS builder

# install dependencies
RUN apt-get update \
  && apt-get install -y curl unzip

# download PhantomBot
ARG PHANTOMBOT_VERSION=3.0.0
RUN curl -L -O "https://github.com/PhantomBot/PhantomBot/releases/download/v${PHANTOMBOT_VERSION}/PhantomBot-${PHANTOMBOT_VERSION}.zip" \
  && unzip "PhantomBot-${PHANTOMBOT_VERSION}.zip" \
  && mv "PhantomBot-${PHANTOMBOT_VERSION}" phantombot

# production
FROM openjdk:8-jre-alpine

# update ssl/certs
RUN apk update \
  && apk add --no-cache ca-certificates \
  && apk add --no-cache openssl

# copy from builder
RUN mkdir /phantombot
WORKDIR /phantombot
COPY --from=builder /phantombot ./

# entry point
COPY ./entrypoint.sh ./

# botlogin
COPY ./botlogin.txt ./config/

# update perms
RUN chmod u+x launch-service.sh launch.sh entrypoint.sh

# expose comms and panel
EXPOSE 25000 25001 25002 25003 25004 25005

# run
ENTRYPOINT ["/phantombot/entrypoint.sh"]

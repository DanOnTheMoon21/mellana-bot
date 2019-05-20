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

# botuser
RUN addgroup botuser
RUN adduser -D botuser --ingroup botuser

# copy from builder
RUN mkdir /home/botuser/phantombot
WORKDIR /home/botuser/phantombot
COPY --from=builder /phantombot ./ 
RUN chmod u+x launch-service.sh launch.sh \
  && chown -R botuser:botuser *

# expose comms and panel
EXPOSE 25000 25001 25002 25003 25004 25005

# run
USER botuser
CMD ["sh", "launch-service.sh"] 

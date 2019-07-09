FROM openjdk:13-alpine
MAINTAINER Said Sef <said@saidsef.co.uk>

LABEL "uk.co.saidsef.aws-dynamodb"="Said Sef Associates Ltd"
LABEL version="2.0"

ARG PORT=""

ENV PORT ${PORT:-8000}
ENV HOME /tmp

WORKDIR /opt/dynamodb

RUN apk add --no-cache --update wget && \
    wget -O /tmp/dynamodb.tar.gz https://s3-us-west-2.amazonaws.com/dynamodb-local/dynamodb_local_latest.tar.gz && \
    tar xfvz /tmp/dynamodb.tar.gz && \
    apk del wget && \
    mkdir -p /data && \
    rm -fv /tmp/dynamodb.tar.gz && \
    rm -rfv /var/cache/apk/*

VOLUME ["/data"]

EXPOSE ${PORT}
CMD ["java", "-Djava.library.path=.", "-jar", "DynamoDBLocal.jar", "-dbPath", "/data", "-port", "8000"]

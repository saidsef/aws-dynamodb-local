FROM java:8-jre-alpine
MAINTAINER Said Sef <said@saidsef.co.uk>

LABEL "uk.co.saidsef.aws-dynamodb"="Said Sef Associates Ltd"
LABEL version="1.0"

RUN mkdir -p /opt/dynamodb/db

WORKDIR /opt/dynamodb

RUN apk add --update wget
RUN wget -O /tmp/dynamodb.tar.gz https://s3-us-west-2.amazonaws.com/dynamodb-local/dynamodb_local_latest.tar.gz
RUN tar xfvz /tmp/dynamodb.tar.gz && \
    rm -fv /tmp/dynamodb.tar.gz && \
    rm -rfv /var/cache/apk/*

EXPOSE 8000

ENTRYPOINT ["java", "-Djava.library.path=.", "-jar", "DynamoDBLocal.jar", "-dbPath", "/opt/dynamodb/db"]

CMD ["-port", "8000"]

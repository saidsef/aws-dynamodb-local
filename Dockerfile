FROM ubuntu:16.04
MAINTAINER Said Sef <said@saidsef.co.uk>

LABEL "uk.co.saidsef.aws-dynamodb"="Said Sef Associates Ltd"
LABEL version="1.0"

RUN mkdir -p /opt/dynamodb/db

WORKDIR /opt/dynamodb

RUN apt-get update
RUN apt-get install -y --no-install-recommends wget openjdk-8-jdk-headless

RUN wget -O /tmp/dynamodb.tar.gz https://s3-us-west-2.amazonaws.com/dynamodb-local/dynamodb_local_latest.tar.gz
RUN tar xfvz /tmp/dynamodb.tar.gz

EXPOSE 8000

ENTRYPOINT ["java", "-Djava.library.path=.", "-jar", "DynamoDBLocal.jar", "-dbPath", "/opt/dynamodb/db"]

CMD ["-port", "8000"]

FROM docker.io/amazon/dynamodb-local:3.3.0

LABEL maintainer="Said Sef <said@saidsef.co.uk> (saidsef.co.uk/)"

LABEL "uk.co.saidsef.aws-dynamodb"="Said Sef Associates Ltd"

ENV PROMETHEUS_JMX_JAR_VERSION 0.20.0

USER root

RUN dnf upgrade -y && dnf clean all

USER dynamodblocal

WORKDIR /home/dynamodblocal

COPY prometheus-jmx-config.yaml /home/dynamodblocal/

RUN curl -vSL https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/${PROMETHEUS_JMX_JAR_VERSION}/jmx_prometheus_javaagent-${PROMETHEUS_JMX_JAR_VERSION}.jar -o /home/dynamodblocal/jmx_prometheus_javaagent.jar

EXPOSE 8000 8081

ENTRYPOINT ["/usr/bin/java", "-javaagent:/home/dynamodblocal/jmx_prometheus_javaagent.jar=8081:/home/dynamodblocal/prometheus-jmx-config.yaml", "-cp", "/home/dynamodblocal/DynamoDBLocal_lib", "-jar", "/home/dynamodblocal/DynamoDBLocal.jar"]

CMD ["-sharedDb", "-dbPath", "/data"]

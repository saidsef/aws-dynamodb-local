FROM docker.io/amazon/dynamodb-local

LABEL maintainer="Said Sef <said@saidsef.co.uk> (saidsef.co.uk/)"

LABEL "uk.co.saidsef.aws-dynamodb"="Said Sef Associates Ltd"
LABEL VERSION="1.21.0"

ENV PROMETHEUS_JMX_JAR_VERSION 0.18.0

WORKDIR /home/dynamodblocal

COPY prometheus-jmx-config.yaml /home/dynamodblocal/

RUN curl -vSL https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/${PROMETHEUS_JMX_JAR_VERSION}/jmx_prometheus_javaagent-${PROMETHEUS_JMX_JAR_VERSION}.jar -o /home/dynamodblocal/jmx_prometheus_javaagent.jar

EXPOSE 8000 8081

# Set the entrypoint command
ENTRYPOINT ["/usr/bin/java", "-javaagent:/home/dynamodblocal/jmx_prometheus_javaagent.jar=8081:/home/dynamodblocal/prometheus-jmx-config.yaml", "-cp", "/home/dynamodblocal/DynamoDBLocal_lib", "-jar", "/home/dynamodblocal/DynamoDBLocal.jar"]

# Set the default arguments for the entrypoint command
CMD ["-sharedDb", "-dbPath", "/data"]

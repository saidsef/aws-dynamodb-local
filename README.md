# Docker DynamoDB Local

Build for local AWS DynamoDB

## AWS DynameDB

Amazon DynamoDB is a fast and flexible NoSQL database service for all applications that need consistent, single-digit millisecond latency at any scale. It is a fully managed cloud database and supports both document and key-value store models. Its flexible data model, reliable performance, and automatic scaling of throughput capacity, makes it a great fit for mobile, web, gaming, ad tech, IoT, and many other applications.

## Components

 - OpenJDK v8
 - [AWS DynamoDB Local](https://s3-us-west-2.amazonaws.com/dynamodb-local/dynamodb_local_latest.tar.gz)

## Kubernetes Deployment

```bash
kubectl apply -f deployment/

```

Or, to deploy via argocd:

```bash
kubectl apply -f argocd/argocd-application.yml
```

## HowTo and Documentation

```shell
docker run -d -p 8000:8000 saidsef/aws-dynamodb-local
```

```shell
aws dynamodb create-table \
  --table-name TableName  \
  --attribute-definitions \
    AttributeName=id,AttributeType=S --key-schema \
    AttributeName=id,KeyType=HASH \
  --provisioned-throughput ReadCapacityUnits=2,WriteCapacityUnits=2 \
  --endpoint-url http://localhost:8000
```

In the SDK set the client to:
```shell
    region: 'localhost',
    endpoint: 'http://localhost:8000'
```

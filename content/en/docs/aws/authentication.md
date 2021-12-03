+++
title = "Authentication and Authorization"
description = "Authentication and authorization support for Portefaix in AWS"
weight = 10
+++

This section shows the how to setup Portefaix with authentication and authorization support in Amazon Webservices (AWS)

## Configure AWS

```shell
❯ . ./portefaix.sh aws
[ Portefaix ]
Setup credentials
Done
```

## Bastion

You would use the [AWS System Manager plugin](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html) to connect to EC2 and EKS instances:

```shell
❯ aws ec2 describe-instances --output table
-------------------
|DescribeInstances|
+-----------------+

❯ aws ssm start-session --target i-019042b3847f5c81f
Starting session with SessionId: portefaix-admin-031b2ba6d981142b0
```

## Configure kubectl

```shell
❯ make kubernetes-credentials CLOUD=aws ENV=staging
```

```shell
❯ kubectl get nodes
NAME                                        STATUS   ROLES    AGE    VERSION
ip-10-0-31-216.eu-west-3.compute.internal   Ready    <none>   101m   v1.18.9-eks-d1db3c
ip-10-0-40-203.eu-west-3.compute.internal   Ready    <none>   101m   v1.18.9-eks-d1db3c
```

+++
title = "Authentication and Authorization"
description = "Authentication and authorization support for Portefaix in Alibaba Cloud"
weight = 10
+++

This section shows the how to setup Portefaix with authentication and authorization support in Alibaba Cloud

## Configure Alibaba Cloud

```shell
❯ . ./portefaix.sh alicloud
[ Portefaix ]
Setup credentials
Done
```

## Bastion

{{% alert title="Work In Progress" color="warning" %}}
{{% /alert %}}

## Configure kubectl

{{% alert title="Work In Progress" color="warning" %}}
{{% /alert %}}

```shell
❯ make kubernetes-credentials CLOUD=alicloud ENV=staging
```

```shell
❯ kubectl get nodes
NAME                                        STATUS   ROLES    AGE    VERSION
```

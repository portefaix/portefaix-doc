+++
title = "Authentication and Authorization"
description = "Authentication and authorization support for Portefaix in Scaleway"
weight = 10
+++

This section shows the how to setup Portefaix with authentication and authorization support in Scaleway

## Configure Scaleway

```shell
❯ . ./portefaix.sh scaleway
[ Portefaix ]
Setup credentials
Done
```

## Configure kubectl

```shell
❯ make kubernetes-credentials CLOUD=scaleway ENV=sandbox
```

```shell
❯ kubectl get nodes

```

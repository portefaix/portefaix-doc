+++
title = "Authentication and Authorization"
description = "Authentication and authorization support for Portefaix in Digital Ocean"
weight = 10
+++

This section shows the how to setup Portefaix with authentication and authorization support in Digital Ocean

## Configure Digital Ocean

```shell
❯ . ./portefaix.sh digitalocean
[ Portefaix ]
Setup credentials
Done
```

## Configure kubectl

```shell
❯ make kubernetes-credentials CLOUD=digitalocean ENV=dev
```

```shell
❯ kubectl get nodes

```

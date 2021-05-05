+++
title = "Authentication and Authorization"
description = "Authentication and authorization support for Portefaix in Exoscale"
weight = 10
+++

This section shows the how to setup Portefaix with authentication and authorization support in Exoscale

## Configure Exoscale

```shell
❯ . ./portefaix.sh exoscale
[ Portefaix ]
Setup credentials
Done
```

## Configure kubectl

```shell
❯ make kubernetes-credentials CLOUD=exoscale ENV=dev
```

```shell
❯ kubectl get nodes

```

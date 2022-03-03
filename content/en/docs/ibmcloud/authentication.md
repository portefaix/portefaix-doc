+++
title = "Authentication and Authorization"
description = "Authentication and authorization support for Portefaix in IBMCloud"
weight = 10
+++

This section shows the how to setup Portefaix with authentication and authorization support in IBMCloud

## Configure IBMCloud

```shell
❯ . ./portefaix.sh ibmcloud
[ Portefaix ]
✔ Configuration file
✔ Flux
✔ PagerDuty
✔ Terraform Cloud
✔ IBMCloud
```

## Configure kubectl

```shell
❯ make -f hack/build/ibmcloud.mk ibmcloud-kube-credentials CLOUD=ibmcloud ENV=staging
```

```shell
❯ kubectl get nodes
NAME            STATUS   ROLES    AGE   VERSION
10.242.0.10     Ready    <none>   13m   v1.22.7+IKS
10.242.0.7      Ready    <none>   29m   v1.22.7+IKS
10.242.128.10   Ready    <none>   12m   v1.22.7+IKS
10.242.128.7    Ready    <none>   29m   v1.22.7+IKS
10.242.64.6     Ready    <none>   29m   v1.22.7+IKS
10.242.64.8     Ready    <none>   13m   v1.22.7+IKS
```

+++
title = "Authentication and Authorization"
description = "Authentication and authorization support for Portefaix in Civo"
weight = 10
+++

This section shows the how to setup Portefaix with authentication and authorization support in Civo

## Configure Civo

```shell
❯ . ./portefaix.sh civo
[ Portefaix ]
 Flux
 Pagerduty
 TerraformCloud
 Civo
✔ Done
```

## Configure kubectl

```shell
❯ make -f hack/build/civo.mk civo-kube-credentials ENV=dev
```

```shell
❯ kubectl get nodes
NAME                                                      STATUS   ROLES    AGE     VERSION
k3s-portefaix-dev-civo-691a-de1391-node-pool-8c2e-859cq   Ready    <none>   6m29s   v1.22.2+k3s1
```

+++
title = "Authentication and Authorization"
description = "Authentication and authorization support for Portefaix in Homelab"
weight = 90
+++

## Configure kubectl

```shell
❯ make kubernetes-credentials CLOUD=k3s ENV=homelab
```

```shell
❯ kubectl get nodes
NAME          STATUS     ROLES    AGE     VERSION
portefaix-1   Ready      master   3h2m    v1.18.17+k3s1
portefaix-4   Ready      <none>   5m36s   v1.18.17+k3s1
portefaix-3   Ready      <none>   5m36s   v1.18.17+k3s1
portefaix-2   Ready      <none>   5m35s   v1.18.17+k3s1
```

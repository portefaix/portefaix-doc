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
NAME       STATUS   ROLES    AGE     VERSION
jarvis-1   Ready    master   7m59s   v1.18.17+k3s1
jarvis-2   Ready    <none>   6m40s   v1.18.17+k3s1
jarvis-3   Ready    <none>   6m27s   v1.18.17+k3s1
```

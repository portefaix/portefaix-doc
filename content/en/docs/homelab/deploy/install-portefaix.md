+++
title = "Install Portefaix"
description = "Instructions for deploying Portefaix infrastructure on Raspberry PI"
weight = 10
+++

<a id="os"/></a>

## Operating System

Setup operating system for Raspberry PI :

```shell
❯ ./hack/scripts/bootstrap.sh <hostname> /dev/mmcblk0
```

Enable SSH :

```shell
❯ sudo mount /dev/mmcblk0p1 /mnt/sdcard
❯ sudo touch /mnt/sdcard/ssh
❯ sudo umount /mnt/sdcard/
```

Copy keys to each node:

```shell
ssh-copy-id -i ~/.ssh/id_rsa.pub pi@x.x.x.x
```

## Ansible

```shell
❯ make -f hack/k3s.mk ansible-run SERVICE=iac/k3s/ ENV=homelab
```

Check Kubernetes cluster:

```shell
pi@jarvis-1:~ $ sudo k3s kubectl get nodes
NAME       STATUS   ROLES    AGE     VERSION
jarvis-1   Ready    master   7m59s   v1.18.17+k3s1
jarvis-2   Ready    <none>   6m40s   v1.18.17+k3s1
jarvis-3   Ready    <none>   6m27s   v1.18.17+k3s1
```

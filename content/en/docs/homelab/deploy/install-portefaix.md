+++
title = "Install Portefaix"
description = "Instructions for deploying Portefaix infrastructure on Raspberry PI"
weight = 10
+++

<a id="os"/></a>

## Operating System

Setup operating system for Raspberry PI :

```shell
❯ sudo dd if=/dev/zero of=/dev/mmcblk0
❯ sudo./hack/scripts/sdcard.sh <hostname> /dev/mmcblk0
```

Enable SSH :

```shell
❯ make -f hack/k3s.mk sdcard-mount ENV=homelab
❯ sudo touch /mnt/portefaix/root/ssh
❯ make -f hack/k3s.mk sdcard-unmount ENV=homelab
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
pi@portefaix-1:~ $ sudo k3s kubectl get nodes
NAME          STATUS     ROLES    AGE     VERSION
portefaix-1   Ready      master   3h2m    v1.18.17+k3s1
portefaix-4   Ready      <none>   5m36s   v1.18.17+k3s1
portefaix-3   Ready      <none>   5m36s   v1.18.17+k3s1
portefaix-2   Ready      <none>   5m35s   v1.18.17+k3s1
```

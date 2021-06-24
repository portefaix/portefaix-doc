+++
title = "Install Portefaix"
description = "Instructions for deploying Portefaix infrastructure on Raspberry PI"
weight = 10
+++

<img src="/docs/images/portefaix_homelab_infra.png"
 alt="Portefaix infrastructure"
 class="mt-3 mb-3 border border-info rounded">

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
❯ make -f hack/k3s.mk ansible-run SERVICE=iac/k3s/machines ENV=homelab
```

## K3Sup

Create the master :

```shell
❯ make -f hack/k3s.mk  k3s-create SERVER_IP=x.x.x.x USER=pi ENV=homelab
```

For each node, add it to the cluster:

```shell
❯ make -f hack/k3s.mk k3s-join SERVER_IP=x.x.x.x USER=pi AGENT_IP=x.x.x.x ENV=homelab
```

Check Kubernetes cluster:

```shell
❯ make -f hack/k3s.mk k3s-kube-credentials ENV=homelab
❯ kubectl get node -o wide
NAME          STATUS   ROLES    AGE     VERSION        INTERNAL-IP     EXTERNAL-IP   OS-IMAGE                       KERNEL-VERSION   CONTAINER-RUNTIME
portefaix-3   Ready    <none>   3m44s   v1.19.1+k3s1   192.168.1.30    <none>        Debian GNU/Linux 10 (buster)   5.10.17-v8+      containerd://1.4.0-k3s1
portefaix-1   Ready    master   8m35s   v1.19.1+k3s1   192.168.1.114   <none>        Debian GNU/Linux 10 (buster)   5.10.17-v8+      containerd://1.4.0-k3s1
portefaix-2   Ready    <none>   6m18s   v1.19.1+k3s1   192.168.1.123   <none>        Debian GNU/Linux 10 (buster)   5.10.17-v8+      containerd://1.4.0-k3s1
portefaix-4   Ready    <none>   47s     v1.19.1+k3s1   192.168.1.32    <none>        Debian GNU/Linux 10 (buster)   5.10.17-v8+      containerd://1.4.0-k3s1
```

Creates the `sops-gpg` secret:

```shell
❯ make -f hack/k3s.mk pgp-secret CLOUD=k3s ENV=homelab
```

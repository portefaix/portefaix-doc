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

Setup operating system for Raspberry PI.

See: https://www.raspberrypi.org/software/

Or:

```shell
❯ sudo dd if=/dev/zero of=/dev/mmcblk0 conv=noerror status=progress
❯ sudo./hack/scripts/sdcard.sh <hostname> /dev/mmcblk0
```

Enable SSH :

```shell
❯ make -f hack/build/k3s.mk sdcard-mount ENV=homelab
❯ sudo touch /mnt/portefaix/boot/ssh
❯ echo portefaix-xxx | sudo tee /mnt/portefaix/root/etc/hostname
❯ make -f hack/build/k3s.mk sdcard-unmount ENV=homelab
```

Copy keys to each node:

```shell
ssh-copy-id -i ~/.ssh/id_rsa.pub pi@x.x.x.x
```

## Ansible

```shell
❯ make -f hack/build/k3s.mk ansible-deps SERVICE=ansible/k3s/machines ENV=homelab
❯ make -f hack/build/k3s.mk ansible-run SERVICE=ansible/k3s/machines ENV=homelab
```

## K3Sup

Create the master :

```shell
❯ make -f hack/build/k3s.mk  k3s-create ENV=homelab SERVER_IP=x.x.x.x 
```

For each node, add it to the cluster:

```shell
❯ make -f hack/build/k3s.mk k3s-join ENV=homelab SERVER_IP=x.x.x.x AGENT_IP=x.x.x.x 
```

Check Kubernetes cluster:

```shell
❯ make -f hack/build/k3s.mk k3s-kube-credentials ENV=homelab
❯ kubectl get node -o wide
NAME          STATUS   ROLES                  AGE    VERSION        INTERNAL-IP     EXTERNAL-IP   OS-IMAGE                       KERNEL-VERSION   CONTAINER-RUNTIME
portefaix-4   Ready    <none>                 32d    v1.21.4+k3s1   192.168.1.32    <none>        Debian GNU/Linux 10 (buster)   5.10.17-v8+      containerd://1.4.9-k3s1
portefaix-1   Ready    control-plane,master   32d    v1.21.4+k3s1   192.168.1.4     <none>        Debian GNU/Linux 10 (buster)   5.10.17-v8+      containerd://1.4.9-k3s1
portefaix-3   Ready    <none>                 32d    v1.21.4+k3s1   192.168.1.30    <none>        Debian GNU/Linux 10 (buster)   5.10.17-v8+      containerd://1.4.9-k3s1
portefaix-5   Ready    <none>                 129m   v1.21.4+k3s1   192.168.1.126   <none>        Debian GNU/Linux 10 (buster)   5.10.63-v8+      containerd://1.4.9-k3s1
portefaix-2   Ready    <none>                 32d    v1.21.4+k3s1   192.168.1.123   <none>        Debian GNU/Linux 10 (buster)   5.10.17-v8+      containerd://1.4.9-k3s1
```

## Applications

Next: [Gitops](/docs/gitops)
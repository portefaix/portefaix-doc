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

For each node, add it to the cluster, then add a label:

```shell
❯ make -f hack/build/k3s.mk k3s-join ENV=homelab SERVER_IP=x.x.x.x AGENT_IP=x.x.x.x

❯ kubectl label node <NODE_NAME> node-role.kubernetes.io/worker=
node/<NODE_NAME> labeled
```

Check Kubernetes cluster:

```shell
❯ make -f hack/build/k3s.mk k3s-kube-credentials ENV=homelab

❯ kubectl get node -o wide
NAME          STATUS   ROLES                  AGE     VERSION        INTERNAL-IP     EXTERNAL-IP   OS-IMAGE                         KERNEL-VERSION   CONTAINER-RUNTIME
portefaix-1   Ready    control-plane,master   22m     v1.24.6+k3s1   192.168.0.208   <none>        Debian GNU/Linux 11 (bullseye)   5.15.61-v8+      containerd://1.6.8-k3s1
portefaix-2   Ready    worker                 12m     v1.24.6+k3s1   192.168.0.116   <none>        Debian GNU/Linux 11 (bullseye)   5.15.61-v8+      containerd://1.6.8-k3s1
portefaix-3   Ready    worker                 7m35s   v1.24.6+k3s1   192.168.0.252   <none>        Debian GNU/Linux 11 (bullseye)   5.15.61-v8+      containerd://1.6.8-k3s1
portefaix-4   Ready    worker                 3m11s   v1.24.6+k3s1   192.168.0.234   <none>        Debian GNU/Linux 11 (bullseye)   5.15.61-v8+      containerd://1.6.8-k3s1
```

## Cloudflare

[R2](https://www.cloudflare.com/products/r2/) is used to store the Terraform states and for S3 buckets

Setup your Cloudflare Account ID, and your AWS credentials

```shell
function setup_cloudflare() {
    echo_info "Cloudflare"
    export CLOUDFLARE_ACCOUNT_ID="xxxxxxxx"
    export AWS_ACCESS_KEY_ID="xxxxxxxxxxx"
    export AWS_SECRET_ACCESS_KEY="xxxxxxxxxxxx"
}

function setup_cloud_provider {
    case $1 in
    
        ...

        "k3s")
            setup_tailscale
            setup_freebox
            setup_cloudflare
            ;;
        *)
            echo -e "${KO_COLOR}Invalid cloud provider: $1.${NO_COLOR}"
            usage
            ;;
    esac
}
```

The creates the bucket for Terraform:

```shell
❯ make -f hack/build/k3s.mk cloudflare-bucket-create ENV=homelab
[portefaix] Create bucket for Terraform states
{
    "Location": "/portefaix-homelab-tfstates"
}
```

## Terraform

Configure DNS:

```shell
❯ make terraform-apply SERVICE=terraform/k3s/dns ENV=homelab
```

Creates the R2 buckets for Observability components:

```shell
❯ make terraform-apply SERVICE=terraform/k3s/observability ENV=homelab
```

## Applications

Next: [Gitops](/docs/gitops)
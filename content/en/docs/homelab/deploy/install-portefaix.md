+++
title = "Install Portefaix"
description = "Instructions for deploying Portefaix infrastructure on Homelab"
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
❯ make ansible-deps SERVICE=ansible/k3s/machines CLOUD=k3s ENV=homelab
❯ make ansible-run SERVICE=ansible/k3s/machines CLOUD=k3s ENV=homelab
```

## K3Sup

Create the master :

```shell
❯ make -f hack/build/k3s.mk  k3s-create ENV=homelab SERVER_IP=x.x.x.x EXTERNAL_IP=x.x.x.x
```

For each node, add it to the cluster, then add a label:

```shell
❯ make -f hack/build/k3s.mk k3s-join ENV=homelab SERVER_IP=x.x.x.x AGENT_IP=x.x.x.x EXTERNAL_IP=x.x.x.x

❯ kubectl label node <NODE_NAME> node-role.kubernetes.io/worker=
node/<NODE_NAME> labeled
```

Check Kubernetes cluster:

```shell
❯ make -f hack/build/k3s.mk k3s-kube-credentials ENV=homelab
```

[Cilium](https://cilium.io/) must be installed:

```shell
❯ make argocd-bootstrap ENV=<environment> CLOUD=<cloud provider> CHOICE=cilium
```

Then check nodes:

```shell
❯ kubectl get node -o wide
NAME          STATUS   ROLES                  AGE   VERSION        INTERNAL-IP     EXTERNAL-IP      OS-IMAGE             KERNEL-VERSION      CONTAINER-RUNTIME
portefaix-4   Ready    <none>                 24m   v1.26.1+k3s1   192.168.0.234   100.87.6.37      Ubuntu 22.04.2 LTS   5.15.0-1024-raspi   containerd://1.6.15-k3s1
portefaix-3   Ready    <none>                 29m   v1.26.1+k3s1   192.168.0.252   100.86.135.11    Ubuntu 22.04.2 LTS   5.15.0-1024-raspi   containerd://1.6.15-k3s1
portefaix     Ready    control-plane,master   87m   v1.26.1+k3s1   192.168.0.62    100.126.241.86   Ubuntu 22.04.2 LTS   5.15.0-60-generic   containerd://1.6.15-k3s1
portefaix-1   Ready    <none>                 45m   v1.26.1+k3s1   192.168.0.208   100.115.34.57    Ubuntu 22.04.2 LTS   5.15.0-1024-raspi   containerd://1.6.15-k3s1
```

and Cilium status:

```shell
❯ cilium status
    /¯¯\
 /¯¯\__/¯¯\    Cilium:         OK
 \__/¯¯\__/    Operator:       OK
 /¯¯\__/¯¯\    Hubble:         OK
 \__/¯¯\__/    ClusterMesh:    disabled
    \__/

Deployment        cilium-operator    Desired: 1, Ready: 1/1, Available: 1/1
DaemonSet         cilium             Desired: 4, Ready: 4/4, Available: 4/4
Deployment        hubble-relay       Desired: 1, Ready: 1/1, Available: 1/1
Deployment        hubble-ui          Desired: 1, Ready: 1/1, Available: 1/1
Containers:       cilium             Running: 4
                  cilium-operator    Running: 1
                  hubble-relay       Running: 1
                  hubble-ui          Running: 1
Cluster Pods:     4/4 managed by Cilium
Image versions    cilium             quay.io/cilium/cilium:v1.13.0@sha256:6544a3441b086a2e09005d3e21d1a4afb216fae19c5a60b35793c8a9438f8f68: 4
                  cilium-operator    quay.io/cilium/operator-generic:v1.13.0@sha256:4b58d5b33e53378355f6e8ceb525ccf938b7b6f5384b35373f1f46787467ebf5: 1
                  hubble-relay       quay.io/cilium/hubble-relay:v1.13.0@sha256:bc00f086285d2d287dd662a319d3dbe90e57179515ce8649425916aecaa9ac3c: 1
                  hubble-ui          quay.io/cilium/hubble-ui:v0.10.0@sha256:118ad2fcfd07fabcae4dde35ec88d33564c9ca7abe520aa45b1eb13ba36c6e0a: 1
                  hubble-ui          quay.io/cilium/hubble-ui-backend:v0.10.0@sha256:cc5e2730b3be6f117b22176e25875f2308834ced7c3aa34fb598aa87a2c0a6a4: 1
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
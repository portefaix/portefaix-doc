+++
title = "Install Portefaix"
description = "Instructions for deploying Portefaix on Alibaba Cloud"
weight = 10
+++

<a id="alicloud"></a>

## Setup

Create an admin user, then API Keys.
And configure Portefaix environment file `${HOME}/.config/portefaix/portefaix.sh`:

```shell
# Alicloud
function setup_alicloud() {
    # Alicloud User: Portefaix Admin
    export ALICLOUD_ACCESS_KEY="xxxxxxxxxx"
    export ALICLOUD_SECRET_KEY="xxxxxxxxxxxxxxxx"
    export ALICLOUD_REGION="eu-central-1"
    # For Terraform Cloud
    export TF_VAR_access_key="${ALICLOUD_ACCESS_KEY}"
    export TF_VAR_secret_key="${ALICLOUD_SECRET_KEY}"
    export TF_VAR_region="${ALICLOUD_REGION}"
}
```

And load environment :

```shell
❯ . ./portefaix.sh alicloud
```

## Storage for Terraform

Create an OSS bucket for Terraform states:

```shell
❯ make -f hack/build/alicloud.mk aliyun-bucket-create ENV=staging
```

Create a TableStore instance:

```shell
❯ make -f hack/build/alicloud.mk aliyun-tablestore-create ENV=staging
```

<a id="alicloud-terraform-cloud"></a>

## Terraform Cloud / Github Actions

[Terraform Cloud](https://terraform.cloud) is used as the remote backend. [Github Actions](https://github.com/features/actions) perform tasks to deploy the Alibaba Cloud infrastructure.

<img src="/docs/images/portefaix-alicloud-deploy.png" alt="Portefaix Alibaba Cloud deployment" class="mt-3 mb-3 rounded">

<a id="alicloud-gitops"></a>

## Gitops for Kubernetes

See : [Gitops with FluxCD](/docs/development/gitops-fluxcd) or [Gitops with ArgoCD](/docs/development/gitops-argocd/)
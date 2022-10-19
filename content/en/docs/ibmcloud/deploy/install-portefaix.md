+++
title = "Install Portefaix"
description = "Instructions for deploying Portefaix on IBMCloud"
weight = 10
+++

<a id="exo"></a>

## Setup

```shell
# IBMCloud
export IAAS_CLASSIC_USERNAME="xxxxxxxxxxxx"
export IC_API_KEY="xxxxxxxxxxxxxx"
export IAAS_CLASSIC_API_KEY="xxxxxxxxxxxxxxxxx"
# For Terraform Backend S3
# See 

```

And load environment :

```shell
❯ . ./portefaix.sh ibmcloud
```

Authentication:

```shell
❯ make -f hack/build/ibmcloud.mk ibmcloud-init ENV=staging
```

Then, generate the right set of HMAC credentials : [documentation](https://www.ibm.com/cloud/blog/store-terraform-states-cloud-object-storage)

```shell
❯ export AWS_ACCESS_KEY_ID="xxxxxxxxxx"
❯ export AWS_SECRET_ACCESS_KEY="xxxxxxxxxxxxxxx"
```

## Storage for Terraform

Create a S3 bucket for Terraform states:

```shell
❯ make -f hack/build/ibmcloud.mk ibmcloud-bucket-create ENV=staging
```

## Terraform

### VPC

```shell
❯ make terraform-apply SERVICE=terraform/ibmcloud/vpc ENV=staging
```

### IKS

```shell
❯ make terraform-apply SERVICE=terraform/ibmcloud/iks ENV=staging
```

## Gitops for Kubernetes

Next: [Gitops](/docs/gitops)
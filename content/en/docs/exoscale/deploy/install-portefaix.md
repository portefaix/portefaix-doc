+++
title = "Install Portefaix"
description = "Instructions for deploying Portefaix on Exoscale"
weight = 10
+++

<a id="exo"></a>

## Setup

```shell
# AWS
export EXOSCALE_API_KEY="xxxxx"
export EXOSCALE_API_SECRET="xxxxxxxxxxx"
export AWS_ACCESS_KEY_ID="${EXOSCALE_API_KEY}"
export AWS_SECRET_ACCESS_KEY="${EXOSCALE_API_SECRET}"
```

And load environment :

```shell
❯ . ./portefaix.sh exoscale
```

## Storage for Terraform

Create a S3 bucket for Terraform states:

```shell
❯ make -f hack/build/exoscale.mk exo-bucket ENV=dev
```

## Terraform

### SKS

```shell
❯ make terraform-apply SERVICE=iac/exoscale/sks ENV=dev
```

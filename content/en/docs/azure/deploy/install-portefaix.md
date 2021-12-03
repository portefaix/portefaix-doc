+++
title = "Install Portefaix"
description = "Instructions for deploying Portefaix on Azure"
weight = 10
+++

<a id="azure"></a>

## Setup

Export Azure credentials:

```shell
❯ export AZURE_SUBSCRIPTION_ID="xxxxxx"
```

## Storage for Terraform

Create a [Storage Account](https://portal.azure.com/#create/Microsoft.StorageAccount) :

```shell
❯ make -f hack/build/azure.mk azure-storage-account ENV=dev
XXXXXXXXXXX
```

You could see the Key on the output.

Create storage container for Terraform states:

```shell
❯ make -f hack/build/azure.mk azure-storage-container ENV=dev KEY="xxxxxxxxxxxxxxxxx"
```

Create the Service Principal for Terraform:

```shell
❯ make -f hack/build/azure.mk azure-sp ENV=dev
{
  "appId": "xxxxxxxxxxxxxxxxx",
  "displayName": "portefaix-dev",
  "name": "http://portefaix-dev",
  "password": "xxxxxxxxxxxx",
  "tenant": "xxxxxxxxxxxx"
}
```

Extract informations and configure portefaix configuration file (`hack/config/portefaix.sh`):

* `SUBSCRIPTION_ID`
* `CLIENT_ID`
* `CLIENT_SECRET`
* `ARM_TENANT_ID`

And load environment :

```shell
❯ . ./portefaix.sh azure
```

Set permissions:

```shell
❯ make -f hack/build/azure.mk azure-permissions ENV=dev
```

## Terraform

[Github Actions](https://github.com/features/actions) with [Terraform Cloud](https://www.terraform.io/cloud) could used to deploy the infrastructure:

<img src="/docs/images/portefaix-azure-deploy.png" alt="Portefaix Azure deployment" class="mt-3 mb-3 rounded">
+++
title = "Install Portefaix"
description = "Instructions for deploying Portefaix infrastructure on GCP"
weight = 10
+++

<a id="gcloud"/></a>

## Organization

Create a Google Cloud Organization using **Google Workspace** or **Cloud Identity**

See: https://cloud.google.com/resource-manager/docs/creating-managing-organization?hl=fr

## Bootstrap

Authenticate on the Google Cloud Platform:

```shell
❯ gcloud auth login
xxxxxxxxxx

❯ gcloud organizations list
DISPLAY_NAME             ID  DIRECTORY_CUSTOMER_ID
xxxxxxx              xxxxxx               xxxxxxxx
```

You could find the `GCP_USER`:

```shell
❯ gcloud auth list
            Credentialed Accounts
ACTIVE  ACCOUNT
*       xxxxxxxxxxxx@portefaix.xyz
```

Bootstrap the organization:

```shell
❯ make -f hack/build/gcp.mk gcp-organization-bootstrap GCP_ORG_ID=xxxxxxxxxxx GCP_USER=xxxxxxxxxxxxxxxxx
```

Then go to https://console.cloud.google.com/cloud-setup/organization to creates groups and create the billing account.

Then create the bootstrap project:

```shell
❯ make -f hack/build/gcp.mk gcp-organization-project GCP_ORG_NAME=xxxx GCP_ORG_ID=xxxxxxxxxxx
```

Associate this project to the Billing Account (on GCP console or using gcloud):

```shell
gcloud alpha billing accounts projects link my-project --billing-account=xxxxxxx
```

Then create the bucket for boostraping the organization:

```shell
❯ make -f hack/build/gcp.mk gcp-bucket GCP_ORG_NAME=xxxxxxx
```

Bootstrap:

```shell
❯ make terraform-apply SERVICE=terraform/gcp/root ENV=main
```

<a id="gcp-terraform-cloud"></a>

## Terraform Cloud / Github Actions

[Terraform Cloud](https://terraform.cloud) is used as the remote backend. [Github Actions](https://github.com/features/actions) perform tasks to deploy the GCP infrastructure.

Configure Terraform Cloud workspaces:

```shell
❯ make terraform-apply SERVICE=terraform/gcp/terraform-cloud ENV=dev
```

<img src="/docs/images/portefaix-gcp-deploy.png" alt="Portefaix GCP deployment" class="mt-3 mb-3 rounded">

<a id="gcp-gitops"></a>

## Gitops for Kubernetes

Next: [Gitops](/docs/gitops)

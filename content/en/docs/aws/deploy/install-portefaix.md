+++
title = "Install Portefaix"
description = "Instructions for deploying Portefaix on AWS"
weight = 10
+++

<a id="aws"></a>

## Setup

Create an [admin user](https://docs.aws.amazon.com/IAM/latest/UserGuide/getting-started_create-admin-group.html).
Then [API Keys](https://console.aws.amazon.com/iam/home?#/security_credentials),
and configure Portefaix environment file `${HOME}/.config/portefaix/portefaix.sh`:

```shell
# AWS
export AWS_ACCESS_KEY_ID="....."
export AWS_SECRET_ACCESS_KEY="....."
export AWS_DEFAULT_REGION="..."
export AWS_REGION="...."
```

And load environment :

```shell
❯ . ./portefaix.sh aws
```

## Storage for Terraform

Create a S3 bucket for Terraform states:

```shell
❯ make -f hack/build/aws.mk aws-s3-bucket ENV=staging
```

Create a DynamoDB table :

```shell
❯ make -f hack/build/aws.mk aws-dynamodb-create-table ENV=staging
```

## Terraform Cloud / Github Actions

[Terraform Cloud](https://terraform.cloud) is used as the remote backend. [Github Actions](https://github.com/features/actions) perform tasks to deploy the AWS infrastructure.

<img src="/docs/images/portefaix-aws-deploy.png" alt="Portefaix AWS deployment" class="mt-3 mb-3 rounded">

## Gitops for Kubernetes

See : [Gitops with FluxCD](/docs/development/gitops-fluxcd) or [Gitops with ArgoCD](/docs/development/gitops-argocd/)
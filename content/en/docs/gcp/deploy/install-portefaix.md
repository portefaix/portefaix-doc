+++
title = "Install Portefaix"
description = "Instructions for deploying Portefaix infrastructure on GCP"
weight = 10
+++

<a id="gcloud"/></a>

## Setup

Authenticate on the Google Cloud Platform:

```shell
❯ gcloud auth application-default login
```

Enable APIs:

```shell
❯ make -f hack/build/gcp.mk gcp-enable-apis ENV=dev
```

Create a bucket for the Terraform tfstates:

```shell
❯ make -f hack/build/gcp.mk gcp-bucket ENV=dev
```

Create a service account for Terraform:

```shell
❯ make -f hack/build/gcp.mk gcp-terraform-sa ENV=dev
```

And a key:

```shell
❯ make -f hack/build/gcp.mk gcp-terraform-key ENV=dev
```

Configure Portefaix environment file `${HOME}/.config/portefaix/portefaix.sh`:

And load environment :

```shell
❯ . ./portefaix.sh gcp
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

See : [Gitops with FluxCD](/docs/development/gitops-fluxcd) or [Gitops with ArgoCD](/docs/development/gitops-argocd/)
+++
title = "Install Portefaix"
description = "Instructions for deploying Portefaix on DigitalOcean"
weight = 10
+++

<a id="do"></a>

## Setup

```shell
# Digital Ocean
function setup_digitalocean() {
    export DIGITALOCEAN_TOKEN="xxxxxxxxxxxx"
    export SPACES_ENDPOINT_URL="fra1.digitaloceanspaces.com"
    export SPACES_ACCESS_KEY_ID="xxxxxxxxxx"
    export SPACES_SECRET_ACCESS_KEY="xxxxxxxxxxxxxxx"
    export AWS_ACCESS_KEY_ID="${SPACES_ACCESS_KEY_ID}"
    export AWS_SECRET_ACCESS_KEY="${SPACES_SECRET_ACCESS_KEY}"
    export AWS_DEFAULT_REGION="eu-west-3"
    export AWS_REGION="eu-west-3"
}
```

And load environment :

```shell
❯ . ./portefaix.sh digitalocean
```

## Storage for Terraform

Create a S3 bucket for Terraform states:

```shell
❯ make -f hack/build/digitalocean.mk exo-bucket ENV=dev
```

## Gitops for Kubernetes

Next: [Gitops](/docs/gitops)
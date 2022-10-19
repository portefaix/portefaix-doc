+++
title = "Install Portefaix"
description = "Instructions for deploying Portefaix on Civo"
weight = 10
+++

<a id="civo"></a>

## Setup

```shell
# Civo
export CIVO_TOKEN="xxxxxxxxxxxxxxxx"
```

And load environment :

```shell
❯ . ./portefaix.sh civo
```

## Storage for Terraform

{{% alert title="Work In Progress" color="warning" %}}
{{% /alert %}}

## Terraform

### Network

```shell
❯ make terraform-apply SERVICE=terraform/civo/network ENV=dev
```

### Kubernetes

```shell
❯ make terraform-apply SERVICE=terraform/civo/kubernetes ENV=dev
```

## Gitops for Kubernetes

Next: [Gitops](/docs/gitops)
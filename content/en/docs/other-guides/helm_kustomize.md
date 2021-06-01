+++
title = "Helm and Kustomize"
description = "Helm and Kustomize usage"
weight = 10

+++

## HelmRelease

*HelmRelease* control the Helm chart into Flux.

You can extract from a HelmRelease file the Helm repository and add it:

```shell
❯ DEBUG=true make helm-flux-repo CHART=kubernetes/base/logging/vector/vector.yaml
```

Then display available values from the Helm chart:

```shell
❯ DEBUG=true make helm-flux-values CHART=kubernetes/base/logging/vector/vector.yaml
```

## Environments

You could rendering Kubernetes manifests files like Flux:

```shell
❯ DEBUG=true make helm-flux-template CHART=kubernetes/base/logging/vector/vector.yaml ENV=prod
```

Or install the chart for an environment

```shell
❯ DEBUG=true make helm-flux-install CHART=kubernetes/base/logging/vector/vector.yaml ENV=prod
```

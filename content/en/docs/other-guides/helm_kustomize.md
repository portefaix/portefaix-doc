+++
title = "Helm and Kustomize"
description = "Helm and Kustomize usage"
weight = 10

+++

## HelmRelease

*HelmRelease* control the Helm chart into Flux.

Display informations about the Helm chart from a HelmRelease:

```shell
❯ make helm-flux-chart CHART=kubernetes/base/monitoring/kube-prometheus-stack/kube-prometheus-stack.yaml
[portefaix] Helm repository and chart kubernetes/base/monitoring/kube-prometheus-stack/kube-prometheus-stack.yaml
https://prometheus-community.github.io/helm-charts
prometheus-community-charts
kube-prometheus-stack
16.13.0
monitoring
```

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

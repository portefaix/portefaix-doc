+++
title = "ArgoCD"
description = "Gitops model for Kubernetes using ArgoCD"
weight = 20

+++
<img src="/docs/images/argocd_architecture.png"
 alt="ArgoCD"
 class="mt-3 mb-3 border border-info rounded">

## Organization

Bootstrap:

* `gitops/argocd/charts` : directory which contains deployed applications using Helm charts
* `gitops/argocd/apps/<CLOUD>/<ENVIRONMENT>` : directory which contains applications deployed into a Kubernetes cluster

To configure the Helm chart, we use YAML files :

* `values.yaml`: common configuration to all Kubernetes cluster
* `values-<CLOUD>-<ENVIRONMENT>.yaml` : configuration of the Helm chart for a Kubernetes cluster


## Sync

```shell
❯ make argocd-bootstrap ENV=<environment> CLOUD=<cloud provider> CHOICE=helm
```

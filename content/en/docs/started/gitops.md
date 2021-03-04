+++
title = "Gitops"
description = "Deploy Kubernetes applications with Gitops model"
weight = 30

+++

[Gitops](https://www.weave.works/technologies/gitops/) model used is [Flux v2](https://toolkit.fluxcd.io/)

<img src="/docs/images/gitops-toolkit.png"
 alt="Flux v2"
 class="mt-3 mb-3 border border-info rounded">

## Organization

Manifests files :

* `kubernetes/base` directory contains manifests for all components
* `kubernetes/overlays/**` directory contains [Kustomize](https://kustomize.io/) overlays

Flux components are deployed for each clusster on `clusters/<CLOUD>/<ENV>/` :

* `clusters/<CLOUD>/<ENV>/flux-system` : Flux core components
* `clusters/<CLOUD>/<ENV>/*.yaml` : [Flux Kustomization](https://toolkit.fluxcd.io/components/kustomize/kustomization/) files for components

## Sync

```shell
❯ make gitops-bootstrap ENV=<ENV> CLOUD=<CLOUD PROVIDER>
```

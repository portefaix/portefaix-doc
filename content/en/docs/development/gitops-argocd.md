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

## Secrets

### Bootstrap

[sealed-secrets](https://github.com/bitnami-labs/sealed-secrets) is used to store secrets into Kubernetes.

Fetch the certificate that you will use to encrypt your secrets, and store it into `.secrets/<CLOUD>/<ENV>/sealed-secrets/cert.pem` :

```shell
❯ kubeseal --fetch-cert --controller-name=sealed-secrets -n kube-system > .secrets/aws/staging/sealed-secrets/cert.pm
```

### Usage

Create a SealedSecrets from a file : 

```shell
❯ make kubeseal-encrypt CLOUD=aws ENV=staging \
    FILE=.secrets/aws/staging/kube-prometheus-stack/object-store.yaml \
    NAME=thanos-objstore-config NAMESPACE=monitoring \
    > ./gitops/argocd/apps/aws/staging/apps/thanos-objstore-config.yaml
```

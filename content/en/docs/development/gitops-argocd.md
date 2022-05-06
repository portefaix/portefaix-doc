+++
title = "ArgoCD"
description = "Gitops model for Kubernetes using ArgoCD"
weight = 20

+++
<img src="/docs/images/argocd_architecture.png"
 alt="Argo-CD"
 class="mt-3 mb-3 border border-info rounded">

## Organization

* `gitops/argocd/bootstrap` : Argo-CD deployment
* `gitops/argocd/stacks` : Portefaix stacks : Argo-CD projects and applications
* `gitops/argocd/apps/<CLOUD>/<ENVIRONMENT>` : Argo-CD applications deployed into the Kubernetes cluster
* `gitops/argocd/charts` : Helm charts configurations

To configure the Helm charts, we use YAML files :

* `values.yaml`: common configuration to all Kubernetes cluster
* `values-<CLOUD>-<ENVIRONMENT>.yaml` : configuration of the Helm chart for a Kubernetes cluster

## Bootstrap

### Argo-CD

```shell
❯ make argocd-bootstrap ENV=<environment> CLOUD=<cloud provider> CHOICE=helm
```

### Stacks

Install a stack into the cluster:

```shell
❯ make argocd-stack-install ENV=<environment> CLOUD=<cloud provider> STACK=<stack name>
```

Go to Argo-CD dashboard, you will see Argo-CD corresponding applications.

## Secrets

[sealed-secrets](https://github.com/bitnami-labs/sealed-secrets) is used to store secrets into Kubernetes.

Fetch the certificate that you will use to encrypt your secrets, and store it into `.secrets/<CLOUD>/<ENV>/sealed-secrets/cert.pem` :

```shell
❯ kubeseal --fetch-cert --controller-name=sealed-secrets -n kube-system > .secrets/aws/staging/sealed-secrets/cert.pm
```

Create a SealedSecrets from a file : 

```shell
❯ make kubeseal-encrypt CLOUD=aws ENV=staging \
    FILE=.secrets/aws/staging/kube-prometheus-stack/object-store.yaml \
    NAME=thanos-objstore-config NAMESPACE=monitoring \
    > ./gitops/argocd/apps/aws/staging/apps/thanos-objstore-config.yaml
```

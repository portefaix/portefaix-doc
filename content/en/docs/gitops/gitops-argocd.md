+++
title = "ArgoCD"
description = "Gitops model for Kubernetes using ArgoCD"
weight = 20

+++
<img src="/docs/images/argocd_architecture.png" alt="Argo-CD" class="mt-3 mb-3 border border-info rounded">

## Organization

* `gitops/argocd/bootstrap` : Argo-CD deployment
* `gitops/argocd/stacks` : Portefaix stacks : Argo-CD projects and applications
* `gitops/argocd/apps/<CLOUD>/<ENVIRONMENT>` : Argo-CD applications deployed into the Kubernetes cluster
* `gitops/argocd/charts` : Helm charts configurations

To configure the Helm charts, we use YAML files :

* `values.yaml`: common configuration to all Kubernetes cluster
* `values-<CLOUD>-<ENVIRONMENT>.yaml` : configuration of the Helm chart for a Kubernetes cluster

## Secrets

[sealed-secrets](https://github.com/bitnami-labs/sealed-secrets) is used to store secrets into Kubernetes.

Fetch the certificate that you will use to encrypt your secrets, and store it into `.secrets/<CLOUD>/<ENV>/sealed-secrets/cert.pem` :

```shell
❯ kubeseal --fetch-cert --controller-name=sealed-secrets -n kube-system > .secrets/aws/staging/sealed-secrets/cert.pm
```

Create a SealedSecrets from a file:

```shell
❯ make kubeseal-encrypt CLOUD=aws ENV=staging \
    FILE=.secrets/aws/staging/kube-prometheus-stack/object-store.yaml \
    NAME=thanos-objstore-config NAMESPACE=monitoring \
    > ./gitops/argocd/apps/aws/staging/apps/thanos-objstore-config.yaml
```

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

<img src="/docs/images/argocd_stacks.png" alt="Argo-CD Stacks" class="mt-3 mb-3 border border-info rounded">

You can list stack installed:

```shell
❯ helm list -A
NAME    NAMESPACE       REVISION        UPDATED                                         STATUS          CHART           APP VERSION
argo-cd argocd          1               2022-06-08 07:40:20.039787662 +0200 CEST        deployed        argo-cd-1.0.0   4.5.0
core    argocd          1               2022-06-08 07:42:03.285558277 +0200 CEST        deployed        stack-0.1.0     0.1.0
system  argocd          1               2022-06-08 07:41:21.749647011 +0200 CEST        deployed        stack-0.1.0     0.1.0
```

Argo-CD applications installs others Argo-CD applications : 

<img src="/docs/images/argocd_app_observability.png" alt="Argo-CD Observability" class="mt-3 mb-3 border border-info rounded">

<img src="/docs/images/argocd_app_grafana.png" alt="Argo-CD Grafana" class="mt-3 mb-3 border border-info rounded">

Go to Argo-CD dashboard, you will see Argo-CD corresponding applications.

You can list **Stack** applications using the labels `app.kubernetes.io/component: portefaix-stack`


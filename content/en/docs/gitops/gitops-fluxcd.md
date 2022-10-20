+++
title = "FluxCD"
description = "Gitops model for Kubernetes using Flux v2"
weight = 10

+++

[Gitops](https://www.weave.works/technologies/gitops/) model used is [Flux v2](https://toolkit.fluxcd.io/)

<img src="/docs/images/gitops-toolkit.png"
 alt="Flux v2"
 class="mt-3 mb-3 border border-info rounded">

## Organization

Manifests files :

* `kubernetes/base` directory contains manifests for all components
* `kubernetes/overlays/**` directory contains [Kustomize](https://kustomize.io/) overlays

Flux components are deployed for each cluster on `clusters/<CLOUD>/<ENV>/` :

* `clusters/<CLOUD>/<ENV>/flux-system` : Flux core components
* `clusters/<CLOUD>/<ENV>/*.yaml` : [Flux Kustomization](https://toolkit.fluxcd.io/components/kustomize/kustomization/) files for components

## Bootstrap

### FluxCD

```shell
❯ make fluxcd-bootstrap ENV=<environment> CLOUD=<cloud provider> BRANCH=<git branch to use>
```

### Stacks

You can list stack installed:

```shell
❯ kubectl -n flux-system get kustomization -l "app.kubernetes.io/component=portefaix-stack"
NAME            AGE    READY   STATUS
core            107m   True    Applied revision: feat/weave-gitops/2ea4d23f1ae31bfb6afbe57a4662b5990dcf3307
observability   109m   True    Applied revision: feat/weave-gitops/2ea4d23f1ae31bfb6afbe57a4662b5990dcf3307
```

And Helm releases:

```shell
❯ helm list -A
NAME                            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART                           APP VERSION
alertmanager-mixin              monitoring      1               2022-08-08 10:57:51.540267795 +0000 UTC deployed        alertmanager-mixin-0.6.0        0.23.0
kube-prometheus-stack           monitoring      1               2022-08-08 10:57:52.701498295 +0000 UTC deployed        kube-prometheus-stack-35.0.3    0.56.0
kube-state-metrics-mixin        monitoring      1               2022-08-08 10:57:52.285323133 +0000 UTC deployed        kube-state-metrics-mixin-0.10.0 2.2.4
kubernetes-mixin                monitoring      1               2022-08-08 10:57:52.528376605 +0000 UTC deployed        kubernetes-mixin-0.8.0          0.8.0
kyverno                         flux-system     1               2022-08-08 09:00:31.649605165 +0000 UTC deployed        kyverno-crds-v2.0.3             v1.4.3
metrics-server                  kube-system     1               2022-08-08 10:57:41.851963826 +0000 UTC failed          metrics-server-3.8.2            0.6.1
prometheus-mixin                monitoring      1               2022-08-08 10:57:53.019370201 +0000 UTC deployed        prometheus-mixin-0.10.0         2.31.1
prometheus-operator-mixin       monitoring      1               2022-08-08 10:57:53.815678548 +0000 UTC deployed        prometheus-operator-mixin-0.8.0 0.52.1
weawe-gitops                    flux-system     1               2022-08-08 07:49:32.97390968 +0000 UTC  deployed        weave-gitops-2.2.5              v0.9.1
```

<img src="/docs/images/fluxcd-applications.png" alt="Flux-CD Applications" class="mt-3 mb-3 border border-info rounded">

<img src="/docs/images/fluxcd-kustomization-details.png" alt="Details" class="mt-3 mb-3 border border-info rounded">

<img src="/docs/images/fluxcd-kustomization-graph.png" alt="Graph" class="mt-3 mb-3 border border-info rounded">


## Secrets

### File

Create a Kubernetes secret file from sensitive file.

Ex: for Thanos configuration :

```yaml
❯ cat .secrets/aws/object-store.yaml
type: S3
config:
  bucket: xxxxxxxxxxx
  endpoint: s3.eu-west-3.amazonaws.com
  region: eu-west-3
```

```shell
❯ make kubernetes-secret NAME=thanos-object-storage NAMESPACE=monitoring FILE=.secrets/aws/object-store.yaml > thanos-object-storage.yaml
```

### Encrypt

Encrypt the file using Sops:

```shell
❯ make sops-encrypt ENV=staging CLOUD=aws FILE=thanos-object-storage.yaml
```

You can now safely store this file into Git.

```shell
❯ mv thanos-object-storage.yaml kubernetes/overlays/staging/monitoring/thanos/
```

### Decrypt

Check you can decrypt the file:

```shell
❯ make sops-decrypt FILE=kubernetes/overlays/staging/monitoring/thanos/thanos-object-storage.yaml
apiVersion: v1
data:
    object-store.yaml: xxxxxxxxxxx
kind: Secret
metadata:
    creationTimestamp: null
    name: thanos-object-storage
    namespace: monitoring
```

## CI/CD

### AGE

{{% alert title="Work In Progress" color="warning" %}}
{{% /alert %}}

### PGP

Generate a GPG key with OpenPGP without specifying a passphrase:

```shell
❯ gpg --full-generate-key

Real name: nlamirault
Email address: nlamirault@users.noreply.github.com
Comment:
You selected this USER-ID:
    "nlamirault <nlamirault@users.noreply.github.com>"

Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? O
```

Retrieve the GPG key ID:

```shell
❯ gpg --export-secret-keys \
--armor FC5BB3323309486AC8DA477CEC6421C7C33D2301
```

Add this output into a Github Secret `SOPS_GPG_KEY`.

On the `e2e` Github Action workflow, we create a Kubernetes secret `sops-gpg`
which will be used by Flux.

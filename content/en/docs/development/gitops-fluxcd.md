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


## Sync

```shell
❯ make fluxcd-bootstrap ENV=<environment> CLOUD=<cloud provider> BRANCH=<git branch to use>
```

## Secrets

### Bootstrap

[Sops](https://github.com/mozilla/sops) is used to manage secrets.

Create for each cloud provider and environment an [Age](https://age-encryption.org/) key. Store it into:

`.secrets/<CLOUD_PROVIDER>/<ENV>/age/age.agekey`

Put your sensitive data into the directory `.secrets` or `.secrets/<CLOUD_PROVIDER>/<ENV>/<APPLICATION>`

Then deploy the Age key into a Kubernetes secret:

```shell
❯ make sops-age-secret CLOUD=<CLOUD_PROVIDER> ENV=<ENV>
```

### Usage

#### File

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

#### Encrypt

Encrypt the file using Sops:

```shell
❯ make sops-encrypt ENV=staging CLOUD=aws FILE=thanos-object-storage.yaml
```

You can now safely store this file into Git.

```shell
❯ mv thanos-object-storage.yaml kubernetes/overlays/staging/monitoring/thanos/
```

#### Decrypt

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

### CI/CD

#### AGE

{{% alert title="Work In Progress" color="warning" %}}
{{% /alert %}}

#### PGP

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

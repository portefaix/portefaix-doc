+++
title = "Secrets"
description = "Gitops model for Kubernetes using Flux v2"
weight = 50

+++

## Kubeseal

[sealed-secrets](https://github.com/bitnami-labs/sealed-secrets) could be used to store secrets into Kubernetes with Argo-CD.

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

## Sops

[Sops](https://github.com/mozilla/sops) is used to manage secrets with FluxCD.

Create for each cloud provider and environment an [Age](https://age-encryption.org/) key. Store it into:

`.secrets/<CLOUD_PROVIDER>/<ENV>/age/age.agekey`

Put your sensitive data into the directory `.secrets` or `.secrets/<CLOUD_PROVIDER>/<ENV>/<APPLICATION>`

Then deploy the Age key into a Kubernetes secret:

```shell
❯ make sops-age-secret CLOUD=<CLOUD_PROVIDER> ENV=<ENV> NAMESPACE=flux-system
```

## External Secrets Operator

[ESO](https://external-secrets.io/) is a Kubernetes operator which read informations from external APIs
and automatically injects the values into a Kubernetes Secret.

Usage on Portefaix:

* AWS Secrets Manager
* Google Secrets Manager
* Azure Key Vault
* AKeyless

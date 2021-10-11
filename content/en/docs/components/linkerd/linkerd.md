+++
title = "Linkerd"
weight = 10
+++

## Hub

<div class="artifacthub-widget" data-url="https://artifacthub.io/packages/helm/linkerd2-edge/linkerd2" data-theme="light" data-header="true" data-responsive="false"><blockquote><p lang="en" dir="ltr"><b>linkerd2</b>: Linkerd gives you observability, reliability, and security for your microservices — with no code change required. </p>&mdash; Open in <a href="https://artifacthub.io/packages/helm/linkerd2-edge/linkerd2">Artifact Hub</a></blockquote></div><script async src="https://artifacthub.io/artifacthub-widget.js"></script>


## Certificates and keys

Use a script ./hack/scripts/linkerd-certificates.sh. Ex for Homelab:

```shell
❯ STEP=step-cli ./hack/scripts/linkerd-certificates.sh k3sh omelab                                                                                                                                                  Generate secrets into: .secrets/k3s/homelab/linkerd
Trust anchor certificate
✔ Would you like to overwrite .secrets/k3s/homelab/linkerd/ca.crt [y/n]: y
Your certificate has been saved in .secrets/k3s/homelab/linkerd/ca.crt.: y
Your private key has been saved in .secrets/k3s/homelab/linkerd/ca.key.
Issuer certificate and key
✔ Would you like to overwrite .secrets/k3s/homelab/linkerd/issuer.key [y/n]: y
✔ Would you like to overwrite .secrets/k3s/homelab/linkerd/issuer.crt [y/n]: y
Your certificate has been saved in .secrets/k3s/homelab/linkerd/issuer.crt.
Your private key has been saved in .secrets/k3s/homelab/linkerd/issuer.key.
Create Kubernetes secret
```

Encrypt using Sops and update manifests:

```shell
❯ make sops-encrypt ENV=homelab CLOUD=k3s FILE=secrets.yaml
❯ mv secrets.yaml ./kubernetes/overlays/k3s/homelab/linkerd/linkerd/certificates.yaml
```

## Gitops

<!-- BEGIN_PORTEFAIX_DOC -->

* Repository URL: https://helm.linkerd.io/edge
* Repository: `linkerd-edge`
* Chart: `linkerd2`
* Version: `21.9.1`
* Namespace: `linkerd`

<!-- END_PORTEFAIX_DOC -->

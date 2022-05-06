+++
title = "Roadmap"
description = "The Portefaix Roadmap"
weight = 50

+++

## v1

### Infrastructure

- [x] Development environment</span>
- [x] Terraform code for Google Cloud Platform</span>
- [x] Terraform code for Amazon AWS</span>
- [x] Terraform code for Microsoft Azure</span>
- [x] Terraform code for Alicloud</span>
- [x] Terraform code for Digital Ocean</span>
- [x] Terraform code for Scaleway</span>
- [x] Terraform code for Exoscale</span>
- [x] Terraform code for IBM Cloud</span>
- [x] Terraform code for Vultr</span>
- [x] Terraform code for Civo</span>
- [ ] `WIP` Terraform code for Oracle Cloud</span>

### Core

- [x] Gitops using Argo-CD</span>
- [x] Gitops using Flux v2</span>

### Observability

- [ ] `WIP` Monitoring: Prometheus, Alertmanager, Thanos, Mimir, ... (<i class="fas fa-check"> GKE </i>, <i class="fas fa-check"> EKS </i>, AKS, Alicloud, Scaleway, Exoscale, IBM, OCI, Homelab)
- [ ] `WIP` Logging: Loki, Vector (<i class="fas fa-check"> GKE </i>, EKS, AKS, Alicloud, Scaleway, Exoscale, IBM, OCI, Homelab)
- [ ] `WIP`Tracing: Tempo (GKE, EKS, AKS, Alicloud, Scaleway, Exoscale, IBM, OCI, Homelab)

### System

- [ ] `WIP` External-DNS, Cert-Manager (<i class="fas fa-check"> GKE </i>, <i class="fas fa-check"> EKS </i>, AKS, Alicloud, Scaleway, Exoscale, IBM, OCI)
- [ ] `WIP` Autoscaling (GKE, EKS, AKS, Alicloud, Scaleway, Exoscale, IBM, OCI, <i class="fas fa-check"> Homelab </i>)

### Authentication

- [ ] `WIP` Argo-CD with Dex (Auth0, Github) (GKE, EKS, AKS, Alicloud, Scaleway, Exoscale, IBM, OCI, <i class="fas fa-check"> Homelab </i>)
- [ ] `WIP` Oauth2-Proxy (GKE, EKS, AKS, Alicloud, Scaleway, Exoscale, IBM, OCI)

### Service Mesh

- [ ] `WIP` Open Service Mesh (<i class="fas fa-check"> GKE </i>, EKS, AKS, Alicloud, Scaleway, Exoscale, IBM, OCI, Homelab)

### Chaos

- [ ] `WIP` Chaos Mesh (<i class="fas fa-check"> GKE </i>, EKS, AKS, Alicloud, Scaleway, Exoscale, IBM, OCI, Homelab)
- [ ] `WIP` Litmus Chaos (<i class="fas fa-check"> GKE </i>, EKS, AKS, Alicloud, Scaleway, Exoscale, IBM, OCI, Homelab)

## v2

### Service Mesh Cloud Providers

- [ ] [Traffic Director](https://cloud.google.com/traffic-director/) [ [#8](https://github.com/portefaix/portefaix/issues/8) ]
- [ ] [AWS App Mesh](https://aws.amazon.com/fr/app-mesh/) [ [#9](https://github.com/portefaix/portefaix/issues/9) ]
- [ ] [Service Fabric Mesh](https://docs.microsoft.com/en-us/azure/service-fabric-mesh/) [ [#10](https://github.com/portefaix/portefaix/issues/10) ]

## Backlog

### Cloud providers


### Secrets Store CSI Driver

- [ ] [GCP Secret manager](https://github.com/GoogleCloudPlatform/secrets-store-csi-driver-provider-gcp) [ [#4](https://github.com/portefaix/portefaix/issues/4) ]
- [ ] [Amazon Secrets manager](https://github.com/aws/containers-roadmap/issues/895) [ [#5](https://github.com/portefaix/portefaix/issues/5) ]
- [ ] [Azure Vault](https://github.com/Azure/secrets-store-csi-driver-provider-azure) [ [#6](https://github.com/portefaix/portefaix/issues/6) ]

### Managing Cloud Services via Kubernetes CRDs

- [ ] [Crossplane](https://crossplane.io/)
- [ ] [AWS Controllers for Kubernetes (ACK)](https://github.com/aws/aws-controllers-k8s)
- [ ] [Azure Service Operator (for Kubernetes)](https://github.com/Azure/azure-service-operator)
- [ ] [Google Config Connector](https://cloud.google.com/config-connector/docs/overview)

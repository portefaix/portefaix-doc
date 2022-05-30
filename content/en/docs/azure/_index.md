+++
title = "Portefaix on Azure"
description = "Running Portefaix on Microsoft Azure AKS"
weight = 40
+++

<img src="/docs/images/portefaix-azure-infra.svg" alt="Portefaix components" class="mt-3 mb-3 rounded">

| Name | Range |
|--------|-------|
| portefaix-dev-hub | 10.10.0.0/16 |
| AzureFirewallSubnet | 10.10.1.0/24 |
| AzureBastionSubnet  | 10.10.2.0/24 |
| portefaix-dev  | 10.0.0.0/16 |
| portefaix-dev-aks | 10.0.0.0/20 |
| portefaix-dev-ilb | 10.0.32.0/20 |
| PrivateLinkEndpoints | *TODO* |
| ApplicationGatewaySubnet | 10.0.16.0/20 |

<img src="/docs/images/portefaix-azure.svg" alt="Portefaix components" class="mt-3 mb-3 rounded">

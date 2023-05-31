+++
title = "Portefaix on Oracle Cloud"
description = "Running Portefaix on Oracle Cloud"
weight = 70
+++

<img src="/docs/images/portefaix-oci-infra.svg" alt="Infrastructure" class="mt-3 mb-3 rounded">

<img src="/docs/images/portefaix-oci.svg" alt="Portefaix components" class="mt-3 mb-3 rounded">

| Name                      | Type         | Range        |
|---------------------------|--------------|--------------|
| portefaix-dev             | VirtualNet   | 10.0.0.0/16  |
| portefaix-dev-aks         | Subnet       | 10.0.0.0/20  |
| portefaix-dev-ilb         | Subnet       | 10.0.32.0/20 |
| ApplicationGatewaySubnet  | Subnet       | 10.0.64.0/24 |
| portefaix-dev-nat-gateway | Subnet       | 10.0.65.0/24 |
| portefaix-dev-hub         | VirtualNet   | 10.10.0.0/16 |
| AzureFirewallSubnet       | Subnet       | 10.10.1.0/24 |
| AzureBastionSubnet        | Subnet       | 10.10.2.0/24 |
| PrivateLinkEndpoints      | Subnet       | *TODO*       |
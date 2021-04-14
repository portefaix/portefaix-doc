+++
title = "Deploying Portefaix"
description = "Instructions for deploying and deleting Portefaix on Google Cloud Platform GKE"
weight = 30
+++

{{% alert title="Work In Progress" color="warning" %}}
{{% /alert %}}

## Prerequisites

* Install [gcloud](https://cloud.google.com/sdk/docs/install)
* Install [terraform](https://www.terraform.io/downloads.html)
* A project created on Google Cloud Platform.

**Note** Edit `iac/gcp/gcp.prod.mk` or add another file named `iac/gcp/gcp.<ENVIRONMENT>.mk`

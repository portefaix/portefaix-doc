+++
title = "Install Portefaix"
description = "Instructions for deploying Portefaix on Oracle Cloud"
weight = 10
+++

<a id="exo"></a>

## Setup

Configure Oracle CLI

```shell
```

And load environment :

```shell
❯ . ./portefaix.sh oci
```

## Create a new compartment

```shell
❯ make -f hack/build/oci.mk oci-compartment ENV=staging
```

## Storage for Terraform

Retrive Compartement ID :

```shell
❯ oci iam compartment list
```

Create a S3 bucket for Terraform states:

```shell
❯ make -f hack/build/oci.mk oci-bucket ENV=staging COMPARTMENT_ID=ocid1.compartment.oc1....
```

## Terraform


+++
title = "Authentication and Authorization"
description = "Authentication and authorization support for Portefaix in GCP"
weight = 90
+++

This section shows the how to setup Portefaix with authentication and authorization support in
Google Cloud Platform (GCP).

## Cloud IAP

To enable Cloud IAP, you need first to configure the OAuth consent screen. If you still haven't configured the OAuth
consent screen, you can do so with an email address and product name.
See https://support.google.com/cloud/answer/6158849?hl=en#zippy=%2Cuser-consent

Then creates the [Oauth credentials](https://console.cloud.google.com/apis/credentials).
Select the `OAuth client ID` from the Create credentials drop-down list and then select `web application` from the
application type. Next, add a name for your OAuth client ID and click `create`.

## Configure Gcloud

```shell
❯ . ./portefaix.sh gcp
[ Portefaix ]
Setup credentials
Done
```

## Configure kubectl

```shell
❯ make -f hack/build/azure.mk gck-kube-credentials CLOUD=gcp ENV=dev
```

```shell
❯ kubectl get nodes
NAME                                                  STATUS   ROLES    AGE     VERSION
gke-xxxxxxxxxx-cluster-g-core-5d5d62be-tf15   Ready    <none>   7h37m   v1.18.10-gke.601
```

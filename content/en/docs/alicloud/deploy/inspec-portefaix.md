+++
title = "Inspec Portefaix"
description = "Instructions for check Portefaix infrastructure on Alibaba Cloud"
weight = 20
+++

[Inspec](http://inspec.io/) is used to check infrastructure.

Check:

```shell
❯ make -f hack/build/alicloud.mk inspec-alicloud-debug
```

Execute tests:

{{% alert title="Work In Progress" color="warning" %}}
{{% /alert %}}


## CIS Kubernetes Benchmark

```shell
❯ make -f hack/build/alicloud.mk inspec-alicloud-kubernetes ENV=staging
```

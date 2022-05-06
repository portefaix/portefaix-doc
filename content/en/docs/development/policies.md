+++
title = "Policies"
description = "The policies repository"
weight = 40

+++

[Portefaix Policies](https://github.com/portefaix/portefaix-policies) contains Kubernetes policies for [Kyverno](https://kyverno.io/) or [Open Policy Agent](https://www.openpolicyagent.org/).

## Kyverno

<!-- BEGIN_PORTEFAIX_KYVERNO_DOC -->

* `PORTEFAIX-C0001` - Container must not use latest image tag
* `PORTEFAIX-C0002` - Container must set liveness probe
* `PORTEFAIX-C0003` - Container must set readiness probe
* `PORTEFAIX-C0004` - Container must mount secrets as volumes, not enviroment variables
* `PORTEFAIX-C0005` - Container must drop all capabilities
* `PORTEFAIX-C0006` - Container must not allow for privilege escalation
* `PORTEFAIX-C0008` - Container resource constraints must be specified
* `PORTEFAIX-M0001` - Metadata must set recommanded Kubernetes labels
* `PORTEFAIX-M0002` - Metadata should have a8r.io annotations
* `PORTEFAIX-M0003` - Metadata should have portefaix.xyz annotations
* `PORTEFAIX-P0002` - Pod must run without access to the host IPC
* `PORTEFAIX-P0003` - Pod must run without access to the host networking
* `PORTEFAIX-P0004` - Pod must run as non-root
* `PORTEFAIX-P0005` - Pod must run without access to the host PID

<!-- END_PORTEFAIX_KYVERNO_DOC -->

## Open Policy Agent

<!-- BEGIN_PORTEFAIX_OPA_DOC -->

* `PORTEFAIX-C0001`: Container must not use latest image tag
* `PORTEFAIX-C0002`: Container must set liveness probe
* `PORTEFAIX-C0003`: Container must set readiness probe
* `PORTEFAIX-C0004`: Container must mount secrets as volumes, not enviroment variables
* `PORTEFAIX-C0006`: Container must not allow for privilege escalation
* `PORTEFAIX-C0008`: Container must define resource contraintes
* `PORTEFAIX-M0001`: Metadata should contain all recommanded Kubernetes labels
* `PORTEFAIX-M0002`: Metadata should have a8r.io annotations
* `PORTEFAIX-M0003`: Metadata should have portefaix.xyz annotations
* `PORTEFAIX-N0001`: Disallow Default Namespace

<!-- END_PORTEFAIX_OPA_DOC -->

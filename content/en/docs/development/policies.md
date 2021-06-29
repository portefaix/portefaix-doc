+++
title = "Policies"
description = "The policies repository"
weight = 40

+++

## Open Policy Agent

<!-- BEGIN_PORTEFAIX_OPA_DOC -->

* PORTEFAIX-C0001: Container must not use latest image tag
* PORTEFAIX-C0002: Container must set liveness probe
* PORTEFAIX-C0003: Container must set readiness probe
* PORTEFAIX-C0004: Container must mount secrets as volumes, not enviroment variables
* PORTEFAIX-C0005: Container must drop all capabilities
* PORTEFAIX-C0006: Container must not allow for privilege escalation
* PORTEFAIX-C0007: Container liveness probe and readiness probe should be different
* PORTEFAIX-C0008: Container must define resource contraintes
* PORTEFAIX-M0001: Metadata should contain all recommanded Kubernetes labels
* PORTEFAIX-M0002: Metadata should have a8r.io annotations
* PORTEFAIX-M0003: Metadata should have portefaix.xyz annotations
* PORTEFAIX-P0001: Pod must run without access to the host aliases
* PORTEFAIX-P0002: Pod must run without access to the host IPC
* PORTEFAIX-P0003: Pod must run without access to the host networking
* PORTEFAIX-P0004: Pod must run as non-root
* PORTEFAIX-P0005: Pod must run without access to the host PID namespace

<!-- END_PORTEFAIX_OPA_DOC -->

## Kyverno

<!-- BEGIN_PORTEFAIX_KYVERNO_DOC -->

* PORTEFAIX-C0001 - Container must not use latest image tag
* PORTEFAIX-C0002 - Container must set liveness probe
* PORTEFAIX-C0003 - Container must set readiness probe
* PORTEFAIX-C0004 - Container must mount secrets as volumes, not enviroment variables
* PORTEFAIX-C0005 - Container must drop all capabilities
* PORTEFAIX-C0006 - Container must not allow for privilege escalation
* PORTEFAIX-C0008 - Container resource constraints must be specified
* PORTEFAIX-M0001 - Metadata must set recommanded Kubernetes labels
* PORTEFAIX-M0002 - Metadata should have a8r.io annotations
* PORTEFAIX-M0003 - Metadata should have portefaix.xyz annotations
* PORTEFAIX-P0002 - Pod must run without access to the host IPC
* PORTEFAIX-P0003 - Pod must run without access to the host networking
* PORTEFAIX-P0004 - Pod must run as non-root
* PORTEFAIX-P0005 - Pod must run without access to the host PID

<!-- END_PORTEFAIX_KYVERNO_DOC -->

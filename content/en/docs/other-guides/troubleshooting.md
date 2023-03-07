+++
title = "Troubleshooting"
description = "Finding and fixing problems in your Portefaix deployment"
weight = 100

+++

This page presents some hints for troubleshooting specific problems that you
may encounter.

## Support

Visit the [Portefaix support page](/docs/other-guides/support/) to find resources
and community forums where you can ask for help.

## DNS

To troubleshooting DNS, you could use the `testing/dns.yaml` manifest.
Edit the `nodeSelector` section to specify on which node you want deploy the pod.

Then, perform some tests:

```shell
❯ kubectl exec -i -t dnsutils -- nslookup kubernetes.default
Server:         10.43.0.10
Address:        10.43.0.10#53

Name:   kubernetes.default.svc.cluster.local
Address: 10.43.0.1
```

```shell
❯ kubectl exec -i -t dnsutils -- nslookup github.com
Server:         10.43.0.10
Address:        10.43.0.10#53

Non-authoritative answer:
Name:   github.com
Address: 140.82.121.4
```
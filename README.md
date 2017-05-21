
consul-formula
==============

[![Consul](./assets/consul_logo.png "Docker")](https://www.consul.io)

[Consul](https://www.consul.io) makes it simple for services to register themselves and to discover other services via a DNS or HTTP interface. Register external services such as SaaS providers as well.

Available states
================

``consul``
----------

Installs Consul configured as a server. The formula will attempt to use salt-mine to find other consul nodes. After it finds other nodes the formula then configures consul to create a cluster and wait for members to join before doing a leader election.

Configuration Options
=====================

`statsd_address` - Where to tell consul to send statistics about the running process.
`data_dir` - Tells consul where to store its data

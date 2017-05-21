{% set p    = pillar.get('consul', {}) %}
{% set pc   = p.get('config', {}) %}
{% set g    = grains.get('consul', {}) %}
{% set gc   = g.get('config', {}) %}

{%- set force_mine_update = salt['mine.send']('network.ip_addrs') %}

{%- set cluster_name = salt['grains.get']('consul:cluster_name') %}
{%- set local_ip = salt['network.ip_addrs']()[0] %}

{%- set consul_host_dict = salt['mine.get']('G@service:consul and G@env:' + grains.get('env'), 'network.ip_addrs', 'compound') %}

{%- set consul_hosts = consul_host_dict.values() %}

{%- set cluster_nodes = [] %}

{%- for ip_addr in consul_hosts %}
  {% if ip_addr != local_ip %}
    {{ cluster_nodes.append(ip_addr[0]) }}
  {% endif %}
{%- endfor %}

{%- set consul = {} %}
{%- do consul.update({
  'version'                 : gc.get('version', pc.get('version','0.6.4')),
  'release_sha'             : gc.get('release_sha', pc.get('release_sha','abdf0e1856292468e2c9971420d73b805e93888e006c76324ae39416edcf0627')),
  'aws_discover'            : pc.get('aws_discover', False),
  'encrypt_key'             : pc.get('encrypt_key'),
  'cluster_nodes'           : cluster_nodes,
  'node_count'              : cluster_nodes|length,
  'data_dir'                : pc.get('data_dir', '/data/'),
  'local_ip'                : local_ip,
  'statsd_address'          : pc.get('statsd_address', False),
  'statsd_prefix'           : pc.get('statsd_prefix', False)
  }) %}

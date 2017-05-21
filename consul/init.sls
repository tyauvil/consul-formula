{%- from 'consul/settings.sls' import consul with context %}

unzip:
  pkg.installed

consul-installer:
  archive.extracted:
    - name: /usr/local/bin/
    - source: https://releases.hashicorp.com/consul/{{ consul.version }}/consul_{{ consul.version }}_linux_amd64.zip
    - source_hash: sha256={{ consul.release_sha }}
    - archive_format: zip
    - user: root
    - group: root
    - if_missing: /usr/local/bin/consul
    - require:
      - pkg: unzip

/etc/consul/config.json:
  file.managed:
    - source: salt://consul/templates/consul.json
    - template: jinja
    - user: root
    - group: root
    - makedirs: True
    - context:
        node_count: {{ consul.node_count }}
        cluster_nodes: {{ consul.cluster_nodes}}
        statsd_address: {{ consul.statsd_address }}
        statsd_prefix: {{ consul.statsd_prefix }}
        env: {{ salt['grains.get']('env') }}
        az: {{ salt['grains.get']('az') }}
        node_name: {{ salt['grains.get']('id') }}
        data_dir: {{ consul.data_dir }}
        local_ip: {{ consul.local_ip }}
        version: {{consul.version }}
        aws_discover: {{ consul.aws_discover }}

{% if grains['oscodename'] == 'xenial' %}
/etc/systemd/system/consul.service:
  file.managed:
    - source: salt://consul/files/consul.service
    - module.run:
      - name: service.systemctl_reload
      - onchanges:
        - file: /etc/systemd/system/td-agent.service
    - listen_in:
        - service: consul
{% endif %}

{% if grains['oscodename'] == 'trusty' %}
/etc/init/consul.conf:
  file.managed:
    - source: salt://consul/files/upstart.conf
    - user: root
    - password: root
    - listen_in:
        - service: consul
{% endif %}

consul:
  service.running:
    - enable: True
    - watch:
      - file: /etc/consul/config.json
    - require:
      - file: /etc/consul/config.json
      - archive: consul-installer

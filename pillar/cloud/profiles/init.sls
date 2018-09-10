{% from 'cloud/profiles/defaults.sls' import defaults %}
{% set cloud_nodes = salt.mt_netbox.get_nodes() %}

cloud:
  profiles:

    ##
    # Digitalocean
    ##

    {% for node, opts in cloud_nodes.get('do-nodes', {}).items() %}
    do_{{ node }}:
      provider:   do
      size:       {{ opts.get('size',      defaults['do']['size']) }}
      location:   {{ opts.get('location',  defaults['do']['location']) }}
    {% endfor %}

    ##
    # Proxmox Internal
    ##

    {% for node, opts in cloud_nodes.get('proxint-nodes', {}).items() %}
    proxint_{{ node }}:
      name:       {{ node }}
      provider:   proxint
      technology: {{ opts.get('type',    defaults['proxint']['type']) }}
      memory:     {{ opts.get('mem',     defaults['proxint']['mem']) }}
      onboot:     {{ opts.get('onboot',  defaults['proxint']['onboot'])|int }}
      rootfs:     volume={{ opts.get('storage', defaults['proxint']['storage'])
          }}:{{ opts.get('disk',    defaults['proxint']['disk_size']) }}
      cores:      {{ opts.get('cpu',     defaults['proxint']['cpu']) }}
      swap:       {{ opts.get('swap',    defaults['proxint']['swap']) }}
      ip_address: {{ opts.get('iface', {}).get('net0', {}).get('ipv4_addr', opts.get('ipv6_addr', '')).split('/')[0] }}
      {% for iface, ifopt in opts.get('iface', {}).items()
      %}{{ iface }}: name={{ ifopt.name }},bridge=vmbr0{% if 'ipv4_addr' in ifopt
          %}{{ ',ip='  ~ ifopt['ipv4_addr'] ~ ',gw=' ~ ifopt['ipv4_gw'] }}{% endif
          %}{% if 'ipv6_addr' in ifopt
          %}{{ ',ip6=' ~ ifopt['ipv6_addr'] ~ ',gw6=' ~ ifopt['ipv6_gw'] }}{% endif
          %}{% if 'vlan' in ifopt %},tag={{ ifopt['vlan'] }}{% endif %}
      {% endfor %}
      ipv4addr:   {{ opts['iface']['net0'].get('ipv4_addr', '') }}
      ipv6addr:   {{ opts['iface']['net0'].get('ipv6_addr', '') }}
      #disk_size:  {{ opts.get('disk',    defaults['proxint']['disk_size']) }}
      #storage:    {{ opts.get('storage', defaults['proxint']['storage']) }}
    {% endfor %}

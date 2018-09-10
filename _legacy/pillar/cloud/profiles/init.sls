{% from 'cloud/profiles/defaults.sls' import defaults %}
{% set cloud_nodes = salt['mt_netbox.get_nodes']() %}

cloud:
  profiles:

    ##
    # Digitalocean
    ##

    {% for node, opts in cloud_nodes.get('digitalocean-nodes', {}).iteritems() %}
    digitalocean_{{ node }}:
      provider:   digitalocean
      image:      {{ opts.get('image',     defaults['digitalocean']['image']) }}
      size:       {{ opts.get('size',      defaults['digitalocean']['size']) }}
      location:   {{ opts.get('location',  defaults['digitalocean']['location']) }}
    {% endfor %}

    ##
    # Proxmox Internal
    ##

    {% for node, opts in cloud_nodes.get('proxint-nodes', {}).iteritems() %}
    proxint_{{ node }}:
      provider:   proxint
      name:       {{ node }}
      technology: {{ opts.get('type',    defaults['proxint']['type']) }}
      mem:        {{ opts.get('mem',     defaults['proxint']['mem']) }}
      onboot:     {{ opts.get('onboot',  defaults['proxint']['onboot']) }}
      host:       {{ opts.get('host',    defaults['proxint']['host']) }}
      disk_size:  {{ opts.get('disk',    defaults['proxint']['disk_size']) }}
      storage:    {{ opts.get('storage', defaults['proxint']['storage']) }}
      cpus:       {{ opts.get('cpu',     defaults['proxint']['cpu']) }}
      swap:       {{ opts.get('swap',    defaults['proxint']['swap']) }}
      {% for iface, ifopt in opts.get('iface', {}).iteritems()
      %}{{ iface }}: name={{ifopt.name}},bridge=vmbr0{% if 'ipv4_addr' in ifopt
          %}{{ ',ip='  ~ ifopt['ipv4_addr'] ~ 'gw=' ~ ifopt['ipv4_gw'] }}{% endif
          %}{% if 'ipv6_addr' in ifopt
          %}{{ ',ip6=' ~ ifopt['ipv6_addr'] ~ 'gw=' ~ ifopt['ipv6_gw'] }}{% endif %}
      {% endfor %}
    {% endfor %}

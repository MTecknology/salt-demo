{% set cloud_nodes = salt.mt_netbox.get_nodes() %}

map_data:

  {# DigitalOcean Nodes #}
  {% for node, opts in cloud_nodes.get('do-nodes', {}).items() %}
  do_{{ node }}:
    - {{ node }}
  {% endfor %}

  {# ProxInternal Nodes #}
  {% for node, opts in cloud_nodes.get('proxint-nodes', {}).items() %}
  proxint_{{ node }}:
    - {{ node }}
  {% endfor %}

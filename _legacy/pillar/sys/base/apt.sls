{# Yes, this is kinda messy... someday I probably won't ever get it cleaned up. ;P #}
{% if grains.get('lsb_distrib_release').startswith('8') %}
debian_apt:
  release: jessie
  version: 8
  salt_ver: 8
  salt_rel: jessie
  server: apt.domain.tld
  salt_server: apt.domain.tld

{% elif grains.get('lsb_distrib_release').startswith('9') %}
debian_apt:
  release: stretch
  version: 9
  #TODO: CHANGE WHEN STRETCH RELEASES
  salt_ver: 8
  salt_rel: jessie
  server: apt.domain.tld
  salt_server: apt.domain.tld

{% endif %}

  {% if not grains['os'] == 'Raspbian' %}
  mtrepo: True
  {% else %}
  mtrepo: False
  {% endif %}

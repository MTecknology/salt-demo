{% set node = salt.mt_utils.parse_id() %}
base:

  'kernel:Linux':
    - match: grain
    - sys.files.apt
    - sys.files.gai
    - sys.files.pam
    - sys.files.tzdata
    - sys.pkgs.base
    - sys.pkgs.ferm
    - sys.pkgs.logcheck
    - sys.pkgs.ntp
    - sys.pkgs.salt
    - sys.pkgs.snap
    - sys.pkgs.ssh
    - sys.pkgs.sshguard
    - sys.pkgs.ssmtp
    - sys.pkgs.sudo
    - sys.pkgs.syslog
    - sys.users

  # Cluster-based includes
  {% if node.get('cluster_name') %}
  '{{ grains['id'] }}':
    - cluster_includes._nil
    {% filter indent(width=4, indentfirst=0) -%}
    {% include 'cluster_includes/' ~ node['cluster_name'] ignore missing with context %}
    {% endfilter %}
  {% endif %}

  'public_ip:inet:*':
    - match: grain
    - sys.cron.openvpn
    - sys.files.remote_resolveconf

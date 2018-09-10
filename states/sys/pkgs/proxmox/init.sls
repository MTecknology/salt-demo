include:
  - sys.users.saltprox

proxmox:
  pkg.installed:
    - pkgs:
      - proxmox-ve
      - ssh
      - ksm-control-daemon
      - open-iscsi
      - systemd-sysv
    - require:
      - pkgrepo: proxmox-repo

proxmox-purged:
  pkg.purged:
    - pkgs:
      - os-prober

{% set debapt = pillar.get('debian_apt', {}) %}

/etc/apt/sources.list.d/pve-enterprise.list:
  file.absent

proxmox-repo:
  pkgrepo.managed:
    - humanname: "Proxmox"
    - name: "deb http://{{ debapt['server'] }}/proxmox {{ debapt['release'] }} pve-no-subscription"
    - dist: {{ debapt['release'] }}
    - file: /etc/apt/sources.list.d/proxmox.list
    - key_url: salt://etc/apt/keys/9887F95A.pub

disable_subscription_warning:
  file.replace:
    - name: /usr/share/pve-manager/js/pvemanagerlib.js
    - pattern: "data.status === 'Active'"
    - repl: "true"
    - require:
      - pkg: proxmox

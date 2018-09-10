unifi:
  pkg.installed:
    - refresh: True
    - require:
      - pkgrepo: ubiquiti-repo
  service.running:
    - name: unifi

## files

ubiquiti-repo:
  pkgrepo.managed:
    - humanname: "Ubiquiti Unifi"
    - name: "deb http://apt.domain.tld/unifi stable ubiquiti"
    - dist: stable
    - file: /etc/apt/sources.list.d/ubiquiti.list
    - key_url: salt://etc/apt/keys/DE57BFBE.pub

##
# Pillar data must be configured:
# acmetool:
#   domains: [ "domain.tld" "d2.tld d3.tld" ]
# Must be publicly reachable
# Nginx configuration must include ssl settings
# Nginx configuration must include .well-known directory structure
##

include:
  - sys.cron.acmetool

acmetool:
  pkg.installed:
    - refresh_db: True
    - require:
      - pkgrepo: acmetool-repo

acmetool-quickstart:
  cmd.run:
    - name: "acmetool quickstart --batch --response-file=/etc/acmetool-responses.yml"
    - unless: "test -f /var/lib/acme/conf/target"
    - require:
      - file: /etc/acmetool-responses.yml
      - pkg: acmetool

## files

/var/www/.acme-challenge:
  file.directory:
    - dir_mode: 775

acmetool-repo:
  pkgrepo.managed:
    - humanname: "acem tool"
    - name: "deb http://apt.domain.tld/acmetool devel main"
    - dist: devel
    - file: /etc/apt/sources.list.d/acmetool.list
    - key_url: salt://etc/apt/keys/EDB58DFA.pub

/etc/acmetool-responses.yml:
  file.managed:
    - template: jinja
    - contents: |
        "acme-enter-email": "administrator@{{ grains['fqdn'] }}"
        "acme-agreement:https://letsencrypt.org/documents/LE-SA-v1.0.1-July-27-2015.pdf": true
        "acmetool-quickstart-choose-server": "https://acme-v01.api.letsencrypt.org/directory"
        "acmetool-quickstart-choose-method": "webroot"
        "acmetool-quickstart-webroot-path": "/var/www/.acme-challenge"
        "acmetool-quickstart-complete": true
        "acmetool-quickstart-install-cronjob": true
        "acmetool-quickstart-install-haproxy-script": false
        "acmetool-quickstart-install-redirector-systemd": false
        "acmetool-quickstart-key-type": "ecdsa"
        "acmetool-quickstart-rsa-key-size": 4096
        "acmetool-quickstart-ecdsa-curve": "nistp256"

{% for domainlist in salt['pillar.get']('acmetool:domains', []) %}
acmetool-cert-{{ domainlist.split(' ', 1)[0] }}:
  cmd.run:
    - name: "acmetool --batch want {{ domainlist }}"
    - require:
      - cmd: acmetool-quickstart
    - unless: "test -f /var/lib/acme/live/{{ domainlist.split(' ', 1)[0] }}/privkey"
{% endfor %}

include:
  - sys.users.inalert

postfix:
  pkg.installed:
    - require:
      - debconf: postfix
    - require_in:
      - file: /etc/ferm/ferm.conf
  service.running:
    - watch:
      - cmd: /etc/postfix/virtual_aliases
      - cmd: /etc/postfix/transport
      - file: /etc/postfix/main.cf
      - file: /etc/postfix/master.cf
    - require:
      - file: /usr/local/sbin/inalert-send
      - file: /usr/local/sbin/inalert-daemon
  debconf.set:
    - data:
        'postfix/main_mailer_type': {'type': 'select', 'value': 'Internet Site'}
        'postfix/destinations': {'type': 'string', 'value': 'inalert.resistance.report, localhost.localdomain, localhost'}
        'postfix/mailname': {'type': 'string', 'value': 'inalert.resistance.report'}

## files

/etc/postfix/virtual_aliases:
  file.managed:
    - contents: |
        @inalert.resistance.report  inalert@inalert.resistance.report
  cmd.wait:
    - name: postmap /etc/postfix/virtual_aliases
    - watch:
      - file: /etc/postfix/virtual_aliases

/etc/postfix/transport:
  file.managed:
    - contents: |
        inalert.resistance.report  inalert:
  cmd.wait:
    - name: postmap /etc/postfix/transport
    - watch:
      - file: /etc/postfix/transport

/etc/postfix/master.cf:
  file.append:
    - text: |
        inalert   unix  -       n       n       -       -       pipe
          flags=X user=inalert argv=/usr/local/sbin/inalert-send
    - require:
      - user: inalert-user
      - file: /usr/local/sbin/inalert-send
      - file: /usr/local/sbin/inalert-daemon

/etc/postfix/main.cf:
  file.append:
    - text: |
        transport_maps = hash:/etc/postfix/transport
        virtual_alias_maps = hash:/etc/postfix/virtual_aliases

/usr/local/sbin/inalert-daemon:
  file.managed:
    - source: salt://usr/local/sbin/inalert-daemon
    - mode: 750

/usr/local/sbin/inalert-send:
  file.managed:
    - source: salt://usr/local/sbin/inalert-send
    - mode: 750

/usr/local/sbin/inalert-redis:
  file.managed:
    - source: salt://usr/local/sbin/inalert-redis
    - mode: 750

inalert_deps:
  pkg.installed:
    - pkgs:
      - git
      - golang-go
      - python-redis
      - python-mysqldb

/etc/inalert.ini:
  file.managed:
    - source: salt://etc/inalert.ini
    - template: jinja
    - context:
        inalert: {{ pillar['inalert'] }}

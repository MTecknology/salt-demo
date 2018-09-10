tftpd:
  pkg.installed:
    - name: tftpd-hpa
    - require_in:
      - file: /etc/ferm/ferm.conf
  service.running:
    - name: tftpd-hpa
    - require:
      - pkg: tftpd

## files

/etc/default/tftpd-hpa:
  file.managed:
    - contents: |
        TFTP_USERNAME="nobody"
        TFTP_DIRECTORY="/srv/tftp"
        TFTP_ADDRESS="0.0.0.0:69"
        TFTP_OPTIONS="--secure"

{% if salt['pillar.get']('tftpd_source', False) %}
/srv/tftp:
  file.recurse:
    - source: salt://srv/tftp%%{{ pillar['tftpd_source'] }}
    - clean: True
    - user: root
    - group: root
    - watch_in:
      - service: tftpd
{% endif %}

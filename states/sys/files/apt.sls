{% set debapt = pillar.get('debian_apt', {}) %}

/etc/apt/sources.list:
  file.managed:
    {% if salt.match.grain('os:Raspbian') %}
    - contents: |
        deb http://apt.domain.tld/raspmain {{ debapt['release'] }} main contrib non-free rpi
        deb http://apt.domain.tld/rasparch {{ debapt['release'] }} main ui
    {% else %}
    - contents: |
        deb http://{{ debapt['server'] }}/debian {{ debapt['release'] }} main contrib
        deb http://{{ debapt['server'] }}/debsec {{ debapt['release'] }}/updates main contrib
        deb http://{{ debapt['server'] }}/debian {{ debapt['release'] }}-updates main contrib
    {% endif %}


{% if salt.match.grain('os:Raspbian') %}
/etc/apt/sources.list.d/raspi.list:
  file.absent
{% endif %}

{% if debapt['mtrepo'] %}
mtrepo:
  pkgrepo.managed:
    - humanname: "MTecknology (Lustfield) Network"
    - name: "deb http://apt.domain.tld/mtrepo {{ debapt['release'] }} main"
    - dist: {{ debapt['release'] }}
    - file: /etc/apt/sources.list.d/mtrepo.list
    - key_url: salt://etc/apt/keys/E2D7AFBA.pub
    - require_in:
      - pkg: salt-minion

{% else %}
/etc/apt/sources.list.d/mtrepo.list:
  file.absent

{% endif %}

{% if 'action' in data['data'] %}
{% set action  = data['data']['action'] %}{% endif %}

{% if 'host' in data['data'] %}
{% set host    = data['data']['host'] %}{% endif %}

{% if 'env' in data['data'] %}
{% set env     = data['data']['env'] %}{% endif %}

{% set tick    = salt.sdb.get('sdb://localsdb/hst_tick') %}

{% set src     = data['id'] %}


##
# git.domain.tld
##
{% if 'prd-git' in src and action == 'highstate' %}
update_fileserver:
  runner.fileserver.update:
    - tgt: prd-salt-01.core.domain.tld

  {% if 'env' in data['data'] %}
highstate_run:
  local.state.highstate:
    - tgt: "G@id:{{ host }}* and G@environment:{{ env }}"
    - expr_form: compound
    - require:
      - runner: update_fileserver

  {% elif host == 'global' %}
    {# If global_highstate has not been triggered, then set tick to create schedule.
       "tick > X" should match script [1] value.
       Set hst_tick to delay to trigger value + delay.
       [1] salt:/usr/local/sbin/global_highstate #}
    {% if not tick or (tick > 7 or tick == 0) %}
highstate_countdown:
  local.sdb.set:
    - tgt: prd-salt-01.core.domain.tld
    - arg:
      - sdb://localsdb/hst_tick
      - '10'
    {% endif %}

  {% else %}
highstate_run:
  local.state.highstate:
    - tgt: "{{ host }}*"
    - require:
      - runner: update_fileserver

  {% endif %}


##
# pubweb.domain.tld
##
{% elif src.startswith('prd-pubweb') and action == 'highstate' %}
update_fileserver:
  runner.fileserver.update:
    - tgt: prd-salt-01.core.domain.tld

  {% if 'env' in data['data'] %}
highstate_run:
  local.state.highstate:
    - tgt: "G@id:{{ host }}* and G@environment:{{ env }}"
    - expr_form: compound
    - require:
      - runner: update_fileserver

  {% else %}
highstate_run:
  local.state.highstate:
    - tgt: "{{ host }}*"
    - require:
      - runner: update_fileserver

  {% endif %}


##
{% endif %}

{% if 'action' in data['data'] %}
{% set action  = data['data']['action'] %}{% endif %}

{% if 'host' in data['data'] %}
{% set host    = data['data']['host'] %}{% endif %}

{% if 'env' in data['data'] %}
{% set env     = data['data']['env'] %}{% endif %}

{% set tick    = salt['sdb.get']('sdb://localsdb/hst_tick') %}

{% set src     = data['id'] %}


##
# git.domain.tld
##
{% if src == 'git.domain.tld' and action == 'highstate' %}
update_fileserver:
  runner.fileserver.update:
    - tgt: salt.domain.tld

  {% if 'env' in data['data'] %}
highstate_run:
  local.state.highstate:
    - tgt: "G@id:{{ host }}* and G@environment:{{ env }}"
    - expr_form: compound
    - require:
      - runner: update_fileserver

  {% elif host == 'global' %}
    {% if not tick or (tick > 10 or tick == 0) %}
{##
  # This is my magic highstate scheduling!
  # When a salt event comes in from the git server that requests
  # a highstate be pushed across the environment, check the
  # current tick value. If a global highstate was not recently
  # executed, then set the tick to 15.
  #
  # A separate process on the salt master is used to decrease
  # this tick value by one every minute and triggers a global
  # highstate runner when the value reaches zero.
  #
  # This results in a global highstate orchestration run being
  # scheduled with a five minute delay when certain git repositories
  # are pushed to. It also creates a delay before the next global
  # higshtate can be triggered, meaning time for this process to
  # complete.
  #
  # Message me if this deserves a separate blog post!
  ##}
highstate_countdown:
  local.sdb.set:
    - tgt: salt.domain.tld
    - arg:
      - sdb://local/hst_tick
      - '15'
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
{% elif src.startswith('pubweb') and action == 'highstate' %}
update_fileserver:
  runner.fileserver.update:
    - tgt: salt.domain.tld

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

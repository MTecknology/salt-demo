{% from 'sys/pkgs/pip-client/defaults.sls' import conf with context -%}
pip-client:
  pkg.installed:
    - pkgs:
      - python-pip

{% for i in conf['installs'] %}
pip-{{ i }}:
  pip.installed:
    - name: {{ i }}
    - require:
      - pkg: pip-client
{% endfor %}

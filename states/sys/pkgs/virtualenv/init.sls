{% from 'sys/pkgs/virtualenv/defaults.sls' import conf with context -%}
python-virtualenv:
  pkg.installed:
    - pkgs:
      - python-virtualenv
      - build-essential
      - python-dev
      - python3-dev

{% for k, venv in conf['virtualenvs'].items() %}

{% if 'build_depends' in venv %}
venv_{{ k }}_deps:
  pkg.installed:
    - pkgs: {{ venv['build_depends'] }}
    - require_in:
      - virtualenv: venv_{{ k }}
{% endif %}

venv_{{ k }}:
  virtualenv.managed:
    - name: {{ venv['path'] }}
    - requirements: {{ venv['requirements'] }}

    {% if 'require' in venv %}
    - require:
      {% for req in venv['require'] %}
      - {{ req }}
      {% endfor %}
    {% endif %}

    {% if 'require_in' in venv %}
    - require_in:
      {% for req in venv['require_in'] %}
      - {{ req }}
      {% endfor %}
    {% endif %}

{% endfor %}

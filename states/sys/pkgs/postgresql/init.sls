{% from 'sys/pkgs/postgresql/defaults.sls' import conf with context -%}
postgresql:
  pkg.installed:
    - pkgs:
      - postgresql
      - libpq-dev
  service.running:
    - enable: True
    - require:
      - pkg: postgresql

{% for db, usr in conf['grants'].items() %}
pgsql_usr_{{ usr }}:
  postgres_user.present:
    - name: {{ usr }}
    - password: {{ conf['users'].get(usr, '') }}
    - require:
      - service: postgresql

pgsql_db_{{ db }}:
  postgres_database.present:
    - name: {{ db }}
    - owner: {{ usr }}
    - require:
      - postgres_user: pgsql_usr_{{ usr }}
{% endfor %}

#!jinja|yaml|gpg
{% from 'sys/pkgs/_/enabled.sls' import enabled %}
{% set node = salt.mt_utils.app_group_from_id(grains['id']) %}

{% if node %}
  {% for app in enabled %}
    {% set included %}{% filter trim() %}{% filter indent(width=2, indentfirst=0) -%}
      {% include 'sys/pkgs/' ~ app ~ '/cluster/' ~ node ~ '.sls' ignore missing with context %}
    {% endfilter %}{% endfilter %}{% endset %}
    {% if included != '' %}
{{ app }}:
  {{ included }}
    {% endif %}
  {% endfor %}
{% endif %}

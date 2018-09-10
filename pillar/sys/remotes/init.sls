#!jinja|yaml|gpg
{% set subdir = 'remotes' %}
{% set app_group = salt.mt_utils.app_group_from_id(grains['id']) %}
{% for app in [
    'git'] -%}
{% include 'sys/' ~ subdir ~ '/' ~ app ~ '/' ~ app_group ~ '.sls' ignore missing with context %}
{% endfor %}

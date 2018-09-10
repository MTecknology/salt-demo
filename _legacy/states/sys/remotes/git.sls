{% if 'git_remotes' in pillar %}

git_remotes-deps:
  pkg.installed:
    - pkgs:
      - git
      - python-git

{% for remote in pillar['git_remotes'] %}
git_remote-{{ remote['local'] }}:
  git.latest:
    - name: {{ remote['remote'] }}
    - target: {{ remote['local'] }}
    - force_reset: True
    {% if 'branch' in remote %}
    - branch: {{ remote['branch'] }}
    {% endif %}
    {% if 'req_in' in remote %}{% for i in ['require_in', 'watch_in'] %}
    - {{ i }}:
      {% for req in remote['req_in'] %}
      - {{ req }}
      {% endfor %}
    {% endfor %}{% endif %}
    - require:
      - pkg: git_remotes-deps
{% endfor %}

{% endif %} # git_remotes in pillar

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
    - target: {{ remote['local'] }}{% if 'identity' in remote %}
    - identity: {{ remote['identity'] }}{% endif %}{% if 'branch' in remote %}
    - branch: {{ remote['branch'] }}{% endif %}{% if 'revision' in remote %}
    - rev: {{ remote['revision'] }}{% endif %}{% if 'force_clone' in remote %}
    - force_clone: {{ remote['force_clone'] }}{% endif %}{% if 'force_reset' in remote %}
    - force_reset: {{ remote['force_reset'] }}{% endif %}{% if 'depth' in remote %}
    - depth: {{ remote['depth'] }}{%endif %}
    {% if 'req_in' in remote %}
    {% for i in ['require_in', 'watch_in'] %}
    - {{ i }}:
      {% for req in remote['req_in'] %}
      - {{ req }}
      {% endfor %}
    {% endfor %}{% endif %}
    - require:
      - pkg: git_remotes-deps{% for req in remote.get('req', []) %}
      - {{ req }}{% endfor %}
{% endfor %}

{% endif %} # git_remotes in pillar

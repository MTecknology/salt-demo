system-tz:
  file.managed:
    - name: /etc/timezone
    - contents: {{ pillar.get('timezone', 'Etc/UTC') }}

system-tz:
  file.managed:
    - name: /etc/timezone
    - contents: {{ pillar.get('timezone', 'US/Central') }}
  #timezone.system:
  #  - name: {{ pillar.get('timezone', 'America/Chicago') }}
  #  - utc: True

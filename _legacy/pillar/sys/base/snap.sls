# This is used to handle extra directories that need to be backed up.
# If anything beyond a root level directory needs to be backed up, the states
# will also need to be updated.

# Default dirs: /etc, /srv, opt

{% if salt.match.glob('boot*.domain.tld') %}
backup_dirs:
  excl:
    - '/srv/tftp/*'

{% elif salt.match.glob('virt*.domain.tld') %}
backup_dirs:
  incl:
    - '/var/lib'
  excl:
    - '/apt/*'
    - '/aptitude/*'
    - '/dpkg/*'
    - '/lxcfs/*'
    - '/mongodb/*'
    - '/vz/*'

{% elif salt.match.glob('irc*.domain.tld') %}
backup_dirs:
  incl:
    - '/home'

{% elif salt.match.glob('wlc.domain.tld') %}
backup_dirs:
  excl:
    - '/unifi/db/*'

{% endif %}

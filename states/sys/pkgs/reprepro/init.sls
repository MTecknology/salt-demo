{#  MANUAL STEPS
      gpg --gen-key
        :  Requested keysize is 4096 bits
	:  "Apt Server <apt@domain.tld>"
	: apt-get install rng-tools
	: rngd -f --rng-device=/dev/urandom
	: apt-get purge -y libudev1 rng-tools udev
  DEPLOY PACKAGE
  #}

reprepro:
  pkg.installed

/srv/mtrepo/conf:
  file.directory:
    - makedirs: True

/srv/mtrepo/conf/distributions:
  file.managed:
    - contents: |
        Origin: Lustfield Network
        Label: Lustfield Network
        Codename: stretch
        Architectures: amd64
        Components: main
        Description: Internal Apt Repository
        SignWith: E2D7AFBA

/srv/mtrepo/conf/options:
  file.managed:
    - contents: |
        verbose
        basedir /srv/mtrepo
        ask-passphrase

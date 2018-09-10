#!jinja|yaml|gpg
{# Custom SSH Keys for root #}
{% if salt.match.glob('mlweb*') %}
root_ssh_keys:
  mlweb:
      pub: |
          ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC3Vb08Qy8z7vVtbR6Gl72SiCAxM2ydqvpnwje/ALLnBa45deCRaMPtObPbpvDzU0RbL+2wyxUKxm0dOnuv7w== anonymous@salt
      prv: |
          -----BEGIN PGP MESSAGE-----
          Version: GnuPG v1

          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
          -----END PGP MESSAGE-----

{% elif salt.match.glob('salt*') %}
root_ssh_keys:
  salt:
    - pub: |
        ssh-rsa AAAAB3NBkXBgMzTPNL54N+3CQ2jAuNtiYlQrsTiX/E/iTYbj4SpE9EJilScKZYg12CYynQtB7mG0hACTzz0D5Sp8wZBMfJjQKKeFbzIisIeNgVQw6Q== tmp@panther
      prv: |
          -----BEGIN PGP MESSAGE-----
          Version: GnuPG v1

          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
          -----END PGP MESSAGE-----
{% endif %}

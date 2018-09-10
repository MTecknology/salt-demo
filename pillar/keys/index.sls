{# To decrypt:
    gpg --import 03891A765AD085.gpg
    gpg --decrypt saltkeys.tgz.gpg -o saltkeys.tgz #}

keys:

  03891A765AD085.{key,pub}:
    prv: 03891A765AD085
    pub: B1C2B4FD5E3AD929
    owner: Michael Lustfield <michael@domain.tld>
    purpose: Michael Lustfield (personal); Glacier uploads

  AEBE3B8BA35B79.pub:
    prv: AEBE3B8BA35B79
    pub: D42AB7AF5E2BF8
    owner: Salt Master <root@salt.domain.tld>
    purpose: Encrypted pillar data

  CA12CE9AB393E3.key:
    located: files:snapkeys.tgz.gpg
    prv: CA12CE9AB393E3
    pub: 19DB4C0A687B58
    owner: Snap Archives <root@snap.domain.tld>
    purpose: Old key; backup encryption; expired 8/30/2016


files:

  saltkeys.tgz.gpg:
    encrypted_with: keys:03891A765AD085.gpg:pub
    contains: Entire .gnupg/ dir for salt master
    private_key_included: True

  snapkeys.tgz.gpg:
    encrypted_with: keys:03891A765AD085.gpg:pub
    contains: Old keys used to encrypt data uploaded to glacier
    private_key_included: True

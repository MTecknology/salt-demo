iPXE
====

It turns out, ipxe is an amazing thing. Because the firmware is so easy to
build, we can create a simple script embedded into the ipxe boot image and
share that with all devices. Instead of a big pile of stuff served over the
junky tftp protocol, we can just serve one single 64k file.

Build
-----

We build a custom undionly image which has an embedded initial script. This
allows us to prevent boot loops while not needing any special configuration
from the dhcp server.

mtnet.ipxe:

    #!ipxe
    dhcp
    chain http://boot.domain.tld/loader.ipxe

To build the ipxe image:

    sudo apt-get build-essential liblzma-dev git
    git clone git://git.ipxe.org/ipxe.git
    vim mtnet.ipxe # [see above]
    make bin/undionly.kpxe EMBED=mtnet.ipxe

Serve
-----

This 64kb file gets to be the only file served by tftpd. The rest is just
static web content served by a website that could easily become dynamic if
ever needed.

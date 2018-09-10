Snap Backup Solution
====================

Purpose
-------

After experience with other environments and a previous fat finger that erased
an entire infrastructure (all servers, backups, routers, etc.), it was apparent
that proper backup solutions are critical in ALL environments. The goal of snap
was to build a backup solution that was impervious to even the biggest "oh shit"
moments that could come up.

Requirements
------------

1. No server can see backups from other servers
#. The backup server can not access other servers
#. The backup server must create versioned backups (historical archives)
#. No server can access its own historical archive
#. All archives must be uploaded to an off-site location
#. All off-site backups must be stored in a secure location
#. The backup server must be unable to delete backups from an off-site location
#. All off-site backups must be retained for a minimum of three months
#. The backup server must keep two years worth of historical archives
#. The entire solution must be fully automated

Pieces Involved
---------------

* Salt ensures servers have a unique ssh key pair created
* Salt sends public key to salt master
* Salt master generates states to ensure user accounts exist on backup server
* Servers have a cron task to automatically generate backups
* Backup server runs rsnapshot of system backups to location
* Archive location is unavailable to server acconuts
* Backup server uses squashfs to create a copy of archives
* Backup server uses gpg to encrypt the squashfs image
* The private gpg key is encrypted is not present on the backup server
* Backup server uploads encrypted archive to AWS Glacier
* AWS policies prevent backup server from modifying uploaded archives

Considerations
--------------

It might be a better idea to upload to AWS S3 and use policies to automatically
send backups to AWS Glacier after ten days.

Careful consideration needs to be made for:

* What directories are backed up
* What is in the directories that are being backed up
* Is the data being backed up large binary-type data
* How long does it take to upload the encrypted image

Documentation
-------------

https://michael.domain.tld/linux/long-term-secure-backups

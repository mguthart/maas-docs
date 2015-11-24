### Navigation

-   [next](networks.html "Networks")
-   [previous](hardware-enablement-kernels.html "Using hardware-enablement kernels")
    |
-   [MAAS 1.8 documentation](index.html) »

Local Mirroring of Boot Images[¶](#local-mirroring-of-boot-images "Permalink to this headline")
===============================================================================================

Boot images are delivered to MAAS via the simplestreams protocol. It is
useful in some situations, such as testing, to mirror the images locally
so that you don’t need to repeatedly pull them down over a slower
Internet link.

First, install the required packages on the host where you wish to store
the mirrored images:

    $ sudo apt-get install simplestreams ubuntu-cloudimage-keyring apache2

Now you can pull the images over using the mirroring tools for
simplestreams. This example gets the daily trusty (14.04) and precise
(12.04) images for the amd64/generic and amd64/hwe-t architectures:

    $ sudo sstream-mirror --keyring=/usr/share/keyrings/ubuntu-cloudimage-keyring.gpg http://maas.ubuntu.com/images/ephemeral-v2/daily/ /var/www/html/maas/images/ephemeral-v2/daily 'arch=amd64' 'subarch~(generic|hwe-t)' 'release~(trusty|precise)' --max=1

This may take a while as hundreds of megabytes will be downloaded.

The images will be written to the local disk and you can verify their
presence by browsing to
`http://<server>/maas/images/ephemeral-v2/daily/streams/v1/index.sjson`{.docutils
.literal} (replace `<server>`{.docutils .literal} with your own server’s
name).

It is a good idea to configure a `cron`{.docutils .literal} job to
repeat this import on a regular basis to keep your mirror up-to-date.

Configuring MAAS to use the local mirror[¶](#configuring-maas-to-use-the-local-mirror "Permalink to this headline")
-------------------------------------------------------------------------------------------------------------------

You can do this using the API or the web UI. To do this via the API you
can use the `maas`{.docutils .literal} (see [*Command Line
Interface*](maascli.html)) command, logged in as the admin user:

    $ maas <profile> boot-sources create url=http://<server>keyring_filename=/usr/share/keyrings/ubuntu-cloudimage-keyring.gpg

And then initiate the download with:

    $ maas <profile> boot-resources import

See [*Boot images import configuration*](bootsources.html) for more
detail.

In the web UI, browse to the Settings tab as the admin user and scroll
down to the “Boot Images” section. There you will find input boxes for
the Sync URL and the keyring path, which should be set as the values in
the API example above.

The import is initiated by browsing to the Images tab and following the
instructions on that page.

[![MAAS
logo](_static/maas-logo-200.png)](index.html "MAAS Documentation Homepage")

MAAS {style="text-align:center;"}
----

Metal As A Service.

\
 \

-   [Local Mirroring of Boot Images](#)
    -   [Configuring MAAS to use the local
        mirror](#configuring-maas-to-use-the-local-mirror)

### Related Topics

-   [Documentation overview](index.html)
    -   Previous: [Using hardware-enablement
        kernels](hardware-enablement-kernels.html "previous chapter")
    -   Next: [Networks](networks.html "next chapter")

### This Page

-   [Show Source](_sources/sstreams-mirror.txt)

### Quick search

Enter search terms or a module, class or function name.

### Navigation

-   [next](networks.html "Networks")
-   [previous](hardware-enablement-kernels.html "Using hardware-enablement kernels")
    |
-   [MAAS 1.8 documentation](index.html) »

© Copyright 2012-2015, MAAS Developers. Ubuntu and Canonical are
registered trademarks of [Canonical Ltd](http://canonical.com).

Revision 4036 (2015-08-05 16:30:57 +0000). Documentation generation
date: 2015-08-12 22:30:33 +0100.

### Navigation

-   [next](nodes.html "Adding nodes to the system")
-   [previous](ipv6.html "Managing IPv6 Networks") |
-   [MAAS 1.8 documentation](index.html) »

Boot images import configuration[¶](#boot-images-import-configuration "Permalink to this headline")
===================================================================================================

The configuration for where a region downloads its images is defined by
a set of “sources”. Each “source” defines a Simplestreams repository
location (`url`{.docutils .literal}) from which images can be downloaded
and a `keyring_filename`{.docutils .literal} (or
`keyring_data`{.docutils .literal}) for validating index and image
signatures from that location. For each source, you can define a series
of filters (`selections`{.docutils .literal}) specifying which images
should be downloaded from that source.

The following example use the MAAS CLI to list the boot sources and the
boot source selections. Assuming the CLI `PROFILE`{.docutils .literal}
is the name of the profile under which you’re logged in to the server:

    $ maas $PROFILE boot-sources read
    [
        {
            "url": "http://maas.ubuntu.com/images/ephemeral-v2/releases/",
            "keyring_data": "",
            "resource_uri": "<url omitted for readability>",
            "keyring_filename": "/usr/share/keyrings/ubuntu-cloudimage-keyring.gpg",
            "id": 1
        }
    ]

    $ maas $PROFILE boot-source-selections read 1
    [
        {
            "labels": [
                "release"
            ],
            "arches": [
                "amd64"
            ],
            "subarches": [
                "*"
            ],
            "release": "trusty",
            "id": 1,
            "resource_uri": "<url omitted for readability>"
        }
    ]

Restricting the images being downloaded[¶](#restricting-the-images-being-downloaded "Permalink to this headline")
-----------------------------------------------------------------------------------------------------------------

Let’s say you want to add a previous LTS release to images being
downloaded. Starting from the configuration described above, you would
need to:

-   Add the “Precise” selection (the selection ‘1’ of the source ‘1’):

        $ maas $PROFILE boot-source-selection create 1 os="ubuntu" release="precise" arches="amd64" subarches="*" labels="*"

Downloading the images from a different source[¶](#downloading-the-images-from-a-different-source "Permalink to this headline")
-------------------------------------------------------------------------------------------------------------------------------

Let’s say you want to import the images from a different location. You
would need to to change the source’s url and keyring:

    $ maas $PROFILE boot-source update 1 url="http://custom.url" keyring_filename="" keyring_data@=./custom_keyring_file
    {
        "url": "http://custom.url/",
        "keyring_data": "<base64 encoded content of `custom_keyring_file`>",
        "resource_uri": "<url omitted for readability>",
        "keyring_filename": "",
        "id": 1
    }

Adding a source[¶](#adding-a-source "Permalink to this headline")
-----------------------------------------------------------------

You can also add a new source:

    $ maas $PROFILE boot-sources create url=http://my.url keyring_filename="" keyring_data@=./ custom_keyring_file
    {
        "url": "http://my.url/",
        "keyring_data": "ZW1wdHkK",
        "keyring_filename": "",
        "id": 2,
        "resource_uri": "<url omitted for readability>"
    }

Inside that newly created source (‘2’) you can add selections:

    $ maas $PROFILE boot-source-selections create 2 os="ubuntu" release="trusty" arches="amd64" subarches="*" labels='*'
    {
        "labels": ["*"],
        "arches": ["amd64"],
        "subarches": ["*"],
        "release": "trusty",
        "id": 3,
        "resource_uri": "<url omitted for readability>"
    }

Deleting a source[¶](#deleting-a-source "Permalink to this headline")
---------------------------------------------------------------------

Let’s say you need to delete the newly added source.

To delete the source:

    $ maas $PROFILE boot-source delete 2

[![MAAS
logo](_static/maas-logo-200.png)](index.html "MAAS Documentation Homepage")

MAAS {style="text-align:center;"}
----

Metal As A Service.

\
 \

-   [Boot images import configuration](#)
    -   [Restricting the images being
        downloaded](#restricting-the-images-being-downloaded)
    -   [Downloading the images from a different
        source](#downloading-the-images-from-a-different-source)
    -   [Adding a source](#adding-a-source)
    -   [Deleting a source](#deleting-a-source)

### Related Topics

-   [Documentation overview](index.html)
    -   Previous: [Managing IPv6 Networks](ipv6.html "previous chapter")
    -   Next: [Adding nodes to the system](nodes.html "next chapter")

### This Page

-   [Show Source](_sources/bootsources.txt)

### Quick search

Enter search terms or a module, class or function name.

### Navigation

-   [next](nodes.html "Adding nodes to the system")
-   [previous](ipv6.html "Managing IPv6 Networks") |
-   [MAAS 1.8 documentation](index.html) »

© Copyright 2012-2015, MAAS Developers. Ubuntu and Canonical are
registered trademarks of [Canonical Ltd](http://canonical.com).

Revision 4036 (2015-08-05 16:30:57 +0000). Documentation generation
date: 2015-08-12 22:30:33 +0100.

### Navigation

-   [next](devices.html "Devices")
-   [previous](kernel-options.html "Setting kernel boot options") |
-   [MAAS 1.8 documentation](index.html) »

Installing Ubuntu and deploying nodes[¶](#installing-ubuntu-and-deploying-nodes "Permalink to this headline")
=============================================================================================================

Once a node has been accepted into MAAS and is ready for use, users can
deploy services to that node.

Prior to deployment, MAAS is responsible for:

1.  Powering up the node.
2.  Installing Ubuntu on the node.
3.  Installing the user’s SSH keys on the node.

Once these steps have been completed, the node is ready to have services
deployed to it, either manually or by using a tool like
[Juju](http://juju.ubuntu.com).

There are two ways to install Ubuntu on a node:

1.  [*The Debian installer*](#debian-installer).
2.  [*The fast installer*](#fast-installer).

The Debian Installer[¶](#the-debian-installer "Permalink to this headline")
---------------------------------------------------------------------------

The Debian Installer installs Ubuntu on a node in exactly the same way
as you would install it manually: using the [Debian
Installer](http://www.debian.org/devel/debian-installer/). Answers to
the questions asked by the installer are provided in a ‘preseed’ file.
For more information on preseed files, see the [*Additional
Configuration*](configure.html#preseed) page.

The Debian installer is not enabled by default. To enable it for a node
that’s been configured to use the fast installer, visit the node’s page
as an administrator and click the `Use the Debian installer`{.docutils
.literal} button.

![](_images/node-page-use-default-installer.png)

To set multiple nodes to use the Debian installer, select the
`Mark nodes as using the Debian installer`{.docutils .literal} option
from the bulk action menu on the `Nodes`{.docutils .literal} page in the
MAAS web UI.

Because it installs Ubuntu from scratch, downloading packages as
required, the Debian installer is slower than the [*fast
installer*](#fast-installer).

The fast installer[¶](#the-fast-installer "Permalink to this headline")
-----------------------------------------------------------------------

The fast installer is, as the name suggests, a means of installing
Ubuntu on a node more quickly than would be possible using the [*Debian
installer*](#debian-installer).

The fast installer is enabled by default for newly enlisted nodes.

![](_images/node-page-use-fast-installer.png)

To set multiple nodes to use the fast installer, select the
`Mark nodes as using the fast installer`{.docutils .literal} option from
the bulk action menu on the `Nodes`{.docutils .literal} page in the MAAS
web UI.

The fast installer copies a pre-built Ubuntu image to the node, with all
the packages installed that would be normally found in an Ubuntu
installation.

The fast installer is much quicker than the Debian installer, but has
the disadvantage that it’s less easy to configure a node at install
time, since the fast installer doesn’t use a [*preseed
file*](configure.html#preseed). In addition, the packages that are
initially installed on a fast-installed node need updating manually,
since they are part of the installation image and not downloaded fresh
from an apt repository.

For more information about the fast installer, see the [curtin
project](https://launchpad.net/curtin) on Launchpad.

[![MAAS
logo](_static/maas-logo-200.png)](index.html "MAAS Documentation Homepage")

MAAS {style="text-align:center;"}
----

Metal As A Service.

\
 \

-   [Installing Ubuntu and deploying nodes](#)
    -   [The Debian Installer](#the-debian-installer)
    -   [The fast installer](#the-fast-installer)

### Related Topics

-   [Documentation overview](index.html)
    -   Previous: [Setting kernel boot
        options](kernel-options.html "previous chapter")
    -   Next: [Devices](devices.html "next chapter")

### This Page

-   [Show Source](_sources/installing-ubuntu.txt)

### Quick search

Enter search terms or a module, class or function name.

### Navigation

-   [next](devices.html "Devices")
-   [previous](kernel-options.html "Setting kernel boot options") |
-   [MAAS 1.8 documentation](index.html) »

© Copyright 2012-2015, MAAS Developers. Ubuntu and Canonical are
registered trademarks of [Canonical Ltd](http://canonical.com).

Revision 4036 (2015-08-05 16:30:57 +0000). Documentation generation
date: 2015-08-12 22:30:33 +0100.

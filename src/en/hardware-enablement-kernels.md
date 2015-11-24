### Navigation

-   [next](sstreams-mirror.html "Local Mirroring of Boot Images")
-   [previous](nodes.html "Adding nodes to the system") |
-   [MAAS 1.8 documentation](index.html) »

Using hardware-enablement kernels[¶](#using-hardware-enablement-kernels "Permalink to this headline")
=====================================================================================================

Note

This feature is available in MAAS versions 1.5 and above.

MAAS allows you to use hardware enablement kernels when booting nodes
that require them.

What are hardware-enablement kernels?[¶](#what-are-hardware-enablement-kernels "Permalink to this headline")
------------------------------------------------------------------------------------------------------------

Brand new hardware gets released all the time. We want that hardware to
work well with Ubuntu and MAAS, even if it was released after the latest
release of MAAS or Ubuntu. Hardware Enablement (HWE) is all about
keeping pace with the new hardware.

Ubuntu’s solution to this is to offer newer kernels for older releases.
There are at least two kernels on offer for Ubuntu releases: the
“generic” kernel – i.e. the kernel released with the current series –
and the Hardware Enablement kernel, which is the most recent kernel
release.

There are separate HWE kernels for each release of Ubuntu, referred to
as `hwe-<release letter>`{.docutils .literal}. So, the 14.04 / Trusty
Tahr HWE kernel is called `hwe-t`{.docutils .literal}, the 12.10 /
Quantal Quetzal HWE kernel is called `hwe-q`{.docutils .literal} and so
on. This allows you to use newer kernels with older releases, for
example running Precise with a Saucy (hwe-s) kernel.

For more information see the [LTS Enablement
Stack](https://wiki.ubuntu.com/Kernel/LTSEnablementStack) page on the
Ubuntu wiki.

Booting hardware-enablement kernels[¶](#booting-hardware-enablement-kernels "Permalink to this headline")
---------------------------------------------------------------------------------------------------------

MAAS imports hardware-enablement kernels along with its generic boot
images, but as different “sub-architectures” to the default “generic”
one.

So, for example, a common server might have architecture and
sub-architecture of `amd64/generic`{.docutils .literal}, but some newer
system chassis which doesn’t become fully functional with the default
kernel for Ubuntu 14.04 Trusty Tahr, for example, may require
`amd64/hwe-t`{.docutils .literal}.

The quickest way to make a node use a hardware-enablement kernel is by
using the MAAS command, like this:

    $ maas <profile-name> node update <system-id>
      architecture=amd64/hwe-t

If you specify an architecture that doesn’t exist (e.g.
`amd64/hwe-zz`{.docutils .literal}), the `maas`{.docutils .literal}
command will return an error.

It’s also possible to use HWE kernels from the MAAS web UI, by visiting
the Node’s page and clicking `Edit node`{.docutils .literal}. Under the
Architecture field, you will be able to select any HWE kernels that have
been imported onto that node’s cluster controller.

[![MAAS
logo](_static/maas-logo-200.png)](index.html "MAAS Documentation Homepage")

MAAS {style="text-align:center;"}
----

Metal As A Service.

\
 \

-   [Using hardware-enablement kernels](#)
    -   [What are hardware-enablement
        kernels?](#what-are-hardware-enablement-kernels)
    -   [Booting hardware-enablement
        kernels](#booting-hardware-enablement-kernels)

### Related Topics

-   [Documentation overview](index.html)
    -   Previous: [Adding nodes to the
        system](nodes.html "previous chapter")
    -   Next: [Local Mirroring of Boot
        Images](sstreams-mirror.html "next chapter")

### This Page

-   [Show Source](_sources/hardware-enablement-kernels.txt)

### Quick search

Enter search terms or a module, class or function name.

### Navigation

-   [next](sstreams-mirror.html "Local Mirroring of Boot Images")
-   [previous](nodes.html "Adding nodes to the system") |
-   [MAAS 1.8 documentation](index.html) »

© Copyright 2012-2015, MAAS Developers. Ubuntu and Canonical are
registered trademarks of [Canonical Ltd](http://canonical.com).

Revision 4036 (2015-08-05 16:30:57 +0000). Documentation generation
date: 2015-08-12 22:30:33 +0100.

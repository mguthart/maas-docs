### Navigation

-   [next](installing-ubuntu.html "Installing Ubuntu and deploying nodes")
-   [previous](networks.html "Networks") |
-   [MAAS 1.8 documentation](index.html) »

Setting kernel boot options[¶](#setting-kernel-boot-options "Permalink to this headline")
=========================================================================================

MAAS is able to send specific kernel options to booting nodes on both a
global basis and a per-node basis.

Global kernel options[¶](#global-kernel-options "Permalink to this headline")
-----------------------------------------------------------------------------

As an admin, click on the gear icon at the top right and scroll down to
the Global Kernel Parameters section, as shown here:

![](_images/global_kernel_opts.png)

Whatever you set here is sent as-is to all booting nodes.

Per-node kernel options[¶](#per-node-kernel-options "Permalink to this headline")
---------------------------------------------------------------------------------

Per-node kernel options are set using tags. The easiest way of doing
this is to use the `maas`{.docutils .literal} command. You will need to
[*be logged in to the API first*](maascli.html#api-key) and then you can
add a tag which has its `kernel_opts`{.docutils .literal} value set,
like this:

    $ maas maas tags new name='nomodeset' \
      comment='nomodeset kernel option' kernel_opts='nomodeset vga'

Once the tag is defined, you can add it to a node or nodes:

    $ maas maas tag update-nodes nomodeset add=<system_id_1> \
      add=<system_id_2>

Note

Any per-node kernel options set will completely override the global
options. If multiple tags attached to a node have the kernel\_opts
defined, the first one ordered by name is used.

[![MAAS
logo](_static/maas-logo-200.png)](index.html "MAAS Documentation Homepage")

MAAS {style="text-align:center;"}
----

Metal As A Service.

\
 \

-   [Setting kernel boot options](#)
    -   [Global kernel options](#global-kernel-options)
    -   [Per-node kernel options](#per-node-kernel-options)

### Related Topics

-   [Documentation overview](index.html)
    -   Previous: [Networks](networks.html "previous chapter")
    -   Next: [Installing Ubuntu and deploying
        nodes](installing-ubuntu.html "next chapter")

### This Page

-   [Show Source](_sources/kernel-options.txt)

### Quick search

Enter search terms or a module, class or function name.

### Navigation

-   [next](installing-ubuntu.html "Installing Ubuntu and deploying nodes")
-   [previous](networks.html "Networks") |
-   [MAAS 1.8 documentation](index.html) »

© Copyright 2012-2015, MAAS Developers. Ubuntu and Canonical are
registered trademarks of [Canonical Ltd](http://canonical.com).

Revision 4036 (2015-08-05 16:30:57 +0000). Documentation generation
date: 2015-08-12 22:30:33 +0100.

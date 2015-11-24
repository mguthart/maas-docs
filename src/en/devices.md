### Navigation

-   [next](os-support.html "Operating Systems Support")
-   [previous](installing-ubuntu.html "Installing Ubuntu and deploying nodes")
    |
-   [MAAS 1.8 documentation](index.html) »

Devices[¶](#devices "Permalink to this headline")
=================================================

Note

This feature is available in MAAS versions 1.8 and above. If you’re
writing a client application, you can check if MAAS supports this
feature via the web API; see the documentation for the
`devices-management`{.docutils .literal} capability
[*here*](capabilities.html#cap-devices-management).

In addition to nodes, a MAAS cluster controller can manage *devices*.
Devices represent non-installable machines. This feature can be used to
track routers, virtual machines, etc. within MAAS.

Same as nodes, devices can be assigned IP addresses and DNS names. IP
addresses can be fixed, in which case the device should be configured to
use the defined IP address, or dynamic, in which case the device can
obtain an IP address from the MAAS DHCP server and will receive the
configured IP address.

Devices can also be assigned a parent node and will be automatically
deleted (along with all the IP address reservations associated with it)
when the parent node is deleted or released. This is designed to model
and manage the virtual machines or containers running on a MAAS-deployed
node.

[![MAAS
logo](_static/maas-logo-200.png)](index.html "MAAS Documentation Homepage")

MAAS {style="text-align:center;"}
----

Metal As A Service.

\
 \

### Related Topics

-   [Documentation overview](index.html)
    -   Previous: [Installing Ubuntu and deploying
        nodes](installing-ubuntu.html "previous chapter")
    -   Next: [Operating Systems
        Support](os-support.html "next chapter")

### This Page

-   [Show Source](_sources/devices.txt)

### Quick search

Enter search terms or a module, class or function name.

### Navigation

-   [next](os-support.html "Operating Systems Support")
-   [previous](installing-ubuntu.html "Installing Ubuntu and deploying nodes")
    |
-   [MAAS 1.8 documentation](index.html) »

© Copyright 2012-2015, MAAS Developers. Ubuntu and Canonical are
registered trademarks of [Canonical Ltd](http://canonical.com).

Revision 4036 (2015-08-05 16:30:57 +0000). Documentation generation
date: 2015-08-12 22:30:33 +0100.

### Navigation

-   [next](ipv6.html "Managing IPv6 Networks")
-   [previous](cluster-configuration.html "Cluster Configuration") |
-   [MAAS 1.8 documentation](index.html) »

Static IPs[¶](#static-ips "Permalink to this headline")
=======================================================

Note

This feature is available in MAAS versions 1.6 and above. If you’re
writing a client application, you can check if MAAS supports this
feature via the web API; see the documentation for the
`static-ipaddresses`{.docutils .literal} capability
[*here*](capabilities.html#cap-static-ipaddresses).

Previously, MAAS relied on the DHCP server to allocate its own IP
addresses to nodes, using the IP range defined on the relevant cluster
interface. This was found to be unreliable since the IPs were only known
once the node had booted and requested an address, and had race
conditions when the lease expired and another machine was looking for
its own IP.

MAAS now defines an additional range on the cluster for static IPs that
are allocated by MAAS itself (see [*Cluster
Configuration*](cluster-configuration.html) for more information about
this).

In normal operation, MAAS will automatically choose and allocate a
static IP to any node network interfaces where it knows on which cluster
interface that node interface is connected.

The [*MAAS API*](api.html) contains functions to request additional
static IPs, which are summarised here:

Sticky IPs[¶](#sticky-ips "Permalink to this headline")
-------------------------------------------------------

Synopsis:
:   `POST /api/1.0/nodes/{system_id}/`{.docutils .literal}
    `op=claim_sticky_ip_address`{.docutils .literal}

Normally, IPs are released back into the pool of available IPs once a
node is released by a user. A “Sticky” IP is one which is allocated to
an interface on a node that does not change unless the sticky IP is
removed. This enables more predictable IPs at the cost of wasting IPs
when the node is not in use.

Unmanaged User-allocated IPs[¶](#unmanaged-user-allocated-ips "Permalink to this headline")
-------------------------------------------------------------------------------------------

Synopsis:
:   `GET /api/1.0/ipaddresses/`{.docutils .literal}

    `POST /api/1.0/ipaddresses/`{.docutils .literal}
    `op=release`{.docutils .literal}

    `POST /api/1.0/ipaddresses/`{.docutils .literal}
    `op=reserve`{.docutils .literal}

This API allows users to request an ad-hoc IP address for use in any way
they see fit. The IP is not tied to any node in MAAS and is guaranteed
not to be in use by MAAS itself.

See the full [*MAAS API*](api.html) documentation for precise technical
details.

[![MAAS
logo](_static/maas-logo-200.png)](index.html "MAAS Documentation Homepage")

MAAS {style="text-align:center;"}
----

Metal As A Service.

\
 \

-   [Static IPs](#)
    -   [Sticky IPs](#sticky-ips)
    -   [Unmanaged User-allocated IPs](#unmanaged-user-allocated-ips)

### Related Topics

-   [Documentation overview](index.html)
    -   Previous: [Cluster
        Configuration](cluster-configuration.html "previous chapter")
    -   Next: [Managing IPv6 Networks](ipv6.html "next chapter")

### This Page

-   [Show Source](_sources/static-ips.txt)

### Quick search

Enter search terms or a module, class or function name.

### Navigation

-   [next](ipv6.html "Managing IPv6 Networks")
-   [previous](cluster-configuration.html "Cluster Configuration") |
-   [MAAS 1.8 documentation](index.html) »

© Copyright 2012-2015, MAAS Developers. Ubuntu and Canonical are
registered trademarks of [Canonical Ltd](http://canonical.com).

Revision 4036 (2015-08-05 16:30:57 +0000). Documentation generation
date: 2015-08-12 22:30:33 +0100.

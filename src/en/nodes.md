### Navigation

-   [next](hardware-enablement-kernels.html "Using hardware-enablement kernels")
-   [previous](bootsources.html "Boot images import configuration") |
-   [MAAS 1.8 documentation](index.html) »

Adding nodes to the system[¶](#adding-nodes-to-the-system "Permalink to this headline")
=======================================================================================

Now that the MAAS controller is running, we need to make the nodes aware
of MAAS and vice-versa. If you have set up DHCP correctly, and your
nodes can boot via
[PXE](http://en.wikipedia.org/wiki/Preboot_Execution_Environment) then
things really couldn’t be much easier and you can use [*the automatic
discovery procedure*](#auto-enlist). You do not need to install Ubuntu
on nodes that you wish to add to MAAS prior to enlistment.

To learn more about setting up DHCP, read the [*cluster configuration
documentation*](cluster-configuration.html#cluster-configuration).

Automatic Discovery[¶](#automatic-discovery "Permalink to this headline")
-------------------------------------------------------------------------

With nodes set to boot from a PXE image, they will start, look for a
DHCP server, receive the PXE boot details, boot the image, contact the
MAAS server and shut down.

During this process, the MAAS server will be passed information about
the node, including the architecture, MAC address and other details
which will be stored in the database of nodes. You can accept and
commission the nodes via the web interface. When the nodes have been
accepted the selected series of Ubuntu will be installed.

To save time, you can also accept and commission all nodes from the
commandline. This requires that you first log in with the API key, which
[*you can retrieve from the web interface*](maascli.html#api-key):

    $ maas maas nodes accept-all

Manually add nodes[¶](#manually-add-nodes "Permalink to this headline")
-----------------------------------------------------------------------

If you know the MAC address of a node, you can manually enter details
about the node through the web interface. Click the `Add Node`{.docutils
.literal} button to be taken to the “Add Node” form:

![](_images/add-node.png)

Virtual machine nodes[¶](#virtual-machine-nodes "Permalink to this headline")
-----------------------------------------------------------------------------

If you’re setting up virtual machines to use as nodes with MAAS, you
need to configure the power type as `virsh`{.docutils .literal}. For
MAAS to be able to use virsh, make sure you have the
`libvirt-bin`{.docutils .literal} package installed.

The virsh power type takes two parameters:

Power ID
:   The Power ID is the name of the virtual machine shown by
    `sudo virsh list --all`{.docutils .literal}
Address
:   This is a libvirt connection string, such as
    `qemu+ssh://ubuntu@10.0.0.2/system`{.docutils .literal} or
    `qemu:///system`{.docutils .literal}

![](_images/virsh-config.png)

If you want to use ssh you’ll need to generate a ssh key pair for the
maas user. By default there is no home directory created for the maas
user:

    $ sudo mkdir /home/maas
    $ sudo chown maas:maas /home/maas

Add a login shell for the maas user:

    $ sudo chsh -s /bin/bash maas

Become the maas user and generate a SSH keypair:

    $ sudo su - maas
    $ ssh-keygen

Then add the public key to `/ubuntu/.ssh/authorized_keys`{.docutils
.literal} on the vm server so virsh can use ssh without a password:

    $ ssh-copy-id -i ~/.ssh/id_rsa ubuntu@10.0.0.2

As the maas user, test virsh commands against libvirt at 10.0.0.2:

    $ virsh -c qemu+ssh://ubuntu@10.0.0.2/system list --all

[![MAAS
logo](_static/maas-logo-200.png)](index.html "MAAS Documentation Homepage")

MAAS {style="text-align:center;"}
----

Metal As A Service.

\
 \

-   [Adding nodes to the system](#)
    -   [Automatic Discovery](#automatic-discovery)
    -   [Manually add nodes](#manually-add-nodes)
    -   [Virtual machine nodes](#virtual-machine-nodes)

### Related Topics

-   [Documentation overview](index.html)
    -   Previous: [Boot images import
        configuration](bootsources.html "previous chapter")
    -   Next: [Using hardware-enablement
        kernels](hardware-enablement-kernels.html "next chapter")

### This Page

-   [Show Source](_sources/nodes.txt)

### Quick search

Enter search terms or a module, class or function name.

### Navigation

-   [next](hardware-enablement-kernels.html "Using hardware-enablement kernels")
-   [previous](bootsources.html "Boot images import configuration") |
-   [MAAS 1.8 documentation](index.html) »

© Copyright 2012-2015, MAAS Developers. Ubuntu and Canonical are
registered trademarks of [Canonical Ltd](http://canonical.com).

Revision 4036 (2015-08-05 16:30:57 +0000). Documentation generation
date: 2015-08-12 22:30:33 +0100.

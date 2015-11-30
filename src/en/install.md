Title: Installing MAAS | MAAS Documentation

# Installing MAAS


There are two main ways to install MAAS:

> -   [*From Ubuntu’s package archive on an existing Ubuntu
>     install.*](#pkg-install)
> -   [*As a fresh install from Ubuntu Server install
>     media.*](#disc-install)

If you are interested in testing the latest development version you can
also check out the very latest source and build MAAS — see the [*hacking
guide*](hacking.html) — or use the [Testing
PPA](https://launchpad.net/~maas-maintainers/+archive/ubuntu/testing) or
the [Daily
PPA](https://launchpad.net/~maas-maintainers/+archive/ubuntu/dailybuilds).
Note that these PPAs contain development versions of MAAS that are
potentially unstable, so use with caution.

## Installing MAAS from the archive

Installing MAAS from packages is thankfully straightforward. There are
actually several packages that go into making up a working MAAS install,
but for convenience, many of these have been gathered into a virtual
package called ‘maas’ which will install the necessary components for a
‘seed cloud’, that is a single server that will directly control a group
of nodes. The main packages are:

> -   `maas`{.docutils .literal} - seed cloud setup, which includes both
>     the region controller and the cluster controller below.
> -   `maas-region-controller`{.docutils .literal} - includes the web
>     UI, API and database.
> -   `maas-cluster-controller`{.docutils .literal} - controls a group
>     (“cluster”) of nodes including DHCP management.
> -   `maas-dhcp`{.docutils .literal}/`maas-dns`{.docutils .literal} -
>     required when managing dhcp/dns.

If you need to separate these services or want to deploy an additional
cluster controller, you should install the corresponding packages
individually (see [*the description of a typical
setup*](orientation.html#setup) for more background on how a typical
hardware setup might be arranged).

There are two suggested additional packages ‘maas-dhcp’ and ‘maas-dns’.
These set up MAAS-controlled DHCP and DNS services which greatly
simplify deployment if you are running a typical setup where the MAAS
controller can run the network (Note: These **must** be installed if you
later set the options in the web interface to have MAAS manage
DHCP/DNS). If you need to integrate your MAAS setup under an existing
DHCP setup, see [*Manual DHCP
configuration*](configure.html#manual-dhcp)

Note

A more up-to-date MAAS is available for the most recent Ubuntu LTS
release in the Canonical cloud archive. You can activate the archive
with `sudo add-apt-repository cloud-archive:tools`{.docutils .literal}.
Using packages from this archive is recommended as it contains important
fixes and new features that are not always available in the Ubuntu
archive.

## Install packages

At the command line, type:

```bash
sudo apt-get install maas maas-dhcp maas-dns
```

You will see a list of packages and a confirmation message to proceed.
The exact list will obviously depend on what you already have installed
on your server, but expect to add about 200MB of files.

The configuration for the MAAS controller will automatically run and pop
up this config screen:

![](../../media/install_cluster-config.png)

Here you will need to enter the hostname for where the region controller
can be contacted. In many scenarios, you may be running the region
controller (i.e. the web and API interface) from a different network
address, for example where a server has several network interfaces.

Once the configuration scripts have run you should see this message
telling you that the system is ready to use:

![](../media/install_controller-config.png)

The web server is started last, so you have to accept this message
before the service is run and you can access the Web interface. Then
there are just a few more setup steps [*Post-Install
tasks*](#post-install)

## Installing MAAS from Ubuntu Server boot media

If you are installing MAAS as part of a fresh install it is easiest to
choose the “Multiple Server install with MAAS” option from the installer
and have pretty much everything set up for you. Boot from the Ubuntu
Server media and you will be greeted with the usual language selection
screen:

![](../media/install_01.png)

On the next screen, you will see there is an entry in the menu called
“Multiple server install with MAAS”. Use the cursor keys to select this
and then press Enter.

![](../media/install_02.png)

The installer then runs through the usual language and keyboard options.
Make your selections using Tab/Cursor keys/Enter to proceed through the
install. The installer will then load various drivers, which may take a
moment or two.

![](../media/install_03.png)

The next screen asks for the hostname for this server. Choose something
appropriate for your network.

![](../media/install_04.png)

Finally we get to the MAAS part! Here there are just two options. We
want to “Create a new MAAS on this server” so go ahead and choose that
one.

![](../media/install_05.png)

The install now continues as usual. Next you will be prompted to enter a
username. This will be the admin user for the actual server that MAAS
will be running on (not the same as the MAAS admin user!)

![](../media/install_06.png)

As usual you will have the chance to encrypt your home directory.
Continue to make selections based on whatever settings suit your usage.

![](../media/install_07.png)

After making selections and partitioning storage, the system software
will start to be installed. This part should only take a few minutes.

![](../media/install_09.png)

Various packages will now be configured, including the package manager
and update manager. It is important to set these up appropriately so you
will receive timely updates of the MAAS server software, as well as
other essential services that may run on this server.

![](../media/install_10.png)

The configuration for MAAS will ask you to configure the host address of
the server. This should be the IP address you will use to connect to the
server (you may have additional interfaces e.g. to run node subnets)

![](../media/install_cluster-config.png)

The next screen will confirm the web address that will be used to the
web interface.

![](../media/install_controller-config.png)

After configuring any other packages the installer will finally come to
and end. At this point you should eject the boot media.

![](../media/install_14.png)

After restarting, you should be able to login to the new server with the
information you supplied during the install. The MAAS software will run
automatically.

![](../media/install_15.png)

**NOTE:** The maas-dhcp and maas-dns packages should be installed by
default, but on older releases of MAAS they won’t be. If you want to
have MAAS run DHCP and DNS services, you should install these packages.
Check whether they are installed with:

```bash
dpkg -l maas-dhcp maas-dns
```

If they are missing, then:

```bash
sudo apt-get install maas-dhcp maas-dns
```

And then proceed to the post-install setup below.

## Post-Install tasks

Your MAAS is now installed, but there are a few more things to be done.
If you now use a web browser to connect to the region controller, you
should see that MAAS is running, but there will also be some errors on
the screen:

![](../media/install_web-init.png)

The on screen messages will tell you that there are no boot images
present, and that you can’t login because there is no admin user.

Create a superuser account[¶](#create-a-superuser-account "Permalink to this headline")
---------------------------------------------------------------------------------------

Once MAAS is installed, you’ll need to create an administrator account:

    $ sudo maas-region-admin createadmin --username=root --email=MYEMAIL@EXAMPLE.COM

Substitute your own email address for
[MYEMAIL@EXAMPLE.COM](mailto:MYEMAIL%40EXAMPLE.COM). You may also use a
different username for your administrator account, but “root” is a
common convention and easy to remember. The command will prompt for a
password to assign to the new user.

You can run this command again for any further administrator accounts
you may wish to create, but you need at least one.

Log in on the server[¶](#log-in-on-the-server "Permalink to this headline")
---------------------------------------------------------------------------

Looking at the region controller’s main web page again, you should now
see a login screen. Log in using the user name and password which you
have just created.

![](../media/install-login.png)

Import the boot images[¶](#import-the-boot-images "Permalink to this headline")
-------------------------------------------------------------------------------

Since version 1.7, MAAS stores the boot images in the region
controller’s database, from where the cluster controllers will
synchronise with the region and pull images from the region to the
cluster’s local disk. This process is automatic and MAAS will check for
and download new Ubuntu images every hour.

However, on a new installation you’ll need to start the import process
manually once you have set up your MAAS region controller. There are two
ways to start the import: through the web user interface, or through the
remote API.

To do it in the web user interface, go to the Images tab, check the
boxes to say which images you want to import, and click the “Import
images” button at the bottom of the Ubuntu section.

![](../media/import-images.png)

A message will appear to let you know that the import has started, and
after a while, the warnings about the lack of boot images will
disappear.

It may take a long time, depending on the speed of your Internet
connection for import process to complete, as the images are several
hundred megabytes. The import process will only download images that
have changed since last import. You can check the progress of the import
by hovering over the spinner next to each image.

The other way to start the import is through the [*region-controller
API*](api.html#region-controller-api), which you can invoke most
conveniently through the [*command-line interface*](maascli.html#cli).

To do this, connect to the MAAS API using the “maas” command-line
client. See [*Logging in*](maascli.html#api-key) for how to get set up
with this tool. Then, run the command:

```bash
maas my-maas-session boot-resources import
```
(Substitute a different profile name for ‘my-maas-session’ if you have
named yours something else.) This will initiate the download, just as if
you had clicked “Import images” in the web user interface.

By default, the import is configured to download the most recent LTS
release only for the amd64 architecture. Although this should suit most
needs, you can change the selections on the Images tab, or over the API.
Read [*customise boot sources*](bootsources.html) to see examples on how
to do that.

## Speeding up repeated image imports by using a local mirror

See [*Local Mirroring of Boot Images*](sstreams-mirror.html) for
information on how to set up a mirror and configure MAAS to use it.

## Configure DHCP

If you want MAAS to control DHCP, you can either:

1.  Follow the instructions at [*Cluster
    Configuration*](cluster-configuration.html) to use the web UI to set
    up your cluster controller.
2.  Use the command line interface maas by first [*logging in to the
    API*](maascli.html#api-key) and then [*following this
    procedure*](maascli.html#cli-dhcp)

If you are manually configuring a DHCP server, you should take a look at
[*Manual DHCP configuration*](configure.html#manual-dhcp)

## Configure switches on the network

Some switches use Spanning-Tree Protocol (STP) to negotiate a loop-free
path through a root bridge. While scanning, it can make each port wait
up to 50 seconds before data is allowed to be sent on the port. This
delay in turn can cause problems with some applications/protocols such
as PXE, DHCP and DNS, of which MAAS makes extensive use.

To alleviate this problem, you should enable
[Portfast](https://www.symantec.com/business/support/index?page=content&id=HOWTO6019)
for Cisco switches or its equivalent on other vendor equipment, which
enables the ports to come up almost immediately.

## Traffic between the region contoller and cluster controllers

  -   Each cluster controller must be able to:
  -   Initiate TCP connections (for HTTP) to each region controller on
        port 80 or port 5240, the choice of which depends on the setting
        of `MAAS_URL`{.docutils .literal}.
  -   Initiate TCP connections (for RPC) to each region controller
        between port 5250 and 5259 inclusive. This permits up to 10
        `maas-regiond`{.docutils .literal} processes on each region
        controller host. At present this is not configurable.

Once everything is set up and running, you are ready to [*start
enlisting nodes*](nodes.html)



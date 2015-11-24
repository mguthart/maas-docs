### Navigation

-   [next](juju-quick-start.html "Juju Quick Start")
-   [previous](devices.html "Devices") |
-   [MAAS 1.8 documentation](index.html) »

Operating Systems Support[¶](#operating-systems-support "Permalink to this headline")
=====================================================================================

Note

This feature is available in MAAS versions 1.7 and above.

Besides Ubuntu, MAAS allows users to deploy different operating systems,
such as CentOS. Ubuntu Advantage customers can additionally deploy
Redhat Enterprise Linux (RHEL), OpenSUSE, SLES, Window Server and
Windows HyperV.

Generated Images vs. Custom Images[¶](#generated-images-vs-custom-images "Permalink to this headline")
------------------------------------------------------------------------------------------------------

MAAS supports two different classes of OS images, Generated images and
Custom images.

Generated images are images of the OS’ that MAAS team fully supports.
Currently supported OS’ are CentOS and Windows.

Custom images are images that MAAS can deploy, but may have been
customized and differ from those that the MAAS team supports. Custom
images can include any Ubuntu, CentOS or Windows image. Additionally,
Redhat Enterprise Linux (RHEL), OpenSUSE and SLES images also fall under
this category.

Installing MAAS Images[¶](#installing-maas-images "Permalink to this headline")
-------------------------------------------------------------------------------

### Installing Generated Images[¶](#installing-generated-images "Permalink to this headline")

Installing MAAS Generated Images (CentOS or Windows) can be done with
the command:

    $ maas admin boot-resources create name=<os/series>
      architecture=<architecture> [filetype=ddtgz]
      content@=<image-name>

The list of supported Operating Systems under Generated Images is:

> -   CentOS 6.5 (centos/centos65)
> -   CentOS 7 (centos/centos7)
> -   Windows Server 2012 (windows/win2012)
> -   Windows Server 2012 R2 (windows/win2012r2)
> -   Windows Hyper-V (windows/win2012hv)
> -   Windows Hyper-V R2 (windows/win2012hvr2)

Examples:

    $ maas admin boot-resources create name=centos/centos7
      architecture=amd64/generic content@=centos7-amd64-root-tgz

    $ maas admin boot-resources create name=windows/win2012
      architecture=amd64/generic filetype=ddtgz
      content@=win2012-amd64-ddtgz

### Installing Custom Images[¶](#installing-custom-images "Permalink to this headline")

Installing custom images require the user to specify a unique identifier
for the OS and Release, as well as the title of the Image:

    $ maas admin boot-resources create name=custom/<os-release-id>
      title=<title> architecture=amd64/generic content@=<image-name>

Examples:

    $ maas admin boot-resources create name=custom/rhel7
      title="RedHat Enterprise Linux 7" architecture=amd64/generic
      content@=rhel7-amd64-root-tgz

The list of tested Operating Systems under Custom Images is:

> -   OpenSUSE
> -   SLES 11 and SLES 12
> -   Redhat Enterprise Linux 7 (RHEL7)

MAAS Image Builder[¶](#maas-image-builder "Permalink to this headline")
-----------------------------------------------------------------------

The MAAS Image Builder is a script that allows users to generate their
own images. However, `maas-image-builder`{.docutils .literal} only
supports the generation of CentOS and RHEL images. To install
`maas-image-builder`{.docutils .literal}, please follow the
instructions:

    $ sudo apt-get add-apt-repository ppa:maas-maintainers/stable
    $ sudo apt-get install maas-image-builder

### Creating and Installing CentOS MAAS Images[¶](#creating-and-installing-centos-maas-images "Permalink to this headline")

Note

Supported CentOS versions are CentOS 6.5 (centos65) and CentOS 7
(centos7).

To create a MAAS CentOS image, no ISO is needed as all of the required
software to create the image is downloaded (from CentOS repositories) as
part of the image generation process. To create the MAAS CentOS image,
`maas-image-builder`{.docutils .literal} can be used as:

    $ maas-image-builder -a amd64 -o centos7-amd64-root-tgz centos --edition 7

The created image, `centos7-amd64-root-tgz`{.docutils .literal}, needs
to be uploaded into the MAAS Region Controller. This image will be
listed under the Generated Image Section in the MAAS Image page. This
image can be uploaded with:

    $ maas admin boot-resources create name=centos/centos7
      architecture=amd64/generic content@=./build-output/centos7-amd64-root-tgz

[![MAAS
logo](_static/maas-logo-200.png)](index.html "MAAS Documentation Homepage")

MAAS {style="text-align:center;"}
----

Metal As A Service.

\
 \

-   [Operating Systems Support](#)
    -   [Generated Images vs. Custom
        Images](#generated-images-vs-custom-images)
    -   [Installing MAAS Images](#installing-maas-images)
        -   [Installing Generated Images](#installing-generated-images)
        -   [Installing Custom Images](#installing-custom-images)
    -   [MAAS Image Builder](#maas-image-builder)
        -   [Creating and Installing CentOS MAAS
            Images](#creating-and-installing-centos-maas-images)

### Related Topics

-   [Documentation overview](index.html)
    -   Previous: [Devices](devices.html "previous chapter")
    -   Next: [Juju Quick Start](juju-quick-start.html "next chapter")

### This Page

-   [Show Source](_sources/os-support.txt)

### Quick search

Enter search terms or a module, class or function name.

### Navigation

-   [next](juju-quick-start.html "Juju Quick Start")
-   [previous](devices.html "Devices") |
-   [MAAS 1.8 documentation](index.html) »

© Copyright 2012-2015, MAAS Developers. Ubuntu and Canonical are
registered trademarks of [Canonical Ltd](http://canonical.com).

Revision 4036 (2015-08-05 16:30:57 +0000). Documentation generation
date: 2015-08-12 22:30:33 +0100.

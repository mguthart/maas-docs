### Navigation

-   [next](troubleshooting.html "MAAS Troubleshooting")
-   [previous](capabilities.html "Capabilities") |
-   [MAAS 1.8 documentation](index.html) »

Getting help[¶](#getting-help "Permalink to this headline")
===========================================================

Where to get help[¶](#where-to-get-help "Permalink to this headline")
---------------------------------------------------------------------

The two channels you can use to get help debugging a MAAS issue are:

-   The [Ask Ubuntu](http://askubuntu.com/questions/ask?tags=maas)
    website.
-   The [Freenode \#maas](http://webchat.freenode.net/?channels=maas)
    IRC channel.

Gathering debugging information[¶](#gathering-debugging-information "Permalink to this headline")
-------------------------------------------------------------------------------------------------

If your question is related to a problem related to a specific MAAS
installation, we encourage you to gather debugging information and make
it available before you head over to Ask Ubuntu or the IRC channel. This
way, you’ll have all the required information handy for people who can
help you.

Gathering debugging information is a fully automated process that is
performed with the help of
[sosreport](https://github.com/sosreport/sosreport).

If your MAAS server is running Ubuntu version 14.04 (Trusty Tahr) or
later, you can get sosreport from the official archives:

    # Install sosreport.
    sudo apt-get install -y sosreport
    # Create the report.
    sudo sosreport -o maas

Alternatively, if your MAAS server is running a previous Ubuntu release,
you’ll need to install sosreport manually:

    # Install git.
    sudo apt-get install -y git
    # Get the latest version of sosreport.
    git clone https://github.com/sosreport/sosreport.git /tmp/sosreport
    # Create the report.
    sudo /tmp/sosreport/sosreport -o maas

This will create a tarball containing MAAS’ log files, MAAS’
configuration files and a dump of MAAS’ database. By default, the
tarball will end up in /tmp but you can change the location, see
sosreport’s manpage for details. If there are things you do not wish to
share publicly, feel free to edit the tarball.

Now, the last step is to make this file available by any means at your
disposal (openly accessible FTP server, Dropbox, etc.) in order for the
people who will help you to be able to get their hands on it.

[![MAAS
logo](_static/maas-logo-200.png)](index.html "MAAS Documentation Homepage")

MAAS {style="text-align:center;"}
----

Metal As A Service.

\
 \

-   [Getting help](#)
    -   [Where to get help](#where-to-get-help)
    -   [Gathering debugging
        information](#gathering-debugging-information)

### Related Topics

-   [Documentation overview](index.html)
    -   Previous: [Capabilities](capabilities.html "previous chapter")
    -   Next: [MAAS
        Troubleshooting](troubleshooting.html "next chapter")

### This Page

-   [Show Source](_sources/getting-help.txt)

### Quick search

Enter search terms or a module, class or function name.

### Navigation

-   [next](troubleshooting.html "MAAS Troubleshooting")
-   [previous](capabilities.html "Capabilities") |
-   [MAAS 1.8 documentation](index.html) »

© Copyright 2012-2015, MAAS Developers. Ubuntu and Canonical are
registered trademarks of [Canonical Ltd](http://canonical.com).

Revision 4036 (2015-08-05 16:30:57 +0000). Documentation generation
date: 2015-08-12 22:30:33 +0100.

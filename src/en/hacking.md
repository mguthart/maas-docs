Hacking MAAS
============

Coding style
------------

MAAS follows the [Launchpad Python Style Guide](https://dev.launchpad.net/PythonStyleGuide), except where it gets Launchpad specific, and where it talks about [method naming](https://dev.launchpad.net/PythonStyleGuide#Naming). MAAS instead adopts [PEP-8](http://www.python.org/dev/peps/pep-0008/) naming in all cases, so method names should usually use the `lowercase_with_underscores` form.

Prerequisites
-------------

You can grab MAAS's code manually from Launchpad but [Bazaar](http://bazaar.canonical.com/) makes it easy to fetch the last version of the code. First of all, install Bazaar:

    $ sudo apt-get install bzr

Then go into the directory where you want the code to reside and run:

    $ bzr branch lp:maas maas && cd maas

MAAS depends on Postgres 9.1, Apache 2, daemontools, pyinotify, and many other packages. To install everything that's needed for running and developing MAAS, run:

    $ make install-dependencies

Careful: this will `apt-get install` many packages on your system, via `sudo`. It may prompt you for your password.

This will install `bind9`. As a result you will have an extra daemon running. If you are a developer and don't intend to run BIND locally, you can disable the daemon by inserting `exit 1` at the top of `/etc/default/bind9`. The package still needs to be installed for tests though.

You may also need to install `python-django-piston`, but installing it seems to cause import errors for `oauth` when running the test suite.

All other development dependencies are pulled automatically from [PyPI](http://pypi.python.org/) when `buildout` runs. See First time using buildout?\_ and Running tests\_.

First time using buildout?
--------------------------

[Buildout](http://www.buildout.org/) is used to develop MAAS. Buildout, if configured so, can cache downloaded files and built eggs. If you've not already done something similar, the following snippet will massively improve build times:

    [buildout]
    download-cache = /home/<your-user-name>/.buildout/cache
    eggs-directory = /home/<your-user-name>/.buildout/eggs

Put this in `~/.buildout/default.cfg` and create the `cache` directory:

    $ mkdir /home/<your-user-name>/.buildout/cache

The `eggs` directory will be created automatically.

Running tests
-------------

To run the whole suite:

    $ make test

To run tests at a lower level of granularity:

    $ ./bin/test.region src/maasserver/tests/test_api.py
    $ ./bin/test.region src/maasserver/tests/test_api.py:AnonymousEnlistmentAPITest

The test runner is [nose](http://readthedocs.org/docs/nose/en/latest/), so you can pass in options like `--with-coverage` and `--nocapture` (short option: `-s`). The latter is essential when using `pdb` so that stdout is not adulterated.

> **note**
>
> When running `make test` through ssh from a machine with locales that are not set up on the machine that runs the tests, some tests will fail with a `MismatchError` and an "unsupported locale setting" message. Running `locale-gen` for the missing locales or changing your locales on your workstation to ones present on the server will solve the issue.

### Running JavaScript tests

The JavaScript tests are run using [Selenium](http://seleniumhq.org/). Firefox is the default browser but any browser supported by Selenium can be used to run the tests. Note that you might need to download the appropriate driver and make it available in the path. You can then choose which browsers to use by setting the environment variable `MAAS_TEST_BROWSERS` to a comma-separated list of the names of the browsers to use. For instance, to run the tests with Firefox and Chrome:

    $ export MAAS_TEST_BROWSERS="Firefox, Chrome"

Development MAAS server setup
-----------------------------

Access to the database is configured in `src/maas/development.py`.

The `Makefile` or the test suite sets up a development database cluster inside your branch. It lives in the `db` directory, which gets created on demand. You'll want to shut it down before deleting a branch; see below.

First, set up the project. This fetches all the required dependencies and sets up some useful commands in `bin/`:

    $ make

Create the database cluster and initialise the development database:

    $ make syncdb

Optionally, populate your database with the sample data:

    $ make sampledata

By default, the snippet `maas_proxy` includes a definition for an http proxy running on port 8000 on the same host as the MAAS server. This means you can *either* install `squid-deb-proxy`:

    $ sudo apt-get install squid-deb-proxy

*or* you can edit `contrib/snippets_v2/generic` to remove the proxy definition.

Set the iSCSI config to include the MAAS configs:

    $ sudo tee -a /etc/tgt/targets.conf < contrib/tgt.conf

The http\_proxy variable is only needed if you're downloading through a proxy; "sudo" wouldn't pass it on to the script without the assignment. Or if you don't have it set but do want to download through a proxy, pass your proxy's URL: "http\_proxy=http://proxy.example.com/"

Run the development webserver and watch all the logs go by:

    $ make run

Point your browser to <http://localhost:5240/MAAS/>

If you've populated your instance with the sample data, you can login as a simple user using the test account (username: 'test', password: 'test') or the admin account (username: 'admin', password: 'test').

At this point you may also want to [download PXE boot resources](`Downloading%20PXE%20boot%20resources`_).

To shut down the database cluster and clean up all other generated files in your branch:

    $ make distclean

### Downloading PXE boot resources

To use PXE booting, each cluster controller needs to download several files relating to PXE booting. This process is automated, but it does not start by default.

First create a superuser and start all MAAS services:

    $ bin/maas-region-admin createadmin
    $ make run

Substitute your own email. The command will prompt for a choice of password.

Next, get the superuser's API key on the [account preferences](http://localhost:5240/MAAS/account/prefs/) page in the web UI, and use it to log into MAAS at the command-line:

    $ bin/maas login dev http://localhost:5240/MAAS/

Start downloading PXE boot resources:

    $  bin/maas dev node-groups import-boot-images

This sends jobs to each cluster controller, asking each to download the boot resources they require. This may download dozens or hundreds of megabytes, so it may take a while. To save bandwidth, set an HTTP proxy beforehand:

    $ bin/maas dev maas set-config name=http_proxy value=http://...

### Running the built-in TFTP server

You will need to run the built-in TFTP server on the real TFTP port (69) if you want to boot some real hardware. By default, it's set to start up on port 5244 for testing purposes. Make these changes:

    * Edit ``etc/maas/pserv.yaml`` to change the tftp/port setting to 69
    * Install the ``authbind``package:

      $ sudo apt-get install authbind

    * Create a file ``/etc/authbind/byport/69`` that is *executable* by the
      user running MAAS.

      $ sudo touch /etc/authbind/byport/69
      $ sudo chmod a+x /etc/authbind/byport/69

Now when starting up the MAAS development webserver, "make run" and "make start" will detect authbind's presence and use it automatically.

### Running the BIND daemon for real

There's a BIND daemon that is started up as part of the development service but it runs on port 5246 by default. If you want to make it run as a real DNS server on the box then edit `services/dns/run` and change the port declaration there so it says:

    port=53

Then as for TFTP above, create an authbind authorisation:

    $ sudo touch /etc/authbind/byport/53
    $ sudo chmod a+x /etc/authbind/byport/53

and run as normal.

### Running the cluster worker

The cluster also needs authbind as it needs to bind a socket on UDP port 68 for DHCP probing:

    $ sudo touch /etc/authbind/byport/68
    $ sudo chmod a+x /etc/authbind/byport/68

If you omit this, nothing else will break, but you will get an error in the cluster log because it can't bind to the port.

### Configuring DHCP

MAAS requires a properly configured DHCP server so it can boot machines using PXE. MAAS can work with its own instance of the ISC DHCP server, if you install the maas-dhcp package:

    $ sudo apt-get install maas-dhcp

If you choose to run your own ISC DHCP server, there is a bit more configuration to do. First, run this tool to generate a configuration that will work with MAAS:

    $ maas-provision generate-dhcp-config [options]

Run `maas-provision generate-dhcp-config -h` to see the options. You will need to provide various IP details such as the range of IP addresses to assign to clients. You can use the generated output to configure your system's ISC DHCP server, by inserting the configuration in the `/etc/dhcp/dhcpd.conf` file.

Also, edit /etc/default/isc-dhcp-server to set the INTERFACES variable to just the network interfaces that should be serviced by this DHCP server.

Now restart dhcpd:

    $ sudo service isc-dhcp-server restart

None of this work is needed if you let MAAS run its own DHCP server by installing `maas-dhcp`.

Development services
--------------------

The development environment uses *daemontools* to manage the various services that are required. These are all defined in subdirectories in `services/`.

There are familiar service-like commands:

    $ make start
    $ make status
    $ make restart
    $ make stop

The latter is a dependency of `distclean` so just running `make distclean` when you've finished with your branch is enough to stop everything.

Individual services can be manipulated too:

    $ make services/clusterd/@start

The `@<action>` pattern works for any of the services.

There's an additional special action, `run`:

    $ make run

This starts all services up and tails their log files. When you're done, kill `tail` (e.g. Ctrl-c), and all the services will be stopped.

However, when used with individual services:

    $ make services/regiond/@run

it does something even cooler. First it shuts down the service, then it restarts it in the foreground so you can see the logs in the console. More importantly, it allows you to use `pdb`, for example.

A note of caution: some of the services have slightly different behaviour when run in the foreground:

-   regiond (the *webapp* service) will be run with its auto-reloading enabled.

There's a convenience target for hacking regiond that starts everything up, but with regiond in the foreground:

    $ make run+regiond

Apparently Django needs a lot of debugging ;)

Adding new dependencies
-----------------------

Since MAAS is distributed mainly as an Ubuntu package, all runtime dependencies should be packaged, and we should develop with the packaged version if possible. All dependencies, from a package or not, need to be added to `setup.py` and `buildout.cfg`, and the version specified in `versions.cfg` (`allowed-picked-version` is disabled, hence `buildout` must be given precise version information).

If it is a development-only dependency (i.e. only needed for the test suite, or for developers' convenience), simply running `buildout` like this will make the necessary updates to `versions.cfg`:

    $ ./bin/buildout -v buildout:allow-picked-versions=true

Adding new source files
-----------------------

When creating a new source file, a Python module or test for example, always start with the appropriate template from the `templates` directory.

Database information
--------------------

MAAS uses [South](http://south.aeracode.org) to manage changes to the database schema.

Be sure to have a look at [South's documentation](http://south.aeracode.org/docs/) before you make any change.

### Changing the schema

Once you've made a model change (i.e. a change to a file in `src/<application>/models/*.py`) you have to run South's [schemamigration](http://south.aeracode.org/docs/commands.html#schemamigration) command to create a migration file that will be stored in `src/<application>/migrations/`.

Note that if you want to add a new model class you'll need to import it in `src/<application>/models/__init__.py`

Once you've changed the code, run:

    $ ./bin/maas-region-admin schemamigration maasserver --auto description_of_the_change

This will generate a migration module named `src/maasserver/migrations/<auto_number>_description_of_the_change.py`. Don't forget to add that file to the project with:

    $ bzr add src/maasserver/migrations/<auto_number>_description_of_the_change.py

To apply that migration, run:

    $ make syncdb

> **note**
>
> In order to create or run a migration, you'll need to have the database server running. To do that, either run `make start`, which will start all of the MAAS components or `make services/database/@start`, which will start only the database server.

### Performing data migration

If you need to perform data migration, very much in the same way, you will need to run South's [datamigration](http://south.aeracode.org/docs/commands.html#datamigration) command. For instance, if you want to perform changes to the `maasserver` application, run:

    $ ./bin/maas-region-admin datamigration maasserver description_of_the_change

This will generate a migration module named `src/maasserver/migrations/<auto_number>_description_of_the_change.py`. You will need to edit that file and fill the `forwards` and `backwards` methods where data should be actually migrated. Again, don't forget to add that file to the project:

    $ bzr add src/maasserver/migrations/<auto_number>_description_of_the_change.py

Once the methods have been written, apply that migration with:

    $ make syncdb

### Examining the database manually

If you need to get an interactive `psql` prompt, you can use [dbshell](https://docs.djangoproject.com/en/dev/ref/django-admin/#dbshell):

    $ bin/maas-region-admin dbshell

If you need to do the same thing with a version of MAAS you have installed from the package, you can use:

    $ sudo maas-region-admin dbshell --installed

You can use the `\dt` command to list the tables in the MAAS database. You can also execute arbitrary SQL. For example::

    maasdb=# select system_id, hostname from maasserver_node;
                     system_id                 |      hostname
    -------------------------------------------+--------------------
     node-709703ec-c304-11e4-804c-00163e32e5b5 | gross-debt.local
     node-7069401a-c304-11e4-a64e-00163e32e5b5 | round-attack.local
    (2 rows)

Documentation
-------------

Use [reST](http://sphinx.pocoo.org/rest.html) with the [convention for headings as used in the Python documentation](http://sphinx.pocoo.org/rest.html#sections).



# Juju Quick Start

These instructions will help you deploy your first charm with Juju to a
MAAS cluster.

In the following, we assume that you have a MAAS cluster set-up with at
least 2 nodes enlisted with it.

## Your API key, SSH key, and environments.yaml


You’ll need an API key from MAAS so that the Juju client can access it.
Each user account in MAAS can have as many API keys as desired. One hard
and fast rule is that you’ll need to use a different API key for each
Juju *environment* you set up within a single MAAS cluster.

There is no need to explicitly add an SSH key to MAAS when using Juju;
it will automatically put your public key on any hosts that it starts
up.

!!! Note: You do not need to use the MAAS web UI or API to allocate a
node to yourself, Juju will do this for you.

### Getting a key

To get the API key:

1.  Go to your MAAS preferences page (go to your MAAS home page
    `http://<my-maas-server>:80/MAAS/` and choose
    *Preferences* from the drop-down menu that appears when clicking
    your username at the top-right of the page).
2.  Optionally add a new MAAS key. Do this if you’re setting up another
    environment within the same MAAS cluster.

The `<my-maas-server>` part of the URL should be replaced with the address of
your MAAS server.

### Adding an SSH key

While you’re still on the MAAS preferences page, add your SSH key by
clicking *Add SSH key*. Use the public half of your SSH key, the content
of `~/.ssh/id_rsa.pub` for example; don’t paste the
private half.

### Creating environments.yaml

Create or modify `~/.juju/environments.yaml` with
the following content:

```yaml

    environments:
      maas:
        type: maas
        maas-server: 'http://<my-maas-server>:80/MAAS'
        maas-oauth: '<maas-api-key>'
        admin-secret: <your-admin-secret>
        default-series: precise
```

The values you need to substitute are:

`<my-maas-server>` - the name or IP of your MAAS server
`<maas-api-key>` - the MAAS API key string you obtained above
`<your-admin-secret>` - a random pass-phrase (there is no default).

Now Juju

If juju-core is not yet installed on the client machine, run:

```bash

sudo apt-get install juju-core
```

Now, use Juju to change the default environment to MAAS and check the status:

```bash
juju switch maas
juju status
```
As you’ve not bootstrapped you ought to see:

```bash
    error: Unable to connect to environment "".
    Please check your credentials or use 'juju bootstrap' to create a new environment.
```

!!! Note: if Juju complains that there are multiple environments and no
explicit default, add `-e ${environment-name}` after
each command, e.g.:

To initialise the environment, Juju needs to create a bootstrap node:

```bash
juju bootstrap
```

This command will return quickly, but the master node may take a *long* time to
come up. It has to completely install Ubuntu and Juju on it and reboot
before it’ll be available for use. 

You can check on progess using the watch command:

```bash
watch juju status
```

... which should provide enough information to see when the node is installed and 
running.


Once the boostrap node has been installed a status command should come
up with something a bit more interesting:

```no-highlight
    environment: maas
    machines:
      "0":
        agent-state: started
        agent-version: 1.13.3.1
        dns-name: kmhwd.master
        instance-id: /MAAS/api/1.0/nodes/node-5c5b713a-1afc-11e3-9904-525400123456/
        series: precise
    services: {}
```

Now it’s possible to deploy a charm:

```bash
juju deploy mysql
juju status
```

If you have another node free you can finish off the standard example:

```bash
juju deploy wordpress
juju add-relation wordpress mysql
juju expose wordpress
juju status
```

Note that each charm runs on its own host, so each deployment will
actually take as long as it took to bootstrap.

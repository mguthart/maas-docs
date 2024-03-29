
# Command Line Interface

As well as the web interface, many tasks can be performed by accessing
the MAAS API directly through the `maas` command. This section details how
to log in with this tool and perform some common operations.

## Logging in

Before the API will accept any commands from `maas`, you must first log
in. To do this, you need an API key for your MAAS account. A key was
generated for you as soon as your account was created, although you can
still generate additional keys if you prefer.

The key can be found in the web user interface, or if you have root
privileges on the region controller, retrieved from the command line.

To obtain the key from the web user interface, log in and click on your
user name in the top right corner of the page, and select ‘Preferences’
from the menu which appears.

![](_images/maascli-prefs.png)

A new page will load...

![](_images/maascli-key.png)

Your MAAS API keys appear at the top of the preferences form. It’s
easiest to just select and copy the key (it’s quite long!) and then
paste it into the command line.

To obtain the key through the command line, run this command on the
region controller (it requires root access):

```bash
sudo maas-region-admin apikey --username=<my-username>
```

(Substitute your MAAS user name for <my-username>).

Once you have your API key, log in with:

```
maas login <profile-name> <hostname> <key>
```

This command logs you in, and creates a “profile” with the profile name
you have selected. The profile is an easy way of storing the server URL
and your login credentials, and re-using them across command-line
invocations. Think of the profile as a persistent session. You can have
multiple profiles open at the same time, and so as part of the login
command, you assign a unique name to the new profile. Later invocations
of the maas command line will refer to the profile by this name.

For example, you might log in with a command line like:

```bash
maas login my-maas http://10.98.0.13/MAAS/api/1.0
    AWSCRMzqMNy:jjk...5e1FenoP82Qm5te2
```

This creates the profile ‘my-maas’ and registers it with the given key
at the specified API endpoint URL.

If you omit the API key, the command will prompt you for it in the
console. It is also possible to use a hyphen, ‘-‘ in place of the API
key. In this case the command will read the API key from standard input,
as a single line, ignoring whitespace. This mode of input can be useful
if you want to read the API key from a file, or if you wish to avoid
including the API key in a command line where it may be observed by
other users on the system.

Specifying an empty string instead of an API key will make the profile
act as an anonymous user. Some calls in the API are accessible without
logging in, but most of them are not.

## The `maas` commands

The `maas` command exposes the whole API, so you can
do anything you actually *can* do with MAAS using this command.
Unsurprisingly, this leaves us with a vast number of options, but before
we delve into detail on the specifics, here is a sort of ‘cheat-sheet’
for common tasks you might want to do using `maas`{.docutils .literal}.

  -   [*Configure DHCP and DNS services*](#cli-dhcp)
  -   [*Commission all enlisted nodes*](#cli-commission)
  -   [*Setting IPMI power parameters for a
      node*](man/maas.8.html#cli-power)

The main maas commands are:

### `list`

Lists the details [name url auth-key] of all the currently logged-in
profiles.

###`login <profile> <url> <key>`

Logs in to the MAAS controller API at the given URL, using the key
provided and associates this connection with the given profile name.

### `logout <profile>`

Logs out from the given profile, flushing the stored credentials.

### `refresh`

> Refreshes the API descriptions of all the current logged in profiles.
> This may become necessary for example when upgrading the maas packages
> to ensure the command-line options match with the API.

### `<profile> [command] [options] ...`

> Using the given profile name instructs `maas`{.docutils .literal} to
> direct the subsequent commands and options to the relevant MAAS, which
> for the current API are detailed below...

### account

This command is used for creating and destroying the MAAS authorisation
tokens associated with a profile.

Usage: maas *\<profile\>* account [-d –debug] [-h –help]
create-authorisation-token | delete-authorisation-token
[token\_key=*\<value\>*]

#### `-d, --debug`

> Displays debug information listing the API responses.

#### `-h, --help`

> Display usage information.

#### `-k, --insecure`

> Disables the SSL certificate check.

#### `create-authorisation-token`

> Creates a new MAAS authorisation token for the current profile which
> can be used to authenticate connections to the API.

`delete-authorisation-token token_key=<value>`

> Removes the given key from the list of authorisation tokens.

### node

API calls which operate on individual nodes. With these commands, the
node is always identified by its “system\_id” property - a unique tag
allocated at the time of enlistment. To discover the value of the
system\_id, you can use the `maas <profile> nodes list`{.docutils
.literal} command.

USAGE: maas \<profile\> node [-h] release | start | stop | delete | read
| update \<system\_id\>

`-h, --help`

> Display usage information.

`release <system_id>`

> Releases the node given by *\<system\_id\>*

`start <system_id>`

> Powers up the node identified by *\<system\_id\>* (where MAAS has
> information for power management for this node).

`stop <system_id>`

> Powers off the node identified by *\<system\_id\>* (where MAAS has
> information for power management for this node).

`delete <system_id>`

> Removes the given node from the MAAS database.

`read <system_id>`

> Returns all the current known information about the node specified by
> *\<system\_id\>*

`update <system_id> [parameters...]`

> Used to change or set specific values for the node. The valid
> parameters are listed below:
>
>     hostname=<value>
>          The new hostname for this node.
>
>     architecture=<value>
>          Sets the architecture type, where <value>
>          is a string containing a valid architecture type,
>          e.g. "i386/generic"
>
>     distro_series=<value>
>          Sets the distro series of Ubuntu to use (e.g. "precise").
>
>     power_type=<value>
>          Set the given power type on the node. (e.g. "ipmi")
>
>     power_parameters_{param1}... =<value>
>          Set the given power parameters. Note that the valid options for these
>          depend on the power type chosen.
>
>     power_parameters_skip_check 'true' | 'false'
>          Whether to sanity check the supplied parameters against this node's
>          declared power type. The default is 'false'.

Example: Setting the power parameters for an ipmi enabled node:

    maas maas node update <system_id> \
      power_type="ipmi" \
      power_parameters_power_address=192.168.22.33 \
      power_parameters_power_user=root \
      power_parameters_power_pass=ubuntu;

### nodes[¶](#nodes "Permalink to this headline")

Usage: maas \<profile\> nodes [-h] is-registered | list-allocated |
acquire | list | accept | accept-all | new | check-commissioning

`-h, --help`

> Display usage information.

`accept <system_id>`

> Accepts the node referenced by \<system\_id\>.

`accept-all`

> Accepts all currently discovered but not previously accepted nodes.

`acquire`

> Allocates a node to the profile used to issue the command. Any ready
> node may be allocated.

`is-registered mac_address=<address>`

> Checks to see whether the specified MAC address is registered to a
> node.

`list`

> Returns a JSON formatted object listing all the currently known nodes,
> their system\_id, status and other details.

`list-allocated`

> Returns a JSON formatted object listing all the currently allocated
> nodes, their system\_id, status and other details.

`new architecture=<value> mac_addresses=<value> [parameters]`{.samp
.docutils .literal}

> Creates a new node entry given the provided key=value information for
> the node. A minimum of the MAC address and architecture must be
> provided. Other parameters may also be supplied:
>
>     architecture="<value>" - The architecture of the node, must be
>     one of the recognised architecture strings (e.g. "i386/generic")
>     hostname="<value>" - a name for this node. If not supplied a name
>     will be generated.
>     mac_addresses="<value>" - The mac address(es)
>     allocated to this node.
>     power_type="<value>" - the power type of
>     the node (e.g. virsh, ipmi)

`check-commissioning`

> Displays current status of nodes in the commissioning phase. Any that
> have not returned before the system timeout value are listed as
> “failed”.

Examples: Accept and commission all discovered nodes:

    $ maas maas nodes accept-all

List all known nodes:

    $ maas maas nodes list

Filter the list using specific key/value pairs:

    $ maas maas nodes list architecture="i386/generic"

### node-groups[¶](#node-groups "Permalink to this headline")

Usage: maas \<profile\> node-groups [-d –debug] [-h –help] [-k
–insecure] register | list | accept | reject

`-d, --debug`

> Displays debug information listing the API responses.

`-h, --help`

> Display usage information.

`-k, --insecure`

> Disables the SSL certificate check.

`register uuid=<value> name=<value> interfaces=<json_string>`{.samp
.docutils .literal}

> Registers a new node group with the given name and uuid. The
> interfaces parameter must be supplied in the form of a JSON string
> comprising the key/value data for the interface to be used, for
> example: interface=’[“ip”:”192.168.21.5”,”interface”:”eth1”,
> “subnet\_mask”:”255.255.255.0”,”broadcast\_ip”:”192.168.21.255”,
> “router\_ip”:”192.168.21.1”, “ip\_range\_low”:”192.168.21.10”,
> “ip\_range\_high”:”192.168.21.50”}]’

`list`

> Returns a JSON list of all currently defined node groups.

`accept <uuid>`

> Accepts a node-group or number of nodegroups indicated by the supplied
> UUID

`reject <uuid>`

> Rejects a node-group or number of nodegroups indicated by the supplied
> UUID

### node-group-interface[¶](#node-group-interface "Permalink to this headline")

For managing the interfaces. See also
[*node-group-interfaces*](#node-group-interfaces)

Usage: maas *\<profile\>* node-group-interfaces [-d –debug] [-h –help]
[-k –insecure] read | update | delete [parameters...]

..program:: maas node-group-interface

`read <uuid> <interface>`

> Returns the current settings for the given UUID and interface

`update [parameters]`

> Changes the settings for the interface according to the given
> parameters:
>
>     management=  0 | 1 | 2
>          The service to be managed on the interface ( 0= none, 1=DHCP, 2=DHCP
>          and DNS).
>
>     subnet_mask=<value>
>          Apply the given dotted decimal value as the subnet mask.
>
>     broadcast_ip=<value>
>          Apply the given dotted decimal value as the broadcast IP address for
>          this subnet.
>
>     router_ip=<value>
>          Apply the given dotted decimal value as the default router address
>          for this subnet.
>
>     ip_range_low=<value>
>          The lowest value of IP address to allocate via DHCP
>
>     ip_range_high=<value>
>          The highest value of IP address to allocate via DHCP

`delete <uuid> <interface>`

> Removes the entry for the given UUID and interface.

Example: Configuring DHCP and DNS.

To enable MAAS to manage DHCP and DNS, it needs to be supplied with the
relevant interface information. To do this we need to first determine
the UUID of the node group affected:

    $ uuid=$(maas <profile> node-groups list | grep uuid | cut -d\" -f4)

Once we have the UUID we can use this to update the node-group-interface
for that nodegroup, and pass it the relevant interface details:

    $ maas <profile> node-group-interface update $uuid eth0 \
            ip_range_high=192.168.123.200    \
            ip_range_low=192.168.123.100     \
            management=2                     \
            broadcast_ip=192.168.123.255     \
            router_ip=192.168.123.1          \

Replacing the example values with those required for this network. The
only non-obvious parameter is ‘management’ which takes the values 0 (no
management), 1 (manage DHCP) and 2 (manage DHCP and DNS).

### node-group-interfaces[¶](#node-group-interfaces "Permalink to this headline")

The node-group-interfaces commands are used for configuring the
management of DHCP and DNS services where these are managed by MAAS.

Usage: maas *\<profile\>* node-group-interfaces [-d –debug] [-h –help]
[-k –insecure] list | new [parameters...]

`-d, --debug`

> Displays debug information listing the API responses.

`-h, --help`

> Display usage information.

`-k, --insecure`

> Disables the SSL certificate check.

`list <label>`

> Lists the current stored configurations for the given identifier
> \<label\> in a key:value format which should be easy to decipher.

`new <label> ip=<value> interface=<if_device> [parameters...]`{.samp
.docutils .literal}

> Creates a new interface group. The required parameters are the IP
> address and the network interface this applies to (e.g. eth0). In
> order to do anything useful, further parameters are required:
>
>     management= 0 | 1 | 2
>          The service to be managed on the interface
>          ( 0= none, 1=DHCP, 2=DHCP and DNS).
>
>     subnet_mask=<value>
>          Apply the given dotted decimal value as the subnet mask.
>
>     broadcast_ip=<value>
>          Apply the given dotted decimal value as the
>          broadcast IP address for this subnet.
>
>     router_ip=<value>
>          Apply the given dotted decimal value as the
>          default router address for this subnet.
>
>     ip_range_low=<value>
>          The lowest value of IP address to allocate via DHCP, used
>          only for enlistment, commissioning and unknown devices.
>
>     ip_range_high=<value>
>          The highest value of IP address to allocate via DHCP, used
>          only for enlistment, commissioning and unknown devices.
>
>     static_ip_range_low=<value>
>          Lowest IP number of the range for IPs given to allocated
>          nodes and user requests for IPs.
>
>     static_ip_range_low=<value>
>          Highest IP number of the range for IPs given to allocated
>          nodes and user requests for IPs.

### tag[¶](#tag "Permalink to this headline")

The tag command is used to manually alter tags, tagged nodes or rebuild
the automatic tags.

> For more information on how to use them effectively, please see
> [*Making use of Tags*](tags.html#deploy-tags)

Usage: maas \<profile\> tag read | update-nodes | rebuild | update |
nodes | delete

`read <tag_name>`

> Returns information on the tag specified by \<name\>

`update-nodes <tag_name> [add=<system_id>] [remove=<system_id>] [nodegroup=<system_id>]`{.samp
.docutils .literal}

> Applies or removes the given tag from a list of nodes specified by
> either or both of add=”\<system\_id\>” and remove=”\<system\_id\>”.
> The nodegroup parameter, which restricts the operations to a
> particular nodegroup, is optional, but only the superuser can execute
> this command without it.

`rebuild`

> Triggers a rebuild of the tag to node mapping.

`update <tag_name> [name=<value>] | [comment=<value>]| [definition=<value>]`{.samp
.docutils .literal}

> Updates the tag identified by tag\_name. Any or all of name,comment
> and definition may be supplied as parameters. If no parameters are
> supplied, this command returns the current values.

`nodes <tag_name>`

> Returns a list of nodes which are associated with the given tag.

`delete <tag_name>`

> Deletes the given tag.

### tags[¶](#tags "Permalink to this headline")

Tags are a really useful way of identifying nodes with particular
characteristics.

For more information on how to use them effectively, please see [Making
use of Tags](tags.html#deploy-tags)

Usage: maas \<profile\> tag [-d –debug] [-h –help] [-k –insecure] list |
create

`-d, --debug`

> Displays debug information listing the API responses.

`-h, --help`

> Display usage information.

`-k, --insecure`

> Disables the SSL certificate check.

`list`

> Returns a JSON object listing all the current tags known by the MAAS
> server

`create name=<value> definition=<value> [comment=<value>]`

> Creates a new tag with the given name and definition. A comment is
> optional. Names must be unique, obviously - an error will be returned
> if the given name already exists. The definition is in the form of an
> XPath expression which parses the XML returned by running
> `lshw` on the node.

Example: Adding a tag to all nodes which have an Intel GPU:

    $ maas maas tags new name='intel-gpu' \
        comment='Machines which have an Intel display driver' \
        definition='contains(//node[@id="display"]/vendor, "Intel")'

### unused commands[¶](#unused-commands "Permalink to this headline")

Because the `maas` command exposes all of the API,
it also lists some command options which are not really intended for end
users, such as the “file” and “boot-images” options.



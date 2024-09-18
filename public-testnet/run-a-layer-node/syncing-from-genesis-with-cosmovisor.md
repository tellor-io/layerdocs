---
description: It takes a bit longer, but it always works.
---

# Syncing from Genesis with Cosmovisor

## Prerequisites:

* A Layer node machine configured like [this](./).

## Build and configure cosmovisor

1. **Clone the cosmos repo, change directory to** `cosmos-sdk`

```sh
git clone https://github.com/cosmos/cosmos-sdk && cd cosmos-sdk/tools/cosmovisor
```

2. **Build cosmovisor with the command:**

```sh
go build ./cmd/cosmovisor
```

3. Add the following to the end of your `~/.bashrc` or `~/.zshrc` file:

```
# cosmovisor
export DAEMON_NAME=layerd
export DAEMON_HOME=$HOME/.layer
export DAEMON_RESTART_AFTER_UPGRADE=true
export DAEMON_ALLOW_DOWNLOAD_BINARIES=false
export DAEMON_POLL_INTERVAL=300ms
export UNSAFE_SKIP_BACKUP=true
export DAEMON_PREUPGRADE_MAX_RETRIES=0
```

Use  `source ~/.bashrc` or `source ~/.zshrc` to load the variables.

4. Gather all the Layer Antietam binaries. You can clone the repo and create a build at each tag, or download them from the repo: [v0.2.1](https://github.com/tellor-io/layer/releases/tag/v0.2.1) [v0.3.0](https://github.com/tellor-io/layer/releases/tag/v0.3.0) [v0.4.2](https://github.com/tellor-io/layer/releases/tag/v0.4.2) [v0.5.0](https://github.com/tellor-io/layer/releases/tag/v0.5.0) [v0.6.1](https://github.com/tellor-io/layer/releases/tag/v0.6.1). For each release, select the binary that matches your OS / cpu architecture. (e.g. "Darwin\_arm64" for macOS,"Linux\_x86\_x64" for most cloud machines...)&#x20;

We will save them to a folder called binaries, but you can keep them anywhere you like. Download each binary to it's own folder:

{% code overflow="wrap" %}
```sh
# v0.2.1
mkdir ~/binaries && cd ~/binaries && mkdir v0.2.1 && cd v0.2.1 && wget https://github.com/tellor-io/layer/releases/download/v0.2.1/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz
# v0.3.0
cd ~/binaries && mkdir v0.3.0 && cd v0.3.0 && wget https://github.com/tellor-io/layer/releases/download/v0.3.0/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz
# v0.4.2
cd ~/binaries && mkdir v0.4.2 && cd v0.4.2 && wget https://github.com/tellor-io/layer/releases/download/v0.2.1/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz
# v0.5.0
cd ~/binaries && mkdir v0.5.0 && cd v0.5.0 && wget https://github.com/tellor-io/layer/releases/download/v0.5.0/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz
# v0.6.1
cd ~/binaries && mkdir v0.6.1 && cd v0.6.1 && wget https://github.com/tellor-io/layer/releases/download/v0.6.1/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz
# v0.7.1-fix
cd ~/binaries && mkdir v0.7.1-fix && cd v0.7.1-fix && wget https://github.com/tellor-io/layer/releases/download/0.7.1-fix/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz
```
{% endcode %}

To check that these downloaded and extracted correctly: `ls ~/binaries`

5. Once you have all of the binaries downloaded, initialize cosmovisor and add all the upgrades. Change the file paths in the command to match the path to each binary exactly:

```shell
# set up cosmovisor. Each command is done seperatly.
./cosmovisor init ~/binaries/v0.2.1/layerd
./cosmovisor add-upgrade v0.3.0 ~/binaries/v0.3.0/layerd
./cosmovisor add-upgrade v0.4.2 ~/binaries/v0.4.2/layerd
./cosmovisor add-upgrade v0.5.0 ~/binaries/v0.5.0/layerd
./cosmovisor add-upgrade v0.6.1 ~/binaries/v0.6.1/layerd
./cosmovisor add-upgrade v0.7.1-fix ~/binaries/v0.7.1-fix/layerd
```

## Start your Layer Node!

{% hint style="success" %}
_<mark style="color:green;">**Before starting your node**</mark><mark style="color:green;">,</mark> it's a good idea to think about how you want to run it so that the process does not get killed accidentally._ [_GNU screen_](https://tellor.io/blog/how-to-manage-cli-applications-on-hosted-vms-with-screen/) _is a great option for beginners. More advanced setups can be achieved using systemd._
{% endhint %}

Run the command:

{% code overflow="wrap" %}
```sh
./cosmovisor run start --api.enable --api.swagger --price-daemon-enabled=false --panic-on-daemon-failure-enabled=false --home /home/admin/.layer --key-name $ACCOUNT_NAME
```
{% endcode %}

If your node is configured correctly, you should see the node connecting to end points before rapidly downloading blocks.   Please allow time for the node to sync before moving onto setting up a validator.

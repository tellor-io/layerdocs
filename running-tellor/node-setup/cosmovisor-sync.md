---
description: Cosmovisor is a binary manager that can perform upgrades automatically.
---

# Cosmovisor Sync

## Prerequisites:

A Tellor node machine configured like [this](/broken/pages/OzHKVqI8SaLRc9qfBb3m) is not required, but different setups may require different commands from the ones shown below.

## Build and configure Cosmovisor

1. **Clone the** cosmos repo somewhere on your node machine and change directory to `cosmos-sdk`

```sh
git clone https://github.com/cosmos/cosmos-sdk && cd cosmos-sdk/tools/cosmovisor
```

2. Build cosmovisor:

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

4. Initialize cosmovisor and add all the of the upgrades that you downloaded during [node setup](/broken/pages/OzHKVqI8SaLRc9qfBb3m). Change the file paths in the command to match the correct folder path to each binary:

```shell
# set up cosmovisor. Each command is done seperatly.
./cosmovisor init ~/layer/binaries/v4.0.3/layerd
./cosmovisor add-upgrade v5.0.0 ~/layer/binaries/v5.0.0/layerd
./cosmovisor add-upgrade v5.1.0 ~/layer/binaries/v5.1.0/layerd
./cosmovisor add-upgrade v5.1.1 ~/layer/binaries/v5.1.1/layerd
./cosmovisor add-upgrade v5.1.2 ~/layer/binaries/v5.1.2/layerd
./cosmovisor add-upgrade v6.0.0 ~/layer/binaries/v6.0.0/layerd
./cosmovisor add-upgrade v6.1.0 ~/layer/binaries/v6.1.0-fix/layerd
./cosmovisor add-upgrade v6.1.1 ~/layer/binaries/v6.1.1/layerd
```

6. To start your node with cosmovisor managing upgrades:

{% code overflow="wrap" %}
```sh
./cosmovisor run start --home ~/.layer --keyring-backend test --key-name YOUR_ACCOUNT_NAME --api.enable --api.swagger
```
{% endcode %}

Make sure to do `add-upgrade` in advance of future Tellor upgrades to make use of cosmovisor's upgrade automation!

## Binary Upgrades With Cosmovisor

When there's an upgrade coming, download the new binary and add it to cosmovisor. Replace `v6.1.6` with the actual upgrade tag if different:

{% tabs %}
{% tab title="Linux" %}
```sh
mkdir -p ~/layer/binaries/v6.1.6 && cd ~/layer/binaries/v6.1.6 && wget https://github.com/tellor-io/layer/releases/download/v6.1.6/layer_Linux_x86_64.tar.gz && tar -xvzf layer_Linux_x86_64.tar.gz
./cosmovisor add-upgrade v6.1.6 ~/layer/binaries/v6.1.6/layerd
```
{% endtab %}

{% tab title="MacOS" %}
```sh
mkdir -p ~/layer/binaries/v6.1.6 && cd ~/layer/binaries/v6.1.6 && wget https://github.com/tellor-io/layer/releases/download/v6.1.6/layer_Darwin_arm64.tar.gz && tar -xvzf layer_Darwin_arm64.tar.gz
./cosmovisor add-upgrade v6.1.6 ~/layer/binaries/v6.1.6/layerd
```
{% endtab %}

{% tab title="Linux ARM64" %}
```sh
mkdir -p ~/layer/binaries/v6.1.6 && cd ~/layer/binaries/v6.1.6 && wget https://github.com/tellor-io/layer/releases/download/v6.1.6/layer_Linux_arm64.tar.gz && tar -xvzf layer_Linux_arm64.tar.gz
./cosmovisor add-upgrade v6.1.6 ~/layer/binaries/v6.1.6/layerd
```
{% endtab %}
{% endtabs %}

---
description: Setup steps for cosmovisor gang.
---

# Cosmovisor Sync

Cosmovisor is a binary manager that can perform upgrades automatically. It can be configured to automatically download binaries, but this level of automation has not been tested on Tellor!

## Prerequisites:

A Tellor node machine configured like [this](broken-reference) is not required, but different setups may require different commands from the ones shown below.

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

4. Initialize cosmovisor and add all the of the upgrades that you downloaded during [node setup](broken-reference). Change the file paths in the command to match the correct folder path to each binary:

For a genesis sync:

```shell
# set up cosmovisor. Each command is done seperatly.
./cosmovisor init ~/layer/binaries/v4.0.0/layerd
./cosmovisor add-upgrade v4.0.1 ~/layer/binaries/v4.0.1/layerd
./cosmovisor add-upgrade v4.0.3 ~/layer/binaries/v4.0.3/layerd
./cosmovisor add-upgrade v5.0.0 ~/layer/binaries/v5.0.0/layerd
./cosmovisor add-upgrade v5.1.0 ~/layer/binaries/v5.1.0/layerd
./cosmovisor add-upgrade v5.1.1 ~/layer/binaries/v5.1.1/layerd
./cosmovisor add-upgrade v5.1.2 ~/layer/binaries/v5.1.2/layerd
./cosmovisor add-upgrade v6.0.0 ~/layer/binaries/v6.0.0/layerd
```

For a state sync, initialize cosmovisor with the current binary:

```sh
# set up cosmovisor. Each command is done seperatly.
./cosmovisor init ~/layer/binaries/v6.0.0/layerd
```

6. To start your node with cosmovisor managing upgrades:

{% code overflow="wrap" %}
```sh
./cosmovisor run start --home ~/.layer --keyring-backend test --key-name YOUR_ACCOUNT_NAME --api.enable --api.swagger
```
{% endcode %}

Make sure to do `add-upgrade` in advance of future Tellor upgrades to make use of cosmovisor's features.

---
description: If you would like to use cosmovisor...
---

# Cosmovisor Sync

## Prerequisites:

* A Layer node machine configured like [this](./).

## Build and configure Cosmovisor

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

4. Once you have all of the binaries downloaded, initialize Cosmovisor and add all the upgrades. Change the file paths in the command to match the path to each binary exactly:

```shell
# set up cosmovisor. Each command is done seperatly.
./cosmovisor init ~/layer/binaries/v3.0.1/layerd
./cosmovisor add-upgrade ~/layer/binaries/v3.0.2/layerd
```

6. To start your node with cosmovisor managing upgrades:

{% code overflow="wrap" %}
```sh
./cosmovisor run start --api.enable --api.swagger --price-daemon-enabled=false --panic-on-daemon-failure-enabled=false --key-name $ACCOUNT_NAME
```
{% endcode %}

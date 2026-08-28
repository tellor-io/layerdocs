---
description: Setup steps for cosmovisor gang.
---

# Cosmovisor

Cosmovisor is a binary manager that can perform upgrades automatically. It can be configured to automatically download binaries, but this is not recommended! 

## Download and configure Cosmovisor

1. Download the latest cosmovisor binary [cosmovisor v1.5.0](https://github.com/cosmos/cosmos-sdk/releases/tag/cosmovisor%2Fv1.5.0) binary:

{% tabs %}
{% tab title="Linux" %}
```sh
wget https://github.com/cosmos/cosmos-sdk/releases/download/cosmovisor%2Fv1.5.0/cosmovisor-v1.5.0-linux-amd64.tar.gz && tar -xvzf cosmovisor-v1.5.0-linux-amd64.tar.gz
```
{% endtab %}

{% tab title="MacOS" %}
```sh
wget https://github.com/cosmos/cosmos-sdk/releases/download/cosmovisor%2Fv1.5.0/cosmovisor-v1.5.0-darwin-amd64.tar.gz && tar -xvzf cosmovisor-v1.5.0-darwin-amd64.tar.gz
```
{% endtab %}

{% tab title="Linux ARM64" %}
```sh
wget https://github.com/cosmos/cosmos-sdk/releases/download/cosmovisor%2Fv1.5.0/cosmovisor-v1.5.0-linux-arm64.tar.gz && tar -xvzf cosmovisor-v1.5.0-linux-arm64.tar.gz
```
{% endtab %}
{% endtabs %}

2. Add the following to the end of your `~/.bashrc` or `~/.zshrc` file:

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

3. Initialize cosmovisor:

```sh
# Initialize cosmovisor.
./cosmovisor init ~/layer/binaries/v6.1.7/layerd
```

4. Start your node with cosmovisor:

{% code overflow="wrap" %}
```sh
./cosmovisor run start --home ~/.layer --keyring-backend test --key-name YOUR_ACCOUNT_NAME --api.enable --api.swagger
```
{% endcode %}

When a new upgrade is announced, follow the [Binary Upgrades](binary-upgrades.md#upgrading-with-cosmovisor) page to download the binary and run `add-upgrade` before the upgrade height.

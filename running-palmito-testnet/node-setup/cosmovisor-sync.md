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
./cosmovisor init ~/layer/binaries/v6.1.5/layerd
```

4. Start your node with cosmovisor:

{% code overflow="wrap" %}
```sh
./cosmovisor run start --home ~/.layer --keyring-backend test --key-name YOUR_ACCOUNT_NAME --api.enable --api.swagger
```
{% endcode %}

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

---
description: Steps for updating your reporter daemon.
---

# Updating reporterd

{% hint style="success" %}
It's important to keep your Tellor reporter software up-to-date with all the latest feeds so that you can maximize rewards. This is done separately from chain (layerd) upgrades
{% endhint %}

### 1. Stop your reporter.

### 2. Remove the old `reporterd` binary and Configs:

_Be sure to set the correct paths to these files if your setup is different:_

{% code overflow="wrap" %}
```sh
rm ~/layer/binaries/reporter/reporterd
rm ~/layer/binaries/reporter/README.md
rm ~/.layer/config/market_params.toml
rm ~/.layer/config/custom_query_config.toml
rm ~/.layer/config/pricefeed_exchange_config.toml
```
{% endcode %}

### 3. Update your `.env` or service file

If you are upgrading from a version before v0.2.5, update your environment variables to match the current format. Key changes:

* `ETH_RPC_URL_PRIMARY` / `ETH_RPC_URL_FALLBACK` → `BRIDGE_CHAIN_RPC_NODES` (comma-separated list)
* `TOKEN_BRIDGE_CONTRACT` → removed; use `TOKEN_BRIDGE_TEST_CONTRACT` only if you need a custom bridge contract override
* Layer connectivity → `RPC_NODES` and `GRPC_NODES` (comma-separated primary and fallbacks)
* Reporter identity → `LAYER_HOME`, `FROM`, `KEYRING_BACKEND` (and `KEYRING_PASSWORD_FILE` when using `file` keyring)
* On testnet with a non-mainnet bridge chain → add `ETH_MAINNET_RPC_NODES`

Compare your `.env` against the [layer-daemons `env.example`](https://github.com/tellor-io/layer-daemons/blob/v0.2.5/env.example) for the current variable names and defaults.

### 4. Download the latest `reporterd` release

Download [reporterd v0.2.5](https://github.com/tellor-io/layer-daemons/releases/tag/v0.2.5):

{% tabs %}
{% tab title="Linux" %}
{% code overflow="wrap" %}
```sh
mkdir -p ~/layer/binaries/reporter && cd ~/layer/binaries/reporter && wget https://github.com/tellor-io/layer-daemons/releases/download/v0.2.5/reporterd_Linux_x86_64.tar.gz && tar -xvzf reporterd_Linux_x86_64.tar.gz && rm reporterd_Linux_x86_64.tar.gz
```
{% endcode %}
{% endtab %}

{% tab title="Mac" %}
{% code overflow="wrap" %}
```sh
mkdir -p ~/layer/binaries/reporter && cd ~/layer/binaries/reporter && wget https://github.com/tellor-io/layer-daemons/releases/download/v0.2.5/reporterd_Darwin_arm64.tar.gz && tar -xvzf reporterd_Darwin_arm64.tar.gz && rm reporterd_Darwin_arm64.tar.gz
```
{% endcode %}
{% endtab %}
{% endtabs %}

### 5. Restart your reporter

{% code overflow="wrap" %}
```sh
cd ~/layer/binaries/reporter && ./reporterd
```
{% endcode %}

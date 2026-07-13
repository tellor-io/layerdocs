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

Compare your `.env` against the [layer-daemons `env.example`](https://github.com/tellor-io/layer-daemons/blob/v0.2.7/env.example) for the current variable names and defaults.

Compare your `.service` file against the [example reporterd service file](../node-setup/example-.service-files.md) and update your `Environment` settings to match the current variable names and defaults.

### 4. Download the latest `reporterd` release

Download [reporterd v0.2.7](https://github.com/tellor-io/layer-daemons/releases/tag/v0.2.7):

{% tabs %}
{% tab title="Linux" %}
{% code overflow="wrap" %}
```sh
mkdir -p ~/layer/binaries/reporter && cd ~/layer/binaries/reporter && wget https://github.com/tellor-io/layer-daemons/releases/download/v0.2.7/reporterd_Linux_x86_64.tar.gz && tar -xvzf reporterd_Linux_x86_64.tar.gz && rm reporterd_Linux_x86_64.tar.gz
```
{% endcode %}
{% endtab %}

{% tab title="Mac" %}
{% code overflow="wrap" %}
```sh
mkdir -p ~/layer/binaries/reporter && cd ~/layer/binaries/reporter && wget https://github.com/tellor-io/layer-daemons/releases/download/v0.2.7/reporterd_Darwin_arm64.tar.gz && tar -xvzf reporterd_Darwin_arm64.tar.gz && rm reporterd_Darwin_arm64.tar.gz
```
{% endcode %}
{% endtab %}
{% endtabs %}

### 5. Restart your reporter

Note: The `--chain-id` flag has been removed. All other CLI flags are optional when configuration is provided via your `.env` or service file.

{% code overflow="wrap" %}
```sh
cd ~/layer/binaries/reporter && ./reporterd
```
{% endcode %}

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
rm ~/.layer/config/market_params.toml
rm ~/.layer/config/custom_query_config.toml
rm ~/.layer/config/pricefeed_exchange_config.toml
```
{% endcode %}

### 3. Download the latest `reporterd` release

{% tabs %}
{% tab title="Linux" %}
{% code overflow="wrap" %}
```sh
cd ~/layer/binaries/reporter && wget https://github.com/tellor-io/layer/releases/download/reporterd%2Fv0.1.3/reporterd_Linux_x86_64.tar.gz && tar -xvzf reporterd_Linux_x86_64.tar.gz && rm reporterd_Linux_x86_64.tar.gz
```
{% endcode %}
{% endtab %}

{% tab title="Mac" %}
{% code overflow="wrap" %}
```sh
cd ~/layer/binaries/reporter && wget https://github.com/tellor-io/layer/releases/download/reporterd%2Fv0.1.3/reporterd_Darwin_arm64.tar.gz && tar -xvzf reporterd_Darwin_arm64.tar.gz && rm reporterd_Darwin_arm64.tar.gz
```
{% endcode %}
{% endtab %}
{% endtabs %}

### 4. Restart your reporter

{% code overflow="wrap" %}
```sh
./reporterd --chain-id layertest-4 --grpc-addr 0.0.0.0:9090 --from ACCOUNT_NAME --home ~/.layer --keyring-backend test --node tcp://0.0.0.0:26657
```
{% endcode %}

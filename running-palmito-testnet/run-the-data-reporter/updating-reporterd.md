---
description: Steps for updating your reporter daemon.
---

# Updating reporterd

{% hint style="success" %}
It's important to keep your Tellor reporter software up-to-date with all the latest feeds so that you can maximize rewards. This is done separately from chain (layerd) upgrades
{% endhint %}

### 1. Remove the old `reporterd` binary

{% code overflow="wrap" %}
```sh
cd ~/layer/binaries && rm reporterd
```
{% endcode %}

### 2. Remove the old configs

We want to remove the old reporter configurations so that a new ones can be generated with the latest feeds / sources:

```sh
rm ~/.layer/config/market_params.toml
rm ~/.layer/config/custom_query_config.toml
rm ~/.layer/config/market_params.toml
```

### 3. Download the latest `reporterd` release

{% tabs %}
{% tab title="Linux" %}
{% code overflow="wrap" %}
```sh
mkdir -p ~/layer/binaries/reporter && cd ~/layer/binaries/reporter && wget https://github.com/tellor-io/layer/releases/download/reporterd%2Fv0.0.5/reporterd_Linux_x86_64.tar.gz && tar -xvzf reporterd_Linux_x86_64.tar.gz
```
{% endcode %}
{% endtab %}

{% tab title="Mac" %}
{% code overflow="wrap" %}
```sh
mkdir -p ~/layer/binaries/reporter && cd ~/layer/binaries/reporter && wget https://github.com/tellor-io/layer/releases/download/reporterd%2Fv0.0.5/reporterd_Darwin_arm64.tar.gz && tar -xvzf reporterd_Darwin_arm64.tar.gz
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

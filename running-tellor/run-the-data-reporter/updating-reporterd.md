---
description: Steps for updating your reporter daemon.
---

# Updating reporterd

{% hint style="success" %}
It's important to keep your Tellor reporter software up-to-date with all the latest feeds so that you can maximize rewards. This is done separately from chain (layerd) upgrades
{% endhint %}

{% hint style="warning" %}
**Upcoming v6.1.4 Chain Upgrade** 🚀

Hi everyone!

The v6.1.4 chain upgrade is scheduled for **Monday, April 13, 2026**.&#x20;

Countdown site here: https://layer-node.com/gov-proposals/mainnet

**What to do:**

1. **Upgrade your reporter clients to v0.1.6** before the upgrade date to ensure everything runs smoothly.
2. **Pause your bridge usage** from 24 hours before until 24 hours after the upgrade to avoid losing funds!
3. **Watch the** [**Discord**](https://discord.gg/vYJ7STXe) for the new TRBBridgeV2 contract address. Once announced, you'll need to update your reporter's bridge contract setting so operations can resume quickly.

Thanks for staying on top of this! Let us know if you have any questions.
{% endhint %}

### 1. Stop your reporter.

### 2. Remove the old `reporterd` binary and Configs:

_Your file paths may be different. Remember to adjust as needed to remove the files:_

{% code overflow="wrap" %}
```sh
rm -rf ~/layer/binaries/reporter/reporterd
rm -rf ~/layer/binaries/reporter/readme.md
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
cd ~/layer/binaries/reporter && wget https://github.com/tellor-io/layer-daemons/releases/download/v0.1.6/reporterd_Linux_x86_64.tar.gz && tar -xvzf reporterd_Linux_x86_64.tar.gz && rm reporterd_Linux_x86_64.tar.gz
```
{% endcode %}
{% endtab %}

{% tab title="Mac" %}
{% code overflow="wrap" %}
```sh
cd ~/layer/binaries/reporter && wget https://github.com/tellor-io/layer-daemons/releases/download/v0.1.6/reporterd_Darwin_arm64.tar.gz && tar -xvzf reporterd_Darwin_arm64.tar.gz && rm reporterd_Darwin_arm64.tar.gz
```
{% endcode %}
{% endtab %}
{% endtabs %}

### 4. Restart your reporter

{% code overflow="wrap" %}
```sh
./reporterd --chain-id layertest-5 --grpc-addr 0.0.0.0:9090 --from ACCOUNT_NAME --home ~/.layer --keyring-backend test --node tcp://0.0.0.0:26657
```
{% endcode %}

---
description: Steps for updating your reporter daemon.
---

# Updating reporterd

{% hint style="success" %}
It's important to keep your Tellor reporter software up-to-date with all the latest feeds so that you can maximize rewards. This is done separately from chain (layerd) upgrades
{% endhint %}

### 1. Rebuild the `reporterd` binary

Navigate to your layer directory and build the new binary:

```sh
cd ~/layer/daemons && make build
```

Move the binary to it's expected location (your setup may be different).

{% code overflow="wrap" %}
```sh
cp bin/reporterd ~/layer/binaries/v5.1.1 && cd ~/layer/binaries/v5.1.1
```
{% endcode %}

### 2. Remove the old `market_params.toml` config

We want to remove the old reporter configuration so that a new one can be generated with the latest feeds / sources:

```sh
rm ~/.layer/config/market_params.toml
```

### 3. Restart your reporter

{% code overflow="wrap" %}
```sh
./reporterd --chain-id layertest-4 --grpc-addr 0.0.0.0:9090 --from ACCOUNT_NAME --home ~/.layer --keyring-backend test --node tcp://0.0.0.0:26657
```
{% endcode %}

---
description: Example commands for common actions with all required flags.
---

# Commands Reference

To send tokens:

```
./layerd tx bank send $ACCOUNT_NAME <recipients_address> <amount>loya --fees 5loya
```

Add the `--node` flag to any command if you don't have a local node. Here's a full example of a send tx for 123 TRB using remote RPC:

{% code overflow="wrap" %}
```bash
./layerd tx bank send $ACCOUNT_NAME tellor18wjwgr0j8pv4ektdaxvzsykpntdylftwz8ml97 123000000loya --fees 10loya --node=http://tellorlayer.com:26657
```
{% endcode %}

To delegate to a validator:

{% code overflow="wrap" %}
```bash
./layerd tx staking delegate tellorvaloper1dct4uwgcfjxqaphjmfzjv2yz733n9fycxdz2m6 123000000loya --from $ACCOUNT_NAME --fees 5loya --chain-id layertest-2
```
{% endcode %}

To select a reporter with your bonded token power (must be delegated to a validator first):

{% code overflow="wrap" %}
```bash
./layerd tx reporter select-reporter tellor148zgkh394d382g4rft3dhlv32wx0g6r743vv4q --from selector_guy --chain-id layertest-2 --fees 10loya --node=http://layer-node.com:26758
```
{% endcode %}

To start layer as a validator /reporter:

{% code overflow="wrap" %}
```sh
./layerd start --api.enable --api.swagger --price-daemon-enabled=true --panic-on-daemon-failure-enabled=false --key-name $ACCOUNT_NAME --home ~/.layer
```
{% endcode %}

Start layer with cosmovisor:

{% code overflow="wrap" %}
```sh
./cosmovisor run start --api.enable --api.swagger --price-daemon-enabled=false --panic-on-daemon-failure-enabled=false --key-name $ACCOUNT_NAME --home ~/.layer
```
{% endcode %}

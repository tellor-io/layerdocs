# Create a Reporter

_Once you’re successfully running a validator, you’re almost a reporter already!_&#x20;

This section assumes that you have a [node](run-a-layer-node.md) / [validator](become-a-validator.md) already. Run the command:

```bash
./layerd tx reporter create-reporter "100000000000000000" "1000000" --from $ACCOUNT_NAME --keyring-backend $KEYRING_BACKEND --chain-id layer --home $LAYERD_NODE_HOME --keyring-dir $LAYERD_NODE_HOME
```

Restart your node again, changing `--price-daemon-enabled` to be `true` to turn on the price daemon:

```bash
./layerd start --home $LAYERD_NODE_HOME --api.enable --api.swagger --price-daemon-enabled=true --panic-on-daemon-failure-enabled=false
```

## Jailing (and unjail-ing)

_Jailing can happen for various reasons (such as inactivity) while we work out the kinks. It's part of the process! Here is how you can get out if it happens to you._ \
\
Make sure your terminal window (shell) has all the variables loaded before trying to do these txs.&#x20;

### Steps to unjail:

{% hint style="info" %}
Read all steps first because you have about 4 minutes to do everything or you will be jailed again for inactivity:
{% endhint %}

1. stop your node / validator / reporter with and start it back up as a node / validator (turning off the reporter):

```bash
./layerd start --home $LAYERD_NODE_HOME --api.enable --api.swagger --price-daemon-enabled=false --panic-on-daemon-failure-enabled=false
```

2. enter the unjail the command:

```bash
./layerd tx slashing unjail --from $TELLOR_ADDRESS --chain-id layer --home $LAYERD_NODE_HOME --keyring-backend test --keyring-dir $LAYERD_NODE_HOME
```

3. Restart the node with reporter daemon turned on:

```bash
./layerd start --home $LAYERD_NODE_HOME --api.enable --api.swagger --price-daemon-enabled=true --panic-on-daemon-failure-enabled=false
```

\

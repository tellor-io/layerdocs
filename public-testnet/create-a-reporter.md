# Create a Reporter

Once you’re successfully running a validator, you’re almost a reporter already! Just one more command:

```
./layerd tx reporter create-reporter "100000000000000000" "1000000" --from $ACCOUNT_NAME --keyring-backend $KEYRING_BACKEND --chain-id layer --home $LAYERD_NODE_HOME
```

Restart your node again, but this time we will change the command a bit to turn on the price daemon:

```
./layerd start --home $LAYERD_NODE_HOME --api.enable --api.swagger --price-daemon-enabled=true --panic-on-daemon-failure-enabled=false
```

> Layer testnet is still experimental, and jailing can happen for various reasons while we work out the kinks. Make sure your terminal window (shell) has all the variables loaded before trying to build txs.&#x20;

## Steps to unjail:

{% hint style="info" %}
Read all steps first because you have about 4 minutes to do everything or you will be jailed again for inactivity:
{% endhint %}

1. stop your node / validator / reporter with and start it back up as a node / validator (turning off the reporter):

```
./layerd start --home $LAYERD_NODE_HOME --api.enable --api.swagger --price-daemon-enabled=false --panic-on-daemon-failure-enabled=false
```

2. enter the unjail the command:

```
./layerd tx slashing unjail --from $TELLOR_ADDRESS --chain-id layer --home $LAYERD_NODE_HOME --keyring-backend test --keyring-dir $LAYERD_NODE_HOME
```

3. Restart the node with reporter daemon turned on:

```
./layerd start --home $LAYERD_NODE_HOME --api.enable --api.swagger --price-daemon-enabled=true --panic-on-daemon-failure-enabled=false
```

\

# Create a Reporter

_Once you’re successfully running a validator, you’re almost a reporter already!_&#x20;

This section assumes that you have a [node](run-layer/) and [validator](run-a-layer-validator/) running already. Run the command:

{% code overflow="wrap" %}
```bash
./layerd tx reporter create-reporter "200000" "1000000" --from darth_vader --chain-id layertest-2 --fees 10loya --yes
```
{% endcode %}

Restart your node again, changing `--price-daemon-enabled` to be `true` to turn on the price daemon:

{% code overflow="wrap" %}
```bash
./layerd start --api.enable --api.swagger --price-daemon-enabled=true --panic-on-daemon-failure-enabled=false --home $HOME/.layer --key-name $ACCOUNT_NAME
```
{% endcode %}

## Jailing (and unjail-ing)

_Jailing can happen for various reasons (such as inactivity) while we work out the kinks. It's part of the process! Here is how you can get out if it happens to you._ \
\
Make sure your terminal window (shell) has all the variables loaded before trying to do these txs.&#x20;

### Steps to unjail:

{% hint style="info" %}
Read all steps first because you have about 4 minutes to do everything or you will be jailed again for inactivity:
{% endhint %}

1. stop your node / validator / reporter with and start it back up as a node / validator (turning off the reporter):

{% code overflow="wrap" %}
```bash
./layerd start --api.enable --api.swagger --price-daemon-enabled=false --panic-on-daemon-failure-enabled=false --home $HOME/.layer --key-name $ACCOUNT_NAME
```
{% endcode %}

2. enter the unjail the command:

{% code overflow="wrap" %}
```bash
./layerd tx slashing unjail --from $TELLOR_ADDRESS --chain-id layertest-1 --fees 1000loya
```
{% endcode %}

3. Restart the node with reporter daemon turned on:

{% code overflow="wrap" %}
```bash
./layerd start --api.enable --api.swagger --price-daemon-enabled=true --panic-on-daemon-failure-enabled=false --home $HOME/.layer --key-name $ACCOUNT_NAME
```
{% endcode %}

\

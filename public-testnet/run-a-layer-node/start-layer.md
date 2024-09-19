# Start Layer

{% hint style="success" %}
_<mark style="color:green;">**Before starting your node**</mark><mark style="color:green;">,</mark> it's a good idea to think about how you want to run it so that the process does not get killed accidentally._ [_GNU screen_](https://tellor.io/blog/how-to-manage-cli-applications-on-hosted-vms-with-screen/) _is a great option for beginners. More advanced setups can be achieved using systemd._
{% endhint %}

Start layer with the command:

{% code overflow="wrap" %}
```sh
./layerd start --api.enable --api.swagger --price-daemon-enabled=false --panic-on-daemon-failure-enabled=false --home /home/admin/.layer --key-name $ACCOUNT_NAME
```
{% endcode %}

If your node was configured successfully, you should see the node connecting to end points before rapidly downloading blocks.  Please allow time for the node to sync before moving onto setting up a validator.

### (Optional) Cosmovisor Start

If you set up your node with cosmovisor, start layer using the command:

{% code overflow="wrap" %}
```sh
./cosmovisor run start --api.enable --api.swagger --price-daemon-enabled=false --panic-on-daemon-failure-enabled=false --home /home/admin/.layer --key-name $ACCOUNT_NAME
```
{% endcode %}

## Check Sync Status

To check if your node is synced:

```bash
./layerd status
```

* If `"catching_up": true`, your node is not synced.&#x20;
* If `"catching_up": false`, your node is synced!

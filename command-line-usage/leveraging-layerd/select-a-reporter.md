# Select a Reporter

This is the command for stakers who back a reporter of their choice. For the full staking walkthrough (and how to choose a reporter), see [Delegating and Selecting](../../bridging-trb/delegating-and-selecting.md).

{% code overflow="wrap" %}
```sh
# layerd tx reporter select-reporter [reporter-address] [flags]
# Example selecting reporter tellor148zgkh394dexamplex0g6r743vv4q
./layerd tx reporter select-reporter tellor148zgkh394dexamplex0g6r743vv4q --from YOUR_ACCOUNT_NAME --fees 5loya --chain-id tellor-1 --node https://mainnet.tellorlayer.com/rpc/
```
{% endcode %}

{% hint style="info" %}
On the Palmito testnet, use `--chain-id layertest-5 --node https://node-palmito.tellorlayer.com/rpc/` instead.
{% endhint %}

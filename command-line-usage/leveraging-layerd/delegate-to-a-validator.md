# Delegate to a Validator

This is the command for stakers who delegate their stake to a validator instead of running one. For the full staking walkthrough (and how to choose a validator), see [Delegating and Selecting](../../bridging-trb/delegating-and-selecting.md).

{% code overflow="wrap" %}
```sh
# layerd tx staking delegate [validator-addr] [amount] [flags]
# example delegating 12 TRB to tellorvaloper1dct4uwgcfjxqaphjm33n9fycxdz2m6
./layerd tx staking delegate tellorvaloper1dct4uwgcfjxqaphjm33n9fycxdz2m6 12000000loya --from YOUR_ACCOUNT_NAME --fees 5loya --chain-id tellor-1 --node https://mainnet.tellorlayer.com/rpc/
```
{% endcode %}

{% hint style="info" %}
On the Palmito testnet, use `--chain-id layertest-5 --node https://node-palmito.tellorlayer.com/rpc/` instead.
{% endhint %}

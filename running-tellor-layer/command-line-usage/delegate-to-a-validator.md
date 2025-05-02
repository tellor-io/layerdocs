# Delegate to a Validator

When you delegate to a validator you will increase their power while earning rewards minus that validators commission.&#x20;

When you delegate to a validator, losses can occur due to that validator's inactivity or misbehavior.&#x20;

Be sure to select a validator that you trust!

{% code overflow="wrap" %}
```sh
# layerd tx staking delegate [validator-addr] [amount] [flags]
# example delegating 12 TRB to tellorvaloper1dct4uwgcfjxqaphjm33n9fycxdz2m6
./layerd tx staking delegate tellorvaloper1dct4uwgcfjxqaphjm33n9fycxdz2m6 12000000loya --from YOUR_ACCOUNT_NAME --fees 5loya --chain-id layertest-4 --node https://node-palmito.tellorlayer.com/rpc/
```
{% endcode %}

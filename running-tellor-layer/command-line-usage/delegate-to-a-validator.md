# Delegate to a Validator

Follow these steps to delegate your tokens on the test chain. We will use a remote rpc so that you do not need to run a node locally.

### Create the delegate tx

The following is an example command:

{% code overflow="wrap" %}
```sh
# layerd tx staking delegate [validator-addr] [amount] [flags]
# example delegating 12 TRB to tellorvaloper1dct4uwgcfjxqaphjm33n9fycxdz2m6
./layerd tx staking delegate tellorvaloper1dct4uwgcfjxqaphjm33n9fycxdz2m6 12000000loya --from YOUR_ACCOUNT_NAME --fees 5loya --chain-id layertest-4 --node https://node-palmito.tellorlayer.com/rpc/
```
{% endcode %}

# Delegate to a Validator

Follow these steps to delegate your tokens on the test chain. We will use a remote rpc so that you do not need to run a node locally.

### Create the delegate tx

1. The following is an example command:

{% code overflow="wrap" %}
```sh
# e.g. for delegate to tellorvaloper1dct4uwgcfjxqaphjm33n9fycxdz2m6
./layerd tx staking delegate tellorvaloper1dct4uwgcfjxqaphjm33n9fycxdz2m6 123000000loya --from $ACCOUNT_NAME --fees 5loya --chain-id layertest-2
```
{% endcode %}

_Be sure to customize the "_tellorvaloper" prefix _address of the person you want to delegate to, the amount that you want to deligate. The loya amount has 6 decimals (e.g._ 10000000loya = 10 TRB)

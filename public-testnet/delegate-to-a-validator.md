# Delegate to a Validator

Follow these steps to delegate your tokens on the test chain. We will use a remote rpc so that you do not need to run a node; however, it is still necessary to build `layerd` locally and configure accounts so that you can run layer commands.

### Create the delegate tx

1. The following is an example command:

{% code overflow="wrap" %}
```sh
./layerd tx staking delegate tellorvaloper_address_of_delegate 10000000loya --gas auto --from $ACCOUNT_NAME --node=http://tellornode.com:26657 --chain-id layertest-1 --fees 1000loya
```
{% endcode %}

_Be sure to customize the "_tellorvaloper" prefix _address of the person you want to delegate to, the amount that you want to deligate. The loya amount has 6 decimals (e.g._ 10000000loya = 10 TRB)

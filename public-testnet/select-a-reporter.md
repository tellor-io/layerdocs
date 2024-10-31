# Select a reporter

Follow these steps to select a reporter to increase their reporting power and recieve rewards minus the reporter's commision. We will use a remote rpc so that you do not need to run a local node.

### Create the select-reporter tx

{% code overflow="wrap" %}
```sh
# if selecting tellor148zgkh394d382g4rft3dhl2wx0g6r743vv4q
./layerd tx reporter select-reporter tellor148zgkh394d382g4rft3dhl2wx0g6r743vv4q --from $ACCOUNT_NAME --chain-id layertest-2 --fees 5loya --node=http://layer-node.com:26758
```
{% endcode %}

_Be sure to customize the "_tellor" prefix _address of the person you want to delegate to, the amount that you want to deligate. The loya amount has 6 decimals (e.g._ 10000000loya = 10 TRB)

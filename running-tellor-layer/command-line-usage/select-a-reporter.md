# Select a Reporter

When you select a reporter you increase their reporting power while earning rewards minus the reporter's commission. \
\
When you select a reporter, losses can occur if that reporter is disputed.&#x20;

Be sure to select an active reporter who you trust!

{% code overflow="wrap" %}
```sh
# layerd tx reporter select-reporter [reporter-address] [flags]
# Example selecting reporter tellor148zgkh394d382g4rft3dhl2wx0g6r743vv4q
./layerd tx reporter select-reporter tellor148zgkh394d382g4rft3dhl2wx0g6r743vv4q --from YOUR_ACCOUNT_NAME --fees 5loya --chain-id layertest-4 --node=http://layer-node.com:26758
```
{% endcode %}

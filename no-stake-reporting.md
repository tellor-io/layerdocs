---
description: Report data to the chain. No stake required.
icon: door-open
---

# No-Stake Reporting

As of v5.0.0, anyone from the anywhere may report oracle data to Tellor Layer as a "no-stake" report. No-stake reports are different from regular reports because they are not aggregated on chain, and they cannot be disputed.

The query data and value for a no-stake report can be any abi encoded data in hexadecimal format.

To create a no-stake report using the cli, use the oracle module's no-stake-report command:

{% code overflow="wrap" %}
```shell
# layerd tx oracle no-stake-report [query_data] [value] [flags]

./layerd tx oracle no-stake-report 000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000735768617420646f20796f752063616c6c206120636f6e73656e7375616c2068616c6c7563696e6174696f6e20657870657269656e636564206461696c792062792062696c6c696f6e73206f66206c65676974696d617465206f70657261746f72732c20696e206576657279206e6174696f6e2e00000000000000000000000000 00000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000032637962657273706163652c20746865206d61747269782c2074686520677269642c2074656c6c6f72206d617962652069646b0000000000000000000000000000 --from telliot_layer --fees 5loya --chain-id tellor-1
```
{% endcode %}


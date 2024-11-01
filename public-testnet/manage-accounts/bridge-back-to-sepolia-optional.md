# Bridge back to Sepolia (optional)

First, request withdraw of your tokens from layer to sepolia. In this example, the layer address is `tellor1suuc9d5dr5stps5tzjv5d95ur02827ardn5` and the ethereum address that we want to withdraw to is `0x7660794eF8f978Ea0922DC29B4d93e1fc94A`:

{% code overflow="wrap" %}
```bash
./layerd tx bridge withdraw-tokens tellor1suuc9d5dr5stps5tzjv5d95ur02827ardn5 7660794eF8f978Ea0922DC29B4d93e1fc94A 69010069loya --fees 5loya
```
{% endcode %}


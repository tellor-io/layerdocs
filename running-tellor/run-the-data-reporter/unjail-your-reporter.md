---
description: 'Example command to unjail your reporter:'
---

# Unjail Your Reporter

In the event of a dispute, your reporter will be jailed.&#x20;

If the dispute is just a warning, you can unjail right away. The command to do this is:

{% code overflow="wrap" %}
```sh
# layerd tx reporter unjail-reporter [flags]
./layerd tx reporter unjail-reporter --from ACCOUNT_NAME --fees 5loya --chain-id tellor-1
```
{% endcode %}

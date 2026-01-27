---
description: Steps for changing your reporter selection.
---

# Switch Reporter or Selector

Note: Using the switch-reporter command will lock your stake for 21 days to prevent bridge manipulation. After the waiting period ends, your stake becomes active again and is reassigned to the new reporter address.

The following command can be used to change your reporter selection:

{% code overflow="wrap" %}
```sh
./layerd tx reporter switch-reporter NEW_REPORTER_ADDRESS --from OLD_REPORTER_ADDRESS --fees 5loya --chain-id layertest-4
```
{% endcode %}


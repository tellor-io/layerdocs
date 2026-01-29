---
description: Steps for changing your reporter selection.
---

# Switch Reporter or Selector

Note: Reporters who want to "retire" and become selectors must wait 21 days to prevent bridge manipulation.

The following command can be used to change your reporter selection:

{% code overflow="wrap" %}
```sh
./layerd tx reporter switch-reporter NEW_REPORTER_ADDRESS --from OLD_REPORTER_ADDRESS --fees 5loya --chain-id layertest-4
```
{% endcode %}


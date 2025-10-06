---
description: Steps for changing your reporter selection.
---

# Switch Reporter or Selector

The following command can be used to change your reporter selection:

{% code overflow="wrap" %}
```sh
./layerd tx reporter switch-reporter NEW_REPORTER_ADDRESS --from OLD_REPORTER_ADDRESS --fees 5loya --chain-id tellor-1
```
{% endcode %}

Note: To prevent bridge manipulation, reporters are not allowed to do `switch-reporter` for reporter addresses that have reported data in the passed 21 days.


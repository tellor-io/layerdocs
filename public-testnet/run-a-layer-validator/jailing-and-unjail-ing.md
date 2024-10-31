---
description: whoops!
---

# Jailing (and unjail-ing)

_Jailing can happen for various reasons (such as inactivity). It's part of the testing process! Here is how you can get out if it happens to you._ \
\
Make sure your terminal window (shell) has all the variables loaded before trying to do these txs.&#x20;

{% code overflow="wrap" %}
```bash
./layerd tx slashing unjail --from $ACCOUNT_NAME --fees 5loya --yes
```
{% endcode %}

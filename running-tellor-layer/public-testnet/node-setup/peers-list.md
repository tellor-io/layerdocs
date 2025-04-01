---
description: The following peers list can be used for syncing `layertest-3`
---

# Peers List

{% hint style="info" %}
If you followed the Node Setup section of these docs, you already have the latest peers list.
{% endhint %}

In your `~/.layerd/config/config.toml` file:

{% code overflow="wrap" %}
```json
# Comma separated list of seed nodes to connect to
seeds = "c7b175a5bafb35176cdcba3027e764a0dbd0811c@34.219.95.82:26656,05105e8bb28e8c5ace1cecacefb8d4efb0338ec6@18.218.114.74:26656,705f6154c6c6aeb0ba36c8b53639a5daa1b186f6@3.80.39.230:26656,1f6522a346209ee99ecb4d3e897d9d97633ae146@3.101.138.30:26656,3822fa2eb0052b36360a7a6e285c18cc92e26215@175.41.188.192:26656"

# Comma separated list of nodes to keep persistent connections to
persistent_peers = "c7b175a5bafb35176cdcba3027e764a0dbd0811c@34.219.95.82:26656,05105e8bb28e8c5ace1cecacefb8d4efb0338ec6@18.218.114.74:26656,705f6154c6c6aeb0ba36c8b53639a5daa1b186f6@3.80.39.230:26656,1f6522a346209ee99ecb4d3e897d9d97633ae146@3.101.138.30:26656,3822fa2eb0052b36360a7a6e285c18cc92e26215@175.41.188.192:26656"

```
{% endcode %}

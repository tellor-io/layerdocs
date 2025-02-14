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
seeds = "f4786bc2a40172e29784b9f8d69567c474de8a8c@13.212.32.99:26656,7f2c8cad741c28d7a01d9f1cf2e1a87eb751afa3@52.53.226.18:26656,d87d655453277514d150df82e6305b307f138d06@54.234.103.186:26656,59fd40b86c9b65ca717b29ce37b08fdb82c8e61d@3.144.113.220:26656"

# Comma separated list of nodes to keep persistent connections to
persistent_peers = "f4786bc2a40172e29784b9f8d69567c474de8a8c@13.212.32.99:26656,7f2c8cad741c28d7a01d9f1cf2e1a87eb751afa3@52.53.226.18:26656,d87d655453277514d150df82e6305b307f138d06@54.234.103.186:26656,59fd40b86c9b65ca717b29ce37b08fdb82c8e61d@3.144.113.220:26656"

```
{% endcode %}

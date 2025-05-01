---
description: Using the Query Builder
---

# Generate Tellor Query Ids

Navigate to [https://tellor.io/queryidstation/](https://tellor.io/queryidstation/).

_**This tool can bse used to generate the Query Data and Query Id for any Tellor data. Here's how to do it for Tellor Layer bridge transactions.**_

* Click on custom query.
* Enter `TRBBridge` for the type.
* add a `bool` parameter. Set it to true for requests "to layer". Set this to "false" for withdraw requests.
* add a uint256 parameter for the deposit Id.

See image below:

<figure><img src="../../../.gitbook/assets/Screenshot From 2025-04-01 21-18-22.png" alt=""><figcaption><p>Great!</p></figcaption></figure>

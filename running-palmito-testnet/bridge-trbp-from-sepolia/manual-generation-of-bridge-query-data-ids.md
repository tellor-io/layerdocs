---
description: Just in case
---

# Manual Generation of Bridge Query Data / IDs

Navigate to [https://tellor.io/queryidstation/](https://tellor.io/queryidstation/).

_**This tool can be used to generate many different types of Query Data and Query Id for any Tellor data. Here's how to do it for Tellor  bridge transactions.**_

* Click on custom query.
* Enter `TRBBridge` for the type.
* add a `bool` parameter. Set it to true for requests "to layer". Set this to "false" for withdraw requests.
* add a uint256 parameter for the deposit Id.

See image below:

<figure><img src="../../.gitbook/assets/Screenshot From 2025-04-01 21-18-22.png" alt=""><figcaption><p>Great!</p></figcaption></figure>

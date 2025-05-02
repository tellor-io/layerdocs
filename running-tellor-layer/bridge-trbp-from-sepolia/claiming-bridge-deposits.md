---
description: Earn tips for running claim-deposit for others!
hidden: true
---

# Claiming Bridge Deposits

_**The claim transaction for an individual bridge request can be claimed (12 hours after deposit on Ethereum) by the first person who is willing to do the work to earn the tip. Follow the steps in this section to claim bridge deposits using the command line interface.**_

{% hint style="warning" %}
<mark style="color:blue;">**You must have a balance on Tellor Layer to claim tips for bridge deposits.**</mark>
{% endhint %}

1\) Find the queryId for the unclaimed bridge deposit. This is covered in another section of this documentation ([here](manual-generation-of-bridge-query-data-ids.md)).

2\) Find a timestamp for the aggregate report of the bridge deposit:

{% code overflow="wrap" %}
```shell
# Note: remove the '0x' from the beginning of the Query ID
# layerd query oracle get-current-aggregate-report [query_id] [flags]
./layerd query oracle get-current-aggregate-report 97e25476d1379dcf4958abe62e2bd81b13adc63d42b908fb1252de268fe365cf
```
{% endcode %}

The output will be something like this:

```
aggregate:
  aggregate_power: "5039"
  aggregate_reporter: tellor10usyr7v4xe2uhtnvg4kwtgtuzh5e4u2378zjj9
  aggregate_value: 0000000000000000000000007660794ef8f978ea0922dc29b3b534d93e1fc94a00000000000000000000000000000000000000000000000000000000000000800000000000000000000000000000000000000000000000000de0b6b3a764000000000000000000000000000000000000000000000000000000b1a2bc2ec50000000000000000000000000000000000000000000000000000000000000000002d74656c6c6f7231376763363771303564357267737a3963617a6e6d307337733565617a7767326533666b6b386500000000000000000000000000000000000000
  height: "730695"
  index: "3"
  meta_id: "364368"
  micro_height: "728705"
  query_id: U1sUehYNt1FpYPtqD/phWE5UMCSuURxRN+Gv0TVOXlw=
timestamp: "1743606083967"
```

Make a note of the timestamp for step 3.

3\) Call claim-deposit:

{% code overflow="wrap" %}
```sh
# layerd tx bridge claim-deposits [creator] [deposit-ids] [timestamps] [flags]
./layerd tx bridge claim-deposits YOUR_TELLOR_PREFIX_ADDRESS 3 1738788758751 --from ACCOUNT_NAME --gas auto --chain-id layertest-4 --fees 10loya --yes
```
{% endcode %}

You should see your new balance reflected when you run the command:

{% code overflow="wrap" %}
```sh
./layerd query bank balance $TELLOR_ADDRESS loya
```
{% endcode %}

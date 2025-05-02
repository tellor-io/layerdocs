---
description: How to get your funds back to Ethereum (Sepolia)
---

# Bridge TRB back to Sepolia

#### **1. Use the CLI to Request a Withdrawal**&#x20;

In the following example command, our Tellor address is `tellor1suuc9d5dr5stps5tzjv5d95ur02827ardn5` and the ethereum address that we want to withdraw to is `0x7660794eF8f978Ea0922DC29B4d93e1fc94A`. (Adjust these two parameters to match your addresses.)

{% code overflow="wrap" %}
```sh
# layerd tx bridge withdraw-tokens [creator] [recipient] [amount] [flags]
./layerd tx bridge withdraw-tokens tellor1suuc9d5dr5stps5tzjv5d95ur02827ardn5 7660794eF8f978Ea0922DC29B4d93e1fc94A 69010069loya --from YOUR_ACCOUNT_NAME --fees 5loya --chain-id layertest-4
```
{% endcode %}

_Save the transaction hash from the output._&#x20;

#### 2. Gather information about your request

Use the command:

{% code overflow="wrap" %}
```sh
./layerd query tx --type=hash <YOUR_TRANSACTION_HASH> | grep -A 1 -e raw_log -e query_id -e withdraw_id
```
{% endcode %}

Copy the output to use later. It should look similar to this:

```
    key: query_id
    value: 866997ed9d1a463f0ce8ba1d55a6b7545ba1e4ba1292ae502b6a859b5e1d3a5d
--
    key: withdraw_id
    value: "8"
--
raw_log: ""
timestamp: "2025-05-02T16:11:27Z"
```

#### **3. Wait 12 hours.**

There is a 12 hour delay for bridge requests to and from Tellor.

#### 4. Find the timestamp of the aggregate report  using the query\_id from step 1:

<pre class="language-sh" data-overflow="wrap"><code class="lang-sh"># layerd query oracle get-current-aggregate-report [query_id] [flags]
<strong>./layerd query oracle get-current-aggregate-report &#x3C;your_query_id_from_step_2>
</strong></code></pre>

This will output information about the report. Copy the `timestamp` for step 4.

**4. Request attestations for your withdraw request report:**

{% code overflow="wrap" %}
```bash
# layerd tx bridge request-attestations [creator] [query_id] [timestamp] [flags]
./layerd tx bridge request-attestations $TELLOR_ADDRESS <query_id_from_step2> <timestamp_from_step_3> --from $ACCOUNT_NAME --chain-id layertest-4 --fees 50loya --yes
```
{% endcode %}

{% hint style="info" %}
Behind the scenes, py-relayer is used to send attestation information back to the bridge contract on Sepolia. As long as gas costs on the network are not egregious, `withdrawFromLayer` will be called automatically!
{% endhint %}

**5.  Check your balance on Sepolia!**

---
description: How to get your funds back to Ethereum (Sepolia)
---

# Bridge TRB back to Sepolia

**1. Request withdraw of your tokens on Layer via the cli.**&#x20;

In this example, the layer address is `tellor1suuc9d5dr5stps5tzjv5d95ur02827ardn5` and the ethereum address that we want to withdraw to is `0x7660794eF8f978Ea0922DC29B4d93e1fc94A`:

{% code overflow="wrap" %}
```bash
# layerd tx bridge withdraw-tokens [creator] [recipient] [amount] [flags]
./layerd tx bridge withdraw-tokens tellor1suuc9d5dr5stps5tzjv5d95ur02827ardn5 7660794eF8f978Ea0922DC29B4d93e1fc94A 69010069loya --from YOUR_ACCOUNT_NAME --fees 5loya
```
{% endcode %}

Copy the transaction hash of this withdraw-tokens transaction from the output.

\
We need to query the result and copy two pieces of information: the `query_id` and the `withdraw_id`

{% code overflow="wrap" %}
```bash
# to get the queryId
./layerd query tx --type=hash <your_tx_hash> | grep -A 1 "query_id"

# to get the withdraw_id
./layerd query tx --type=hash <your_tx_hash> | grep -A 1 "withdraw_id"
```
{% endcode %}

Save these to be used in step 3...

{% hint style="info" %}
_<mark style="color:blue;">**Your withdraw request will be automatically reported on layer.**</mark>_&#x20;
{% endhint %}

#### 2. Wait 12 hours.

#### 3. Find the timestamp of the aggregate report  using the query\_id from step 1:

<pre class="language-sh" data-overflow="wrap"><code class="lang-sh"># layerd query oracle get-current-aggregate-report [query_id] [flags]
<strong>./layerd query oracle get-current-aggregate-report &#x3C;your_query_id_from_step_2>
</strong></code></pre>

This will output information about the report. Copy the `timestamp` for step 4.

#### 4. Request attestations for your withdraw request report:

{% code overflow="wrap" %}
```bash
# layerd tx bridge request-attestations [creator] [query_id] [timestamp] [flags]
./layerd tx bridge request-attestations $TELLOR_ADDRESS <query_id_from_step2> <timestamp_from_step_3> --from $ACCOUNT_NAME --chain-id layertest-4 --fees 50loya --yes
```
{% endcode %}

{% hint style="info" %}
Behind the scenes, py-relayer is used to send attestation information back to the bridge contract on Sepolia. As long as gas costs on the network are not egregious, `withdrawFromLayer` will be called automatically!
{% endhint %}

#### 5.  Check your balance on Sepolia!

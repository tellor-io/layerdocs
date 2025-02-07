# Bridge back to Sepolia

1. Request withdraw of your tokens from layer to sepolia. In this example, the layer address is `tellor1suuc9d5dr5stps5tzjv5d95ur02827ardn5` and the ethereum address that we want to withdraw to is `0x7660794eF8f978Ea0922DC29B4d93e1fc94A`:

{% code overflow="wrap" %}
```bash
./layerd tx bridge withdraw-tokens tellor1suuc9d5dr5stps5tzjv5d95ur02827ardn5 7660794eF8f978Ea0922DC29B4d93e1fc94A 69010069loya --from YOUR_ACCOUNT_NAME --fees 5loya
```
{% endcode %}

2. Copy the transaction hash of this withdraw-tokens transaction. We need to query the result and copy two pieces of information: the `query_id` and the `withdraw_id`

{% code overflow="wrap" %}
```bash
# to get the queryId
./layerd query tx --type=hash <your_tx_hash> | grep -A 1 "query_id"

# to get the withdraw_id
./layerd query tx --type=hash <your_tx_hash> | grep -A 1 "withdraw_id"
```
{% endcode %}

Save these handy to be used later...

2. Wait 12 hours.

{% hint style="info" %}
_<mark style="color:blue;">**While you wait, your withdraw request will automatically reported on layer.**</mark>_

_<mark style="color:blue;">**Next, we will find the timestamp of that report.**</mark>_
{% endhint %}

3. To find the timestamp of the aggregate report, use the query\_id from step 2:

{% code overflow="wrap" %}
```bash
./layerd query oracle get-current-aggregate-report <your_query_id_from_step_2>
```
{% endcode %}

This will print information about the report. Copy the timestamp for the next step.

4. Request attestations for your withdraw request report:

{% code overflow="wrap" %}
```bash
./layerd tx bridge request-attestations $TELLOR_ADDRESS <query_id_from_step2> <timestamp_from_step_3> --from $ACCOUNT_NAME --chain-id layertest-3 --fees 50loya --yes
```
{% endcode %}

5. Navigate to the block explorer's [bridge page](https://antietam.tellor.io/oracle-bridge). Paste in your withdraw request's Query ID and Timestamp and click the "Generate Oracle Proofs Below" button. (see screenshot below)

<figure><img src="../../.gitbook/assets/Screenshot 2025-02-07 at 1.18.41 PM (2).png" alt=""><figcaption></figcaption></figure>

Keep this page open for the next step.

6. Call the `withdrawFromLayer` bridge function. Navigate to the [bridge contract.](https://sepolia.etherscan.io/address/0x6ac02f3887b358591b8b2d22cfb1f36fa5843867#writeContract) Click on 6.withdrawFromLayer. Fill in the inputs with the values from the block explorer shown above, and click "Write".

You should recieve your tokens on Sepolia right away.


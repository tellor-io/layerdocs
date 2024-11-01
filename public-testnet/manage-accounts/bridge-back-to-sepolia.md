# Bridge back to Sepolia

1. Request withdraw of your tokens from layer to sepolia. In this example, the layer address is `tellor1suuc9d5dr5stps5tzjv5d95ur02827ardn5` and the ethereum address that we want to withdraw to is `0x7660794eF8f978Ea0922DC29B4d93e1fc94A`:

{% code overflow="wrap" %}
```bash
./layerd tx bridge withdraw-tokens tellor1suuc9d5dr5stps5tzjv5d95ur02827ardn5 7660794eF8f978Ea0922DC29B4d93e1fc94A 69010069loya --fees 5loya
```
{% endcode %}

2. Copy the transaction hash of this withdraw-tokens transaction. We need to query the tx and copy two pieces of information: the `query_id` and the `withdraw_id`

{% code overflow="wrap" %}
```bash
# to get the queryId
./layerd query tx --type=hash <your_withdraw-tokens_tx_hash> | grep -A 1 "query_id"

# to get the withdraw_id
./layerd query tx --type=hash 505B5D17C8BBE378B975E05FF8157E5812B4617A41F3C6B24B7667060A91EB6C | grep -A 1 "withdraw_id"
```
{% endcode %}

Save these in a safe place to be used later.

2. Wait 12 hours.

_<mark style="color:blue;">**While you were waiting, your withdraw request was reported to the layer oracle. We need to get the timestamp of that report.**</mark>_

3. To find the query Id, use the queryIdBuilder app here. Use `TRBBridge` for the type and add two arguments: bool `false` and uint256 `3`&#x20;

To find the timestamp:

{% code overflow="wrap" %}
```bash
./layerd query oracle get-current-aggregate-report <your_query_id_from_step_2>
```
{% endcode %}

This will print information about the report. Copy the timestamp for the next step.

4. Request attestations for your withdraw request report:

{% code overflow="wrap" %}
```bash
./layerd tx bridge request-attestations $TELLOR_ADDRESS <query_id_from_step2> <timestamp_from_step_3> --from $ACCOUNT_NAME --chain-id layertest-2 --fees 50loya --yes
```
{% endcode %}

Once the reporters/validators attest to your withdraw request, all that is left is to wait for the relayer to prove your withdraw and the bridge contract will send the tokens to your sepolia address!

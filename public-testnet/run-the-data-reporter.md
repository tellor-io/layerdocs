# Run the Data Reporter

_Once you’re successfully running a validator, running Tellor's custom reporter module is easy!_&#x20;

_**This section assumes that you have a**_ [_**node**_](node-setup/) _**and**_ [_**validator**_](run-a-layer-validator/) _**running already.**_ \


Anyone using layer may choose to "select" reporting power to a reporter similarly to how they may "delegate" to a validator. The reporter gets commission. \
\
The create-reporter command requires that you specify your commission rate and the minimum amount of tokens that others may use when selecting you.&#x20;

* A `commision`rate of `200000` means that you get 2% of rewards from your selectors.
* A `min-tokens-required` value of `1000000` prevents spam by requiring that selectors have at least 1 TRB in their wallet.\
  \
  Now, run the command:

{% code overflow="wrap" %}
```bash
# layerd tx reporter create-reporter [commission-rate] [min-tokens-required] [flags]
./layerd tx reporter create-reporter "200000" "1000000" --from $ACCOUNT_NAME --chain-id layertest-3 --fees 10loya --yes
```
{% endcode %}

Check if your reporter was created successfully:

```sh
./layerd query reporter reporters | grep $TELLOR_ADDRESS
```

If you see your address in the list, your reporter was created successfully.

Restart your node again, adding flags for turning on the integrated price daemon:

{% code overflow="wrap" %}
```bash
./layerd start --api.enable --api.swagger --price-daemon-enabled=true --panic-on-daemon-failure-enabled=false --key-name $ACCOUNT_NAME --home ~/.layer
```
{% endcode %}

To see your report transactions, query the oracle module with the command:

```sh
./layerd query oracle get-reportsby-reporter $TELLOR_ADDRESS
```

If you see a list of reports, congratulations! You're now a tellor reporter.&#x20;

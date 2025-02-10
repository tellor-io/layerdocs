# Run the Data Reporter

_**This section assumes that you have a**_ [_**node**_](node-setup/) _**and**_ [_**validator**_](run-a-layer-validator/) _**running already.**_&#x20;

1. Add these lines to the bottom of your .bashrc / .zshrc so that they are automatically loaded in new environments. (If you have a more advanced setup, add them to your start script or .service file) Replace the example REPORTERS\_VALIDATOR\_ADDRESS with your own 'telorvaloper' prefix address:

```sh
export WITHDRAW_FREQUENCY="21600"
export REPORTERS_VALIDATOR_ADDRESS="tellorvaloper1YOUR_TELLORVALOPER_ADDRESS"
```

2. Sign the `create-reporter` command. Create-reporter requires that you specify your commission rate and the minimum amount of tokens that others may use when selecting you.&#x20;

* A `commision`rate of `200000` means that you get 2% of rewards from your selectors.
* A `min-tokens-required` value of `1000000` prevents spam by requiring that selectors have at least 1 TRB in their wallet.\
  \
  Now, run the command:

{% code overflow="wrap" %}
```bash
# layerd tx reporter create-reporter [commission-rate] [min-tokens-required] [flags]
./layerd tx reporter create-reporter 0.25 1000000 --from YOUR_ACCOUNT_NAME --chain-id layertest-3 --fees 10loya --yes
```
{% endcode %}

3. Check if your reporter was created successfully:

```sh
./layerd query reporter reporters | grep YOUR_TELLOR_ADDRESS
```

If you see your address in the list, your reporter was created successfully.

Restart your node again, adding flags for turning on the integrated price daemon:

{% code overflow="wrap" %}
```bash
./layerd start --api.enable --api.swagger --price-daemon-enabled=true --panic-on-daemon-failure-enabled=false --key-name YOUR_ACCOUNT_NAME --home ~/.layer
```
{% endcode %}

To see your report transactions, query the oracle module with the command:

```sh
./layerd query oracle get-reportsby-reporter YOUR_TELLOR_ADDRESS
```

If you see a list of reports, congratulations! You're now a tellor reporter.&#x20;

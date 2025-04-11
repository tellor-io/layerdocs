---
icon: pen
---

# Become a Data Reporter

{% hint style="success" %}
_**This section assumes that you have a**_ [_**node**_](public-testnet/node-setup/) _**and**_ [_**validator**_](run-a-layer-validator/) _**running already.**_&#x20;
{% endhint %}

1. Create the `create-reporter` transaction. The command requires that you specify your commission rate, min-tokens-required, and a moniker for your reporter:&#x20;

* A `commision-rate` of `0.05` means that you get 5% of rewards from your selectors. This can be changed later.
* A `min-tokens-required` value of `1000000` prevents spam by requiring that selectors have at least 1 TRB in their wallet. This can be changed later.
* Your `moniker` can be anything you like. (REPORTER\_MONIKER) in the example command:

{% code overflow="wrap" %}
```bash
# layerd tx reporter create-reporter [commission-rate] [min-tokens-required] [moniker] [flags]
./layerd tx reporter create-reporter 0.05 1000000 REPORTER_MONIKER --from YOUR_ACCOUNT_NAME --chain-id layertest-4 --fees 10loya --yes
```
{% endcode %}

3. Check if your reporter was created successfully:

```sh
./layerd query reporter reporters | grep YOUR_TELLOR_ADDRESS
```

If you see your address in the list, your reporter was created successfully.

Restart your node again, adding flags for turning on the integrated price daemon:

<pre class="language-bash" data-overflow="wrap"><code class="lang-bash"><strong>./layerd start --api.enable --api.swagger --price-daemon-enabled=true --panic-on-daemon-failure-enabled=false --key-name YOUR_ACCOUNT_NAME --home ~/.layer
</strong></code></pre>

To see your report transactions, query the oracle module with the command:

```sh
./layerd query oracle get-reportsby-reporter YOUR_TELLOR_ADDRESS
```

If you see a list of reports, congratulations! You're now a tellor reporter.&#x20;

---
description: Operate a Data Reporter!
icon: pen
---

# Become a Data Reporter

{% hint style="success" %}
**Starting with version v4.0.3 the reporter daemon (`reporterd`) is complied and operated separately from the node client `layerd`. This is an important improvement to allow upgrading the oracle data reporter without the need for a chain upgrade**
{% endhint %}

## Prerequisites

* An account for creating a reporter that has either [created](run-a-layer-validator/) or [delegated](command-line-usage/delegate-to-a-validator.md) to a validator.&#x20;
* `Go ≥ 1.22` : Use the default install instructions [here](https://go.dev/doc/install) if not already installed.

## Build the Reporter Binary

#### 1) To build the Reporter Daemon Binary

Clone the repo, change directory to layer/daemons and do `make build`:

```sh
git clone https://github.com/tellor-io/layer && cd layer/daemons && make build
```

Move or Copy the binary to `~/layer/binaries/v4.0.3` and `cd` to that directory to operate the reporter (unless your setup is different).

```sh
cp reporterd ~/layer/binaries/v4.0.3 && cd ~/layer/binaries/v4.0.3
```

#### 2) Configure a Reporter and Start Reporting

Use the cli to create your reporter with an initial reporting configuration. Commission-rate and min-tokens-required are shown at safe values, but can be adjusted for personal preference:&#x20;

{% code overflow="wrap" %}
```bash
# create-reporter [commission-rate] [min-tokens-required] [moniker] [flags]
./layerd tx reporter create-reporter 0.05 1000000 REPORTER_MONIKER --from YOUR_ACCOUNT_NAME --chain-id layertest-4 --fees 10loya --yes
```
{% endcode %}

* A `commision-rate` of `0.05` means that you get 5% of rewards from your selectors.
* A `min-tokens-required` value of `1000000` prevents spam by requiring that selectors have at least 1 TRB in their wallet. This can be changed later.
* Your `moniker` can be anything you like. (REPORTER\_MONIKER) in the example command:

#### 3) Check if your reporter was created successfully:

```sh
./layerd query reporter reporters | grep YOUR_TELLOR_ADDRESS
```

If you see your address in the list, your reporter was created successfully.

3\) Start the reporter:

{% code overflow="wrap" %}
```bash
./reporterd --chain-id layertest-4 --grpc-addr 0.0.0.0:9090 --from ACCOUNT_NAME --home ~/.layer --keyring-backend test --node tcp://0.0.0.0:26657
```
{% endcode %}

To verify that you are reporting, query the oracle module with the command:

```sh
./layerd query oracle get-reportsby-reporter YOUR_TELLOR_ADDRESS
```

If you see a list of reports, congratulations! You're now a tellor reporter.&#x20;

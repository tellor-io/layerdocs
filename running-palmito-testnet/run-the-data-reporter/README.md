---
description: Operate a Data Reporter!
icon: pen
---

# Become a Data Reporter

{% hint style="success" %}
**Starting with version v4.0.3 the reporter daemon (`reporterd`) is complied and operated separately from the node client `layerd`. This is an important improvement to allow upgrading the oracle data reporter without the need for a chain upgrade**
{% endhint %}

## Prerequisites

* An account for creating a reporter that has either [created](../../running-tellor-layer/run-a-layer-validator/) or [delegated](broken-reference) to a validator.&#x20;
* `Go ≥ 1.22` : Use the default install instructions [here](https://go.dev/doc/install) if not already installed.

## Build the Reporter Binary

#### 1) To build the Reporter Daemon Binary

Clone the repo, change directory to layer/daemons and do `make build`:

```sh
git clone https://github.com/tellor-io/layer && cd layer/daemons && make build
```

Move or Copy the binary to `~/layer/binaries/v5.0.0` and `cd` to that directory to operate the reporter (unless your setup is different).

```sh
cp bin/reporterd ~/layer/binaries/v5.0.0 && cd ~/layer/binaries/v5.0.0
```

#### 2) Configure a Reporter and Start Reporting

Use the cli to create your reporter with an initial reporting configuration. Commission-rate and min-tokens-required are shown at safe values, but can be adjusted for personal preference:&#x20;

{% code overflow="wrap" %}
```bash
# create-reporter [commission-rate] [min-tokens-required] [moniker] [flags]
./layerd tx reporter create-reporter 0.05 1000000 REPORTER_MONIKER --from YOUR_ACCOUNT_NAME --chain-id layertest-4 --fees 10loya --yes
```
{% endcode %}

Parameters:

* A `commision-rate` of `0.05` means that you get 5% of rewards from your selectors.
* A `min-tokens-required` value of `1000000` prevents spam by requiring that selectors have at least 1 TRB in their wallet. This can be changed later.
* Choose a `REPORTER_MONIKER` that you love! (It does not need to be the same as your validator moniker.)
* Your `moniker` can be anything you like. (REPORTER\_MONIKER) in the example command:

#### 3) Check if your reporter was created successfully:

```sh
./layerd query reporter reporters | grep -A 7 YOUR_TELLOR_ADDRESS
```

If your reporter was created successfully, this will output your reporter information.

4\) Make an empty .env file to bypass an error. (this will be fixed in the next update):

```sh
touch .env
```

#### 5) Start the reporter:

{% code overflow="wrap" %}
```bash
./reporterd --chain-id layertest-4 --grpc-addr 0.0.0.0:9090 --from ACCOUNT_NAME --home ~/.layer --keyring-backend test --node tcp://0.0.0.0:26657
```
{% endcode %}

The logs should soon begin showing information about your cycle list reports!&#x20;

<sub>You can set up a grafana dashboard using</sub> [<sub>this\_guide</sub>](https://app.gitbook.com/o/-MFXSaNHbs8RgP8-7mnZ/s/s90SVtIdiQ8dmMsqriIa/~/changes/316/setting-up-a-grafana-dashboard-for-your-layer-node) <sub>to monitor things in Layer such as average gas price for submitting a report, block times, total bonded tokens, etc.</sub>

Congratulations on becoming a Tellor Reporter! 🎉

```
# example of Healthy logs at time of writing
...
3:13PM INF ReporterDaemon current query id in cycle list=5c13cd9c97dbb98f2429c101a2a8150e6c7a0ddaff6124ee176a3a411067ded0 module=reporter-client
3:13PM INF NewReport module=reporter-client reporter=tellor1xyxd7x9yjfh0ad6mg3wfyczwmandzj7qlgl3ug
3:13PM INF NewReport module=reporter-client reporter_power=6
3:13PM INF NewReport module=reporter-client query_type=SpotPrice
3:13PM INF NewReport module=reporter-client query_id=5c13cd9c97dbb98f2429c101a2a8150e6c7a0ddaff6124ee176a3a411067ded0
3:13PM INF NewReport module=reporter-client value=000000000000000000000000000000000000000000000001ac9d8fdd3ff08000
3:13PM INF NewReport cyclelist=true module=reporter-client
3:13PM INF NewReport aggregate_method=weighted-median module=reporter-client
3:13PM INF NewReport module=reporter-client query_data=00000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000000953706f745072696365000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c0000000000000000000000000000000000000000000000000000000000000004000000000000000000000000000000000000000000000000000000000000000800000000000000000000000000000000000000000000000000000000000000003747262000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000037573640000000000000000000000000000000000000000000000000000000000
3:13PM INF NewReport module=reporter-client timestamp=1746198787384
3:13PM INF NewReport meta_id=1102753 module=reporter-client
3:13PM INF NewReport module=reporter-client msg_index=0
3:13PM INF transaction hash: 89BA489BC6DB0D022456733F500A4AFECE27F03BFDBF7FE2A7EA56117C4B884E module=reporter-client
3:13PM INF response after submit message: 0 module=reporter-client
3:13PM INF Tx in Channel: 0 module=reporter-client
...
```

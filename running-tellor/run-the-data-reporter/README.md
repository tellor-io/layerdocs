---
description: Operate a Data Reporter!
icon: pen
---

# Run a Data Reporter

## Staking

To create a reporter on Tellor Layer, you must first "stake" your address one of two ways. You must either create a validator -OR- delegate to a validator to bond your tokens.

* Create a Validator: Your account is the KEYNAME account used for your [validator](../run-a-layer-validator/).
* Delegate to a Validator: If your reporter account is not a validator account, you must [bond your address to a validator ](../../command-line-usage/leveraging-layerd/delegate-to-a-validator.md)before you may create your reporter.

#### 1) Configure a Reporter on Tellor

Use the `layerd` cli register and initialize your reporter configuration. Commission-rate and min-tokens-required are shown at safe values, but can be adjusted (now or later) for personal preference:

{% code overflow="wrap" %}
```bash
# create-reporter [commission-rate] [min-tokens-required] [moniker] [flags]
./layerd tx reporter create-reporter 0.05 1000000 REPORTER_MONIKER --from YOUR_ACCOUNT_NAME --chain-id tellor-1 --fees 10loya --yes
```
{% endcode %}

Parameters:

* A (example) `commision-rate` of `0.05` means that you get 5% of rewards from your selectors.
* A (example) `min-tokens-required` value of `1000000` prevents spam by requiring that selectors have at least 1 TRB in their wallet. This can be changed later.
* Choose a `REPORTER_MONIKER` that you love! (It does not need to be the same as your validator moniker.)

#### 2) Check if your reporter was created successfully:

```sh
./layerd query reporter reporters | grep -A 7 YOUR_TELLOR_ADDRESS
```

If your reporter was created successfully, this will output your reporter information.

#### 3) Download the latest `reporterd` binary:

Download [reporterd v0.2.5](https://github.com/tellor-io/layer-daemons/releases/tag/v0.2.5):

{% tabs %}
{% tab title="Linux" %}
{% code overflow="wrap" %}
```sh
mkdir -p ~/layer/binaries/reporter && cd ~/layer/binaries/reporter && wget https://github.com/tellor-io/layer-daemons/releases/download/v0.2.5/reporterd_Linux_x86_64.tar.gz && tar -xvzf reporterd_Linux_x86_64.tar.gz && rm reporterd_Linux_x86_64.tar.gz
```
{% endcode %}
{% endtab %}

{% tab title="Mac" %}
{% code overflow="wrap" %}
```sh
mkdir -p ~/layer/binaries/reporter && cd ~/layer/binaries/reporter && wget https://github.com/tellor-io/layer-daemons/releases/download/v0.2.5/reporterd_Darwin_arm64.tar.gz && tar -xvzf reporterd_Darwin_arm64.tar.gz && rm reporterd_Darwin_arm64.tar.gz
```
{% endcode %}
{% endtab %}
{% endtabs %}

#### 4) Create `.env`

`reporterd` loads environment variables from a `.env` file in the current working directory (or from `../.env` when run from a subdirectory). You can also set these in a [systemd service file](../node-setup/example-.service-files.md) instead.

Copy [`env.example`](https://github.com/tellor-io/layer-daemons/blob/main/env.example) from layer-daemons and edit the values for your setup:

{% code overflow="wrap" %}
```sh
cd ~/layer/binaries/reporter
wget https://raw.githubusercontent.com/tellor-io/layer-daemons/refs/heads/main/env.example
cp env.example .env
```
{% endcode %}

At minimum, set `LAYER_HOME`, `FROM`, `KEYRING_BACKEND`, `RPC_NODES`, `GRPC_NODES`, `BRIDGE_CHAIN_RPC_NODES`, and your custom query API keys. Most CLI flags can be provided as environment variables by uppercasing the flag name and replacing `-` with `_` (for example, `--from` becomes `FROM`). Use `LAYER_HOME` for the Layer home directory instead of relying on the shell's `HOME`. 

{% hint style="info" %}
See the [layer-daemons README](https://github.com/tellor-io/layer-daemons/blob/v0.2.5/README.md) and [`env.example`](https://github.com/tellor-io/layer-daemons/blob/v0.2.5/env.example) for all available options, including auto-unbonding, price guard, and auto balance-to-keep bridge settings.
{% endhint %}

#### 5) Start the reporter:

From the directory containing your `.env` file:

{% code overflow="wrap" %}
```bash
cd ~/layer/binaries/reporter && ./reporterd
```
{% endcode %}

If you prefer CLI flags instead of `.env`, you can still pass them explicitly. Environment variables take precedence over matching flags when both are set:

{% code overflow="wrap" %}
```bash
./reporterd --grpc-addr 127.0.0.1:9090 --from ACCOUNT_NAME --home ~/.layer --keyring-backend test --node tcp://127.0.0.1:26657
```
{% endcode %}

Here is an example start command for a reporter who wants to automatically unbond 2.999 TRB (2999999 loya) per day with a maximum set to 1% of their total stake:

{% code overflow="wrap" %}
```bash
./reporterd --auto-unbonding-frequency 1 --auto-unbonding-amount 2999999 --auto-unbonding-max-stake-percentage 0.01
```
{% endcode %}

The same auto-unbonding settings can be set in `.env`:

```sh
AUTO_UNBONDING_FREQUENCY=1
AUTO_UNBONDING_AMOUNT=2999999
AUTO_UNBONDING_MAX_STAKE_PERCENTAGE=0.01
```

{% hint style="success" %}
You can set up a grafana dashboard using [this\_guide](../../setting-up-a-grafana-dashboard-for-your-layer-node.md) to monitor things in Layer such as average gas price for submitting a report, block times, total bonded tokens, etc.
{% endhint %}

Congratulations on becoming a Tellor Reporter! 🎉

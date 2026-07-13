---
description: Operate a Data Reporter!
icon: pen
---

# Run a Data Reporter (testnet)

## Prerequisites

* A working[ node](../node-quick-start-testnet.md).
* An account for creating a reporter that has either [created](../run-a-layer-validator/) or [delegated](../../command-line-usage/leveraging-layerd/delegate-to-a-validator.md) to a validator.

#### 1) Configure a Reporter on Tellor

Use the `layerd` cli register and initialize your reporter configuration. Commission-rate and min-tokens-required are shown at safe values, but can be adjusted (now or later) for personal preference:

{% code overflow="wrap" %}
```bash
# create-reporter [commission-rate] [min-tokens-required] [moniker] [flags]
./layerd tx reporter create-reporter 0.05 1000000 REPORTER_MONIKER --from YOUR_ACCOUNT_NAME --chain-id layertest-5 --fees 10loya --yes
```
{% endcode %}

Parameters:

* A (example) `commission-rate` of `0.05` means that you get 5% of rewards from your selectors.
* A (example) `min-tokens-required` value of `1000000` prevents spam by requiring that selectors have at least 1 TRB in their wallet. This can be changed later.
* Choose a `REPORTER_MONIKER` that you love! (It does not need to be the same as your validator moniker.)

#### 2) Check if your reporter was created successfully:

```sh
./layerd query reporter reporters | grep -A 7 YOUR_TELLOR_ADDRESS
```

If your reporter was created successfully, this will output your reporter information.

#### 3) Download the latest `reporterd` binary:

Download [reporterd v0.2.7](https://github.com/tellor-io/layer-daemons/releases/tag/v0.2.7):

{% tabs %}
{% tab title="Linux" %}
{% code overflow="wrap" %}
```sh
mkdir -p ~/layer/binaries/reporter && cd ~/layer/binaries/reporter && wget https://github.com/tellor-io/layer-daemons/releases/download/v0.2.7/reporterd_Linux_x86_64.tar.gz && tar -xvzf reporterd_Linux_x86_64.tar.gz && rm reporterd_Linux_x86_64.tar.gz
```
{% endcode %}
{% endtab %}

{% tab title="Mac" %}
{% code overflow="wrap" %}
```sh
mkdir -p ~/layer/binaries/reporter && cd ~/layer/binaries/reporter && wget https://github.com/tellor-io/layer-daemons/releases/download/v0.2.7/reporterd_Darwin_arm64.tar.gz && tar -xvzf reporterd_Darwin_arm64.tar.gz && rm reporterd_Darwin_arm64.tar.gz
```
{% endcode %}
{% endtab %}
{% endtabs %}

#### 4) Create `.env`

`reporterd` loads environment variables from a `.env` file in the current working directory (or from `../.env` when run from a subdirectory). You can also set these in a [systemd service file](../node-setup/example-.service-files.md) instead.

Copy [`env.example`](https://github.com/tellor-io/layer-daemons/blob/v0.2.7/env.example) from layer-daemons and edit the values for your setup:

{% code overflow="wrap" %}
```sh
cd ~/layer/binaries/reporter
wget https://raw.githubusercontent.com/tellor-io/layer-daemons/v0.2.7/env.example
cp env.example .env
```
{% endcode %}

At minimum, set `LAYER_HOME`, `FROM`, `KEYRING_BACKEND`, `RPC_NODES`, `GRPC_NODES`, and your custom query API keys. `RPC_NODES`, `GRPC_NODES`, `BRIDGE_CHAIN_RPC_NODES`, and `ETH_MAINNET_RPC_NODES` accept comma-separated endpoint lists, with the first endpoint used as the primary and later endpoints used as ordered fallbacks.

Most CLI flags can be provided as environment variables by uppercasing the flag name and replacing `-` or `.` with `_` (for example, `--keyring-backend` becomes `KEYRING_BACKEND`). Use `LAYER_HOME` for the Layer home directory instead of relying on the shell's `HOME`. When using `KEYRING_BACKEND=file`, set `KEYRING_PASSWORD_FILE` to a file that contains the keyring password and is readable only by the service user.

On testnet, point `BRIDGE_CHAIN_RPC_NODES` at your Sepolia (or other bridge-chain) RPC endpoints. Because the bridge chain is not Ethereum mainnet, also set `ETH_MAINNET_RPC_NODES` so custom query contract reads use mainnet endpoints. The built-in custom query templates also use `CMC_PRO_API_KEY`, `CGPRO_API_KEY`, `SUBGRAPH_API_KEY`, and, when `ETH_MAINNET_RPC_NODES` is unset, `INFURA_API_KEY` and `ALCHEMY_API_KEY`.

_Note: API keys are not strictly required, but reporters should set them to enable reporting for all tipped feeds and maximize earnings._

{% hint style="info" %}
See the [layer-daemons README](https://github.com/tellor-io/layer-daemons/blob/v0.2.7/README.md) and [`env.example`](https://github.com/tellor-io/layer-daemons/blob/v0.2.7/env.example) for all available options, including remote signer, dispute monitor, custom query cache, auto-unbonding, price guard, and auto balance-to-keep bridge settings.
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
./reporterd --grpc 127.0.0.1:9090 --node tcp://127.0.0.1:26657 --from ACCOUNT_NAME --home ~/.layer --keyring-backend test
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
You can set up a grafana dashboard using [this\_guide](../../setting-up-a-grafana-dashboard-for-your-layer-node.md) to monitor things in Tellor such as average gas price for submitting a report, block times, total bonded tokens, etc.
{% endhint %}

Congratulations on becoming a Tellor Reporter! 🎉

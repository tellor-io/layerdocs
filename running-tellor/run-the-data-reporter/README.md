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

Use the `layerd` cli register and initialize your reporter configuration. Commission-rate and min-tokens-required are shown at safe values, but can be adjusted (now or later) for personal preference:&#x20;

{% code overflow="wrap" %}
```bash
# create-reporter [commission-rate] [min-tokens-required] [moniker] [flags]
./layerd tx reporter create-reporter 0.05 1000000 REPORTER_MONIKER --from YOUR_ACCOUNT_NAME --chain-id tellor-1 --fees 10loya --yes
```
{% endcode %}

Parameters:

* A (example) `commision-rate` of `0.05` means that you get 5% of rewards from your selectors.
* A (example)  `min-tokens-required` value of `1000000` prevents spam by requiring that selectors have at least 1 TRB in their wallet. This can be changed later.
* Choose a `REPORTER_MONIKER` that you love! (It does not need to be the same as your validator moniker.)

#### 2) Check if your reporter was created successfully:

```sh
./layerd query reporter reporters | grep -A 7 YOUR_TELLOR_ADDRESS
```

If your reporter was created successfully, this will output your reporter information.

#### 3) Download the latest `reporterd` binary:

{% tabs %}
{% tab title="Linux" %}
{% code overflow="wrap" %}
```sh
mkdir -p ~/layer/binaries/reporter && cd ~/layer/binaries/reporter && wget https://github.com/tellor-io/layer-daemons/releases/download/v0.1.5/reporterd_Linux_x86_64.tar.gz && tar -xvzf reporterd_Linux_x86_64.tar.gz && rm reporterd_Linux_x86_64.tar.gz
```
{% endcode %}
{% endtab %}

{% tab title="Mac" %}
{% code overflow="wrap" %}
```sh
mkdir -p ~/layer/binaries/reporter && cd ~/layer/binaries/reporter && wget https://github.com/tellor-io/layer-daemons/releases/download/v0.1.5/reporterd_Darwin_arm64.tar.gz && tar -xvzf reporterd_Darwin_arm64.tar.gz && rm reporterd_Darwin_arm64.tar.gz
```
{% endcode %}
{% endtab %}
{% endtabs %}

#### 4) Create .env

Be sure to configure these variables here or in your shell. (The .env file is required but can be empty if you're setting these in a .service file or in `.bashrc`):

{% code overflow="wrap" %}
```sh
ETH_RPC_URL="wss://a.good.ethereum.rpc.url"
ETH_RPC_URL_PRIMARY="wss://a.good.ethereum.rpc.url"
ETH_RPC_URL_FALLBACK="https://another.ethereum.rpc.url"
TOKEN_BRIDGE_CONTRACT="0x5acb5977f35b1A91C4fE0F4386eB669E046776F2"
WITHDRAW_FREQUENCY=3600
REPORTERS_VALIDATOR_ADDRESS=tellorvaloper1egaks..."
CMC_PRO_API_KEY=YOUR_COINMARKETCAP_API_KEY
SUBGRAPH_API_KEY=YOUR_GRAPH_API_KEY
INFURA_API_KEY=YOUR_INFURA_API_KEY
ALCHEMY_API_KEY=YOUR_ALCHEMY_API_KEY
```
{% endcode %}

#### 5) Start the reporter:

{% code overflow="wrap" %}
```bash
./reporterd --chain-id tellor-1 --grpc-addr 0.0.0.0:9090 --from ACCOUNT_NAME --home ~/.layer --keyring-backend test --node tcp://0.0.0.0:26657
```
{% endcode %}

Note: Optional flags may be used to establish a stream of profit taking for your operation:

{% hint style="info" %}
**Optinal flags for auto-unbonding:**\
`--auto-unbonding-frequency` : The frequency (in days) with which you would like to withdraw rewards (unlocked after 21 days).       &#x20;

`--auto-unbonding-ammount` : The amount of TRB (in loya) which you would like to auto-unbond.

`--auto-unbonding-max-stake-percentage` : A safeguard against automatically unbonding too much. Set this to a percentage of your stake ( 0.01 for 1%)
{% endhint %}

Here is an example start command for a reporter who wants to automatically unbond 2.999 TRB (2999999loya) per day with a maximum set to 1% of their total stake:

{% code overflow="wrap" %}
```bash
./reporterd --chain-id tellor-1 --grpc-addr 0.0.0.0:9090 --from ACCOUNT_NAME --home ~/.layer --keyring-backend test --node tcp://0.0.0.0:26657 --auto-unbonding-frequency 1 --auto-unbonding-amount 2999999 --auto-unbonding-max-stake-percentage 0.01
```
{% endcode %}

{% hint style="success" %}
You can set up a grafana dashboard using [this\_guide](../../setting-up-a-grafana-dashboard-for-your-layer-node.md) to monitor things in Layer such as average gas price for submitting a report, block times, total bonded tokens, etc.
{% endhint %}

Congratulations on becoming a Tellor Reporter! 🎉

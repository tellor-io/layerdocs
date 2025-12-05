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
mkdir -p ~/layer/binaries/reporter && cd ~/layer/binaries/reporter && wget https://github.com/tellor-io/layer/releases/download/reporterd%2Fv0.1.2/reporterd_Linux_x86_64.tar.gz && tar -xvzf reporterd_Linux_x86_64.tar.gz && rm reporterd_Linux_x86_64.tar.gz
```
{% endcode %}
{% endtab %}

{% tab title="Mac" %}
{% code overflow="wrap" %}
```sh
mkdir -p ~/layer/binaries/reporter && cd ~/layer/binaries/reporter && wget https://github.com/tellor-io/layer/releases/download/reporterd%2Fv0.1.2/reporterd_Darwin_arm64.tar.gz && tar -xvzf reporterd_Darwin_arm64.tar.gz && rm reporterd_Darwin_arm64.tar.gz
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

_Note: The API keys are not required, but reporters should consider setting them to enable reporting for all tipped feeds. This ensures maximum earnings._

#### 5) Start the reporter:

{% code overflow="wrap" %}
```bash
./reporterd --chain-id tellor-1 --grpc-addr 0.0.0.0:9090 --from ACCOUNT_NAME --home ~/.layer --keyring-backend test --node tcp://0.0.0.0:26657
```
{% endcode %}

The logs should soon begin showing information about your cycle list reports!&#x20;

{% hint style="success" %}
You can set up a grafana dashboard using [this\_guide](../../setting-up-a-grafana-dashboard-for-your-layer-node.md) to monitor things in Layer such as average gas price for submitting a report, block times, total bonded tokens, etc.
{% endhint %}

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

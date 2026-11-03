---
description: Request a Tellor report by paying TRB for a query.
icon: hand-holding-circle-dollar
---

# Tipping the Tellor Network

Anyone with a Layer account can tip. The tip opens a reporting window for that query. Staked reporters submit values, the chain aggregates them, and 98% of the tip is split among the reporters who were included, weighted by their stake. The other 2% is burned.

A tip the chain accepts is a paid window. A report shows up only if some reporter submits before that window closes.

{% hint style="info" %}
TRB on Layer uses 6 decimals. The denom is `loya`. 1 TRB is `1000000loya`.&#x20;
{% endhint %}

#### When to tip

A tip is a one-time payment for a specific query. Use it to request data that is not on the cycle list, or to add a reward to a query that is. Further tips sent while the window is still open are added to the same reward. There is no on-chain heartbeat or deviation threshold. To get the same feed again on a schedule, send another tip when you want the next report. That loop is yours to run, or a bot's.

{% hint style="info" %}
The cycle list is a governance-set rotation of feeds. Reporters work through that list continuously, paid by inflationary rewards, so those feeds do not need a tip to be reported.
{% endhint %}

Tipping a cycle-list feed does not remove it from the rotation. If that feed's current window has already expired, the tip is an extra reporting opportunity.&#x20;

If the window closes with no report, the unpaid tip stays on the query. The next tip starts a new window and adds to that amount.

{% hint style="info" %}
If a tipped query is reported for, but does not receive the power behind it required by the user, it is recommended to reach out in the #reporters channel in the [Tellor discord](https://discord.gg/tellor) to help coordinate with the reporter network.
{% endhint %}

#### What the chain will accept

The registry is the catalog of tippable query types. The cycle list is the rotation. A query outside the cycle list is tippable when its query type is a registered data spec.

List the types, read one spec, then build query data from it:

```
./layerd query registry all-data-specs --node $NODE
./layerd query registry data-spec SpotPrice --node $NODE
./layerd query registry generate-querydata SpotPrice '["eth","usd"]' --node $NODE
```

`generate-querydata` returns the hex you pass to `tx oracle tip`. The parameters are a JSON array, one entry per field on that spec. `decode-querydata` checks a hex you already have. If that decode fails, the type is not registered and the tip fails.

```
./layerd query registry decode-querydata $QUERY_DATA --node $NODE
./layerd query oracle get-cycle-list --node $NODE
```

`data-spec` includes `report_block_window`. The tip's reporting window is that many blocks. `get-cycle-list` tells you whether this query is already being reported without a tip.

`SpotPrice` is one query type. Its parameters are two strings, the asset and the currency, so any pair encodes. ETH/USD and a pair nobody has reported are both valid `SpotPrice` query data. The chain takes the tip for either. The tip does not add the pair to the cycle list.

The asset and currency strings are case-sensitive. `["eth","usd"]` and `["ETH","USD"]` are different query ids. All lowercase `["eth","usd"]`  is currently the convention for the SpotPrice query.

Bridge tips use `TRBBridgeV2`.

#### Whether a reporter will fill it

The chain does not check that a reporter can price the query. `reporterd` polls open tipped queries and attempts a `SpotPrice` report for each one. It submits only when that reporter's own config knows the feed. A reporter fills a tip for these feeds. The asset string is lowercase. Feeds on the cycle list are reported continuously, without a tip. Their latest relayed values are on [feeds.tellor.io](https://feeds.tellor.io/).

| Feed        | Parameters          | Cycle list |
| ----------- | ------------------- | ---------- |
| ATOM/USD    | `["atom","usd"]`    |            |
| BTC/USD     | `["btc","usd"]`     | x          |
| ETH/USD     | `["eth","usd"]`     | x          |
| RETH/USD    | `["reth","usd"]`    | x          |
| SDAI/USD    | `["sdai","usd"]`    |            |
| SFRXUSD/USD | `["sfrxusd","usd"]` | x          |
| STETH/USD   | `["steth","usd"]`   |            |
| SUSDE/USD   | `["susde","usd"]`   | x          |
| TBTC/USD    | `["tbtc","usd"]`    | x          |
| TRB/USD     | `["trb","usd"]`     | x          |
| USDC/USD    | `["usdc","usd"]`    | x          |
| USDE/USD    | `["usde","usd"]`    |            |
| USDT/USD    | `["usdt","usd"]`    | x          |
| WSTETH/USD  | `["wsteth","usd"]`  | x          |

ATOM/USD, SDAI/USD, STETH/USD, and USDE/USD need a tip before a reporter submits. Build the query data from the parameters, then pass that hex to the tip command below.

./layerd query registry generate-querydata SpotPrice '\["atom","usd"]' --node $NODE

If the feed is not in the table, request it at [tellor.io/new-price-feed-request](https://tellor.io/new-price-feed-request/). The team uses that form to coordinate a new price feed with reporters. A tip for a pair that is not in the table opens a window, and no configured reporter submits a value for it.

A tip is settled on Tellor Layer. `get-current-aggregate-report` reads it there. [feeds.tellor.io](https://feeds.tellor.io/) and other EVM contracts show the report after a relayer submits the attestation to that chain. The cycle-list feeds already have a relayer running, which is why their values are on that site with no tip.&#x20;

{% hint style="info" %}
ATOM/USD, SDAI/USD, STETH/USD, and USDE/USD need the tip first, then a relay of that query id once the aggregate is in. The steps are on [Relay Data to EVM Chains](https://docs.tellor.io/tellor/using-tellor-data/relay-data-to-evm-chains).
{% endhint %}

### Build the query data

The tip takes query data, the ABI encoding of the query. It does not take the query id. The query id is `keccak256` of that encoding, and you use it later to read the aggregate.

Build both at [querybuilder.tellor.io](https://querybuilder.tellor.io/), or with `generate-querydata` above. For a spot price the encoding is `abi.encode("SpotPrice", abi.encode(asset, currency))`. ETH/USD is `SpotPrice("eth", "usd")`, and its query id is `0x83a7f3d48786ac2667503a61e8c415438ed2922eb86a2906e4ee66d9a2ce4992`. Specs for each query type are in the [dataSpecs repo](https://github.com/tellor-io/dataSpecs).

Copy the query data hex from the builder and drop the `0x` prefix. The CLI already returns it without one.

#### Send the tip

You need `layerd`, a Layer account funded with `loya`, and the chain id `tellor-1`. Account setup is on the Managing Accounts page. Bridging TRB onto Layer is on the Bridging TRB page.

Check the balance and the current tip limits before you send:

```
./layerd query bank balance $ACCOUNT_ADDRESS loya --node $NODE
./layerd query oracle params --node $NODE
```

`min_tip_amount` and `max_tip_amount` are in `loya`. A single tip below the minimum or above the maximum is rejected. The open tip on one query cannot go above `max_tip_amount` . That cumulative cap is the constant `DefaultMaxTipAmount` in the tip handler. Changing the `max_tip_amount` parameter does not move it.

```
./layerd tx oracle tip --help
```

```
./layerd tx oracle tip $QUERY_DATA 10000loya \
    --from $ACCOUNT_NAME \--chain-id tellor-1 \
    --node $NODE \--fees 12loya \
    --gas auto
```

`$QUERY_DATA` is the hex from the query builder or from `generate-querydata`. `10000loya` is 0.01 TRB. `--from` is the account that pays. Use the public RPC from the Peers List and Public RPCs page as `$NODE`.

The transaction emits `tip_added` with the query id, the tipper, the amount credited after the burn, and the query's meta id.

#### Check it

`get-current-tip` takes the same query data you tipped. The aggregate query takes the query id.

```
./layerd query oracle get-current-tip $QUERY_DATA --node $NODE
./layerd query oracle get-current-aggregate-report $QUERY_ID --node $NODE
./layerd query oracle get-tipped-queries --node $NODE
```

An open tip with an empty aggregate means the window is up and no reporter has submitted yet.

`get-user-tip-total` takes your tellor address and returns the tips credited to you. That total is what counts toward the user share of dispute voting power.

```
./layerd query oracle get-user-tip-total $ACCOUNT_ADDRESS --node $NODE
```

#### Where the TRB goes

The chain burns 2% at the moment of the tip. The remaining 98% sits on the query until reporters are included in the aggregate, then it is locked in escrow for those reporters, split by the stake power behind their submissions.

A reporter does not receive the tip as spendable TRB. `withdraw-tip` moves escrowed tips onto a validator's stake. `withdraw-tip-to-balance` starts a 21-day unlock into a free balance. Either path keeps the tokens out of circulation long enough that tipping cannot be used to farm vote power or to skip the validator deposit limit. Claiming tips also counts toward the cap on how fast the validator set can change.

```
./layerd tx reporter withdraw-tip $SELECTOR_ADDRESS $VALIDATOR_ADDRESS \
  --from $ACCOUNT_NAME --chain-id tellor-1 --node $NODE --fees 5loya --gas auto

./layerd tx reporter withdraw-tip-to-balance $SELECTOR_ADDRESS \
  --from $ACCOUNT_NAME --chain-id tellor-1 --node $NODE --fees 5loya --gas auto
```

### Relaying Data

Tipping the Tellor Network incentivizes reporters to report the requested data onto the Tellor network. This data will then need to be relayed to the desired network, the steps to which can be found at [Relay Data to EVM Chains](https://docs.tellor.io/tellor/using-tellor-data/relay-data-to-evm-chains).

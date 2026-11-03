---
description: A simple read of existing Tellor feeds.
icon: square-poll-horizontal
---

# (Simple) Integrating Existing Feeds

{% hint style="warning" %}
Only read directly from the DataBank contract when the value in your protocol is less than what’s staked on Tellor. Beyond this threshold, increase security and control using [(Advanced) Integrating Tellor Data](integrating-tellor-data.md).
{% endhint %}

{% hint style="warning" %}
See the [Tellor Feeds](https://feeds.tellor.io/) site for live relayed feeds. These feeds are currently set to be relayed at 4 hr intervals. To guarantee continued data relays, a keeper network can be used or you can always set up your own relayer.&#x20;
{% endhint %}

{% hint style="info" %}
See the [Contracts Reference](https://docs.tellor.io/contracts-reference) page for deployed contract addresses. You are also welcome to deploy your own.&#x20;
{% endhint %}

We will install the `usingtellorlayer` npm package to gain access to the `TellorDataBank` interface:

```
npm i usingtellorlayer
```

The code block below shows how you can connect your contract to `TellorDataBank` and read the data:

```
pragma solidity 0.8.19;

import "usingtellorlayer/contracts/interfaces/ITellorDataBank.sol";

contract SampleLendingPoolUser {
    ITellorDataBank public dataBank;
    bytes32 public ethUsdQueryId;

    uint256 public constant MAX_PRICE_AGE = 4 hours;
    uint256 public constant LTV_BPS = 8000;

    mapping(address => uint256) public collateral;
    mapping(address => uint256) public debt;

    constructor(address _dataBank) {
        dataBank = ITellorDataBank(_dataBank);
        ethUsdQueryId = keccak256(abi.encode("SpotPrice", abi.encode("eth", "usd")));
    }

    function deposit() external payable {
        collateral[msg.sender] += msg.value;
    }

    function borrow(uint256 _stableAmount) external {
        ITellorDataBank.AggregateData memory _report = dataBank.getCurrentAggregateData(ethUsdQueryId);
        require(_report.value.length >= 32, "no report");
        require(block.timestamp - (_report.aggregateTimestamp / 1000) < MAX_PRICE_AGE, "stale price");

        uint256 _price = abi.decode(_report.value, (uint256));
        uint256 _collateralValue = collateral[msg.sender] * _price / 1e18;
        debt[msg.sender] += _stableAmount;
        require(debt[msg.sender] * 10000 <= _collateralValue * LTV_BPS, "ltv");
    }
}
```

**Understanding Checks on a DataBank read (above)**

We need to make sure our data is not too old and that it can be correctly decoded:

1. The query id is the argument you pass to `getCurrentAggregateData`.&#x20;
2. `aggregateTimestamp` is milliseconds.&#x20;
3. Require the aggregate timestamp to be inside the age your action can tolerate. `MAX_PRICE_AGE`  wider than the feed's heartbeat on feeds.tellor.io  (Typically 4hrs by default)
4. Spot prices are a `uint256` with 18 decimals.&#x20;

{% hint style="info" %}
See the [SampleLayerUser](https://github.com/tellor-io/SampleLayerUser) repo for a more example Tellor use case implementations.&#x20;
{% endhint %}

---
description: Overview
icon: hand-wave
---

# Introduction

## What is Tellor?

Tellor is a Layer 1 blockchain built for the purpose of coming to consensus on any subjective data. It is operated by an open public network of staked parties who are crypto-economically incentivized to honestly report requested data.

{% hint style="info" %}
For in-depth information about the design, checkout the [Tellor tech paper](https://github.com/tellor-io/layer/blob/main/TellorLayer%20-%20tech.pdf) and our [ADRs](https://github.com/tellor-io/layer/tree/main/adr).
{% endhint %}

<mark style="background-color:yellow;">**Important note for validators who offer staking services: There are currently trustless inflationary rewards for being a validator or reporter on tellor-1. Inflationary rewards will transition Q1 2026. Temporary rewards are currently available at 1/4th rate (approx. 36 TRB per 24 hours).**</mark>&#x20;

### Tellor-1

**`tellor-1` is the tellor mainnet chain-id. Over a year in the making, this is a custom oracle chain for coming to consensus on subjective data.** The network is open for anyone to participate with no barriors to participation other than bridging and staking TRB ([ERC20](https://etherscan.io/token/0x88df592f8eb5d7bd38bfef7deb0fbc02cf3778a0?a=0x8cfc184c877154a8f9ffe0fe75649dbe5e2dbebf)).&#x20;

{% content-ref url="/broken/pages/Pe4IW2P0OSDraf0cWra8" %}
[Broken link](/broken/pages/Pe4IW2P0OSDraf0cWra8)
{% endcontent-ref %}

### Palmito Testnet (layertest-4)

Palmito is the current testnet equivalent for testing tellor operation and functionaity.

{% content-ref url="/broken/pages/cpgf4r3gLEp7xSXrvVjL" %}
[Broken link](/broken/pages/cpgf4r3gLEp7xSXrvVjL)
{% endcontent-ref %}

### What is a Validator?&#x20;

Validators in the Tellor network play a crucial role in maintaining the blockchain's integrity and consensus. They are responsible for validating transactions, securing the network, and ensuring the proper functioning of the blockchain. The number of total validators is capped at 100.

#### **Responsibilities of a Validator:**

1. **Transaction Validation:** Validators validate transactions and add them to the chain.
2. **Consensus Participation:** They participate in the consensus mechanism to agree on the state of the chain.
3. **Block Proposal:** Validators propose new blocks and ensure that all committed transactions are included.
4. **Signing:** Validators sign aggregated data values, ensuring their correctness before they are relayed to other chains.

### What is a Reporter?

Reporters are individuals who read data from the internet (and/or any"real world" sources) for submission to the Tellor oracle. The data they report is aggregated and verified via on-chain consensus. Reporters earn TRB rewards for their efforts.

#### **Reporters are responsible for:**

* **Submitting values** for data requests (queries) that are subject to validation and disputes.  \*Validators can be reporters but not all reporters will be validators.
* **Monitoring submissions for accuracy**. A robust system of staking and slashing ensures that reporters (and users) are crypto-economically incentivized to monitor their data.

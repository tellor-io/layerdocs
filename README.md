---
description: Overview
icon: hand-wave
---

# Introduction

## What is Tellor Layer?

Tellor Layer is a stand alone L1 built using the cosmos sdk for the purpose of coming to consensus on any subjective data. It works by using a network of staked parties who are crypto-economically incentivized to honestly report requested data. &#x20;

{% hint style="info" %}
For more in-depth information, checkout the [Tellor Layer tech paper](https://github.com/tellor-io/layer/blob/main/TellorLayer%20-%20tech.pdf) and our [ADRs](https://github.com/tellor-io/layer/tree/main/adr).
{% endhint %}

## Palmito Testnet

The current testnet is code named "Palmito", and it is the first testnet that uses the "real" Sepolia testnet TRB contract instead of a playground token. All supply on Tellor Palmito will be bridged Sepolia TRB: [https://sepolia.etherscan.io/address/0x80fc34a2f9FfE86F41580F47368289C402DEc660](https://sepolia.etherscan.io/address/0x80fc34a2f9FfE86F41580F47368289C402DEc660)\


Sepolia TRB cannot be minted from a playground faucet the way it was done on previous testnets which used "TRBP". Testers will need to make new requests in the Tellor public discord. Please include your public EVM address on Ethereum's Sepolia.\
\
We look forward to hearing from you! Once your TRB is bridged to Palmito, you can try running a validator, creating a reporter, tipping a reporter, and securing the authentically decentralized Tellor oracle.

### What is a Validator?&#x20;

Validators in the Tellor Layer network play a crucial role in maintaining the blockchain's integrity and consensus. They are responsible for validating transactions, securing the network, and ensuring the proper functioning of the blockchain. The number of total validators is capped at 100.

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


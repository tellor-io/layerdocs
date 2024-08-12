# Introduction

## What is Tellor Layer?

Tellor Layer is a stand alone L1 built using the cosmos sdk for the purpose of coming to consensus on any subjective data. It works by using a network of staked parties who are crypto-economically incentivized to honestly report requested data. &#x20;

{% hint style="info" %}
For more in-depth information, checkout the [Tellor Layer tech paper](https://github.com/tellor-io/layer/blob/main/TellorLayer%20-%20tech.pdf) and our [ADRs](https://github.com/tellor-io/layer/tree/main/adr).
{% endhint %}

## Antietam Testnet

In preparation for Tellor Layer's launch to mainnet we are conducting a series of public testnets, the first is called Antietam, with the goal of testing the functionality and processes of running a node, and participating as a validator and reporter.   &#x20;

### What is a Validator?&#x20;

Validators in the Tellor Layer network play a crucial role in maintaining the blockchain's integrity and consensus. They are responsible for validating transactions, securing the network, and ensuring the proper functioning of the blockchain.  The number of total validators is capped at 100.

#### **Responsibilities of a Validator:**

1. **Transaction Validation:** Validators validate transactions and add them to the chain.
2. **Consensus Participation:** They participate in the consensus mechanism to agree on the state of the chain.
3. **Block Proposal:** Validators propose new blocks and ensure that all committed transactions are included.
4. **Signing:** Validators sign aggregated data values, ensuring their correctness before they are relayed to other chains.

#### **Reporters are responsible for:**

* **Submitting values** for data requests (queries) that are subject to validation and disputes.  \*Validators can be reporters but not all reporters will be validators.




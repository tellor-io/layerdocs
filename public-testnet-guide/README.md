# Public Testnet Guide

## Join the Public Testnet

**In this guide we we'll cover the necessary steps to:**

1. Configure a Tellor Layer node and join the network using setup scripts.
2. Use the node to stake test TRB as a Layer validator and earn rewards.

{% hint style="warning" %}
**Note:** This is a guide for setting up a Tellor Layer public testnet node. Care is taken to provide clarity on the tools being used, but testers should be comfortable with running experimental code via command line interface. A beginner’s understanding of the cosmos SDK is highly recommended!&#x20;
{% endhint %}

{% hint style="info" %}
**Note:** Oracle data reporting is not ready for public testing at this time.
{% endhint %}

### Pre-requisites

* A local or cloud system running linux or macos
* Golang v1.22
* jq, yq, and sed for running the scripts:
  * Install jq
    * For mac: brew install jq
    * For linux Ubuntu: sudo apt-get install jq
  * Install yq
    * For mac: brew install yq
    * For linux Ubuntu: sudo apt-get install yq
  * Install sed
    * For mac: brew install sed
    * For linux: sudo apt-get install sed
* Testnet TRB for staking a validator. Feel free to request some layer test TRB in the public discord #developers channel, or try the token bridge from the Sepolia testnet playground.



### &#x20;

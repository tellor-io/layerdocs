---
description: How to use Etherscan to "manually" bridge TRB back to Ethereum.
---

# Request a Withdrawal via CLI

#### 1. Request your withdrawal via cli.&#x20;

The withdraw-tokens command is used to initiate a withdraw of "loose" TRB from tellor layer:

```sh
./layerd tx bridge withdraw-tokens [creator] [recipient] [amount] [flags]
```

\[creator]: Your tellor layer account's tellor1 prefix address.

\[recipient]: An ethereum address that you control. (Used to claim the tokens.)

\[amount]: The amount that you want to withdraw in loya (Note: 1 TRB = 1000000loya)

Full example requesting a withdrawal of 23 TRB:

{% code overflow="wrap" %}
```sh
./layerd tx bridge withdraw-tokens tellor1qw46ez58fjmp29f4r0a66278fyrhc4n4px9xyv 0xEcEFCC185418D7266E67C8a6374E580a187C0D1d 23000000loya --from ACCOUNT_NAME --fees 7loya --chain-id tellor-1 # or layertest-4 for testnet TRB
```
{% endcode %}

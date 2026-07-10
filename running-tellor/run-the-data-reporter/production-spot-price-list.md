---
description: A list of used spot price feeds.
---

# Production Spot Price List

{% hint style="info" %}
Note: These feeds are configured automatically on first run by [reporterd](./). If you find that you are not able to report any of these prices, please [update your data reporter!](updating-reporterd.md)
{% endhint %}

There are two different methods for calculating prices: "Market", and "Fundamental".

**Market**: A median of market prices from exchange APIs.

**Fundamental**: (conversion rate from the token contract) \* (market price of the collateral asset). These feeds require EVM RPC calls to calculate.

1. BTC/USD: Market
2. ETH/USD: Market
3. TRB/USD: Market
4. USDC/USD: Market
5. USDT/USD: Market
6. tBTC/USD: Market
7. wstETH/USD: Fundamental
8. rETH/USD: Fundamental
9. sfrxUSD/USD: Fundamental
10. sUSDe/USD: Fundamental

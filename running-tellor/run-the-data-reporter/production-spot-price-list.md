---
description: A list of used spot price feeds.
---

# Production Spot Price List

{% hint style="info" %}
Note: These feeds are configured automatically on first run by [reporterd](./). If you find that you are not able to report any of these prices, please [update your data reporter! ](updating-reporterd.md)
{% endhint %}

There are two different methods for calculating prices: "Market", and "Fundamental".

**Market**: A median of market prices from exchange APIs.

**Fundamental**: (conversion rate from the token contract) \* (market price of the collateral asset). These feeds require EVM RPC calls to calculate.

1. BTC/USD: Market&#x20;
2. ETH/USD: Market
3. KING/USD: Market
4. rETH/USD: Fundamental
5. SAGA/USD: Market
6. sfrxUSD/USD: Fundamental
7. stATOM/USD: Market
8. sUSDe/USD: Fundamental
9. sUSDS/USD: Market
10. sUSN/USD: Fundamental
11. tBTC/USD: Market
12. TRB/USD: Market
13. USDC/USD: Market
14. USDN/USD: Market
15. USDT/USD: Market
16. vyUSD/USD: Fundamental
17. wstETH/USD: Fundamental
18. yETH/USD: Fundamental
19. yUSD/USD: Fundamental

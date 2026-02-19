# On-Chain Orderbook Engine

This repository provides a high-performance Solidity implementation of a Limit Order Book. Unlike automated market makers (AMMs), this engine allows users to specify exact prices for their trades, bringing traditional finance efficiency to the blockchain.

## Trading Workflow
1. **Place Order:** Users submit a `LimitOrder` specifying side (Buy/Sell), amount, and price.
2. **Matching:** The engine checks the opposite side of the book for crossing prices.
3. **Execution:** If a match is found, assets are swapped atomically.
4. **Liquidity:** If no match exists, the order is added to the book, sorted by price priority.



## Technical Highlights
* **Doubly Linked List:** Used to maintain price levels for $O(1)$ insertion and removal.
* **Partial Fills:** Supports orders being filled across multiple smaller counter-orders.
* **Non-Custodial:** Funds are only moved upon successful match or cancellation.

## Gas Optimization
This contract minimizes storage writes by using packed structs and bitwise operations to track order status and mapping pointers.

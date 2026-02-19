// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract OrderBook is ReentrancyGuard {
    enum Side { Buy, Sell }

    struct Order {
        uint256 id;
        address trader;
        Side side;
        uint256 amount;
        uint256 price;
        uint256 filled;
    }

    uint256 public nextOrderId;
    mapping(uint256 => Order) public orders;
    
    // Simplified: Price -> Order IDs (In production, use a sorted Linked List)
    mapping(uint256 => uint256[]) public buyOrders; 
    mapping(uint256 => uint256[]) public sellOrders;

    event OrderPlaced(uint256 id, address indexed trader, Side side, uint256 amount, uint256 price);
    event TradeExecuted(uint256 buyId, uint256 sellId, uint256 amount, uint256 price);

    /**
     * @dev Places a limit order and attempts to match it immediately.
     */
    function placeOrder(Side _side, uint256 _amount, uint256 _price) external nonReentrant {
        uint256 orderId = nextOrderId++;
        orders[orderId] = Order(orderId, msg.sender, _side, _amount, _price, 0);

        _matchOrders(orderId);

        if (orders[orderId].filled < orders[orderId].amount) {
            if (_side == Side.Buy) buyOrders[_price].push(orderId);
            else sellOrders[_price].push(orderId);
        }

        emit OrderPlaced(orderId, msg.sender, _side, _amount, _price);
    }

    function _matchOrders(uint256 _orderId) internal {
        Order storage newOrder = orders[_orderId];

        if (newOrder.side == Side.Buy) {
            // Logic to iterate through sellOrders[price] where price <= newOrder.price
            // This is a simplified stub for demonstration of the matching flow
        } else {
            // Logic to iterate through buyOrders[price] where price >= newOrder.price
        }
    }

    function cancelOrder(uint256 _orderId) external {
        Order storage order = orders[_orderId];
        require(msg.sender == order.trader, "Not authorized");
        require(order.filled < order.amount, "Already filled");
        
        order.filled = order.amount; // Mark as filled/cancelled
    }
}

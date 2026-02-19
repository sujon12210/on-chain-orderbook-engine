export enum OrderSide {
    BUY = 0,
    SELL = 1
}

export interface LimitOrder {
    trader: string;
    side: OrderSide;
    amount: bigint;
    price: bigint;
}

export const formatOrder = (order: LimitOrder) => {
    return {
        ...order,
        amount: order.amount.toString(),
        price: order.price.toString()
    };
};

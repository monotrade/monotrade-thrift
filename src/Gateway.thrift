/*
 * This file contains the MonoTrade gateway interface.
 */

include "Types.thrift"
include "Errors.thrift"
include "Limits.thrift"

namespace java monotrade.gateway
namespace go monotrade.gateway
namespace netstd MonoTrade.Gateway
namespace py monotrader.gateway
namespace cpp monotrade


/*
 * 实现回调等不宜用 thrift 定义的特性。
 * Minxin 会注入到实际的 Gateway 中
 */
service GatewayMixin {
	
}


/*
 * 这个 TradeSide 是为了实现 Gateway 的方便
 */
enum TradeSide {
	BUY,
	SELL,
	SHORT,
	COVER,
	SELL_TODAY,
	COVER_TODAY,
}

service Gateway {
	void initialize();
	void connect();
	void close();

	/**
	 * Send a new order. retrun orderId.
     TODO: 是否返还 OrderResult？
	 */
	string sendOrder(1: Types.Symbol symbol, 
					 2: double price,
					 3: i32 volume,
					 4: TradeSide side,
					 5: Types.TradeType tradeType,
					 6: Types.PriceType priceType
			)
		throws (1: Errors.OrderException orderException);

    void cancelOrder(1: string orderID)
    	throws (1: Errors.OrderException orderException);
}
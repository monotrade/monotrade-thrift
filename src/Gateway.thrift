/*
 * This file contains the MonoTrade gateway interface.
 */

include "Types.thrift"
include "Errors.thrift"
include "Limits.thrift"
include "Trade.thrift"

namespace java monotrade.gateway
namespace go monotrade.gateway
namespace csharp MonoTrade.Gateway
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
	void connect(1: map<string,string> setting)
	void close()

	/**
	 * Send a new order. retrun orderId.
     TODO: 是否返还 OrderResult？
	 */
	string sendOrder(1: Types.Symbol symbol, // full symbol with code and exchange
					 2: double price,
					 3: double volume,
					 4: Trade.Trade side,
					 # 4: Trade.Offset offset,
  	 				 # 5: Trade.OrderType type,

  	 				 6: Trade.PriceType priceType  //  默认：限价
					 7: Trade.TradeType tradeType,  // 普通，套保，套利，备兑
					 

					 10: string reference = "", // 备注

			)
		throws (1: Errors.OrderException orderException);

    void cancelOrder(1: string orderID)
    	throws (1: Errors.OrderException orderException);


        #    void Subscribe(string symbol);
        #void SendOrder(OrderRequest request);
        #void cancelOrder(string orderID);

        #// asynchronised query
        #void queryAccount();
        #void queryPosition();

}
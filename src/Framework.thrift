/*
 * 本文件中平台接口。
 */
include "Types.thrift"
include "Errors.thrift"
include "Limits.thrift"
include "Trade.thrift"
include "Market.thrift"

namespace java monotrade
namespace go monotrade
namespace csharp MonoTrade
namespace py monotrade
namespace cpp monotrade

/**
    Event engine distributes event object based on its type to those handlers registered.

    It also generates timer event by every interval seconds, which can be used for timing purpose.
*/
// service MessageEngine {
// 	void put(1: any message)
// }


/*
 * 实现回调等不宜用 thrift 定义的特性。
 *
 * 包括 Gateway需要使用到的方法的定义，以及 Gateway的上下文数据
 * 使用基类， mixin, 还是 引用 context ?????
 */
service GatewayContext {
    // Gateway 可以调用的方法(通过 GatewayContext, 或 Mixin 实现？)
    void onTick(1: Market.Tick tick);
    void onOrder(1: Trade.Order order);
    void onTrade(1: Trade.Trade trade);
    void onPosition(1: Trade.Position position);
    void onAccount(1: Trade.Account account);
    void onLog(1: string message);
    void onHint(1: string hintMessage);
    void onVoice(1: string voiceMessage);
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

service Strategy {
	
}
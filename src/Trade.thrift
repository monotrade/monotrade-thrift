include "Types.thrift"

/*
 * 本文件中定义交易相关的类型。
 */

namespace java monotrade.trade
namespace go monotrade.trade
namespace csharp MonoTrade.Trade
namespace py monotrade.trade
namespace cpp monotrade







struct Portfolio {

}






struct Transaction {
    1: string symbol,   
}


 

struct OrderRequest {
  	 1: Types.Symbol symbol, // full symbol with code and exchange
  	 2: Types.Direction direction,
  	 3: Types.Offset offset,
  	 4: Types.OrderType type,
  	 5: double price,
  	 6: double volume,


//     reference: str = ""

}

enum OrderStatus {
		SUBMITTING = 0;	//"提交中"
	    NOTTRADED = 1;	//"未成交"
	    PARTTRADED = 2;	//"部分成交"
	    ALLTRADED = 3;	//"全部成交"
	    CANCELLED = 4;	//"已撤销"
	    REJECTED = 5;	//"拒单"
	}

struct Order {
	99: string gatewayName,

	1: Types.Symbol symbol, // full symbol with code and exchange
  	2: Types.Direction direction,
  	3: Types.Offset offset,
	4: Types.OrderType type,
	5: double price,
	6: double volume,

	50: string orderID,
	51: Types.Timestamp time,
	52: double tradedVolume,
	53: double leftVolume,
	

	

	// enum ActiveStatus {
	// 	//     def is_active(self) -> bool:		
	// }
	
    59: OrderStatus status,

}



//Trade data contains information of a fill of an order. One order
//can have several trade fills.
    
struct Trade {
	1: Types.Symbol symbol, // full symbol with code and exchange
  	2: string orderID,
  	3: string tradeID,
  	4: Types.Direction direction,
  	5: Types.Offset offset,
	6: Types.OrderType type,
	11: Types.Timestamp time,
	12: double price,
	13: double volume,
    99: string gatewayName,
}


//Positon data is used for tracking each individual position holding.
struct Position {
	1: Types.Symbol symbol, // full symbol with code and exchange
	2: Types.Direction direction,
	3: double volume,
	4: double price,			//均价
	5: double frozenVolume,
	6: double profitAndLoss,	//盈亏
	7: double yesterdayVolume,	// 昨仓
	99: string gatewayName,
}

//Account data contains information about balance, frozen and available.
struct Account {
	1: string accountID,
	2: double balance,		// 余额
	3: double frozen,		// 冻结
}


include "Types.thrift"

/*
 * 本文件中定义交易相关的类型。
 */

namespace java monotrade.trade
namespace go monotrade.trade
namespace csharp MonoTrade.Trade
namespace py monotrade.trade
namespace cpp monotrade




//     Direction of order/trade/position.

enum Direction {
    LONG = 0;
    SHORT = 1;
    //     NET = "净"
}



//     Offset of order/trade.
enum Offset {
    OPEN = 0;           //     OPEN = "开"
    CLOSE = 1;          //     CLOSE = "平"
    CLOSETODAY = 2;     //     CLOSETODAY = "平今"
    CLOSEYESTERDAY = 3; //     CLOSEYESTERDAY = "平昨"
}

/**
 * 交易类型。 在下单时指定交易的目的。 是否支持取决于账户的权限。
 *
 * NORMAL: 现货普通交易，期货和期权的投机交易。
 *
 * HEDGING: 保值(套保)，适用于期货。期货帐号要开通相应的权限。
 *
 * ARBITRAGE: 套利，适用于期货。期货帐号要开通相应的权限。
 *
 * COVERED: 备兑交易，适用于期权。期权帐号要开通相应的权限。
 *          备兑开仓是指投资者在拥有标的证券（含当日买入）的基础上，
 *          卖出相应的认购期权（百分之百现券担保，不需现金保证金），
 *          即通过备兑开仓增加备兑持仓头寸。 
 *          此时该投资者为期权的卖方，可以获得相应的权利金。 
 */

enum TradeType {
    NORMAL = 1,      # 0x000001   普通
    HEDGING = 4,     # 0x000100   套保
    ARBITRAGE = 8,   # 0x001000   套利
    COVERED = 16,    # 0x010000   备兑
}




/**
 * This enumeration defines the price type of an order.
 * It's determined by securities type and/or exchange.
 深证支持方式为LMT,BOC,BOP,ITC,B5TC,FOK
上证支持方式为LMT,B5TC,B5TL 
期权支持方式为LMT,ITC,FOK,FOK_LMT,EXE,MTL
港股支持方式为LMT,ALO,ACO,ELO,SLO
期货支持方式为LMT
#目前，深圳支持的方式为0－5，上海只支持0，4、6三种

 */
enum PriceType {
    LMT = 0,     #限价委托
    BOC  =  1  ,   #对方最优价格委托
    BOP  =  2  ,   #本方最优价格委托
    ITC  =   3 ,    #即时成交剩余撤销
    B5TC =   4 ,   #最优五档剩余撤销
    FOK  =   5 ,   #全额成交或撤销委托(市价FOK)
    B5TL =   6 ,   #最优五档剩余转限价
    ALO  =   7 ,  #竞价限价盘
    ACO  =   8 ,  #竞价盘
    ELO  =   9 ,  #增强限价盘
    SLO  =   10  ,  #特别限价盘
    FOK_LMT = 11 ,  #全额成交或撤销委托(限价FOK)
    EXE  =    12 ,  #期权行权
    MTL  =    13  #市价剩余转限价

/* O32
    price_type  UFX价格类型
'0' 限价
'1' 任意价(期货,期权,不支持中金所,上期所和能源期货交易所)
'2' 市价剩余转限价（上交所股票期权）
'3' 市价剩余撤消（上交所股票期权）
'4' FOK限价（上交所股票期权）
'5' FOK市价（上交所股票期权）,股转市场(协议成交确认申报)
'a' 五档即成剩撤（上交所市价）
'b' 五档即成剩转（上交所市价）
'c' 限价盘（零股）(港股通)
'e' 竞价限价盘(港股通)
'g' 增强限价盘(港股通)
'i' 竞价限价盘FOK(港股通)
'j' 增强限价盘FOK(港股通)（郑商所期货，期权，大商所期货FAK市价）
'k' 定价申报(股转市场)（郑商所期权，大商所期货FOK市价）
'l' 协议转让成交确认申报(股转市场)
'm' 协议转让互报成交确认申报(股转市场)
'A' 五档即成剩撤（深交所市价）
'C' 即成剩撤（深交所市价）
'D' 对手方最优（深交所市价）（科创板业务）
'E' 本方最优（深交所市价）（科创板业务）
'F' 全额成或撤（FOK市价）（深交所市价）
'G' 全额成或撤(FOK限价)（上期所、中金所、深交所、能源交易所）（郑商所期权，大商所期货，期权FOK限价）
'K' 即成剩撤（FAK）（上期所、郑商所期货，期权、中金所、能源交易所）（大商所期货，期权即成剩撤(FAK)）
'L' 五档即成剩撤（中金所五档市价）
'M' 五档即成剩转（中金所五档市价转限价）
'N' 最优一档即成剩撤（中金所最优价）
'O' 最优一档即成剩转（中金所最优价）



struct PriceType {
    /*
    QuanTu


    2   10002   价格类型
    上交所价格类型 
    0   限价
    A   五档即成剩撤
    b   五档即成剩转
    深交所价格类型 
    0   限价
    A   五档即成剩撤
    C   即成剩撤
    D   对手方最优
    E   本方最优
    F   全额成或撤
    期货价格类型  
    0   限价
    
}

*/
}





struct Portfolio {

}






struct Transaction {
    1: string symbol,   
}


 
enum OrderType {
    LIMIT = 0;  //"限价"
    MARKET = 1;  //"市价"
    STOP = 2;  //"STOP"
    FAK = 3;  //"FAK"
    FOK = 4;  //"FOK"
    //RFQ = 0;  //"询价"
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
  	2: Direction direction,
  	3: Offset offset,
	4: OrderType type,
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
  	4: Direction direction,
  	5: Offset offset,
	//6: OrderType type,
	11: Types.Timestamp time,
	12: double price,
	13: double volume,
    99: string gatewayName,
}


//Positon data is used for tracking each individual position holding.
struct Position {
	1: Types.Symbol symbol, // full symbol with code and exchange
	2: Direction direction,
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


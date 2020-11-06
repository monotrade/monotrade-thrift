include "Types.thrift"


/*
 * 本文件中定义 MonoTrade 中市场相关的公共类型。
 */

namespace java monotrade.types
namespace go monotrade.types
namespace csharp MonoTrade.Types
namespace py monotrade.types
namespace cpp monotrade




/**
 * Tick 数据
 * 已参考: vnpy, RootNet, Quantu
 */
struct Tick {
	1: Types.Symbol symbol,					
    2: Types.Exchange exchange,
    3: string name,
    4: Types.Timestamp timestamp,
    
    10: double preClosePrice,
    11: double lastPrice,
    12: double openPrice,
    13: double highPrice,
    14: double lowPrice,
    15: i32 volume,   // 累计成交量
    16: double amount, // 累计成交金额


	21: list<double> askPrices,
	22: list<i32> askVolumes,  
    23: list<double> bidPrices,
    24: list<i32> bidVolumes,  

   
//    limit_up: float = 0
//    limit_down: float = 0
//  trade_type          int                   
//交易类型 1: ‘双开’, 2: ‘双平’, 3: ‘多开’, 4: ‘空开’, 5: ‘空平’, 6: ‘多平’, 7: ‘多换’, 8: ‘空换’
  
}
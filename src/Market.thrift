include "Types.thrift"


/*
 * 本文件中定义 MonoTrade 中市场相关的公共类型。
 */

namespace java monotrade.types
namespace go monotrade.types
namespace csharp MonoTrade.Types
namespace py monotrade.types
namespace cpp monotrade

/*************************************/


message Security {
    string symbol = 1;  // full symbol with code and exchange
    monotrade.message.SecurityType type = 2;
    string display_name = 3;    // 中文名称
    string name = 4;    // 代号
    string start_date = 5;  // yyyy-mm-dd
    string end_date = 6;    // yyyy-mm-dd
}



message Tick {
  string symbol = 1;
  google.protobuf.Timestamp time = 2;
  //name: str = ""

  float openPrice = 10;
  float highPrice = 11;
  float lowPrice = 12;
  float preClosePrice = 13;
  float lastPrice = 14;     //当前价

  // limit_up: float = 0
  // limit_down: float = 0
  float volume = 21;        //累计成交量（股）
  float amount = 22;        //累计成交额

  // repeated float askPrices = 0.0;
  // repeated float askVolumes = 0;

  float bidPrice1 = 31;
  float bidPrice2 = 32;
  float bidPrice3 = 33;
  float bidPrice4 = 34;
  float bidPrice5 = 35;

  float bidVolume1 = 41;
  float bidVolume2 = 42;
  float bidVolume3 = 43;
  float bidVolume4 = 44;
  float bidVolume5 = 45;

  float askPrice1 = 51;
  float askPrice2 = 52;
  float askPrice3 = 53;
  float askPrice4 = 54;
  float askPrice5 = 55;

  float askVolume1 = 61;
  float askVolume2 = 62;
  float askVolume3 = 63;
  float askVolume4 = 64;
  float askVolume5 = 65;


}


message Bar {
  string symbol = 1;
  google.protobuf.Duration interval = 2;

  google.protobuf.Timestamp time = 3;

  float openPrice = 21;
  float highPrice = 22;
  float lowPrice = 23;
  float closePrice = 24;
  float volume = 25;
  float amount = 26;


  /* vnpy
    open_interest: float = 0
   */
}

//Contract data contains basic information about each contract traded.
message Contract {
  string symbol = 1;
  string name = 2;
}


// class ContractData(BaseData):
//     """
//     
//     """



//     product: Product
//     size: int
//     pricetick: float

//     min_volume: float = 1           # minimum trading volume of the contract
//     stop_supported: bool = False    # whether server supports stop order
//     net_position: bool = False      # whether gateway uses net position volume
//     history_data: bool = False      # whether gateway provides bar history data

//     option_strike: float = 0
//     option_underlying: str = ""     # vt_symbol of underlying contract
//     option_type: OptionType = None
//     option_expiry: datetime = None
//     option_portfolio: str = ""
//     option_index: str = ""          # for identifying options with same strike price


/******************************************/


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
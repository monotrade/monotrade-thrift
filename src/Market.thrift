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


struct Security {
    1: Types.Symbol symbol, // full symbol with code and exchange
    2: Types.SecurityType type,
    3: string display_name,    // 中文名称
    4: string name,    // 代号
    5: Types.Timestamp start_date = 5;  // yyyy-mm-dd
    6: Types.Timestamp end_date = 6;    // yyyy-mm-dd
}


struct Tick {
    1: Types.Symbol symbol, // full symbol with code and exchange
    2: Types.Timestamp time,

    10: double openPrice,
    11: double highPrice,
    12: double lowPrice,
    13: double preClosePrice,
    14: double lastPrice,

    // limit_up: double = 0
    // limit_down: double = 0
  
    21: double volume,        //累计成交量（股）
    22: double amount,        //累计成交额

    // repeated double askPrices = 0.0;
    // repeated double askVolumes = 0;

    31: double bidPrice1,
    32: double bidPrice2,
    33: double bidPrice3,
    34: double bidPrice4,
    35: double bidPrice5,

    41: double bidVolume1,
    42: double bidVolume2,
    43: double bidVolume3,
    44: double bidVolume4,
    45: double bidVolume5,

    51: double askPrice1,
    52: double askPrice2,
    53: double askPrice3,
    54: double askPrice4,
    55: double askPrice5,

    61: double askVolume1,
    62: double askVolume2,
    63: double askVolume3,
    64: double askVolume4,
    65: double askVolume5,


}


struct Bar {
    1: Types.Symbol symbol, // full symbol with code and exchange
    2: Types.Timestamp time,
    3: Types.Duration interval,
    
    21: double openPrice,
    22: double highPrice,
    23: double lowPrice,
    24: double closePrice,
    25: double volume,
    26: double amount,


  /* vnpy
    open_interest: double = 0
   */
}

//Contract data contains basic information about each contract traded.
struct Contract {
    1: Types.Symbol symbol, // full symbol with code and exchange
    2: string name,    // 代号  
}


// class ContractData(BaseData):
//     """
//     
//     """



//     product: Product
//     size: int
//     pricetick: double

//     min_volume: double = 1           # minimum trading volume of the contract
//     stop_supported: bool = False    # whether server supports stop order
//     net_position: bool = False      # whether gateway uses net position volume
//     history_data: bool = False      # whether gateway provides bar history data

//     option_strike: double = 0
//     option_underlying: str = ""     # vt_symbol of underlying contract
//     option_type: OptionType = None
//     option_expiry: datetime = None
//     option_portfolio: str = ""
//     option_index: str = ""          # for identifying options with same strike price


/******************************************/



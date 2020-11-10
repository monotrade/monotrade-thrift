/*
 * 本文件中定义 MonoTrade 中的公共类型。
 */

namespace java monotrade.types
namespace go monotrade.types
namespace csharp MonoTrade.Types
namespace py monotrade.types
namespace cpp monotrade


/**
 * An Evernote Timestamp is the date and time of an event in UTC time.
 * This is expressed as a specific number of milliseconds since the
 * standard base "epoch" of:
 *
 *    January 1, 1970, 00:00:00 GMT
 *
 * NOTE:  the time is expressed at the resolution of milliseconds, but
 * the value is only precise to the level of seconds.   This means that
 * the last three (decimal) digits of the timestamp will be '000'.
 *
 * The Thrift IDL specification does not include a native date/time type,
 * so this value is used instead.
 *
 * The service will accept timestamp values (e.g. for Note created and update
 * times) between 1000-01-01 and 9999-12-31
 */
typedef i64 Timestamp



/**
 *  duration of milliseconds
 */
typedef i64 Duration 

/**
 * 证券代码在交易模型中是一个非常重要的标识，用于关联各类数据。
 * 为了严格统一定义，这里定义了一个专门的类型 `Symbol`。 Symbol的格式应该为:
 * `证券代码.交易所代码`，并通过约束 `Limits.SYMBOL_REGEX` 进行限制。
 * 实现的框架中应该用该约束进行检查。
 */
typedef string Symbol



enum SecurityType {    
    STOCK = 0;  //股票,   EQUITY(vnpy)
    FUND = 1;   // 基金
    INDEX = 2; // 指数
    FUTURES = 3; // 期货
    OPTIONS = 4; //期权
    ETF = 5;    // ETF
    
    
    
    SPREAD = 80;  // 价差
    
    /* others in vnpy
    FOREX = "外汇"
    SPOT = "现货"
    BOND = "债券"
    WARRANT = "权证"

    * others in joinQuant
     lof'
     fja'
     fjb'
     open_fund'
     bond_fund'
     stock_fund'
     QDII_fund'
     money_market_fund'
     mixture_fund'。
    */
}

/**
 *
 */
#struct Exchange {
#    1: string name,
#    2: string code,
#    //3: list<PriceType> supportedPriceTypes,
#}



enum Exchange {
    // 以百度百科中的缩写为准
    //proto3版本中，首成员必须为0，成员不应有相同的值

    SSE = 0;   //Shanghai Stock Exchange. XSHG(joinQuant)
    SZSE = 1;  //Shenzhen Stock Exchange. XSHE(JoinQuant)
    CFFEX = 2; //China Financial Futures Exchange. CCFX(JoinQuant)
    SHFE = 3;  //Shanghai Futures Exchange. XSGE(JoinQuant)
    CZCE = 4;  //Zhengzhou Commodity Exchange.  XZCE(JoinQuant)
    DCE = 5;   //Dalian Commodity Exchange.  XDCE(JoinQuant)
    INE = 6;  // Shanghai International Energy Exchange.  XINE(JoinQuant)
    
    NEEQ = 10; //
    
    LOCAL = 99; // For local generated data

    /* others in vnpy
    # Chinese
    
    SGE = "SGE"             # Shanghai Gold Exchange
    WXE = "WXE"             # Wuxi Steel Exchange
    CFETS = "CFETS"         # China Foreign Exchange Trade System
    */
}


//     Direction of order/trade/position.

enum Direction {
    LONG = 0;
    SHORT = 1;
    //     NET = "净"
}




enum OrderType {
    LIMIT = 0;  //"限价"
    MARKET = 1;  //"市价"
    STOP = 2;  //"STOP"
    FAK = 3;  //"FAK"
    FOK = 4;  //"FOK"
    //RFQ = 0;  //"询价"
}
    
    

/******************************/







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





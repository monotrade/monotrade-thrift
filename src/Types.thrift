/*
 * 本文件中定义 MonoTrade 中所有的公共类型。
 */

namespace java monotrade.type
namespace csharp MonoTrade.Type
namespace py monotrade.type
namespace cpp monotrade

// =============================== attribute defs ====================================
/**
 * 证券代码在交易模型中是一个非常重要的标识，用于关联各类数据。
 * 为了严格统一定义，这里定义了一个专门的类型 `Symbol`。 Symbol的格式应该为:
 * `证券代码.交易所代码`，并通过约束 `Limits.SYMBOL_REGEX` 进行限制。
 * 实现的框架中应该用该约束进行检查。
 */
typedef string Symbol

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
    NORMAL = 1,      # 0x000001
    HEDGING = 4,     # 0x000100
    ARBITRAGE = 8,   # 0x001000 
    COVERED = 16,    # 0x010000
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




/**
 *
 */
struct Exchange {
	1: string name,
	2: string code,
	//3: list<PriceType> supportedPriceTypes,
}


struct Tick {
	1: Symbol symbol,					# vnpy 

	2: list<double> ask_prices,
	3: list<i32> ask_volumes,  
	/*
	tick包含的key值有下列值.
    symbol              str                   标的代码
    open                float                 开盘价
    high                float                 最高价
    low                 float                 最低价
    price               float	              最新价
    cum_volume          long                  成交总量/最新成交量,累计值
    cum_amount          float                 成交总金额/最新成交额,累计值
    trade_type          int                   交易类型 1: ‘双开’, 2: ‘双平’, 3: ‘多开’, 4: ‘空开’, 5: ‘空平’, 6: ‘多平’, 7: ‘多换’, 8: ‘空换’
    last_volume         int                   瞬时成交量
    cum_position        int                   合约持仓量(期),累计值（股票此值为0）
    last_amount         float                 瞬时成交额
    created_at          datetime.datetime     创建时间
    receive_local_time  float             收到时的本地时间秒数. 3.0.113 后增加  注意: 内部使用
    quotes              list[Dict]            股票提供买卖5档数据, list[0]~list[4]分别对应买卖一档到五档, 期货提供买卖1档数据, list[0]表示买卖一档. 目前期货的 list[1] ~ list[4] 值是没有意义的
        quotes 里每项包含的key值有:
          bid_p:  float   买价
          bid_v:  int     买量
          ask_p   float   卖价
          ask_v   int     卖量*/  
}

struct Bar {
	1: Symbol symbol,					# vnpy 

	/*
	 bar 对象包含的key值有下列值.
    symbol         str      标的代码
    frequency      str      频率, 支持多种频率. 要把时间转换为相应的秒数. 如 30s, 60s, 300s, 900s
    open           float    开盘价
    close          float    收盘价
    high           float    最高价
    low            float    最低价
    amount         float    成交额
    volume         long     成交量
    position       long     持仓量（仅期货）
    bob            datetime.datetime    bar开始时间
    eob            datetime.datetime    bar结束时间
    receive_local_time  float       收到时的本地时间秒数. 3.0.113 后增加  注意: 内部使用
	*/
}


struct Trade {
	1: string symbol,					# vnpy 
}

struct Position {
	1: string symbol,					# vnpy 
}


struct Portfolio {

}


struct Account {
	1: string symbol,					# vnpy 
}

struct Order {
	1: string symbol,					# vnpy 
}




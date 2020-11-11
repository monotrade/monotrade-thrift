/**
 * 本文件定义和策略相关的服务。主要有：
 * <dl>
 * <dt>策略接口(Strategy)</dt> 
 * 策略接口定义了策略规范，所有策略都必须实现该接口中定义的功能。
 * 策略平台通过本接口管理和执行策略。
 *
 * <dt>策略扩展(StrategyMixin)</dt>
 * 实现策略运行中需要调用平台的一些方法。
 * 为了避免策略中对平台对象的引用，可以在动态语言中将 StrategyMixin 注入到策略实例中。
 * 比如 python 中的 Minxin class (通过多重继承实现)，
 * 或者 csharp 中的扩展方法(extension method)实现。
 *
 * <dt>策略上下文(StrategyContext)</dt>
 * 策略运行中，有一些公共的状态需要记录，比如策略所有的委托，相关证券的最新/历史行情，
 * 持仓状态，关联的帐户/组合的资金状态等。
 * 这些信息可以由平台维护，策略只需要对其进行只读访问，从而降低策略编写的复杂度。
 * TODO: 放在策略中，还是Context中？
 * TODO: 决策表？
 */

include "Types.thrift"
include "Errors.thrift"
include "Limits.thrift"

include "Market.thrift"
include "Trade.thrift"

namespace java monotrade.strategy
namespace go monotrade.strategy
namespace csharp MonoTrade.Strategy
namespace py monotrade.strategy
namespace cpp monotrade


/*
 * 策略运行上下文。 平台应将其注入到策略中，并更新其中的数据。
 * 理论上，这些数据对策略只读。
 */
struct StrategyContext {
    /*
    self.ticks = {}
    self.orders = {}
    self.trades = {}
    self.positions = {}
    self.accounts = {}
    self.contracts = {}
    self.active_orders = {}
    */

}

/**
 * 下单或撤单动作的结果类型。 只用于 <href>OrderResult</href>.
 *
 * SUCCESSFUL: 下单或撤单指令正确，且符合风控要求，已经报往交易所。
 *
 * UNSUFFICIENT: 余额不足(持仓余额或资金不足)
 *
 * RISKFUL: 该委托存在风险，且达到了风控禁止的条件.
 *
 * OTHERS: 由于其他原因导致的下单或撤单失败。
 */
enum OrderResultType {
	SUCCESSFUL = 0,
	UNSUFFICIENT = 1,
	RISKFUL = 2,
	OTHERS = 99,
}

/**
 * 下单或撤单动作返回的结果.  
 * <dl>
 * <dt>resultType:</dt> 结果类型。 表示下单动作成功或失败。详见 OrderResultType。
 * <dt>orderID:</dt> 订单号。由交易所分配。 
 * 下单成功时，返回交易所分配的订单号
 * 下单失败时，不返回订单号
 * 撤单时，不管成功或失败均返回待撤的订单号
 * <dt>externalID:</dt> 第三方系统自定义号。比如柜台系统中的流水号。
 * </dl>
 */
struct OrderResult {
	1: required OrderResultType resultType,
	2: optional string orderID,		# 
	3: optional string externalID,
	4: string message

/*
QuanTu

MBasketEntrustResult			
字段名称	字段说明	字段类型	备注
error_no	错误代码	int	
error_info	证券代码	string	
entrust_no	委托编号	int	
batch_no	操作批号	int	
investunit_id	投资单元ID	int	
instance_id	交易投资组合ID	int	
capitalunit_id	资金账户ID	int	
strategy_flag_id	策略标志ID	int	
strategy_req_id	策略请求ID	int	
success_flag	撤单成功标志	string	


O32

1: required OrderResultType resultType,
	2: optional string orderID,		# 
	3: optional string externalID
	/*
	risk_serial_no	N8	风控判断流水号		用于关联风控信息包中的风控信息条目	v	v	v
*/


}




/*
 * 策略中使用到的一些功能。 在框架/策略基类中要实现这些功能，
 * 并注入或继承到具体策略中。
 */
service StrategyMixin {
	/**
	  * 获取策略上下文数据
	  */

	StrategyContext getContext();

	/**
	  * 买入委托。 适用于现货，期货，期权。
	  *
	  * @param symbol
	  *   交易标的，包括证券代码和交易所代码。
	  *
	  * @param price
	  *   买入价格。 对于某些市价单，忽略。
	  *
	  * @param volume
	  *   买入数量。 
	  *
	  * @param priceType
	  *   价格方式。指定为限价单或市价单等。 
	  *
	  * @param tradeType
	  *   交易类型。 默认为 TradeType.NORMAL。
	  *   对于期货，要指明是否为 套保 或 套利，
	  *   买入不适合期权备兑交易(TradeType.COVERED)
	  *
	  * @return
	  *   委托结果
	  *
	  * @throws OrderException
	  *   委托错误信息
	  * 
	  * @throws RiskException
	  *   风控异常. 策略平台中的风控信息能够进行处理,可以返回异常信息.
	  *   对于后端柜台系统的异步调用，只能在 OrderResult 中反映委托失败。
	  *   然后再从其他途径获取失败原因。  
	  */
	OrderResult buy(1: Types.Symbol symbol,  
   	                2: double price,   				    
				    3: i32 volume,				   
				    4: Trade.PriceType priceType,
				    5: Trade.TradeType tradeType)
        throws(1: Errors.OrderException OrderException);
        //throws(1: Errors.RiskException riskException);

	/**
	  * 卖出委托
      *
	  * @param symbol
	  *   交易标的，包括证券代码和交易所代码。
	  *
	  * @param price
	  *   卖出价格。 对于某些市价单，忽略。
	  *
	  * @param volume
	  *   卖出数量。 
	  *
	  * @param priceType
	  *   价格方式。指定为限价单或市价单等。 
	  *
	  * @param tradeType
	  *   交易类型。 默认为 TradeType.NORMAL。
	  *   对于期货，要指明是否为 套保 或 套利，
	  *   卖出不适合期权备兑交易(TradeType.COVERED)
	  *
	  * @return
	  *   委托结果
	  *
	  * @throws OrderException
	  *   委托错误信息
	  *   
	  */
   	OrderResult sell(1: Types.Symbol symbol,  
   				   2: double price,   				    
				   3: i32 volume,				   
				   4: Trade.PriceType priceType,
				   5: Trade.TradeType tradeType)
     throws(1: Errors.OrderException OrderException);


	/**
	  * 卖出平今仓。与 sell 类似。
	  * 对于期货，默认先平旧仓，后平今仓。
	  * 大商所、郑商所、中金所不支持平今。（但如果有今开，即使平旧仓也按平今手续费）
	  * 上期所支持指定平今
	  * 现货和期权不支持？
	  */
    OrderResult sellToday(1: Types.Symbol symbol,  
   				   2: double price,   				    
				   3: i32 volume,				   
				   4: Trade.PriceType priceType,
				   5: Trade.TradeType tradeType)
     throws(1: Errors.OrderException OrderException);


	/**
	  * 卖出开仓。
	  *
	  * @param tradeType
	  *   交易类型。 默认为 TradeType.NORMAL。
	  *   对于期货，要指明是否为 套保 或 套利，
	  *   对于期权，可以为 TradeType.NORMAL 或 备兑开仓(TradeType.COVERED)
	  *   <dd>备兑开仓是指投资者在拥有标的证券（含当日买入）的基础上，
      *       卖出相应的认购期权（百分之百现券担保，不需现金保证金），
      *       即通过备兑开仓增加备兑持仓头寸。</dd>
	  */

     OrderResult short(1: Types.Symbol symbol,  
   				   2: double price,   				    
				   3: i32 volume,				   
				   4: Trade.PriceType priceType,
				   5: Trade.TradeType tradeType)
     throws(1: Errors.OrderException OrderException);

    
    /**
	  * 买入平仓。
	  *
	  * @param tradeType
	  *   交易类型。 默认为 TradeType.NORMAL。
	  *   对于期货，要指明是否为 套保 或 套利，
	  *   对于期权，可以为 TradeType.NORMAL 或 备兑平仓(TradeType.COVERED)
      *   <dd>备兑平仓是指按申报数量冻结可平备兑持仓头寸，
      *       如超过当前可平备兑持仓头寸，则返回无效；
      *       并按申报的权利金金额计减可用保证金。成交后，计减备兑持仓头寸，
      *       计增备兑开仓（或解锁）额度。 </dd>
	  */
    OrderResult cover(1: Types.Symbol symbol,  
   				   2: double price,   				    
				   3: i32 volume,				   
				   4: Trade.PriceType priceType,
				   5: Trade.TradeType tradeType)
     throws(1: Errors.OrderException OrderException);

	/**
	  * 买入平今仓。与 cover 类似。
	  * 对于期货，默认先平旧仓，后平今仓。
	  * 大商所、郑商所、中金所不支持平今。（但如果有今开，即使平旧仓也按平今手续费）
	  * 上期所支持指定平今
	  * 现货和期权不支持？
	  */
      OrderResult coverToday(1: Types.Symbol symbol,  
   				   2: double price,   				    
				   3: i32 volume,				   
				   4: Trade.PriceType priceType,
				   5: Trade.TradeType tradeType)
     throws(1: Errors.OrderException OrderException);
     


	OrderResult cancelOrder(1: string orderID)
	     throws(1: Errors.OrderException OrderException);


	//TODO: bilateral quote such as NEEQ


	//TODO: 对于 broker，只订阅委托回报和成交回报？
	//TODO: 或者委托和成交不用订阅？

    void subscribe(1:Types.Symbol symbol)
    	throws (1: Errors.SubscribeException e);
    
    void unSubscribe(1:Types.Symbol symbol)
    	throws (1: Errors.SubscribeException e);

    void schedule(1:string period,
    	          2:string time)
    //void loadBar();
    //void loadTick();
    //void playVoice();

}


service Strategy {

	void initialize();
	void start();					# vnpy.CTA
	void stop();						# vnpy.CTA

	void onSchedule(
					1: string data_rule, 
					2: string timeRule);					# join quant

	void onTick(1: Market.Tick tick);	# vnpy.CTA
	void onBar(1: Market.Bar bar);	# vnpy.CTA

	void onTrade(1: Trade.Trade trade);	# vnpy.CTA
	void onPosition(1: Trade.Position position);	# vnpy.CTA
	void onAccount(1: Trade.Account accountStatus);	# vnpy.CTA
	void onOrder(1: Trade.Order orderStatus);	# vnpy.CTA

/*
    # type: (Context, int, Text) -> NoReturn
    """
    底层sdk出错时的回调函数
    :param context:
    :param code: 错误码.  参考: https://www.myquant.cn/docs/python/71
    :param info: 错误信息描述
    """
*/
	void onError();


/*
动态参数修改事件推送. 参数 parameter 为动态参数的信息
*/
	void onParameter();



	/*
	def on_execution_report(context, execrpt):
    # type: (Context, DictLikeExecRpt) -> NoReturn
    """
    委托执行回报事件. 参数 execrpt 为执行回报信息
    响应委托被执行事件，委托成交后被触发
    """
    pass

*/
}
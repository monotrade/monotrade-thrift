/*
 * This file contains the definitions of the Evernote-related errors that
 * can occur when making calls to EDAM services. 
 */

include "Types.thrift"
include "Limits.thrift"

namespace java monotrade.error
namespace go monotrade.error
namespace csharp MonoTrade.Error
namespace py monotrade.error
namespace cpp monotrade


/**
 *
 */
 
enum OrderErrorCode {
  UNKNOWN = 0,
  UNSUPPORTED_PRICE_TYPE = 1,
  BAD_DATA_FORMAT = 2,
}

/**
 * 在策略平台上拦截到的委托异常。 柜台的异步下单无法返回异常，只能先返回结果，
 * 在通过推送或查询获取错误信息。
 */
exception OrderException {
  1:  required  OrderErrorCode errorCode,
  2:  optional  string message,
  3:  optional  i32 rateLimitDuration
}

	//entrust_fail_code	N8	委托失败代码		参见数据字典17。	v	v	v
	//fail_cause	C256	失败原因			v	v	v




enum RiskLevel {
  NORMAL = 1,
  WARNING = 2,
  FORBIDDEN = 3
}


exception RiskException {
	
}




exception SubscribeException {
  
}

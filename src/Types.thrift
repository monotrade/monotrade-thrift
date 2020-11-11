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









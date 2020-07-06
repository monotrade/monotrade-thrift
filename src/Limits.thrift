/*
 * This file contains the allowable limits for the various fields and
 * collections that make up the MonoTrader data model.
 */
include "Types.thrift"

namespace java monotrade.limits
namespace go monotrade.limits
namespace csharp MonoTrade.Limits
namespace py monotrade.limits
namespace cpp monotrade.limits

// ========================== string field limits ==============================
/**
 * Any Symbol must match the provided regular expression.
 * more than 2 bits security code, '.', and 2-6 bit of exchange code.
 * 
 */
const string SYMBOL_REGEX = "^[^.]{2,}\\.[^.]{2,6}$";
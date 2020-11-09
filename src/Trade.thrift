syntax = "proto3";

package monotrade.message;
option go_package = ".;monotrade";

//import "google/protobuf/duration.proto";
import public "google/protobuf/timestamp.proto";
import "enums.proto";

message OrderRequest {
  string symbol = 1;
  monotrade.message.Direction direction = 2;
  monotrade.message.Offset offset = 3;
  monotrade.message.OrderType type = 4;
  float price = 5;
  float volume = 6; 


//     reference: str = ""

}



message Order {
	string gatewayName = 99;

	string symbol = 1;
  	monotrade.message.Direction direction = 2;
  	monotrade.message.Offset offset = 3;
	monotrade.message.OrderType type = 4;
	float price = 5;
	float volume = 6; 

	string orderID = 50;
	google.protobuf.Timestamp time = 51;
	float tradedVolume = 52;
	float leftVolume = 53;
	

	enum Status {
		SUBMITTING = 0;	//"提交中"
	    NOTTRADED = 1;	//"未成交"
	    PARTTRADED = 2;	//"部分成交"
	    ALLTRADED = 3;	//"全部成交"
	    CANCELLED = 4;	//"已撤销"
	    REJECTED = 5;	//"拒单"
	}

	// enum ActiveStatus {
	// 	//     def is_active(self) -> bool:		
	// }
	
    Status status = 59;

}



//Trade data contains information of a fill of an order. One order
//can have several trade fills.
    
message Trade {
	string symbol = 1;
  	string orderID = 2;
  	string tradeID = 3;

  	monotrade.message.Direction direction = 4;
  	monotrade.message.Offset offset = 5;
	monotrade.message.OrderType type = 6;

	google.protobuf.Timestamp time = 11;
	float price = 12;
	float volume = 13;
    
    string gatewayName = 99;
}


//Positon data is used for tracking each individual position holding.
message Position {
	string symbol = 1;
	monotrade.message.Direction direction = 2;
	float volume = 3;
	float price = 4;			//均价
	float frozenVolume = 5;
	float profitAndLoss = 6;	//盈亏
	float yesterdayVolume = 7;	// 昨仓
	string gatewayName = 99;
}

//Account data contains information about balance, frozen and available.
message Account {
	string accountID = 1;
	float balance = 2;		// 余额
	float frozen =3;		// 冻结
}


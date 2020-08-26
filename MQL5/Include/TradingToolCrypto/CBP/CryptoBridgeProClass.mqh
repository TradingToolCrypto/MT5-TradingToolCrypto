#property copyright "Copyright 2020, TradingToolCrypto Corp."
#property link      "https://github.com/tradingtoolcrypto"
#define VERSION 1.33
/*
   https://github.com/tradingtoolcrypto
*/
#import "CBP_Functions.ex5"
int GetOrderNumberFromLineName(string linename);
string GetVolumeFromLineName(string linename);
string GetSideFromLineName(string linename);
string GetObjectDesc(int what_order_number);
void DeleteOjectLinesByName(string linedesc);
void DeleteOjectLinesByDesc(string linedesc);
void DeleteOjectLines(string sym);
bool CreateOrderEntryLine(string name, string text, datetime time1, double price1, datetime time2, double price2, color col, int lineWidth, int lineStyle);
bool CreateTPLine(string name, string text, datetime time1, double price1, datetime time2, double price2, color col, int lineWidth, int lineStyle);
bool CreateEntryLine(string name, string text, datetime time1, double price1, datetime time2, double price2, color col, int lineWidth, int lineStyle);
void DeleteSubWindowObjectAll(long id_order, string objectname);
void DeleteSubWindowObjectName(long id_order, string objectname);
double GetGlobal(string ExchangeName, string body);
void DeleteGlobalOrderName(string exchangeName, string sym, double value);
void DeleteGlobalPrefix(string prefix);
void SetSubWindowText(string name, string text, int x, int y, color colour, int size);
void RewriteGlobals(string checkifexist, string replacewith);
string NormalizeString(string value, int digit);
#import

#import "Binance_api.ex5"
bool Binance_Cancel_Trade(string sym, long orderId);
bool Binance_Cancel_Trade_All(string sym);
bool Binance_Open_Trade(string sym, string side, string orderType, string orderSize, string orderPrice, int quoteDigit, int lotDigit);
bool Binance_Open_Trade_Stop(string sym, string side, string orderType, string orderSize, string stopPrice, int quoteDigit, int lotDigit);
bool Binance_Open_Trade_StopLimit(string sym, string side, string orderType, string orderSize, string orderPrice, string stopPrice, int quoteDigit, int lotDigit);
bool Binance_Balance(string sym, string quotebase);
bool Binance_GetPriceBest(string sym, int quote_digit);
bool Binance_GetPrice(string sym);
bool Binance_GetServerTime();
bool Binance_Get_API_Key(string key, string secret);
bool Binance_GetOpenOrders(string sym, int quote_precision);
#import

#import "BinanceUS_api.ex5"
bool Binance_US_Cancel_Trade(string sym, long orderId);
bool Binance_US_Cancel_Trade_All(string sym);
bool Binance_US_Open_Trade(string sym, string side, string orderType, string orderSize, string orderPrice, int quoteDigit, int lotDigit);
bool Binance_US_Open_Trade_Stop(string sym, string side, string orderType, string orderSize, string stopPrice, int quoteDigit, int lotDigit);
bool Binance_US_Open_Trade_StopLimit(string sym, string side, string orderType, string orderSize, string orderPrice, string stopPrice, int quoteDigit, int lotDigit);
bool Binance_US_Balance(string sym, string quotebase);
bool Binance_US_GetPriceBest(string sym, int quote_digit);
bool Binance_US_GetPrice(string sym);
bool Binance_US_GetServerTime();
bool Binance_US_Get_API_Key(string key, string secret);
bool Binance_US_GetOpenOrders(string sym, int quote_precision);
#import

#import "BinanceFutures_api.ex5"
bool BinanceFutures_HedgeMode(string hedgeOn_true_else_false);
bool BinanceFutures_Get_API_Key(string key, string secret, string livedemo);

bool BinanceFutures_Cancel_Trade(string sym, long orderId);
bool BinanceFutures_Cancel_Trade_ALL(string sym);
bool BinanceFutures_Open_Trade(string sym, string side, string orderType, string orderSize, string orderPrice,int quoteDigit, int lotDigit);
bool BinanceFutures_Open_Trade_Stop(string sym, string side, string orderType, string orderSize, string stopPrice, int quoteDigit, int lotDigit);
bool BinanceFutures_Open_Trade_StopLimit(string sym, string side, string orderType, string orderSize, string orderPrice, string stopPrice,int quoteDigit, int lotDigit);
bool BinanceFutures_Close_Trade(string sym, string side, string orderType, string orderSize, string orderPrice, int quoteDigit, int lotDigit);
bool BinanceFutures_Balance(string sym, string quotebase);
bool BinanceFutures_GetPriceBest(string sym, int quote_digit);
bool BinanceFutures_GetPrice(string sym, int quoteDigit);
bool BinanceFutures_GetOpenInterest(string sym, int quoteDigit);
bool BinanceFutures_GetFundRate(string sym, int quoteDigit);
bool BinanceFutures_GetOpenOrders(string sym, int quote_precision);
bool BinanceFutures_GetServerTime();
bool BinanceFutures_Set_Leverage(string sym, double leverage);
bool BinanceFutures_Positions(string sym, int quoteDigit); // returns the users open positions
#import

#import "Binance_Dex_api.ex5"
bool Biance_Dex_Cancel_Trade(string sym, int orderId);
bool Binance_Dex_Open_Trade(string sym, string side, string orderType, string orderSize, string orderPrice, int quoteDigit, int lotDigit);
bool Binance_Dex_Balance(string sym, string quotebase);
bool Binance_Dex_GetPriceBest(string sym);
bool Binance_Dex_GetPrice(string sym);
bool Binance_Dex_Get_API_Key(string key, string secret);
bool Binance_Dex_BlockTime();
bool Binance_Dex_Account(string address);
bool Binance_Dex_Symbols(int List_total);
bool Binance_Dex_Markets(int List_total);
bool Binance_Dex_Order_List(string address);
bool Binance_Dex_Time_Sales(string symbol, int limit);
#import

#import "Bybit_api.ex5"
bool Bybit_Modify_Trade(string sym, string orderId, string price, int quoteDigit, int lotDigit);
bool Bybit_Cancel_Trade(string sym, string orderId);
bool Bybit_Cancel_Trade_All(string sym);
bool Bybit_Open_Trade(string sym, string side, string orderType, string orderSize, string orderPrice, int quoteDigit, int lotDigit);
bool Bybit_Open_Trade_Stop(string sym, string side, string orderType, string orderSize, string stopPrice, int quoteDigit, int lotDigit);
bool Bybit_Balance(string sym, string quotebase);
bool Bybit_GetOpenOrders(string sym, int quote_precision);
bool Bybit_GetPriceBest(string sym, int quoteDigit);
bool Bybit_GetPrice(string sym, int quoteDigit);
bool Bybit_GetOpenInterest(string sym, int quoteDigit);
bool Bybit_GetFundRate(string sym, int quoteDigit);
bool Bybit_GetServerTime();
bool Bybit_Get_API_Key(string key, string secret, string livedemo);
bool Bybit_Leverage(int liveOne_demoTwo);           // returns the users leverage
bool Bybit_Positions(string sym, int quoteDigit); // returns the users open positions
bool Bybit_ClosePosition(string sym, string ordertype);
bool Bybit_Set_Leverage(string sym, double leverage);

#import

#import "Bitmex_api.ex5"
bool Bitmex_GetOpenOrders(string sym, int quote_precision);
bool Bitmex_Positions(string sym, int quote_precision);
bool Bitmex_Cancel_Trade(string sym, string orderId);
bool Bitmex_Cancel_Trade_All(string sym);
bool Bitmex_Open_Trade(string sym, string side, string orderType, string orderSize, string orderPrice, int quoteDigit, int lotDigit);
bool Bitmex_Balance(string sym, string quotebase);
bool Bitmex_GetPriceBest(string sym);
bool Bitmex_GetPrice(string sym);
bool Bitmex_GetServerTime();
bool Bitmex_Get_API_Key(string key, string secret);
bool Bitmex_GetAnnouncement();
bool Bitmex_GetChat(int id);
bool Bitmex_ClosePosition(string sym, string ordertype);
bool Bitmex_Set_Leverage(string sym, double leverage);
#import

#import "Kucoin_api.ex5"
bool Kucoin_Cancel_Trade(string sym, int orderId);
bool Kucoin_Open_Trade(string sym, string side, string orderType, string orderSize, string orderPrice, int quoteDigit, int lotDigit);
bool Kucoin_Balance(string sym, string quotebase);
bool Kucoin_GetPriceBest(string sym);
bool Kucoin_GetPrice(string sym);
bool Kucoin_GetServerTime();
bool Kucoin_Get_API_Key(string key, string secret, string passphase);
#import

#import "Deribit_api.ex5"
bool Deribit_Cancel_Trade(string sym, string orderId);
bool Deribit_Open_Trade(string sym, string side, string orderType, string orderSize, string orderPrice, int quoteDigit, int lotDigit);
bool Deribit_Balance(string sym, string quotebase);
bool Deribit_GetOpenOrders(string sym);
bool Deribit_GetPriceBest(string sym, int quoteDigit);
bool Deribit_GetPrice(string sym);
bool Deribit_GetServerTime();
bool Deribit_Get_API_Key(string key, string secret);
bool Deribit_Leverage(int liveOne_demoTwo);           // returns the users leverage
bool Deribit_Positions(string sym, int quoteDigit); // returns the users open positions
bool Deribit_ClosePosition(string sym, string ordertype);
bool Deribit_Set_Leverage(string sym, double leverage);
bool Deribit_Cancel_Trade_All(string sym);
#import

#import "Okex_api.ex5"
bool Okex_Modify_Trade(string sym, string orderId, double price);
bool Okex_Cancel_Trade(string sym, string orderId);
bool Okex_Cancel_Trade_All(string sym);
bool Okex_Open_Trade(string sym, string side, string orderType, string orderSize, string orderPrice, int quoteDigit, int lotDigit);
bool Okex_Open_Trade_Stop(string sym, string side, string orderType, string orderSize, string stopPrice, int quoteDigit, int lotDigit);
bool Okex_Balance(string sym, string quotebase);
bool Okex_GetOpenOrders(string sym, int quote_precision);
bool Okex_GetPriceBest(string sym, int quoteDigit);
bool Okex_GetPrice(string sym, int quoteDigit);
bool Okex_GetServerTime();
bool Okex_Get_API_Key(string key, string secret, string livedemo, string market_type);
bool Okex_Leverage(int liveOne_demoTwo);           // returns the users leverage
bool Okex_Positions(string sym, int quoteDigit); // returns the users open positions
bool Okex_ClosePosition(string sym, string ordertype);
bool Okex_Set_Leverage(string sym, double leverage);

#import


input group "---------------CRYPTO BRIDGE API SETUP---------------"
input string Binance_Api_Key = "";
input string Binance_Api_Secret = "";

input string Binance_US_Api_Key = "";
input string Binance_US_Api_Secret = "";

input string BinanceFutures_Api_Key = "";
input string BinanceFutures_Api_Secret = "";
input string BinanceFutures_LiveDemo = "live";

input string Bitmex_Api_Key = "";
input string Bitmex_Api_Secret = "";

input string Bybit_Api_Key = "";
input string Bybit_Api_Secret = "";
input string Bybit_LiveDemo = "live";

input string Deribit_Api_Key = "";
input string Deribit_Api_Secret = "";

input string Kucoin_Api_Key = "";
input string Kucoin_Api_Secret = "";
input string Kucoin_Passphase = "";

input string Okex_Api_Key = "";
input string Okex_Api_Secret = "";
input string Okex_LiveDemo = "live";
input string Okex_text_0 = "Market Type: margin, spot, futures, swap, option";
input string Okex_Market_Type = "swap";

input group "---------------CRYPTO BRIDGE VISUAL SETUP---------------"


input string Partial_TakeProfit_1 = "TP/SL Line style only works with lineThickness == 1";
input ENUM_LINE_STYLE TP_SL_lineStyle = STYLE_SOLID;
input int TP_SL_lineThickness = 2;
input color Takeprofit_Color = clrLightGreen;
input color Stoploss_Color = clrLightPink;

input string Entry_0 = "Entry Line style only works with lineThickness == 1";
input ENUM_LINE_STYLE EntrylineStyle = STYLE_DASH;
input int EntrylineThickness = 1;
input color Entry_Color = clrLightGray;

input string Order_0 = "Order Line style only works with lineThickness == 1";
input ENUM_LINE_STYLE OrderlineStyle = STYLE_SOLID;
input int OrderlineThickness = 1;
input color Order_Color_Buy = clrBlueViolet;
input color Order_Color_Sell = clrRosyBrown;
/*
 Create an ENUM to have a droplist of the available exchanges within your robot's expert properties
*/
enum ENUM_AVAILABLE_EXCHANGE
{
  BINANCE_DEX = 0,
  BINANCE = 1,
  BYBIT = 2,
  BITMEX = 3,
  KUCOIN = 4,
  BINANCE_FUTURES = 5,
  BINANCE_US = 6,
  DERIBIT = 7,
  OKEX = 8

};


input string EXCHANGE_1 = "-----ADJUSTMENTS BELOW ARE FOR CUSTOM ROBOTS------";
input ENUM_AVAILABLE_EXCHANGE Exchange_Number;
input string Exchange_Symbol_Name = "BTCUSDT";
input double Exchange_Lotsize = 1.0;
input int Exchange_Lot_Precision = 8;
input int Exchange_Quote_Precision = 8;
input double Exchange_Leverage = 35;

input int Exchange_Millisecond_RateLimiter = 1000;

input group "---------------CRYPTO BRIDGE END SETUP---------------"

class CryptoBridge
{
protected:
  string my_name;

public:
  bool Init_Api_Keys(int exchange);
  bool Get_OpenInterest(string sym, int exchangeNumber, int quote_precision);
  bool Get_FundRate(string sym, int exchangeNumber, int quote_precision);
  bool Get_Balance(string sym, string quote_base, int exchangeNumber);
  bool Get_PriceBest(string sym, int exchangeNumber, int quote_precision);
  bool Get_Price(string sym, int exchangeNumber, int quote_precision);
  bool Get_Position(string sym, int exchangeNumber, int quote_precision);
  bool Get_OpenOrders(string sym, int exchangeNumber, int quote_precision);
  string Get_Exchange_Name(int exchangeNumber);
  bool Get_Exchange_Server_Time(int exchangeNumber);
  bool Open_Trade(string sym, string side, string orderType, string orderSize, string orderPrice, int quoteDigit, int lotDigit, int exchangeNumber);
  bool Open_Trade_Stop(string sym, string side, string orderType, string orderSize, string stopPrice, int quoteDigit, int lotDigit, int exchangeNumber);
  bool Open_Trade_StopLimit(string sym, string side, string orderType, string orderSize, string orderPrice, string stopPrice, int quoteDigit, int lotDigit, int exchangeNumber);
  bool Modify_Trade(string sym, string id, string orderPrice ,int orderNumber, string orderSide, string orderSize, int quoteDigit, int lotDigit,int exchangeNumber);
  bool Cancel_Trade(string sym, string orderId, int exchangeNumber, int order_number);
  bool Cancel_Trade_All(string sym, int exchangeNumber);
  bool Hedge_Mode(bool on_true_off_false, int exchangeNumber);
  void Parse_Orders(string exchangeName, int order_location, int id_location);
  void Parse_Positions(string exchangeName, int pos_location, int liq_location, int quoteDigit);
  void Parse_Wallets(string exchangeName);
  double Get_Wallet_Info(int robotInstance, string exchangeName, string walletInfoSymbol);
  bool Margin_Close_Position(string sym, string side, string orderType, string orderSize, string orderPrice, int quoteDigit, int lotDigit, int exchangeNumber);
  bool Margin_Set_Leverage(string sym, double leverage, int exchangeNumber);
};
//+------------------------------------------------------------------+
//|               Run this function any time you switch exchanges.   |
//+------------------------------------------------------------------+
bool CryptoBridge::Init_Api_Keys(int exchange)
{

  GlobalVariableSet("Exchange", exchange);

  if (exchange == 0)
  {

    return (Binance_Dex_Get_API_Key(Binance_Api_Key, Binance_Api_Secret));
  }
  if (exchange == 1)
  {

    return (Binance_Get_API_Key(Binance_Api_Key, Binance_Api_Secret));
  }
  if (exchange == 2)
  {

    return (Bybit_Get_API_Key(Bybit_Api_Key, Bybit_Api_Secret, Bybit_LiveDemo));
  }
  if (exchange == 3)
  {

    return (Bitmex_Get_API_Key(Bitmex_Api_Key, Bitmex_Api_Secret));
  }
  if (exchange == 4)
  {

    return (Kucoin_Get_API_Key(Kucoin_Api_Key, Kucoin_Api_Secret, Kucoin_Passphase));
  }
  if (exchange == 5)
  {

    return (BinanceFutures_Get_API_Key(BinanceFutures_Api_Key, BinanceFutures_Api_Secret, BinanceFutures_LiveDemo));
  }
  if (exchange == 6)
  {

    return (Binance_US_Get_API_Key(Binance_US_Api_Key, Binance_US_Api_Secret));
  }
  if (exchange == 7)
  {

    return (Deribit_Get_API_Key(Deribit_Api_Key, Deribit_Api_Secret));
  }
  if (exchange == 8)
  {

    return (Okex_Get_API_Key(Okex_Api_Key, Okex_Api_Secret, Okex_LiveDemo, Okex_Market_Type));
  }
  return (false);
}

//+------------------------------------------------------------------+
//|   return the exchange name                                       |
//+------------------------------------------------------------------+
string CryptoBridge::Get_Exchange_Name(int exchange_number)
{

  if (exchange_number == 0)
  {
    return ("BinanceDex");
  }
  if (exchange_number == 1)
  {
    return ("Binance");
  }
  if (exchange_number == 2)
  {
    return ("Bybit");
  }
  if (exchange_number == 3)
  {
    return ("Bitmex");
  }
  if (exchange_number == 4)
  {
    return ("Kucoin");
  }
  if (exchange_number == 5)
  {
    return ("BinanceFutures");
  }
  if (exchange_number == 6)
  {
    return ("BinanceUS");
  }
  if (exchange_number == 7)
  {
    return ("Deribit");
  }
  if (exchange_number == 8)
  {
    return ("Okex");
  }
  return ("");
}

bool CryptoBridge::Hedge_Mode(bool on_true_off_false, int exchangeNumber)
{

  if (exchangeNumber == 5)
  {
    if (on_true_off_false)
    {
      return (BinanceFutures_HedgeMode("true"));
    }
    else
    {
      return (BinanceFutures_HedgeMode("false"));
    }
  }

  return (false);
}

//+------------------------------------------------------------------+
//|     modify order by id                                           |
//+------------------------------------------------------------------+
bool CryptoBridge::Modify_Trade(string sym, string id, string orderPrice, int orderNumber, string orderSide, string orderSize, int quoteDigit, int lotDigit,int exchangeNumber)
{

  if (exchangeNumber == 1)
  {
    // return (Binance_Open_Trade(sym, side, orderType, orderSize, orderPrice));
  }
  if (exchangeNumber == 2)
  {
    return (Bybit_Modify_Trade(sym, id, orderPrice,quoteDigit,lotDigit));
  }

  if (exchangeNumber == 3)
  {
    // return (Bitmex_Open_Trade(sym, side, orderType, orderSize, orderPrice));
  }

  if (exchangeNumber == 4)
  {
    // return (Kucoin_Open_Trade(sym, side, orderType, orderSize, orderPrice));
  }

  if (exchangeNumber == 5)
  {
      /*
      Cancelt the order 
      */
      CryptoBridge::Cancel_Trade(sym,id,exchangeNumber,orderNumber);
      /*
      Place a new order 
      */
     return (BinanceFutures_Open_Trade(sym, orderSide, "LIMIT", orderSize, orderPrice,quoteDigit,lotDigit));
  }
  if (exchangeNumber == 6)
  {
    //  return (Binance_US_Open_Trade(sym, side, orderType, orderSize, orderPrice));
  }
  if (exchangeNumber == 7)
  {
    //  return (Deribit_Open_Trade(sym, side, orderType, orderSize, orderPrice));
  }
  return (false);
}
//+------------------------------------------------------------------+
//|     market or limit order                                        |
//+------------------------------------------------------------------+
bool CryptoBridge::Open_Trade(string sym, string side, string orderType, string orderSize, string orderPrice, int quoteDigit, int lotDigit, int exchangeNumber)
{

  if (exchangeNumber == 1)
  {
    return (Binance_Open_Trade(sym, side, orderType, orderSize, orderPrice,quoteDigit,lotDigit));
  }
  if (exchangeNumber == 2)
  {
    return (Bybit_Open_Trade(sym, side, orderType, orderSize, orderPrice,quoteDigit,lotDigit));
  }

  if (exchangeNumber == 3)
  {
    return (Bitmex_Open_Trade(sym, side, orderType, orderSize, orderPrice,quoteDigit,lotDigit));
  }

  if (exchangeNumber == 4)
  {
    return (Kucoin_Open_Trade(sym, side, orderType, orderSize, orderPrice,quoteDigit,lotDigit));
  }

  if (exchangeNumber == 5)
  {
    return (BinanceFutures_Open_Trade(sym, side, orderType, orderSize, orderPrice,quoteDigit,lotDigit));
  }
  if (exchangeNumber == 6)
  {
    return (Binance_US_Open_Trade(sym, side, orderType, orderSize, orderPrice,quoteDigit,lotDigit));
  }
  if (exchangeNumber == 7)
  {
    return (Deribit_Open_Trade(sym, side, orderType, orderSize, orderPrice,quoteDigit,lotDigit));
  }
  return (false);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CryptoBridge::Open_Trade_Stop(string sym, string side, string orderType, string orderSize, string stopPrice, int quoteDigit, int lotDigit, int exchangeNumber)
{

  if (exchangeNumber == 1)
  {
    return (Binance_Open_Trade_Stop(sym, side, orderType, orderSize,stopPrice,quoteDigit,lotDigit));
  }
  if (exchangeNumber == 2)
  {
    return (Bybit_Open_Trade_Stop(sym, side, orderType, orderSize, stopPrice,quoteDigit,lotDigit));
  }
  if (exchangeNumber == 5)
  {
    return (BinanceFutures_Open_Trade_Stop(sym, side, orderType, orderSize, stopPrice,quoteDigit,lotDigit));
  }
  if (exchangeNumber == 6)
  {
    return (Binance_US_Open_Trade_Stop(sym, side, orderType, orderSize,stopPrice,quoteDigit,lotDigit));
  }

  return (false);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CryptoBridge::Open_Trade_StopLimit(string sym, string side, string orderType, string orderSize, string orderPrice, string stopPrice, int quoteDigit, int lotDigit, int exchangeNumber)
{

  if (exchangeNumber == 1)
  {
    return (Binance_Open_Trade_StopLimit(sym, side, orderType, orderSize, orderPrice, stopPrice,quoteDigit,lotDigit));
  }
  if (exchangeNumber == 5)
  {
    return (BinanceFutures_Open_Trade_StopLimit(sym, side, orderType, orderSize, orderPrice, stopPrice,quoteDigit,lotDigit));
  }
  if (exchangeNumber == 6)
  {
    return (Binance_US_Open_Trade_StopLimit(sym, side, orderType, orderSize, orderPrice, stopPrice,quoteDigit,lotDigit));
  }
  return (false);
}
//+------------------------------------------------------------------+
//|       cancel specific order based on order ID                    |
//+------------------------------------------------------------------+
bool CryptoBridge::Cancel_Trade(string sym, string orderId, int exchangeNumber, int order_number)
{

  string name = CryptoBridge::Get_Exchange_Name(exchangeNumber);
  
  DeleteGlobalOrderName(name, sym, order_number + 1); // Globals start at a value of 1
  DeleteSubWindowObjectName(0, "order_id" + IntegerToString(order_number));
  DeleteSubWindowObjectName(0, "orderid" + IntegerToString(order_number));
  DeleteSubWindowObjectName(0, "sub_order_" + IntegerToString(order_number));
  DeleteOjectLinesByDesc(orderId);

  if (exchangeNumber == 1)
  {
    return (Binance_Cancel_Trade(sym, StringToInteger(orderId)));
  }

  if (exchangeNumber == 2)
  {
    return (Bybit_Cancel_Trade(sym, orderId));
  }

  if (exchangeNumber == 3)
  {

    return (Bitmex_Cancel_Trade(sym, orderId));
  }

  if (exchangeNumber == 5)
  {
    return (BinanceFutures_Cancel_Trade(sym, StringToInteger(orderId)));
  }

  if (exchangeNumber == 6)
  {
    return (Binance_US_Cancel_Trade(sym, StringToInteger(orderId)));
  }
  if (exchangeNumber == 7)
  {
    return (Deribit_Cancel_Trade(sym, orderId));
  }

  return (false);
}
//+------------------------------------------------------------------+
//|       cancel all orders                                          |
//+------------------------------------------------------------------+
bool CryptoBridge::Cancel_Trade_All(string sym, int exchangeNumber)
{

  string prefix = CryptoBridge::Get_Exchange_Name(exchangeNumber);
  
  DeleteGlobalPrefix(prefix + "_Order_" + sym); //- this is the global assigned to the orders
  DeleteSubWindowObjectAll(0, "sub_order_");   //  - this is the order string
  DeleteSubWindowObjectAll(0, "order_id");     //    - this is the order id string
  DeleteSubWindowObjectAll(0, "orderid");      //     - this is the order edit button "X" to cancel individual orders
  DeleteOjectLines(sym);                                        // - deletes the lines on the chart

  if (exchangeNumber == 1)
  {
    return (Binance_Cancel_Trade_All(sym));
  }

  if (exchangeNumber == 2)
  {
    return (Bybit_Cancel_Trade_All(sym));
  }

  if (exchangeNumber == 3)
  {
    return (Bitmex_Cancel_Trade_All(sym));
  }

  if (exchangeNumber == 5)
  {
    return (BinanceFutures_Cancel_Trade_ALL(sym));
  }

  if (exchangeNumber == 6)
  {
    return (Binance_US_Cancel_Trade_All(sym));
  }

  return (false);
}
//+------------------------------------------------------------------+
//|  fetch server time                                               |
//+------------------------------------------------------------------+
bool CryptoBridge::Get_Exchange_Server_Time(int exchangeNumber)
{

  //Binance_Dex_BlockTime()
  if (exchangeNumber == 0)
  {
    return (Binance_Dex_BlockTime());
  }

  if (exchangeNumber == 1)
  {
    return (Binance_GetServerTime());
  }

  if (exchangeNumber == 2)
  {
    return (Bybit_GetServerTime());
  }

  if (exchangeNumber == 3)
  {
    return (Bitmex_GetServerTime());
  }

  if (exchangeNumber == 4)
  {
    return (Kucoin_GetServerTime());
  }

  if (exchangeNumber == 5)
  {
    return (BinanceFutures_GetServerTime());
  }

  if (exchangeNumber == 6)
  {
    return (Binance_US_GetServerTime());
  }
  if (exchangeNumber == 7)
  {
    return (Deribit_GetServerTime());
  }
  if (exchangeNumber == 8)
  {
    return (Okex_GetServerTime());
  }
  return (false);
}
//+------------------------------------------------------------------+
//|  Returns the top of the orderbook values: best bid and ask       |
//+------------------------------------------------------------------+
bool CryptoBridge::Get_PriceBest(string sym, int exchangeNumber, int quote_precision)
{
  if (exchangeNumber == 0)
  {
    return (Binance_Dex_GetPriceBest(sym));
  }
  if (exchangeNumber == 1)
  {
    return (Binance_GetPriceBest(sym, quote_precision));
  }
  if (exchangeNumber == 2)
  {
    return (Bybit_GetPriceBest(sym, quote_precision));
  }
  if (exchangeNumber == 3)
  {
    return (Bitmex_GetPriceBest(sym));
  }

  if (exchangeNumber == 4)
  {
    return (Kucoin_GetPriceBest(sym));
  }

  if (exchangeNumber == 5)
  {
    return (BinanceFutures_GetPriceBest(sym, quote_precision));
  }
  if (exchangeNumber == 6)
  {
    return (Binance_US_GetPriceBest(sym, quote_precision));
  }
  if (exchangeNumber == 7)
  {
    return (Deribit_GetPriceBest(sym, quote_precision));
  }
  if (exchangeNumber == 8)
  {
    return (Okex_GetPriceBest(sym, quote_precision));
  }
  return (false);
}
//+------------------------------------------------------------------+
//|   fetch   the last traded price                                  |
//+------------------------------------------------------------------+
bool CryptoBridge::Get_Price(string sym, int exchangeNumber, int quote_precision)
{

  if (exchangeNumber == 0)
  {
    return (Binance_Dex_GetPrice(sym));
  }

  if (exchangeNumber == 1)
  {
    return (Binance_GetPrice(sym));
  }
  if (exchangeNumber == 2)
  {
    return (Bybit_GetPrice(sym, quote_precision));
  }
  if (exchangeNumber == 3)
  {
    return (Bitmex_GetPrice(sym));
  }
  if (exchangeNumber == 4)
  {
    return (Kucoin_GetPrice(sym));
  }

  if (exchangeNumber == 5)
  {
    return (BinanceFutures_GetPrice(sym, quote_precision));
  }
  if (exchangeNumber == 6)
  {
    return (Binance_US_GetPrice(sym));
  }
  if (exchangeNumber == 7)
  {
    return (Deribit_GetPrice(sym));
  }
  if (exchangeNumber == 8)
  {
    return (Okex_GetPrice(sym, quote_precision));
  }
  return (false);
}
//+------------------------------------------------------------------+
//|   fetch OpenInterest                                             |
//+------------------------------------------------------------------+
bool CryptoBridge::Get_OpenInterest(string sym, int exchangeNumber, int quote_precision)
{

  if (exchangeNumber == 0)
  {
    // return (Binance_Dex_GetPrice(sym));
  }

  if (exchangeNumber == 1)
  {
    //  return (Binance_GetPrice(sym));
  }
  if (exchangeNumber == 2)
  {
    return (Bybit_GetOpenInterest(sym, quote_precision));
  }
  if (exchangeNumber == 3)
  {
    //  return (Bitmex_GetPrice(sym));
  }
  if (exchangeNumber == 4)
  {
    //  return (Kucoin_GetPrice(sym));
  }

  if (exchangeNumber == 5)
  {
    return (BinanceFutures_GetOpenInterest(sym, quote_precision));
  }
  if (exchangeNumber == 6)
  {
    //  return (Binance_US_GetPrice(sym));
  }
  if (exchangeNumber == 7)
  {
    //  return (Deribit_GetPrice(sym));
  }
  if (exchangeNumber == 8)
  {
    // return (Okex_GetPrice(sym,quote_precision));
  }
  return (false);
}
//+------------------------------------------------------------------+
//|   fetch FundRate                                                 |
//+------------------------------------------------------------------+
bool CryptoBridge::Get_FundRate(string sym, int exchangeNumber, int quote_precision)
{

  if (exchangeNumber == 0)
  {
    //  return (Binance_Dex_GetPrice(sym));
  }

  if (exchangeNumber == 1)
  {
    //  return (Binance_GetPrice(sym));
  }
  if (exchangeNumber == 2)
  {
    return (Bybit_GetFundRate(sym, quote_precision));
  }
  if (exchangeNumber == 3)
  {
    //  return (Bitmex_GetPrice(sym));
  }
  if (exchangeNumber == 4)
  {
    //  return (Kucoin_GetPrice(sym));
  }

  if (exchangeNumber == 5)
  {
    return (BinanceFutures_GetFundRate(sym, quote_precision));
  }
  if (exchangeNumber == 6)
  {
    //return (Binance_US_GetPrice(sym));
  }
  if (exchangeNumber == 7)
  {
    //  return (Deribit_GetPrice(sym));
  }
  if (exchangeNumber == 8)
  {
    //  return (Okex_GetPrice(sym,quote_precision));
  }
  return (false);
}
//+------------------------------------------------------------------+
//|   fetch the open positions                                       |
//+------------------------------------------------------------------+
bool CryptoBridge::Get_Position(string sym, int exchangeNumber, int quote_precision)
{
  //deletes the existing positions in memory
  string prefix = CryptoBridge::Get_Exchange_Name(exchangeNumber);
  
  DeleteGlobalPrefix(prefix + "_POS_");     // - this is the position global variable
  DeleteGlobalPrefix(prefix + "_LIQ_");     // - this is the pos  liq global variable
  DeleteSubWindowObjectAll(0, "sub_pos_"); // - this is the position string
  DeleteSubWindowObjectAll(0, "sub_liq_"); // - this is the liquidation string
   /*
  delete the TP and SL lines on the chart if exists
  */
  DeleteOjectLinesByName("TP1b");
  DeleteOjectLinesByName("TP2b");
  DeleteOjectLinesByName("TP3b");
  DeleteOjectLinesByName("TP4b");
  DeleteOjectLinesByName("SL1b");
  DeleteOjectLinesByName("SL2b");
  DeleteOjectLinesByName("SL3b");
  DeleteOjectLinesByName("SL4b");
  
  DeleteOjectLinesByName("TP1s");
  DeleteOjectLinesByName("TP2s");
  DeleteOjectLinesByName("TP3s");
  DeleteOjectLinesByName("TP4s");
  DeleteOjectLinesByName("SL1s");
  DeleteOjectLinesByName("SL2s");
  DeleteOjectLinesByName("SL3s");
  DeleteOjectLinesByName("SL4s");

  if (exchangeNumber == 2)
  { 
    if(sym==""){
    Bybit_Positions("BTCUSD", quote_precision);
    Bybit_Positions("EOSUSD", quote_precision);
    Bybit_Positions("XRPUSD", quote_precision);
    Bybit_Positions("ETHUSD", quote_precision);
     return(true);
    }else{
      return (Bybit_Positions(sym, quote_precision));
    }
    
  }

  if (exchangeNumber == 3)
  {
    return (Bitmex_Positions(sym, quote_precision));
  }

  if (exchangeNumber == 5)
  {
    return (BinanceFutures_Positions(sym, quote_precision));
  }

  if (exchangeNumber == 7)
  {
    return (Deribit_Positions(sym, quote_precision));
  }
  return (false);
}
//+------------------------------------------------------------------+
//| sets orders information within subwindow                         |
//+------------------------------------------------------------------+
bool CryptoBridge::Get_OpenOrders(string sym, int exchangeNumber, int quote_precision)
{
  //deletes the existing orders in memory
  string prefix = CryptoBridge::Get_Exchange_Name(exchangeNumber);
  
  DeleteGlobalPrefix(prefix + "_Order_" + sym + "_MARKET");
  DeleteGlobalPrefix(prefix + "_Order_" + sym + "_LIMIT");
  DeleteGlobalPrefix(prefix + "_Order_" + sym + "_STOPMARKET");
  DeleteGlobalPrefix(prefix + "_Order_" + sym + "_STOP_MARKET");
  DeleteGlobalPrefix(prefix + "_Order_" + sym + "_STOPLIMIT");
  DeleteGlobalPrefix(prefix + "_Order_" + sym + "_STOP_LIMIT");

  DeleteSubWindowObjectAll(0, "sub_order_"); // - this is the order string
  DeleteSubWindowObjectAll(0, "order_id");   //   - this is the order id string
  DeleteSubWindowObjectAll(0, "orderid");    //    - this is the order edit button "X" to cancel individual orders

  DeleteOjectLines(sym);

  if (exchangeNumber == 1)
  {
    return (Binance_GetOpenOrders(sym, quote_precision));
  }

  if (exchangeNumber == 2)
  {
    return (Bybit_GetOpenOrders(sym, quote_precision));
  }
  if (exchangeNumber == 3)
  {
    return (Bitmex_GetOpenOrders(sym, quote_precision));
  }

  if (exchangeNumber == 5)
  {
    return (BinanceFutures_GetOpenOrders(sym, quote_precision));
  }

  if (exchangeNumber == 6)
  {
    return (Binance_US_GetOpenOrders(sym, quote_precision));
  }
  if (exchangeNumber == 7)
  {
    return (Deribit_GetOpenOrders(sym));
  }

  return (false);
}

//+------------------------------------------------------------------+
//| return true if pos closed on                                     |
//+------------------------------------------------------------------+
bool CryptoBridge::Margin_Close_Position(string sym, string side, string orderType, string orderSize, string orderPrice, int quoteDigit, int lotDigit, int exchangeNumber)
{

  if (exchangeNumber == 2)
  {
    return (Bybit_ClosePosition(sym, orderType));
  }
  if (exchangeNumber == 3)
  {
    return (Bitmex_ClosePosition(sym, orderType));
  }

  if (exchangeNumber == 5)
  {
    return (BinanceFutures_Close_Trade(sym, side, orderType, orderSize, orderPrice,quoteDigit, lotDigit));
  }
  return (false);
}
//+------------------------------------------------------------------+
//| return the new leverage value                                    |
//+------------------------------------------------------------------+
bool CryptoBridge::Margin_Set_Leverage(string sym, double leverage, int exchangeNumber)
{
  if (exchangeNumber == 2)
  {
    return (Bybit_Set_Leverage(sym, leverage));
  }
  if (exchangeNumber == 3)
  {
    return (Bitmex_Set_Leverage(sym, leverage));
  }

  if (exchangeNumber == 5)
  {
    return (BinanceFutures_Set_Leverage(sym, leverage));
  }

  return (false);
}

//+------------------------------------------------------------------+
//| return all wallet balances                                       |
//+------------------------------------------------------------------+
bool CryptoBridge::Get_Balance(string sym, string quote_base, int exchangeNumber)
{
  string prefix = CryptoBridge::Get_Exchange_Name(exchangeNumber);
  DeleteGlobalPrefix(prefix + "_Wallet_");

  if (exchangeNumber == 1)
  {
    return (Binance_Balance(sym, quote_base));
  }
  if (exchangeNumber == 2)
  {
    return (Bybit_Balance(sym, quote_base));
  }
  if (exchangeNumber == 3)
  {
    return (Bitmex_Balance(sym, quote_base));
  }
  if (exchangeNumber == 4)
  {
    return (Kucoin_Balance(sym, quote_base));
  }
  if (exchangeNumber == 5)
  {
    return (BinanceFutures_Balance(sym, quote_base));
  }

  if (exchangeNumber == 6)
  {
    return (Binance_US_Balance(sym, quote_base));
  }
  if (exchangeNumber == 7)
  {
    return (Deribit_Balance(sym, quote_base));
  }

  return (false);
}

//+------------------------------------------------------------------+
//| Binance_Order_GVTETH_LIMIT_SELL_0.00750000_8.00000000            |
//+------------------------------------------------------------------+
string exchange_name[];
string exchange_symbol[];
string exchange_ordertype[];
string exchange_orderside[];
double exchange_orderprice[];
double exchange_ordersize[];
void CryptoBridge::Parse_Orders(string exchangeName, int order_location, int id_location)
{
  // Empty previous data
  ArrayFree(exchange_name);
  ArrayFree(exchange_symbol);
  ArrayFree(exchange_ordertype);
  ArrayFree(exchange_orderside);
  ArrayFree(exchange_orderprice);
  ArrayFree(exchange_ordersize);

  SetSubWindowText("sub_orders_text_", "Orders", order_location, 0, Gray, 10);

  string myarray[];
  int total = GlobalVariablesTotal();
  string name = "";
  string order_info = "";
  int counterC = 0;
  int counterD = 0;
  string orderstring = "";
  datetime bar_close = iTime(NULL, PERIOD_CURRENT, 0);

  for (int i = 0; i < total; i++)
  {
    name = GlobalVariableName(i);
    int dash0 = StringFind(name, "_", 0);

    string exchange = StringSubstr(name, 0, dash0);

    //  exchange_name[i] = exchange;

    if (exchange == exchangeName && dash0 != -1)
    {
      int dash1 = StringFind(name, "_", dash0 + 1);   // SCAN AFTER THE PREVIOUS DASH
      string wal = StringSubstr(name, dash0 + 1, -1); //
      int dash2 = StringFind(wal, "_", 0);            // SCAN AFTER THE PREVIOUS DASH

      string named_order = StringSubstr(wal, 0, 5); // Binance_Order_

      if ("Order" == named_order && dash2 != -1)
      {
        ArrayResize(myarray, counterC + 1, 0); // COUNTER STARTS AT ZERO SO WE ADD ONE
                                               // ArrayResize(myarray_id,counterC+1,0);// COUNTER STARTS AT ZERO SO WE ADD ONE

        order_info = StringSubstr(name, dash1 + 1, -1); // DONT INCLUDE THE DASH2

        //GVTETH_LIMIT_SELL_0.00750000_8.00000000
        int dash3 = StringFind(order_info, "_", 0);
        string symbol = StringSubstr(order_info, 0, dash3);
        //  Print("Dash3 (symbol) : " + symbol);

        int dash4 = StringFind(order_info, "_", dash3 + 1);
        string ordertype = StringSubstr(order_info, dash3 + 1, (dash4 - dash3) - 1);
        //  Print("Dash4 (ordertype) : " + ordertype + " dash3 (length) " + dash3 + " dash4 (length) " + dash4 );

        int dash5 = StringFind(order_info, "_", dash4 + 1);
        string orderside = StringSubstr(order_info, dash4 + 1, (dash5 - dash4) - 1);
        //   Print("Dash5 (orderside) : " + orderside + " dash4 (length) " + dash4 + " dash5 (length) " + dash5 );

        int dash6 = StringFind(order_info, "_", dash5 + 1);
        string orderprice = StringSubstr(order_info, dash5 + 1, (dash6 - dash5) - 1);
        // Print("Dash6 (orderprice) : " + orderprice + " dash5 (length) " + dash5 + " dash6 (length) " + dash6 );

        int dash7 = StringFind(order_info, "_", dash6 + 1);
        string ordersize = StringSubstr(order_info, dash6 + 1, (dash7 - dash6) - 1);
        //  Print("Dash7 (ordersize) : " + ordersize + " dash6 (length) " + dash6 + " dash7 (length) " + dash7 );

        // COUNTER STARTS AT ZERO SO WE ADD ONE
        ArrayResize(exchange_name, counterD + 1, 0);
        ArrayResize(exchange_symbol, counterD + 1, 0);
        ArrayResize(exchange_ordertype, counterD + 1, 0);
        ArrayResize(exchange_orderside, counterD + 1, 0);
        ArrayResize(exchange_orderprice, counterD + 1, 0);
        ArrayResize(exchange_ordersize, counterD + 1, 0);

        // COUNTER STARTS AT ZERO for array[0] =
        exchange_name[counterD] = exchange;
        exchange_symbol[counterD] = symbol;
        exchange_ordertype[counterD] = ordertype;
        exchange_orderside[counterD] = orderside;
        exchange_orderprice[counterD] = StringToDouble(orderprice);
        exchange_ordersize[counterD] = StringToDouble(ordersize);
        myarray[counterC] = order_info;

        counterC++; // COUNTER ADDS ONE
        counterD++;

        /*
         Create order object on the chart 
        */
      }
    }
  }

  if (counterC > 0)
  {

    for (int i = counterC - 1; i > -1; i--)
    {

      if (exchange_orderside[i] == "BUY")
      {
        CreateOrderEntryLine(exchange_symbol[i] + "_BUY_"  +exchange_ordersize[i] + "_" + IntegerToString(i), GetObjectDesc(i), bar_close - 6000, exchange_orderprice[i], bar_close, exchange_orderprice[i], Order_Color_Buy, OrderlineThickness, OrderlineStyle);
      }
      if (exchange_orderside[i] == "SELL")
      {
        CreateOrderEntryLine(exchange_symbol[i] + "_SELL_" +exchange_ordersize[i] + "_" + IntegerToString(i), GetObjectDesc(i), bar_close - 6000, exchange_orderprice[i], bar_close, exchange_orderprice[i], Order_Color_Sell, OrderlineThickness, OrderlineStyle);
      }
    }
  }
}

//+------------------------------------------------------------------+
//| Binance_Pos_GVTETH_MARKET_SELL_0.00750000_8.00000000            |
//+------------------------------------------------------------------+
string exchange_name_p[];
string exchange_symbol_p[];
string exchange_orderside_p[];
double exchange_orderprice_p[];
double exchange_ordersize_p[];
double exchange_orderliquidation_p[];
void CryptoBridge::Parse_Positions(string exchangeName, int pos_location, int liq_location, int quoteDigit)
{

  // Empty previous data
  ArrayFree(exchange_name_p);
  ArrayFree(exchange_symbol_p);
  ArrayFree(exchange_orderside_p);
  ArrayFree(exchange_orderprice_p);
  ArrayFree(exchange_ordersize_p);
  ArrayFree(exchange_orderliquidation_p);

  // Positions Lable on the chart
  SetSubWindowText("sub_position_text_", "Positions", pos_location, 0, Gray, 10);
  SetSubWindowText("sub_liq_text_", "LIQ", 210, 0, Gray, 10);

  string myarray[];
  int total = GlobalVariablesTotal();
  string name = "";
  string position_info = "";

  int counterB = 0; // COUNTER STARTS AT ZERO
  int counterD = 0; // COUNTER STARTS AT ZERO

  for (int i = 0; i < total; i++)
  {
    name = GlobalVariableName(i);
    int dash1 = StringFind(name, "_", 0);

    string exchange = StringSubstr(name, 0, dash1);
    if (exchange == exchangeName && dash1 != -1)
    {

      int dash2 = StringFind(name, "_", dash1 + 1);
      string wal = StringSubstr(name, dash1 + 1, -1);

      int dash3 = StringFind(wal, "_", 0);

      string wall = StringSubstr(wal, 0, 3); // POS"

      if ("POS" == wall && dash3 != -1)
      {

        ArrayResize(myarray, counterB + 1, 0);             // COUNTER STARTS AT ZERO SO WE ADD ONE
        position_info = StringSubstr(name, dash2 + 1, -1); // DONT INCLUDE THE DASH2

        //GVTETH
        int dash4 = StringFind(position_info, "_", 0);
        string symbol = StringSubstr(position_info, 0, dash4);
        //  Print("Dash4 (symbol) : " + symbol);

        //MARKET
        int dash5 = StringFind(position_info, "_", dash4 + 1);
        string ordertype = StringSubstr(position_info, dash4 + 1, (dash5 - dash4) - 1);
        //  Print("Dash5 (ordertype) : " + ordertype  );//+ " dash4 (length) " + dash4 + " dash5 (length) " + dash5

        //Buy or Sell or None(bybit) or BOTH for binanceFutures
        int dash6 = StringFind(position_info, "_", dash5 + 1);
        string orderside = StringSubstr(position_info, dash5 + 1, (dash6 - dash5) - 1);
          Print("Dash6 (orderside) : " + orderside  );//+ " dash4 (length) " + dash4 + " dash5 (length) " + dash5

        // Price
        int dash7 = StringFind(position_info, "_", dash6 + 1);
        string orderprice = StringSubstr(position_info, dash6 + 1, (dash7 - dash6) - 1);
        //  Print("Dash7 (orderprice) : " + orderprice  );//+ " dash5 (length) " + dash5 + " dash6 (length) " + dash6

        // volume
        int dash8 = StringFind(position_info, "_", dash7 + 1);
        string ordersize = StringSubstr(position_info, dash7 + 1, (dash8 - dash7) - 1);
        //  Print("Dash8 (ordersize) : " + ordersize );// + " dash6 (length) " + dash6 + " dash7 (length) " + dash7

        // COUNTER STARTS AT ZERO SO WE ADD ONE
        ArrayResize(exchange_name_p, counterD + 1, 0);
        ArrayResize(exchange_symbol_p, counterD + 1, 0);

        ArrayResize(exchange_orderside_p, counterD + 1, 0);
        ArrayResize(exchange_orderprice_p, counterD + 1, 0);
        ArrayResize(exchange_ordersize_p, counterD + 1, 0);

        // COUNTER STARTS AT ZERO for array[0] =
        Print("ParsePositions counterD " + counterD);
        exchange_name_p[counterD] = exchange;
        exchange_symbol_p[counterD] = symbol;
        exchange_orderside_p[counterD] = orderside;
        exchange_orderprice_p[counterD] = StringToDouble(orderprice);
        exchange_ordersize_p[counterD] = StringToDouble(ordersize);

        myarray[counterB] = position_info; // COUNTER STARTS AT ZERO for array[0] =
        counterB++;                        // COUNTER ADDS ONE
        counterD++;                        // COUNTER ADDS ONE
      }
    }
  }

  if (counterB > 0)
  {
    ArrayResize(myarray, counterB, 0);
    datetime bar_close = iTime(NULL, PERIOD_CURRENT, 0);
    for (int i = 0; i < counterB; i++)
    {

      if (exchange_ordersize_p[i] != 0)
      {
        SetSubWindowText("sub_pos_" + IntegerToString(i), myarray[i], pos_location, 20 + (25 * i), Gray, 10);
        CreateEntryLine(exchange_symbol_p[i] + "_ENTRY", "desc", bar_close - 6000, exchange_orderprice_p[i], bar_close, exchange_orderprice_p[i], Entry_Color, EntrylineThickness, EntrylineStyle);
      }
    }
  }

  /* 
    - Need to loop over the
    - Bybit_LIQ_ETHUSD global( double price )
  */
  double liquidationarray[];
  int counterE = 0;
  for (int i = 0; i < total; i++)
  {
    name = GlobalVariableName(i);
    int dash1 = StringFind(name, "_", 0);

    string exchange = StringSubstr(name, 0, dash1);
    if (exchange == exchangeName && dash1 != -1)
    {

      int dash2 = StringFind(name, "_", dash1 + 1);
      string wal = StringSubstr(name, dash1 + 1, -1);

      int dash3 = StringFind(wal, "_", 0);

      string wall = StringSubstr(wal, 0, 3); // LIQ"

      if ("LIQ" == wall && dash3 != -1)
      {

        string liq_info = StringSubstr(name, dash2 + 1, -1); // DONT INCLUDE THE DASH2
        int dash4 = StringFind(liq_info, "_", 0);
        string symbol = StringSubstr(liq_info, 0, dash4);
        // Print("LIQ Dash4 (symbol) : " + symbol);
        double liq = GlobalVariableGet(name);

        // COUNTER STARTS AT ZERO SO WE ADD ONE
        ArrayResize(exchange_orderliquidation_p, counterE + 1, 0);
        exchange_orderliquidation_p[counterE] = liq;

        // COUNTER STARTS AT ZERO SO WE ADD ONE
        ArrayResize(liquidationarray, counterE + 1, 0);
        liquidationarray[counterE] = StringToDouble(DoubleToString(liq, quoteDigit));
        counterE++;
      }
    }
  }

  if (counterE > 0)
  {
    ArrayResize(liquidationarray, counterE, 0);
    for (int i = 0; i < counterE; i++)
    {

      if (liquidationarray[i] > 0)
      {
        SetSubWindowText("sub_liq_" + IntegerToString(i), DoubleToString(liquidationarray[i], quoteDigit), liq_location, 20 + (25 * i), Gray, 10);
      }
    }
  }
}
/*
 parse exchange_wallet_SYMBOL
*/
void CryptoBridge::Parse_Wallets(string exchangeName)
{

  string myarray[];
  int total = GlobalVariablesTotal();
  string name = "";
  string wallet = "";

  int countD = 0; // COUNTER STARTS AT ZERO

  for (int i = 0; i < total; i++)
  {
    name = GlobalVariableName(i);
    int dash1 = StringFind(name, "_", 0); // exchange_wallet_SYMBOL

    string exchange = StringSubstr(name, 0, dash1);
    if (exchange == exchangeName && dash1 != -1)
    {
      // Print(" MATCH exchange name " + exchange);

      int dash2 = StringFind(name, "_", dash1 + 1);   // SCAN AFTER THE PREVIOUS DASH
      string wal = StringSubstr(name, dash1 + 1, -1); // FIND THE "Wallet_sym"

      int dash3 = StringFind(wal, "_", 0); // SCAN AFTER THE PREVIOUS DASH
                                           //Wallet_GVT

      string wall = StringSubstr(wal, 0, 6); // Wallet"
                                             //  Print("DEBUG2: " + wall);

      if ("Wallet" == wall && dash3 != -1)
      {
        ArrayResize(myarray, countD + 1, 0);        // count STARTS AT ZERO SO WE ADD ONE
        wallet = StringSubstr(name, dash2 + 1, -1); // DONT INCLUDE THE DASH2
        myarray[countD] = wallet;                   // count STARTS AT ZERO for array[0] =
        countD++;                                   // count ADDS ONE
      }
    }
  }

  if (countD > 0)
  {
    ArrayResize(myarray, countD, 0);
    for (int i = 0; i < countD; i++)
    {
      SetSubWindowText("sub_wallet_" + IntegerToString(i), myarray[i] + "(" + DoubleToString(GetGlobal(exchangeName, "_Wallet_" + myarray[i]), 8) + ")", 0, 120 + (25 * i), Green, 12);
    }
  }
}

/*
 parse RobotInstance_exchange_wallet_
 PNL
 MARGIN
 SYMBOL
*/
double CryptoBridge::Get_Wallet_Info(int robotInstance, string exchangeName, string walletInfoSymbol)
{

  int total = GlobalVariablesTotal();
  string name = "";
  for (int i = 0; i < total; i++)
  {
    name = GlobalVariableName(i);
    int dash1 = StringFind(name, "_", 0); // robot_instance
    string robot_number = StringSubstr(name, 0, dash1);
    
    long str_num = StringToInteger(robot_number);
    
    if (str_num == robotInstance  && dash1 != -1)
    {
      
      int dash2 = StringFind(name, "_", dash1);   
      int dash3 = StringFind(name, "_", dash2+1); 
      int dash4 = StringFind(name, "_", dash3+1); 
      int dash5 = StringFind(name, "_", dash4+1); 
      int dash6 = StringFind(name, "_", dash5+1); 
      
      string ex_number = StringSubstr(name, 0,dash1);
      string ex_name = StringSubstr(name, dash1+1,(dash3-dash2)-1 );
      string ex_wallet = StringSubstr(name, dash3+1, (dash4-dash3)-1 );
      
      string ex_info = StringSubstr(name, dash4+1 ,-1);
      
      if(ex_name == exchangeName){
         
         if(ex_wallet == "Wallet"){
         
            if(ex_info == walletInfoSymbol){
               return( GlobalVariableGet(name) );
            }
         
         
         }
      
      }
      
      
    }
  }
  return(0);
}







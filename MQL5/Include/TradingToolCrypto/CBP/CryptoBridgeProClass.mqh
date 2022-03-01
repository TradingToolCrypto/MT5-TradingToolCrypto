//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, TradingToolCrypto Corp."
#property link      "https://github.com/tradingtoolcrypto"
#define VERSION 1.44

#import "CBP_Functions.ex5"
string RemoveSymbolSeperator(string symbolname, string seperator);
int GetOrderNumberFromLineName(string linename);
string GetVolumeFromLineName(string linename);
string GetSideFromLineName(string linename);
string GetTypeFromLineName(string linename);
string GetObjectDesc(int what_order_number);
void DeleteOjectLinesByName(string linedesc);
void DeleteOjectLinesByDesc(string linedesc);
void DeleteOjectLines(string sym);
bool CreateOrderEntryLine(string name, string text, datetime time1, double price1, datetime time2, double price2, color col, int lineWidth, int lineStyle);
bool CreateTPLine(string name, string text, datetime time1, double price1, datetime time2, double price2, color col, int lineWidth, int lineStyle);
bool CreateEntryLine(string name, string text, datetime time1, double price1, datetime time2, double price2, color col, int lineWidth, int lineStyle);
void DeleteSubWindowObjectAll(long chart_id, string objectname);
void DeleteSubWindowObjectAll(long chart_id, int window_);
void DeleteSubWindowObjectAll(long chart_id, int window_, string prefix);
void DeleteSubWindowObjectName(long id_order, string objectname);
double GetGlobal(string ExchangeName, string body);
void DeleteGlobalOrderName(string exchangeName, string sym, double value);
void DeleteGlobalPrefix(string prefix);
void SetSubWindowText(string name, string text, int x, int y, color colour, int size);
void RewriteGlobals(string checkifexist, string replacewith);
string NormalizeString(string value, int digit);
#import

#import "Bithumb_api.ex5"
void Bithumb_Set_Instance(int id);
bool Bithumb_Get_API_Key(string key, string secret);
bool Bithumb_GetServerTime();
bool Bithumb_GetPrice(string sym);
bool Bithumb_GetPriceBest(string sym, int digit_UI);
bool Bithumb_Open_Trade(string sym, string side, string orderType, string orderSize, string orderPrice, int quoteDigit, int lotDigit, string newClientOrderId);
bool Bithumb_Cancel_Trade(string sym, string orderId, string clientOrderId);
bool Bithumb_Balance(string sym, string quotebase);
bool Bithumb_GetOpenOrders(string sym, int quoteDigit);
#import

#import "Bitmax_api.ex5"
void Bitmax_Set_Instance(int id);
bool Bitmax_Get_API_Key(string key, string secret, string account_category);
bool Bitmax_Balance(string sym, string quotebase);
bool Bitmax_GetPrice(string sym, int quote_precision);
bool Bitmax_GetPriceBest(string sym, int digit_UI);
bool Bitmax_GetServerTime();
string Bitmax_ExchangeInfo();
bool Bitmax_Open_Trade(string sym, string side, string orderType, string orderSize, string orderPrice, int quoteDigit, int lotDigit, string newClientOrderId);
bool Bitmax_Open_Trade_Stop(string sym, string side, string orderType, string orderSize, string stopPrice, int quoteDigit, int lotDigit, string newClientOrderId);
bool Bitmax_Cancel_Trade(string sym, string orderId, string clientOrderId);
bool Bitmax_Cancel_Trade_All(string sym);
bool Bitmax_GetOpenOrders(string sym, int quoteDigit);
#import

#import "BinanceTestnet_api.ex5"
string Binance_Test_ExchangeInfo();
bool Binance_Test_Cancel_Trade(string sym, long orderId, string clientOrderId);
bool Binance_Test_Cancel_Trade_All(string sym);
bool Binance_Test_Open_Trade(string sym, string side, string orderType, string orderSize, string orderPrice, int quoteDigit, int lotDigit, string newClientOrderId);
bool Binance_Test_Open_Trade_Stop(string sym, string side, string orderType, string orderSize, string stopPrice, int quoteDigit, int lotDigit, string newClientOrderId);
bool Binance_Test_Open_Trade_StopLimit(string sym, string side, string orderType, string orderSize, string orderPrice, string stopPrice, int quoteDigit, int lotDigit, string newClientOrderId);
bool Binance_Test_Balance(string sym, string quotebase);
bool Binance_Test_GetPriceBest(string sym, int quote_digit);
bool Binance_Test_GetPrice(string sym);
bool Binance_Test_GetServerTime();
bool Binance_Test_Get_API_Key(string key, string secret);
void Binance_Test_Set_Instance(int id);
bool Binance_Test_GetOpenOrders(string sym, int quote_precision);
#import


#import "Binance_api.ex5"
string Binance_ExchangeInfo();
bool Binance_Cancel_Trade(string sym, long orderId, string clientOrderId);
bool Binance_Cancel_Trade_All(string sym);
bool Binance_Open_Trade(string sym, string side, string orderType, string orderSize, string orderPrice, int quoteDigit, int lotDigit, string newClientOrderId);
bool Binance_Open_Trade_Stop(string sym, string side, string orderType, string orderSize, string stopPrice, int quoteDigit, int lotDigit, string newClientOrderId);
bool Binance_Open_Trade_StopLimit(string sym, string side, string orderType, string orderSize, string orderPrice, string stopPrice, int quoteDigit, int lotDigit, string newClientOrderId);
bool Binance_Balance(string sym, string quotebase);
bool Binance_GetPriceBest(string sym, int quote_digit);
bool Binance_GetPrice(string sym);
bool Binance_GetServerTime();
bool Binance_Get_API_Key(string key, string secret);
void Binance_Set_Instance(int id);
bool Binance_GetOpenOrders(string sym, int quote_precision);
#import

#import "BinanceUS_api.ex5"
string BinanceUS_ExchangeInfo();
bool Binance_US_Cancel_Trade(string sym, long orderId, string  clientOrderId);
bool Binance_US_Cancel_Trade_All(string sym);
bool Binance_US_Open_Trade(string sym, string side, string orderType, string orderSize, string orderPrice, int quoteDigit, int lotDigit, string newClientOrderId);
bool Binance_US_Open_Trade_Stop(string sym, string side, string orderType, string orderSize, string stopPrice, int quoteDigit, int lotDigit, string newClientOrderId);
bool Binance_US_Open_Trade_StopLimit(string sym, string side, string orderType, string orderSize, string orderPrice, string stopPrice, int quoteDigit, int lotDigit, string newClientOrderId);
bool Binance_US_Balance(string sym, string quotebase);
bool Binance_US_GetPriceBest(string sym, int quote_digit);
bool Binance_US_GetPrice(string sym);
bool Binance_US_GetServerTime();
bool Binance_US_Get_API_Key(string key, string secret);
void Binance_US_Set_Instance(int id);
bool Binance_US_GetOpenOrders(string sym, int quote_precision);
#import

#import "BinanceFutures_api.ex5"
string BinanceFutures_ExchangeInfo();
bool BinanceFutures_HedgeMode(string hedgeOn_true_else_false);
bool BinanceFutures_Get_API_Key(string key, string secret, string livedemo);
void BinanceFutures_Set_Instance(int id);
bool BinanceFutures_Cancel_Trade(string sym, long orderId, string clientOrderId);
bool BinanceFutures_Cancel_Trade_ALL(string sym);
bool BinanceFutures_Open_Trade(string sym, string side, string orderType, string orderSize, string orderPrice, int quoteDigit, int lotDigit, string orderId);
bool BinanceFutures_Open_Trade_Stop(string sym, string side, string orderType, string orderSize, string stopPrice, int quoteDigit, int lotDigit, string orderId);
bool BinanceFutures_Open_Trade_StopLimit(string sym, string side, string orderType, string orderSize, string orderPrice, string stopPrice, int quoteDigit, int lotDigit, string orderId);
bool BinanceFutures_Close_Trade(string sym, string side, string orderType, string orderSize, string orderPrice, int quoteDigit, int lotDigit);
bool BinanceFutures_Balance(string sym, string quotebase);
bool BinanceFutures_GetPriceBest(string sym, int quote_digit);
bool BinanceFutures_GetPrice(string sym, int quoteDigit);
bool BinanceFutures_GetOpenInterest(string sym, int quoteDigit);
bool BinanceFutures_GetFundRate(string sym, int quoteDigit);
bool BinanceFutures_GetFundRate_All(double min_funding_rate);
bool BinanceFutures_GetOpenOrders(string sym, int quote_precision);
bool BinanceFutures_GetServerTime();
bool BinanceFutures_Set_Leverage(string sym, double leverage);
bool BinanceFutures_Positions(string sym, int quoteDigit); // returns the users open positions
string BinanceFutures_Transactions(string sym, string transactionType, long startTime, long endTime);
#import

#import "BinanceFuturesCoin_api.ex5"
string BinanceFuturesC_ExchangeInfo();
bool BinanceFuturesC_HedgeMode(string hedgeOn_true_else_false);
bool BinanceFuturesC_Get_API_Key(string key, string secret, string livedemo);
void BinanceFuturesC_Set_Instance(int id);
bool BinanceFuturesC_Cancel_Trade(string sym, long orderId, string clientOrderId);
bool BinanceFuturesC_Cancel_Trade_ALL(string sym);
bool BinanceFuturesC_Open_Trade(string sym, string side, string orderType, string orderSize, string orderPrice, int quoteDigit, int lotDigit, string orderId);
bool BinanceFuturesC_Open_Trade_Stop(string sym, string side, string orderType, string orderSize, string stopPrice, int quoteDigit, int lotDigit, string orderId);
bool BinanceFuturesC_Open_Trade_StopLimit(string sym, string side, string orderType, string orderSize, string orderPrice, string stopPrice, int quoteDigit, int lotDigit, string orderId);
bool BinanceFuturesC_Close_Trade(string sym, string side, string orderType, string orderSize, string orderPrice, int quoteDigit, int lotDigit);
bool BinanceFuturesC_Balance(string sym, string quotebase);
bool BinanceFuturesC_GetPriceBest(string sym, int quote_digit);
bool BinanceFuturesC_GetPrice(string sym, int quoteDigit);
bool BinanceFuturesC_GetOpenInterest(string sym, int quoteDigit);
bool BinanceFuturesC_GetFundRate(string sym, int quoteDigit);
bool BinanceFuturesC_GetOpenOrders(string sym, int quote_precision);
bool BinanceFuturesC_GetServerTime();
bool BinanceFuturesC_Set_Leverage(string sym, double leverage);
bool BinanceFuturesC_Positions(string sym, int quoteDigit); // returns the users open positions
#import
/*
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
*/
#import "Bybit_api.ex5"
string Bybit_ExchangeInfo();
bool Bybit_Modify_Trade(string sym, string orderId, string clientOrderId, string price, int quoteDigit, int lotDigit);
bool Bybit_Modify_Trade_Conditional(string sym, string orderId, string clientOrderId, string price, int quoteDigit, int lotDigit);
bool Bybit_Cancel_Trade(string sym, string orderId, string clientOrderId);
bool Bybit_Cancel_Trade_All(string sym);
bool Bybit_Cancel_Trade_Stop(string sym, string orderId, string clientOrderId);
bool Bybit_Open_Trade(string sym, string side, string orderType, string orderSize, string orderPrice, int quoteDigit, int lotDigit, string orderId);
bool Bybit_Open_Trade_Stop(string sym, string side, string orderType, string orderSize, string stopPrice, int quoteDigit, int lotDigit, string orderId);
bool Bybit_Open_Trade_StopLimit(string sym, string side, string orderType, string orderSize, string orderPrice, string stopPrice, int quoteDigit, int lotDigit, string newClientOrderId);
bool Bybit_Balance(string sym, string quotebase);
bool Bybit_GetOpenOrders(string sym, int quote_precision);
bool Bybit_GetPriceBest(string sym, int quoteDigit);
bool Bybit_GetPrice(string sym, int quoteDigit);
bool Bybit_GetOpenInterest(string sym, int quoteDigit);
bool Bybit_GetFundRate(string sym, int quoteDigit);
bool Bybit_GetServerTime();
bool Bybit_Get_API_Key(string key, string secret, string livedemo);
void Bybit_Set_Instance(int id);
bool Bybit_Leverage(int liveOne_demoTwo);
bool Bybit_Positions(string sym, int quoteDigit);
bool Bybit_ClosePosition(string sym, string ordertype);
bool Bybit_Set_Leverage(string sym, double leverage);
#import

#import "Bybit_PERP_api.ex5"
string Bybit_P_ExchangeInfo();
bool Bybit_P_Modify_Trade(string sym, string orderId, string clientOrderId, string price, int quoteDigit, int lotDigit);
bool Bybit_P_Modify_Trade_Conditional(string sym, string orderId, string clientOrderId, string price, int quoteDigit, int lotDigit);
bool Bybit_P_Cancel_Trade(string sym, string orderId, string clientOrderId);
bool Bybit_P_Cancel_Trade_All(string sym);
bool Bybit_P_Cancel_Trade_Stop(string sym, string orderId, string clientOrderId);
bool Bybit_P_Open_Trade(string sym, string side, string orderType, string orderSize, string orderPrice, int quoteDigit, int lotDigit, string orderId);
bool Bybit_P_Open_Trade_Stop(string sym, string side, string orderType, string orderSize, string stopPrice, int quoteDigit, int lotDigit, string orderId);
bool Bybit_P_Open_Trade_StopLimit(string sym, string side, string orderType, string orderSize, string orderPrice, string stopPrice, int quoteDigit, int lotDigit, string newClientOrderId);
bool Bybit_P_Balance(string sym, string quotebase);
bool Bybit_P_GetOpenOrders(string sym, int quote_precision);
bool Bybit_P_GetPriceBest(string sym, int quoteDigit);
bool Bybit_P_GetPrice(string sym, int quoteDigit);
bool Bybit_P_GetOpenInterest(string sym, int quoteDigit);
bool Bybit_P_GetFundRate(string sym, int quoteDigit);
bool Bybit_P_GetServerTime();
bool Bybit_P_Get_API_Key(string key, string secret, string livedemo);
void Bybit_P_Set_Instance(int id);
bool Bybit_P_Leverage(int liveOne_demoTwo);
bool Bybit_P_Positions(string sym, int quoteDigit);
bool Bybit_P_ClosePosition(string sym, string side, string orderType, double orderVolume, double orderPrice);
bool Bybit_P_Set_Leverage(string sym, double leverage);
bool Bybit_P_HedgeMode(string sym, string hedgeOn_true_else_false);
#import

#import "Bitmex_api.ex5"
bool Bitmex_GetOpenOrders(string sym, int quote_precision);
bool Bitmex_Positions(string sym, int quote_precision);
bool Bitmex_Cancel_Trade(string sym, string orderId, string clientOrderId);
bool Bitmex_Cancel_Trade_All(string sym);
bool Bitmex_Open_Trade(string sym, string side, string orderType, string orderSize, string orderPrice, int quoteDigit, int lotDigit, string orderId);
bool Bitmex_Open_Trade_Stop(string sym, string side, string orderType, string orderSize, string stopPrice, int quoteDigit, int lotDigit, string orderId);
bool Bitmex_Open_Trade_StopLimit(string sym, string side, string orderType, string orderSize, string orderPrice, string stopPrice, int quoteDigit, int lotDigit, string orderId);
bool Bitmex_Modify_Trade(string sym, string side, string orderType, string orderSize, string orderPrice, string orderId, string clientOrderId, int quoteDigit, int lotDigit);
bool Bitmex_Balance(string sym, string quotebase);
bool Bitmex_GetPriceBest(string sym);
bool Bitmex_GetPrice(string sym);
bool Bitmex_GetServerTime();
bool Bitmex_Get_API_Key(string key, string secret);
void Bitmex_Set_Instance(int id);
bool Bitmex_GetAnnouncement();
bool Bitmex_GetChat(int id);
bool Bitmex_ClosePosition(string sym, string ordertype);
bool Bitmex_Set_Leverage(string sym, double leverage);
#import

#import "ftx_api.ex5"
void FTX_Set_Instance(int id);
bool FTX_Get_API_Key(string key, string secret);
bool FTX_GetServerTime();
bool FTX_GetPrice(string sym, int quoteDigit);
bool FTX_GetOpenInterest(string sym, int quoteDigit);
bool FTX_GetFundRate(string sym, int quoteDigit);
bool FTX_GetPriceBest(string sym, int quoteDigit);
bool FTX_Balance(string sym, string quotebase);
bool FTX_Positions(string sym, int quoteDigit);
bool FTX_Open_Trade(string sym, string side, string orderType, string orderSize, string orderPrice, int quoteDigit, int lotDigit, string newClientOrderId);
bool FTX_Open_Trade_Stop(string sym, string side, string orderType, string orderSize, string stopPrice, int quoteDigit, int lotDigit, string newClientOrderId);
bool FTX_Open_Trade_StopLimit(string sym, string side, string orderType, string orderSize, string orderPrice, string stopPrice, int quoteDigit, int lotDigit, string newClientOrderId);
bool FTX_Cancel_Trade(string sym, string orderId, string clientOrderId);
bool FTX_Cancel_Trade_All(string sym);
bool FTX_Modify_Trade(string sym, string orderId, string clientOrderId, string price, int quoteDigit, int lotDigit);
bool FTX_Modify_Trade_Conditional(string sym, string orderId, string price, int quoteDigit, int lotDigit);
bool FTX_GetOpenOrders(string sym, int quoteDigit);
bool FTX_Set_Leverage(string sym, double leverage);
#import


#import "Kucoin_api.ex5"
void Kucoin_Set_Instance(int id);
bool Kucoin_Get_API_Key(string key, string secret, string passphrase);
bool Kucoin_Balance(string sym, string quotebase);
string Kucoin_ExchangeInfo();
bool Kucoin_GetServerTime();
bool Kucoin_GetPrice(string sym);
bool Kucoin_GetPriceBest(string sym, int digit_UI);
bool Kucoin_GetOpenOrders(string sym, int quoteDigit);
bool Kucoin_Cancel_Trade(string sym, string orderId, string clientOrderId);
bool Kucoin_Open_Trade(string sym, string side, string orderType, string orderSize, string orderPrice, int quoteDigit, int lotDigit, string newClientOrderId);
#import
/*
#import "Deribit_api.ex5"
bool Deribit_Cancel_Trade(string sym, string orderId);
bool Deribit_Open_Trade(string sym, string side, string orderType, string orderSize, string orderPrice, int quoteDigit, int lotDigit);
bool Deribit_Balance(string sym, string quotebase);
bool Deribit_GetOpenOrders(string sym);
bool Deribit_GetPriceBest(string sym, int quoteDigit);
bool Deribit_GetPrice(string sym);
bool Deribit_GetServerTime();
bool Deribit_Get_API_Key(string key, string secret);
bool Deribit_Leverage(int liveOne_demoTwo);
bool Deribit_Positions(string sym, int quoteDigit);
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
bool Okex_Leverage(int liveOne_demoTwo);
bool Okex_Positions(string sym, int quoteDigit);
bool Okex_ClosePosition(string sym, string ordertype);
bool Okex_Set_Leverage(string sym, double leverage);
#import
*/

/*
   include header files
*/
#include <TradingToolCrypto\CBP\ExchangeList.mqh>
/*
 Create an ENUM to have a droplist of the available exchanges within your robot's expert properties
*/
enum ENUM_TRADING_EXCHANGE
  {
   BINANCE_TEST = 0,
   ASCENDEX = 28,
   BINANCE = 1,
   BINANCE_US = 6,
   BINANCE_FUTURES = 5,
   BINANCE_FUTURES_COIN = 21,
   BITHUMB = 29,
   BITMEX = 3,
   BYBIT = 2,
   BYBIT_USDT = 22,
//  DERIBIT = 7,
//  OKEX = 8
   FTX = 12,
   KUCOIN = 4
  };


input group "---------------CRYPTO BRIDGE API SETUP---------------"

input string Ascendex_Api_Key = "";
input string Ascendex_Api_Secret = "";
input string Ascendex_Account_Type = "cash";


input string Binance_Api_Key = "";
input string Binance_Api_Secret = "";

input string Binance_US_Api_Key = "";
input string Binance_US_Api_Secret = "";

input string BinanceFutures_Api_Key = "";
input string BinanceFutures_Api_Secret = "";
input string BinanceFutures_LiveDemo = "live";

input string Bitmex_Api_Key = "";
input string Bitmex_Api_Secret = "";

input string Bithumb_Api_Key = "";
input string Bithumb_Api_Secret = "";

input string Bybit_Api_Key = "";
input string Bybit_Api_Secret = "";
input string Bybit_LiveDemo = "live";

input string FTX_Api_Key = "";
input string FTX_Api_Secret = "";

input string Kucoin_Api_Key = "";
input string Kucoin_Api_Secret = "";
input string Kucoin_Passphrase = "";

/*
input string Deribit_Api_Key = "";
input string Deribit_Api_Secret = "";

input string Okex_Api_Key = "";
input string Okex_Api_Secret = "";
input string Okex_LiveDemo = "live";
input string Okex_text_0 = "Market Type: margin, spot, futures, swap, option";
input string Okex_Market_Type = "swap";
*/

input group "---------------CRYPTO BRIDGE VISUAL SETUP---------------"
input ENUM_LINE_STYLE         TP_SL_lineStyle         = STYLE_SOLID;
input int                     TPSLLineThickness       = 2;
input color                   TakeprofitColor         = clrLightGreen;
input color                   StoplossColor           = clrLightPink;

input ENUM_LINE_STYLE         EntrylineStyle          = STYLE_DASH;
input int                     EntrylineThickness      = 1;
input int                     EntrylineLength         = 10;
input color                   EntryColorLong          = clrLightGray;
input color                   EntryColorShort         = clrLightGray;

input ENUM_LINE_STYLE         PriceMarkerLineStyle    = STYLE_SOLID;
input int                     PriceMarkerLineThickness = 2;
input color                   PriceMarkerColor        = clrGoldenrod;

input ENUM_LINE_STYLE         OrderlineStyle          = STYLE_SOLID;
input int                     OrderlineThickness      = 1;
input color                   OrderColorBuy           = clrBlueViolet;
input color                   OrderColorSell          = clrRosyBrown;
input color                   OrderColorStopLimit     = clrGoldenrod;

input group "-----ADJUSTMENTS BELOW ARE FOR CUSTOM ROBOTS------";
input ENUM_TRADING_EXCHANGE   Exchange_Number;
input string                  Exchange_Symbol_Name          = "BTCUSDT";
input double                  Exchange_Lotsize              = 1.0;
input int                     Exchange_Lot_Precision        = 8;
input int                     Exchange_Quote_Precision      = 8;
input double                  Exchange_Leverage             = 10;
input bool                    Exchange_HedgeMode            = false;
input int                     Exchange_RateLimiter          = 1000;
input group "---------------CRYPTO BRIDGE END SETUP---------------"

string GLOBAL_Parse_Separator = "#";
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CryptoBridge
  {
protected:
   string            my_name;
   int               unique_id;
   void              create_unique_id();
   void              adjust_unique_id();

public:
   bool              Init_Api_Keys(int exchange);
   bool              Deinit_Api_Keys(int exchange);
   int               Get_UniqueID() {return(unique_id);}
   // Public api calls
   string            Get_Exchange_Name(int exchangeNumber);
   bool              Get_Exchange_Server_Time(int exchangeNumber);
   bool              Get_FundRate(string sym, int exchangeNumber, int quote_precision);
   bool              Get_FundRateAll(int exchangeNumber, double minimum);
   bool              Get_OpenInterest(string sym, int exchangeNumber, int quote_precision);
   bool              Get_PriceBest(string sym, int exchangeNumber, int quote_precision);
   bool              Get_Price(string sym, int exchangeNumber, int quote_precision);
   int               Get_SymbolVolumeDigit(int exchangeNumber, string sym);
   int               Get_SymbolQuoteDigit(int exchangeNumber, string sym);
   // Private api calls
   bool              Hedge_Mode(bool on_true_off_false, int exchangeNumber);
   bool              Margin_Close_Position(string sym, string side, string orderType, string orderSize, string orderPrice, int quoteDigit, int lotDigit, int exchangeNumber);
   bool              Margin_Set_Leverage(string sym, double leverage, int exchangeNumber);
   bool              Modify_Trade(string sym, string side, string orderType, string orderSize, string orderPrice, string id, string clientId, int orderNumber,  int quoteDigit, int lotDigit, int exchangeNumber);
   bool              Open_Trade(string sym, string side, string orderType, string orderSize, string orderPrice, int quoteDigit, int lotDigit, int exchangeNumber, string orderId);
   bool              Open_Trade_Stop(string sym, string side, string orderType, string orderSize, string stopPrice, int quoteDigit, int lotDigit, int exchangeNumber, string orderId);
   bool              Open_Trade_StopLimit(string sym, string side, string orderType, string orderSize, string orderPrice, string stopPrice, int quoteDigit, int lotDigit, int exchangeNumber, string orderId);
   bool              Get_Position(string sym, int exchangeNumber, int quote_precision);
   void              Parse_Positions(string exchangeName, int pos_location, int liq_location, int quoteDigit);
   bool              Get_Balance(string sym, string quote_base, int exchangeNumber);
   void              Parse_Wallets(string exchangeName, int x, int y);
   bool              Get_OpenOrders(string sym, int exchangeNumber, int quote_precision);
   void              Parse_Orders(string exchangeName, int order_location, int id_location);
   void              Parse_OrdersY(string exchangeName, int order_location_x, int order_location_y, int id_location_x, int id_location_y);
   bool              Cancel_Trade_All(string sym, int exchangeNumber);
   bool              Cancel_Trade(string sym, string orderId, int exchangeNumber, int order_number, string clientOrderId);
   string            Get_Transactions(int exchangeNumber, string sym, string transactionType, long startTime, long endTime);
  };

//+------------------------------------------------------------------+
//|               Run this function any time you switch exchanges.   |
//+------------------------------------------------------------------+
bool CryptoBridge::Init_Api_Keys(int exchange)
  {
   bool checked = false;
   add_chart_indicator();
   create_unique_id();
   Print("CBP InitAPIKEYS | ID " + unique_id);
   if(exchange == 0)
     {
      checked = Binance_Test_Get_API_Key(Binance_Api_Key, Binance_Api_Secret);
      Binance_Test_Set_Instance(unique_id);
      add_exchange_info(exchange);
      return (checked);
     }
   if(exchange == 1)
     {
      checked = Binance_Get_API_Key(Binance_Api_Key, Binance_Api_Secret);
      Binance_Set_Instance(unique_id);
      add_exchange_info(exchange);
      return (checked);
     }
   if(exchange == 2)
     {
      checked = Bybit_Get_API_Key(Bybit_Api_Key, Bybit_Api_Secret, Bybit_LiveDemo);
      Bybit_Set_Instance(unique_id);
      add_exchange_info(exchange);
      CryptoBridge::Margin_Set_Leverage(Exchange_Symbol_Name, Exchange_Leverage, Exchange_Number);
      return (checked);
     }
   if(exchange == 3)
     {
      checked = Bitmex_Get_API_Key(Bitmex_Api_Key, Bitmex_Api_Secret);
      Bitmex_Set_Instance(unique_id);
      add_exchange_info(exchange);
      CryptoBridge::Margin_Set_Leverage(Exchange_Symbol_Name, Exchange_Leverage, Exchange_Number);
      return (checked);
     }
   if(exchange == 4)
     {
      checked = Kucoin_Get_API_Key(Kucoin_Api_Key, Kucoin_Api_Secret, Kucoin_Passphrase);
      Kucoin_Set_Instance(unique_id);
      add_exchange_info(exchange);
      return (checked);
     }
   if((exchange == 5) || (exchange == 26))
     {
      checked = BinanceFutures_Get_API_Key(BinanceFutures_Api_Key, BinanceFutures_Api_Secret, BinanceFutures_LiveDemo);
      BinanceFutures_Set_Instance(unique_id);
      add_exchange_info(exchange);
      CryptoBridge::Hedge_Mode(Exchange_HedgeMode, 5);
      CryptoBridge::Margin_Set_Leverage(Exchange_Symbol_Name, Exchange_Leverage, Exchange_Number);
      return (checked);
     }
   if(exchange == 6)
     {
      checked = Binance_US_Get_API_Key(Binance_US_Api_Key, Binance_US_Api_Secret);
      Binance_US_Set_Instance(unique_id);
      add_exchange_info(exchange);
      return (checked);
     }
   /*
   if(exchange == 7)
     {

      return (Deribit_Get_API_Key(Deribit_Api_Key, Deribit_Api_Secret));
     }
   if(exchange == 8)
     {

      return (Okex_Get_API_Key(Okex_Api_Key, Okex_Api_Secret, Okex_LiveDemo, Okex_Market_Type));
     }
   */
   if(exchange == 12)
     {
      checked =  FTX_Get_API_Key(FTX_Api_Key, FTX_Api_Secret);
      FTX_Set_Instance(unique_id);
      add_exchange_info(exchange);
      CryptoBridge::Margin_Set_Leverage(Exchange_Symbol_Name, Exchange_Leverage, Exchange_Number);
      return (checked);
     }
   if((exchange == 21) || (exchange == 27))
     {
      checked = BinanceFuturesC_Get_API_Key(BinanceFutures_Api_Key, BinanceFutures_Api_Secret, BinanceFutures_LiveDemo);
      BinanceFuturesC_Set_Instance(unique_id);
      add_exchange_info(exchange);
      CryptoBridge::Hedge_Mode(Exchange_HedgeMode, 21);
      CryptoBridge::Margin_Set_Leverage(Exchange_Symbol_Name, Exchange_Leverage, Exchange_Number);
      return (checked);
     }
   if(exchange == 22)
     {
      checked = Bybit_P_Get_API_Key(Bybit_Api_Key, Bybit_Api_Secret, Bybit_LiveDemo);
      Bybit_P_Set_Instance(unique_id);
      add_exchange_info(exchange);
      CryptoBridge::Hedge_Mode(Exchange_HedgeMode, 22);
      CryptoBridge::Margin_Set_Leverage(Exchange_Symbol_Name, Exchange_Leverage, Exchange_Number);
      return (checked);
     }
   if(exchange == 28)
     {
      checked = Bitmax_Get_API_Key(Ascendex_Api_Key, Ascendex_Api_Secret, Ascendex_Account_Type);
      Bitmax_Set_Instance(unique_id);
      add_exchange_info(exchange);
      return (checked);
     }
   if(exchange == 29)
     {
      checked = Bithumb_Get_API_Key(Bithumb_Api_Key, Bithumb_Api_Secret);
      Bithumb_Set_Instance(unique_id);
      add_exchange_info(exchange);
      return (checked);
     }
   return (false);
  }
/*
Delete all Global Variables that belong to this instance
- Get Exchange Name from Exchange ID
- Delete Objects within subwindow
- Adjust Global Variable "CBP"
- Delete all Globals that belong to this exchange instance
*/
bool CryptoBridge::Deinit_Api_Keys(int exchange)
  {
   Comment("");
   if(exchange == -1)
     {
      return(false);
     }
   string ex_name = Get_Exchange_Name(exchange);
   Print("CBP DEINIT() | ID " + IntegerToString(unique_id) + " | Exchange Name " + ex_name);
   DeleteSubWindowObjectAll(0, 1);
   adjust_unique_id();
   if(ex_name != "" && unique_id != 0)
     {
      GlobalVariablesDeleteAll(IntegerToString(unique_id) + GLOBAL_Parse_Separator +  ex_name, 0);
     }
   return(true);
  }

//+------------------------------------------------------------------+
//|   return the exchange name                                       |
//+------------------------------------------------------------------+
string CryptoBridge::Get_Exchange_Name(int exchange_number)
  {
   if(exchange_number == 0)
     {
      return ("Binance");
     }
   if(exchange_number == 1)
     {
      return ("Binance");
     }
   if(exchange_number == 2)
     {
      return ("Bybit");
     }
   if(exchange_number == 3)
     {
      return ("Bitmex");
     }
   if(exchange_number == 4)
     {
      return ("Kucoin");
     }
   if((exchange_number == 5) || (exchange_number == 26))
     {
      return ("BinanceFutures");
     }
   if(exchange_number == 6)
     {
      return ("BinanceUS");
     }
   if(exchange_number == 7)
     {
      return ("Deribit");
     }
   if(exchange_number == 8)
     {
      return ("Okex");
     }
   if(exchange_number == 12)
     {
      return ("FTX");
     }
   if((exchange_number == 21) || (exchange_number == 27))
     {
      return ("BinanceFuturesC");
     }
   if(exchange_number == 22)
     {
      return ("Bybit_P");
     }
   if(exchange_number == 28)
     {
      return ("Bitmax");
     }
   if(exchange_number == 29)
     {
      return ("Bithumb");
     }
   return ("");
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CryptoBridge::Hedge_Mode(bool on_true_off_false, int exchangeNumber)
  {
   Print("CBP HedgeMode");
   if((exchangeNumber == 5) || (exchangeNumber == 26))
     {
      if(on_true_off_false)
        {
         return (BinanceFutures_HedgeMode("true"));
        }
      else
        {
         return (BinanceFutures_HedgeMode("false"));
        }
     }
   if((exchangeNumber == 21) || (exchangeNumber == 27))
     {
      if(on_true_off_false)
        {
         return (BinanceFuturesC_HedgeMode("true"));
        }
      else
        {
         return (BinanceFuturesC_HedgeMode("false"));
        }
     }
     if((exchangeNumber == 22) || (exchangeNumber == 22))
     {
      if(on_true_off_false)
        {
         return (Bybit_P_HedgeMode(Exchange_Symbol_Name, "BothSide"));
        }
      else
        {
         return (Bybit_P_HedgeMode(Exchange_Symbol_Name, "MergedSingle"));
        }
     }
   return (false);
  }

/*
  CryptoBridgePro reads the line object. Within the line object, a stoploss order is called STOPMARKET
  - When we send an stoploss order to the exchange, the ordertype needs to be called STOP_LOSS
  - Therefore, we need to match STOPMARKET as the ordertype, then convert the order type to STOP_LOSS when we send the data through the exchange libraries.
*/
bool CryptoBridge::Modify_Trade(string sym, string side, string orderType, string orderSize, string orderPrice, string id, string clientId, int orderNumber,  int quoteDigit, int lotDigit, int exchangeNumber)
  {
   Print("CBP ModifyTrade | orderPrice " + orderPrice + " | ID " + id + " |  Client ID " + clientId + " | Order Type " + orderType + " | quoteDigit " + IntegerToString(quoteDigit) + " | lotDigit " + IntegerToString(lotDigit));
   
   if(exchangeNumber == 0)
     {
      CryptoBridge::Cancel_Trade(sym, id, exchangeNumber, 0, clientId);
      if(orderType == "LIMIT")
        {
         return (Binance_Test_Open_Trade(sym, side, orderType, orderSize, orderPrice, quoteDigit, lotDigit, id));
        }
     }
   if(exchangeNumber == 1)
     {
      CryptoBridge::Cancel_Trade(sym, id, exchangeNumber, 0, clientId);
      if(orderType == "LIMIT")
        {
         return (Binance_Open_Trade(sym, side, orderType, orderSize, orderPrice, quoteDigit, lotDigit, id));
        }
     }
   if(exchangeNumber == 2)
     {
      if(orderType == "LIMIT")
        {
         return (Bybit_Modify_Trade(sym, id, clientId, orderPrice, quoteDigit, lotDigit));
        }
      if(orderType == "STOPMARKET")     //CBP returns on line drag/drop function
        {
         return(Bybit_Modify_Trade_Conditional(sym, id, clientId, orderPrice, quoteDigit, lotDigit));
        }
     }
   if(exchangeNumber == 3)
     {
      return (Bitmex_Modify_Trade(sym, side, orderType, orderSize, orderPrice, id, clientId, quoteDigit, lotDigit));
     }
   if(exchangeNumber == 4)
     {
      CryptoBridge::Cancel_Trade(sym, id, exchangeNumber, 0, clientId);
      return (Kucoin_Open_Trade(sym, side, orderType, orderSize, orderPrice, quoteDigit, lotDigit, id));
     }
   /*
   binance futures requires canceling the order and placing a new order with the updated price
   */
   if((exchangeNumber == 5) || (exchangeNumber == 26))
     {
      if(orderType == "STOPMARKET")
        {
         orderType = "STOP_LOSS";
        }
      CryptoBridge::Cancel_Trade(sym, id, exchangeNumber, 0, clientId);
      if(orderType == "LIMIT")
        {
         return (BinanceFutures_Open_Trade(sym, side, orderType, orderSize, orderPrice, quoteDigit, lotDigit, id));
        }
      if(orderType == "STOP_LOSS")
        {
         return (BinanceFutures_Open_Trade_Stop(sym, side, orderType, orderSize, orderPrice, quoteDigit, lotDigit, id));
        }
     }
   if(exchangeNumber == 6)
     {
      CryptoBridge::Cancel_Trade(sym, id, exchangeNumber, 0, clientId);
      if(orderType == "LIMIT")
        {
         return (Binance_US_Open_Trade(sym, side, orderType, orderSize, orderPrice, quoteDigit, lotDigit, id));
        }
     }
   if(exchangeNumber == 7)
     {
      //  return (Deribit_Open_Trade(sym, side, orderType, orderSize, orderPrice));
     }
   /*
   FTX doesn't require the orderType because it is already known on the exchange side and we are submitting a new price for that orderID
   */
   if(exchangeNumber == 12)
     {
      if(orderType == "LIMIT")
        {
         return (FTX_Modify_Trade(sym, id, clientId, orderPrice, quoteDigit, lotDigit));
        }
      if(orderType == "STOPMARKET")
        {
         return(FTX_Modify_Trade_Conditional(sym, id, orderPrice, quoteDigit, lotDigit));
        }
     }
   if((exchangeNumber == 21) || (exchangeNumber == 27))
     {
      if(orderType == "STOPMARKET")
        {
         orderType = "STOP_LOSS";
        }
      CryptoBridge::Cancel_Trade(sym, id, exchangeNumber, 0, clientId); // Bug fixed Nov 11 - 2020
      if(orderType == "LIMIT")
        {
         return (BinanceFuturesC_Open_Trade(sym, side, orderType, orderSize, orderPrice, quoteDigit, lotDigit, id));
        }
      if(orderType == "STOP_LOSS")
        {
         return (BinanceFuturesC_Open_Trade_Stop(sym, side, orderType, orderSize, orderPrice, quoteDigit, lotDigit, id));
        }
     }
   if(exchangeNumber == 22)
     {
      if(orderType == "LIMIT")
        {
         return (Bybit_P_Modify_Trade(sym, id, clientId, orderPrice, quoteDigit, lotDigit));
        }
      if(orderType == "STOPMARKET")     //CBP returns on line drag/drop function
        {
         return(Bybit_P_Modify_Trade_Conditional(sym, id, clientId, orderPrice, quoteDigit, lotDigit));
        }
     }
   if(exchangeNumber == 28)
     {
      if(orderType == "STOPMARKET")
        {
         orderType = "STOP_LOSS";
        }
      if(orderType == "LIMIT")
        {
         CryptoBridge::Cancel_Trade(sym, id, exchangeNumber, 0, clientId);
         Bitmax_Open_Trade(sym, side, orderType, orderSize, orderPrice, quoteDigit, lotDigit, "");
        }
      if(orderType == "STOP_LOSS")
        {
         CryptoBridge::Cancel_Trade(sym, id, exchangeNumber, 0, clientId);
         Bitmax_Open_Trade_Stop(sym, side, orderType, orderSize, orderPrice, quoteDigit, lotDigit, "");
        }
     }
   if(exchangeNumber == 29)
     {
      if(orderType == "STOPMARKET")
        {
         orderType = "STOP_LOSS";
        }
      if(orderType == "LIMIT")
        {
         CryptoBridge::Cancel_Trade(sym, id, exchangeNumber, 0, clientId);
         Bithumb_Open_Trade(sym, side, orderType, orderSize, orderPrice, quoteDigit, lotDigit, "");
        }
      if(orderType == "STOP_LOSS")
        {
         CryptoBridge::Cancel_Trade(sym, id, exchangeNumber, 0, clientId);
         //Bithumb_Open_Trade_Stop(sym,side,orderType,orderSize,orderPrice,quoteDigit,lotDigit,"");
        }
     }
   return (false);
  }
//+------------------------------------------------------------------+
//|     market or limit order                                        |
//+------------------------------------------------------------------+
bool CryptoBridge::Open_Trade(string sym, string side, string orderType, string orderSize, string orderPrice, int quoteDigit, int lotDigit, int exchangeNumber, string orderId)
  {
   Print("CBP OpenTrade " + sym + " |(side) " + side + " |(type) " + orderType + " |(size) " + orderSize + " |(price) " + orderPrice + " |(quoteD) " + IntegerToString(quoteDigit) + " |(lotD) " + IntegerToString(lotDigit) + " |(exchangeID) " + IntegerToString(exchangeNumber) + " |(orderID) " + orderId);
   if(exchangeNumber == 0)
     {
      return (Binance_Test_Open_Trade(sym, side, orderType, orderSize, orderPrice, quoteDigit, lotDigit, orderId));
     }
   if(exchangeNumber == 1)
     {
      return (Binance_Open_Trade(sym, side, orderType, orderSize, orderPrice, quoteDigit, lotDigit, orderId));
     }
   if(exchangeNumber == 2)
     {
      return (Bybit_Open_Trade(sym, side, orderType, orderSize, orderPrice, quoteDigit, lotDigit, orderId));
     }
   if(exchangeNumber == 3)
     {
      return (Bitmex_Open_Trade(sym, side, orderType, orderSize, orderPrice, quoteDigit, lotDigit, orderId));
     }
   if(exchangeNumber == 4)
     {
      return (Kucoin_Open_Trade(sym, side, orderType, orderSize, orderPrice, quoteDigit, lotDigit, orderId));
     }
   if((exchangeNumber == 5) || (exchangeNumber == 26))
     {
      return (BinanceFutures_Open_Trade(sym, side, orderType, orderSize, orderPrice, quoteDigit, lotDigit, orderId));
     }
   if(exchangeNumber == 6)
     {
      return (Binance_US_Open_Trade(sym, side, orderType, orderSize, orderPrice, quoteDigit, lotDigit, orderId));
     }
   /*
   if(exchangeNumber == 7)
     {
      return (Deribit_Open_Trade(sym, side, orderType, orderSize, orderPrice,quoteDigit,lotDigit));
     }
   */
   if(exchangeNumber == 12)
     {
      return (FTX_Open_Trade(sym, side, orderType, orderSize, orderPrice, quoteDigit, lotDigit, orderId));
     }
   if((exchangeNumber == 21) || (exchangeNumber == 27))
     {
      return (BinanceFuturesC_Open_Trade(sym, side, orderType, orderSize, orderPrice, quoteDigit, lotDigit, orderId));
     }
   if(exchangeNumber == 22)
     {
      return (Bybit_P_Open_Trade(sym, side, orderType, orderSize, orderPrice, quoteDigit, lotDigit, orderId));
     }
   if(exchangeNumber == 28)
     {
      return (Bitmax_Open_Trade(sym, side, orderType, orderSize, orderPrice, quoteDigit, lotDigit, orderId));
     }
   if(exchangeNumber == 29)
     {
      return (Bithumb_Open_Trade(sym, side, orderType, orderSize, orderPrice, quoteDigit, lotDigit, orderId));
     }
   return (false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CryptoBridge::Open_Trade_Stop(string sym, string side, string orderType, string orderSize, string stopPrice, int quoteDigit, int lotDigit, int exchangeNumber, string orderId)
  {
   Print("CBP OpenTradeStop " + sym + " | " + side + " | " + orderType + " | " + orderSize + " | " + stopPrice + " | " + IntegerToString(quoteDigit) + " | " + IntegerToString(lotDigit) + " | " + IntegerToString(exchangeNumber) + " | " + orderId);
   if(exchangeNumber == 0)
     {
      return (Binance_Test_Open_Trade_Stop(sym, side, orderType, orderSize, stopPrice, quoteDigit, lotDigit, orderId));
     }
   if(exchangeNumber == 1)
     {
      return (Binance_Open_Trade_Stop(sym, side, orderType, orderSize, stopPrice, quoteDigit, lotDigit, orderId));
     }
   if(exchangeNumber == 2)
     {
      return (Bybit_Open_Trade_Stop(sym, side, orderType, orderSize, stopPrice, quoteDigit, lotDigit, orderId));
     }
   if(exchangeNumber == 3)
     {
      return (Bitmex_Open_Trade_Stop(sym, side, orderType, orderSize, stopPrice, quoteDigit, lotDigit, orderId));
     }
   if((exchangeNumber == 5) || (exchangeNumber == 26))
     {
      return (BinanceFutures_Open_Trade_Stop(sym, side, orderType, orderSize, stopPrice, quoteDigit, lotDigit, orderId));
     }
   if(exchangeNumber == 6)
     {
      return (Binance_US_Open_Trade_Stop(sym, side, orderType, orderSize, stopPrice, quoteDigit, lotDigit, orderId));
     }
   if(exchangeNumber == 12)
     {
      return (FTX_Open_Trade_Stop(sym, side, orderType, orderSize, stopPrice, quoteDigit, lotDigit, orderId));
     }
   if((exchangeNumber == 21) || (exchangeNumber == 27))
     {
      return (BinanceFuturesC_Open_Trade_Stop(sym, side, orderType, orderSize, stopPrice, quoteDigit, lotDigit, orderId));
     }
   if(exchangeNumber == 22)
     {
      return (Bybit_P_Open_Trade_Stop(sym, side, orderType, orderSize, stopPrice, quoteDigit, lotDigit, orderId));
     }
   if(exchangeNumber == 28)
     {
      return (Bitmax_Open_Trade_Stop(sym, side, orderType, orderSize, stopPrice, quoteDigit, lotDigit, orderId));
     }
   return (false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CryptoBridge::Open_Trade_StopLimit(string sym, string side, string orderType, string orderSize, string orderPrice, string stopPrice, int quoteDigit, int lotDigit, int exchangeNumber, string orderId)
  {
   Print("CBP OpenTradeStopLimit " + sym + " | " + side + " | " + orderType + " | " + orderSize + " | " + orderPrice +  " | " + stopPrice + " | " + IntegerToString(quoteDigit) + " | " + IntegerToString(lotDigit) + " | " + IntegerToString(exchangeNumber) + " | " + orderId);
    if(exchangeNumber == 0)
     {
      return (Binance_Test_Open_Trade_StopLimit(sym, side, orderType, orderSize, orderPrice, stopPrice, quoteDigit, lotDigit, orderId));
     }
   if(exchangeNumber == 1)
     {
      return (Binance_Open_Trade_StopLimit(sym, side, orderType, orderSize, orderPrice, stopPrice, quoteDigit, lotDigit, orderId));
     }
   if(exchangeNumber == 2)
     {
      return (Bybit_Open_Trade_StopLimit(sym, side, orderType, orderSize, orderPrice, stopPrice, quoteDigit, lotDigit, orderId));
     }
   if(exchangeNumber == 3)
     {
      return (Bitmex_Open_Trade_StopLimit(sym, side, orderType, orderSize, orderPrice, stopPrice, quoteDigit, lotDigit, orderId));
     }
   if((exchangeNumber == 5) || (exchangeNumber == 26))
     {
      return (BinanceFutures_Open_Trade_StopLimit(sym, side, orderType, orderSize, orderPrice, stopPrice, quoteDigit, lotDigit, orderId));
     }
   if(exchangeNumber == 6)
     {
      return (Binance_US_Open_Trade_StopLimit(sym, side, orderType, orderSize, orderPrice, stopPrice, quoteDigit, lotDigit, orderId));
     }
   if(exchangeNumber == 12)
     {
      return (FTX_Open_Trade_StopLimit(sym, side, orderType, orderSize, orderPrice, stopPrice, quoteDigit, lotDigit, orderId));
     }
   if((exchangeNumber == 21) || (exchangeNumber == 27))
     {
      return (BinanceFuturesC_Open_Trade_StopLimit(sym, side, orderType, orderSize, orderPrice, stopPrice, quoteDigit, lotDigit, orderId));
     }
   if(exchangeNumber == 22)
     {
      return (Bybit_P_Open_Trade_StopLimit(sym, side, orderType, orderSize, orderPrice, stopPrice, quoteDigit, lotDigit, orderId));
     }
   return (false);
  }
//+------------------------------------------------------------------+
//|       cancel specific order based on order ID                    |
//+------------------------------------------------------------------+
/*
 notes -
   - orderid4 button (X) is not being delisted
*/
bool CryptoBridge::Cancel_Trade(string sym, string orderId, int exchangeNumber, int order_number, string clientOrderId)
  {
   Print("CBP CancelTrade" + " | symbol " + sym + " | orderID " + orderId + " | clientID " + clientOrderId + " UI orderNumber " + order_number);
   string customsymbol = RemoveSymbolSeperator(sym, "_");
   string name = CryptoBridge::Get_Exchange_Name(exchangeNumber);
   if(order_number != -1)
     {
      DeleteGlobalOrderName(name, customsymbol, order_number + 1);  // Globals start at a value of 1
      DeleteSubWindowObjectName(0, "order_id" + IntegerToString(order_number));
      DeleteSubWindowObjectName(0, "orderid" + IntegerToString(order_number));
      DeleteSubWindowObjectName(0, "sub_order_" + IntegerToString(order_number));
     }
   if(orderId != "")
     {
      DeleteOjectLinesByDesc(orderId);
     }
      if(exchangeNumber == 0)
     {
      return (Binance_Test_Cancel_Trade(sym, StringToInteger(orderId), clientOrderId));
     }
   if(exchangeNumber == 1)
     {
      return (Binance_Cancel_Trade(sym, StringToInteger(orderId), clientOrderId));
     }
   if(exchangeNumber == 2)
     {
      return (Bybit_Cancel_Trade(sym, orderId, clientOrderId));
     }
   if(exchangeNumber == 3)
     {
      return (Bitmex_Cancel_Trade(sym, orderId, clientOrderId));
     }
   if(exchangeNumber == 4)
     {
      return (Kucoin_Cancel_Trade(sym, orderId, clientOrderId));
     }
   if((exchangeNumber == 5) || (exchangeNumber == 26))
     {
      return (BinanceFutures_Cancel_Trade(sym, StringToInteger(orderId), clientOrderId));
     }
   if(exchangeNumber == 6)
     {
      return (Binance_US_Cancel_Trade(sym, StringToInteger(orderId), clientOrderId));
     }
   /*
   if(exchangeNumber == 7)
     {
      return (Deribit_Cancel_Trade(sym, orderId));
     }
   */
   if(exchangeNumber == 12)
     {
      return (FTX_Cancel_Trade(sym, orderId, clientOrderId));
     }
   if((exchangeNumber == 21) || (exchangeNumber == 27))
     {
      return (BinanceFuturesC_Cancel_Trade(sym, StringToInteger(orderId), clientOrderId));
     }
   if(exchangeNumber == 22)
     {
      return (Bybit_P_Cancel_Trade(sym, orderId, clientOrderId));
     }
   if(exchangeNumber == 28)
     {
      return (Bitmax_Cancel_Trade(sym, orderId, clientOrderId));
     }
   if(exchangeNumber == 29)
     {
      return (Bithumb_Cancel_Trade(sym, orderId, clientOrderId));
     }
   return (false);
  }
//+------------------------------------------------------------------+
//|       cancel all orders                                          |
//+------------------------------------------------------------------+
bool CryptoBridge::Cancel_Trade_All(string sym, int exchangeNumber)
  {
   Print("CBP CancelAllTrades");
   string prefix = CryptoBridge::Get_Exchange_Name(exchangeNumber);
   string ok = unique_id + GLOBAL_Parse_Separator + prefix + GLOBAL_Parse_Separator + "Order" + GLOBAL_Parse_Separator + sym;
   DeleteGlobalPrefix(ok); //- this is the global assigned to the orders
   DeleteSubWindowObjectAll(0, "sub_order_");   //  - this is the order string
   DeleteSubWindowObjectAll(0, "order_id");     //    - this is the order id string
   DeleteSubWindowObjectAll(0, "orderid");      //     - this is the order edit button "X" to cancel individual orders
   DeleteOjectLines(sym);                                        // - deletes the lines on the chart
    if(exchangeNumber == 0)
     {
      return (Binance_Test_Cancel_Trade_All(sym));
     }
   if(exchangeNumber == 1)
     {
      return (Binance_Cancel_Trade_All(sym));
     }
   if(exchangeNumber == 2)
     {
      return (Bybit_Cancel_Trade_All(sym));
     }
   if(exchangeNumber == 3)
     {
      return (Bitmex_Cancel_Trade_All(sym));
     }
   if(exchangeNumber == 4)
     {
      return (Kucoin_Cancel_Trade(sym, "", ""));
     }
   if((exchangeNumber == 5) || (exchangeNumber == 26))
     {
      return (BinanceFutures_Cancel_Trade_ALL(sym));
     }
   if(exchangeNumber == 6)
     {
      return (Binance_US_Cancel_Trade_All(sym));
     }
   if(exchangeNumber == 12)
     {
      return (FTX_Cancel_Trade_All(sym));
     }
   if((exchangeNumber == 21) || (exchangeNumber == 27))
     {
      return (BinanceFuturesC_Cancel_Trade_ALL(sym));
     }
   if(exchangeNumber == 22)
     {
      return (Bybit_P_Cancel_Trade_All(sym));
     }
   return (false);
  }
//+------------------------------------------------------------------+
//|  fetch server time                                               |
//+------------------------------------------------------------------+
bool CryptoBridge::Get_Exchange_Server_Time(int exchangeNumber)
  {
   Print("CBP ServerTime");
   
   if(exchangeNumber == 0)
     {
        return (Binance_Test_GetServerTime());
     }
    
   if(exchangeNumber == 1)
     {
      return (Binance_GetServerTime());
     }
   if(exchangeNumber == 2)
     {
      return (Bybit_GetServerTime());
     }
   if(exchangeNumber == 3)
     {
      return (Bitmex_GetServerTime());
     }
   if(exchangeNumber == 4)
     {
      return (Kucoin_GetServerTime());
     }
   if((exchangeNumber == 5) || (exchangeNumber == 26))
     {
      return (BinanceFutures_GetServerTime());
     }
   if(exchangeNumber == 6)
     {
      return (Binance_US_GetServerTime());
     }
   /*
   if(exchangeNumber == 7)
     {
      return (Deribit_GetServerTime());
     }
   if(exchangeNumber == 8)
     {
      return (Okex_GetServerTime());
     }
   */
   if(exchangeNumber == 12)
     {
      return (FTX_GetServerTime());
     }
   if((exchangeNumber == 21) || (exchangeNumber == 27))
     {
      return (BinanceFuturesC_GetServerTime());
     }
   if(exchangeNumber == 22)
     {
      return (Bybit_P_GetServerTime());
     }
   if(exchangeNumber == 29)
     {
      return (Bithumb_GetServerTime());
     }
   return (false);
  }
//+------------------------------------------------------------------+
//|  Returns the top of the orderbook values: best bid and ask       |
//+------------------------------------------------------------------+
bool CryptoBridge::Get_PriceBest(string sym, int exchangeNumber, int quote_precision)
  {
   Print("CBP PriceBest");
   if(exchangeNumber == 0)
     {
      return (Binance_Test_GetPriceBest(sym, quote_precision));
     }
   if(exchangeNumber == 1)
     {
      return (Binance_GetPriceBest(sym, quote_precision));
     }
   if(exchangeNumber == 2)
     {
      return (Bybit_GetPriceBest(sym, quote_precision));
     }
   if(exchangeNumber == 3)
     {
      return (Bitmex_GetPriceBest(sym));
     }
   if(exchangeNumber == 4)
     {
      return (Kucoin_GetPriceBest(sym, quote_precision));
     }
   if((exchangeNumber == 5) || (exchangeNumber == 26))
     {
      return (BinanceFutures_GetPriceBest(sym, quote_precision));
     }
   if(exchangeNumber == 6)
     {
      return (Binance_US_GetPriceBest(sym, quote_precision));
     }
   /*
   if(exchangeNumber == 7)
     {
      return (Deribit_GetPriceBest(sym, quote_precision));
     }
   if(exchangeNumber == 8)
     {
      return (Okex_GetPriceBest(sym, quote_precision));
     }
   */
   if(exchangeNumber == 12)
     {
      return (FTX_GetPriceBest(sym, quote_precision));
     }
   if((exchangeNumber == 21) || (exchangeNumber == 27))
     {
      return (BinanceFuturesC_GetPriceBest(sym, quote_precision));
     }
   if(exchangeNumber == 22)
     {
      return (Bybit_P_GetPriceBest(sym, quote_precision));
     }
   if(exchangeNumber == 28)
     {
      return (Bitmax_GetPriceBest(sym, quote_precision));
     }
   if(exchangeNumber == 29)
     {
      return (Bithumb_GetPriceBest(sym, quote_precision));
     }
   return (false);
  }
//+------------------------------------------------------------------+
//|   fetch   the last traded price                                  |
//+------------------------------------------------------------------+
bool CryptoBridge::Get_Price(string sym, int exchangeNumber, int quote_precision)
  {
   Print("CBP Price");
   if(exchangeNumber == 0)
     {
      return (Binance_Test_GetPrice(sym));
     }
   if(exchangeNumber == 1)
     {
      return (Binance_GetPrice(sym));
     }
   if(exchangeNumber == 2)
     {
      return (Bybit_GetPrice(sym, quote_precision));
     }
   if(exchangeNumber == 3)
     {
      return (Bitmex_GetPrice(sym));
     }
   if(exchangeNumber == 4)
     {
      return (Kucoin_GetPrice(sym));
     }
   if((exchangeNumber == 5) || (exchangeNumber == 26))
     {
      return (BinanceFutures_GetPrice(sym, quote_precision));
     }
   if(exchangeNumber == 6)
     {
      return (Binance_US_GetPrice(sym));
     }
   /*
   if(exchangeNumber == 7)
     {
      return (Deribit_GetPrice(sym));
     }
   if(exchangeNumber == 8)
     {
      return (Okex_GetPrice(sym, quote_precision));
     }
   */
   if(exchangeNumber == 12)
     {
      return (FTX_GetPrice(sym, quote_precision));
     }
   if((exchangeNumber == 21) || (exchangeNumber == 27))
     {
      return (BinanceFuturesC_GetPrice(sym, quote_precision));
     }
   if(exchangeNumber == 22)
     {
      return (Bybit_P_GetPrice(sym, quote_precision));
     }
   if(exchangeNumber == 28)
     {
      return (Bitmax_GetPrice(sym, quote_precision));
     }
   if(exchangeNumber == 29)
     {
      return (Bithumb_GetPrice(sym));
     }
   return (false);
  }
//+------------------------------------------------------------------+
//|   fetch OpenInterest                                             |
//+------------------------------------------------------------------+
bool CryptoBridge::Get_OpenInterest(string sym, int exchangeNumber, int quote_precision)
  {
   Print("CBP OpenInterest");
   if(exchangeNumber == 0)
     {
      // return (Binance_Dex_GetPrice(sym));
     }
   if(exchangeNumber == 1)
     {
      //  return (Binance_GetPrice(sym));
     }
   if(exchangeNumber == 2)
     {
      return (Bybit_GetOpenInterest(sym, quote_precision));
     }
   if(exchangeNumber == 3)
     {
      //  return (Bitmex_GetPrice(sym));
     }
   if(exchangeNumber == 4)
     {
      //  return (Kucoin_GetPrice(sym));
     }
   if((exchangeNumber == 5) || (exchangeNumber == 26))
     {
      return (BinanceFutures_GetOpenInterest(sym, quote_precision));
     }
   if(exchangeNumber == 6)
     {
      //  return (Binance_US_GetPrice(sym));
     }
   if(exchangeNumber == 7)
     {
      //  return (Deribit_GetPrice(sym));
     }
   if(exchangeNumber == 8)
     {
      // return (Okex_GetPrice(sym,quote_precision));
     }
   if(exchangeNumber == 12)
     {
      return (FTX_GetOpenInterest(sym, quote_precision));
     }
   if((exchangeNumber == 21) || (exchangeNumber == 27))
     {
      return (BinanceFuturesC_GetOpenInterest(sym, quote_precision));
     }
   if(exchangeNumber == 22)
     {
      return (Bybit_P_GetOpenInterest(sym, quote_precision));
     }
   return (false);
  }
//+------------------------------------------------------------------+
//|   fetch FundRate                                                 |
//+------------------------------------------------------------------+
bool CryptoBridge::Get_FundRate(string sym, int exchangeNumber, int quote_precision)
  {
   Print("CBP FundRate");
   if(exchangeNumber == 0)
     {
      //  return (Binance_Dex_GetPrice(sym));
     }
   if(exchangeNumber == 1)
     {
      //  return (Binance_GetPrice(sym));
     }
   if(exchangeNumber == 2)
     {
      return (Bybit_GetFundRate(sym, quote_precision));
     }
   if(exchangeNumber == 3)
     {
      //  return (Bitmex_GetPrice(sym));
     }
   if(exchangeNumber == 4)
     {
      //  return (Kucoin_GetPrice(sym));
     }
   if((exchangeNumber == 5) || (exchangeNumber == 26))
     {
      return (BinanceFutures_GetFundRate(sym, quote_precision));
     }
   if(exchangeNumber == 6)
     {
      //return (Binance_US_GetPrice(sym));
     }
   if(exchangeNumber == 7)
     {
      //  return (Deribit_GetPrice(sym));
     }
   if(exchangeNumber == 8)
     {
      //  return (Okex_GetPrice(sym,quote_precision));
     }
   if(exchangeNumber == 12)
     {
      return (FTX_GetFundRate(sym, quote_precision));
     }
   if((exchangeNumber == 21) || (exchangeNumber == 27))
     {
      return (BinanceFuturesC_GetFundRate(sym, quote_precision));
     }
   if(exchangeNumber == 22)
     {
      return (Bybit_P_GetFundRate(sym, quote_precision));
     }
   return (false);
  }


//+------------------------------------------------------------------+
//| return true if pos closed on                                     |
//+------------------------------------------------------------------+
bool CryptoBridge::Margin_Close_Position(string sym, string side, string orderType, string orderSize, string orderPrice, int quoteDigit, int lotDigit, int exchangeNumber)
  {
   Print("CBP MarginClosePosition " + sym + " | " + side + " | " + orderType + " | " + orderSize + " | " + orderPrice + " | " + IntegerToString(quoteDigit) + " | " + IntegerToString(lotDigit) + " | " + IntegerToString(exchangeNumber));
   if(exchangeNumber == 2)
     {
      return (Bybit_ClosePosition(sym, orderType));
     }
   if(exchangeNumber == 3)
     {
      return (Bitmex_ClosePosition(sym, orderType));
     }
   if((exchangeNumber == 5) || (exchangeNumber == 26))
     {
      return (BinanceFutures_Close_Trade(sym, side, orderType, orderSize, orderPrice, quoteDigit, lotDigit));
     }
   if((exchangeNumber == 21) || (exchangeNumber == 27))
     {
      return (BinanceFuturesC_Close_Trade(sym, side, orderType, orderSize, orderPrice, quoteDigit, lotDigit));
     }
   if(exchangeNumber == 22)
     {
      return (Bybit_P_ClosePosition(sym, side, orderType, orderSize, orderPrice));
     }
   return (false);
  }
//+------------------------------------------------------------------+
//| return the new leverage value                                    |
//+------------------------------------------------------------------+
bool CryptoBridge::Margin_Set_Leverage(string sym, double leverage, int exchangeNumber)
  {
   Print("CBP MarginSetLeverage");
   if(exchangeNumber == 2)
     {
      return (Bybit_Set_Leverage(sym, leverage));
     }
   if(exchangeNumber == 3)
     {
      return (Bitmex_Set_Leverage(sym, leverage));
     }
   if((exchangeNumber == 5) || (exchangeNumber == 26))
     {
      return (BinanceFutures_Set_Leverage(sym, leverage));
     }
   if(exchangeNumber == 12)
     {
      return (FTX_Set_Leverage("", leverage));
     }
   if((exchangeNumber == 21) || (exchangeNumber == 27))
     {
      return (BinanceFuturesC_Set_Leverage(sym, leverage));
     }
   if(exchangeNumber == 22)
     {
      return (Bybit_P_Set_Leverage(sym, leverage));
     }
   return (false);
  }
//+------------------------------------------------------------------+
//| return all wallet balances                                       |
//+------------------------------------------------------------------+
bool CryptoBridge::Get_Balance(string sym, string quote_base, int exchangeNumber)
  {
   Print("CBP GetBalance");
   const string prefix = CryptoBridge::Get_Exchange_Name(exchangeNumber);
   const string ok = unique_id + GLOBAL_Parse_Separator + prefix + GLOBAL_Parse_Separator + "Wallet";
   DeleteGlobalPrefix(ok);
   if(exchangeNumber == 0)
     {
      return (Binance_Test_Balance(sym, quote_base));
     }
   if(exchangeNumber == 1)
     {
      return (Binance_Balance(sym, quote_base));
     }
   if(exchangeNumber == 2)
     {
      return (Bybit_Balance(sym, quote_base));
     }
   if(exchangeNumber == 3)
     {
      return (Bitmex_Balance(sym, quote_base));
     }
   if(exchangeNumber == 4)
     {
      return (Kucoin_Balance(sym, quote_base));
     }
   if((exchangeNumber == 5) || (exchangeNumber == 26))
     {
      return (BinanceFutures_Balance(sym, quote_base));
     }
   if(exchangeNumber == 6)
     {
      return (Binance_US_Balance(sym, quote_base));
     }
   /*
   if(exchangeNumber == 7)
     {
      return (Deribit_Balance(sym, quote_base));
     }
   */
   if(exchangeNumber == 12)
     {
      return (FTX_Balance(sym, quote_base));
     }
   if((exchangeNumber == 21) || (exchangeNumber == 27))
     {
      return (BinanceFuturesC_Balance(sym, quote_base));
     }
   if(exchangeNumber == 22)
     {
      return (Bybit_P_Balance(sym, quote_base));
     }
   if(exchangeNumber == 28)
     {
      return (Bitmax_Balance(sym, quote_base));
     }
   if(exchangeNumber == 29)
     {
      return (Bithumb_Balance(sym, "spot"));
     }
   return (false);
  }

//+------------------------------------------------------------------+
//| sets orders information within subwindow                         |
//+------------------------------------------------------------------+
bool CryptoBridge::Get_OpenOrders(string sym, int exchangeNumber, int quote_precision)
  {
   const string prefix = CryptoBridge::Get_Exchange_Name(exchangeNumber);
   Print("CBP GetOpenOrders " + sym + " ExchangeName " + prefix);
   const string ok = unique_id + GLOBAL_Parse_Separator + prefix + GLOBAL_Parse_Separator + "Order" + GLOBAL_Parse_Separator + sym;
   DeleteGlobalPrefix(ok);
   DeleteSubWindowObjectAll(0, "sub_order_"); // - this is the order string
   DeleteSubWindowObjectAll(0, "order_id");   //   - this is the order id string
   DeleteSubWindowObjectAll(0, "orderid");    //    - this is the order edit button "X" to cancel individual orders
   DeleteOjectLines(sym);
    if(exchangeNumber == 0)
     {
      return (Binance_Test_GetOpenOrders(sym, quote_precision));
     }
   if(exchangeNumber == 1)
     {
      return (Binance_GetOpenOrders(sym, quote_precision));
     }
   if(exchangeNumber == 2)
     {
      return (Bybit_GetOpenOrders(sym, quote_precision));
     }
   if(exchangeNumber == 3)
     {
      return (Bitmex_GetOpenOrders(sym, quote_precision));
     }
   if(exchangeNumber == 4)
     {
      return (Kucoin_GetOpenOrders(sym, quote_precision));
     }
   if((exchangeNumber == 5) || (exchangeNumber == 26))
     {
      return (BinanceFutures_GetOpenOrders(sym, quote_precision));
     }
   if(exchangeNumber == 6)
     {
      return (Binance_US_GetOpenOrders(sym, quote_precision));
     }
   /*
   if(exchangeNumber == 7)
     {
      return (Deribit_GetOpenOrders(sym));
     }
   */
   if(exchangeNumber == 12)
     {
      return (FTX_GetOpenOrders(sym, quote_precision));
     }
   if((exchangeNumber == 21) || (exchangeNumber == 27))
     {
      return (BinanceFuturesC_GetOpenOrders(sym, quote_precision));
     }
   if(exchangeNumber == 22)
     {
      return (Bybit_P_GetOpenOrders(sym, quote_precision));
     }
   if(exchangeNumber == 28)
     {
      return (Bitmax_GetOpenOrders(sym, quote_precision));
     }
   if(exchangeNumber == 29)
     {
      return (Bithumb_GetOpenOrders(sym, quote_precision));
     }
   return (false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string exchange_name[];
string exchange_symbol[];
string exchange_ordertype[];
string exchange_orderside[];
double exchange_orderprice[];
double exchange_ordersize[];
int    exchange_orderindex[];
string    exchange_orderid[];
void CryptoBridge::Parse_Orders(string exchangeName, int order_location, int id_location)
  {
   Print(" CBP ParseOrders " + exchangeName + " Exchange Unique ID " + unique_id);
   ArrayFree(exchange_name);
   ArrayFree(exchange_symbol);
   ArrayFree(exchange_ordertype);
   ArrayFree(exchange_orderside);
   ArrayFree(exchange_orderprice);
   ArrayFree(exchange_ordersize);
   ArrayFree(exchange_orderindex);
   ArrayFree(exchange_orderid);
   SetSubWindowText("sub_orders_text_", "Orders", order_location, 0, Gray, 10);
   datetime bar_close = iTime(NULL, PERIOD_CURRENT, 0);
   int total = GlobalVariablesTotal();
   int counterD = 0;
   int k = 0;
   string name;
   ushort u_sep;
   string result[];
   string r_id, r_exchange, r_order, r_symbol, r_order_type, r_order_side, r_order_volume, r_order_price;
   for(int i = 0; i < total; i++)
     {
      name = GlobalVariableName(i);
      u_sep = StringGetCharacter(GLOBAL_Parse_Separator, 0);
      k = StringSplit(name, u_sep, result);
      /*
      Only use the GV that matchs the unique id, exchangeName and Order
      */
      if(k >= 8 && result[2] == "Order" && result[1] == exchangeName && result[0] == unique_id)
        {
         r_id = result[0];
         r_exchange = result[1];
         r_order = result[2];// ORDER
         r_symbol = result[3];
         r_order_type = result[4];
         r_order_side = result[5];
         r_order_price = result[6];
         r_order_volume = result[7];
         // COUNTER STARTS AT ZERO SO WE ADD ONE
         ArrayResize(exchange_name, counterD + 1, 0);
         ArrayResize(exchange_symbol, counterD + 1, 0);
         ArrayResize(exchange_ordertype, counterD + 1, 0);
         ArrayResize(exchange_orderside, counterD + 1, 0);
         ArrayResize(exchange_orderprice, counterD + 1, 0);
         ArrayResize(exchange_ordersize, counterD + 1, 0);
         ArrayResize(exchange_orderindex, counterD + 1, 0);
         ArrayResize(exchange_orderid, counterD + 1, 0);
         // COUNTER STARTS AT ZERO for array[0] =
         exchange_name[counterD] = r_exchange;
         exchange_symbol[counterD] = r_symbol;
         exchange_ordertype[counterD] = r_order_type;
         exchange_orderside[counterD] = r_order_side;
         exchange_orderprice[counterD] = StringToDouble(r_order_price);
         exchange_ordersize[counterD] = StringToDouble(r_order_volume);
         exchange_orderindex[counterD] = (int) GlobalVariableGet(name);
         exchange_orderid[counterD] = GetObjectDesc(exchange_orderindex[counterD]);
         counterD++;
        }
     }
   /*
          Create order object on the chart
   */
   int loop_main = ArraySize(exchange_name);
   if(loop_main > 0)
     {
      // for(int i =0; i < loop_main; i++) // working for bitmex oct25 - 2020 ( does this break other exchanges?)
      for(int i = loop_main - 1; i > -1; i--) // Testing binance futures ( this was the default) Nov 15 (working - bug fixed)
        {
         if(exchange_orderside[i] == "BUY" && exchange_ordertype[i] != "STOPLIMIT")
           {
            CreateOrderEntryLine(exchange_symbol[i] + GLOBAL_Parse_Separator + exchange_ordertype[i] + GLOBAL_Parse_Separator + "BUY" + GLOBAL_Parse_Separator  + exchange_ordersize[i] + GLOBAL_Parse_Separator + IntegerToString(i), GetObjectDesc(exchange_orderindex[i]), bar_close - 6000, exchange_orderprice[i], bar_close, exchange_orderprice[i], OrderColorBuy, OrderlineThickness, OrderlineStyle);
           }
         if(exchange_orderside[i] == "SELL" && exchange_ordertype[i] != "STOPLIMIT")
           {
            CreateOrderEntryLine(exchange_symbol[i] + GLOBAL_Parse_Separator + exchange_ordertype[i] + GLOBAL_Parse_Separator +  "SELL" + GLOBAL_Parse_Separator + exchange_ordersize[i] + GLOBAL_Parse_Separator + IntegerToString(i), GetObjectDesc(exchange_orderindex[i]), bar_close - 6000, exchange_orderprice[i], bar_close, exchange_orderprice[i], OrderColorSell, OrderlineThickness, OrderlineStyle);
           }
         /*
         stop limit orders need to be a different color because these orders require two prices and drag to modify will be disabled
         OrderColorStopLimit
         */
         if(exchange_orderside[i] == "BUY" && exchange_ordertype[i] == "STOPLIMIT")
           {
            CreateOrderEntryLine(exchange_symbol[i] + GLOBAL_Parse_Separator + exchange_ordertype[i] + GLOBAL_Parse_Separator +  "BUY" + GLOBAL_Parse_Separator  + exchange_ordersize[i] + GLOBAL_Parse_Separator + IntegerToString(i), GetObjectDesc(exchange_orderindex[i]), bar_close - 6000, exchange_orderprice[i], bar_close, exchange_orderprice[i], OrderColorStopLimit, OrderlineThickness, OrderlineStyle);
           }
         if(exchange_orderside[i] == "SELL" && exchange_ordertype[i] == "STOPLIMIT")
           {
            CreateOrderEntryLine(exchange_symbol[i] + GLOBAL_Parse_Separator + exchange_ordertype[i] + GLOBAL_Parse_Separator +  "SELL" + GLOBAL_Parse_Separator + exchange_ordersize[i] + GLOBAL_Parse_Separator + IntegerToString(i), GetObjectDesc(exchange_orderindex[i]), bar_close - 6000, exchange_orderprice[i], bar_close, exchange_orderprice[i], OrderColorStopLimit, OrderlineThickness, OrderlineStyle);
           }
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CryptoBridge::Parse_OrdersY(string exchangeName, int order_location_x, int order_location_y, int id_location_x, int id_location_y)
  {
   Print("CBP ParseOrders " + exchangeName);
   SetSubWindowText("sub_orders_text_", "Orders", order_location_x, order_location_y, Gray, 10);
   ArrayFree(exchange_name);
   ArrayFree(exchange_symbol);
   ArrayFree(exchange_ordertype);
   ArrayFree(exchange_orderside);
   ArrayFree(exchange_orderprice);
   ArrayFree(exchange_ordersize);
   ArrayFree(exchange_orderindex);
   SetSubWindowText("sub_orders_text_", "Orders", order_location_x, 0, Gray, 10);
   datetime bar_close = iTime(NULL, PERIOD_CURRENT, 0);
   int total = GlobalVariablesTotal();
   int counterD = 0;
   int k = 0;
   string name;
   ushort u_sep;
   string result[];
   string r_id, r_exchange, r_order, r_symbol, r_order_type, r_order_side, r_order_volume, r_order_price;
   for(int i = 0; i < total; i++)
     {
      name = GlobalVariableName(i);
      u_sep = StringGetCharacter(GLOBAL_Parse_Separator, 0);
      k = StringSplit(name, u_sep, result);
      /*
      Only use the GV that matchs the unique id, exchangeName and Order
      */
      if(k >= 8 && result[2] == "Order" && result[1] == exchangeName && result[0] == unique_id)
        {
         r_id = result[0];
         r_exchange = result[1];
         r_order = result[2];// ORDER
         r_symbol = result[3];
         r_order_type = result[4];
         r_order_side = result[5];
         r_order_price = result[6];
         r_order_volume = result[7];
         // COUNTER STARTS AT ZERO SO WE ADD ONE
         ArrayResize(exchange_name, counterD + 1, 0);
         ArrayResize(exchange_symbol, counterD + 1, 0);
         ArrayResize(exchange_ordertype, counterD + 1, 0);
         ArrayResize(exchange_orderside, counterD + 1, 0);
         ArrayResize(exchange_orderprice, counterD + 1, 0);
         ArrayResize(exchange_ordersize, counterD + 1, 0);
         ArrayResize(exchange_orderindex, counterD + 1, 0);
         // COUNTER STARTS AT ZERO for array[0] =
         exchange_name[counterD] = r_exchange;
         exchange_symbol[counterD] = r_symbol;
         exchange_ordertype[counterD] = r_order_type;
         exchange_orderside[counterD] = r_order_side;
         exchange_orderprice[counterD] = StringToDouble(r_order_price);
         exchange_ordersize[counterD] = StringToDouble(r_order_volume);
         exchange_orderindex[counterD] = (int) GlobalVariableGet(name);
         counterD++;
        }
     }
   /*
          Create order object on the chart
   */
   int loop_main = ArraySize(exchange_name);
   if(loop_main > 0)
     {
      // for(int i =0; i < loop_main; i++) // working for bitmex oct25 - 2020 ( does this break other exchanges?)
      for(int i = loop_main - 1; i > -1; i--) // Testing binance futures ( this was the default) Nov 15 (working - bug fixed)
        {
         if(exchange_orderside[i] == "BUY" && exchange_ordertype[i] != "STOPLIMIT")
           {
            CreateOrderEntryLine(exchange_symbol[i] + GLOBAL_Parse_Separator + exchange_ordertype[i] + GLOBAL_Parse_Separator + "BUY" + GLOBAL_Parse_Separator  + exchange_ordersize[i] + GLOBAL_Parse_Separator + IntegerToString(i), GetObjectDesc(exchange_orderindex[i]), bar_close - 6000, exchange_orderprice[i], bar_close, exchange_orderprice[i], OrderColorBuy, OrderlineThickness, OrderlineStyle);
           }
         if(exchange_orderside[i] == "SELL" && exchange_ordertype[i] != "STOPLIMIT")
           {
            CreateOrderEntryLine(exchange_symbol[i] + GLOBAL_Parse_Separator + exchange_ordertype[i] + GLOBAL_Parse_Separator +  "SELL" + GLOBAL_Parse_Separator + exchange_ordersize[i] + GLOBAL_Parse_Separator + IntegerToString(i), GetObjectDesc(exchange_orderindex[i]), bar_close - 6000, exchange_orderprice[i], bar_close, exchange_orderprice[i], OrderColorSell, OrderlineThickness, OrderlineStyle);
           }
         /*
         stop limit orders need to be a different color because these orders require two prices and drag to modify will be disabled
         OrderColorStopLimit
         */
         if(exchange_orderside[i] == "BUY" && exchange_ordertype[i] == "STOPLIMIT")
           {
            CreateOrderEntryLine(exchange_symbol[i] + GLOBAL_Parse_Separator + exchange_ordertype[i] + GLOBAL_Parse_Separator +  "BUY" + GLOBAL_Parse_Separator  + exchange_ordersize[i] + GLOBAL_Parse_Separator + IntegerToString(i), GetObjectDesc(exchange_orderindex[i]), bar_close - 6000, exchange_orderprice[i], bar_close, exchange_orderprice[i], OrderColorStopLimit, OrderlineThickness, OrderlineStyle);
           }
         if(exchange_orderside[i] == "SELL" && exchange_ordertype[i] == "STOPLIMIT")
           {
            CreateOrderEntryLine(exchange_symbol[i] + GLOBAL_Parse_Separator + exchange_ordertype[i] + GLOBAL_Parse_Separator +  "SELL" + GLOBAL_Parse_Separator + exchange_ordersize[i] + GLOBAL_Parse_Separator + IntegerToString(i), GetObjectDesc(exchange_orderindex[i]), bar_close - 6000, exchange_orderprice[i], bar_close, exchange_orderprice[i], OrderColorStopLimit, OrderlineThickness, OrderlineStyle);
           }
        }
     }
  }
//+------------------------------------------------------------------+
//|   fetch the open positions                                       |
//+------------------------------------------------------------------+
bool CryptoBridge::Get_Position(string sym, int exchangeNumber, int quote_precision)
  {
   Print("CBP GetPosition on Symbol(" + sym + ")");
   DeleteOjectLinesByDesc("ENTRY_BUY");
   DeleteOjectLinesByDesc("ENTRY_SELL");
   string prefix = CryptoBridge::Get_Exchange_Name(exchangeNumber);
   string pos = unique_id + GLOBAL_Parse_Separator + prefix + GLOBAL_Parse_Separator + "POS";
   string liq = unique_id + GLOBAL_Parse_Separator + prefix + GLOBAL_Parse_Separator + "LIQ";
   DeleteGlobalPrefix(pos);
   DeleteGlobalPrefix(liq);
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
   if(exchangeNumber == 2)
     {
      return (Bybit_Positions(sym, quote_precision));
     }
   if(exchangeNumber == 3)
     {
      return (Bitmex_Positions(sym, quote_precision));
     }
   if((exchangeNumber == 5) || (exchangeNumber == 26))
     {
      return (BinanceFutures_Positions(sym, quote_precision));
     }
   /*
   if(exchangeNumber == 7)
     {
      return (Deribit_Positions(sym, quote_precision));
     }
   */
   if(exchangeNumber == 12)
     {
      return (FTX_Positions(sym, quote_precision));
     }
   if((exchangeNumber == 21) || (exchangeNumber == 27))
     {
      return (BinanceFuturesC_Positions(sym, quote_precision));
     }
   if(exchangeNumber == 22)
     {
      return (Bybit_P_Positions(sym, quote_precision));
     }
   return (false);
  }


string exchange_wallets[];
double exchange_wallets_balance[];
double exchange_wallets_freemargin[];
double exchange_wallets_pnl[];
void CryptoBridge::Parse_Wallets(string exchangeName, int x, int y)
  {
   ArrayFree(exchange_wallets);
   ArrayFree(exchange_wallets_balance);
   ArrayFree(exchange_wallets_freemargin);
   ArrayFree(exchange_wallets_pnl);
   DeleteSubWindowObjectAll(0, "sub_wallet_" + exchangeName + "_");
   SetSubWindowText("sub_wallet_" + exchangeName, exchangeName + " Wallets", x, y, Gray, 10);
   int total = GlobalVariablesTotal();
   string name = "";
   string wallet = "";
   ushort u_sep;
   string result[];
   int k;
   int countD = 0;
   for(int i = 0; i < total; i++)
     {
      name = GlobalVariableName(i);
      u_sep = StringGetCharacter(GLOBAL_Parse_Separator, 0);
      k = StringSplit(name, u_sep, result);
      if(k == 4 && result[0] == unique_id && result[1] == exchangeName && result[2] == "Wallet")
        {
         ArrayResize(exchange_wallets, countD + 1, 0);
         ArrayResize(exchange_wallets_balance, countD + 1, 0);
         ArrayResize(exchange_wallets_freemargin, countD + 1, 0);
         ArrayResize(exchange_wallets_pnl, countD + 1, 0);
         exchange_wallets[countD] = result[3];
         exchange_wallets_balance[countD] = GlobalVariableGet(name);
         exchange_wallets_freemargin[countD] = GlobalVariableGet(name + GLOBAL_Parse_Separator + "MARGIN");
         exchange_wallets_pnl[countD] = GlobalVariableGet(name + GLOBAL_Parse_Separator + "PNL");
         countD++;
        }
     }
   if(countD > 0)
     {
      ArrayResize(exchange_wallets, countD, 0);
      ArrayResize(exchange_wallets_balance, countD, 0);
      ArrayResize(exchange_wallets_freemargin, countD, 0);
      ArrayResize(exchange_wallets_pnl, countD, 0);
      for(int i = 0; i < countD; i++)
        {
         if(exchange_wallets_balance[i] != 0)
           {
            SetSubWindowText("sub_wallet_" + exchangeName + "_" + IntegerToString(i), exchange_wallets[i] + " " + DoubleToString(exchange_wallets_balance[i], 8) +
                             " MARGIN " + DoubleToString(exchange_wallets_freemargin[i], 8) +
                             " PNL " + DoubleToString(exchange_wallets_pnl[i], 8), x, (y + 16) + (20 * i), Green, 12);
           }
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void add_chart_indicator()
  {
   bool exist = false;
//--- The number of windows on the chart (at least one main window is always present)
   int windows = (int)ChartGetInteger(0, CHART_WINDOWS_TOTAL);
//--- Check all windows
   for(int w = 0; w < windows; w++)
     {
      //--- the number of indicators in this window/subwindow
      int total = ChartIndicatorsTotal(0, w);
      //--- Go through all indicators in the window
      for(int i = 0; i < total; i++)
        {
         //--- get the short name of an indicator
         string name = ChartIndicatorName(0, w, i);
         if(name == "SubWindow")
           {
            //--- get the handle of an indicator
            int handle = ChartIndicatorGet(0, w, name);
            IndicatorRelease(handle);
            exist  = true;
            break;
           }
        }
      if(exist)
         break;
     }
   if(exist)
      return;
   /*
   else the indicator does not exist and
   - place the indicator on the chart automatically
   - dir - "Examples\\Custom Moving Average
   */
   int indicator_handle = iCustom(NULL, PERIOD_CURRENT, "TTC\\SubWindow");
   int subwindow = (int)ChartGetInteger(0, CHART_WINDOWS_TOTAL);
   ChartIndicatorAdd(0, subwindow, indicator_handle);
  }
//+------------------------------------------------------------------+
void CryptoBridge::create_unique_id()
  {
   const string id = "CBP";
   double value = GlobalVariableGet(id);
   if(value == 0)
     {
      GlobalVariableSet(id, 1);
      unique_id = 1;
     }
   if(value > 0)
     {
      GlobalVariableSet(id, value + 1);
      unique_id = value + 1;
     }
  }

/*
When the CryptoBridge instance is terminated, reduce the Global Variable "CBP" by 1 value
*/
void CryptoBridge::adjust_unique_id()
  {
   const string id = "CBP";
   double value = GlobalVariableGet(id);
   if(value > 0)
     {
      GlobalVariableSet(id, value - 1);
     }
   else
     {
      GlobalVariableSet(id, 0);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string CryptoBridge::Get_Transactions(int exchangeNumber, string sym, string transactionType, long startTime, long endTime)
  {
   Print("CBP GetTransactions");
   if(exchangeNumber == 5)
     {
      return (BinanceFutures_Transactions(sym, transactionType, startTime, endTime));
     }
   return("");
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CryptoBridge::Get_FundRateAll(int exchangeNumber, double minimum)
  {
   Print("CBP GetFundRateAll");
   if(exchangeNumber == 5)
     {
      return (BinanceFutures_GetFundRate_All(minimum));
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CryptoBridge::Get_SymbolQuoteDigit(int exchangeNumber, string sym)
  {
   Print("CBP SymbolQuoteDigit");
   if(exchangeNumber == 1)
     {
      int loop = ArraySize(BinanceSymbols);
      for(int i = 0; i < loop; i++)
        {
         if(sym == BinanceSymbols[i])
           {
            return(BinanceSymbolsQuoteDigit[i]);
           }
        }
     }
   if((exchangeNumber == 2) || (exchangeNumber == 22))
     {
      int loop = ArraySize(BybitSymbols);
      for(int i = 0; i < loop; i++)
        {
         if(sym == BybitSymbols[i])
           {
            return(BybitSymbolsQuoteDigit[i]);
           }
        }
     }
   if((exchangeNumber == 5) || (exchangeNumber == 26))
     {
      int loop = ArraySize(BinanceFuturesSymbols);
      for(int i = 0; i < loop; i++)
        {
         if(sym == BinanceFuturesSymbols[i])
           {
            return(BinanceFuturesSymbolsQuoteDigit[i]);
           }
        }
     }
   if(exchangeNumber == 6)
     {
      int loop = ArraySize(BinanceUSSymbols);
      for(int i = 0; i < loop; i++)
        {
         if(sym == BinanceUSSymbols[i])
           {
            return(BinanceUSSymbolsQuoteDigit[i]);
           }
        }
     }
   if((exchangeNumber == 21) || (exchangeNumber == 27))
     {
      int loop = ArraySize(BinanceFuturesCSymbols);
      for(int i = 0; i < loop; i++)
        {
         if(sym == BinanceFuturesCSymbols[i])
           {
            return(BinanceFuturesCSymbolsQuoteDigit[i]);
           }
        }
     }
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CryptoBridge::Get_SymbolVolumeDigit(int exchangeNumber, string sym)
  {
   Print("CBP SymbolVolumeDigit");
   if(exchangeNumber == 1)
     {
      int loop = ArraySize(BinanceSymbols);
      for(int i = 0; i < loop; i++)
        {
         if(sym == BinanceSymbols[i])
           {
            return(BinanceSymbolsVolumeDigit[i]);
           }
        }
     }
   if((exchangeNumber == 2) || (exchangeNumber == 22))
     {
      int loop = ArraySize(BybitSymbols);
      for(int i = 0; i < loop; i++)
        {
         if(sym == BybitSymbols[i])
           {
            return(BybitSymbolsVolumeDigit[i]);
           }
        }
     }
   if((exchangeNumber == 5) || (exchangeNumber == 26))
     {
      int loop = ArraySize(BinanceFuturesSymbols);
      for(int i = 0; i < loop; i++)
        {
         if(sym == BinanceFuturesSymbols[i])
           {
            return(BinanceFuturesSymbolsVolumeDigit[i]);
           }
        }
     }
   if(exchangeNumber == 6)
     {
      int loop = ArraySize(BinanceUSSymbols);
      for(int i = 0; i < loop; i++)
        {
         if(sym == BinanceUSSymbols[i])
           {
            return(BinanceUSSymbolsVolumeDigit[i]);
           }
        }
     }
   if((exchangeNumber == 21) || (exchangeNumber == 27))
     {
      int loop = ArraySize(BinanceFuturesCSymbols);
      for(int i = 0; i < loop; i++)
        {
         if(sym == BinanceFuturesCSymbols[i])
           {
            return(BinanceFuturesCSymbolsVolumeDigit[i]);
           }
        }
     }
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void add_exchange_info(int exchangeNumber)
  {
   Print("CBP ExchangeInfo");
   if(exchangeNumber == 1 || exchangeNumber == 0 )
     {
      const int marketsTotal = 2000;
      string info;
      if(exchangeNumber == 0){
      info = Binance_Test_ExchangeInfo();
      }else{
      info = Binance_ExchangeInfo();
      }
     
      jasonClass.Clear();
      jasonClass.Deserialize(info);
      ArrayFree(BinanceSymbols);
      ArrayResize(BinanceSymbols, marketsTotal);
      ArrayFree(BinanceSymbolsQuoteDigit);
      ArrayResize(BinanceSymbolsQuoteDigit, marketsTotal);
      ArrayFree(BinanceSymbolsVolumeDigit);
      ArrayResize(BinanceSymbolsVolumeDigit, marketsTotal);
      string sym = "";
      int count_index = 0;
      for(int i = 0; i < marketsTotal; i++)
        {
         sym = jasonClass["symbols"][i]["symbol"].ToStr();;
         if(sym == "")
            break;
         BinanceSymbols[i] = sym;
         BinanceSymbolsQuoteDigit[i] = enter_string_get_digit(jasonClass["symbols"][i]["filters"][0]["tickSize"].ToStr());
         BinanceSymbolsVolumeDigit[i] = enter_string_get_digit(jasonClass["symbols"][i]["filters"][2]["stepSize"].ToStr());
         count_index++;
        }
      ArrayResize(BinanceSymbols, count_index);
      ArrayResize(BinanceSymbolsQuoteDigit, count_index);
      ArrayResize(BinanceSymbolsVolumeDigit, count_index);
     }
   if((exchangeNumber == 2) || (exchangeNumber == 22))
     {
      string info = Bybit_ExchangeInfo();
      jasonClass.Clear();
      jasonClass.Deserialize(info);
      ArrayFree(BybitSymbols);
      ArrayResize(BybitSymbols, 100);
      ArrayFree(BybitSymbolsQuoteDigit);
      ArrayResize(BybitSymbolsQuoteDigit, 100);
      ArrayFree(BybitSymbolsVolumeDigit);
      ArrayResize(BybitSymbolsVolumeDigit, 100);
      string sym = "";
      int count_index = 0;
      for(int i = 0; i < 100; i++)
        {
         sym = jasonClass["result"][i]["name"].ToStr();
         if(sym == "")
            break;
         BybitSymbols[i] = sym;
         BybitSymbolsQuoteDigit[i]  =   jasonClass["result"][i]["price_scale"].ToStr();
         BybitSymbolsVolumeDigit[i] = 0;
         count_index++;
        }
      ArrayResize(BybitSymbols, count_index);
      ArrayResize(BybitSymbolsQuoteDigit, count_index);
      ArrayResize(BybitSymbolsVolumeDigit, count_index);
     }
   if((exchangeNumber == 5) || (exchangeNumber == 26))
     {
      string info = BinanceFutures_ExchangeInfo();
      jasonClass.Clear();
      jasonClass.Deserialize(info);
      ArrayFree(BinanceFuturesSymbols);
      ArrayResize(BinanceFuturesSymbols, 5000);
      ArrayFree(BinanceFuturesSymbolsQuoteDigit);
      ArrayResize(BinanceFuturesSymbolsQuoteDigit, 5000);
      ArrayFree(BinanceFuturesSymbolsVolumeDigit);
      ArrayResize(BinanceFuturesSymbolsVolumeDigit, 5000);
      string sym = "";
      int count_index = 0;
      for(int i = 0; i < 5000; i++)
        {
         sym = jasonClass["symbols"][i]["symbol"].ToStr();;
         if(sym == "")
            break;
         BinanceFuturesSymbols[i] = jasonClass["symbols"][i]["symbol"].ToStr();
         BinanceFuturesSymbolsQuoteDigit[i] = jasonClass["symbols"][i]["pricePrecision"].ToInt();
         BinanceFuturesSymbolsVolumeDigit[i] = jasonClass["symbols"][i]["quantityPrecision"].ToInt();
         count_index++;
        }
      ArrayResize(BinanceFuturesSymbols, count_index);
      ArrayResize(BinanceFuturesSymbolsQuoteDigit, count_index);
      ArrayResize(BinanceFuturesSymbolsVolumeDigit, count_index);
     }
   if(exchangeNumber == 6)
     {
      const int marketsTotal = 2000;
      string info = BinanceUS_ExchangeInfo();
      jasonClass.Clear();
      jasonClass.Deserialize(info);
      ArrayFree(BinanceUSSymbols);
      ArrayResize(BinanceUSSymbols, marketsTotal);
      ArrayFree(BinanceUSSymbolsQuoteDigit);
      ArrayResize(BinanceUSSymbolsQuoteDigit, marketsTotal);
      ArrayFree(BinanceUSSymbolsVolumeDigit);
      ArrayResize(BinanceUSSymbolsVolumeDigit, marketsTotal);
      string sym = "";
      int count_index = 0;
      for(int i = 0; i < marketsTotal; i++)
        {
         sym = jasonClass["symbols"][i]["symbol"].ToStr();;
         if(sym == "")
            break;
         BinanceUSSymbols[i] = sym;
         BinanceUSSymbolsQuoteDigit[i] = enter_string_get_digit(jasonClass["symbols"][i]["filters"][0]["tickSize"].ToStr());
         BinanceUSSymbolsVolumeDigit[i] = enter_string_get_digit(jasonClass["symbols"][i]["filters"][2]["stepSize"].ToStr());
         count_index++;
        }
      ArrayResize(BinanceUSSymbols, count_index);
      ArrayResize(BinanceUSSymbolsQuoteDigit, count_index);
      ArrayResize(BinanceUSSymbolsVolumeDigit, count_index);
     }
   if((exchangeNumber == 21) || (exchangeNumber == 27))
     {
      string info = BinanceFuturesC_ExchangeInfo();
      jasonClass.Clear();
      jasonClass.Deserialize(info);
      ArrayFree(BinanceFuturesCSymbols);
      ArrayResize(BinanceFuturesCSymbols, 5000);
      ArrayFree(BinanceFuturesCSymbolsQuoteDigit);
      ArrayResize(BinanceFuturesCSymbolsQuoteDigit, 5000);
      ArrayFree(BinanceFuturesCSymbolsVolumeDigit);
      ArrayResize(BinanceFuturesCSymbolsVolumeDigit, 5000);
      string sym = "";
      int count_index = 0;
      for(int i = 0; i < 5000; i++)
        {
         sym = jasonClass["symbols"][i]["symbol"].ToStr();;
         if(sym == "")
            break;
         BinanceFuturesCSymbols[i] = jasonClass["symbols"][i]["symbol"].ToStr();
         BinanceFuturesCSymbolsQuoteDigit[i] = jasonClass["symbols"][i]["pricePrecision"].ToInt();
         BinanceFuturesCSymbolsVolumeDigit[i] = jasonClass["symbols"][i]["quantityPrecision"].ToInt();
         count_index++;
        }
      ArrayResize(BinanceFuturesCSymbols, count_index);
      ArrayResize(BinanceFuturesCSymbolsQuoteDigit, count_index);
      ArrayResize(BinanceFuturesCSymbolsVolumeDigit, count_index);
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
   Print("CBP ParsePositions " + exchangeName);
// Empty previous data
   ArrayFree(exchange_name_p);
   ArrayFree(exchange_symbol_p);
   ArrayFree(exchange_orderside_p);
   ArrayFree(exchange_orderprice_p);
   ArrayFree(exchange_ordersize_p);
   ArrayFree(exchange_orderliquidation_p);
// Positions Lable on the chart
   SetSubWindowText("sub_position_text_", "Positions", pos_location, 0, Gray, 10);
   SetSubWindowText("sub_liq_text_", "LIQ", liq_location, 0, Gray, 10);
   int total = GlobalVariablesTotal();
   int counterD = 0; // COUNTER STARTS AT ZERO
   int k = 0;
   string name;
   ushort u_sep;
   string result[];
   string r_id, r_exchange, r_order, r_symbol, r_order_type, r_order_side, r_order_volume, r_order_price;
   string build_global_name;
   string positionarray[];
   for(int i = 0; i < total; i++)
     {
      name = GlobalVariableName(i);
      u_sep = StringGetCharacter(GLOBAL_Parse_Separator, 0);
      k = StringSplit(name, u_sep, result);
      if(k == 8 && result[0] == unique_id && result[1] == exchangeName && result[2] == "POS")
        {
         r_id = result[0];
         r_exchange = result[1];
         r_order = result[2];// ORDER
         r_symbol = result[3];
         r_order_type = result[4];
         r_order_side = result[5];
         r_order_price = result[6];
         r_order_volume = result[7];
         build_global_name =  r_id + GLOBAL_Parse_Separator +
                              r_exchange + GLOBAL_Parse_Separator + "LIQ" + GLOBAL_Parse_Separator +
                              r_symbol + GLOBAL_Parse_Separator +
                              r_order_type + GLOBAL_Parse_Separator +
                              r_order_side + GLOBAL_Parse_Separator +
                              r_order_price + GLOBAL_Parse_Separator +
                              r_order_volume;
         // COUNTER STARTS AT ZERO SO WE ADD ONE
         ArrayResize(exchange_name_p, counterD + 1, 0);
         ArrayResize(exchange_symbol_p, counterD + 1, 0);
         ArrayResize(exchange_orderside_p, counterD + 1, 0);
         ArrayResize(exchange_orderprice_p, counterD + 1, 0);
         ArrayResize(exchange_ordersize_p, counterD + 1, 0);
         ArrayResize(exchange_orderliquidation_p, counterD + 1, 0);
         ArrayResize(positionarray, counterD + 1, 0);
         // COUNTER STARTS AT ZERO for array[0] =
         exchange_name_p[counterD] = r_exchange;
         exchange_symbol_p[counterD] = r_symbol;
         exchange_orderside_p[counterD] = r_order_side;
         exchange_orderprice_p[counterD] = StringToDouble(r_order_price);
         exchange_ordersize_p[counterD] = StringToDouble(r_order_volume);
         exchange_orderliquidation_p[counterD] =  GlobalVariableGet(build_global_name);
         positionarray[counterD] = r_symbol + " " + r_order_side + " (" + r_order_volume + ")" + " " + NormalizeString(r_order_price, quoteDigit);
         /*
         reconstruct the position information that will be displayed within the sub window
         */
         counterD++;                        // COUNTER ADDS ONE
        }
     }
   /*
   Position Array is loaded
   */
   if(counterD > 0)
     {
      ArrayResize(positionarray, counterD, 0);
      datetime bar_close = iTime(NULL, PERIOD_CURRENT, 0);
      for(int i = 0; i < counterD; i++)
        {
         if(exchange_orderside_p[i] == "BUY")
           {
            SetSubWindowText("sub_pos_" + IntegerToString(i), positionarray[i], pos_location, 20 + (25 * i), EntryColorLong, 10);
            SetSubWindowText("sub_liq_" + IntegerToString(i), DoubleToString(exchange_orderliquidation_p[i], quoteDigit), liq_location, 20 + (25 * i), StoplossColor, 10);
            CreateEntryLine(exchange_symbol_p[i] + GLOBAL_Parse_Separator +  "ENTRY", "ENTRY_" + exchange_orderside_p[i], bar_close - (6000 * EntrylineLength), exchange_orderprice_p[i], bar_close, exchange_orderprice_p[i], EntryColorLong, EntrylineThickness, EntrylineStyle);
           }
         if(exchange_orderside_p[i] == "SELL")
           {
            SetSubWindowText("sub_pos_" + IntegerToString(i), positionarray[i], pos_location, 20 + (25 * i), EntryColorShort, 10);
            SetSubWindowText("sub_liq_" + IntegerToString(i), DoubleToString(exchange_orderliquidation_p[i], quoteDigit), liq_location, 20 + (25 * i), StoplossColor, 10);
            CreateEntryLine(exchange_symbol_p[i] + GLOBAL_Parse_Separator +  "ENTRY", "ENTRY_" + exchange_orderside_p[i], bar_close - (6000 * EntrylineLength), exchange_orderprice_p[i], bar_close, exchange_orderprice_p[i], EntryColorShort, EntrylineThickness, EntrylineStyle);
           }
        }
     }
  }
//+------------------------------------------------------------------+

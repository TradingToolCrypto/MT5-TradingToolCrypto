/*

   https://github.com/TradingToolCrypto/MT5-TradingToolCrypto/blob/master/MQL5/Include/TradingToolCrypto/CBP/CryptoBridgeProClass.mqh

ROBOT
   - scan global variables for "Signal"
      - parse the signal information and make a market order on the exchange
      - only scan for a new signal on each new bar
USER
   - Setup the CRYPTO BRIDGE within the robot input tabs
      - select the exchange
      - select the market
      - select the contract size
      - select the Quote Digit ( not required if using market orders)
      - select the Volume Digit (to properly normalize the contract size)



*/
#property copyright "Copyright 2020, TradingToolCrypto Corp."
#property link      "https://github.com/tradingtoolcrypto"
#property version     "1.00"
#include <TradingToolCrypto\CBP\CryptoBridgeProClass.mqh>      // import the Crypto Bridge Class 
#include <TradingToolCrypto\TT\bars.mqh>                       // import new_bar function
CryptoBridge bridge;                                           // cryptoBridge class

/*
input group "TYPE IN THE ORDER TYPE"
input string Script_Open_Order = "NONE";
input string Order_Price = "12345";
*/
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {

   if(bridge.Init_Api_Keys(Exchange_Number))
     {
      Print("Api Keys Loaded");
     }

   string name_of_exchange = bridge.Get_Exchange_Name(Exchange_Number);

   Print("Trading on exchange: " + name_of_exchange);
   return (INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {
   /*

   scan for the global variable signals on each new bar

   */
   string trade_action = "NONE";
   if(new_bar(_Symbol, PERIOD_CURRENT))
     {
      trade_action =    scan_globals_for_signals("Signal","#");
     }


   if(trade_action == "NONE")
     {
      return;
     }





   if(trade_action == "SELL")
     {
      bridge.Open_Trade(Exchange_Symbol_Name,"SELL","MARKET",DoubleToString(Exchange_Lotsize,Exchange_Lot_Precision),  "",Exchange_Quote_Precision, Exchange_Lot_Precision,Exchange_Number,"");
     }



   if(trade_action == "BUY")
     {
      bridge.Open_Trade(Exchange_Symbol_Name,"BUY","MARKET",DoubleToString(Exchange_Lotsize,Exchange_Lot_Precision), "",Exchange_Quote_Precision, Exchange_Lot_Precision,Exchange_Number,"");
     }

   /*

      if(Script_Open_Order == "LIMIT_BUY")
        {
         bridge.Open_Trade(Exchange_Symbol_Name,"BUY","LIMIT",DoubleToString(Exchange_Lotsize,Exchange_Lot_Precision), Order_Price,Exchange_Quote_Precision, Exchange_Lot_Precision,Exchange_Number,"");
        }

      if(Script_Open_Order == "LIMIT_SELL")
        {
         bridge.Open_Trade(Exchange_Symbol_Name,"SELL","LIMIT",DoubleToString(Exchange_Lotsize,Exchange_Lot_Precision), Order_Price,Exchange_Quote_Precision, Exchange_Lot_Precision,Exchange_Number,"");
        }

      if(Script_Open_Order == "STOP_SELL")
        {
         bridge.Open_Trade_Stop(Exchange_Symbol_Name,"SELL","STOP_LOSS",DoubleToString(Exchange_Lotsize,Exchange_Lot_Precision), Order_Price,Exchange_Quote_Precision, Exchange_Lot_Precision,Exchange_Number,"");
        }

      if(Script_Open_Order == "STOP_BUY")
        {
         bridge.Open_Trade_Stop(Exchange_Symbol_Name,"BUY","STOP_LOSS",DoubleToString(Exchange_Lotsize,Exchange_Lot_Precision), Order_Price,Exchange_Quote_Precision, Exchange_Lot_Precision,Exchange_Number,"");
        }
    */

  }
/*

   Signal#BTCUSDT#15#SELL

   [0] = signal
   [1] = symbol
   [2] = timeframe
   [3] = direction

*/
string scan_globals_for_signals(string findItem, string hash)
  {

   string sep=hash;              // A separator as a character
   ushort u_sep;                  // The code of the separator character
   string result[];               // An array to get strings
   u_sep=StringGetCharacter(sep,0);

   int loop = GlobalVariablesTotal();
   string name="";
   int k=0;
   for(int i = 0; i<loop; i++)
     {
      name = GlobalVariableName(i);
      k=StringSplit(name,u_sep,result);

      /*
      found a global that matches our criteria
      GlobalVariableSet(sym+"#" + IntegerToString(Period()) + "#SELL", valueHigh);
      */
      if(result[0] == findItem)
        {
         /*
         
         parse the symbol name and match with the CryptoBridge Class
         
         CB_charts creates a unique suffix based on the exchange that we are charting such as BTCUSDT.bnf for BinanceFutures USDT market. 
         We will parse the suffix from this chart's symbol to return only BTCUSDT
         Then we will match this string with the Crypto Bridge input Exchange Symbol Name
         
         if we have a match we know we have an alert on the correct exchange. 
         
         */
         if(remove_suffix_from_symbol(result[1]) == Exchange_Symbol_Name)
           {
            /*
            Found the signal direction
            Delete the global to prevent duplicate signals
            */
            if(result[3] == "SELL")
              {
               GlobalVariableDel(name);
               return("SELL");

              }
            if(result[3] == "BUY")
              {
               GlobalVariableDel(name);
               return("BUY");
              }
           }
        }

     }
   return("NONE");
  }
//+------------------------------------------------------------------+

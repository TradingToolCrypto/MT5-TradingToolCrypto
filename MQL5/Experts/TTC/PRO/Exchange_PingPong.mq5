#property copyright "Copyright 2020, TradingToolCrypto Corp."
#property link      "https://github.com/tradingtoolcrypto"
#property description "Tools=> Options => ExpertAdvisors => Allow Webrequests"
#property description "Example of URL: https://fapi.biance.com"
#property description "You must make a payment with the Payment_Bot_Pro before using"
#property version "1.00"

#include <TradingToolCrypto\CBP\CryptoBridgeProClass.mqh>

/*
 Class name CryptoBridge 
 then create your own variable name to use the class 
 such as bridge
*/

CryptoBridge bridge;

string exchangename = "";

int OnInit()
{
   bridge.Init_Api_Keys(Exchange_Number);
   // What exchange are will trading at?
   exchangename = bridge.Get_Exchange_Name(Exchange_Number);
   EventSetMillisecondTimer(Exchange_Millisecond_RateLimiter);
   return (INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   //--- destroy timer
   EventKillTimer();
}
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTimer()
{
   /*
   Ping pong strategy
   */
   // api call to get the open orders
   if (!bridge.Get_OpenOrders(Exchange_Symbol_Name, Exchange_Number,Exchange_Quote_Precision))
   {
      Print("Failed to check OpenOrders");
   }
   else
   {
      // if any orders exist, they will be presented within the SubWindow Indicator
      bridge.Parse_Orders(exchangename, 640, 1040);
      Print("Parsing Open Orders if available");
   }

   // If any order exists, you can access the results within the arrays below
   int loop_orders = ArraySize(exchange_name);
   // if the array exchange_name has a value > 0 , then we have open orders
   if (loop_orders > 0)
   {
      for (int i = 0; i < loop_orders; i++)
      {
         Print("Symbol: " + exchange_symbol[i] +
               " Type: " + exchange_ordertype[i] +
               " Side: " + exchange_orderside[i] +
               " Price: " + DoubleToString(exchange_orderprice[i], Exchange_Quote_Precision) +
               " Volume: " + DoubleToString(exchange_ordersize[i], Exchange_Lot_Precision));
      }
   }
   else
   {
      Print(" No Orders exist: Processing Logic......");
      // no orders exist
      Sleep(1000);
      if (!bridge.Get_Position(Exchange_Symbol_Name, Exchange_Number, Exchange_Quote_Precision))
      {
         Print("Failed to check Get_Position");
      }
      else
      {
         // if any positions exist, they will be presented within the SubWindow Indicator
         bridge.Parse_Positions(exchangename, 275, 200, Exchange_Lot_Precision);
         Print("Parsing Positions if available");

         // If any positions exists, you can access the results within the arrays below
         int loop_positions = ArraySize(exchange_name_p);
         // if the array exchange_name_p has a value > 0 , then we have open positions
         if (loop_positions > 0)
         {
            for (int i = 0; i < loop_positions; i++)
            {
               Print("Symbol: " + exchange_symbol_p[i] +
                     " Side: " + exchange_orderside_p[i] +
                     " Price: " + DoubleToString(exchange_orderprice_p[i], Exchange_Quote_Precision) +
                     " Volume: " + DoubleToString(exchange_ordersize_p[i], Exchange_Lot_Precision));
            }
         }
         else
         {
            Print(" No Position exist: Processing Logic to do something......");
         }
      }

      // Leverage
      // maximum exposure
      // liq price
      // position size ( 1% per order)
      // takeprofit

      // grab the latest bid and ask prices
         double ask = 0, bid = 0, spread = 0;
         Sleep(1000);
         if (bridge.Get_PriceBest(Exchange_Symbol_Name, Exchange_Number, Exchange_Quote_Precision))
         {
            ask = GlobalVariableGet(exchangename + "_" + Exchange_Symbol_Name + "_Ask");
            bid = GlobalVariableGet(exchangename + "_" + Exchange_Symbol_Name + "_Bid");
            Print(" Bid: " + bid + " Ask: " + ask);
            if (ask != 0 && bid != 0)
            {
               spread = ask - bid;
            }
         }

         double entry_buy_price = NormalizeDouble(bid - spread, Exchange_Quote_Precision);
         if (bridge.Open_Trade(Exchange_Symbol_Name, "BUY", "LIMIT", Exchange_Lotsize, entry_buy_price,Exchange_Quote_Precision,Exchange_Lot_Precision, Exchange_Number))
         {
            Print(" Buy Limit Placed ");
         }

         Sleep(1000);

         double entry_sell_price = NormalizeDouble(ask + spread, Exchange_Quote_Precision);
         if (bridge.Open_Trade(Exchange_Symbol_Name, "SELL", "LIMIT", Exchange_Lotsize, entry_sell_price,Exchange_Quote_Precision,Exchange_Lot_Precision, Exchange_Number))
         {
            Print(" Sell Limit Placed ");
         }
   }
}

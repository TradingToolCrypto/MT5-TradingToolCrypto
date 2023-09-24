#property copyright "Copyright 2020, TradingToolCrypto Corp"
#property link "https://github.com/TradingToolCrypto"
#property version   "1.00"
/* CryptoBridgePro FrameWork Class variables

 cb.orderPending() 

 run this function to gather the values below

      string exchange_name[];
      string exchange_symbol[];
      string exchange_ordertype[];
      string exchange_orderside[];
      double exchange_orderprice[];
      double exchange_ordersize[];
      int    exchange_orderindex[];
      string    exchange_orderid[];
*/

#include <TradingToolCrypto/CBP/CBPFrameWork.mqh>
CBPFrameWork cb;// For Trading 
/*
   - class (RobotFrameWork) becomes an object and is imported within CBPFramework
   - give the class a pointer name (btc,bnb,etc)
*/
RobotFrameWork btc;// For Data aka charting,indicators,price values

input double RobotParamMaxBuyVolume = 20000;
input double RobotParamMaxSellVolume = 20000;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
   btc.Init_Symbol(Symbol() );
  
//---
   return(INIT_SUCCEEDED);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();
  }

//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
double LastPrice_Asset_A = 0;
void OnTick()
  {
   int API_CALLS = 0;
   bool trigger = false;
   double compare_Asset_A = btc.symbolAsk();
   double compare_Asset_AB = btc.symbolBid();
   double spr = compare_Asset_A - compare_Asset_AB;
   double fifty_Cents = btc.symbolPoint() * 5;
   double fiveDollars = fifty_Cents * 10;
   double tenDollars =  fiveDollars * 2;
   double fiftyDollars = tenDollars * 5;
   if(LastPrice_Asset_A != compare_Asset_A)
     {
      LastPrice_Asset_A = compare_Asset_A;
      trigger = true;
     }
   if(trigger)
     {
      //--- Only Run Logic when the price is changing
      // get positions
      int loop = cb.orderPending();
      API_CALLS ++;
      for(int i = 0; i < loop; i++)
        {
        }
      int bids = cb.orderPendingLimitLong;
      int asks = cb.orderPendingLimitShort;
      Print("BID # | " + bids + " |  ASK # | " + asks);
      if(loop > 0 && bids > 0)
        {
         cb.tradeDeleteAll(true);
         API_CALLS ++;
        }
      else
         if(asks > 0)
           {
            cb.tradeDeleteAll(false);
            API_CALLS ++;
           }
      // MAKE A BUY POSITION
      if(cb.positionTotal() && cb.position_avg_price_buy != 0)
        {
         if(cb.position_avg_price_buy > compare_Asset_A && cb.position_volume_buy < RobotParamMaxBuyVolume)
           {
            // only average in BUYS
            API_CALLS ++;
            cb.tradeBid(Exchange_Lotsize);
            API_CALLS ++;
            cb.tradeBid(Exchange_Lotsize * 2, compare_Asset_AB - fiveDollars);
            API_CALLS ++;
            /*
            cb.tradeBid(Exchange_Lotsize * 3, compare_Asset_AB - tenDollars);
            API_CALLS ++;
            cb.tradeBid(Exchange_Lotsize * 4, compare_Asset_AB - tenDollars * 2);
            API_CALLS ++;
            */
            runOrderPending();// Add the Order Lines on the Chart
            API_CALLS ++;
           }
         // Only Scale Out with Sell limits at Profit
         if(cb.position_avg_price_buy < compare_Asset_AB)
           {
            cb.tradeAsk(Exchange_Lotsize);
            API_CALLS++;
            cb.tradeAsk(Exchange_Lotsize * 2, compare_Asset_A + fiveDollars);
            API_CALLS++;
            /*
            cb.tradeAsk(Exchange_Lotsize * 3, compare_Asset_A + tenDollars);
            API_CALLS++;
            cb.tradeAsk(Exchange_Lotsize * 4, compare_Asset_A + tenDollars * 2);
            API_CALLS++;
            */
            runOrderPending();// Add the Order Lines on the Chart
            API_CALLS ++;
           }
        }
      // SELL POSITION
      if(cb.positionTotal() && cb.position_avg_price_sell != 0)
        {
         if(cb.position_avg_price_sell > compare_Asset_AB)
           {
            // scale out in profit only
            API_CALLS ++;
            cb.tradeBid(Exchange_Lotsize);
            API_CALLS ++;
            cb.tradeBid(Exchange_Lotsize * 2, compare_Asset_AB - fiveDollars);
            API_CALLS ++;
            /*
            cb.tradeBid(Exchange_Lotsize * 3, compare_Asset_AB - tenDollars * 2);
            API_CALLS ++;
            cb.tradeBid(Exchange_Lotsize * 4, compare_Asset_AB - tenDollars * 3);
            API_CALLS ++;
            */
            runOrderPending();// Add the Order Lines on the Chart
            API_CALLS ++;
           }
         //
         if(cb.position_avg_price_sell < compare_Asset_A && cb.position_volume_sell <  RobotParamMaxSellVolume)
           {
            cb.tradeAsk(Exchange_Lotsize);
            API_CALLS++;
            cb.tradeAsk(Exchange_Lotsize * 2, compare_Asset_A + fiveDollars);
            API_CALLS++;
            /*
            cb.tradeAsk(Exchange_Lotsize * 3, compare_Asset_A + tenDollars * 2);
            API_CALLS++;
            cb.tradeAsk(Exchange_Lotsize * 4, compare_Asset_A + tenDollars * 3);
            API_CALLS++;
            */
            runOrderPending();// Add the Order Lines on the Chart
            API_CALLS ++;
           }
        }
     }
   if(API_CALLS > 0)
     {
      Print("API CALLS THIS LOOP " + (string) API_CALLS);
     }
  }
//+------------------------------------------------------------------+
void runOrderPending()
  {
   if(cb.orderPending() > 0)
     {
      int loopOrders =  ArraySize(exchange_name) ;
      for(int i = 0; i < loopOrders; i++)
        {
         Print(" Order Details : " + exchange_orderprice[i] + " | " + exchange_symbol[i] + " | " + exchange_ordersize[i]
               + " | " + exchange_orderside[i]);
        }
     }
  }
//+------------------------------------------------------------------+

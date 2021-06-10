//+------------------------------------------------------------------+
//|                                                 PumpBot_v1.0.mq5 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, TradingToolCrypto Corp"
#property link "https://github.com/TradingToolCrypto"
#property version "1.00"

#include <TradingToolCrypto\CBP\CBPFrameWork.mqh>
#include <TradingToolCrypto\TT\RobotFrameWork.mqh>
#include <TradingToolCrypto\TT\bars.mqh>
#include <TradingToolCrypto\TT\IndicatorPlus.mqh>

RobotFrameWork mt5;
CBPFrameWork cb;
IndicatorPlus indi;

input ENUM_TIMEFRAMES IntervalForPump = PERIOD_CURRENT;
input group "Move Price requires CB_Charts OrderBook data";
input bool MovePrice = false;
input group "Decide to Buy or Sell";
input bool OnlyLong = false;
input bool OnlyShort = false;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   EventSetTimer(60);
   const string sym = Symbol();
   indi.Init_IndicatorPlus(sym);

   if(MovePrice){
    if(!MarketBookAdd(sym))
     {
      Print("Initization Error: Something is wrong with collecting the MarketBookAdd()");
      return (INIT_FAILED);
     }
   }
  
//---
   return(INIT_SUCCEEDED);
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
//|                                                                  |
//+------------------------------------------------------------------+
void OnTimer()
  {

   if(MovePrice){
    if(index_best_ask == 0 || index_best_bid == 0)
     {
      Print("Can not run the main the loop because the Orderbook is not correct");
      return;
     }
   }
  
   /*
   indicator logic 
   */
   const double rsi = indi.get_rsi(1);

   if(new_bar(Symbol(),IntervalForPump))
     {
      if(OnlyLong && rsi < RSI_SELL)
        {
         if(MovePrice)
           {
            double volume = book[index_best_ask].volume_real;
            cb.tradeBuy(volume);
           }
         else
           {
            cb.tradeBuy(Exchange_Lotsize);
           }
        }
      if(OnlyShort && rsi > RSI_BUY)
        {
         if(MovePrice)
           {
            double volume = book[index_best_bid].volume_real;
            cb.tradeSell(volume);
           }
         else
           {
            cb.tradeSell(Exchange_Lotsize);
           }
        }
     }
  }

//+------------------------------------------------------------------+
//| BookEvent function                                               |
//+------------------------------------------------------------------+
MqlBookInfo book[];
int index_best_ask = 0;
int index_best_bid = 0;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnBookEvent(const string &symbol)
  {
// reset the orderbook index
   index_best_ask = 0;
   index_best_bid = 0;
   int Sell_Volume_Total = 0;
   int Buy_Volume_Total = 0;
//Returns a structure array MqlBookInfo containing records of the Depth of Market of a specified symbol.
   if(!MarketBookGet(symbol, book))
     {
      printf("Failed load market book price. Reason: " + (string)GetLastError());
      return;
     }
// what is the size of the book array?
   int size = ArraySize(book);
   if(size < 1)
     {
      printf("Failed load market book price. Reason: " + (string)GetLastError());
      return;
     }
   /*
    Find the Best Bid index and the Best Ask index
    ensure that we start counting at 1, to prevent the array out of index
   */
   for(int i = 1; i < size; i++)
     {
      if(book[i - 1].type == BOOK_TYPE_SELL && book[i].type == BOOK_TYPE_BUY)
        {
         index_best_ask = i - 1;
         index_best_bid = i;
        }
     }
  }
//+------------------------------------------------------------------+
//| Tester function                                                  |
//+------------------------------------------------------------------+
double OnTester()
  {
//---
   double ret=0.0;
//---

//---
   return(ret);
  }
//+------------------------------------------------------------------+
//| TesterInit function                                              |
//+------------------------------------------------------------------+
void OnTesterInit()
  {
//---

  }
//+------------------------------------------------------------------+
//| TesterPass function                                              |
//+------------------------------------------------------------------+
void OnTesterPass()
  {
//---

  }
//+------------------------------------------------------------------+
//| TesterDeinit function                                            |
//+------------------------------------------------------------------+
void OnTesterDeinit()
  {
//---

  }
//+------------------------------------------------------------------+

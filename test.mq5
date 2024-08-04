/*
 Im trying to draw channels

 - bullish channel that captures a previous low and points up
 - bearish channel that captures a previous high and points down


 - bugs
 some times the algo will draw a channel where current price has already broken out
 - so right now, the object will be deleted immediately after creation

this means its possible to not have any lines on the chart

Feb 6

- if price is within the current channel, do not redraw a new channel

Feb 10
- make a new buttom for the channel pattern
- too many signals : draw horizontal line at each signal and count the signals

way too many signals
- signals for wedge : range
- signals for breakout
and a filter that prevents switching signals every bar

if pattern is wedge : wait for breakout :
if pattern is breakout :
A : if bullishh, dont redraw lines

v4.00
- change the logic just to the line creation of bullish or bearish for logical testing

- Feb 18,
- change the core logic to use the lines for entry and exits and not use the patterns
- base the entries on the possible R:R  : what channel is bigger, larger TP , better setup
- use the channel width for TP2 and half of width for TP1


notes : impossible for perfect entry ==> a tight stoploss.

feb 21 , 2024 : new thoughts , dont go for the big profits for this strategy, just a 1 : 1 is fine. or 2 to 1 with small stop

objects on the chart with values that we need for logic operations

Channel_Top_Slope

AUGUST 2024 

4th : adjust with width : make it smaller: it never works atm


*/
#property copyright "Copyright 2020, TradingToolCrypto Corp"
#property link "https://github.com/TradingToolCrypto"
#property version "0.70"

#include <TradingToolCrypto\CBP\CBPFrameWork.mqh>
#include <TradingToolCrypto\TT\RobotFrameWork.mqh>
#include <TradingToolCrypto\TT\bars.mqh>
#include <TradingToolCrypto\TT\IndicatorPlus.mqh>
#include <TradingToolCrypto/TT/utilities.mqh>// include create_objects 

RobotFrameWork mt5;
//CBPFrameWork cb;
IndicatorPlus indi;

input ENUM_TIMEFRAMES IntervalForPump = PERIOD_CURRENT;

// rename this to enable Orderbook if its used later
// must be used with CB_CryptoCharts robots
input group "Move Price requires CB_Charts OrderBook data";
input bool MovePrice = false;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
input group "Trading Futures or Spot Exchange (Different Logic)";
input bool FuturesTrading = false;


input group "Decide to Buy or Sell";
input bool OnlyLong = false;
input bool OnlyShort = false;

input group "Decide to Close Buy or Sell based on logic";
input bool ClosingLogicIsOn = true;

input group "If values > 0 then use TP and/or SL ";
input double SL_Value = 0;
input double TP_Value = 0;


input group "MT5 Brokerages: allow trading";
input bool BackTesting = true;
input double Brokerage_Lotsize = 0.1;
input group "Averaging: every strategy needs a good trade management system";
input double Brokerage_Lotsize_Maximum = 50;

input color BullishChannelColor = clrLightBlue;
input color BearishChannelColor = clrLightPink;

input group "--- BackTesting | Optimization  ---"
input int MinWaveValueInput = 25;
input int  MAX_BARS_SLOW = 2000;
input bool SHOW_PATTERNS = false;

input double  MAX_ENTRY_DEVIATION = 0.001;
input double  MAX_TRAILING_SL_DEVIATION = 0.001;
input bool    AVERAGE_LOSERS = false;
input double  MAX_AVERAGEING_DEVIATION = 0.001;

input group "--- Filters |Channel Width "
input double CHANNEL_BULL_MIN_WIDTH = 0.01;
input double CHANNEL_BULL_MAX_WIDTH = 1.5;

input double CHANNEL_BULL_MIN_SLOPE = 0.01;
input double CHANNEL_BULL_MAX_SLOPE = 1.5;

input double CHANNEL_BEAR_MIN_WIDTH = 0.01;
input double CHANNEL_BEAR_MAX_WIDTH = 1.5;

input double CHANNEL_BEAR_MIN_SLOPE = 0.01;
input double CHANNEL_BEAR_MAX_SLOPE = 1.5;

input group "--- Filters | Risk Reward  "
input double MIN_RISK_REWARD = 1;

string sym;
int  MAX_BARS_FAST = 500;


input bool AUTO_LOOKBACK = true;
input int LOOKBACK = 2;


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {

   DeleteSubWindowObjectAll(0,0);
   DeleteSubWindowObjectAll(0,1);

   sym = Symbol();
   indi.Init_IndicatorPlus(sym);

   mt5.Init_Symbol(sym);

   ButtonsBuySell(HD_Screen, "Remove", "Add", "Delete");



   if(HD_Screen)
     {
      int x_a = 500;
      int y_a = 40;
      int width_ = 0;
      int height_ = 0;
      int font_size = HD_Text;
      string font_style = "Arial Bold";

      if(font_size == 7)
        {
         y_a = 20;
         font_style ="Arial";
        }

      if(font_size == 8)
        {
         y_a = 30;
        }

      if(font_size == 9)
        {
         y_a = 40;
        }

      width_ =x_a;
      height_ = y_a;

      //pattern "P" button
      ObjCreateButton("Channel_Pattern$",false,
                      x_a
                      ,y_a, 20,height_,"P",
                      clrDarkBlue,clrWhite,0,CORNER_RIGHT_LOWER,font_size,
                      font_style,0,false,OBJ_ALL_PERIODS);


      ObjCreateButton("Channel_Pattern",false,
                      x_a-20,
                      y_a,
                      width_-20,height_,"PATTERN",
                      clrGray,clrWhite,0,CORNER_RIGHT_LOWER,font_size,
                      font_style,0,false,OBJ_ALL_PERIODS);


      //top = bearish
      ObjCreateButton("Channel_Width_Top$",false,
                      x_a*3 + 20,
                      y_a, 20,height_,"T",
                      clrDarkBlue,clrWhite,0,CORNER_RIGHT_LOWER,font_size,
                      font_style,0,false,OBJ_ALL_PERIODS);

      ObjCreateButton("Channel_Width_Top",false,
                      x_a*3,
                      y_a, width_/2,height_,"top",
                      clrGray,clrWhite,0,CORNER_RIGHT_LOWER,font_size,
                      font_style,0,false,OBJ_ALL_PERIODS);

      ObjCreateButton("Channel_Top_Slope",false,
                      x_a*2 +(x_a/2),
                      y_a, width_/2,height_,"top",
                      clrGray,clrWhite,0,CORNER_RIGHT_LOWER,font_size,
                      font_style,0,false,OBJ_ALL_PERIODS);


      //bottom = bullish channel
      ObjCreateButton("Channel_Width_Bottom$",false,x_a+width_+20,
                      y_a, 20,height_,"B",
                      clrDarkBlue,clrWhite,0,CORNER_RIGHT_LOWER,font_size,
                      font_style,0,false,OBJ_ALL_PERIODS);



      ObjCreateButton("Channel_Width_Bottom",false,x_a+width_
                      ,y_a, width_/2,height_,"bottom",
                      clrGray,clrWhite,0,CORNER_RIGHT_LOWER,font_size,
                      font_style,0,false,OBJ_ALL_PERIODS);

      ObjCreateButton("Channel_Bottom_Slope",false,
                      x_a +(x_a/2)
                      ,y_a, width_/2,height_,"bottom",
                      clrGray,clrWhite,0,CORNER_RIGHT_LOWER,font_size,
                      font_style,0,false,OBJ_ALL_PERIODS);


     }
   else  //fix
     {
      int x_a = 500;
      int y_a = 40;
      int width_ = x_a;
      int height_ = y_a;
      int font_size = 9;
      ObjCreateButton("Channel_Pattern",false,x_a,y_a, width_,height_,"PATTERN",
                      clrBisque,clrBlack,0,CORNER_RIGHT_LOWER,font_size,
                      "Arial Bold",0,false,OBJ_ALL_PERIODS);

     }


// DRAW LINES : draw channels for top and bottom
   logic();


   if(Exchange_Lotsize)
     {
      // inits already  cb ==>  CBPFrameWork();
     }

   if(MovePrice)
     {
      if(!MarketBookAdd(sym))
        {
         Print("Initization Error: Something is wrong with collecting the MarketBookAdd()");
         return (INIT_FAILED);
        }
     }

// EventSetTimer(1);

   Comment("");

//---
   return(INIT_SUCCEEDED);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {


   if(BackTesting)
     {
      mt5.positionTotal();
     }

   if(FuturesTrading)
     {
      //  cb.positionTotal();
     }



   if(MovePrice)
     {
      if(index_best_ask == 0 || index_best_bid == 0)
        {
         Print("Can not run the main the loop because the Orderbook is not correct");
         return;
        }
     }

// Symbol is the attached chart that the robot is selected to : doesn't matter in this case'
   if(new_bar(Symbol(),IntervalForPump))
     {

      mt5.positionTotal();
      double bid = mt5.symbolBid();

      logic();

      // ALL percentages of price for calculations to prevent points : bps : etc
      double averaging_distance = bid * MAX_AVERAGEING_DEVIATION; //

      double min_channel = bid *CHANNEL_BULL_MIN_WIDTH;
      double max_channel = bid *CHANNEL_BULL_MAX_WIDTH;

      double min_channel_bear = bid *CHANNEL_BEAR_MIN_WIDTH;
      double max_channel_bear = bid *CHANNEL_BEAR_MAX_WIDTH;



      double  top_channel_width = StringToDouble(ChannelsWidth("top1"));
      double  bottom_channel_width = StringToDouble(ChannelsWidth("bottom1"));

      double  top_channel_price = ChannelsTrendlineValue("top1");
      double  bottom_channel_price = ChannelsTrendlineValue("bottom1");

      double top_deviation_price = ChannelsDeviationlineValue("top1");
      double bottom_deviation_price = ChannelsDeviationlineValue("bottom1");

      double sl_deviation = bid * MAX_TRAILING_SL_DEVIATION;

      double entry_deviation = bid * MAX_ENTRY_DEVIATION;

      // new idea
      string get_label_of_bearchannel = ObjectGetString(0,"Channel_Top_Slope",OBJPROP_TEXT,0);
      double slope_bear = StringToDouble(get_label_of_bearchannel);

      string get_label_of_bullchannel = ObjectGetString(0,"Channel_Bottom_Slope",OBJPROP_TEXT,0);
      double slope_bull = StringToDouble(get_label_of_bullchannel);

      // create tp 1+2 with default
      double buy_tp1 = 0;
      double buy_tp2 = 0;
      double buy_sl1 = 0;

      if(top_channel_price > bid)// some time this is not the case
        {
         buy_tp1 = (top_channel_price - bid)/2;// Midpoint of channel
         buy_tp2 = buy_tp1*2;;// Full channel width
        }
      /*

           else  // use the bull channel dev line for tp
             {
              if(bottom_deviation_price > bid)
                {
                 buy_tp1 = (bottom_deviation_price - bid)/2;
                 buy_tp2 =  bottom_deviation_price - bid;
                }
             }
      */

      // based on the TP , now define the stoploss using the risk reward
      buy_sl1 = buy_tp1 / MIN_RISK_REWARD;

      // One Trade Only
      if(!AVERAGE_LOSERS)
        {
         if(OnlyLong
            // && SIGNAL_BUY >= 0
            //  && logic_channel(false,"bottom1")=="BUY"  // Near the bottom of the channel
            //   && tp < tpSell // ensure the channel is bigger than sell channel
            && mt5.position_volume_buy == 0

            //  && min_channel < bottom_channel_width
            //  &&  bottom_channel_width < top_channel_width

            && bid <= top_deviation_price + entry_deviation

            // since we are buying on the bearish down channel, ensure the width is large
            && top_channel_width > bid * CHANNEL_BEAR_MIN_WIDTH

            && CHANNEL_BEAR_MIN_SLOPE < slope_bear
            /*
              && mt5.symbolLowest(1) > bid
              && mt5.symbolLowest(5) > bid
              && mt5.symbolLowest(15) > bid
              && mt5.symbolLowest(30) < bid

              && mt5.symbolBarBull(1)
              && !mt5.symbolBarBull(2)
            */


           )
           {


            mt5.tradeBuy(Brokerage_Lotsize,bid+buy_tp1,bid-buy_sl1);//bid+tp,bid-sl
            //  mt5.tradeBuy(Brokerage_Lotsize,bid+buy_tp2,bid-buy_sl1);//bid+tp,bid-sl

           }
        }


      if(AVERAGE_LOSERS)
        {
         // LONG && mt5.position_volume_sell == 0 // No sell positions exist
         if(OnlyLong
            // && SIGNAL_BUY >= 0
            && logic_channel(false,"bottom1")=="BUY"  // Near the bottom of the channel
            //   && tp < tpSell // ensure the channel is bigger than sell channel
            && !mt5.symbolBarBull(1)



           )
           {

            if(mt5.position_volume_buy>0)
              {
               // make sure to average losers only
               if(bid< mt5.position_avg_price_buy-averaging_distance)
                 {
                  //   cb.tradeBuy(Exchange_Lotsize);
                  if(mt5.position_volume_buy<Brokerage_Lotsize_Maximum)
                    {

                     mt5.tradeBuy(Brokerage_Lotsize,bid+buy_tp1,0);//bid+tp,bid-sl
                     mt5.tradeBuy(Brokerage_Lotsize,bid+buy_tp2,0);//bid+tp,bid-sl
                    }
                 }
              }
            else
              {
               // first trade
               mt5.tradeBuy(Brokerage_Lotsize,bid+buy_tp1,0);//bid+tp,bid-sl
               mt5.tradeBuy(Brokerage_Lotsize,bid+buy_tp2,0);//bid+tp,bid-sl

              }
           }

        }

      // SHORT
      if(OnlyShort && mt5.position_volume_buy == 0
         //  && SIGNAL_SELL >= 0
         && logic_channel(true,"top1")=="SELL"  // Near the bottom of the channel
         //  && tpSell < tp
        )
        {
         // cb.tradeSell(Exchange_Lotsize);
         if(mt5.position_volume_sell<Brokerage_Lotsize)
           {
            mt5.tradeSell(Brokerage_Lotsize, 0,0);
            mt5.tradeSell(Brokerage_Lotsize, 0,0);
           }
        }





      mt5.positionTotal();


      // close buys at top of the bullish channel
      if(bid>= bottom_deviation_price-entry_deviation && mt5.position_volume_buy > 0)
        {

         Print("CLOSE BUYS AT PROFIT");
         mt5.tradeClose(true);// close buys

        }

      /*
            if(bid> top_channel_price+entry_deviation && mt5.position_volume_buy > 0)
              {

               Print("CLOSE BUYS AT PROFIT");
               mt5.tradeClose(true);// close buys

              }
      */

      /*
            if(bid  <bottom_channel_price-entry_deviation && mt5.position_volume_buy > 0)
              {

               Print("CLOSE BUYS AT LOSS");
               mt5.tradeClose(true);// close buys

              }
      */
      // move sl, trailing stoploss using the trendlines

      // not at profit
      /*
      if(mt5.position_volume_buy > 0 && bid < mt5.position_avg_price_buy)
        {

         mt5.tradeModifyFixedReduce(true,bottom_channel_price-sl_deviation);
        }
      // at profit>sl_dev but TL below entry
      // move to Breakeven
      if(mt5.position_volume_buy > 0 && bid-sl_deviation > mt5.position_avg_price_buy && bottom_channel_price < mt5.position_avg_price_buy)
        {

         mt5.tradeModifyFixedReduce(true,mt5.position_avg_price_buy);
        }
      bool top_ok =  false;
      if(logic_channel(true,"top1")=="SELL")
        {
         top_ok=true;
        }

      if(mt5.position_volume_buy > 0 && !top_ok) //&& bid-sl_deviation > mt5.position_avg_price_buy && bottom_channel_price > mt5.position_avg_price_buy
        {

         mt5.tradeModifyFixedReduce(true,bottom_channel_price-sl_deviation);
        }
      */


      // first SL
      if(AVERAGE_LOSERS)
        {
         //#2  breakeven SL, trailing
         if(mt5.position_volume_buy > 0
            && bottom_channel_price > mt5.position_avg_price_buy
            && bottom_channel_price+sl_deviation < mt5.position_avg_price_buy)
           {
            mt5.tradeModifyFixedReduce(true,bottom_channel_price);

           }

         //#2  breakeven SL, trailing
         if(mt5.position_volume_buy > 0
            && bottom_channel_price> mt5.position_avg_price_buy-sl_deviation)
           {
            mt5.tradeModifyFixedReduce(true,bottom_channel_price+sl_deviation);

           }
        }
      /*
      else
      {
       if(mt5.position_volume_buy > 0

         )
         {

          mt5.tradeModifyFixedReduce(true,bottom_channel_price-sl_deviation);
         }
      }
      */





      /*
            if(mt5.position_volume_sell==Brokerage_Lotsize)
              {
               // mt5.tradeModifyTrailing(false,mt5.position_avg_price_sell);
               mt5.tradeModifyFixedReduce(false,mt5.position_avg_price_sell);

              }
            if(mt5.position_volume_buy==Brokerage_Lotsize)
              {
               //  mt5.tradeModifyTrailing(true,mt5.position_avg_price_buy);
               mt5.tradeModifyFixedReduce(true,mt5.position_avg_price_buy);

              }
        */

      /*
            if(ClosingLogicIsOn)
              {

               if(ok_buy_close>=0)
                 {
                  Print("CLOSE BUYS ");
                  mt5.tradeClose(true);// close buys
                 }

               if(ok_sell_close>=0)
                 {
                  Print("CLOSE SELLS ");
                  mt5.tradeClose(false);// close sells
                 }
              }
      */

     }// end new bar


   double tp;
   double sl;

   bool FlipAtSL = false;

// Close orders at TP and SL with market orders : MT5 brokerages (limits are useless)

   /*

      if(mt5.position_volume_buy> 0)
        {

         if(TP_Value>0)
           {
            tp = mt5.symbolPoint() * TP_Value;

            if(mt5.position_avg_price_buy < mt5.symbolBid() - tp)
              {

               mt5.tradeClose(true);
               //   mt5.tradeBuy(Brokerage_Lotsize*2);
              }
           }
         if(SL_Value>0)
           {
            sl = mt5.symbolPoint() * SL_Value;


            if(mt5.position_avg_price_buy > mt5.symbolBid() + sl)
              {
               mt5.tradeClose(true);
               if(FlipAtSL)
                  mt5.tradeSell(Brokerage_Lotsize);

              }


           }

        }
      if(mt5.position_volume_sell> 0)
        {
         if(TP_Value>0)
           {
            tp = mt5.symbolPoint() * TP_Value;
            if(mt5.position_avg_price_sell > mt5.symbolAsk() + tp)
              {
               mt5.tradeClose(false);
              }
           }
         if(SL_Value>0)
           {
            sl = mt5.symbolPoint() * SL_Value;
            if(mt5.position_avg_price_sell < mt5.symbolAsk() - sl)
              {
               mt5.tradeClose(false);
               if(FlipAtSL)
                  mt5.tradeBuy(Brokerage_Lotsize);

              }

           }


   }

   */

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

int GLOBAL_SIGNAL_COUNT = 0;
string GLOBAL_SIGNAL_LAST = "";

//+------------------------------------------------------------------+
//|                                                                  |
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

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnChartEvent(const int idc,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
   runChartEvent(idc,lparam,dparam,sparam);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void runChartEvent(const int id,
                   const long &lparam,
                   const double &dparam,
                   const string &sparam)
  {




   if(id==CHARTEVENT_OBJECT_CLICK)
     {

      if(sparam=="Buy_EX")
        {

         Print("buttons ");
         ResetLastError();
         user_action_add();
         ObjEditTextField("Close_EX","Delete" + GLOBAL_CHANNELS);
         ObjectSetInteger(0,sparam,OBJPROP_STATE,false);

        }

      if(sparam=="Sell_EX")
        {
         Print("buttons ");
         ResetLastError();

         user_action_remove();
         ObjEditTextField("Close_EX","Delete" + GLOBAL_CHANNELS);

         ObjectSetInteger(0,sparam,OBJPROP_STATE,false);

        }

      if(sparam=="Close_EX")
        {
         Print("buttons ");
         ResetLastError();

         ObjectsDeleteAll(0,-1,-1);
         // Reset
         GLOBAL_CHANNELS = 0;
         // add buttons again
         ButtonsBuySell(HD_Screen,"Remove", "Add", "Delete");

         ObjectSetInteger(0,sparam,OBJPROP_STATE,false);

        }
     }
  }

datetime global_time_now = 0;
void check_new_day()
  {

   static datetime last_check_time = 0;
   global_time_now = TimeLocal();
   if(global_time_now > last_check_time)
     {
      last_check_time = global_time_now + 86400;
      user_action_add_backtest(-1,-1);

     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int GLOBAL_CHANNELS = 0;
void user_action_add()
  {
   GLOBAL_CHANNELS++;
   CreateChannelBasedOnZig(MinWaveValueInput,"top"+GLOBAL_CHANNELS, "money",true, GLOBAL_CHANNELS, 1+GLOBAL_CHANNELS,BullishChannelColor, BearishChannelColor, 1);
   CreateChannelBasedOnZig(MinWaveValueInput,"bottom"+GLOBAL_CHANNELS, "money",false, GLOBAL_CHANNELS, 1+GLOBAL_CHANNELS, BullishChannelColor,BearishChannelColor, 1);
   Print("Channels creates ", GLOBAL_CHANNELS);
   ChartRedraw(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void user_action_remove()
  {
   ObjectDelete(0,"top"+GLOBAL_CHANNELS);
   ObjectDelete(0,"bottom"+GLOBAL_CHANNELS);
   Print("Channels deleted ", GLOBAL_CHANNELS);
   if(GLOBAL_CHANNELS>=1)
     {
      GLOBAL_CHANNELS--;
     }
   ChartRedraw(0);
  }
/*
Function exists for backtesting in visual mode, otherwise the user would initiate the first set of lines
- input allows a conditional filter to be applied to whether or not redraw the channel.
- - currently used as a way to keep the current channel if price stays inside it
*/
// if true draw the line
void user_action_add_backtest(int top, int bottom)
  {
// if true, price is inside the channels and we don't need to update them'
   if(top == -1)
     {

      if(AUTO_LOOKBACK)
        {

         for(int x= 0;x<LOOKBACK;x++)
           {
            user_action_add();
           }
        }

      CreateChannelBasedOnZig(MinWaveValueInput,"top"+1, "money",true, 1, 2,BullishChannelColor, BearishChannelColor, 3);


     }

   if(bottom==-1)
     {

      if(AUTO_LOOKBACK)
        {

         for(int x= 0;x<LOOKBACK;x++)
           {
            user_action_add();
           }
        }

      CreateChannelBasedOnZig(MinWaveValueInput,"bottom"+1, "money",false, 1, 2, BullishChannelColor,BearishChannelColor, 3);

     }

   ChartRedraw(0);

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool does_channel_exist()
  {
   const datetime now = iTime(sym,PERIOD_CURRENT,0);
   double linepriceNowA;
   double linepriceNowB;
   if(ObjectFind(0, "top1") != -1)
     {
      linepriceNowA = ObjectGetValueByTime(0,"top1",now, 0);
     }
   if(ObjectFind(0, "bottom1") != -1)
     {
      linepriceNowB = ObjectGetValueByTime(0,"bottom1",now, 0);
     }
   if(linepriceNowA!= 0 && linepriceNowB!= 0)
     {
      return true;
     }
   return false;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string logic_channel(bool isHigh, string name)
  {

   const datetime now = iTime(sym,PERIOD_CURRENT,0);
   double linepriceNowA;
   double linepriceNowB;
   double price;
   double price_bar;
   double point_one;
   if(ObjectFind(0, name) != -1)
     {


      if(!isHigh)
        {
         linepriceNowA = ObjectGetValueByTime(0,name,now, 0);
         linepriceNowB = ObjectGetValueByTime(0,name,now, 1);
         price = SymbolInfoDouble(Symbol(), SYMBOL_BID);
         price_bar = mt5.symbolLow(1);
         point_one = price *MAX_ENTRY_DEVIATION;
         // add buffer
         if(linepriceNowA <= price && price < linepriceNowA + point_one)
           {
            // the bottom channel
            return("BUY");
           }
         if(linepriceNowA <= price_bar && price_bar < linepriceNowA + point_one)
           {
            // the bottom channel
            return("BUY");
           }
        }
      if(isHigh)
        {
         linepriceNowA = ObjectGetValueByTime(0,name,now, 0);
         linepriceNowB = ObjectGetValueByTime(0,name,now, 1);
         price = SymbolInfoDouble(Symbol(), SYMBOL_BID);
         price_bar = mt5.symbolHigh(1);
         point_one = price *MAX_ENTRY_DEVIATION;
         if(linepriceNowA >= price && price > linepriceNowA - point_one
            && linepriceNowA != 0) //linepriceNowA < price ||
           {
            // top
            return("SELL");
           }
         if(linepriceNowA >= price_bar && price_bar > linepriceNowA - point_one
            && linepriceNowA != 0) //linepriceNowA < price ||
           {
            // top
            return("SELL");
           }
        }
     }
   return("NONE");
  }


/*
 Improve this function : this is the most important

 have two version of the channel deviation values
*/
void CreateChannelBasedOnZig(int minWave, string name, string desc,bool isHigh, int start, int end, color isColorBullish,color isColorBearish, int line_thick)
  {


   end = OptimizeLookback(isHigh, start, end, minWave);

// HH : ZIG : find highs
   if(isHigh)
     {
      datetime low_date_x_1 =  indi.get_zig_date(MAX_BARS_SLOW,start);
      datetime low_date_x_2 =  indi.get_zig_date(MAX_BARS_SLOW,end);
      double low_x_1 = indi.get_zig_direction(MAX_BARS_SLOW,start);
      double low_x_2 = indi.get_zig_direction(MAX_BARS_SLOW,end);
      // new feature : MiniumumWaveDistance
      int bars =  BarsBetweenTimestamps(low_date_x_1, low_date_x_2);
      int sec = PeriodSeconds(PERIOD_CURRENT);

      // NEW IDEA : bars * seconds /60 = minutes is the unit
      int minutes = (bars * sec)/60;
      double rise = MathAbs(low_x_2- low_x_1); //bull channel , start is lower

      string slope = channelAngles(minutes,rise);
      ObjEditTextField("Channel_Top_Slope", slope) ;






      datetime delay2x_end_point_date = low_date_x_2-(bars*2)*sec;//  delay2x_end_point_date, low_x_2,

      // create a better width of the channel
      double ll = mt5.symbolLowest(bars);
      if(low_x_2 != 0 && low_x_1 != 0 && bars >minWave)
        {

         double diff = low_x_2 - low_x_1;
         ObjCreateChannelLine(name, desc,
                              low_date_x_1, low_x_1,
                              low_date_x_2, low_x_2,
                              low_date_x_2, ll,  isColorBearish, line_thick, STYLE_DOT);// resistance
        }

      // deleteTheChannel(true, "TOP_"+name);
     }
   else // LOWS
     {

      datetime low_date_x_1 =  indi.get_zag_date(MAX_BARS_SLOW,start);
      datetime low_date_x_2 =  indi.get_zag_date(MAX_BARS_SLOW,end);

      double low_x_1 = indi.get_zag_direction(MAX_BARS_SLOW,start);
      double low_x_2 = indi.get_zag_direction(MAX_BARS_SLOW,end);

      // new feature : MiniumumWaveDistance
      int bars =  BarsBetweenTimestamps(low_date_x_1, low_date_x_2);

      // bars = bars*2;

      int sec = PeriodSeconds(PERIOD_CURRENT);

      // NEW IDEA : bars * seconds /60 = minutes is the unit
      int minutes = (bars * sec)/60;
      double rise = MathAbs(low_x_1- low_x_2); //bull channel , start is lower
      string slope = channelAngles(minutes,rise);
      ObjEditTextField("Channel_Bottom_Slope", slope) ;

      //  datetime mid_point_date = low_date_x_2-bars*sec;//  mid_point_date, low_x_2, isColorBullish,


      // create a better width of the channel
      double hh = mt5.symbolHighest(bars);


      if(low_x_2 != 0 && low_x_1 != 0 && bars >minWave)
        {

         double diff = low_x_1 - low_x_2;
         ObjCreateChannelLine(name, desc,
                              low_date_x_1, low_x_1,
                              low_date_x_2, low_x_2,
                              low_date_x_2, hh,  isColorBullish, line_thick, STYLE_DOT);// support


        }

      //  deleteTheChannel(false, "BOTTOM_"+name);
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   ObjectsDeleteAll(0,-1,-1);
   GLOBAL_CHANNELS =0;
   Comment("");
// EventKillTimer();
  }

// return the channel width
double get_tp_from_channel(bool isLong)
  {
// make width of the channels with %

   double top,bottom;
   bottom = StringToDouble(ChannelsWidth("bottom1"));
   top = StringToDouble(ChannelsWidth("top1"));


   if(isLong)
     {
      return (bottom);
     }
   else
     {
      return(top);
     }

  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OptimizeLookback(bool isHigh, int start, int end, int minLookback)
  {

   int bars = 0;

   int last_end_value = end;

   datetime low_date_x_1;
   datetime low_date_x_2;

   while(bars < minLookback)
     {
      if(isHigh)
        {
         low_date_x_1 =  indi.get_zig_date(MAX_BARS_SLOW,start);
         low_date_x_2 =  indi.get_zig_date(MAX_BARS_SLOW,last_end_value);
        }
      else
        {
         low_date_x_1 =  indi.get_zag_date(MAX_BARS_SLOW,start);
         low_date_x_2 =  indi.get_zag_date(MAX_BARS_SLOW,last_end_value);
        }

      bars =  BarsBetweenTimestamps(low_date_x_1, low_date_x_2);
      last_end_value++;

      if(MAX_BARS_SLOW<=last_end_value)
         break;

     }



   return  last_end_value;


  }
//+------------------------------------------------------------------+
int SIGNAL_BUY =-1;
int SIGNAL_SELL =-1;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string channelAngles(int minutes_, double rise_)
  {
// Rise over Run
   double slope =0;
   if(rise_ > 0 && minutes_ > 0)
     {
      slope = rise_ / minutes_ ;
     }
   return (DoubleToString(slope,8));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void logic()
  {

   string pattern = GLOBAL_SIGNAL_LAST; // init

// GET DATA to create the zigzags. this does not draw any zigzags.
// COLLECTS DATA
   indi.get_all_zigzags(MAX_BARS_SLOW);

// if channels don't exist, draw them based on the zigzag data
   if(!does_channel_exist())
     {
      user_action_add_backtest(-1, -1);
      return;
     }
// if both channels exist,
// -- where is price in relation to the channels
// -- and what patterns exists


   string get_label = ObjectGetString(0,"Channel_Pattern",OBJPROP_TEXT,0);
   int ok_wedge = StringFind(get_label, "WEDGE",0);

   int ok_bullish = StringFind(get_label, "BULLISH",0);
   int ok_bearish = StringFind(get_label, "BEARISH",0);

   SIGNAL_BUY = ok_bullish;
   SIGNAL_SELL = ok_bearish;

// Is price within the prev drawn channels (channels are drawn on init: first tick)
   double bid = mt5.symbolBid();
// function returns either "inside or outside"" including :top or bottom and line name
   string create_channels_bear = ChannelsPriceInsideTop("top1", bid, 0,1);
//  string create_channels_bull = ChannelsPriceInside("bottom1", bid, 0,1);

   string create_channels_bull =  ChannelsPriceInsideBottom("bottom1", bid, 0,1);

// search within the text string for only the word "inside"
   int ok_buy = StringFind(create_channels_bull, "INSIDE",0);
   int ok_sell = StringFind(create_channels_bear, "INSIDE",0);
// if exists == 0 , else -1


// make width of the channels with %
   double top,bottom, top_perc, bottom_perc;
   string out_top_bot;
   int digi = mt5.symbolDigit();

   bottom = StringToDouble(ChannelsWidth("bottom1"));
   if(bottom>0)
      bottom_perc = (bottom / bid)*100;

   top = StringToDouble(ChannelsWidth("top1"));
   if(top>0)
      top_perc = (top /bid)*100;

   ObjEditTextField("Channel_Width_Bottom", DoubleToString(bottom,digi) + "|" + DoubleToString(bottom_perc,2) + "%") ;
   ObjEditTextField("Channel_Width_Top", DoubleToString(top,digi) + "|" + DoubleToString(top_perc,2) + "%") ;




// if price is within either channel, do not redraw that channel.
//-- this means that the channel does not redraw but the patterns will change.
//---- not good because if we have a certain pattern we dont want to redraw
//---- either channel until price is outside of both channels.

// wedge pattern existed, is it time t change channels?
// Print("DEBUG WEDGE ", ok_wedge);
   if(ok_wedge>=0)
     {
      if(ok_buy == -1 && ok_sell == -1)
        {
         // redraw
         user_action_add_backtest(-1, -1);
         pattern =  ChannelsCompareByName("top1",0, "bottom1",0);
         ObjEditTextField("Channel_Pattern", pattern);

        }
     }
// redraw channels : update pattern
   if(ok_wedge== -1)
     {
      user_action_add_backtest(ok_sell, ok_buy);// false means to draw the lines
      // -- if patterns exists, when should the channels be updated again
      pattern =  ChannelsCompareByName("top1",0, "bottom1",0);
      ObjEditTextField("Channel_Pattern", pattern);
     }


   string isWedge =   StringSubstr(pattern,0,5);// wedge

   string isBullish =   StringSubstr(pattern,0,7);// bullish

   if(SHOW_PATTERNS)
     {

      if(GLOBAL_SIGNAL_LAST != pattern)
        {
         GLOBAL_SIGNAL_LAST = pattern;
         GLOBAL_SIGNAL_COUNT++;
         // draw line

         if(pattern== "NONE")
           {
            const datetime now = iTime(NULL,PERIOD_CURRENT,0);
            ObjCreateVLine("Signal"+ IntegerToString(GLOBAL_SIGNAL_COUNT)+":"+pattern, pattern,
                           now, bid,

                           clrAliceBlue, 5, STYLE_SOLID);
           }
         else
            if(isBullish=="BEARISH")
              {
               const datetime now = iTime(NULL,PERIOD_CURRENT,0);
               ObjCreateVLine("Signal"+ IntegerToString(GLOBAL_SIGNAL_COUNT)+":"+pattern, pattern,
                              now, bid,

                              clrRed, 1, STYLE_SOLID);
              }
            else
               if(isBullish=="BULLISH")
                 {
                  const datetime now = iTime(NULL,PERIOD_CURRENT,0);
                  ObjCreateVLine("Signal"+ IntegerToString(GLOBAL_SIGNAL_COUNT)+":"+pattern, pattern,
                                 now, bid,

                                 clrBlueViolet, 1, STYLE_SOLID);
                 }
               else
                  if(isWedge == "WEDGE")
                    {
                     const datetime now = iTime(NULL,PERIOD_CURRENT,0);
                     ObjCreateVLine("Signal"+ IntegerToString(GLOBAL_SIGNAL_COUNT)+":"+pattern, pattern,
                                    now, bid,

                                    clrYellow, 1, STYLE_DOT);


                    }
                  else
                    {
                     const datetime now = iTime(NULL,PERIOD_CURRENT,0);
                     ObjCreateVLine("Signal"+ IntegerToString(GLOBAL_SIGNAL_COUNT) +":"+pattern, pattern,
                                    now, bid,

                                    clrBlack, 1, STYLE_DOT);
                    }


        }
     }


  }




//+------------------------------------------------------------------+

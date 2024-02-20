//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, TradingToolCrypto Corp."
#property link      "https://github.com/tradingtoolcrypto"
#include <TradingToolCrypto/TT/create_objects.mqh>

// pass in two datetime timestamps

// return how many bars between the two timestamps

// start time is the most current bar [1] (higher value : time value)
// and the end time is the oldest bar [100]
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int BarsBetweenTimestamps(datetime start, datetime end)
  {

   int x = (int) start;
   int y = (int) end;

   int span = x-y ; // subtract lower value from higher value : seconds between timestamps

   int seconds = PeriodSeconds(PERIOD_CURRENT);// one bar == # of seconds

   int bars = 0;
   if(span!= 0 && seconds != 0)
     {
      bars = span / seconds;
     }
   return bars;







  }
//+------------------------------------------------------------------+
// I want a button that adds or or removes a channel
void ButtonsBuySell(string bid, string ask, string close)
  {

   long value = ChartGetInteger(0,CHART_WIDTH_IN_PIXELS,0);
   long center =0;
   center = NormalizeDouble(value/2,0) ;

   ObjCreateButton("Sell_EX",false,center+28,5,105,40,bid,Red,White,0,CORNER_RIGHT_UPPER,9,"Arial",0,false,OBJ_ALL_PERIODS);
   ObjCreateButton("Buy_EX",false,center-75,5,105,40,ask,Blue,White,0,CORNER_RIGHT_UPPER,9,"Arial",0,false,OBJ_ALL_PERIODS);
   ObjCreateButton("Close_EX",false,center-180,5,105,40,close,Green,White,0,CORNER_RIGHT_UPPER,9,"Arial",0,false,OBJ_ALL_PERIODS);

  }
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string ChannelsCompareByName(string name,int lineA, string compareWith, int lineB)
  {
   double linepriceNowA=0;
   double linepriceNowA2=0;
   double linepriceNowB=0;
   double linepriceNowB2=0;
   const datetime now = iTime(NULL,PERIOD_CURRENT,0);
   const double price = SymbolInfoDouble(NULL, SYMBOL_BID);

// top
   if(ObjectFind(0, name) != -1)
     {
      linepriceNowA = ObjectGetValueByTime(0,name,now,  lineA);
      if(lineA==0)
        {
         linepriceNowA2 = ObjectGetValueByTime(0,name,now,  1);
        }
      else
         if(lineA==1)
           {
            linepriceNowA2 = ObjectGetValueByTime(0,name,now,  0);
           }
     }
// bottom
   if(ObjectFind(0, compareWith) != -1)
     {

      linepriceNowB = ObjectGetValueByTime(0,compareWith,now,  lineB);// 1 bottom lower channel value
      if(lineB==0)
        {
         linepriceNowB2 = ObjectGetValueByTime(0,compareWith,now,  1);
        }
      else
         if(lineB==1)
           {
            linepriceNowB2 = ObjectGetValueByTime(0,compareWith,now,  0);
           }
     }
//lines exist
   if(linepriceNowB != 0 && linepriceNowA != 0)
     {
      if(linepriceNowA > linepriceNowB
         && linepriceNowA > linepriceNowB2 // true top :  b2 > b
         && linepriceNowA2 > linepriceNowB // true bottom
         && price > linepriceNowB
         && price < linepriceNowA)
        {
         if(price < linepriceNowA && price > linepriceNowA2)
           {
            return("WEDGE:TOP");
           }
         if(price > linepriceNowB && price < linepriceNowB2)
           {
            return("WEDGE:BOTTOM");
           }
         if(price > linepriceNowB2
            && price < linepriceNowA2)
           {
            return("WEDGE:MIDDLE");
           }

         if(price < linepriceNowB2
            && price > linepriceNowA2)
           {
            return("WEDGE:DIAMOND");
           }
        }

      if(linepriceNowA > linepriceNowB
         && price > linepriceNowB
         && price > linepriceNowA && price > linepriceNowA2)
        {
         return("BULLISH:DIAMOND:BREAKOUT");
        }


      if(linepriceNowA > linepriceNowB
         && price < linepriceNowB && price < linepriceNowB2)
        {
         return("BEARISH:DIAMOND:BREAKOUT");
        }

      if(linepriceNowA < linepriceNowB && linepriceNowA2 < linepriceNowB2
         && price < linepriceNowB  && price < linepriceNowB2
         && price < linepriceNowA  && price < linepriceNowA2)
        {
         // price is below bullish channel and a new bearish channel is below the bull channel and price is below the bearish channel
         return("BEARISH:DIAMOND:BREAKOUT");
        }


      if(linepriceNowA < linepriceNowB && linepriceNowA2 < linepriceNowB2
         && price < linepriceNowB  && price < linepriceNowB2// below the bullish channel
         && price < linepriceNowA  && price > linepriceNowA2)// inside the beairsh channel
        {
         // price is below bullish channel and a new bearish channel is below the bull channel and price is below the bearish channel
         return("BEARISH:TREND");
        }

      if(linepriceNowA < linepriceNowB
         && price > linepriceNowA  && price > linepriceNowA2
         && price > linepriceNowB && price > linepriceNowB2)
        {
         //idk
         return("BULLISH:BREAKOUT");
        }


      if(linepriceNowA < linepriceNowB
         && price > linepriceNowA  && price > linepriceNowA2
         && price < linepriceNowB && price < linepriceNowB2)
        {
         //idk
         return("BREAKOUT:RETEST:DIAMOND:RANGE");
        }
     }
// BREAK OUTS
   if(linepriceNowB != 0 && linepriceNowA == 0)
     {
      // only bullish channel(botom channel) , no resistance to draw top channel
      if(price >linepriceNowB2)
        {
         return("BULLISH:BUY:TAKEPROFIT");
        }
      if(price < linepriceNowB2 && price > linepriceNowB)
        {
         return("BULLISH:BUY");
        }

      if(price < linepriceNowB)
        {
         return("BULLISH:BREAKOUT:CLOSE:BUY");
        }

     }
// support channel is missing, only bearish channel exists
   if(linepriceNowB == 0 && linepriceNowA != 0)
     {
      if(price < linepriceNowA2)
        {
         return("SELL:TAKEPROFIT");
        }
      if(price > linepriceNowA)
        {
         return("BULLISH:BREAKOUT:CLOSE:SELL");
        }
      if(price > linepriceNowA2 && price < linepriceNowA)
        {
         return("BEARISH:SELL");
        }

     }

   if(linepriceNowB2 > linepriceNowA &&
      linepriceNowB < linepriceNowA2
      && price > linepriceNowB && price < linepriceNowB2)
     {
      return("BULLISH:ASCENDING:TRIANGLE");
     }

   if(linepriceNowB2 > linepriceNowA &&
      linepriceNowB > linepriceNowA
      && price > linepriceNowB && price < linepriceNowB2)
     {
      return("BULLISH:BAT:WAVE:UP");
     }

// wierd situation where bearish channgel width is huge and bull small channel with price inside
   if(linepriceNowB2 > linepriceNowA2 &&
      linepriceNowB > linepriceNowA2
     )
     {
      if(price > linepriceNowB && price < linepriceNowB2)
        {
         return("BEARISH:CAT:WAVE:DOWN");
        }
      if(price > linepriceNowB && price > linepriceNowB2)
        {
         return("BEARISH:CAT:RETEST");
        }
     }
   return("NONE");
  }
/*
Is price inside the channel or outside the channel
*/
string ChannelsPriceInside(string name, double price, int lineA,int lineB)
  {

   if(price==0)
     {
      return "FAIL";
     }

   string sym = Symbol();
   const datetime now = iTime(sym,PERIOD_CURRENT,0);

   if(ObjectFind(0, name) != -1)
     {
      double linepriceNowA = ObjectGetValueByTime(0,name,now,  lineA);
      double linepriceNowB = ObjectGetValueByTime(0,name,now,  lineB);
      if(linepriceNowA != 0 && linepriceNowB !=0)
        {
         if(price >= linepriceNowA && price < linepriceNowB)
           {
            return "INSIDE:"+name;
           }
         else
            if(price < linepriceNowA && price >= linepriceNowB)
              {
               return "INSIDE:"+name;
              }
            else
               if(price > linepriceNowB && price >= linepriceNowA)
                 {
                  return "OUTSIDE:TOP:"+name;
                 }
               else
                  if(price < linepriceNowA && price < linepriceNowB)
                    {
                     return "OUTSIDE:BOTTOM:"+name;
                    }
        }
     }
   else
     {
      return "FAIL:NO LINE";
     }
   return "FAIL:CHANNEL SIGNAL";
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ChannelsDelete(bool isHigh, string name)
  {
// Print("Debug line " + name + " isHigh " + isHigh);

   const datetime now = iTime(NULL,PERIOD_CURRENT,0);

   if(ObjectFind(0, name) != -1)
     {
      // Print("Found line " + name);

      double linepriceNowA = ObjectGetValueByTime(0,name,now, 0);
      double linepriceNowB = ObjectGetValueByTime(0,name,now, 1);
      double price = SymbolInfoDouble(Symbol(), SYMBOL_BID);

      // bottom channels
      if(!isHigh)
        {
         if(linepriceNowA > price)
           {

            // delete the bottom channel that is above the current price
            ObjectDelete(0, name);
           }
        }
      else// top channel : pink
        {
         //  Print("Found line " + price + " Line " + linepriceNowA);
         if(linepriceNowB < price)//linepriceNowA < price ||
           {

            // delete the top channel that is below the current price
            ObjectDelete(0, name);
           }


        }

     }

  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string ChannelsWidth(string name)
  {
   string sym = Symbol();
   const datetime now = iTime(sym,PERIOD_CURRENT,0);

   if(ObjectFind(0, name) != -1)
     {
      double linepriceNowA = ObjectGetValueByTime(0,name,now,  0);
      double linepriceNowB = ObjectGetValueByTime(0,name,now,  1);
      if(linepriceNowA != 0 && linepriceNowB !=0)
        {
         double value =MathAbs(linepriceNowA - linepriceNowB);
         return (DoubleToString(value, SymbolInfoInteger(sym,SYMBOL_DIGITS)));
        }
     }
   else
     {
      return "FAIL:NO LINE";
     }
   return "FAIL:CHANNEL WIDTH";
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double ChannelsTrendlineValue(string name)
  {
   string sym = Symbol();
   const datetime now = iTime(sym,PERIOD_CURRENT,0);
   double value=0;
   if(ObjectFind(0, name) != -1)
     {
      double linepriceNowA =0;
      if(name == "bottom1")
        {
         linepriceNowA = ObjectGetValueByTime(0,name,now,  0);// this is working
        }
      else
        {
         linepriceNowA = ObjectGetValueByTime(0,name,now,  0);// idk yet ,
        }
      if(linepriceNowA != 0)
        {
         value =linepriceNowA;
        }
     }
   return value;
  }
//+------------------------------------------------------------------+
double ChannelsDeviationlineValue(string name)
  {
   string sym = Symbol();
   const datetime now = iTime(sym,PERIOD_CURRENT,0);
   double value=0;
   if(ObjectFind(0, name) != -1)
     {
      double linepriceNowA =0;
      if(name == "bottom1")
        {
         linepriceNowA = ObjectGetValueByTime(0,name,now,  1);
        }
      else
        {
         linepriceNowA = ObjectGetValueByTime(0,name,now,  1);
        }
      if(linepriceNowA != 0)
        {
         value =linepriceNowA;
        }
     }
   return value;
  }
//+------------------------------------------------------------------+

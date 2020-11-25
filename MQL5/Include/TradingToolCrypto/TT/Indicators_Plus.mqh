#property copyright "Copyright 2020, TradingToolCrypto Corp"
#property link "https://github.com/TradingToolCrypto"
#property version "1.00"

input string PLEASE_ADJUST_BB_STATEGY = "------------------------------------";
input int MA_PERIOD_A = 20;
input ENUM_MA_METHOD MA_TYPE = MODE_EMA;
input ENUM_APPLIED_PRICE MA_DATA_TYPE = PRICE_MEDIAN;
input double MA_DEVIATION = 2.0;
input int MA_BAR_SHIFT = 0;

input string PLEASE_ADJUST_EMA_STATEGY = "------------------------------------";
input int EMA_PERIOD_A = 50;
input int EMA_PERIOD_B = 100;
input ENUM_MA_METHOD EMA_TYPE = MODE_EMA;
input ENUM_APPLIED_PRICE EMA_DATA_TYPE = PRICE_CLOSE;
input int EMA_BAR_SHIFT = 0;

input double EMASPREAD_BUY = -0.60;
input double EMASPREAD_SELL = 0.60;

input string PLEASE_ADJUST_RSI_STATEGY = "------------------------------------";
input int RSI_PERIOD_A = 14;
input ENUM_APPLIED_PRICE RSI_DATA_TYPE = PRICE_CLOSE;

input double RSI_BUY = 20;
input double RSI_SELL = 80;

datetime lasttime;

// Indicators
int MA_handle_1;  // handle of the indicator iMA
int STD_handle_1; // handle of the indicator iMA
int EMA_handle_1;
int EMA_handle_2;
int RSI_handle_1;

double RSI[], EMA_1[], EMA_2[];

double BBUp[], BBLow[], BBMidle[]; // dynamic arrays for numerical values of Bollinger Bands
double StdDevBuffer[];             // dynamic arrays for numerical values of stddev
string market_name = "";

/*
 Place this function within the OnInit()
*/

bool init_Indicators(string what_market)
{
   // grab the market symbol from init function for later use in indicator logic
   market_name = what_market;

   if (MA_PERIOD_A != 0)
   {
      MA_handle_1 = iBands(what_market, PERIOD_CURRENT, MA_PERIOD_A, MA_BAR_SHIFT, MA_DEVIATION, MA_DATA_TYPE);
      //--- report if there was an error in object creation
      if (MA_handle_1 < 0)
      {
         Print("The creation of iMA has failed: MA_handle=", INVALID_HANDLE);
         Print("Runtime error = ", GetLastError());
         //--- forced program termination
         return (false);
      }
   }

   if (EMA_PERIOD_A != 0)
   {
      EMA_handle_1 = iMA(what_market, PERIOD_CURRENT, EMA_PERIOD_A, EMA_BAR_SHIFT, EMA_TYPE, EMA_DATA_TYPE);
      if (EMA_handle_1 < 0)
      {
         Print("The creation of iMA has failed: EMA_handle_1 =", INVALID_HANDLE);
         Print("Runtime error = ", GetLastError());
         //--- forced program termination
         return (false);
      }
   }

   if (EMA_PERIOD_A != 0)
   {
      EMA_handle_2 = iMA(what_market, PERIOD_CURRENT, EMA_PERIOD_B, EMA_BAR_SHIFT, EMA_TYPE, EMA_DATA_TYPE);
      if (EMA_handle_2 < 0)
      {
         Print("The creation of iMA has failed: EMA_handle_2 =", INVALID_HANDLE);
         Print("Runtime error = ", GetLastError());
         //--- forced program termination
         return (false);
      }
   }

   if (RSI_PERIOD_A != 0)
   {
      RSI_handle_1 = iRSI(what_market, PERIOD_CURRENT, RSI_PERIOD_A, RSI_DATA_TYPE);
      //--- report if there was an error in object creation
      if (RSI_handle_1 < 0)
      {
         Print("The creation of iRSI has failed: RSI_handle=", INVALID_HANDLE);
         Print("Runtime error = ", GetLastError());
         //--- forced program termination
         return (false);
      }
   }

   /*
   STD_handle_1=  iStdDev(what_market,PERIOD_CURRENT,MA_PERIOD_A,MA_BAR_SHIFT,MA_TYPE,MA_DATA_TYPE);
   //--- report if there was an error in object creation
   if(STD_handle_1<0 )
      {
      Print("The creation of iSTD has failed: STD_handle=",INVALID_HANDLE);
      Print("Runtime error = ",GetLastError());
      //--- forced program termination
      return(false);
      }
   */

   // everything is ok
   Print("init_Indicators ok");
   return (true);
}

double get_signal_BB(int buffer, int bar_index)
{

   //--- do we have enough bars to work with
   int Mybars = Bars(market_name, 0);
   if (Mybars < MA_PERIOD_A) // if total bars is less than 60 bars
   {
      Print("We have less than enough bars on the chart, Robot will wait for more bars before deciding on what to do next");
      return (0);
   }

   CopyBuffer(MA_handle_1, 0, 0, MA_PERIOD_A, BBMidle);
   CopyBuffer(MA_handle_1, 1, 0, MA_PERIOD_A, BBUp);
   CopyBuffer(MA_handle_1, 2, 0, MA_PERIOD_A, BBLow);

   // the indicator arrays
   ArraySetAsSeries(BBUp, true);
   ArraySetAsSeries(BBLow, true);
   ArraySetAsSeries(BBMidle, true);

   if (buffer == 1)
   {
      return (BBUp[bar_index]);
   }
   if (buffer == 2)
   {
      return (BBMidle[bar_index]);
   }
   if (buffer == 3)
   {
      return (BBLow[bar_index]);
   }
   return (0);
}

double get_ma_deviation()
{

   CopyBuffer(MA_handle_1, 0, 0, MA_PERIOD_A, BBMidle);
   CopyBuffer(MA_handle_1, 1, 0, MA_PERIOD_A, BBUp);
   CopyBuffer(MA_handle_1, 2, 0, MA_PERIOD_A, BBLow);

   ArraySetAsSeries(BBUp, true);
   ArraySetAsSeries(BBLow, true);
   ArraySetAsSeries(BBMidle, true);

   double width = BBUp[1] - BBLow[1];

   return (width);
}

string get_standard_deviation(double price)
{
   // use the logic

   int Mybars = Bars(market_name, 0);
   if (Mybars < MA_PERIOD_A) // if total bars is less than 60 bars
   {
      Print("We have less than enough bars on the chart, Robot will wait for more bars before deciding on what to do next");
      return ("NONE");
   }
   /*
     // To be used for getting recent/latest price quotes
         MqlTick Latest_Price; // Structure to get the latest prices      
         SymbolInfoTick(market_name ,Latest_Price); // Assign current prices to structure 
      
      // The BID price.
         static double price; 
      
      // The ASK price.
         static double dAsk_Price; 
      
         price = Latest_Price.bid;  // Current Bid price.
         dAsk_Price = Latest_Price.ask;  // Current Ask price.
     */
   CopyBuffer(STD_handle_1, 0, 0, MA_PERIOD_A, StdDevBuffer);
   /*
   handle_          ,// indicator handle 
      0,             // indicator buffer number 
      index,         // start position 
      1,             // amount to copy 
      StdDev         // target array to copy
   */

   // the indicator arrays
   ArraySetAsSeries(StdDevBuffer, true);

   string decision = "";
   if (StdDevBuffer[1] > StdDevBuffer[2] && StdDevBuffer[2] > StdDevBuffer[3])
   {
      // std increasing
      decision = "up";
   }
   if (StdDevBuffer[1] < StdDevBuffer[2] && StdDevBuffer[2] < StdDevBuffer[3])
   {
      // std decreasing
      decision = "down";
   }

   if (decision == "")
   {
      decision = "flat";
   }

   return (decision);
}

double get_standard_deviation_price()
{
   // use the logic

   int Mybars = Bars(market_name, 0);
   if (Mybars < MA_PERIOD_A) // if total bars is less than 60 bars
   {
      Print("We have less than enough bars on the chart, Robot will wait for more bars before deciding on what to do next");
   }

   CopyBuffer(STD_handle_1, 0, 0, MA_PERIOD_A, StdDevBuffer);
   /*
   handle_          ,// indicator handle 
      0,             // indicator buffer number 
      index,         // start position 
      1,             // amount to copy 
      StdDev         // target array to copy
   */

   // the indicator arrays
   ArraySetAsSeries(StdDevBuffer, true);

   double normalize = NormalizeDouble(StdDevBuffer[1], 8);
   return (normalize);
}

double get_signal_RSI(int bar_index)
{
   //--- do we have enough bars to work with
   int Mybars = Bars(market_name, 0);
   if (Mybars < RSI_PERIOD_A) // if total bars is less than 60 bars
   {
      Print("We have less than enough bars on the chart, Robot will wait for more bars before deciding on what to do next");
      return (0);
   }

   CopyBuffer(RSI_handle_1, 0, 0, 5, RSI);
   ArraySetAsSeries(RSI, true);

   return (NormalizeDouble(RSI[bar_index], 2));
}

double ema1 = 0;
double ema2 = 0;
double get_signal_EMA_SPREAD(int bar_index)
{

   //--- do we have enough bars to work with
   int Mybars = Bars(market_name, 0);
   if (Mybars < EMA_PERIOD_A && Mybars < EMA_PERIOD_B) // if total bars is less than 60 bars
   {
      Print("We have less than enough bars on the chart, Robot will wait for more bars before deciding on what to do next");
      return (0);
   }

   CopyBuffer(EMA_handle_1, 0, 0, 5, EMA_1);
   CopyBuffer(EMA_handle_2, 0, 0, 5, EMA_2);

   // the indicator arrays
   ArraySetAsSeries(EMA_1, true);
   ArraySetAsSeries(EMA_2, true);

   ema1 = EMA_1[bar_index];
   ema2 = EMA_2[bar_index];

   //Spread is the percentage spread difference between EMA1 (Slow) and EMA2 (Fast)
   return (NormalizeDouble(((ema1 / ema2) - 1) * 100, 2));
}

string get_signal_buy_1(double price, int bar_index)
{

   if (get_signal_EMA_SPREAD(bar_index) < EMASPREAD_BUY)
   {
      if (ema1 < ema2)
      {

         if (get_signal_RSI(bar_index) < RSI_BUY)
         {
            if (price < get_signal_BB(2, 1))
            {
               return ("SIGNAL");
            }
         }
      }
   }
   return ("false");
}

string get_signal_sell_1(double price, int bar_index)
{

   if (get_signal_EMA_SPREAD(bar_index) > EMASPREAD_SELL)
   {
      if (ema1 > ema2)
      {
         if (get_signal_RSI(bar_index) > RSI_SELL)
         {
            if (price > get_signal_BB(2, 1))
            {
               return ("SIGNAL");
            }
         }
      }
   }
   return ("false");
}

/*
 Create an unlimited amount of strategies
 - Name your strategy
 - Your strategy needs a unique number
*/

enum ENUM_AVAILABLE_LOGIC
{
   BUY_STRATEGY_ONE = 1,
   SELL_STRATEGY_ONE = 2
};

/*
 
 This is the only piece of code that goes inside your robot
 
 - string returns_signal_if_true = get_signal(1,Bid,1);
 
 - access the strategies by 1,2,3,4,5,6 
 - insert the bid price
 - select what bar index you want to run the indicator on : 1 = Last bar, 0 = current closing bar
 
*/

string get_signal(int strategy, double price, int bar_index)
{

   if (strategy == 1)
   {
      return (get_signal_buy_1(price, bar_index));
   }
   if (strategy == 2)
   {
      return (get_signal_sell_1(price, bar_index));
   }
   /*
   create more strategy combinations below
   
   if(strategy == 3){
      return( get_signal_buy_2(price,bar_index) );
   }
   
   if(strategy == 4){
      return( get_signal_sell_2(price,bar_index) );
   }
   
   */

   return ("false");
}

/*
 More Oct 2020
*/


string get_signal_EMA_CROSS()
{
   double ema1a = 0;
   double ema2a = 0;
   
   double ema1b = 0;
   double ema2b = 0;

   //--- do we have enough bars to work with
   int Mybars = Bars(market_name, 0);
   if (Mybars < EMA_PERIOD_A && Mybars < EMA_PERIOD_B) // if total bars is less than 60 bars
   {
      Print("We have less than enough bars on the chart, Robot will wait for more bars before deciding on what to do next");
      return (0);
   }

   CopyBuffer(EMA_handle_1, 0, 0, 5, EMA_1);
   CopyBuffer(EMA_handle_2, 0, 0, 5, EMA_2);

   // the indicator arrays
   ArraySetAsSeries(EMA_1, true);
   ArraySetAsSeries(EMA_2, true);

   ema1a = EMA_1[0];
   ema2a = EMA_2[0];
   
    ema1b = EMA_1[1];
   ema2b = EMA_2[1];
   
   // cross up 
   if(ema1a > ema2a && ema1b <= ema2b){
      return("CROSSUP");
   }
   // cross down
   if(ema1a < ema2a && ema1b >= ema2b){
      return("CROSSDOWN");
   }
   
 return("NONE");
}
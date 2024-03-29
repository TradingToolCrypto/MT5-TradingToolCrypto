//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, TradingToolCrypto Corp"
#property link "https://github.com/TradingToolCrypto"
#property version "1.00"
/*
 https://www.mql5.com/en/articles/351
 protected functions can be called from the class Cbase while private functions can not be called


 //-- draw indicators after test
   TesterHideIndicators(!ENABLE_TEST_INDICATORS);

*/


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class RobotFrameWork
  {

   /*
   Levels of encapsulation
   */
private:
   bool              sym_hedgeMode;
   int               sym_magic;
   int               sym_digit_quote;
   int               sym_digit_volume;
   double            sym_point;
   string            sym_name;
   int               instance;
   ulong              ms_in;
   ulong              ms_out;
   double            tradeTP;
   double            tradeSL;
   ENUM_ORDER_TYPE_FILLING sym_exec;

public:
                     RobotFrameWork(int pointer);
                     RobotFrameWork();
                    ~RobotFrameWork();
   bool              Init_Symbol(string symbol);

   double            symbolPoint();
   int               symbolDigit();
   string            symbolName() { return(sym_name);}
   double            symbolNormalizeVolume(double posVolume);
   double            symbolSpread();
   double            symbolAsk();
   double            symbolBid();
   int               symbolBars();
   bool              symbolNewBar(ENUM_TIMEFRAMES tf);
   double            symbolOpen(int index,ENUM_TIMEFRAMES tf);
   double            symbolHigh(int index,ENUM_TIMEFRAMES tf);
   double            symbolLow(int index,ENUM_TIMEFRAMES tf);
   double            symbolClose(int index,ENUM_TIMEFRAMES tf);
   double            symbolOpen(int index);
   double            symbolHigh(int index);
   double            symbolLow(int index);
   double            symbolClose(int index);
   double            symbolHighest(int bars);
   double            symbolLowest(int bars);

   double            symbolRange(int bars);
   double            symbolRange(int bars, int range);
   bool              symbolBarBull(int index);
   bool              symbolBarBull(int index, ENUM_TIMEFRAMES tf);
   double            symbolBarRange(int index);

   bool              tradeBuy(double volume);
   bool              tradeSell(double volume);

   bool              tradeBuy(double volume, double tp, double sl);
   bool              tradeSell(double volume, double tp, double sl);

   bool              tradeBid(double volume);
   bool              tradeAsk(double volume);
   bool              tradeBid(double volume, double price);
   bool              tradeAsk(double volume, double price);

   bool              tradeBuyStop(double volume);
   bool              tradeSellStop(double volume);
   bool              tradeBuyStop(double volume,double price);
   bool              tradeSellStop(double volume,double price);

   bool              tradeBuyStopLimit(double volume,double trigger);
   bool              tradeSellStopLimit(double volume,double trigger);

   bool              tradeBuyStopLimit(double volume,double trigger, double orderprice);
   bool              tradeSellStopLimit(double volume,double trigger, double orderprice);

   int               orderPending();
   int               orderPendingLimitLong;
   int               orderPendingLimitShort;
   int               orderPendingStopLong;
   int               orderPendingStopShort;
   int               orderPendingStopLimitLong;
   int               orderPendingStopLimitShort;

   bool              tradeClose(bool longOnly); // close all
   bool              tradeCloseLimit(bool longOnly);

   bool              tradeDeleteLimit(bool longOnly);
   bool              tradeDeleteStop(bool longOnly);

   void              tradeSetTPSL(double tp, double sl);
   bool              tradeModifyPercent(bool longOnly, double tp, double sl);
   bool              tradeModifyFixed(bool longOnly, double tp, double sl);
   bool              tradeModify(bool longOnly);
   bool              tradeModifyTrailing(bool longOnly, double sl_price);
   bool              tradeModifyFixedReduce(bool longOnly, double sl);

   double            moneyRiskOnBalance(bool brokerOnly, double exchangeBalance);
   string            moneyRiskOnPointsPlusCommission(bool ifLong, const string baseCurrency,const double balance, const double risk, const int slPoints, const double commissionPercent);

   string            msTimer(bool inOut);

   string            errorCode(int value);
   string            errorRetCode(int value);

   bool              positionTotal();
   int               positionTotalLong;
   int               positionTotalShort;
   double            position_avg_price_sell;
   double            position_avg_price_buy;
   double            position_volume_sell;
   double            position_volume_buy;
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
RobotFrameWork::RobotFrameWork(int pointer)
  {
   instance = pointer;
   Print("RobotFrameWork Loaded: Instance(" + IntegerToString(pointer) + ")");
  }
/*
    The default symbol is loaded
    - Any symbol can be assigned by passing the symbol into Init_Symbol and by making another instance
*/
RobotFrameWork::RobotFrameWork()
  {
   RobotFrameWork::Init_Symbol(Symbol());
   Print("RobotFrameWork Loaded: No Instance");
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
RobotFrameWork::~RobotFrameWork()
  {
   Print("RobotFrameWork Removed: " + symbolName());
  }
/*
 this function can be called to creat individual classes such as
 RobotFrameWork mt1;
 RobotFrameWork mt2;

 OnInit(){
  mt1.Init_Symbol("EURUSD");
  mt2.Init_Symbol("GBPUSD");
 }

*/
bool RobotFrameWork::Init_Symbol(string symbol)
  {

   sym_name = symbol;
   sym_magic = MathRand();
   sym_digit_quote =  SymbolInfoInteger(symbol,SYMBOL_DIGITS);
   sym_point =  SymbolInfoDouble(symbol,SYMBOL_POINT);

   int typeAccount = AccountInfoInteger(ACCOUNT_MARGIN_MODE);
   /*
   Buy and sell position can exist on HedgeMode account type
   */
   if(typeAccount == 2)
     {
      sym_hedgeMode = true;
     }
   /*
    Only 1 position can exist , This means the position count does not change when scaling in and out
   */
   if(typeAccount == 0)
     {
      sym_hedgeMode = false;
     }

   /*
      Print(" HEDGIN ALLOWED : Answer: " + sym_hedgeMode);
      Print(" HEDGIN ALLOWED : hedging: " + ACCOUNT_MARGIN_MODE_RETAIL_HEDGING);
      Print(" HEDGIN ALLOWED : netting:  " + ACCOUNT_MARGIN_MODE_RETAIL_NETTING);
      Print(" HEDGIN ALLOWED : exchange: " + ACCOUNT_MARGIN_MODE_EXCHANGE);

      Print("SYMBOL_FILLING_MODE: ", SymbolInfoInteger(symbol, SYMBOL_FILLING_MODE));
      Print("SYMBOL_ORDER_MODE: ", SymbolInfoInteger(symbol, SYMBOL_ORDER_MODE));
      Print("SYMBOL_TRADE_MODE: ", EnumToString((ENUM_SYMBOL_TRADE_MODE)SymbolInfoInteger(_Symbol, SYMBOL_TRADE_MODE)));
      Print("SYMBOL_TRADE_EXEMODE: ", EnumToString((ENUM_SYMBOL_TRADE_EXECUTION)SymbolInfoInteger(_Symbol, SYMBOL_TRADE_EXEMODE)));

      need to figure out the correct execution mode based on these values and set them automatically
      */
   Print("SYMBOL_FILLING_MODE: ", SymbolInfoInteger(symbol, SYMBOL_FILLING_MODE));
   Print("SYMBOL_TRADE_EXEMODE: ", EnumToString((ENUM_SYMBOL_TRADE_EXECUTION)SymbolInfoInteger(_Symbol, SYMBOL_TRADE_EXEMODE)));

   int value = (ENUM_SYMBOL_TRADE_EXECUTION)SymbolInfoInteger(symbol,SYMBOL_TRADE_EXEMODE);
   /*
   ORDER_FILLING_FOK =0
   ORDER_FILLING_IOC = 1;
   ORDER_FILLING_RETURN = 2
   */


   uint filling=(uint)SymbolInfoInteger(symbol,SYMBOL_FILLING_MODE);
   if(filling == 2)
     {
      sym_exec=1;
     }
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double RobotFrameWork::symbolPoint()
  {
   return(sym_point);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int RobotFrameWork::symbolDigit()
  {
   return(sym_digit_quote);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double RobotFrameWork::symbolSpread()
  {

   double bid = SymbolInfoDouble(sym_name,SYMBOL_BID);
   double ask = SymbolInfoDouble(sym_name,SYMBOL_ASK);
   return(NormalizeDouble(ask-bid,sym_digit_quote));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double RobotFrameWork::symbolAsk()
  {
   double ask = SymbolInfoDouble(sym_name,SYMBOL_ASK);
   return(NormalizeDouble(ask,sym_digit_quote));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double RobotFrameWork::symbolBid()
  {
   double bid = SymbolInfoDouble(sym_name,SYMBOL_BID);
   return(NormalizeDouble(bid,sym_digit_quote));
  }
//+------------------------------------------------------------------+
bool RobotFrameWork::symbolNewBar(ENUM_TIMEFRAMES tf)
  {
   datetime time_array[];
   static datetime lastbar;
   datetime curbar = iTime(sym_name,tf,0);
   if(curbar ==0)
     {
      if(CopyTime(sym_name,tf,0,1,time_array) != -1)
        {
         curbar = time_array[0];
        }
     }
   if(lastbar != curbar)
     {
      lastbar = curbar;
      return (true);
     }
   return (false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int RobotFrameWork::symbolBars()
  {
   int bars = Bars(sym_name,PERIOD_CURRENT);
   int vbars =  ChartGetInteger(ChartID(),CHART_WIDTH_IN_BARS);
   /*
   if more bars can visually be seen on the chart compared to the actual number of bars in the history database
   - rest vbars
   */
   if(bars < vbars)
     {
      vbars = bars;
     }
   return(vbars);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double RobotFrameWork::symbolBarRange(int index)
  {
   if(index == 0)
      index = 1;
   double h = iHigh(sym_name,PERIOD_CURRENT,index);
   double l = iLow(sym_name,PERIOD_CURRENT,index);
   return(NormalizeDouble(h-l,sym_digit_quote));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool RobotFrameWork::symbolBarBull(int index)
  {
   if(index == 0)
      index = 1;
   double o = iOpen(sym_name,PERIOD_CURRENT,index);
   double c = iClose(sym_name,PERIOD_CURRENT,index);
   if(c > o)
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool RobotFrameWork::symbolBarBull(int index, ENUM_TIMEFRAMES tf)
  {
   if(index == 0)
      index = 1;
   double o = iOpen(sym_name,tf,index);
   double c = iClose(sym_name,tf,index);
   if(c > o)
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double RobotFrameWork::symbolOpen(int index)
  {
   double o = iOpen(sym_name,PERIOD_CURRENT,index);
   return(o);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double RobotFrameWork::symbolHigh(int index)
  {
   double h = iHigh(sym_name,PERIOD_CURRENT,index);
   return(h);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double RobotFrameWork::symbolLow(int index)
  {
   double l = iLow(sym_name,PERIOD_CURRENT,index);
   return(l);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double RobotFrameWork::symbolClose(int index)
  {
   double c= iClose(sym_name,PERIOD_CURRENT,index);
   return(c);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double RobotFrameWork::symbolOpen(int index,ENUM_TIMEFRAMES tf)
  {
   double o = iOpen(sym_name,tf,index);
   return(o);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double RobotFrameWork::symbolHigh(int index,ENUM_TIMEFRAMES tf)
  {
   double h = iHigh(sym_name,tf,index);
   return(h);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double RobotFrameWork::symbolLow(int index,ENUM_TIMEFRAMES tf)
  {
   double l = iLow(sym_name,tf,index);
   return(l);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double RobotFrameWork::symbolClose(int index,ENUM_TIMEFRAMES tf)
  {
   double c= iClose(sym_name,tf,index);
   return(c);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double RobotFrameWork::symbolHighest(int bars)
  {
   int hh1 = iHighest(sym_name,PERIOD_CURRENT,MODE_CLOSE,bars,1);
   double hh1_ = iHigh(sym_name,PERIOD_CURRENT,hh1);
   return(hh1_);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double RobotFrameWork::symbolLowest(int bars)
  {
   int ll1 = iLowest(sym_name,PERIOD_CURRENT,MODE_CLOSE,bars,1);
   double ll1_ = iLow(sym_name,PERIOD_CURRENT,ll1);
   return(ll1_);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double RobotFrameWork::symbolRange(int bars)
  {
   double top = symbolHighest(bars);
   double bottom = symbolLowest(bars);
   return(NormalizeDouble(top-bottom,sym_digit_quote));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double RobotFrameWork::symbolRange(int bars, int range)
  {
   int ll1 = iLowest(sym_name,PERIOD_CURRENT,MODE_CLOSE,bars,range);
   double ll1_ = iLow(sym_name,PERIOD_CURRENT,ll1);
   int hh1 = iHighest(sym_name,PERIOD_CURRENT,MODE_CLOSE,bars,range);
   double hh1_ = iHigh(sym_name,PERIOD_CURRENT,hh1);
   return(NormalizeDouble(hh1_-ll1_,sym_digit_quote));
  }
/*
 Attempt to normalize the lotsize for each broker and return a value that doesn't create an error
 - work in progress -
 - working with pepperston - done
*/
double RobotFrameWork::symbolNormalizeVolume(double posVolume)
  {
   double minVolume = SymbolInfoDouble(sym_name,SYMBOL_VOLUME_MIN);
   double maxVolume = SymbolInfoDouble(sym_name,SYMBOL_VOLUME_MAX);
   double volumeStep = SymbolInfoDouble(sym_name,SYMBOL_VOLUME_STEP);

   int normalize_digit = 0;

   if(volumeStep==1)
     {
      normalize_digit = 0;
     }
   if(volumeStep==0.1)
     {
      normalize_digit = 1;
     }
   if(volumeStep==0.01)
     {
      normalize_digit = 2;
     }
   if(volumeStep<=0.01)
     {
      normalize_digit = 2;
     }

   if(minVolume == 0.10)
     {
      normalize_digit = 1;
     }
   if(minVolume == 0.01)
     {
      normalize_digit = 2;
     }
   if(posVolume < minVolume)
     {
      return(NormalizeDouble(minVolume,normalize_digit));
     }
   if(posVolume>maxVolume)
     {
      return(NormalizeDouble(maxVolume,normalize_digit));
     }
   return(NormalizeDouble(posVolume,normalize_digit));
  }
/*
 average price only works if the volume is the same size. Not ideal, I'll need to change this later
 Netting account type would only have 1 position at all times, and the position open price is equal the average price by default.
*/
bool RobotFrameWork::positionTotal()
  {
   positionTotalLong=0;
   positionTotalShort=0;
   position_avg_price_buy = 0;
   position_avg_price_sell=0;
   position_volume_buy =0;
   position_volume_sell =0;
   for(int i = PositionsTotal() - 1; i >= 0; i--)
     {
      ulong ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(ticket))
        {
         if(PositionGetInteger(POSITION_TYPE)==0)
           {
            positionTotalLong++;
            position_avg_price_buy += PositionGetDouble(POSITION_PRICE_OPEN);
            position_volume_buy += PositionGetDouble(POSITION_VOLUME);
           }
         if(PositionGetInteger(POSITION_TYPE)==1)
           {
            positionTotalShort++;
            position_avg_price_sell+= PositionGetDouble(POSITION_PRICE_OPEN);
            position_volume_sell += PositionGetDouble(POSITION_VOLUME);
           }
        }
     }


   if(positionTotalLong > 0)
     {
      position_avg_price_buy = position_avg_price_buy /positionTotalLong;
     }
   if(positionTotalShort > 0)
     {
      position_avg_price_sell = position_avg_price_sell /positionTotalShort;
     }


   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int RobotFrameWork::orderPending()
  {

   orderPendingLimitLong = 0;
   orderPendingStopLong = 0;
   orderPendingStopLimitLong = 0;

   orderPendingLimitShort = 0;
   orderPendingStopShort = 0;
   orderPendingStopLimitShort = 0;

   int total = OrdersTotal();
   for(int i = total - 1; i >= 0; i--)
     {
      ulong ticket =  OrderGetTicket(i);
      if(OrderGetString(ORDER_SYMBOL) == sym_name)
        {

         if(OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_BUY_LIMIT && OrderGetInteger(ORDER_MAGIC) == sym_magic)
           {
            orderPendingLimitLong++;
           }
         if(OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_BUY_STOP && OrderGetInteger(ORDER_MAGIC) == sym_magic)
           {
            orderPendingStopLong++;
           }
         if(OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_BUY_STOP_LIMIT && OrderGetInteger(ORDER_MAGIC) == sym_magic)
           {
            orderPendingStopLimitLong++;
           }

         if(OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_SELL_LIMIT && OrderGetInteger(ORDER_MAGIC) == sym_magic)
           {
            orderPendingLimitShort++;
           }
         if(OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_SELL_STOP && OrderGetInteger(ORDER_MAGIC) == sym_magic)
           {
            orderPendingStopShort++;
           }
         if(OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_SELL_STOP_LIMIT && OrderGetInteger(ORDER_MAGIC) == sym_magic)
           {
            orderPendingStopLimitShort++;
           }
        }
     }
   return(total);
  }


/*
 Delete all the Limit orders
 longOnly , delete all the BuyLimits
 !longOnly, delete all the SellLimits
*/
bool RobotFrameWork::tradeDeleteLimit(bool longOnly)
  {
   for(int i = OrdersTotal() - 1; i >= 0; i--)
     {
      long ticket =  OrderGetTicket(i);
      if(OrderGetString(ORDER_SYMBOL) == sym_name)
        {

         if(longOnly)
           {
            if(OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_BUY_LIMIT && OrderGetInteger(ORDER_MAGIC) == sym_magic)
              {
               MqlTradeRequest request= {};
               request.action   =TRADE_ACTION_REMOVE;
               request.magic    =sym_magic;
               request.order =ticket;
               MqlTradeResult result= {};
               if(!OrderSend(request,result) && (result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE))
                 {
                  Print("Function tradeBuy failed with error #", GetLastError(), " retcode #", result.retcode);
                 }

              }
           }
         else
           {
            if(OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_SELL_LIMIT && OrderGetInteger(ORDER_MAGIC) == sym_magic)
              {
               MqlTradeRequest request= {};
               request.action   =TRADE_ACTION_REMOVE;
               request.magic    =sym_magic;
               request.order =ticket;
               MqlTradeResult result= {};
               if(!OrderSend(request,result) && (result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE))
                 {
                  Print("Function tradeBuy failed with error #", GetLastError(), " retcode #", result.retcode);
                 }

              }
           }
        }
     }
   return(false);
  }



/*
 Delete all the stop orders
 longOnly , delete all the Buystop
 !longOnly, delete all the Sellstop
*/
bool RobotFrameWork::tradeDeleteStop(bool longOnly)
  {
   for(int i = OrdersTotal() - 1; i >= 0; i--)
     {
      long ticket =  OrderGetTicket(i);
      if(OrderGetString(ORDER_SYMBOL) == sym_name)
        {

         if(longOnly)
           {
            if(OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_BUY_STOP && OrderGetInteger(ORDER_MAGIC) == sym_magic)
              {
               MqlTradeRequest request= {};
               request.action   =TRADE_ACTION_REMOVE;
               request.magic    =sym_magic;
               request.order =ticket;
               MqlTradeResult result= {};
               if(!OrderSend(request,result) && (result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE))
                 {
                  Print("Function tradeBuy failed with error #", GetLastError(), " retcode #", result.retcode);
                 }

              }
           }
         else
           {
            if(OrderGetInteger(ORDER_TYPE) == ORDER_TYPE_SELL_STOP && OrderGetInteger(ORDER_MAGIC) == sym_magic)
              {
               MqlTradeRequest request= {};
               request.action   =TRADE_ACTION_REMOVE;
               request.magic    =sym_magic;
               request.order =ticket;
               MqlTradeResult result= {};
               if(!OrderSend(request,result) && (result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE))
                 {
                  Print("Function tradeBuy failed with error #", GetLastError(), " retcode #", result.retcode);
                 }

              }
           }
        }
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void RobotFrameWork::tradeSetTPSL(double tp, double sl)
  {
   tradeTP = tp;
   tradeSL = sl;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool RobotFrameWork::tradeBuy(double volume)
  {
   MqlTradeRequest request= {};
   request.type_filling = sym_exec;
   request.action   =TRADE_ACTION_DEAL;
   request.symbol   =sym_name;
   request.magic    =sym_magic;
   request.volume   =volume;
   request.type     =ORDER_TYPE_BUY;
   request.price    =symbolAsk();
   request.sl       =0;
   request.tp       =0;
   request.deviation=9999999;
   request.comment=sym_name;
   MqlTradeResult result= {};
   if(OrderSend(request,result) && (result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE))
     {
      return(true);
     }
   else
     {
      Print("Function tradeBuy failed with error #", GetLastError(), " retcode #", result.retcode);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool RobotFrameWork::tradeBuy(double volume, double tp, double sl)
  {
   MqlTradeRequest request= {};
   request.type_filling = sym_exec;
   request.action   =TRADE_ACTION_DEAL;
   request.symbol   =sym_name;
   request.magic    =sym_magic;
   request.volume   =volume;
   request.type     =ORDER_TYPE_BUY;
   request.price    =symbolAsk();
   request.sl       =NormalizeDouble(sl, sym_digit_quote);
   request.tp       =NormalizeDouble(tp, sym_digit_quote);
   request.deviation=9999999;
   request.comment=sym_name;
   MqlTradeResult result= {};
   if(OrderSend(request,result) && (result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE))
     {
      return(true);
     }
   else
     {
      Print("Function tradeBuy failed with error #", GetLastError(), " retcode #", result.retcode);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool RobotFrameWork::tradeBid(double volume)
  {
   MqlTradeRequest request= {};
   request.type_filling = sym_exec;
   request.action   =TRADE_ACTION_PENDING;
   request.symbol   =sym_name;
   request.magic    =sym_magic;
   request.volume   =volume;
   request.type     =ORDER_TYPE_BUY_LIMIT;
   request.price    =symbolBid()- sym_point;
   request.sl       =0;
   request.tp       =0;
   request.deviation=9999999;
   request.comment=sym_name;
   MqlTradeResult result= {};
   if(OrderSend(request,result) && (result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE))
     {
      return(true);
     }
   else
     {
      Print("Function tradeBuy failed with error #", GetLastError(), " retcode #", result.retcode);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool RobotFrameWork::tradeBid(double volume,double price)
  {
   MqlTradeRequest request= {};
   request.type_filling = sym_exec;
   request.action   =TRADE_ACTION_PENDING;
   request.symbol   =sym_name;
   request.magic    =sym_magic;
   request.volume   =volume;
   request.type     =ORDER_TYPE_BUY_LIMIT;
   request.price    =price;
   request.sl       =0;
   request.tp       =0;
   request.deviation=9999999;
   request.comment=sym_name;
   MqlTradeResult result= {};
   if(OrderSend(request,result) && (result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE))
     {
      return(true);
     }
   else
     {
      Print("Function tradeBuy failed with error #", GetLastError(), " retcode #", result.retcode);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool RobotFrameWork::tradeBuyStop(double volume)
  {
   MqlTradeRequest request= {};
   request.type_filling = sym_exec;
   request.action   =TRADE_ACTION_PENDING;
   request.symbol   =sym_name;
   request.magic    =sym_magic;
   request.volume   =volume;
   request.type     =ORDER_TYPE_BUY_STOP;
   request.price    =symbolAsk();
   request.sl       =0;
   request.tp       =0;
   request.deviation=9999999;
   request.comment=sym_name;
   MqlTradeResult result= {};
   if(OrderSend(request,result) && (result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE))
     {
      return(true);
     }
   else
     {
      Print("Function tradeBuy failed with error #", GetLastError(), " retcode #", result.retcode);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool RobotFrameWork::tradeBuyStop(double volume,double price)
  {
   MqlTradeRequest request= {};
   request.type_filling = sym_exec;
   request.action   =TRADE_ACTION_PENDING;
   request.symbol   =sym_name;
   request.magic    =sym_magic;
   request.volume   =volume;
   request.type     =ORDER_TYPE_BUY_STOP;
   request.price    =price;
   request.sl       =0;
   request.tp       =0;
   request.deviation=9999999;
   request.comment=sym_name;
   MqlTradeResult result= {};
   if(OrderSend(request,result) && (result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE))
     {
      return(true);
     }
   else
     {
      Print("Function tradeBuy failed with error #", GetLastError(), " retcode #", result.retcode);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool RobotFrameWork::tradeBuyStopLimit(double volume,double trigger)
  {
   MqlTradeRequest request= {};
   request.type_filling = sym_exec;
   request.action   =TRADE_ACTION_PENDING;
   request.symbol   =sym_name;
   request.magic    =sym_magic;
   request.volume   =volume;
   request.type     =ORDER_TYPE_BUY_STOP_LIMIT;
   request.price    =trigger;
   request.stoplimit = symbolBid();
   request.sl       =0;
   request.tp       =0;
   request.deviation=9999999;
   request.comment=sym_name;
   MqlTradeResult result= {};
   if(OrderSend(request,result) && (result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE))
     {
      return(true);
     }
   else
     {
      Print("Function tradeBuy failed with error #", GetLastError(), " retcode #", result.retcode);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool RobotFrameWork::tradeBuyStopLimit(double volume,double trigger, double orderprice)
  {
   MqlTradeRequest request= {};
   request.type_filling = sym_exec;
   request.action   =TRADE_ACTION_PENDING;
   request.symbol   =sym_name;
   request.magic    =sym_magic;
   request.volume   =volume;
   request.type     =ORDER_TYPE_BUY_STOP_LIMIT;
   request.price    =trigger;
   request.stoplimit = orderprice;
   request.sl       =0;
   request.tp       =0;
   request.deviation=9999999;
   request.comment=sym_name;
   MqlTradeResult result= {};
   if(OrderSend(request,result) && (result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE))
     {
      return(true);
     }
   else
     {
      Print("Function tradeBuy failed with error #", GetLastError(), " retcode #", result.retcode);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool RobotFrameWork::tradeSell(double volume)
  {
   MqlTradeRequest request= {};
   request.type_filling = sym_exec;
   request.action   =TRADE_ACTION_DEAL;
   request.symbol   =sym_name;
   request.magic    =sym_magic;
   request.volume   =volume;
   request.type     =ORDER_TYPE_SELL;
   request.price    =symbolBid();
   request.sl       =0;
   request.tp       =0;
   request.deviation=9999999;
   request.comment=sym_name;
   MqlTradeResult result= {};
   if(OrderSend(request,result) && (result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE))
     {
      return(true);
     }
   else
     {
      Print("Function tradeSell failed with error #", GetLastError(), " retcode #", result.retcode);
     }
   return(false);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool RobotFrameWork::tradeSell(double volume,double tp, double sl)
  {
   MqlTradeRequest request= {};
   request.type_filling = sym_exec;
   request.action   =TRADE_ACTION_DEAL;
   request.symbol   =sym_name;
   request.magic    =sym_magic;
   request.volume   =volume;
   request.type     =ORDER_TYPE_SELL;
   request.price    =symbolBid();
   request.sl       =NormalizeDouble(sl, sym_digit_quote);
   request.tp       =NormalizeDouble(tp, sym_digit_quote);
   request.deviation=9999999;
   request.comment=sym_name;
   MqlTradeResult result= {};
   if(OrderSend(request,result) && (result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE))
     {
      return(true);
     }
   else
     {
      Print("Function tradeSell failed with error #", GetLastError(), " retcode #", result.retcode);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool RobotFrameWork::tradeSellStop(double volume)
  {
   MqlTradeRequest request= {};
   request.type_filling = sym_exec;
   request.action   =TRADE_ACTION_PENDING;
   request.symbol   =sym_name;
   request.magic    =sym_magic;
   request.volume   =volume;
   request.type     =ORDER_TYPE_SELL_STOP;
   request.price    =symbolBid();
   request.sl       =0;
   request.tp       =0;
   request.deviation=9999999;
   request.comment=sym_name;
   MqlTradeResult result= {};
   if(OrderSend(request,result) && (result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE))
     {
      return(true);
     }
   else
     {
      Print("Function tradeSell failed with error #", GetLastError(), " retcode #", result.retcode);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool RobotFrameWork::tradeSellStop(double volume,double price)
  {
   MqlTradeRequest request= {};
   request.type_filling = sym_exec;
   request.action   =TRADE_ACTION_PENDING;
   request.symbol   =sym_name;
   request.magic    =sym_magic;
   request.volume   =volume;
   request.type     =ORDER_TYPE_SELL_STOP;
   request.price    =price;
   request.sl       =0;
   request.tp       =0;
   request.deviation=9999999;
   request.comment=sym_name;
   MqlTradeResult result= {};
   if(OrderSend(request,result) && (result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE))
     {
      return(true);
     }
   else
     {
      Print("Function tradeSell failed with error #", GetLastError(), " retcode #", result.retcode);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool RobotFrameWork::tradeSellStopLimit(double volume,double trigger)
  {
   MqlTradeRequest request= {};
   request.type_filling = sym_exec;
   request.action   =TRADE_ACTION_PENDING;
   request.symbol   =sym_name;
   request.magic    =sym_magic;
   request.volume   =volume;
   request.type     =ORDER_TYPE_SELL_STOP_LIMIT;
   request.price    =trigger;
   request.stoplimit=symbolAsk();
   request.sl       =0;
   request.tp       =0;
   request.deviation=9999999;
   request.comment=sym_name;
   MqlTradeResult result= {};
   if(OrderSend(request,result) && (result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE))
     {
      return(true);
     }
   else
     {
      Print("Function tradeSell failed with error #", GetLastError(), " retcode #", result.retcode);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool RobotFrameWork::tradeSellStopLimit(double volume,double trigger, double orderprice)
  {
   MqlTradeRequest request= {};
   request.type_filling = sym_exec;
   request.action   =TRADE_ACTION_PENDING;
   request.symbol   =sym_name;
   request.magic    =sym_magic;
   request.volume   =volume;
   request.type     =ORDER_TYPE_SELL_STOP_LIMIT;
   request.price    =trigger;
   request.stoplimit=orderprice;
   request.sl       =0;
   request.tp       =0;
   request.deviation=9999999;
   request.comment=sym_name;
   MqlTradeResult result= {};
   if(OrderSend(request,result) && (result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE))
     {
      return(true);
     }
   else
     {
      Print("Function tradeSell failed with error #", GetLastError(), " retcode #", result.retcode);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool RobotFrameWork::tradeAsk(double volume)
  {
   MqlTradeRequest request= {};
   request.type_filling = sym_exec;
   request.action   =TRADE_ACTION_PENDING;
   request.symbol   =sym_name;
   request.magic    =sym_magic;
   request.volume   =volume;
   request.type     =ORDER_TYPE_SELL_LIMIT;
   request.price    =symbolAsk() + sym_point;
   request.sl       =0;
   request.tp       =0;
   request.deviation=9999999;
   request.comment=sym_name;
   MqlTradeResult result= {};
   if(OrderSend(request,result) && (result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE))
     {
      return(true);
     }
   else
     {
      Print("Function tradeSell failed with error #", GetLastError(), " retcode #", result.retcode);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool RobotFrameWork::tradeAsk(double volume,double price)
  {
   MqlTradeRequest request= {};
   request.type_filling = sym_exec;
   request.action   =TRADE_ACTION_PENDING;
   request.symbol   =sym_name;
   request.magic    =sym_magic;
   request.volume   =volume;
   request.type     =ORDER_TYPE_SELL_LIMIT;
   request.price    =price;
   request.sl       =0;
   request.tp       =0;
   request.deviation=9999999;
   request.comment=sym_name;
   MqlTradeResult result= {};
   if(OrderSend(request,result) && (result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE))
     {
      return(true);
     }
   else
     {
      Print("Function tradeSell failed with error #", GetLastError(), " retcode #", result.retcode);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool RobotFrameWork::tradeClose(bool longOnly)
  {
   for(int i = PositionsTotal() - 1; i >= 0; i--)
     {
      long ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(ticket))
        {
         if(longOnly)
           {
            if(sym_name == PositionGetString(POSITION_SYMBOL) && PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_BUY)
              {
               MqlTradeRequest request= {};
               request.type_filling = sym_exec;
               // was DEAL
               request.action   =TRADE_ACTION_DEAL;

               request.magic=PositionGetInteger(POSITION_MAGIC);
               request.symbol=PositionGetString(POSITION_SYMBOL);
               request.volume=PositionGetDouble(POSITION_VOLUME);
               // WAS SELL
               request.type =ORDER_TYPE_SELL;

               request.price=SymbolInfoDouble(sym_name,SYMBOL_BID);
               request.position=PositionGetInteger(POSITION_TICKET);
               request.deviation = 999999999;
               MqlTradeResult result= {};
               if(OrderSend(request,result) && (result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE))
                 {

                 }
               else
                 {
                  Print("Function tradeCloseBuy failed with error #", GetLastError(), " retcode #", result.retcode);
                 }
              }
           }

         if(!longOnly)
           {
            if(sym_name == PositionGetString(POSITION_SYMBOL) && PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_SELL)
              {
               MqlTradeRequest request= {};
               request.type_filling = sym_exec;
               request.action   =TRADE_ACTION_DEAL;
               request.magic=PositionGetInteger(POSITION_MAGIC);
               request.symbol=PositionGetString(POSITION_SYMBOL);
               request.volume=PositionGetDouble(POSITION_VOLUME);
               request.type =ORDER_TYPE_BUY;
               request.price=SymbolInfoDouble(sym_name,SYMBOL_ASK);
               request.position=PositionGetInteger(POSITION_TICKET);
               request.deviation = 999999999;
               MqlTradeResult result= {};
               if(OrderSend(request,result) && (result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE))
                 {

                 }
               else
                 {
                  Print("Function tradeCloseSell failed with error #", GetLastError(), " retcode #", result.retcode);
                 }
              }
           }
        }
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|     Close open position with a limit order :                     |
//|     Netting account type only                                    |
//+------------------------------------------------------------------+
bool RobotFrameWork::tradeCloseLimit(bool longOnly)
  {
   for(int i = PositionsTotal() - 1; i >= 0; i--)
     {
      long ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(ticket))
        {
         if(longOnly)
           {
            if(sym_name == PositionGetString(POSITION_SYMBOL) && PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_BUY)
              {
               MqlTradeRequest request= {};
               request.type_filling = sym_exec;
               request.action   =TRADE_ACTION_CLOSE_BY;
               request.position = ticket;
               request.position_by=PositionGetInteger(POSITION_TICKET);
               request.magic=PositionGetInteger(POSITION_MAGIC);
               request.symbol=PositionGetString(POSITION_SYMBOL);
               request.volume=PositionGetDouble(POSITION_VOLUME);
               request.type =ORDER_TYPE_SELL_LIMIT;
               request.price=SymbolInfoDouble(sym_name,SYMBOL_ASK);
               MqlTradeResult result= {};
               if(OrderSend(request,result) && (result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE))
                 {
                  return(true);
                 }
               else
                 {
                  Print("Function tradeCloseBuy failed with error #", GetLastError(), " retcode #", result.retcode);
                 }
              }
           }

         if(!longOnly)
           {
            if(sym_name == PositionGetString(POSITION_SYMBOL) && PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_SELL)
              {
               MqlTradeRequest request= {};
               request.type_filling = sym_exec;
               request.action   =TRADE_ACTION_CLOSE_BY;
               request.position = ticket;
               request.position_by=PositionGetInteger(POSITION_TICKET);
               request.magic=PositionGetInteger(POSITION_MAGIC);
               request.symbol=PositionGetString(POSITION_SYMBOL);
               request.volume=PositionGetDouble(POSITION_VOLUME);
               request.type =ORDER_TYPE_BUY_LIMIT;
               request.price=SymbolInfoDouble(sym_name,SYMBOL_BID);
               MqlTradeResult result= {};
               if(OrderSend(request,result) && (result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE))
                 {
                  return(true);
                 }
               else
                 {
                  Print("Function tradeCloseSell failed with error #", GetLastError(), " retcode #", result.retcode);
                 }
              }
           }
        }
     }
   return(false);
  }
/*
 Set the stoploss and takeprofit based on a percentage value of the asset
*/
bool RobotFrameWork::tradeModifyPercent(bool longOnly, double tp, double sl)
  {
   for(int i = PositionsTotal() - 1; i >= 0; i--)
     {
      long ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(ticket))
        {
         if(longOnly)
           {
            if(sym_name == PositionGetString(POSITION_SYMBOL) && PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_BUY)
              {
               double e_tp = PositionGetDouble(POSITION_PRICE_OPEN) * (tp*0.01);
               double e_sl = PositionGetDouble(POSITION_PRICE_OPEN) * (sl*0.01);
               double entry_tp = PositionGetDouble(POSITION_PRICE_OPEN) + e_tp;
               double entry_sl = PositionGetDouble(POSITION_PRICE_OPEN) - e_sl;
               MqlTradeRequest request= {};
               request.action   =TRADE_ACTION_SLTP;
               request.magic=PositionGetInteger(POSITION_MAGIC);
               request.symbol=PositionGetString(POSITION_SYMBOL);
               request.sl      =NormalizeDouble(entry_sl, sym_digit_quote);;
               request.tp      =NormalizeDouble(entry_tp, sym_digit_quote);
               request.position=PositionGetInteger(POSITION_TICKET);
               MqlTradeResult result= {};
               if(OrderSend(request,result) && (result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE))
                 {
                  return(true);
                 }
               else
                 {
                  Print("Function tradeModifyBuyTPSL failed with error #", GetLastError(), " retcode #", result.retcode);
                 }
              }
           }

         if(!longOnly)
           {
            if(sym_name == PositionGetString(POSITION_SYMBOL) && PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_SELL)
              {
               double e_tp = PositionGetDouble(POSITION_PRICE_OPEN) * (tp*0.01);
               double e_sl = PositionGetDouble(POSITION_PRICE_OPEN) * (sl*0.01);
               double entry_tp = PositionGetDouble(POSITION_PRICE_OPEN) - e_tp;
               double entry_sl = PositionGetDouble(POSITION_PRICE_OPEN) + e_sl;
               MqlTradeRequest request= {};
               request.action   =TRADE_ACTION_SLTP;
               request.magic=PositionGetInteger(POSITION_MAGIC);
               request.symbol=PositionGetString(POSITION_SYMBOL);
               request.sl      =NormalizeDouble(entry_sl, sym_digit_quote);;
               request.tp      =NormalizeDouble(entry_tp, sym_digit_quote);
               request.position=PositionGetInteger(POSITION_TICKET);
               MqlTradeResult result= {};
               if(OrderSend(request,result) && (result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE))
                 {
                  return(true);
                 }
               else
                 {
                  Print("Function tradeModifySellTPSL failed with error #", GetLastError(), " retcode #", result.retcode);
                 }
              }
           }

        }
     }
   return(false);
  }
/*
 Check if the current price has already gone beyond the stoploss value
  - market close now
 Stoploss in Points
 - Fixed Amount in Points
*/
bool RobotFrameWork::tradeModifyFixed(bool longOnly, double tp, double sl)
  {

   for(int i = PositionsTotal() - 1; i >= 0; i--)
     {
      long ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(ticket))
        {
         if(longOnly)
           {
            if(sym_name == PositionGetString(POSITION_SYMBOL) && PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_BUY)
              {
               double entry_tp = PositionGetDouble(POSITION_PRICE_OPEN) + tp*sym_point;
               double entry_sl = PositionGetDouble(POSITION_PRICE_OPEN) - sl*sym_point;
               if(PositionGetDouble(POSITION_PRICE_CURRENT) < entry_sl)
                 {
                  tradeClose(true);
                 }
               else
                  if(PositionGetDouble(POSITION_SL) == 0 && PositionGetDouble(POSITION_TP) ==  0)
                    {
                     MqlTradeRequest request= {};
                     request.action   =TRADE_ACTION_SLTP;
                     request.magic=PositionGetInteger(POSITION_MAGIC);
                     request.symbol=PositionGetString(POSITION_SYMBOL);
                     request.sl      =NormalizeDouble(entry_sl, sym_digit_quote);;
                     request.tp      =NormalizeDouble(entry_tp, sym_digit_quote);
                     request.position=PositionGetInteger(POSITION_TICKET);
                     MqlTradeResult result= {};
                     if(OrderSend(request,result) && (result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE))
                       {
                        return(true);
                       }
                     else
                       {
                        Print("Function tradeModifyBuyTPSL failed with error #", GetLastError(), " retcode #", result.retcode);
                       }
                    }
              }
           }

         if(!longOnly)
           {
            if(sym_name == PositionGetString(POSITION_SYMBOL) && PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_SELL)
              {
               double entry_tp = PositionGetDouble(POSITION_PRICE_OPEN) - tp*sym_point;
               double entry_sl = PositionGetDouble(POSITION_PRICE_OPEN) + sl*sym_point;
               if(PositionGetDouble(POSITION_PRICE_CURRENT) > entry_sl)
                 {
                  tradeClose(false);
                 }
               else
                  if(PositionGetDouble(POSITION_SL) ==0 && PositionGetDouble(POSITION_TP)==0)
                    {
                     MqlTradeRequest request= {};
                     request.action   =TRADE_ACTION_SLTP;
                     request.magic=PositionGetInteger(POSITION_MAGIC);
                     request.symbol=PositionGetString(POSITION_SYMBOL);
                     request.sl      =NormalizeDouble(entry_sl, sym_digit_quote);;
                     request.tp      =NormalizeDouble(entry_tp, sym_digit_quote);
                     request.position=PositionGetInteger(POSITION_TICKET);
                     MqlTradeResult result= {};
                     if(OrderSend(request,result) && (result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE))
                       {
                        return(true);
                       }
                     else
                       {
                        Print("Function tradeModifySellTPSL failed with error #", GetLastError(), " retcode #", result.retcode);
                       }
                    }
              }
           }
        }
     }
   return(false);
  }
/*
 run tradeSetTPSL with your values then run this command
 - stoploss and takeprofit are in % values based on the assets price
 Market Close if the price has already moved beyond the Stoploss value
*/
bool RobotFrameWork::tradeModify(bool longOnly)
  {
   double tp = tradeTP;
   double sl = tradeSL;
   for(int i = PositionsTotal() - 1; i >= 0; i--)
     {
      long ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(ticket))
        {
         if(longOnly)
           {
            if(sym_name == PositionGetString(POSITION_SYMBOL) && PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_BUY)
              {
               double e_tp = PositionGetDouble(POSITION_PRICE_OPEN) * (tp*0.01);
               double e_sl = PositionGetDouble(POSITION_PRICE_OPEN) * (sl*0.01);
               double entry_tp = PositionGetDouble(POSITION_PRICE_OPEN) + e_tp;
               double entry_sl = PositionGetDouble(POSITION_PRICE_OPEN) - e_sl;
               if(PositionGetDouble(POSITION_PRICE_CURRENT) < entry_sl)
                 {
                  tradeClose(false);
                 }
               else
                 {
                  MqlTradeRequest request= {};
                  request.action   =TRADE_ACTION_SLTP;
                  request.magic=PositionGetInteger(POSITION_MAGIC);
                  request.symbol=PositionGetString(POSITION_SYMBOL);
                  request.sl      =NormalizeDouble(entry_sl, sym_digit_quote);;
                  request.tp      =NormalizeDouble(entry_tp, sym_digit_quote);
                  request.position=PositionGetInteger(POSITION_TICKET);
                  MqlTradeResult result= {};
                  if(OrderSend(request,result) && (result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE))
                    {
                     return(true);
                    }
                  else
                    {
                     Print("Function tradeModifyBuyTPSL failed with error #", GetLastError(), " retcode #", result.retcode);
                    }
                 }
              }
           }

         if(!longOnly)
           {
            if(sym_name == PositionGetString(POSITION_SYMBOL) && PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_SELL)
              {
               double e_tp = PositionGetDouble(POSITION_PRICE_OPEN) * (tp*0.01);
               double e_sl = PositionGetDouble(POSITION_PRICE_OPEN) * (sl*0.01);
               double entry_tp = PositionGetDouble(POSITION_PRICE_OPEN) - e_tp;
               double entry_sl = PositionGetDouble(POSITION_PRICE_OPEN) + e_sl;
               if(PositionGetDouble(POSITION_PRICE_CURRENT) > entry_sl)
                 {
                  tradeClose(false);
                 }
               else
                 {
                  MqlTradeRequest request= {};
                  request.action   =TRADE_ACTION_SLTP;
                  request.magic=PositionGetInteger(POSITION_MAGIC);
                  request.symbol=PositionGetString(POSITION_SYMBOL);
                  request.sl      =NormalizeDouble(entry_sl, sym_digit_quote);;
                  request.tp      =NormalizeDouble(entry_tp, sym_digit_quote);
                  request.position=PositionGetInteger(POSITION_TICKET);
                  MqlTradeResult result= {};
                  if(OrderSend(request,result) && (result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE))
                    {
                     return(true);
                    }
                  else
                    {
                     Print("Function tradeModifySellTPSL failed with error #", GetLastError(), " retcode #", result.retcode);
                    }
                 }
              }
           }

        }
     }
   return(false);
  }
/*

 Reduce the stoploss from the previous value
 - Do not tradeClose if this value is not met

*/

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool RobotFrameWork::tradeModifyFixedReduce(bool longOnly, double sl)
  {
   bool ok = false;
   for(int i = PositionsTotal() - 1; i >= 0; i--)
     {
      long ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(ticket))
        {
         if(longOnly)
           {
            if(sym_name == PositionGetString(POSITION_SYMBOL) && PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_BUY)
              {

               if(PositionGetDouble(POSITION_SL) < sl)
                 {
                  MqlTradeRequest request= {};
                  request.action   =TRADE_ACTION_SLTP;
                  request.magic=PositionGetInteger(POSITION_MAGIC);
                  request.symbol=PositionGetString(POSITION_SYMBOL);
                  request.sl      =NormalizeDouble(sl, sym_digit_quote);;
                  request.tp      =PositionGetDouble(POSITION_TP);
                  request.position=PositionGetInteger(POSITION_TICKET);
                  //--- send a trade request
                  MqlTradeResult result= {};
                  if(OrderSend(request,result) && (result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE))
                    {
                     ok = true;
                    }
                  else
                    {
                     Print("Function tradeModifyBuyTPSL failed with error #", GetLastError(), " retcode #", result.retcode);
                    }
                 }
              }
           }

         if(!longOnly)
           {
            if(sym_name == PositionGetString(POSITION_SYMBOL) && PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_SELL)
              {
               if(PositionGetDouble(POSITION_SL) > sl)
                 {
                  MqlTradeRequest request= {};
                  request.action   =TRADE_ACTION_SLTP;
                  request.magic=PositionGetInteger(POSITION_MAGIC);
                  request.symbol=PositionGetString(POSITION_SYMBOL);
                  request.sl      =NormalizeDouble(sl, sym_digit_quote);;
                  request.tp      =PositionGetDouble(POSITION_TP);
                  request.position=PositionGetInteger(POSITION_TICKET);
                  MqlTradeResult result= {};
                  if(OrderSend(request,result) && (result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE))
                    {
                     ok = true;
                    }
                  else
                    {
                     Print("Function tradeModifySellTPSL failed with error #", GetLastError(), " retcode #", result.retcode);
                    }
                 }
              }
           }
        }
     }
   return(ok);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool RobotFrameWork::tradeModifyTrailing(bool longOnly,double sl_price)
  {
   double sl = sl_price;
   for(int i = PositionsTotal() - 1; i >= 0; i--)
     {
      long ticket = PositionGetTicket(i);
      if(PositionSelectByTicket(ticket))
        {
         if(longOnly)
           {
            if(sym_name == PositionGetString(POSITION_SYMBOL)
               && PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_BUY
               && PositionGetDouble(POSITION_PRICE_OPEN) < sl
               && PositionGetDouble(POSITION_SL) != sl
              )
              {
               MqlTradeRequest request= {};
               request.action   =TRADE_ACTION_SLTP;
               request.magic=PositionGetInteger(POSITION_MAGIC);
               request.symbol=PositionGetString(POSITION_SYMBOL);
               request.sl      =NormalizeDouble(sl, sym_digit_quote);;
               request.position=PositionGetInteger(POSITION_TICKET);
               MqlTradeResult result= {};
               if(OrderSend(request,result) && (result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE))
                 {
                  return(true);
                 }
               else
                 {
                  Print("Function tradeModifyBuyTPSL failed with error #", GetLastError(), " retcode #", result.retcode);
                 }
              }
           }

         if(!longOnly)
           {
            if(sym_name == PositionGetString(POSITION_SYMBOL)
               && PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_SELL
               && PositionGetDouble(POSITION_PRICE_OPEN) > sl
               && PositionGetDouble(POSITION_SL) != sl
              )
              {
               MqlTradeRequest request= {};
               request.action   =TRADE_ACTION_SLTP;
               request.magic=PositionGetInteger(POSITION_MAGIC);
               request.symbol=PositionGetString(POSITION_SYMBOL);
               request.sl      =NormalizeDouble(sl, sym_digit_quote);;
               request.position=PositionGetInteger(POSITION_TICKET);
               MqlTradeResult result= {};
               if(OrderSend(request,result) && (result.retcode == TRADE_RETCODE_PLACED || result.retcode == TRADE_RETCODE_DONE))
                 {
                  return(true);
                 }
               else
                 {
                  Print("Function tradeModifySellTPSL failed with error #", GetLastError(), " retcode #", result.retcode);
                 }
              }
           }
        }
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double RobotFrameWork::moneyRiskOnBalance(bool brokerOnly, double exchangeBalance)
  {
   double lotsize = 0;
   if(brokerOnly)
     {
      double balanceBroker = AccountInfoDouble(ACCOUNT_BALANCE);
      double quoteAsset = symbolAsk();
      double lev = balanceBroker/ quoteAsset;
      lotsize = symbolNormalizeVolume(lev);
     }
   else
     {
      double balanceBroker = exchangeBalance;
      double quoteAsset = symbolAsk();
      double lev = balanceBroker/ quoteAsset;
      lotsize = symbolNormalizeVolume(lev);
     }
   return(lotsize);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string RobotFrameWork::moneyRiskOnPointsPlusCommission(bool ifLong, const string baseCurrency,const double balance, const double risk, const int slPoints, const double commissionPercent)
  {
   bool debug = false;
   if(((baseCurrency=="") || (balance == 0) || (risk == 0) || slPoints ==0) || (commissionPercent == 0))
     {
      return("");
     }
   if(debug)
     {
      Print("-------------------------------------------\n"+
            "(Balance " + balance  + " " + baseCurrency +
            "|Risk " + risk +
            "%|SL in Points " + slPoints +")");

     }
   /*
   QUOTE
   SL
   */
   const int asset_digits = SymbolInfoInteger(Symbol(), SYMBOL_DIGITS);
   const double asset_points = SymbolInfoDouble(Symbol(),SYMBOL_POINT);
   const double price = SymbolInfoDouble(Symbol(), SYMBOL_ASK);
   const double bid =   SymbolInfoDouble(Symbol(), SYMBOL_BID);
   const double spread = (price - bid);
   const double spread_points = spread / asset_points;
   const double asset_sl = asset_points * slPoints;
   if(debug)
     {
      Print("Asset Quote Ask: " + DoubleToString(price,asset_digits) + " Bid: " + DoubleToString(bid,asset_digits) + " Spread: " + DoubleToString(spread,asset_digits) + " in Points: " + DoubleToString(spread_points,0));
      Print("Stoploss based in Quote Value : " + DoubleToString(asset_sl,asset_digits) + " " + baseCurrency + " || Asset Quote Precision " + DoubleToString(asset_points,asset_digits));
     }
   /*
   RISK PER TRADE
   change 0.5% to math 0.005
   */
   const double riskP = risk*0.01;
   const double balanceAtRisk = balance * riskP;
   if(debug)
     {
      Print("Balance at risk if price hits Stoploss: " + balanceAtRisk + " " + baseCurrency);
     }
   /*
   COMMISSION
   open/close commission: 0.04% to math 0.0004
   how many points is the round turn commission equal to?
   */
   const double fee = commissionPercent*0.01;                                                     // Open or close
   const double feeRT = (commissionPercent*2)*0.01;                                                   // Open and Close
   const double fee0nOneUnit = price * feeRT;                                   // Asset Quote times RT commission

   const double maxPointsForSL = asset_sl + fee0nOneUnit;                       // Commission in Points + SL in points = Real Stoploss in points
   if(debug)
     {
      Print("RoundTurnFee(open/close) per unit: " + fee0nOneUnit);
      Print("Add RoundTurnFee to slPoints on one unit: " + maxPointsForSL);
     }
   /*
   POSITION SIZE
   position size = balanceAtRisk / SL;
   */
   const double units = balanceAtRisk / maxPointsForSL;
   const double commssionOnUnits = (feeRT*units)*price;
   if(debug)
     {
      Print("RoundTurnFee on Position Size " + DoubleToString(commssionOnUnits,8));
      Print("Position Size: " +  units + "(COIN) || Value in USD: " + units*price);
     }

   if(debug)
     {
      if(ifLong)
        {
         const double slAt = bid - asset_sl;
         Print("SL at price: " + DoubleToString(slAt,asset_digits));
        }

      if(!ifLong)
        {
         const double slAt = bid + asset_sl;
         Print("SL at price: " + DoubleToString(slAt,asset_digits));
        }
     }
   /*

   Check calculations

   */
   if(debug)
     {
      const double riskTotal = (units * asset_sl) +commssionOnUnits;
      Print("Check Calculations: (units*sl+commission) " + riskTotal  + " <==> Balance at Risk: " +balanceAtRisk);
     }


   /*
    binance USDT futures
    */
   if(baseCurrency == "USDT")
     {
      Print("Lotsize:(COIN) " +DoubleToString(units,3));
      return(DoubleToString(units,3));
     }
   /*
   bybit markets non usdt
   */
   if(baseCurrency != "USDT")
     {
      double lotUSD = units * price;;
      Print("Lotsize:(USD) " + lotUSD);
      return(DoubleToString(lotUSD,0));
     }
   return("");
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string RobotFrameWork::msTimer(bool inOut)
  {
   if(inOut)
     {
      ms_in = GetTickCount64();
     }
   if(!inOut)
     {
      ms_out = GetTickCount64();
      ulong ms = ms_out-ms_in;
      return("Function |msTimer| " +IntegerToString(ms) + " ms");
     }
   return("");
  }
//+------------------------------------------------------------------+
//| return error description                                         |
//+------------------------------------------------------------------+
string RobotFrameWork::errorCode(int value)
  {
   string errorStr;
   switch(value)
     {
      case 0:
         errorStr="The operation completed successfully";
         break;
      case 4001:
         errorStr="Unexpected internal error";
         break;
      case 4002:
         errorStr="Wrong parameter in the inner call of the client terminal function";
         break;
      case 4003:
         errorStr="Wrong parameter when calling the system function";
         break;
      case 4004:
         errorStr="Not enough memory to perform the system function";
         break;
      case 4005:
         errorStr="The structure contains objects of strings and/or dynamic arrays and/or structure of such objects and/or classes";
         break;
      case 4006:
         errorStr="Array of a wrong type, wrong size, or a damaged object of a dynamic array";
         break;
      case 4007:
         errorStr="Not enough memory for the relocation of an array, or an attempt to change the size of a static array";
         break;
      case 4008:
         errorStr="Not enough memory for the relocation of string";
         break;
      case 4009:
         errorStr="Not initialized string";
         break;
      case 4010:
         errorStr="Invalid date and/or time";
         break;
      case 4011:
         errorStr="Requested array size exceeds 2 GB";
         break;
      case 4012:
         errorStr="Wrong pointer";
         break;
      case 4013:
         errorStr="Wrong type of pointer";
         break;
      case 4014:
         errorStr="Function is not allowed for call";
         break;
      case 4015:
         errorStr="The names of the dynamic and the static resource match";
         break;
      case 4016:
         errorStr="Resource with this name has not been found in EX5";
         break;
      case 4017:
         errorStr="Unsupported resource type or its size exceeds 16 Mb";
         break;
      case 4018:
         errorStr="The resource name exceeds 63 charactersy";
         break;
      case 4101:
         errorStr="Wrong chart ID";
         break;
      case 4102:
         errorStr="Chart does not respond";
         break;
      case 4103:
         errorStr="Chart not found";
         break;
      case 4104:
         errorStr="No Expert Advisor in the chart that could handle the event";
         break;
      case 4105:
         errorStr="Chart opening error";
         break;
      case 4106:
         errorStr="Failed to change chart symbol and period";
         break;
      case 4107:
         errorStr="Error value of the parameter for the function of working with charts";
         break;
      case 4108:
         errorStr="Failed to create timer";
         break;
      case 4109:
         errorStr="Wrong chart property ID";
         break;
      case 4110:
         errorStr="Error creating screenshots";
         break;
      case 4111:
         errorStr="Error navigating through chart";
         break;
      case 4112:
         errorStr="Error applying template";
         break;
      case 4113:
         errorStr="Subwindow containing the indicator was not found";
         break;
      case 4114:
         errorStr="Error adding an indicator to chart";
         break;
      case 4115:
         errorStr="Error deleting an indicator from the chart";
         break;
      case 4116:
         errorStr="Indicator not found on the specified chart";
         break;
      case 4201:
         errorStr="Error working with a graphical object";
         break;
      case 4202:
         errorStr="Graphical object was not found";
         break;
      case 4203:
         errorStr="Wrong ID of a graphical object property";
         break;
      case 4204:
         errorStr="Unable to get date corresponding to the value";
         break;
      case 4205:
         errorStr="Unable to get value corresponding to the date";
         break;
      case 4301:
         errorStr="Unknown symbol";
         break;
      case 4302:
         errorStr="Symbol is not selected in MarketWatch";
         break;
      case 4303:
         errorStr="Wrong identifier of a symbol property";
         break;
      case 4304:
         errorStr="Time of the last tick is not known (no ticks)";
         break;
      case 4305:
         errorStr="Error adding or deleting a symbol in MarketWatch";
         break;
      case 4401:
         errorStr="Requested history not found";
         break;
      case 4402:
         errorStr="Wrong ID of the history property";
         break;
      case 4403:
         errorStr="Exceeded history request timeout";
         break;
      case 4404:
         errorStr="Number of requested bars limited by terminal settings";
         break;
      case 4405:
         errorStr="Multiple errors when loading history";
         break;
      case 4407:
         errorStr="Receiving array is too small to store all requested data";
         break;
      case 4501:
         errorStr="Global variable of the client terminal is not found";
         break;
      case 4502:
         errorStr="Global variable of the client terminal with the same name already exists";
         break;
      case 4510:
         errorStr="Email sending failed";
         break;
      case 4511:
         errorStr="Sound playing failed";
         break;
      case 4512:
         errorStr="Wrong identifier of the program property";
         break;
      case 4513:
         errorStr="Wrong identifier of the terminal property";
         break;
      case 4514:
         errorStr="File sending via ftp failed";
         break;
      case 4515:
         errorStr="Failed to send a notification";
         break;
      case 4516:
         errorStr="Invalid parameter for sending a notification — an empty string or NULL has been passed to the SendNotification() function";
         break;
      case 4517:
         errorStr="Wrong settings of notifications in the terminal (ID is not specified or permission is not set)";
         break;
      case 4518:
         errorStr="Too frequent sending of notifications";
         break;
      case 4519:
         errorStr="FTP server is not specified";
         break;
      case 4520:
         errorStr="FTP login is not specified";
         break;
      case 4521:
         errorStr="File not found in the MQL5\\Files directory to send on FTP server";
         break;
      case 4522:
         errorStr="FTP connection failed";
         break;
      case 4523:
         errorStr="FTP path not found on server";
         break;
      case 4524:
         errorStr="FTP connection closed";
         break;
      case 4601:
         errorStr="Not enough memory for the distribution of indicator buffers";
         break;
      case 4602:
         errorStr="Wrong indicator buffer index";
         break;
      case 4603:
         errorStr="Wrong ID of the custom indicator property";
         break;
      case 4701:
         errorStr="Wrong account property ID";
         break;
      case 4751:
         errorStr="Wrong trade property ID";
         break;
      case 4752:
         errorStr="Trading by Expert Advisors prohibited";
         break;
      case 4753:
         errorStr="Position not found";
         break;
      case 4754:
         errorStr="Order not found";
         break;
      case 4755:
         errorStr="Deal not found";
         break;
      case 4756:
         errorStr="Trade request sending failed";
         break;
      case 4801:
         errorStr="Unknown symbol";
         break;
      case 4802:
         errorStr="Indicator cannot be created";
         break;
      case 4803:
         errorStr="Not enough memory to add the indicator";
         break;
      case 4804:
         errorStr="The indicator cannot be applied to another indicator";
         break;
      case 4805:
         errorStr="Error applying an indicator to chart";
         break;
      case 4806:
         errorStr="Requested data not found";
         break;
      case 4807:
         errorStr="Wrong indicator handle";
         break;
      case 4808:
         errorStr="Wrong number of parameters when creating an indicator";
         break;
      case 4809:
         errorStr="No parameters when creating an indicator";
         break;
      case 4810:
         errorStr="The first parameter in the array must be the name of the custom indicator";
         break;
      case 4811:
         errorStr="Invalid parameter type in the array when creating an indicator";
         break;
      case 4812:
         errorStr="Wrong index of the requested indicator buffer";
         break;
      case 4901:
         errorStr="Depth Of Market can not be added";
         break;
      case 4902:
         errorStr="Depth Of Market can not be removed";
         break;
      case 4903:
         errorStr="The data from Depth Of Market can not be obtained";
         break;
      case 4904:
         errorStr="Error in subscribing to receive new data from Depth Of Market";
         break;
      case 5001:
         errorStr="More than 64 files cannot be opened at the same time";
         break;
      case 5002:
         errorStr="Invalid file name";
         break;
      case 5003:
         errorStr="Too long file name";
         break;
      case 5004:
         errorStr="File opening error";
         break;
      case 5005:
         errorStr="Not enough memory for cache to read";
         break;
      case 5006:
         errorStr="File deleting error";
         break;
      case 5007:
         errorStr="A file with this handle was closed, or was not opening at all";
         break;
      case 5008:
         errorStr="Wrong file handle";
         break;
      case 5009:
         errorStr="The file must be opened for writing";
         break;
      case 5010:
         errorStr="The file must be opened for reading";
         break;
      case 5011:
         errorStr="The file must be opened as a binary one";
         break;
      case 5012:
         errorStr="The file must be opened as a text";
         break;
      case 5013:
         errorStr="The file must be opened as a text or CSV";
         break;
      case 5014:
         errorStr="The file must be opened as CSV";
         break;
      case 5015:
         errorStr="File reading error";
         break;
      case 5016:
         errorStr="String size must be specified, because the file is opened as binary";
         break;
      case 5017:
         errorStr="A text file must be for string arrays, for other arrays - binary";
         break;
      case 5018:
         errorStr="This is not a file, this is a directory";
         break;
      case 5019:
         errorStr="File does not exist";
         break;
      case 5020:
         errorStr="File can not be rewritten";
         break;
      case 5021:
         errorStr="Wrong directory name";
         break;
      case 5022:
         errorStr="Directory does not exist";
         break;
      case 5023:
         errorStr="This is a file, not a directory";
         break;
      case 5024:
         errorStr="The directory cannot be removed";
         break;
      case 5025:
         errorStr="Failed to clear the directory (probably one or more files are blocked and removal operation failed)";
         break;
      case 5026:
         errorStr="Failed to write a resource to a file";
         break;
      case 5027:
         errorStr="Unable to read the next piece of data from a CSV file (FileReadString, FileReadNumber, FileReadDatetime, FileReadBool), since the end of file is reached";
         break;
      case 5030:
         errorStr="No date in the string";
         break;
      case 5031:
         errorStr="Wrong date in the string";
         break;
      case 5032:
         errorStr="Wrong time in the string";
         break;
      case 5033:
         errorStr="Error converting string to date";
         break;
      case 5034:
         errorStr="Not enough memory for the string";
         break;
      case 5035:
         errorStr="The string length is less than expected";
         break;
      case 5036:
         errorStr="Too large number, more than ULONG_MAX";
         break;
      case 5037:
         errorStr="Invalid format string";
         break;
      case 5038:
         errorStr="Amount of format specifiers more than the parameters";
         break;
      case 5039:
         errorStr="Amount of parameters more than the format specifiers";
         break;
      case 5040:
         errorStr="Damaged parameter of string type";
         break;
      case 5041:
         errorStr="Position outside the string";
         break;
      case 5042:
         errorStr="0 added to the string end, a useless operation";
         break;
      case 5043:
         errorStr="Unknown data type when converting to a string";
         break;
      case 5044:
         errorStr="Damaged string object";
         break;
      case 5050:
         errorStr="Copying incompatible arrays. String array can be copied only to a string array, and a numeric array - in numeric array only";
         break;
      case 5051:
         errorStr="The receiving array is declared as AS_SERIES, and it is of insufficient size";
         break;
      case 5052:
         errorStr="Too small array, the starting position is outside the array";
         break;
      case 5053:
         errorStr="An array of zero length";
         break;
      case 5054:
         errorStr="Must be a numeric array";
         break;
      case 5055:
         errorStr="Must be a one-dimensional array";
         break;
      case 5056:
         errorStr="Timeseries cannot be used";
         break;
      case 5057:
         errorStr="Must be an array of type double";
         break;
      case 5058:
         errorStr="Must be an array of type float";
         break;
      case 5059:
         errorStr="Must be an array of type long";
         break;
      case 5060:
         errorStr="Must be an array of type int";
         break;
      case 5061:
         errorStr="Must be an array of type short";
         break;
      case 5062:
         errorStr="Must be an array of type char";
         break;
      case 5100:
         errorStr="OpenCL functions are not supported on this computer";
         break;
      case 5101:
         errorStr="Internal error occurred when running OpenCL";
         break;
      case 5102:
         errorStr="Invalid OpenCL handle";
         break;
      case 5103:
         errorStr="Error creating the OpenCL context";
         break;
      case 5104:
         errorStr="Failed to create a run queue in OpenCL";
         break;
      case 5105:
         errorStr="Error occurred when compiling an OpenCL program";
         break;
      case 5106:
         errorStr="Too long kernel name (OpenCL kernel)";
         break;
      case 5107:
         errorStr="Error creating an OpenCL kernel";
         break;
      case 5108:
         errorStr="Error occurred when setting parameters for the OpenCL kernel";
         break;
      case 5109:
         errorStr="OpenCL program runtime error";
         break;
      case 5110:
         errorStr="Invalid size of the OpenCL buffer";
         break;
      case 5111:
         errorStr="Invalid offset in the OpenCL buffer";
         break;
      case 5112:
         errorStr="Failed to create an OpenCL buffer";
         break;
      case 5200:
         errorStr="Invalid URL";
         break;
      case 5201:
         errorStr="Failed to connect to specified URL";
         break;
      case 5202:
         errorStr="Timeout exceeded";
         break;
      case 5203:
         errorStr="HTTP request failed";
      case 5300:
         errorStr="A custom symbol must be specified";
         break;
      case 5301:
         errorStr="The name of the custom symbol is invalid. The symbol name can only contain Latin letters without punctuation, spaces or special characters (may only contain '.', '_', '&' and '#'). It is not recommended to use characters <, >, :, ', /,\\, |, ?, *.";
         break;
      case 5302:
         errorStr="The name of the custom symbol is too long. The length of the symbol name must not exceed 32 characters including the ending 0 character";
         break;
      case 5303:
         errorStr="The path of the custom symbol is too long. The path length should not exceed 128 characters including 'Custom\\', the symbol name, group separators and the ending 0";
         break;
      case 5304:
         errorStr="A custom symbol with the same name already exists";
         break;
      case 5305:
         errorStr="Error occurred while creating, deleting or changing the custom symbol";
         break;
      case 5306:
         errorStr="You are trying to delete a custom symbol selected in Market Watch";
         break;
      case 5307:
         errorStr="An invalid custom symbol property";
         break;
      case 5308:
         errorStr="A wrong parameter while setting the property of a custom symbol";
         break;
      case 5309:
         errorStr="A too long string parameter while setting the property of a custom symbol";
         break;
      case 5310:
         errorStr="Ticks in the array are not arranged in the order of time";
         break;
      case 65536:
         errorStr="User defined errors start with this code";
         break;
      default:
         errorStr="unknown error";
     }
//---
   return(errorStr);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string RobotFrameWork::errorRetCode(int value)
  {
   string retcodeStr;
//---
   switch(value)
     {
      //--- codes returned from trade server
      case 10004:
         retcodeStr="Requote";
         break;
      case 10006:
         retcodeStr="Request rejected";
         break;
      case 10007:
         retcodeStr="Request canceled by trader";
         break;
      case 10008:
         retcodeStr="Order placed";
         break;
      case 10009:
         retcodeStr="Request completed";
         break;
      case 10010:
         retcodeStr="Only part of the request was completed";
         break;
      case 10011:
         retcodeStr="Request processing error";
         break;
      case 10012:
         retcodeStr="Request canceled by timeout";
         break;
      case 10013:
         retcodeStr="Invalid request";
         break;
      case 10014:
         retcodeStr="Invalid volume in the request";
         break;
      case 10015:
         retcodeStr="Invalid price in the request";
         break;
      case 10016:
         retcodeStr="Invalid stops in the request";
         break;
      case 10017:
         retcodeStr="Trade is disabled";
         break;
      case 10018:
         retcodeStr="Market is closed";
         break;
      case 10019:
         retcodeStr="There is not enough money to complete the request";
         break;
      case 10020:
         retcodeStr="Prices changed";
         break;
      case 10021:
         retcodeStr="There are no quotes to process the request";
         break;
      case 10022:
         retcodeStr="Invalid order expiration date in the request";
         break;
      case 10023:
         retcodeStr="Order state changed";
         break;
      case 10024:
         retcodeStr="Too frequent requests";
         break;
      case 10025:
         retcodeStr="No changes in request";
         break;
      case 10026:
         retcodeStr="Autotrading disabled by server";
         break;
      case 10027:
         retcodeStr="Autotrading disabled by client terminal";
         break;
      case 10028:
         retcodeStr="Request locked for processing";
         break;
      case 10029:
         retcodeStr="Order or position frozen";
         break;
      case 10030:
         retcodeStr="Invalid order filling type";
         break;
      case 10031:
         retcodeStr="No connection with the trade server";
         break;
      case 10032:
         retcodeStr="Operation is allowed only for live accounts";
         break;
      case 10033:
         retcodeStr="The number of pending orders has reached the limit";
         break;
      case 10034:
         retcodeStr="The volume of orders and positions for the symbol has reached the limit";
         break;
      case 10035:
         retcodeStr="Incorrect or prohibited order type";
         break;
      case 10036:
         retcodeStr="Position with the specified POSITION_IDENTIFIER has already been closed";
         break;
      case 10038:
         retcodeStr="A close volume exceeds the current position volume";
         break;
      case 10039:
         retcodeStr="A close order already exists for a specified position. This may happen when working in the hedging system:           \n"+
                    "1) when attempting to close a position with an opposite one, while close orders for the position already exist   \n"+
                    "2) when attempting to fully or partially close a position if the total volume of the already present close orders\n"+
                    "and the newly placed one exceeds the current position volume";
         break;

      default:
         retcodeStr="unknown error";
     }
//---
   return(retcodeStr);
  }


/*
 Child Class
 inheritance from the RobotFrameWork class

class CChild: public RobotFrameWork
  {
private:
   bool              function_private();

protected:
   bool              function_protected();

public:
   bool              function();

  };
*/

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, TradingToolCrypto Corp"
#property link "https://github.com/TradingToolCrypto"
#property version "1.00"

#include <TradingToolCrypto/TT/RobotFrameWork.mqh>
#include <TradingToolCrypto/CBP/CryptoBridgeProClass.mqh>
CryptoBridge bridge;
class CBPFrameWork: public RobotFrameWork
  {
private:
   string            frameworkPrefix;
   string            exchangeName;
public:
                     CBPFrameWork();
                    ~CBPFrameWork();

   bool              hedgeMode(bool hedgemode);

   bool              tradeBuy(double volume);
   bool              tradeSell(double volume);

   bool              tradeBuyStop(double volume);
   bool              tradeSellStop(double volume);
   bool              tradeBuyStop(double volume,double price);
   bool              tradeSellStop(double volume, double price);

   bool              tradeBuyStopLimit(double volume,double trigger);
   bool              tradeSellStopLimit(double volume,double trigger);
   bool              tradeBuyStopLimit(double volume,double trigger, double orderprice);
   bool              tradeSellStopLimit(double volume,double trigger,double orderprice);

   bool              tradeBid(double volume);
   bool              tradeAsk(double volume);
   bool              tradeBid(double volume, double price);
   bool              tradeAsk(double volume, double price);
   //--- HEDGE MODE CLOSE ORDERS --
   bool              tradeCloseMarket(bool isLong, double volume);
   bool              tradeCloseLimit(bool isLong, double volume);
   bool              tradeCloseLimit(bool isLong,double volume, double price);
   bool              tradeCloseStop(double volume);
   bool              tradeCloseStop(double volume, double price);
   bool              tradeCloseStopLimit(double volume, double trigger);
   bool              tradeCloseStopLimit(double volume, double trigger, double orderprice);
   //--- HEDGE MODE CLOSE ORDERS --

   bool              tradeDelete(string orderid);
   bool              tradeDeleteAll();
   bool              tradeDeleteAll(bool longOnly);
   bool              tradeDeleteLimit(bool longOnly);
   bool              tradeDeleteStop(bool longOnly);

   int               orderPending();
   int               orderPendingLimitLong;
   int               orderPendingLimitShort;
   int               orderPendingStopLimitLong;
   int               orderPendingStopLimitShort;
   int               orderPendingStopLong;
   int               orderPendingStopShort;

   bool              orderPendingTriggered(bool isLong, double bid, double ask, bool limit, bool stop, bool stoplimit);

   bool              positionTotal();
   int               positionTotalLong;
   int               positionTotalShort;
   double            position_avg_price_sell;
   double            position_avg_price_buy;
   double            position_volume_sell;
   double            position_volume_buy;

   bool              balance(string baseCurrency, int x_axis, int y_axis);
   double            balanceBaseCurrency;

   bool              volume(bool ifLong, const string baseCurrency,const double balanceInBase, const double riskPercentage, const double slPoints, const double commissionPercent);
   double            volumeUnits;
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CBPFrameWork::CBPFrameWork()
  {
   exchangeName = bridge.Get_Exchange_Name(Exchange_Number);
  // frameworkPrefix = (string)Exchange_Number + "." + exchangeName + ".";//binance 
   frameworkPrefix = (string)Exchange_Number + exchangeName;
   RobotFrameWork::Init_Symbol(Symbol());

   Print(" Check RobotFrameWork Symbol's Price " + RobotFrameWork::symbolAsk());

   if(bridge.Init_Api_Keys(Exchange_Number))
     {
      Print("CBPFrameWork Initization Loaded Api Keys");
     }
   else
     {
      Print("CBPFrameWork Initization Failed to load Api Keys");
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CBPFrameWork::~CBPFrameWork()
  {
   bridge.Deinit_Api_Keys(Exchange_Number);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::hedgeMode(bool hedgemode)
  {
   return(bridge.Hedge_Mode(hedgemode,Exchange_Number));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeBuy(double volume)
  {
   string order_id = frameworkPrefix  + GetTickCount64();
   if(bridge.Open_Trade(Exchange_Symbol_Name,"BUY","MARKET",DoubleToString(volume,Exchange_Lot_Precision),"",Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number,order_id))
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeSell(double volume)
  {
   string order_id = frameworkPrefix  + GetTickCount64();
   if(bridge.Open_Trade(Exchange_Symbol_Name,"SELL","MARKET",DoubleToString(volume,Exchange_Lot_Precision),"",Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number,order_id))
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeBuyStop(double volume)
  {
   string order_id = frameworkPrefix  + GetTickCount64();
   double ask = RobotFrameWork::symbolAsk();
   if(bridge.Open_Trade_Stop(Exchange_Symbol_Name,"BUY","STOP_LOSS",DoubleToString(volume,Exchange_Lot_Precision),DoubleToString(ask,Exchange_Quote_Precision),Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number,order_id))
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeSellStop(double volume)
  {
   string order_id = frameworkPrefix  + GetTickCount64();
   double bid = RobotFrameWork::symbolBid();
   if(bridge.Open_Trade_Stop(Exchange_Symbol_Name,"SELL","STOP_LOSS",DoubleToString(volume,Exchange_Lot_Precision),DoubleToString(bid,Exchange_Quote_Precision),Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number,order_id))
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeBuyStop(double volume, double price)
  {
   string order_id = frameworkPrefix + GetTickCount64();
   if(bridge.Open_Trade_Stop(Exchange_Symbol_Name,"BUY","STOP_LOSS",DoubleToString(volume,Exchange_Lot_Precision),DoubleToString(price,Exchange_Quote_Precision),Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number,order_id))
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeSellStop(double volume, double price)
  {
   string order_id = frameworkPrefix + GetTickCount64();
   if(bridge.Open_Trade_Stop(Exchange_Symbol_Name,"SELL","STOP_LOSS",DoubleToString(volume,Exchange_Lot_Precision),DoubleToString(price,Exchange_Quote_Precision),Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number,order_id))
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeBid(double volume)
  {
   string order_id = frameworkPrefix  + GetTickCount64();
   double bid = RobotFrameWork::symbolBid();
   if(bridge.Open_Trade(Exchange_Symbol_Name,"BUY","LIMIT",DoubleToString(volume,Exchange_Lot_Precision),DoubleToString(bid,Exchange_Quote_Precision),Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number,order_id))
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeAsk(double volume)
  {
   string order_id = frameworkPrefix  + GetTickCount64();
   double ask = RobotFrameWork::symbolAsk();
   if(bridge.Open_Trade(Exchange_Symbol_Name,"SELL","LIMIT",DoubleToString(volume,Exchange_Lot_Precision),DoubleToString(ask,Exchange_Quote_Precision),Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number,order_id))
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeBid(double volume, double price)
  {
   string order_id = frameworkPrefix  + GetTickCount64();
   if(bridge.Open_Trade(Exchange_Symbol_Name,"BUY","LIMIT",DoubleToString(volume,Exchange_Lot_Precision),DoubleToString(price,Exchange_Quote_Precision),Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number,order_id))
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeAsk(double volume, double price)
  {
   string order_id = frameworkPrefix  + GetTickCount64();
   if(bridge.Open_Trade(Exchange_Symbol_Name,"SELL","LIMIT",DoubleToString(volume,Exchange_Lot_Precision),DoubleToString(price,Exchange_Quote_Precision),Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number,order_id))
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeBuyStopLimit(double volume,double trigger)
  {
   string order_id = frameworkPrefix  + GetTickCount64();
   double price = RobotFrameWork::symbolBid();
   if(bridge.Open_Trade_StopLimit(Exchange_Symbol_Name,"BUY","STOP_LOSS_LIMIT",DoubleToString(volume,Exchange_Lot_Precision),DoubleToString(price,Exchange_Quote_Precision),DoubleToString(trigger,Exchange_Quote_Precision),Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number,order_id))
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeSellStopLimit(double volume,double trigger)
  {
   string order_id = frameworkPrefix  + GetTickCount64();
   double price = RobotFrameWork::symbolAsk();
   if(bridge.Open_Trade_StopLimit(Exchange_Symbol_Name,"SELL","STOP_LOSS_LIMIT",DoubleToString(volume,Exchange_Lot_Precision),DoubleToString(price,Exchange_Quote_Precision),DoubleToString(trigger,Exchange_Quote_Precision),Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number,order_id))
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeBuyStopLimit(double volume,double trigger, double orderprice)
  {
   string order_id = frameworkPrefix  + GetTickCount64();
   double price = orderprice;
   if(bridge.Open_Trade_StopLimit(Exchange_Symbol_Name,"BUY","STOP_LOSS_LIMIT",DoubleToString(volume,Exchange_Lot_Precision),DoubleToString(price,Exchange_Quote_Precision),DoubleToString(trigger,Exchange_Quote_Precision),Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number,order_id))
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeSellStopLimit(double volume,double trigger, double orderprice)
  {
   string order_id = frameworkPrefix  + GetTickCount64();
   double price = orderprice;
   if(bridge.Open_Trade_StopLimit(Exchange_Symbol_Name,"SELL","STOP_LOSS_LIMIT",DoubleToString(volume,Exchange_Lot_Precision),DoubleToString(price,Exchange_Quote_Precision),DoubleToString(trigger,Exchange_Quote_Precision),Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number,order_id))
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeCloseMarket(bool isLong, double volume)
  {
   if(isLong)
     {
      if(bridge.Margin_Close_Position(Exchange_Symbol_Name,"SELL","MARKET",DoubleToString(volume,Exchange_Lot_Precision), "",Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number))
        {
         return(true);
        }
     }
   if(!isLong)
     {
      if(bridge.Margin_Close_Position(Exchange_Symbol_Name,"BUY","MARKET",DoubleToString(volume,Exchange_Lot_Precision), "",Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number))
        {
         return(true);
        }
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeCloseLimit(bool isLong, double volume)
  {
   if(isLong)
     {
      double price = RobotFrameWork::symbolAsk();
      if(bridge.Margin_Close_Position(Exchange_Symbol_Name,"SELL","LIMIT",DoubleToString(volume,Exchange_Lot_Precision), DoubleToString(price, Exchange_Quote_Precision),Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number))
        {
         return(true);
        }
     }
   if(!isLong)
     {
      double price = RobotFrameWork::symbolBid();
      if(bridge.Margin_Close_Position(Exchange_Symbol_Name,"BUY","LIMIT",DoubleToString(volume,Exchange_Lot_Precision), DoubleToString(price, Exchange_Quote_Precision),Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number))
        {
         return(true);
        }
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeCloseLimit(bool isLong, double volume, double price)
  {
   if(isLong)
     {

      if(bridge.Margin_Close_Position(Exchange_Symbol_Name,"SELL","LIMIT",DoubleToString(volume,Exchange_Lot_Precision), DoubleToString(price, Exchange_Quote_Precision),Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number))
        {
         return(true);
        }
     }
   if(!isLong)
     {

      if(bridge.Margin_Close_Position(Exchange_Symbol_Name,"BUY","LIMIT",DoubleToString(volume,Exchange_Lot_Precision), DoubleToString(price, Exchange_Quote_Precision),Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number))
        {
         return(true);
        }
     }
   return(false);
  }
/*

   run this function once and get the position exist within
   tradeTotalLong;
   tradeTotalShort;

   Currently exchanges only allow 1 position (netting), while binanceFutures allow 1 buy and 1 sell
   - however, this could change in the future with Hedging Account Types

*/
bool CBPFrameWork::positionTotal()
  {
   positionTotalLong = 0;
   positionTotalShort = 0;
   position_avg_price_sell=0;
   position_avg_price_buy=0;
   position_volume_sell=0;
   position_volume_buy=0;

   if(bridge.Get_Position(Exchange_Symbol_Name,Exchange_Number,Exchange_Quote_Precision))
     {
      bridge.Parse_Positions(exchangeName,275,200,Exchange_Quote_Precision);
      int loop = ArraySize(exchange_name_p);
      if(loop == 0)
        {
         return(true);
        }
      for(int i = 0; i<loop; i++)
        {
         if(Exchange_Symbol_Name ==  exchange_symbol_p[i])
           {
            if(exchange_orderside_p[i] == "BUY")
              {
               positionTotalLong++;
               position_avg_price_buy = exchange_orderprice_p[i];
               position_volume_buy = exchange_ordersize_p[i];
              }
            if(exchange_orderside_p[i] == "SELL")
              {
               positionTotalShort++;
               position_avg_price_sell = exchange_orderprice_p[i];
               position_volume_sell = exchange_ordersize_p[i];
              }
           }
        }
      return(true);
     }
   else
     {
      Print("Failed to Get_Position: " + exchangeName);
     }
   return(false);
  }

/*
   int               tradeTotalPendingLimitLong;
   int               tradeTotalPendingLimitShort;
   int               tradeTotalPendingStopLong;
   int               tradeTotalPendingStopShort;
*/
int CBPFrameWork::orderPending()
  {
   int loop = 0;
   orderPendingLimitLong = 0;
   orderPendingStopLong = 0;
   orderPendingStopLimitLong = 0;

   orderPendingLimitShort = 0;
   orderPendingStopShort = 0;
   orderPendingStopLimitShort = 0;

   if(bridge.Get_OpenOrders(Exchange_Symbol_Name,Exchange_Number,Exchange_Quote_Precision))
     {
      bridge.Parse_Orders(exchangeName,640, 1000);
      loop = ArraySize(exchange_name);
      for(int i = 0; i<loop; i++)
        {
         if(Exchange_Symbol_Name ==  exchange_symbol[i])
           {


            if(exchange_orderside[i] == "BUY")
              {
               if(exchange_ordertype[i] == "LIMIT")
                 {
                  orderPendingLimitLong++;
                 }
               if(exchange_ordertype[i] == "STOPMARKET")
                 {
                  orderPendingStopLong++;
                 }
               if(exchange_ordertype[i] == "STOPLIMIT")
                 {
                  orderPendingStopLimitLong++;
                 }
              }


            if(exchange_orderside[i] == "SELL")
              {
               if(exchange_ordertype[i] == "LIMIT")
                 {
                  orderPendingLimitShort++;
                 }
               if(exchange_ordertype[i] == "STOPMARKET")
                 {
                  orderPendingStopShort++;
                 }
               if(exchange_ordertype[i] == "STOPLIMIT")
                 {
                  orderPendingStopLimitShort++;
                 }
              }


           }
        }
     }
   return(loop);
  }

//+------------------------------------------------------------------+
/*
   bool              tradeDelete(string orderid);
   bool              tradeDeleteAll();
   bool              tradeDeleteAll(bool longOnly);
   bool              tradeDeleteLimit(bool longOnly);
   bool              tradeDeleteStop(bool longOnly);
*/
bool CBPFrameWork::tradeDelete(string orderid)
  {
   if(bridge.Cancel_Trade(Exchange_Symbol_Name,orderid,Exchange_Number,0,""))
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeDeleteAll()
  {

   if(bridge.Cancel_Trade_All(Exchange_Symbol_Name,Exchange_Number))
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::balance(string baseCurrency, int x_axis, int y_axis)
  {
   if(bridge.Get_Balance("","", Exchange_Number))
     {
      bridge.Parse_Wallets(exchangeName,x_axis,y_axis);
     }
   else
     {
      Alert("Failed to get Exchange Balance");
      return(false);
     }
   double balanceBase = 0;
   double balanceUSD = 0;
   int loop = ArraySize(exchange_wallets);
   for(int i = 0; i<loop; i++)
     {
      if(exchange_wallets[i] == baseCurrency)
         balanceBase = exchange_wallets_balance[i];
      break;
     }
   if((baseCurrency == "USDT") || (baseCurrency == "USD"))
     {
      balanceBaseCurrency = balanceBase;
     }
   else
     {
      if(bridge.Get_Price(Exchange_Symbol_Name,Exchange_Number,Exchange_Quote_Precision))
        {
         int id = bridge.Get_UniqueID();
         /*
         need to update the libs to add the echange id
         id + GLOBAL_Parse_Separator +  
         */
         double quote = GlobalVariableGet(exchangeName + GLOBAL_Parse_Separator + Exchange_Symbol_Name +GLOBAL_Parse_Separator +"Ask");
         balanceBaseCurrency = quote*balanceBase;
        }
     }
   return(true);
  }
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::volume(bool ifLong, const string baseCurrency,const double balanceInBase, const double riskPercentage, const double slPoints, const double commissionPercent)
  {
   if((baseCurrency=="") || (balanceInBase == 0) || (riskPercentage == 0) || (slPoints ==0) || (commissionPercent == 0))
     {
      return(false);
     }

   const double price = RobotFrameWork::symbolAsk();
   const double bid =   RobotFrameWork::symbolBid();
   const double spread = (price - bid);
   const double spread_points = spread /  RobotFrameWork::symbolPoint();
   const double asset_sl = slPoints;
   const double riskP = riskPercentage*0.01;
   const double balanceAtRisk = balanceInBase * riskP;
   const double fee = commissionPercent*0.01;
   const double feeRT = (commissionPercent*2)*0.01;
   const double fee0nOneUnit = price * feeRT;
   const double maxPointsForSL = asset_sl + fee0nOneUnit;
   const double units = balanceAtRisk / maxPointsForSL;
   const double commssionOnUnits = (feeRT*units)*price;
   const double riskTotal = (units * asset_sl) +commssionOnUnits;
   /*
    binance USDT futures
    */
   if(baseCurrency == "USDT")
     {
      volumeUnits = units;
     }
   /*
   bybit markets non usdt
   */
   if(baseCurrency != "USDT")
     {
      volumeUnits = units * price;;
     }
   return(true);
  }
//+------------------------------------------------------------------+
bool CBPFrameWork::orderPendingTriggered(bool isLong,double bid,double ask,bool limit,bool stop,bool stoplimit)
  {

   int loop = ArraySize(exchange_name);

   if(loop == 0)
     {
      return(false);
     }

   for(int i = 0; i< loop; i++)
     {

      if(isLong)
        {
         if(limit)
           {
            if(bid <= exchange_orderprice[i] && exchange_orderside[i] == "BUY" && exchange_ordertype[i] == "LIMIT" )
              {
               return(true);
              }
           }
         if(stop)
           {
            if(ask >= exchange_orderprice[i] && exchange_orderside[i] == "BUY" && exchange_ordertype[i] == "STOPMARKET")
              {
               return(true);
              }
           }
         if(stoplimit)
           {

           }
        }
      else
        {
         if(limit)
           {
            if(ask >= exchange_orderprice[i] && exchange_orderside[i] == "SELL" && exchange_ordertype[i] == "LIMIT")
              {
               return(true);
              }
           }
         if(stop)
           {
            if(bid <= exchange_orderprice[i] && exchange_orderside[i] == "SELL" && exchange_ordertype[i] == "STOPMARKET")
              {
               return(true);
              }
           }
         if(stoplimit)
           {

           }
        }
     }
   return(false);
  }
//+------------------------------------------------------------------+

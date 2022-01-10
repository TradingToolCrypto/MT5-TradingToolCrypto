/*

 - How to use the OrderSendClass with your current robots
 -- add InitCBP(); within the OnInit function to load your apik keys into the CryptoBridgeProClass
 -- OnInit(){ InitCBP(); }
 -- Find all your OrderSend Functions and replace them with the following function

 if(OrderSend(request,result)){

   if(OrderSendCBP(request,result)){
     Print(" Exchange Request Sent");
   }
 }else{
   Print(" MT5 DEBUG " + GetLastError() );
 }


*/

/*
 Notes
 - What are requests
 https://www.mql5.com/en/docs/constants/tradingconstants/enum_trade_request_actions
 
 v- 1.02 
 - if the position is closed ( find the SL and TP orders and delete them) ==> Checking the OnTransactions()

*/

#include <TradingToolCrypto\CBP\CryptoBridgeProClass.mqh>
#property version "1.01"

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
input group "---------------ORDER SEND CLASS SETUP---------------"

input bool OSC_SEND_TO_EXCHANGE = true;
input bool SEND_SL = false;
input bool SEND_TP = false;
input group "-------------ORDER SEND CLASS END SETUP-------------" 

CryptoBridge bridge;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool InitCBP()
  {
   if(OSC_SEND_TO_EXCHANGE)
     {
      if(bridge.Init_Api_Keys(Exchange_Number))
        {
         return (true);
        }
     }
   return (false);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool OrderSendCBP(const MqlTradeRequest &m_request, MqlTradeResult &m_result)
  {

   Print("OrderSendCBP Result: " + m_result.retcode + " | " +
         "Ask" + " | " + m_result.ask + " | " +
         "Bid" + " | " + m_result.bid + " | " +
         "Comment" + " | " + m_result.comment + " | " +
         "Deal" + " | " + m_result.deal + " | " +
         "Order" + " | " + m_result.order + " | " +
         "Price" + " | " + m_result.price + " | " +
         "ID" + " | " + m_result.request_id + " | " +
         "Volume" + " | " + m_result.volume + " | " +
         "Ret" + " | " + m_result.retcode_external);

   /*
    //--- setting request

       m_request.action      =
       TRADE_ACTION_MODIFY,
       TRADE_ACTION_DEAL, (OPEN_POSITION)
       TRADE_ACTION_CLOSE_BY, (10) - DONT USE FOR NOW


       TRADE_ACTION_PENDING (5) (OPEN_PENDING)
       - Get the Ticket = m_result.order
       - no ticket number is present on requests (solved)

       TRADE_ACTION_SLTP (6) - (PLACE STOP ORDERS FOR SL AND LIMIT ORDERS FOR TP)

       TRADE_ACTION_REMOVE (8) - DELETE PENDING
       - symbol is missing within result
       - order ticket is also missing

       m_request.magic       =m_magic;
       m_request.order       =ticket;
       m_request.price       =price;
       m_request.stoplimit   =stoplimit;
       m_request.sl          =sl;
       m_request.tp          =tp;
       m_request.type_time   =type_time;
       m_request.type        = ORDER_TYPE_BUY, ORDER_TYPE_SELL;
       m_request.expiration  =expiration;
       m_request.position =ticket;
       m_request.symbol   =symbol;
       m_request.volume   =position_volume;
       m_request.deviation=(deviation==ULONG_MAX) ? m_deviation : deviation;
    */

   Print("MT5 Symbol  " + m_request.symbol + " | " +
         "Action  " + m_request.action + " | " +
         "Price  " + m_request.price + " | " +
         "TP Price  " + m_request.tp + " | " +
         "SL Price  " + m_request.sl + " | " +
         "StopLimit Price  " + m_request.stoplimit + " | " +
         "orderType  " + m_request.type + " | " +
         "p Ticket  " + m_request.position + " | o Ticket " + m_request.order + " | " +
         "Volume  " + m_request.volume + " | " +

         "Order #" + " | " + m_result.order

        );

// const string exchangeSymbol = SymbolMapping(m_request.symbol);
   string side = orderSide(m_request.type);
   string type = orderType(m_request.type);
   string price = DoubleToString(m_request.price, Exchange_Quote_Precision);
   string price_stop = DoubleToString(m_request.stoplimit, Exchange_Quote_Precision);
   string tp = DoubleToString(m_request.tp, Exchange_Quote_Precision);
   string sl = DoubleToString(m_request.sl, Exchange_Quote_Precision);

   Print("CBP Symbol  " + Exchange_Symbol_Name + " | " +
         "Side " + side + " | " +
         "Price  " + price + " | " +
         "TP Price  " + tp + " | " +
         "SL Price  " + sl + " | " +
         "StopLimit Price  " + price_stop + " | " +
         "Type  " + type + " | " +
         "Volume  " + Exchange_Lotsize);

   string order_id = IntegerToString(m_result.order);

   if(m_request.action == TRADE_ACTION_REMOVE)
     {
      Print("TRADE_ACTION_REMOVE" + " | Type: " + type);
      //bridge.Cancel_Trade_All(Exchange_Symbol_Name, Exchange_Number);
    
      string ord = m_result.order + "op";
      string ord_tp = m_result.order + "tp";
      string ord_sl = m_result.order + "sl";
      
      if(bridge.Cancel_Trade(Exchange_Symbol_Name,0,Exchange_Number,0,ord)){
      
         Sleep(Exchange_RateLimiter);
         bridge.Cancel_Trade(Exchange_Symbol_Name,0,Exchange_Number,0,ord_tp);
         Sleep(Exchange_RateLimiter);
         bridge.Cancel_Trade(Exchange_Symbol_Name,0,Exchange_Number,0,ord_sl);
      
      }
     }

   if(m_request.action == TRADE_ACTION_DEAL)
     {
      Print("TRADE_ACTION_DEAL" + " | Type: " + type);
      if(type == "MARKET")
        {
         bridge.Open_Trade(Exchange_Symbol_Name, side, type, Exchange_Lotsize, "", Exchange_Quote_Precision, Exchange_Lot_Precision, Exchange_Number,order_id+"op");
        }
     }

   if(m_request.action == TRADE_ACTION_PENDING)
     {
      Print("TRADE_ACTION_PENDING" + " | Type: " + type);
      if(type == "LIMIT")
        {
         bridge.Open_Trade(Exchange_Symbol_Name, side, type, Exchange_Lotsize, price, Exchange_Quote_Precision, Exchange_Lot_Precision, Exchange_Number,order_id+"op");
        }

      if(type == "STOP_LOSS_LIMIT")
        {
         bridge.Open_Trade_StopLimit(Exchange_Symbol_Name, side, type, Exchange_Lotsize, price_stop, price, Exchange_Quote_Precision, Exchange_Lot_Precision, Exchange_Number,order_id+"op");
        }

      if(type == "STOP_LOSS")
        {
         /*
           enter with tp and sl
           enter with with sl only
           enter with tp only
           enter with no sl or tp
         */
         if(side == "BUY")
           {

            if(m_request.sl > 0 && m_request.tp > 0)
              {
               //stoploss is a sell stop_market
               if(SEND_SL)
                 {
                  bridge.Open_Trade_Stop(Exchange_Symbol_Name, "SELL", type, Exchange_Lotsize, sl, Exchange_Quote_Precision, Exchange_Lot_Precision, Exchange_Number,order_id+"sl");
                  Sleep(Exchange_RateLimiter);
                 }

               // enter breakout
               bridge.Open_Trade_Stop(Exchange_Symbol_Name, side, type, Exchange_Lotsize, price, Exchange_Quote_Precision, Exchange_Lot_Precision, Exchange_Number,order_id+"op");
               Sleep(Exchange_RateLimiter);

               // tp
               if(SEND_TP)
                 {
                  bridge.Open_Trade(Exchange_Symbol_Name, "SELL", "LIMIT", Exchange_Lotsize, tp, Exchange_Quote_Precision, Exchange_Lot_Precision, Exchange_Number,order_id+"tp");
                 }
              }
            if(m_request.sl > 0 && m_request.tp <= 0)
              {

               //stoploss is a sell stop_market
               if(SEND_SL)
                 {
                  bridge.Open_Trade_Stop(Exchange_Symbol_Name, "SELL", type, Exchange_Lotsize, sl, Exchange_Quote_Precision, Exchange_Lot_Precision, Exchange_Number,order_id+"sl");
                  Sleep(Exchange_RateLimiter);
                 }
               // enter breakout
               bridge.Open_Trade_Stop(Exchange_Symbol_Name, side, type, Exchange_Lotsize, price, Exchange_Quote_Precision, Exchange_Lot_Precision, Exchange_Number,order_id+"op");
              }
            if(m_request.sl <= 0 && m_request.tp > 0)
              {

               bridge.Open_Trade_Stop(Exchange_Symbol_Name, side, type, Exchange_Lotsize, price, Exchange_Quote_Precision, Exchange_Lot_Precision, Exchange_Number,order_id+"op");
               Sleep(Exchange_RateLimiter);

               if(SEND_TP)
                 {
                  bridge.Open_Trade(Exchange_Symbol_Name, "SELL", "LIMIT", Exchange_Lotsize, tp, Exchange_Quote_Precision, Exchange_Lot_Precision, Exchange_Number,order_id+"tp");

                 }
              }
            if(m_request.sl == 0 && m_request.tp == 0)
              {
               bridge.Open_Trade_Stop(Exchange_Symbol_Name, side, type, Exchange_Lotsize, price, Exchange_Quote_Precision, Exchange_Lot_Precision, Exchange_Number,order_id+"op");
              }
           }

         if(side == "SELL")
           {
            if(m_request.sl > 0 && m_request.tp > 0)
              {

               //stoploss is a sell stop_market
               if(SEND_SL)
                 {
                  bridge.Open_Trade_Stop(Exchange_Symbol_Name, "BUY", type, Exchange_Lotsize, sl, Exchange_Quote_Precision, Exchange_Lot_Precision, Exchange_Number,order_id+"sl");
                  Sleep(Exchange_RateLimiter);
                 }
               // enter breakout
               bridge.Open_Trade_Stop(Exchange_Symbol_Name, side, type, Exchange_Lotsize, price, Exchange_Quote_Precision, Exchange_Lot_Precision, Exchange_Number,order_id+"op");
               Sleep(Exchange_RateLimiter);
               // tp
               if(SEND_TP)
                 {
                  bridge.Open_Trade(Exchange_Symbol_Name, "BUY", "LIMIT", Exchange_Lotsize, tp, Exchange_Quote_Precision, Exchange_Lot_Precision, Exchange_Number,order_id+"tp");
                 }
              }

            if(m_request.sl > 0 && m_request.tp <= 0)
              {

               // enter breakout
               bridge.Open_Trade_Stop(Exchange_Symbol_Name, side, type, Exchange_Lotsize, price, Exchange_Quote_Precision, Exchange_Lot_Precision, Exchange_Number,order_id+"op");
               Sleep(Exchange_RateLimiter);

               //stoploss is a sell stop_market
               if(SEND_SL)
                 {
                  bridge.Open_Trade_Stop(Exchange_Symbol_Name, "BUY", type, Exchange_Lotsize, sl, Exchange_Quote_Precision, Exchange_Lot_Precision, Exchange_Number,order_id+"sl");
                 }
              }

            if(m_request.sl <= 0 && m_request.tp > 0)
              {

               // enter breakout
               bridge.Open_Trade_Stop(Exchange_Symbol_Name, side, type, Exchange_Lotsize, price, Exchange_Quote_Precision, Exchange_Lot_Precision, Exchange_Number,order_id+"op");
               Sleep(Exchange_RateLimiter);
               // tp
               if(SEND_TP)
                 {
                  bridge.Open_Trade(Exchange_Symbol_Name, "BUY", "LIMIT", Exchange_Lotsize, tp, Exchange_Quote_Precision, Exchange_Lot_Precision, Exchange_Number,order_id+"tp");
                 }
              }

            if(m_request.sl == 0 && m_request.tp == 0)
              {
               bridge.Open_Trade_Stop(Exchange_Symbol_Name, side, type, Exchange_Lotsize, price, Exchange_Quote_Precision, Exchange_Lot_Precision, Exchange_Number,order_id+"op");
              }
           }
        }

     }

   if(m_request.action == TRADE_ACTION_SLTP)
     {
      order_id = m_request.position;
      Print("TRADE_ACTION_SLTP" + " | Side: " + side + " | Position Ticket " + order_id);

      if(side == "BUY")
        {
         /*
            place a buylimit for the sell positions takeprofit
            place a buy stop_loss(market) above the sell position entry )
            */
         if(m_request.tp != 0)
           {
           //Modify_Trade(string sym, string side, string orderType, string orderSize,string orderPrice, string id, string clientId, int orderNumber,  int quoteDigit, int lotDigit,int exchangeNumber)
            if(!bridge.Modify_Trade(Exchange_Symbol_Name,"SELL","LIMIT",Exchange_Lotsize,tp,"",order_id+"tp",0,Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number))
              {
               bridge.Open_Trade(Exchange_Symbol_Name, "SELL", "LIMIT", Exchange_Lotsize, tp, Exchange_Quote_Precision, Exchange_Lot_Precision, Exchange_Number,order_id+"tp");
              }
           }

         if(m_request.sl != 0)
           {
            if(!bridge.Modify_Trade(Exchange_Symbol_Name,"SELL","STOP_LOSS",Exchange_Lotsize,sl,"",order_id+"sl",0,Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number))
              {
               bridge.Open_Trade_Stop(Exchange_Symbol_Name, "SELL", "STOP_LOSS", Exchange_Lotsize, sl, Exchange_Quote_Precision, Exchange_Lot_Precision, Exchange_Number,order_id+"sl");
              }
           }
        }
      /*
        place a sell_limit for the buy positions takeprofit
        place a sell stop_loss(market) below the buy positions entry
        */
      if(side == "SELL")
        {

         if(m_request.tp != 0)
           {
            if(!bridge.Modify_Trade(Exchange_Symbol_Name,"BUY","LIMIT",Exchange_Lotsize,tp,"",order_id+"tp",0,Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number))
              {
               bridge.Open_Trade(Exchange_Symbol_Name, "BUY", "LIMIT", Exchange_Lotsize, tp, Exchange_Quote_Precision, Exchange_Lot_Precision, Exchange_Number,order_id+"tp");
              }
           }

         if(m_request.sl != 0)
           {
            if(!bridge.Modify_Trade(Exchange_Symbol_Name,"BUY","STOP_LOSS",Exchange_Lotsize,sl,"",order_id+"sl",0,Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number))
              {
               bridge.Open_Trade_Stop(Exchange_Symbol_Name, "BUY", "STOP_LOSS", Exchange_Lotsize, sl, Exchange_Quote_Precision, Exchange_Lot_Precision, Exchange_Number,order_id+"sl");

              }

           }
        }
     }

   /*
    TRADE_ACTION_MODIFY
    - proper way is to add a user ID to all the orders on the exchange side and find then delete this order, then place a new order
       - the bad way is to delete all the pending orders and only add this new order

    */
   return (false);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string orderSide(int type)
  {
   if(type == ORDER_TYPE_BUY)
      return ("BUY");
   if(type == ORDER_TYPE_SELL)
      return ("SELL");

   if(type == ORDER_TYPE_BUY_LIMIT)
      return ("BUY");
   if(type == ORDER_TYPE_SELL_LIMIT)
      return ("SELL");

   if(type == ORDER_TYPE_BUY_STOP)
      return ("BUY");
   if(type == ORDER_TYPE_SELL_STOP)
      return ("SELL");

   if(type == ORDER_TYPE_BUY_STOP_LIMIT)
      return ("BUY");
   if(type == ORDER_TYPE_SELL_STOP_LIMIT)
      return ("SELL");

   return ("ERROR");
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string orderType(int type)
  {
   if(type == ORDER_TYPE_BUY)
      return ("MARKET");
   if(type == ORDER_TYPE_SELL)
      return ("MARKET");

   if(type == ORDER_TYPE_BUY_LIMIT)
      return ("LIMIT");
   if(type == ORDER_TYPE_SELL_LIMIT)
      return ("LIMIT");

   if(type == ORDER_TYPE_BUY_STOP)
      return ("STOP_LOSS");
   if(type == ORDER_TYPE_SELL_STOP)
      return ("STOP_LOSS");

   if(type == ORDER_TYPE_BUY_STOP_LIMIT)
      return ("STOP_LOSS_LIMIT");
   if(type == ORDER_TYPE_SELL_STOP_LIMIT)
      return ("STOP_LOSS_LIMIT");

   return ("ERROR");
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

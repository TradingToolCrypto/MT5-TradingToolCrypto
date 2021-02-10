#property copyright "Copyright 2020, TradingToolCrypto Corp."
#property link      "https://github.com/tradingtoolcrypto"

#include <TradingToolCrypto\MQL\Trade\Trade.mqh>

CPositionInfo m_position; // trade position object
CTrade m_trade;           // trading object
COrderInfo m_order;       // trading order object

// input: string symbol || Delete Pending orders and return the number count
int DeletePending(string sym)
{
   int count = 0;
   for (int i = OrdersTotal() - 1; i >= 0; i--) // returns the number of current orders
      if (m_order.SelectByIndex(i))
      { // selects the pending order by index for further access to its properties

         if (m_order.Symbol() == sym)
         {
            // delete all orders
            m_trade.OrderDelete(m_order.Ticket());
            count++;
         }
      }
   return (count);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string convert_int_to_OrderType(int inputValue)
  {
   if(0 == inputValue)
     {
      return ("BUY");
     }
   if(1 == inputValue)
     {
      return ("SELL");
     }
   if(2 == inputValue)
     {
      return ("BUYLIMIT");
     }
   if(3 == inputValue)
     {
      return ("SELLLIMIT");
     }
   if(4 == inputValue)
     {
      return ("BUYSTOP");
     }
   if(5 == inputValue)
     {
      return ("SELLSTOP");
     }
   return ("UNKNOWN ORDER TYPE: " + inputValue);
  }
  
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
datetime Global_Bot_Start =0;
void set_bot_init_time(){
   Global_Bot_Start = TimeCurrent();
}


long Find_Order_Magic(ulong position_ticket)
  {

   if(HistorySelect(Global_Bot_Start,TimeCurrent()))
     {
      int loop = HistoryOrdersTotal();
      for(int i = 0; i<loop; i++)
        {

         ulong ticket = HistoryOrderGetTicket(i);

         if(ticket == position_ticket)
           {
            return(HistoryOrderGetInteger(ticket,ORDER_MAGIC));
           }
        }
     }

   return(0);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
long Find_Position_Magic(ulong position_ticket)
  {
   long ticket = 0;
   int total = PositionsTotal();
   if(total == 0)
      return(0);
   for(int i = total - 1; i >= 0; i--)
     {
      if(m_position.SelectByIndex(i))
        {
         ticket = m_position.Ticket();

         if(ticket  == position_ticket)
           {

            return(m_position.Magic());

           }
        }
     }
   return(0);
  }
  
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double buy_position_volume;
double sell_position_volume;
double buy_position_commission;
double sell_position_commission;
double buy_position_entryprice;
double sell_position_entryprice;
double sell_position_profit;
double buy_position_profit;
int buy_position_count;
int sell_position_count;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Get_positions_details()
  {

   buy_position_volume = 0;
   sell_position_volume = 0;

   buy_position_entryprice = 0;
   sell_position_entryprice = 0;

   buy_position_profit = 0;
   sell_position_profit = 0;

   buy_position_count = 0;
   sell_position_count = 0;

   for(int i = PositionsTotal() - 1; i >= 0; i--)
     {
      if(m_position.SelectByIndex(i))
        {

         if(m_position.PositionType() == POSITION_TYPE_BUY)
           {

            buy_position_volume += m_position.Volume();
            buy_position_count++;
            buy_position_entryprice += m_position.PriceOpen();
            buy_position_profit += m_position.Profit();
           }
         if(m_position.PositionType() == POSITION_TYPE_SELL)
           {

            sell_position_volume += m_position.Volume();
            sell_position_count++;
            sell_position_entryprice += m_position.PriceOpen();
            sell_position_profit += m_position.Profit();
           }
        }
     }
  }
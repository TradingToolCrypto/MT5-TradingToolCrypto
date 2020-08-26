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
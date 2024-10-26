/*
 - Telegram_Order_Alerts : 1.02
*/
enum ENUM_TELEGRAM_SIGNAL
  {
   THREE_COMMAS = 0,
   CORNIX = 1,
   STANDARD = 2,
   METATRADER = 3,
   CUSTOM_FORMAT = 4
  };

input ENUM_TELEGRAM_SIGNAL Telegram_Signal_Format;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string GLOBAL_symbol = "";
int order_id = 0;
string signal_deal = "";
string lastsignal_deal = "";


/*
if last position ticket number changes, send new alert */
ulong GLOBAL_position_ticket = 0;
int GLOBAL_position_count = 0;
string Get_Positions()
  {
   string msg = "";
   int positions_total=PositionsTotal();
   ulong ticket=PositionGetTicket(positions_total-1);

// decrease : on closed positions and don't send an alert
   if(positions_total < GLOBAL_position_count)
     {
      GLOBAL_position_count = positions_total;
     }

// send alert on new opened position
   if(ticket != GLOBAL_position_ticket && positions_total > GLOBAL_position_count)
     {
      msg  = Get_Last_Positions();
      GLOBAL_position_ticket = ticket;
      GLOBAL_position_count = positions_total;
     }

   return(msg);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string PositionOrderType(int type_order)
  {
   if(type_order == 0)
      return("Buy");
   if(type_order == 1)
      return("Sell");

   return("Limit/Stop");

  }


/*

Return the last closed order id, this is called the position ID

*/
long Get_Last_Order_History()
  {
   int position_id = 0;
   if(HistorySelect(0,TimeCurrent()))
     {
      int loop = HistoryOrdersTotal();
      for(int i = 0; i<loop; i++)
        {
         long ticket = HistoryOrderGetTicket(i);
         position_id = HistoryOrderGetInteger(ticket,ORDER_POSITION_ID);
        }
     }
   return(position_id);
  }
string GLOBAL_symbol_close ="";
string Get_Last_Deal(long original_ticket)
  {
   double deal_open_price = 0;
   double deal_close_price = 0;
   datetime deal_open_time = 0;
   datetime deal_close_time = 0;

   string deal_last_trade_complete = "";

   if(HistorySelect(0,TimeCurrent()))
     {

      int loop = HistoryDealsTotal();

      for(int i = 0; i< loop; i++)
        {
         long deal_ticket =  HistoryDealGetTicket(i);
         string symbol = HistoryDealGetString(deal_ticket, DEAL_SYMBOL);
         GLOBAL_symbol_close = symbol;
         int symbol_digits = SymbolInfoInteger(symbol,SYMBOL_DIGITS);

         // If profit is zero , this is the open price
         if(Deal_Open_Close(HistoryDealGetInteger(deal_ticket, DEAL_ENTRY)) == "OPENED")
           {
            deal_open_price = HistoryDealGetDouble(deal_ticket,DEAL_PRICE);
            deal_open_time  = (datetime)HistoryDealGetInteger(deal_ticket,DEAL_TIME);
            // if we are at the opened price for ticket X, then reset the closed price
            deal_close_price = 0;
            deal_close_time = 0;
           }

         if(Deal_Open_Close(HistoryDealGetInteger(deal_ticket, DEAL_ENTRY)) == "CLOSED")
           {
            deal_close_price = HistoryDealGetDouble(deal_ticket,DEAL_PRICE);
            deal_close_time = (datetime)HistoryDealGetInteger(deal_ticket,DEAL_TIME);
           }

         //  Print("DEAL_POSITION_ID: " + HistoryDealGetInteger(deal_ticket,DEAL_POSITION_ID) + "  MATCH TO " + original_ticket);

         if(deal_open_price != 0 && deal_close_price != 0 && original_ticket == HistoryDealGetInteger(deal_ticket,DEAL_POSITION_ID))
           {
            // Complete deal
            // Opened and Closed
            deal_last_trade_complete =
               "-----CLOSE POSITION-----\n"+
               "Symbol: " + symbol + "\n" +
               "Opened: " + DoubleToString(deal_open_price, symbol_digits) + "\n" +
               "Lots: " + DoubleToString(HistoryDealGetDouble(deal_ticket,DEAL_VOLUME), Deal_Minimum_Lot(symbol))  + "\n" +
               "Closed: " + DoubleToString(deal_close_price,symbol_digits) + "\n" +
               "Profit: " + DoubleToString(HistoryDealGetDouble(deal_ticket,DEAL_PROFIT),8) + " " + AccountInfoString(ACCOUNT_CURRENCY) + "\n" +
               "Duration: " + Deal_Duration(deal_open_time,deal_close_time)+ "\n" +
               "Ticket: " + HistoryDealGetInteger(deal_ticket,DEAL_POSITION_ID)+ "\n" +
               "TimeClosed: " + (datetime) HistoryDealGetInteger(deal_ticket,DEAL_TIME);

            // reset because we have a opened and closed price in memory ( Completed deal )
            deal_open_price = 0;
            deal_open_time = 0;

           }
        }
     }
   return(deal_last_trade_complete);
  }
/*
    convert two datetimes into seconds, minutes , hours
    compare the two datetimes and check for the duration ( time) between the two values
*/
string Deal_Duration(datetime x, datetime y)
  {

   double duration_minutes = (y-x)/60;// convert to minutes from seconds
   double hours = (duration_minutes/60);// convert to hours from minutes
   int real_hours = hours;
   double partial = 60*(hours - real_hours);// convert % of 1 hour into minutes
   string ok = IntegerToString(real_hours) + "h " + DoubleToString(partial,0) + "m";
   return(ok);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Deal_Minimum_Lot(string sym)
  {

   double min =  SymbolInfoDouble(sym, SYMBOL_VOLUME_MIN);

   if(min >= 0.01)
     {
      return(2);
     }
   if(min < 0.01)
     {
      return(8);
     }

   return(0);

  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string Deal_Open_Close(int what)
  {

   if(what == 0)
     {
      return("OPENED");
     }
   if(what == 1)
     {
      return("CLOSED");
     }

   return("NONE");

  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string Get_Last_Positions()
  {
   string msg = "";

   int positions_total=PositionsTotal();


   for(int i=0; i<positions_total; i++)
     {

      if(i==positions_total-1)
        {
         ulong ticket=PositionGetTicket(i);
         if(PositionSelectByTicket(ticket))
           {
            string position_symbol=PositionGetString(POSITION_SYMBOL);
            GLOBAL_symbol = position_symbol;

            /*
            Telegram_Signal_Format
            0 - 3commas
            1 - cornix
            2 - standard
            3 - Metatrader
            4 - Custom Format
            */
            if(Telegram_Signal_Format == 0)
              {

              }
            if(Telegram_Signal_Format == 1)
              {

              }

            if(Telegram_Signal_Format == 2)
              {
               if(PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_BUY)
                 {
                  msg +="\n-----OPEN POSITIONS-----\n"+
                        " Symbol: " +   position_symbol + "\n" +
                        " Type: " + PositionOrderType(PositionGetInteger(POSITION_TYPE))  + "\n" +
                        " Entry: " + DoubleToString(PositionGetDouble(POSITION_PRICE_OPEN), SymbolInfoInteger(position_symbol,SYMBOL_DIGITS))           + "\n" +
                        " Lots: " +   PositionGetDouble(POSITION_VOLUME)     + "\n" +
                        " Stoploss: " + DoubleToString(PositionGetDouble(POSITION_SL), SymbolInfoInteger(position_symbol,SYMBOL_DIGITS))   + "\n" +
                        " Takeprofit: " + DoubleToString(PositionGetDouble(POSITION_TP), SymbolInfoInteger(position_symbol,SYMBOL_DIGITS))   + "\n" +
                        " Ticket: " +  PositionGetInteger(POSITION_TICKET)  + "\n" +
                        " Time: " + (datetime)PositionGetInteger(POSITION_TIME) ;

                 }
               if(PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_SELL)
                 {
                  msg +="\n-----OPEN POSITIONS-----\n"+
                        " Symbol: " +   position_symbol + "\n" +
                        " Type: " + PositionOrderType(PositionGetInteger(POSITION_TYPE))  + "\n" +
                        " Entry: " + DoubleToString(PositionGetDouble(POSITION_PRICE_OPEN), SymbolInfoInteger(position_symbol,SYMBOL_DIGITS))           + "\n" +
                        " Lots: " +   PositionGetDouble(POSITION_VOLUME)     + "\n" +
                        " Stoploss: " + DoubleToString(PositionGetDouble(POSITION_SL), SymbolInfoInteger(position_symbol,SYMBOL_DIGITS))   + "\n" +
                        " Takeprofit: " + DoubleToString(PositionGetDouble(POSITION_TP), SymbolInfoInteger(position_symbol,SYMBOL_DIGITS))   + "\n" +
                        " Ticket: " +  PositionGetInteger(POSITION_TICKET)+ "\n" +
                        " Time: " + (datetime)PositionGetInteger(POSITION_TIME) ;
                 }

              }

            if(Telegram_Signal_Format == 3)
              {
               if(PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_BUY)
                 {
                  msg +=

                     position_symbol + "\n" +
                     PositionOrderType(PositionGetInteger(POSITION_TYPE)) +" "+ DoubleToString(PositionGetDouble(POSITION_PRICE_OPEN), SymbolInfoInteger(position_symbol,SYMBOL_DIGITS)) + "\n" +
                     "TP " + DoubleToString(PositionGetDouble(POSITION_TP), SymbolInfoInteger(position_symbol,SYMBOL_DIGITS))   + "\n" +
                     "SL " + DoubleToString(PositionGetDouble(POSITION_SL), SymbolInfoInteger(position_symbol,SYMBOL_DIGITS))   + "\n" +
                     "Ticket: " +  PositionGetInteger(POSITION_TICKET)  + "\n" +
                     "Lots: " +   PositionGetDouble(POSITION_VOLUME)     + "\n" +
                     "Time: " + (datetime)PositionGetInteger(POSITION_TIME) + "\n\n" ;

                 }
               if(PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_SELL)
                 {
                  msg +=
                     position_symbol + "\n" +
                     PositionOrderType(PositionGetInteger(POSITION_TYPE)) +" "+ DoubleToString(PositionGetDouble(POSITION_PRICE_OPEN), SymbolInfoInteger(position_symbol,SYMBOL_DIGITS)) + "\n" +
                     "TP " + DoubleToString(PositionGetDouble(POSITION_TP), SymbolInfoInteger(position_symbol,SYMBOL_DIGITS))   + "\n" +
                     "SL " + DoubleToString(PositionGetDouble(POSITION_SL), SymbolInfoInteger(position_symbol,SYMBOL_DIGITS))   + "\n" +
                     "Ticket: " +  PositionGetInteger(POSITION_TICKET)  + "\n" +
                     "Lots: " +   PositionGetDouble(POSITION_VOLUME)     + "\n" +
                     "Time: " + (datetime)PositionGetInteger(POSITION_TIME) + "\n\n" ;
                 }

              }

            if(Telegram_Signal_Format == 4)
              {


              }

           }


        }


     }

   return(msg);
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                 ChartProTask.mqh |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"

#include <TradingToolCrypto\CBP\ChartPro.mqh>

/*


   run this command each time we launch a new chart

*/
string exchange_1[][2];
string exchange_2[][2];
string exchange_3[][2];
string exchange_4[][2];
string exchange_5[][2];
string exchange_6[][2];
string exchange_7[][2];
string exchange_8[][2];
string exchange_9[][2];
string exchange_10[][2];
string exchange_11[][2];
string exchange_12[][2];
string exchange_13[][2];
string exchange_14[][2];
string exchange_15[][2];
string exchange_16[][2];
string exchange_17[][2];
string exchange_18[][2];
string exchange_19[][2];
string exchange_20[][2];

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void prep_exchange_arrays(string &chart_sym[])
  {
   string suffix, ex_symbol, sym;
  
   int loop = prep_exchange_arraysize(chart_sym);

   for(int i =0; i < loop; i++)
     {
      sym = chart_sym[i];
      suffix = ChartPro_ReturnSymbolSuffix(sym);

      if(suffix == "")
        {

         Alert(" Error in Loading the markets suffix from symbol: " + sym);
         Print(" Error in Loading the markets suffix from symbol: " + sym);
        }

      ex_symbol = ChartPro_RemoveSymbolSuffix(sym);

      Print("prep_exchange_arrays() | Symbol: " + sym + " | Suffix: " + suffix + " | Exchange Sym: " + ex_symbol);

      if(suffix == EXCHANGE_BINANCE)
        {
         exchange_1[i][0]=ex_symbol;
        }
      if(suffix == EXCHANGE_BYBIT)
        {
         exchange_2[i][0]=ex_symbol;
        }
      if(suffix == EXCHANGE_BITMEX)
        {
         exchange_3[i][0]=ex_symbol;
        }
      if(suffix == EXCHANGE_KUCOIN)
        {
         exchange_4[i][0]=ex_symbol;
        }
      if(suffix == EXCHANGE_BINANCE_FUTURES)
        {
         exchange_5[i][0]=ex_symbol;
        }
      if(suffix == EXCHANGE_BINANCE_US)
        {
         exchange_6[i][0]=ex_symbol;
        }
      if(suffix == EXCHANGE_DERIBIT)
        {
         exchange_7[i][0]=ex_symbol;
        }
      if(suffix == EXCHANGE_OKEX)
        {
         exchange_8[i][0]=ex_symbol;
        }
      if(suffix == EXCHANGE_COINBASE)
        {
         exchange_9[i][0]=ex_symbol;
        }

      if(suffix == EXCHANGE_BITFINEX)
        {
         exchange_10[i][0]=ex_symbol;
        }

      if(suffix == EXCHANGE_BITSTAMP)
        {
         exchange_11[i][0]=ex_symbol;
        }
      if(suffix == EXCHANGE_FTX)
        {
         exchange_12[i][0]=ex_symbol;
        }
      if(suffix == EXCHANGE_SATANG)
        {
         exchange_13[i][0]=ex_symbol;
        }
      if(suffix == EXCHANGE_DIGITEX)
        {
         exchange_14[i][0]=ex_symbol;
        }
      if(suffix == EXCHANGE_HUOBI)
        {
         exchange_15[i][0]=ex_symbol;
        }
      if(suffix == EXCHANGE_PHEMEX)
        {
         exchange_16[i][0]=ex_symbol;
        }
      if(suffix == EXCHANGE_ZBG)
        {
         exchange_17[i][0]=ex_symbol;
        }
      if(suffix == EXCHANGE_KRAKEN)
        {
         exchange_18[i][0]=ex_symbol;
        }
      if(suffix == EXCHANGE_KUCOIN_FUTURES)
        {
         exchange_19[i][0]=ex_symbol;
        }

      if(suffix == EXCHANGE_BTSE)
        {
         exchange_20[i][0]=ex_symbol;
        }
     }//for
  }//end


//+------------------------------------------------------------------+
//|            resize arrays                |
//+------------------------------------------------------------------+
int prep_exchange_arraysize(string &chart_sym[])
  {
   string suffix, ex_symbol, sym;
   int loop =  ArraySize(chart_sym);
   if(loop == 0)
     {
      Print("Global_Chart_SYM EMPTY ");
      return(0);
     }
// resize all the arrays
   ArrayResize(exchange_1,loop);
   ArrayResize(exchange_2,loop);
   ArrayResize(exchange_3,loop);
   ArrayResize(exchange_4,loop);
   ArrayResize(exchange_5,loop);
   ArrayResize(exchange_6,loop);
   ArrayResize(exchange_7,loop);
   ArrayResize(exchange_8,loop);
   ArrayResize(exchange_9,loop);
   ArrayResize(exchange_10,loop);
   ArrayResize(exchange_11,loop);
   ArrayResize(exchange_12,loop);
   ArrayResize(exchange_13,loop);
   ArrayResize(exchange_14,loop);
   ArrayResize(exchange_15,loop);
   ArrayResize(exchange_16,loop);
   ArrayResize(exchange_17,loop);
   ArrayResize(exchange_18,loop);
   ArrayResize(exchange_19,loop);
   ArrayResize(exchange_20,loop);
   return(loop);
}//end

/*

   timer(1,  insert(1, sym, ".bnf"),   ".bnf");

   returns the orders that belong to a specific exchange 
*/
int insert(int loop, string &chart_sym[], string exchange_id)
  {
   int countorders = 0;
   for(int i = 0; i< loop; i++)
     {

      if(ChartPro_ReturnSymbolSuffix(chart_sym[i]) == exchange_id)
        {
         countorders++;
        }
     }
   return(countorders);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

int webrequest_timer(){

   if(next_request_1(1000000," 1 second loop"))
     {
       timer_trigger_1 = true;
     }
     if(next_request_2(2000000," 2 second loop"))
     {
       timer_trigger_2 = true;
     }
     if(next_request_3(3000000," 3 second loop"))
     {
       timer_trigger_3 = true;
     }
     if(next_request_4(4000000," 4 second loop"))
     {
       timer_trigger_4 = true;
     }
     if(next_request_5(5000000," 5 second loop"))
     {
       timer_trigger_5 = true;
     }
     if(next_request_6(6000000," 6 second loop"))
     {
       timer_trigger_6 = true;
     }
     if(next_request_7(7000000," 7 second loop"))
     {
       timer_trigger_7 = true;
     }
     if(next_request_8(8000000," 8 second loop"))
     {
       timer_trigger_8 = true;
     }
     if(next_request_9(9000000," 9 second loop"))
     {
       timer_trigger_9 = true;
     }
      if(next_request_10(10000000," 10 second loop"))
     {
       timer_trigger_10 = true;
     }



    if(next_request(1000000," 1 second loop"))
     {
      prep_exchange_trigger();// resets all the trigger points every second
      return(true);
     }
     
    return(false);
}


void timer(int loop, int count, string exchange_id)
  {
  /*
  
  order counts 
  - only reset the exchange if orders counts == number of seconds since last check 
  
  */
   
  

   if(count == 1 && timer_trigger_1)
     {
      //Print("TIMER RESET: | COUNT: " + count  + " Exid " + exchange_id );
      prep_exchange_reset(exchange_id, loop);
     }
     
   if(count == 2 && timer_trigger_2)
     {
     //Print("TIMER RESET: | COUNT: " + count  + " Exid " + exchange_id );
      prep_exchange_reset(exchange_id, loop);
     }
     
   if(count == 3&& timer_trigger_3)
     {
     //Print("TIMER RESET: | COUNT: " + count  + " Exid " + exchange_id );
      prep_exchange_reset(exchange_id, loop);
     }
     
   if(count == 4&& timer_trigger_4)
     {
    // Print("TIMER RESET: | COUNT: " + count  + " Exid " + exchange_id );
      prep_exchange_reset(exchange_id, loop);
     }
     if(count == 5&& timer_trigger_5)
     {
    // Print("TIMER RESET: | COUNT: " + count  + " Exid " + exchange_id );
      prep_exchange_reset(exchange_id, loop);
     }
     if(count == 6&& timer_trigger_6)
     {
    // Print("TIMER RESET: | COUNT: " + count  + " Exid " + exchange_id );
      prep_exchange_reset(exchange_id, loop);
     }
     if(count == 7&& timer_trigger_7)
     {
    // Print("TIMER RESET: | COUNT: " + count  + " Exid " + exchange_id );
      prep_exchange_reset(exchange_id, loop);
     }
     if(count == 8&& timer_trigger_8)
     {
    // Print("TIMER RESET: | COUNT: " + count  + " Exid " + exchange_id );
      prep_exchange_reset(exchange_id, loop);
     }
     if(count == 9&& timer_trigger_9)
     {
    // Print("TIMER RESET: | COUNT: " + count  + " Exid " + exchange_id );
      prep_exchange_reset(exchange_id, loop);
     }
     if(count == 10&& timer_trigger_10)
     {
   //  Print("TIMER RESET: | COUNT: " + count  + " Exid " + exchange_id );
      prep_exchange_reset(exchange_id, loop);
     }

  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void prep_exchange_reset(string exchange, int loop)
  {
  //Print("EXCHANGE RESET: | COUNT: " + loop  + " Exid " + exchange );

   for(int i = 0; i<loop; i++)
     {

      if(exchange == EXCHANGE_BINANCE)
        {
         exchange_1[i][1] = "false";
        }

      if(exchange == EXCHANGE_BINANCE_FUTURES)
        {
         exchange_5[i][1] = "false";
        }


     }

  }

/*
 reset the boolean after every 1 second
*/
bool exchange_1_trigger = false;
bool exchange_2_trigger = false;
bool exchange_3_trigger = false;
bool exchange_4_trigger = false;
bool exchange_5_trigger = false;
bool exchange_6_trigger = false;
bool exchange_7_trigger = false;
bool exchange_8_trigger = false;
bool exchange_9_trigger = false;
bool exchange_10_trigger = false;
bool exchange_11_trigger = false;
bool exchange_12_trigger = false;
bool exchange_13_trigger = false;
bool exchange_14_trigger = false;
bool exchange_15_trigger = false;
bool exchange_16_trigger = false;
bool exchange_17_trigger = false;
bool exchange_18_trigger = false;
bool exchange_19_trigger = false;
bool exchange_20_trigger = false;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void prep_exchange_trigger()
  {
   exchange_1_trigger = false;
   exchange_2_trigger = false;
   exchange_3_trigger = false;
   exchange_4_trigger = false;
   exchange_5_trigger = false;
   exchange_6_trigger = false;
   exchange_7_trigger = false;
   exchange_8_trigger = false;
   exchange_9_trigger = false;
   exchange_10_trigger = false;
   exchange_11_trigger = false;
   exchange_12_trigger = false;
   exchange_13_trigger = false;
   exchange_14_trigger = false;
   exchange_15_trigger = false;
   exchange_16_trigger = false;
   exchange_17_trigger = false;
   exchange_18_trigger = false;
   exchange_19_trigger = false;
   exchange_20_trigger = false;
  }
//+------------------------------------------------------------------+

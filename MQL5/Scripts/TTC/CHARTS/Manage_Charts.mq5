//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, TradingToolCrypto Corp."
#property link      "https://github.com/TradingToolCrypto/TradingTool-Wiki/wiki"
#property description "Make a payment with Payment_Bot before using"
#property version   "1.00"
#property script_show_inputs

input bool OpenAllCharts =false;
input bool CloseAllCharts = false;
void OnStart()
  {
   long  thisChart = ChartID();
   long chartid = ChartFirst();

   int loop = SymbolsTotal(true);// as it says, the total count of symbol databases in the marketwatch window

   Print("TOTAL SYMBOLS IN MARKET WATCH", loop);

   if(CloseAllCharts)
     {
      while(chartid != -1)
        {
         chartid = ChartNext(thisChart);
         Print("Next Chart", chartid);
         bool didClose = ChartClose(chartid);
         Print("Closing Chart", chartid);
         Sleep(200);
         bool currentStatus = (bool) TerminalInfoInteger(TERMINAL_TRADE_ALLOWED);

         if(!currentStatus)
           {

            break;
           }
        }
     }

   if(OpenAllCharts)
     {
      for(int x = 0; x< loop; x++)
        {

         bool currentStatus = (bool) TerminalInfoInteger(TERMINAL_TRADE_ALLOWED);

         if(!currentStatus)
           {

            break;
           }

         string symOpenChart = SymbolName(x,true);// get the symbol database name based on the index
         if(!SymbolSelect(symOpenChart, true))
           {
            // theres no match , so skip
           }
         else
           {
            Print("Opening Chart", symOpenChart);
            Sleep(200);
            ChartOpen(symOpenChart, PERIOD_M1);// Let the user select the preferred timeframe
           }

        }

     }



  }
//+------------------------------------------------------------------+

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

input int TA_DELAY = 3000;//ms delay for Technical Analysis



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnStart()
  {
   long  thisChart = ChartID();
   long chartid = ChartFirst();
   chartid = ChartNext(thisChart);

   int loop = SymbolsTotal(true);// as it says, the total count of symbol databases in the marketwatch window

   Print("TOTAL SYMBOLS IN MARKET WATCH", loop);

   charts_run(loop);


  }
//+------------------------------------------------------------------+
void charts_run(int LoopSize)
  {
   int loop = LoopSize;
   long currentChartId = ChartID();
   bool test = (bool) TerminalInfoInteger(TERMINAL_CONNECTED);
   bool currentStatus = (bool) TerminalInfoInteger(TERMINAL_TRADE_ALLOWED);

   Alert(" Connected:   ", test +  " | AutoTrading: " + currentStatus);

   for(int x = 0; x< loop; x++)
     {

      currentStatus = (bool) TerminalInfoInteger(TERMINAL_TRADE_ALLOWED);


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

         currentChartId=  ChartOpen(symOpenChart, PERIOD_D1);
         Sleep(TA_DELAY);
         ChartClose(currentChartId);

         currentChartId=   ChartOpen(symOpenChart, PERIOD_H6);
         Sleep(TA_DELAY);
         ChartClose(currentChartId);


         currentChartId=   ChartOpen(symOpenChart, PERIOD_H2);
         Sleep(TA_DELAY);
         ChartClose(currentChartId);

         currentChartId=   ChartOpen(symOpenChart, PERIOD_H1);
         Sleep(TA_DELAY);
         ChartClose(currentChartId);

         currentChartId=   ChartOpen(symOpenChart, PERIOD_M30);
         Sleep(TA_DELAY);
         ChartClose(currentChartId);

         currentChartId=   ChartOpen(symOpenChart, PERIOD_M15);
         Sleep(TA_DELAY);
         ChartClose(currentChartId);

         currentChartId=   ChartOpen(symOpenChart, PERIOD_M6);
         Sleep(TA_DELAY);
         ChartClose(currentChartId);

         currentChartId=   ChartOpen(symOpenChart, PERIOD_M3);
         Sleep(TA_DELAY);
         ChartClose(currentChartId);

         currentChartId=   ChartOpen(symOpenChart, PERIOD_M1);
         Sleep(TA_DELAY);
         ChartClose(currentChartId);

        }
     }

   ChartClose(currentChartId);

  }
//+------------------------------------------------------------------+

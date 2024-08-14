//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, TradingToolCrypto Corp."
#property link      "https://github.com/TradingToolCrypto/TradingTool-Wiki/wiki"
#property description "Make a payment with Payment_Bot before using"
#property version   "1.10"
#property script_show_inputs
// v - 1.10 : templates

input int TA_DELAY = 3000;//ms delay for Technical Analysis
// Custom templates and timeframes

input string Template_Name_M1 = "m1.tpl";
input ENUM_TIMEFRAMES TF_M1 = PERIOD_M1;


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
   long prevChartId = -1;
   bool currentStatus = (bool) TerminalInfoInteger(TERMINAL_TRADE_ALLOWED);

   Alert(" | AutoTrading must be GreenArrow | " + currentStatus);

   for(int x = 0; x< loop; x++)
     {

      currentStatus = (bool) TerminalInfoInteger(TERMINAL_TRADE_ALLOWED);

      if(!currentStatus)
        {
         break;
        }


      string symOpenChart = SymbolName(x,true);// get the symbol database name based on the index
      if(SymbolSelect(symOpenChart, true))
        {
         ChartClose(prevChartId);
         currentChartId=   ChartOpen(symOpenChart, TF_M1);
         ChartApplyTemplate(currentChartId,Template_Name_M1);
         Sleep(TA_DELAY);
         prevChartId = currentChartId;

        }
     }

  }
//+------------------------------------------------------------------+

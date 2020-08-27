#property copyright "Copyright 2018, FX4BTC"
#property link "https://github.com/fx4btc"
#property description "This is an Indicator: Place on the same chart as the Crypto Bridge Robot"
#property version   "1.00"
#property indicator_separate_window
#property indicator_plots   0
#property indicator_buffers 0
#property indicator_minimum 0.0
#property indicator_maximum 0.0


int OnInit()
  {
   return(INIT_SUCCEEDED);
  }
  
   int OnCalculate(const int total,
                const int calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick[],
                const long &real[],
                const int &spread[])
  {
   return(total);
  }
  
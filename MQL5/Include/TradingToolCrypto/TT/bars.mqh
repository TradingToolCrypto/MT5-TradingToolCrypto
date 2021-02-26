#property copyright "Copyright 2020, TradingToolCrypto Corp."
#property link      "https://github.com/tradingtoolcrypto"

// ( sym , PERIOD_D1)
bool new_bar(string what_market, ENUM_TIMEFRAMES tf)
{
  
    datetime time_array[];
    static datetime lastbar;
    datetime curbar = iTime(what_market,tf,0);
    if(curbar ==0){
     
       if(  CopyTime(what_market,tf,0,1,time_array) != -1){
         curbar = time_array[0];
      
       }
   }
   
    if (lastbar != curbar)
    {
      lastbar = curbar;
      return (true);
    }
    else
    {
      return (false);
    }
  }
  
bool new_barB(string what_market, ENUM_TIMEFRAMES tf)
{
  
    datetime time_array[];
    static datetime lastbar;
    datetime curbar = iTime(what_market,tf,0);
    if(curbar ==0){
     
       if(  CopyTime(what_market,tf,0,1,time_array) != -1){
         curbar = time_array[0];
      
       }
   }
   
    if (lastbar != curbar)
    {
      lastbar = curbar;
      return (true);
    }
    else
    {
      return (false);
    }
  }
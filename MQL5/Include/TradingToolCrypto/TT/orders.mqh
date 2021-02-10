#property copyright "Copyright 2020, TradingToolCrypto Corp."
#property link      "https://github.com/tradingtoolcrypto"


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string normalize_symbol(string original)
  {

   const int found_point = StringFind(original, ".", 0);

   const string subtract = StringSubstr(original, found_point, -1);

   const string correct_symbol = StringSubstr(original, 0, found_point);


   return (correct_symbol);
  }


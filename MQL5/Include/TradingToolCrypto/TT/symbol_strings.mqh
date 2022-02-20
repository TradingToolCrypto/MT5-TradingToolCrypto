//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, TradingToolCrypto Corp."
#property link      "https://github.com/tradingtoolcrypto"

/*
  EURUSD.suffic
  GBPUSD_LMAX
  TRYGBP.Lmx

  ("eurusd" , ".")
*/
string format_symbol_uppercase(string text, string suffix_identifier)
  {
   string array_text[];                         // An array to get strings
   string sep = suffix_identifier;              // A separator as a character
   ushort u_sep;                                // The code of the separator character
//--- Get the separator code
   u_sep = StringGetCharacter(sep, 0);
   int dash_count = StringSplit(text, u_sep, array_text);
   string format = "";
   if(dash_count > 1)
     {
      //--- Work with the strings individually
      StringToUpper(array_text[0]);
      StringToLower(array_text[1]);
      // CB_ChartAll has .byb.all
      if(dash_count == 3)
        {
         StringToLower(array_text[2]);
         format = array_text[0] + sep + array_text[1] + sep + array_text[2] ;
        }
      else
        {
         format = array_text[0] + sep + array_text[1];
        }
      return(format);
     }
   else
     {
      //--- No suffix found, return the same string
      StringToUpper(text);
      return(text);
     }
   return(text);
  }

//order_type( PositionGetInteger(POSITION_TYPE))
string order_type(int type_order)
  {
   if(type_order == 0)
     {
      return("Buy");
     }
   if(type_order == 1)
     {
      return("Sell");
     }
   return("Limit/Stop");
  }

string GLOBAL_SYMBOL_LIST_1 = "";
string GLOBAL_SYMBOL_LIST_2 = "";
string GLOBAL_SYMBOL_LIST_3 = "";
string GLOBAL_SYMBOL_LIST_4 = "";
string GLOBAL_SYMBOL_LIST_5 = "";
string GLOBAL_SYMBOL_LIST_6 = "";
string GLOBAL_SYMBOL_LIST_7 = "";
string GLOBAL_SYMBOL_LIST_8 = "";
string GLOBAL_SYMBOL_LIST_9 = "";
string GLOBAL_SYMBOL_LIST_10 = "";
void list_symbols(bool ListOnlyMarketWatch, int list_length)
  {
   int loop =  SymbolsTotal(true);
   string msg = "";
   for(int i = 0; loop > i; i++)
     {
      if(list_length > i)
        {
         GLOBAL_SYMBOL_LIST_1 += "\n" + SymbolName(i, ListOnlyMarketWatch);
        }
      if(list_length * 2 < i && i < list_length * 3)
        {
         GLOBAL_SYMBOL_LIST_2 += "\n" + SymbolName(i, ListOnlyMarketWatch);
        }
      if(list_length * 3 < i && i < list_length * 4)
        {
         GLOBAL_SYMBOL_LIST_3 += "\n" + SymbolName(i, ListOnlyMarketWatch);
        }
      if(list_length * 4 < i && i < list_length * 5)
        {
         GLOBAL_SYMBOL_LIST_4 += "\n" + SymbolName(i, ListOnlyMarketWatch);
        }
      if(list_length * 5 < i && i < list_length * 6)
        {
         GLOBAL_SYMBOL_LIST_5 += "\n" + SymbolName(i, ListOnlyMarketWatch);
        }
      if(list_length * 6 < i && i < list_length * 7)
        {
         GLOBAL_SYMBOL_LIST_6 += "\n" + SymbolName(i, ListOnlyMarketWatch);
        }
      if(list_length * 7 < i && i < list_length * 8)
        {
         GLOBAL_SYMBOL_LIST_7 += "\n" + SymbolName(i, ListOnlyMarketWatch);
        }
      if(list_length * 8 < i && i < list_length * 9)
        {
         GLOBAL_SYMBOL_LIST_8 += "\n" + SymbolName(i, ListOnlyMarketWatch);
        }
      if(list_length * 9 < i && i < list_length * 10)
        {
         GLOBAL_SYMBOL_LIST_9 += "\n" + SymbolName(i, ListOnlyMarketWatch);
        }
      if(list_length * 10 < i && i < list_length * 11)
        {
         GLOBAL_SYMBOL_LIST_10 += "\n" + SymbolName(i, ListOnlyMarketWatch);
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string str_cornix_signal_truncate(double price, int price_digit)
  {
   string value1 = DoubleToString(price, price_digit);
   if(price >= 1.0)
     {
      return(value1);
     }
   int search1 = StringFind(value1, "0.0000000", 0);
   if(search1 != -1)
     {
      value1 =  StringSubstr(value1, 9, -1);
      return(value1);
     }
   int search2 = StringFind(value1, "0.000000", 0);
   if(search2 != -1)
     {
      value1 =  StringSubstr(value1, 8, -1);
      return(value1);
     }
   int search3 = StringFind(value1, "0.00000", 0);
   if(search3 != -1)
     {
      value1 =  StringSubstr(value1, 7, -1);
      return(value1);
     }
   int search4 = StringFind(value1, "0.0000", 0);
   if(search4 != -1)
     {
      value1 =  StringSubstr(value1, 6, -1);
      return(value1);
     }
   int search5 = StringFind(value1, "0.000", 0);
   if(search5 != -1)
     {
      value1 =  StringSubstr(value1, 5, -1);
      return(value1);
     }
   int search6 = StringFind(value1, "0.00", 0);
   if(search6 != -1)
     {
      value1 =  StringSubstr(value1, 4, -1);
      return(value1);
     }
   int search7 = StringFind(value1, "0.0", 0);
   if(search7 != -1)
     {
      value1 =  StringSubstr(value1, 3, -1);
      return(value1);
     }
   int search8 = StringFind(value1, "0.", 0);
   if(search8 != -1)
     {
      value1 =  StringSubstr(value1, 2, -1);
      return(value1);
     }
   return(value1);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string str_change_side_longshort(string side)
  {
   if(side == "BUY")
     {
      return("LONG");
     }
   if(side == "SELL")
     {
      return("SHORT");
     }
// no match
   return(side);
  }

/*
 /alert symbol 12345
*/


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string symbol_uppercase(string text, string suffix_identifier)
  {
   string array_text[];                         // An array to get strings
   string sep = suffix_identifier;              // A separator as a character
   ushort u_sep;                                // The code of the separator character
//--- Get the separator code
   u_sep = StringGetCharacter(sep, 0);
   int dash_count = StringSplit(text, u_sep, array_text);
   if(dash_count > 1)
     {
      //--- Work with the strings individually
      StringToUpper(array_text[1]);
      return(array_text[1]);
     }
   return("");
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string symbol_price(string text, string suffix_identifier)
  {
   string array_text[];                         // An array to get strings
   string sep = suffix_identifier;              // A separator as a character
   ushort u_sep;                                // The code of the separator character
//--- Get the separator code
   u_sep = StringGetCharacter(sep, 0);
   int dash_count = StringSplit(text, u_sep, array_text);
   if(dash_count > 2)
     {
      //--- Work with the strings individually
      return(array_text[2]);
     }
   return("");
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string symbol_remove_suffix(string chart_symbol)
  {
   /*
      BTCUSDT.binance
      BTCUSD.b2b
   */
   const string sep = ".";          // A separator as a character
   ushort u_sep;                    // The code of the separator character
   string result[];                 // An array to get strings
   u_sep = StringGetCharacter(sep, 0);
   int k = StringSplit(chart_symbol, u_sep, result);
   string value = "";
   if(k > 0)
     {
      value = result[0];
     }
   return(value);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string symbol_return_suffix(string chart_symbol)
  {
   /*
      BTCUSDT.binance
      BTCUSD.b2b
   */
   const string sep = ".";          // A separator as a character
   ushort u_sep;                    // The code of the separator character
   string result[];                 // An array to get strings
   u_sep = StringGetCharacter(sep, 0);
   int k = StringSplit(chart_symbol, u_sep, result);
   string value = "";
   if(k > 1)
     {
      //Print(" DEBUG K " + k  + " symbol " + chart_symbol);
      value = sep + result[1];
     }
   return(value);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string remove_zeros_from_string(string value)
  {
   bool debug = false;
   string create = "";
   string result = "";
   int decimal = StringFind(value, ".", 0);
   string decimal_before = StringSubstr(value, 0, decimal);
   string decimal_after = StringSubstr(value, decimal + 1, -1);
   int decimal_length = StringLen(decimal_after);
   int try1 = StringFind(decimal_after, "0", decimal_length - 1);
   if(try1 != -1)
     {
      string found_zero_1 = StringSubstr(decimal_after, 0, decimal_length - 1);
      if(debug)
         Print(" Found then Edit ==> " + found_zero_1);
      int try2 = StringFind(found_zero_1, "0", decimal_length - 2);
      if(try2 != -1)
        {
         string found_zero_2 = StringSubstr(found_zero_1, 0, decimal_length - 2);
         if(debug)
            Print(" Found then Edit ==> " + found_zero_2);
         int try3 = StringFind(found_zero_2, "0", decimal_length - 3);
         if(try3 != -1)
           {
            string found_zero_3 = StringSubstr(found_zero_2, 0, decimal_length - 3);
            if(debug)
               Print(" Found then Edit ==> " + found_zero_3);
            int try4 = StringFind(found_zero_3, "0", decimal_length - 4);
            if(try4 != -1)
              {
               string found_zero_4 = StringSubstr(found_zero_3, 0, decimal_length - 4);
               if(debug)
                  Print(" Found then Edit ==> " + found_zero_4);
               int try5 = StringFind(found_zero_4, "0", decimal_length - 5);
               if(try5 != -1)
                 {
                  string found_zero_5 = StringSubstr(found_zero_4, 0, decimal_length - 5);
                  if(debug)
                     Print(" Found then Edit ==> " + found_zero_5);
                  int try6 = StringFind(found_zero_5, "0", decimal_length - 6);
                  if(try6 != -1)
                    {
                     string found_zero_6 = StringSubstr(found_zero_5, 0, decimal_length - 6);
                     if(debug)
                        Print(" Found then Edit ==> " + found_zero_6);
                     int try7 = StringFind(found_zero_6, "0", decimal_length - 7);
                     if(try7 != -1)
                       {
                        string found_zero_7 = StringSubstr(found_zero_6, 0, decimal_length - 7);
                        if(debug)
                           Print(" Found then Edit ==> " + found_zero_7);
                        int try8 = StringFind(found_zero_7, "0", decimal_length - 8);
                        if(try8 != -1)
                          {
                           string found_zero_8 = StringSubstr(found_zero_7, 0, decimal_length - 8);
                           if(debug)
                              Print(" Found then Edit ==> " + found_zero_8);
                           int try9 = StringFind(found_zero_8, "0", decimal_length - 9);
                          }
                        else
                          {
                           create  = found_zero_7;
                          }
                       }
                     else
                       {
                        create  = found_zero_6;
                       }
                    }
                  else
                    {
                     create  = found_zero_5;
                    }
                 }
               else
                 {
                  create  = found_zero_4;
                 }
              }
            else
              {
               create  = found_zero_3;
              }
           }
         else
           {
            create  = found_zero_2;
           }
        }
      else
        {
         create  = found_zero_1;
        }
     }
   else
     {
      create = decimal_after;
     }
   if(create != "")
     {
      result = decimal_before + "." + create;
     }
   else
     {
      result = decimal_before;
     }
   if(debug)
      Print(" FINAL RESULT " + result);
   return(result);
  }
//+------------------------------------------------------------------+

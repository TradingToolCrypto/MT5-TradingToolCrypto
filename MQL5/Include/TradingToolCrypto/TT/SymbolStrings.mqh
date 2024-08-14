//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, TradingToolCrypto Corp."
#property link "https://github.com/tradingtoolcrypto"

/*
 August 2024 : refactor : remove Lib to header
*/

string parser = "#";

/*
  EURUSD.suffic
  GBPUSD_LMAX
  TRYGBP.Lmx

  ("eurusd" , ".")
*/
string SymbolFormatSuffix(string text, string suffix_identifier)
  {
   string array_text[];            // An array to get strings
   string sep = suffix_identifier; // A separator as a character
   ushort u_sep;                   // The code of the separator character
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
         format = array_text[0] + sep + array_text[1] + sep + array_text[2];
        }
      else
        {
         format = array_text[0] + sep + array_text[1];
        }
      return (format);
     }
   else
     {
      //--- No suffix found, return the same string
      StringToUpper(text);
      return (text);
     }
   return (text);
  }

// PositionOrderType( PositionGetInteger(POSITION_TYPE))
string PositionOrderType(int type_order)
  {
   if(type_order == 0)
     {
      return ("Buy");
     }
   if(type_order == 1)
     {
      return ("Sell");
     }
   return ("Limit/Stop");
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
void ListMarketWatchSymbols(bool ListOnlyMarketWatch, int list_length)
  {
   int loop = SymbolsTotal(true);
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
string Cornix_SignalData(double price, int price_digit)
  {
   string value1 = DoubleToString(price, price_digit);
   if(price >= 1.0)
     {
      return (value1);
     }
   int search1 = StringFind(value1, "0.0000000", 0);
   if(search1 != -1)
     {
      value1 = StringSubstr(value1, 9, -1);
      return (value1);
     }
   int search2 = StringFind(value1, "0.000000", 0);
   if(search2 != -1)
     {
      value1 = StringSubstr(value1, 8, -1);
      return (value1);
     }
   int search3 = StringFind(value1, "0.00000", 0);
   if(search3 != -1)
     {
      value1 = StringSubstr(value1, 7, -1);
      return (value1);
     }
   int search4 = StringFind(value1, "0.0000", 0);
   if(search4 != -1)
     {
      value1 = StringSubstr(value1, 6, -1);
      return (value1);
     }
   int search5 = StringFind(value1, "0.000", 0);
   if(search5 != -1)
     {
      value1 = StringSubstr(value1, 5, -1);
      return (value1);
     }
   int search6 = StringFind(value1, "0.00", 0);
   if(search6 != -1)
     {
      value1 = StringSubstr(value1, 4, -1);
      return (value1);
     }
   int search7 = StringFind(value1, "0.0", 0);
   if(search7 != -1)
     {
      value1 = StringSubstr(value1, 3, -1);
      return (value1);
     }
   int search8 = StringFind(value1, "0.", 0);
   if(search8 != -1)
     {
      value1 = StringSubstr(value1, 2, -1);
      return (value1);
     }
   return (value1);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string PositionOrderDirection(string side)
  {
   if(side == "BUY")
     {
      return ("LONG");
     }
   if(side == "SELL")
     {
      return ("SHORT");
     }
// no match
   return (side);
  }

/*
 /alert symbol 12345
*/

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string SymbolFormatCase(string text, string suffix_identifier)
  {
   string array_text[];            // An array to get strings
   string sep = suffix_identifier; // A separator as a character
   ushort u_sep;                   // The code of the separator character
//--- Get the separator code
   u_sep = StringGetCharacter(sep, 0);
   int dash_count = StringSplit(text, u_sep, array_text);
   if(dash_count > 1)
     {
      //--- Work with the strings individually
      StringToUpper(array_text[1]);
      return (array_text[1]);
     }
   return ("");
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string SymbolFormatPrice(string text, string suffix_identifier)
  {
   string array_text[];            // An array to get strings
   string sep = suffix_identifier; // A separator as a character
   ushort u_sep;                   // The code of the separator character
//--- Get the separator code
   u_sep = StringGetCharacter(sep, 0);
   int dash_count = StringSplit(text, u_sep, array_text);
   if(dash_count > 2)
     {
      //--- Work with the strings individually
      return (array_text[2]);
     }
   return ("");
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string SymbolSuffixRemove(string chart_symbol)
  {
   /*
      BTCUSDT.binance
      BTCUSD.b2b
   */
   const string sep = "."; // A separator as a character
   ushort u_sep;           // The code of the separator character
   string result[];        // An array to get strings
   u_sep = StringGetCharacter(sep, 0);
   int k = StringSplit(chart_symbol, u_sep, result);
   string value = "";
   if(k > 0)
     {
      value = result[0];
     }
   return (value);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string SymbolSuffixIs(string chart_symbol)
  {
   /*
      BTCUSDT.binance
      BTCUSD.b2b
   */
   const string sep = "."; // A separator as a character
   ushort u_sep;           // The code of the separator character
   string result[];        // An array to get strings
   u_sep = StringGetCharacter(sep, 0);
   int k = StringSplit(chart_symbol, u_sep, result);
   string value = "";
   if(k > 1)
     {
      // Print(" DEBUG K " + k  + " symbol " + chart_symbol);
      value = sep + result[1];
     }
   return (value);
  }

//+------------------------------------------------------------------+

/*

 take the market name BTCUSD_PERP and return BTCUSDPERP

 NormalizeSymbol("BTCUSD_PERP", "_");

*/
string RemoveSymbolSeperator(string symbolname, string seperator)
  {
   string sep = seperator;
   ushort u_sep;
   string result[];
   u_sep = StringGetCharacter(sep, 0);
   int k = StringSplit(symbolname, u_sep, result);
   /*
   found the sep
   */
   string merge = "";
   if(k == 2)
     {
      merge = result[0] + result[1];
      return (merge);
     }
   return (symbolname);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int GetOrderNumberFromLineName(string linename)
  {

   /*
   BTCUSDT_TYPE_SIDE_VOLUME_#
   */
   string sep = parser; // A separator as a character
   ushort u_sep;        // The code of the separator character
   string result[];     // An array to get strings
//--- Get the separator code
   u_sep = StringGetCharacter(sep, 0);
//--- Split the string to substrings
   int k = StringSplit(linename, u_sep, result);
   if(k != 5)
      return (0);
   string value = result[4];
   int convert_value = (int)StringToInteger(value);

   return (convert_value);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string GetVolumeFromLineName(string linename)
  {

   /*
   BTCUSDT_TYPE_SIDE_VOLUME_#
   */
   string sep = parser; // A separator as a character
   ushort u_sep;        // The code of the separator character
   string result[];     // An array to get strings
//--- Get the separator code
   u_sep = StringGetCharacter(sep, 0);
//--- Split the string to substrings
   int k = StringSplit(linename, u_sep, result);
   if(k != 5)
     {
      return ("");
     }

   string value = result[3];
   return (value);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string GetSideFromLineName(string linename)
  {

   /*
   BTCUSDT_TYPE_SIDE_VOLUME_#
   */
   string sep = parser; // A separator as a character
   ushort u_sep;        // The code of the separator character
   string result[];     // An array to get strings
//--- Get the separator code
   u_sep = StringGetCharacter(sep, 0);
//--- Split the string to substrings
   int k = StringSplit(linename, u_sep, result);
   if(k != 5)
     {
      return ("");
     }
   string value = result[2];

   return (value);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string GetTypeFromLineName(string linename)
  {

   /*
   BTCUSDT_TYPE_SIDE_VOLUME_#
   */
   string sep = parser; // A separator as a character
   ushort u_sep;        // The code of the separator character
   string result[];     // An array to get strings
//--- Get the separator code
   u_sep = StringGetCharacter(sep, 0);
//--- Split the string to substrings
   int k = StringSplit(linename, u_sep, result);
   if(k != 5)
     {
      return ("");
     }
   string value = result[1];
   return (value);
  }

/*
 find the object order_id#
 grab the desc of that object == Order ID ,
*/
string GetObjectDesc(int what_order_number)
  {

   if(ObjectFind(0, "order_id" + IntegerToString(what_order_number)) != -1)
     {
      return (ObjectGetString(0, "order_id" + IntegerToString(what_order_number), OBJPROP_TEXT, 0));
     }
   return ("");
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DeleteOjectLinesByName(string linedesc)
  {

   bool dev_debug = false;
   int loop = ObjectsTotal(0, 0, 2); // Main chart, not subwindow | Type of 2 = Trend Lines

   if(loop == 0)
     {
      return;
     }

   for(int i = 0; i < loop; i++)
     {

      string objname = ObjectName(0, i, 0, 2); //| Type of 2 = Trend Lines

      if(dev_debug)
        {
         Print(" DeleteOjectLinesByName() : ObjectName : " + objname + " | Look for : " + linedesc);
        }

      if(ObjectGetString(0, objname, OBJPROP_NAME, 0) == linedesc)
        {
         if(ObjectDelete(0, objname) == false)
           {
            if(dev_debug)
              {
               Print("Delete_Object_Name: Failed " + IntegerToString(GetLastError()));
              }
           }
         else
           {

            if(dev_debug)
              {
               Print("Delete_Object_Name: Success ");
              }
           }
        }
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DeleteOjectLinesByDesc(string linedesc)
  {
   bool dev_debug = false;
   int loop = ObjectsTotal(0, 0, OBJ_TREND); // Main chart, not subwindow
   if(loop != 0)
     {
      for(int i = 0; i < loop; i++)
        {

         string objname = ObjectName(0, i, 0, OBJ_TREND);
         if(dev_debug)
           {
            Print(" DeleteOjectLinesByDesc() : objectname|" + objname + "|" + linedesc + "|");
           }
         if(ObjectGetString(0, objname, OBJPROP_TEXT, 0) == linedesc)
           {
            if(ObjectDelete(0, objname) == false)
              {
               if(dev_debug)
                 {
                  Print("Delete_Object_Name: Failed " + IntegerToString(GetLastError()));
                 }
              }
            else
              {

               if(dev_debug)
                 {
                  Print("Delete_Object_Name: Success ");
                 }
              }
           }
        }
     }

   /*
   H LINES
   */
   int loopH = ObjectsTotal(0, 0, OBJ_HLINE); // Main chart, not subwindow | Type of 1 = horizontal lines only
   if(loopH != 0)
     {
      for(int i = 0; i < loopH; i++)
        {
         string objname = ObjectName(0, i, 0, OBJ_HLINE);
         if(dev_debug)
           {
            Print(" DeleteOjectLinesByDesc() : objectname|" + objname + "|" + linedesc + "|");
           }
         if(ObjectGetString(0, objname, OBJPROP_TEXT, 0) == linedesc)
           {
            if(ObjectDelete(0, objname) == false)
              {
               if(dev_debug)
                 {
                  Print("Delete_Object_Name: Failed " + IntegerToString(GetLastError()));
                 }
              }
            else
              {

               if(dev_debug)
                 {
                  Print("Delete_Object_Name: Success ");
                 }
              }
           }
        }
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DeleteOjectLines(string sym)
  {
   bool dev_debug = false;
   int loop = ObjectsTotal(0, 0, 1); // Main chart, not subwindow | Type of 1 = horizontal lines only

   if(loop == 0)
     {
      return;
     }
   string sep = parser; // A separator as a character
   ushort u_sep;        // The code of the separator character
   string result[];     // An array to get strings
   u_sep = StringGetCharacter(sep, 0);
   for(int i = loop; i > 0; i--)
     {
      string is_string_sym = ObjectName(0, i - 1, 0, 1); // ObjectName(chartid,index,window,objecttype); == Object index starts at 0 ( Problem solved)
      if(dev_debug)
         Print(" Line Name == " + is_string_sym);
      int value = StringSplit(is_string_sym, u_sep, result);
      if(value >= 1)
        {
         if(result[0] == sym)
           {
            if(ObjectDelete(0, is_string_sym) == false)
              {
               if(dev_debug)
                 {
                  Print("Delete_Object_Name: Failed " + IntegerToString(GetLastError()));
                 }
              }
            else
              {
               if(dev_debug)
                 {
                  Print("Delete_Object_Name: Success ");
                 }
              }
           }
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CreateOrderEntryLine(string name, string text, datetime time1, double price1, datetime time2, double price2, color col, int lineWidth, int lineStyle)
  {

   price2 = price1;

   if(ObjectCreate(0, name, OBJ_HLINE, 0, time1, price1))
     {
      // ObjectSetDouble(0,name,OBJPROP_PRICE,price1);
      ObjectSetInteger(0, name, OBJPROP_COLOR, col);
      ObjectSetInteger(0, name, OBJPROP_WIDTH, lineWidth);
      ObjectSetInteger(0, name, OBJPROP_STYLE, lineStyle);
      ObjectSetInteger(0, name, OBJPROP_BACK, true);
      ObjectSetString(0, name, OBJPROP_TEXT, text);
      ObjectSetInteger(0, name, OBJPROP_SELECTABLE, true);
      ObjectSetInteger(0, name, OBJPROP_HIDDEN, false);
      return (true);
     }
   return (false);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CreateTPLine(string name, string text, datetime time1, double price1, datetime time2, double price2, color col, int lineWidth, int lineStyle)
  {
   price2 = price1;

   if(ObjectFind(0, name) != -1)
     {
      if(ObjectCreate(0, name, OBJ_EDIT, 0, time1, price1, time2, price2))
        {
         ObjectSetInteger(0, name, OBJPROP_COLOR, col);
         ObjectSetInteger(0, name, OBJPROP_WIDTH, lineWidth);
         ObjectSetInteger(0, name, OBJPROP_STYLE, lineStyle);
         ObjectSetInteger(0, name, OBJPROP_BACK, true);
         ObjectSetString(0, name, OBJPROP_TEXT, text);
         ObjectSetInteger(0, name, OBJPROP_SELECTABLE, false); // allow adjusting the lines
         ObjectSetInteger(0, name, OBJPROP_HIDDEN, false);
         return (true);
        }
     }
   else
     {
      if(ObjectCreate(0, name, OBJ_TREND, 0, time1, price1, time2, price2))
        {
         ObjectSetInteger(0, name, OBJPROP_COLOR, col);
         ObjectSetInteger(0, name, OBJPROP_WIDTH, lineWidth);
         ObjectSetInteger(0, name, OBJPROP_STYLE, lineStyle);
         ObjectSetInteger(0, name, OBJPROP_BACK, true);
         ObjectSetString(0, name, OBJPROP_TEXT, text);
         ObjectSetInteger(0, name, OBJPROP_SELECTABLE, false);
         ObjectSetInteger(0, name, OBJPROP_HIDDEN, false);
         return (true);
        }
     }
   return (false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CreateEntryLine(string name, string text, datetime time1, double price1, datetime time2, double price2, color col, int lineWidth, int lineStyle)
  {

   price2 = price1;

   if(ObjectFind(0, name) != -1)
     {
      if(ObjectCreate(0, name, OBJ_EDIT, 0, time1, price1, time2, price2))
        {
         ObjectSetInteger(0, name, OBJPROP_COLOR, col);
         ObjectSetInteger(0, name, OBJPROP_WIDTH, lineWidth);
         ObjectSetInteger(0, name, OBJPROP_STYLE, lineStyle);
         ObjectSetInteger(0, name, OBJPROP_BACK, true);
         ObjectSetString(0, name, OBJPROP_TEXT, text);
         ObjectSetInteger(0, name, OBJPROP_SELECTABLE, false); // allow adjusting the lines
         ObjectSetInteger(0, name, OBJPROP_HIDDEN, false);
         return (true);
        }
     }
   else
     {

      if(ObjectCreate(0, name, OBJ_TREND, 0, time1, price1, time2, price2))
        {
         // ObjectSetDouble(0,name,OBJPROP_PRICE,price1);
         ObjectSetInteger(0, name, OBJPROP_COLOR, col);
         ObjectSetInteger(0, name, OBJPROP_WIDTH, lineWidth);
         ObjectSetInteger(0, name, OBJPROP_STYLE, lineStyle);
         ObjectSetInteger(0, name, OBJPROP_BACK, true);
         ObjectSetString(0, name, OBJPROP_TEXT, text);
         ObjectSetInteger(0, name, OBJPROP_SELECTABLE, false);
         ObjectSetInteger(0, name, OBJPROP_HIDDEN, false);
         return (true);
        }
     }
   return (false);
  }

/*
- deletes one global variable based on the exchange name "Bybit"
- and the double value of the global ( the order # 1,2,3,4,5,6,7,8,)
- only one variable is deleted if true, then function breaks out of loop
*/
void DeleteGlobalOrderName(string exchangeName, string sym, double value)
  {

   bool dev_debug = false;
   string name = "";
   int total = GlobalVariablesTotal();
   int countorders = 0; // COUNTER STARTS AT ZERO

   if(total == 0)
     {
      return;
     }
   for(int i = 0; i < total; i++)
     {
      name = GlobalVariableName(i);

      int dash1 = StringFind(name, parser, 0); //
      string exchange = StringSubstr(name, 0, dash1);
      if(exchange == exchangeName && dash1 != -1)
        {

         /*
         Exchange TYPE = Binance_Order
         */
         int dash2 = StringFind(name, parser, dash1 + 1); // SCAN AFTER THE PREVIOUS DASH
         string wal = StringSubstr(name, dash1 + 1, -1);  // FIND THE
         int dash3 = StringFind(wal, parser, 0);          // SCAN AFTER THE PREVIOUS DASH
         string wall = StringSubstr(wal, 0, 5);           // Order"
         if("Order" == wall && dash3 != -1)
           {

            string orderstring = StringSubstr(wal, dash3 + 1, -1);
            if(dev_debug)
               Print("Working with orderstring; Symbol - OrderType - Side - Price - Volume " + orderstring);

            int dash4 = StringFind(orderstring, parser, 0);      // SCAN AFTER THE PREVIOUS DASH
            string symbol = StringSubstr(orderstring, 0, dash4); // Symbol
            if(dev_debug)
              {
               Print("Find symbol: " + sym + " Working with string : " + symbol);
              }

            if(GlobalVariableGet(name) == value && symbol == sym)
              {

               GlobalVariableDel(name);
               if(dev_debug)
                 {
                  Print("Delete Global Name: " + name);
                 }
               break;
              }
           }
        }
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DeleteSubWindowObjectName(long id_order, int subWindow, string objectname)
  {
   bool dev_debug = false;
   int loop = ObjectsTotal(0, subWindow, -1);

   if(loop == 0)
     {
      return;
     }

   for(int i = 0; i < loop; i++)
     {

      if(ObjectDelete(id_order, objectname) == false)
        {
         if(dev_debug)
           {
            Print("Delete_SubWindow_Object_Name: Failed " + IntegerToString(GetLastError()));
           }
        }
      else
        {

         if(dev_debug)
           {
            Print("Delete_SubWindow_Object_Name: Success " + " objectname: " + objectname);
           }
         break;
        }
     }
  }
/*
 - delete all the subwindow objects with specific objectname
 - Delete_SubWindow_Object_All(ChardID(), sub_wallet_"+exchangeName+"_")  - this is the wallet or balance
 - Delete_SubWindow_Object_All(ChardID(), "sub_order_") - this is the order string
 - Delete_SubWindow_Object_All(ChardID(), "order_id")   - this is the order id string
 - Delete_SubWindow_Object_All(ChardID(), "orderid")    - this is the order edit button "X" to cancel individual orders
 - If you use the "Cancel All" function you should delete all the subwindow text variables as described above
*/
void DeleteSubWindowObjectAll(long chart_id, string objectname)
  {
   bool dev_debug = true;
   int loop = ObjectsTotal(0, 1, -1); // loop through all objects within the subwindow

   if(loop == 0)
     {
      return;
     }

   for(int i = 0; i < loop; i++)
     {

      if(ObjectDelete(chart_id, objectname + IntegerToString(i)) == false)
        {
         if(dev_debug)
           {
            Print("_MT5_Object_Delete Failed Error: " + IntegerToString(GetLastError()));
           }
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DeleteSubWindowObjectAll(long chart_id, int window_)
  {
   ObjectsDeleteAll(chart_id, window_, -1);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DeleteSubWindowObjectAll(long chart_id, int window_, string prefix)
  {
   ObjectsDeleteAll(chart_id, prefix, window_, -1);
  }
/*
 - delete all the global variables with a specific exchange and body
 - Delete_Global_Prefix("Binance","_Order")
*/
double GetGlobal(string ExchangeName, string body)
  {
   return (GlobalVariableGet(ExchangeName + body));
  }

/*
 - delete all the global variables with a specific name
 - Delete_Global_Prefix("Binance_Order")
 - Delete_Global_Prefix("Binance_Pos")
 - Delete_Global_Prefix("Binance_Wallet")
 - Delete_Global_Prefix("Binance_ETHUSDT")
  - delete all the global variables at one exchange
  - when the exchange  has been changed, delete all the variables for the previously activated exchange
*/

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DeleteGlobalPrefix(string prefix)
  {
   bool dev_debug = false;
   int value = 0;
   if(prefix != "")
     {
      value = GlobalVariablesDeleteAll(prefix, 0);
     }
   if(dev_debug)
     {
      Print(" Delete_Global_Prefix(string) :" + IntegerToString(value) + " prefix: " + prefix);
     }
  }

/*
 code originally from Bar_price indicator
*/
void SetRectLabel(string name, string text, int x, int y, color colour, int sizeWidth,
                  int sizeHeight,
                  int corner)
  {
   int find = ObjectFind(0, name);
   if(find >= 0)  // Object found in window 0 or window 1
     {
      ObjectSetInteger(0, name, OBJPROP_CORNER, corner);
      //    ObjectSetInteger(0, name, OBJPROP_ANCHOR, corner); No Anchor on rect_labels
      ObjectSetInteger(0, name, OBJPROP_XDISTANCE, x);
      ObjectSetInteger(0, name, OBJPROP_YDISTANCE, y);
      ObjectSetInteger(0, name, OBJPROP_XSIZE, sizeWidth);  // width
      ObjectSetInteger(0, name, OBJPROP_YSIZE, sizeHeight); // height

      ObjectSetInteger(0, name, OBJPROP_BGCOLOR, colour);
      ObjectSetInteger(0, name, OBJPROP_COLOR, colour);
      ObjectSetInteger(0, name, OBJPROP_BORDER_COLOR, colour);
      ObjectSetInteger(0, name, OBJPROP_BACK, true);
     }
   else
     {

      if(ObjectCreate(0, name, OBJ_RECTANGLE_LABEL, 0, 0, 0))
        {
         ObjectSetInteger(0, name, OBJPROP_CORNER, corner);
         //   ObjectSetInteger(0, name, OBJPROP_ANCHOR, corner);
         ObjectSetInteger(0, name, OBJPROP_XDISTANCE, x);
         ObjectSetInteger(0, name, OBJPROP_YDISTANCE, y);
         ObjectSetInteger(0, name, OBJPROP_XSIZE, sizeWidth);  // width
         ObjectSetInteger(0, name, OBJPROP_YSIZE, sizeHeight); // height
         ObjectSetInteger(0, name, OBJPROP_BGCOLOR, colour);
         ObjectSetInteger(0, name, OBJPROP_BORDER_COLOR, colour);
         ObjectSetInteger(0, name, OBJPROP_COLOR, colour);
         ObjectSetInteger(0, name, OBJPROP_BACK, true);
        }
      else
        {

         Print(" object creation failed; Error(): " + IntegerToString(GetLastError()));
        }
     }
  }

//+------------------------------------------------------------------+
void SetButton(
   string aObjName,
   bool aState,
   int aX = 30,
   int aY = 30,
   int aWidth = 100,
   int aHeight = 30,
   string aCaption = "Push Me",
   color aBgColor = Silver,
   color aTextColor = Red,
   int aWindow = 0,
   int aCorner = CORNER_LEFT_UPPER,
   int aFontSize = 0,
   string aFont = "",
   long aChartID = 0,
   bool aBack = false,
   long aTimeFrames = OBJ_ALL_PERIODS)
  {
   int find = ObjectFind(0, aObjName);
   if(find >= 0)  // Object found in window 0 or window 1
     {
      ObjectSetInteger(aChartID, aObjName, OBJPROP_STATE, aState);

      ObjectSetInteger(aChartID, aObjName, OBJPROP_CORNER, aCorner);
      ObjectSetInteger(aChartID, aObjName, OBJPROP_XDISTANCE, aX);
      ObjectSetInteger(aChartID, aObjName, OBJPROP_YDISTANCE, aY);
      ObjectSetInteger(aChartID, aObjName, OBJPROP_XSIZE, aWidth);
      ObjectSetInteger(aChartID, aObjName, OBJPROP_YSIZE, aHeight);
      ObjectSetInteger(aChartID, aObjName, OBJPROP_BGCOLOR, aBgColor);
      ObjectSetInteger(aChartID, aObjName, OBJPROP_COLOR, aTextColor);
      ObjectSetString(aChartID, aObjName, OBJPROP_FONT, aFont);
      ObjectSetInteger(aChartID, aObjName, OBJPROP_FONTSIZE, aFontSize);
      ObjectSetString(aChartID, aObjName, OBJPROP_TEXT, aCaption);
      ObjectSetInteger(aChartID, aObjName, OBJPROP_BACK, aBack);
      ObjectSetInteger(aChartID, aObjName, OBJPROP_TIMEFRAMES, aTimeFrames);

      ObjectSetInteger(aChartID, aObjName, OBJPROP_SELECTABLE, false);
      ObjectSetInteger(aChartID, aObjName, OBJPROP_SELECTED, false);
     }
   else
     {
      ObjectCreate(aChartID, aObjName, OBJ_BUTTON, aWindow, 0, 0);
      ObjectSetInteger(aChartID, aObjName, OBJPROP_STATE, aState);

      ObjectSetInteger(aChartID, aObjName, OBJPROP_CORNER, aCorner);
      ObjectSetInteger(aChartID, aObjName, OBJPROP_XDISTANCE, aX);
      ObjectSetInteger(aChartID, aObjName, OBJPROP_YDISTANCE, aY);
      ObjectSetInteger(aChartID, aObjName, OBJPROP_XSIZE, aWidth);
      ObjectSetInteger(aChartID, aObjName, OBJPROP_YSIZE, aHeight);
      ObjectSetInteger(aChartID, aObjName, OBJPROP_BGCOLOR, aBgColor);
      ObjectSetInteger(aChartID, aObjName, OBJPROP_COLOR, aTextColor);
      ObjectSetString(aChartID, aObjName, OBJPROP_FONT, aFont);
      ObjectSetInteger(aChartID, aObjName, OBJPROP_FONTSIZE, aFontSize);
      ObjectSetString(aChartID, aObjName, OBJPROP_TEXT, aCaption);
      ObjectSetInteger(aChartID, aObjName, OBJPROP_BACK, aBack);
      ObjectSetInteger(aChartID, aObjName, OBJPROP_TIMEFRAMES, aTimeFrames);

      ObjectSetInteger(aChartID, aObjName, OBJPROP_SELECTABLE, false);
      ObjectSetInteger(aChartID, aObjName, OBJPROP_SELECTED, false);
     }
  }

/*
 code originally from Bar_price indicator
*/
void SetLabel(string name, string text, int x, int y, color colour,
              int sizeText,
              int corner)
  {
   int find = ObjectFind(0, name);
   if(find >= 0)  // Object found in window 0 or window 1
     {
      ObjectSetString(0, name, OBJPROP_TEXT, text);

      ObjectSetInteger(0, name, OBJPROP_CORNER, corner);
      ObjectSetInteger(0, name, OBJPROP_ANCHOR, corner); // No Anchor on rect_labels

      ObjectSetInteger(0, name, OBJPROP_XDISTANCE, x);
      ObjectSetInteger(0, name, OBJPROP_YDISTANCE, y);

      ObjectSetInteger(0, name, OBJPROP_BGCOLOR, colour);
      ObjectSetInteger(0, name, OBJPROP_COLOR, colour);
      // ObjectSetInteger(0, name, OBJPROP_BORDER_COLOR, colour);
      ObjectSetInteger(0, name, OBJPROP_BACK, false);
     }
   else
     {

      if(ObjectCreate(0, name, OBJ_LABEL, 0, 0, 0))
        {
         ObjectSetString(0, name, OBJPROP_TEXT, text);
         ObjectSetInteger(0, name, OBJPROP_CORNER, corner);
         ObjectSetInteger(0, name, OBJPROP_ANCHOR, corner);
         ObjectSetInteger(0, name, OBJPROP_XDISTANCE, x);
         ObjectSetInteger(0, name, OBJPROP_YDISTANCE, y);

         ObjectSetInteger(0, name, OBJPROP_BGCOLOR, colour);
         //    ObjectSetInteger(0, name, OBJPROP_BORDER_COLOR, colour);
         ObjectSetInteger(0, name, OBJPROP_COLOR, colour);
         ObjectSetInteger(0, name, OBJPROP_BACK, false);
        }
      else
        {

         Print(" object creation failed; Error(): " + IntegerToString(GetLastError()));
        }
     }
  }
/*
  - find the object within the chart window and change the text
*/
void SetSubWindowText(string name, string text, int x, int y, color colour, int size)
  {

   bool dev_debug = false;
   int find = ObjectFind(0, name);

   if(find >= 0)  // Object found in window 0 or window 1
     {
      //  Print("OBJECT FOUND "+name  + " chart window():" + find );
      string ob_text = ObjectGetString(0, name, OBJPROP_TEXT, 0);
      //  Print("OBJECT FOUND "+name+" obj(text):"+ob_text+" change obj(text): "+text);
      if(ob_text != text)
        {

         if(ObjectSetString(0, name, OBJPROP_TEXT, text))
           {
            // Print("Set_Sub_Window_Text() Text Updated: "+text);
           }
         else
           {
            if(dev_debug)
              {
               Print(" objectSetString failed; Error(): " + IntegerToString(GetLastError()));
              }
           }
        }
     }
   else
     {
      if(ObjectCreate(0, name, OBJ_LABEL, 1, 0, 0))
        {
         ObjectSetInteger(0, name, OBJPROP_XDISTANCE, x);
         ObjectSetInteger(0, name, OBJPROP_YDISTANCE, y);
         ObjectSetInteger(0, name, OBJPROP_COLOR, colour);
         ObjectSetInteger(0, name, OBJPROP_FONTSIZE, size);
         ObjectSetInteger(0, name, OBJPROP_CORNER, CORNER_LEFT_UPPER);
         ObjectSetString(0, name, OBJPROP_TEXT, text);
         if(dev_debug)
           {
            Print(" object created: " + name);
           }
        }
      else
        {
         if(dev_debug)
           {
            Print(" object creation failed; Error(): " + IntegerToString(GetLastError()));
           }
        }
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void SetTextAnyCorner(string name, string text, datetime time_now, double price_now, color colour,
                      int size = 12,
                      int corner = 0)
  {
   int find = ObjectFind(0, name);
   if(find >= 0)  // Object found in window 0 or window 1
     {
      ObjectSetDouble(0, name, OBJPROP_PRICE, 0, price_now);
      ObjectSetInteger(0, name, OBJPROP_TIME, 0, (long)time_now);
      ObjectSetInteger(0, name, OBJPROP_COLOR, colour);
      ObjectSetInteger(0, name, OBJPROP_FONTSIZE, size);
      ObjectSetString(0, name, OBJPROP_TEXT, text);
      ObjectSetInteger(0, name, OBJPROP_CORNER, corner);
     }
   else
     {
      //+------------------------------------------------------------------+
      //|                             0= window 1 subwindo                                      |
      //+------------------------------------------------------------------+
      if(ObjectCreate(0, name, OBJ_ARROW_RIGHT_PRICE, 0, time_now, price_now))
        {

         ObjectSetDouble(0, name, OBJPROP_PRICE, 1, price_now);
         ObjectSetInteger(0, name, OBJPROP_TIME, 1, (long)time_now);
         ObjectSetInteger(0, name, OBJPROP_COLOR, colour);
         ObjectSetInteger(0, name, OBJPROP_FONTSIZE, size);
         ObjectSetString(0, name, OBJPROP_TEXT, text);
         ObjectSetInteger(0, name, OBJPROP_CORNER, corner);
        }
      else
        {

         Print(" object creation failed; Error(): " + IntegerToString(GetLastError()));
        }
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void SetAnySubWindowText(int subWindowIndex, string name, string text, int x, int y, color colour, int size, int corner = CORNER_LEFT_UPPER)
  {

   bool dev_debug = false;
   int find = ObjectFind(subWindowIndex, name);

   if(find >= 0)  // Object found in window i
     {

      string ob_text = ObjectGetString(0, name, OBJPROP_TEXT, 0);
      ObjectSetInteger(0, name, OBJPROP_XDISTANCE, x);
      ObjectSetInteger(0, name, OBJPROP_YDISTANCE, y);
      ObjectSetInteger(0, name, OBJPROP_COLOR, colour);
      ObjectSetInteger(0, name, OBJPROP_FONTSIZE, size);
      ObjectSetInteger(0, name, OBJPROP_CORNER, corner);
      ObjectSetInteger(0, name, OBJPROP_ANCHOR, corner);

      if(ob_text != text)
        {
         ObjectSetString(0, name, OBJPROP_TEXT, text);
        }
     }
   else
     {
      if(ObjectCreate(0, name, OBJ_LABEL, subWindowIndex, 0, 0))
        {
         ObjectSetInteger(0, name, OBJPROP_XDISTANCE, x);
         ObjectSetInteger(0, name, OBJPROP_YDISTANCE, y);
         ObjectSetInteger(0, name, OBJPROP_COLOR, colour);
         ObjectSetInteger(0, name, OBJPROP_FONTSIZE, size);
         ObjectSetInteger(0, name, OBJPROP_CORNER, corner);
         ObjectSetInteger(0, name, OBJPROP_ANCHOR, corner);
         ObjectSetString(0, name, OBJPROP_TEXT, text);
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void RewriteGlobals(string checkifexist, string replacewith)
  {

   bool good = GlobalVariableCheck(checkifexist);
   if(good)
     {
      double get = GlobalVariableGet(checkifexist);
      GlobalVariableSet(replacewith, get);
     }
  }

/*
   Take any number represented as a string and normalize the decimal accuracy

   Example:

   normalizeString("958.8483, 2) == 958.84
*/

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string NormalizeString(string value, int digit)
  {
   bool debug = false;

   /*
    Check the string for "." if the value is not found, return the string
   */
   if(StringFind(value, ".", 0) == -1)
     {
      return (value);
     }
   /*
       if we want to normalize digit = 0 , then search for the "." and remove the values
     Check the string for "." if the value is not found, return the string
    */
   if(digit == 0)
     {
      int placement = StringFind(value, ".", 0);
      int lengt = StringLen(value);

      if(debug)
         Print(" Length " + (string)lengt + " placement " + (string)placement);

      if(placement >= 0)
        {

         value = StringSubstr(value, 0, placement);
         return (value);
        }
     }

   string sep = ".";
   ushort u_sep;
   string result[];

   u_sep = StringGetCharacter(sep, 0);

   int k = StringSplit(value, u_sep, result);

   string s_whole = result[0];

   string s_decimal = result[1];

   int length = StringLen(s_decimal);

   string add = StringSubstr(s_decimal, 0, digit);

   string ok = s_whole + "." + add;

   return (ok);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int ChartWidthInPixels(const long chart_ID = 0)
  {
   bool debug = false;
//--- prepare the variable to get the property value
   long result = -1;
//--- reset the error value
   ResetLastError();
//--- receive the property value
   if(!ChartGetInteger(chart_ID, CHART_WIDTH_IN_PIXELS, 0, result))
     {
      //--- display the error message in Experts journal
      // Print(__FUNCTION__+", Error Code = ",GetLastError());
      if(debug)
         Print(__FUNCTION__ + ", Error Code = ", GetLastError() + " chartid: " + chart_ID + " | r " + result);
     }
//--- return the value of the chart property
   return ((int)result);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int ChartHeightInPixels(const long chart_ID = 0)
  {
   bool debug = false;
//--- prepare the variable to get the property value
   long result = -1;
//--- reset the error value
   ResetLastError();
//--- receive the property value
   if(!ChartGetInteger(chart_ID, CHART_HEIGHT_IN_PIXELS, 0, result))
     {
      //--- display the error message in Experts journal
      if(debug)
         Print(__FUNCTION__ + ", Error Code = ", GetLastError() + " chartid: " + chart_ID + " | r " + result);
     }
//--- return the value of the chart property
   return ((int)result);
  }
//+------------------------------------------------------------------+

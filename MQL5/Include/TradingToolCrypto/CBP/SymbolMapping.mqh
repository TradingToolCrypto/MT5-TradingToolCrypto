//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, TradingToolCrypto Corp"
#property link "https://github.com/TradingToolCrypto"

input group "LOT MULTIPLIER"
input string text_1 = "MT5 Position Size Times Lot Multiplier = Exchange Position";
input double LotMultiplier = 0.1;
input group "PRICE DEVIATION | 0.1% FROM ENTRY PRICE"
input double DeviationPercentage = 0.1;
input group "CUSTOM"
input int TimerSpeed = 500;
input bool ResyncTradesOnNewBar = false;
input ENUM_TIMEFRAMES  ResyncTimeframe = PERIOD_CURRENT;

input bool   AutoSymbolMapping = true;
input string SymbolMapping_Separator = ".";
input string SymbolMapping_Add = "T";

input group "MANUAL SYMBOL MAPPING"
input string MT5_Symbol_1 = "BTCUSD.b2b";
input string EXC_Symbol_1 = "BTCUSDT";
input double LM_Symbol_1 = 1;

input string MT5_Symbol_2 = "";
input string EXC_Symbol_2 = "";
input double LM_Symbol_2 = 1;

input string MT5_Symbol_3 = "";
input string EXC_Symbol_3 = "";
input double LM_Symbol_3 = 1;

input string MT5_Symbol_4 = "";
input string EXC_Symbol_4 = "";
input double LM_Symbol_4 = 1;

input string MT5_Symbol_5 = "";
input string EXC_Symbol_5 = "";
input double LM_Symbol_5 = 1;

input string MT5_Symbol_6 = "";
input string EXC_Symbol_6 = "";
input double LM_Symbol_6 = 1;

input string MT5_Symbol_7 = "";
input string EXC_Symbol_7 = "";
input double LM_Symbol_7 = 1;

input string MT5_Symbol_8 = "";
input string EXC_Symbol_8 = "";
input double LM_Symbol_8 = 1;

input string MT5_Symbol_9 = "";
input string EXC_Symbol_9 = "";
input double LM_Symbol_9 = 1;

input string MT5_Symbol_10 = "";
input string EXC_Symbol_10 = "";
input double LM_Symbol_10 = 1;

input string MT5_Symbol_11 = "BTCUSD.b2b";
input string EXC_Symbol_11 = "BTCUSDT";
input double LM_Symbol_11 = 1;

input string MT5_Symbol_12 = "";
input string EXC_Symbol_12 = "";
input double LM_Symbol_12 = 1;

input string MT5_Symbol_13 = "";
input string EXC_Symbol_13 = "";
input double LM_Symbol_13 = 1;

input string MT5_Symbol_14 = "";
input string EXC_Symbol_14 = "";
input double LM_Symbol_14 = 1;

input string MT5_Symbol_15 = "";
input string EXC_Symbol_15 = "";
input double LM_Symbol_15 = 1;

input string MT5_Symbol_16 = "";
input string EXC_Symbol_16 = "";
input double LM_Symbol_16 = 1;

input string MT5_Symbol_17 = "";
input string EXC_Symbol_17 = "";
input double LM_Symbol_17 = 1;

input string MT5_Symbol_18 = "";
input string EXC_Symbol_18 = "";
input double LM_Symbol_18 = 1;

input string MT5_Symbol_19 = "";
input string EXC_Symbol_19 = "";
input double LM_Symbol_19 = 1;

input string MT5_Symbol_20 = "";
input string EXC_Symbol_20 = "";
input double LM_Symbol_20 = 1;

input string MT5_Symbol_21 = "BTCUSD.b2b";
input string EXC_Symbol_21 = "BTCUSDT";
input double LM_Symbol_21 = 1;

input string MT5_Symbol_22 = "";
input string EXC_Symbol_22 = "";
input double LM_Symbol_22 = 1;

input string MT5_Symbol_23 = "";
input string EXC_Symbol_23 = "";
input double LM_Symbol_23 = 1;

input string MT5_Symbol_24 = "";
input string EXC_Symbol_24 = "";
input double LM_Symbol_24 = 1;

input string MT5_Symbol_25 = "";
input string EXC_Symbol_25 = "";
input double LM_Symbol_25 = 1;

input string MT5_Symbol_26 = "";
input string EXC_Symbol_26 = "";
input double LM_Symbol_26 = 1;

input string MT5_Symbol_27 = "";
input string EXC_Symbol_27 = "";
input double LM_Symbol_27 = 1;

input string MT5_Symbol_28 = "";
input string EXC_Symbol_28 = "";
input double LM_Symbol_28 = 1;

input string MT5_Symbol_29 = "";
input string EXC_Symbol_29 = "";
input double LM_Symbol_29 = 1;

input string MT5_Symbol_30 = "";
input string EXC_Symbol_30 = "";
input double LM_Symbol_30 = 1;

double SymbolMapping_Global_LM = 0;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string SymbolMapping(string mt5_symbol)
  {

   if(AutoSymbolMapping)
     {

      SymbolMapping_Global_LM = LotMultiplier;
      /*
         BTCUSDT.binance
         BTCUSD.b2b
      */
      string sep="";              // A separator as a character
      sep = SymbolMapping_Separator;
      ushort u_sep;                  // The code of the separator character
      string result[];               // An array to get strings
      u_sep=StringGetCharacter(sep,0);
      int k=StringSplit(mt5_symbol,u_sep,result);
      string value = result[0];
      value += SymbolMapping_Add;
      return(value);
     }

   if(mt5_symbol == MT5_Symbol_1)
     {
      SymbolMapping_Global_LM = LM_Symbol_1;
      return(EXC_Symbol_1);
     }
   if(mt5_symbol == MT5_Symbol_2)
     {
      SymbolMapping_Global_LM = LM_Symbol_2;
      return(EXC_Symbol_2);
     }
   if(mt5_symbol == MT5_Symbol_3)
     {
      SymbolMapping_Global_LM = LM_Symbol_3;
      return(EXC_Symbol_3);
     }
   if(mt5_symbol == MT5_Symbol_4)
     {
      SymbolMapping_Global_LM = LM_Symbol_4;
      return(EXC_Symbol_4);
     }
   if(mt5_symbol == MT5_Symbol_5)
     {
      SymbolMapping_Global_LM = LM_Symbol_5;
      return(EXC_Symbol_5);
     }
   if(mt5_symbol == MT5_Symbol_6)
     {
      SymbolMapping_Global_LM = LM_Symbol_6;
      return(EXC_Symbol_6);
     }
   if(mt5_symbol == MT5_Symbol_7)
     {
      SymbolMapping_Global_LM = LM_Symbol_7;
      return(EXC_Symbol_7);
     }
   if(mt5_symbol == MT5_Symbol_8)
     {
      SymbolMapping_Global_LM = LM_Symbol_8;
      return(EXC_Symbol_8);
     }
   if(mt5_symbol == MT5_Symbol_9)
     {
      SymbolMapping_Global_LM = LM_Symbol_9;
      return(EXC_Symbol_9);
     }
   if(mt5_symbol == MT5_Symbol_10)
     {
      SymbolMapping_Global_LM = LM_Symbol_10;
      return(EXC_Symbol_10);
     }
//----

   if(mt5_symbol == MT5_Symbol_11)
     {
      SymbolMapping_Global_LM = LM_Symbol_11;
      return(EXC_Symbol_11);
     }
   if(mt5_symbol == MT5_Symbol_12)
     {
      SymbolMapping_Global_LM = LM_Symbol_12;
      return(EXC_Symbol_12);
     }
   if(mt5_symbol == MT5_Symbol_13)
     {
      SymbolMapping_Global_LM = LM_Symbol_13;
      return(EXC_Symbol_13);
     }
   if(mt5_symbol == MT5_Symbol_14)
     {
      SymbolMapping_Global_LM = LM_Symbol_14;
      return(EXC_Symbol_14);
     }
   if(mt5_symbol == MT5_Symbol_15)
     {
      SymbolMapping_Global_LM = LM_Symbol_15;
      return(EXC_Symbol_15);
     }
   if(mt5_symbol == MT5_Symbol_16)
     {
      SymbolMapping_Global_LM = LM_Symbol_16;
      return(EXC_Symbol_16);
     }
   if(mt5_symbol == MT5_Symbol_17)
     {
      SymbolMapping_Global_LM = LM_Symbol_17;
      return(EXC_Symbol_17);
     }
   if(mt5_symbol == MT5_Symbol_18)
     {
      SymbolMapping_Global_LM = LM_Symbol_18;
      return(EXC_Symbol_18);
     }
   if(mt5_symbol == MT5_Symbol_19)
     {
      SymbolMapping_Global_LM = LM_Symbol_19;
      return(EXC_Symbol_19);
     }
   if(mt5_symbol == MT5_Symbol_20)
     {
      SymbolMapping_Global_LM = LM_Symbol_20;
      return(EXC_Symbol_20);
     }
//----

   if(mt5_symbol == MT5_Symbol_21)
     {
      SymbolMapping_Global_LM = LM_Symbol_21;
      return(EXC_Symbol_21);
     }
   if(mt5_symbol == MT5_Symbol_22)
     {
      SymbolMapping_Global_LM = LM_Symbol_22;
      return(EXC_Symbol_22);
     }
   if(mt5_symbol == MT5_Symbol_23)
     {
      SymbolMapping_Global_LM = LM_Symbol_23;
      return(EXC_Symbol_23);
     }
   if(mt5_symbol == MT5_Symbol_24)
     {
      SymbolMapping_Global_LM = LM_Symbol_24;
      return(EXC_Symbol_24);
     }
   if(mt5_symbol == MT5_Symbol_25)
     {
      SymbolMapping_Global_LM = LM_Symbol_25;
      return(EXC_Symbol_25);
     }
   if(mt5_symbol == MT5_Symbol_26)
     {
      SymbolMapping_Global_LM = LM_Symbol_26;
      return(EXC_Symbol_26);
     }
   if(mt5_symbol == MT5_Symbol_27)
     {
      SymbolMapping_Global_LM = LM_Symbol_27;
      return(EXC_Symbol_27);
     }
   if(mt5_symbol == MT5_Symbol_28)
     {
      SymbolMapping_Global_LM = LM_Symbol_28;
      return(EXC_Symbol_28);
     }
   if(mt5_symbol == MT5_Symbol_29)
     {
      SymbolMapping_Global_LM = LM_Symbol_29;
      return(EXC_Symbol_29);
     }
   if(mt5_symbol == MT5_Symbol_30)
     {
      SymbolMapping_Global_LM = LM_Symbol_30;
      return(EXC_Symbol_30);
     }

   return(mt5_symbol);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int SymbolVolumePrecision(double value)
  {

   /*

   */
   if(value == 0.00000001)
     {
      return(8);
     }
   if(value == 0.0000001)
     {
      return(7);
     }
   if(value == 0.000001)
     {
      return(6);
     }
   if(value == 0.00001)
     {
      return(5);
     }
   if(value == 0.0001)
     {
      return(4);
     }
   if(value == 0.001)
     {
      return(3);
     }
   if(value == 0.01)
     {
      return(2);
     }
   if(value == 0.1)
     {
      return(1);
     }
   if(value >= 1)
     {
      return(0);
     }
   return(0);
  }

//+------------------------------------------------------------------+
string convert_int_to_OrderType(int inputValue)
  {
   if(0 == inputValue)
     {
      return ("BUY");
     }
   if(1 == inputValue)
     {
      return ("SELL");
     }
   if(2 == inputValue)
     {
      return ("BUYLIMIT");
     }
   if(3 == inputValue)
     {
      return ("SELLLIMIT");
     }
   if(4 == inputValue)
     {
      return ("BUYSTOP");
     }
   if(5 == inputValue)
     {
      return ("SELLSTOP");
     }

   return ("UNKNOWN ORDER TYPE: " + IntegerToString(inputValue));
  }


//+------------------------------------------------------------------+

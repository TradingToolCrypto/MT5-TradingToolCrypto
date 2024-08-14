//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, TradingToolCrypto Corp."
#property link      "https://github.com/TradingToolCrypto/TradingTool-Wiki/wiki"
#include <TradingToolCrypto\MQL\Jason.mqh>
#include <TradingToolCrypto\CBP\ExchangeCandles.mqh>
#include <TradingToolCrypto\CBP\ExchangeUrls.mqh>
#include <TradingToolCrypto\TT\SymbolStrings.mqh>

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CJAVal jasonClass(NULL, jtUNDEF);
//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
// #define MacrosYear    2010
#define EXCHANGE_AEVO ".avo"
#define EXCHANGE_ASCENDEX ".asc"
#define EXCHANGE_BINANCE_DEX ".bnx"
#define EXCHANGE_BINANCE ".bnc"
#define EXCHANGE_BINANCE_FUTURES ".bnf"
#define EXCHANGE_BINANCE_FUTURES_COIN ".bnd"
#define EXCHANGE_BINANCE_US ".bnu"
#define EXCHANGE_BITMEX ".mex"
#define EXCHANGE_BITHUMB ".hum"
#define EXCHANGE_BITFINEX ".btf"
#define EXCHANGE_BITSTAMP ".bsp"
#define EXCHANGE_BLOFIN ".fin"
#define EXCHANGE_BTSE ".bts"
#define EXCHANGE_BYBIT_INVERSE ".byi"
#define EXCHANGE_BYBIT_LINEAR ".byl"
#define EXCHANGE_BYBIT ".byb"
#define EXCHANGE_BYBIT_OPTIONS ".byo"
#define EXCHANGE_COINBASE ".cbs"
#define EXCHANGE_DERIBIT ".der"
#define EXCHANGE_DIGITEX ".dig" //Exchange ID 14 now available ||  Project Rebranded after closing down : https://roguechain.io/ 
#define EXCHANGE_FTX ".ftx"
#define EXCHANGE_GEMINI ".gem"
#define EXCHANGE_HUOBI ".huo"
#define EXCHANGE_KRAKEN ".kra"
#define EXCHANGE_KUCOIN ".kuc"
#define EXCHANGE_KUCOIN_FUTURES ".kuf"
#define EXCHANGE_MEXC ".mxc"
#define EXCHANGE_OKEX ".okx"
#define EXCHANGE_PHEMEX ".phe"
#define EXCHANGE_PHEMEX_FUTURES ".phf"
#define EXCHANGE_SATANG ".sat"
#define EXCHANGE_ZBG ".zbg"
// More
#define EXCHANGE_CHART_DIGIT 8

enum ENUM_AVAILABLE_EXCHANGE
  {
   AEVO = 32,
   ASCENDEX = 28,
   BINANCE = 1,
   BINANCE_US = 6,
   BINANCE_FUTURES_USDT = 5,
   BINANCE_FUTURES_USDT_TEST = 26,
   BINANCE_FUTURES_COIN = 21,
   BINANCE_FUTURES_COIN_TEST = 27,
   BITHUMB = 29,
   BITFINEX = 10,
   BITMEX = 3,
   BITSTAMP =11,
   BLOFIN = 33,
   BTSE = 20,
   BYBIT = 2,
   COINBASE = 9,
   DERIBIT = 7,
   DIGITEX = 14,
   FTX = 12,
   GEMINI = 25,
   HUOBI_FUTURES = 15,
   KRAKEN = 18,
   KUCOIN = 4,
   KUCOIN_FUTURES = 19,
   MEXC = 30,
   PHEMEX = 16,
   PHEMEX_FUTURES = 34,
   SATANG_PRO = 13,
   ZBG = 17,
// OKEX = 8,
  };



string BinanceSymbols[];
string BinanceUSSymbols[];
string BinanceFuturesSymbols[];
string BinanceFuturesCSymbols[];
string BybitSymbols[];
string BitmexSymbols[];
string FTXSymbols[];

int BinanceSymbolsQuoteDigit[];
int BinanceUSSymbolsQuoteDigit[];
int BinanceFuturesSymbolsQuoteDigit[];
int BinanceFuturesCSymbolsQuoteDigit[];
int BybitSymbolsQuoteDigit[];
int BitmexSymbolsQuoteDigit[];
int FTXSymbolsQuoteDigit[];

int BinanceSymbolsVolumeDigit[];
int BinanceUSSymbolsVolumeDigit[];
int BinanceFuturesSymbolsVolumeDigit[];
int BinanceFuturesCSymbolsVolumeDigit[];
int BybitSymbolsVolumeDigit[];
int BitmexSymbolsVolumeDigit[];
int FTXSymbolsVolumeDigit[];

//+------------------------------------------------------------------+
int CreateDigitsFromPrice(string quote)
  {
   return (RemoveZerosFromString(quote));
  }

// returns 0 or up to 8 digits defined by the MT5 digit limitation
int RemoveZerosFromString(string value)
  {

   value = RemoveZerosFromStringValue(value);

   int decimal = StringFind(value, ".", 0);
   if(decimal == -1)
     {
      /*
      decimal not found
      whole number
      */
      return (0);
     }
   string decimal_after = StringSubstr(value, decimal + 1, -1);// returns the values after the decimal
   int decimal_length = StringLen(decimal_after);

   if(decimal_length >= EXCHANGE_CHART_DIGIT)
     {
      return(EXCHANGE_CHART_DIGIT);
     }

   return (decimal_length);
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string RemoveZerosFromStringValue(string value)
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



string GLOBAL_exchange = "";
// create a suffix for specific exchange if suffix doesn't exist
string GetExchangeSuffixFromExchangeID(string suffix, int id)
  {
   if(suffix == "")
     {
      if(id == 0)
        {
         GLOBAL_exchange = "BinanceDex";
         return(EXCHANGE_BINANCE_DEX);
        }
      if(id == 1)
        {
         GLOBAL_exchange = "Binance";
         return(EXCHANGE_BINANCE);
        }
      if(id == 2)
        {
         GLOBAL_exchange = "Bybit";
         return(EXCHANGE_BYBIT);
        }

      if(id == 3)
        {
         GLOBAL_exchange = "Bitmex";
         return(EXCHANGE_BITMEX);
        }

      if(id == 4)
        {
         GLOBAL_exchange = "Kucoin";
         return(EXCHANGE_KUCOIN);
        }
      if(id == 5)
        {
         GLOBAL_exchange = "BinanceFutures";
         return(EXCHANGE_BINANCE_FUTURES);
        }
      if(id == 6)
        {
         GLOBAL_exchange = "BinanceUS";
         return(EXCHANGE_BINANCE_US);
        }
      if(id == 7)
        {
         GLOBAL_exchange = "Deribit";
         return(EXCHANGE_DERIBIT);
        }
      if(id == 8)
        {
         GLOBAL_exchange = "Okex";
         return(EXCHANGE_OKEX);
        }
      if(id == 9)
        {
         GLOBAL_exchange = "Coinbase";
         return(EXCHANGE_COINBASE);
        }
      if(id == 10)
        {
         GLOBAL_exchange = "Bitfinex";
         return(EXCHANGE_BITFINEX);
        }
      if(id == 11)
        {
         GLOBAL_exchange = "Bitstamp";
         return(EXCHANGE_BITSTAMP);
        }
      if(id == 12)
        {
         GLOBAL_exchange = "FTX";
         return(EXCHANGE_FTX);
        }
      if(id == 13)
        {
         GLOBAL_exchange = "Satang";
         return(EXCHANGE_SATANG);
        }
      if(id == 14)
        {
         GLOBAL_exchange = "Digitex";
         return(EXCHANGE_DIGITEX);
        }
      if(id == 15)
        {
         GLOBAL_exchange = "Huobi";
         return(EXCHANGE_HUOBI);
        }
      if(id == 16)
        {
         GLOBAL_exchange = "Phemex";
         return(EXCHANGE_PHEMEX);
        }
      if(id == 17)
        {
         GLOBAL_exchange = "ZBG";
         return(EXCHANGE_ZBG);
        }
      if(id == 18)
        {
         GLOBAL_exchange = "Kraken";
         return(EXCHANGE_KRAKEN);
        }
      if(id == 19)
        {
         GLOBAL_exchange = "KucoinFutures";
         return(EXCHANGE_KUCOIN_FUTURES);
        }

      if(id == 20)
        {
         GLOBAL_exchange = "BTSE";
         return(EXCHANGE_BTSE);
        }

      if(id == 21)
        {
         GLOBAL_exchange = "BinanceFuturesCoin";
         return(EXCHANGE_BINANCE_FUTURES_COIN);
        }


      if(id == 25)
        {
         GLOBAL_exchange = "Gemini";
         return(EXCHANGE_GEMINI);
        }
      // TEST NETS
      if(id == 26)
        {
         GLOBAL_exchange = "BinanceFutures";
         return(".bnft");
        }
      if(id == 27)
        {
         GLOBAL_exchange = "BinanceFuturesC";
         return(".bndt");
        }
      if(id == 28)
        {
         GLOBAL_exchange = "Ascendex";
         return(EXCHANGE_ASCENDEX);
        }
      if(id == 29)
        {
         GLOBAL_exchange = "Bithumb";// Bithumb.global : scam exchange
         return(EXCHANGE_BITHUMB);
        }
      if(id == 30)
        {
         GLOBAL_exchange = "Mexc";
         return(EXCHANGE_MEXC);
        }
      //bybit spot
      if(id == 31)
        {
         GLOBAL_exchange = "Bybit";
         return(EXCHANGE_BYBIT);
        }
      if(id == 32)
        {
         GLOBAL_exchange = "Aevo";
         return(EXCHANGE_AEVO);
        }
      if(id == 33)
        {
         GLOBAL_exchange = "Blofin";
         return(EXCHANGE_BLOFIN);
        }
      if(id == 34)
        {
         GLOBAL_exchange = "PhemexFutures";
         return(EXCHANGE_PHEMEX_FUTURES);
        }
     }
   return(suffix);
  }

/*
 suffix is unqiue for each exchange api
 - input the suffix and get the exchange_number for the cryptobridgeproClass

 spot market suffix : byb
linear markets suffix : byl
inverse markets suffix : byi
*/
int GetExchangeIDFromChartSuffix(string id)
  {
   if(id == EXCHANGE_BINANCE_DEX)
     {
      return(0);
     }
   if(id == EXCHANGE_BINANCE)
     {
      return(1);
     }
   if(id == EXCHANGE_BYBIT_INVERSE)// Inverse
     {
      return(2);
     }
   if(id == EXCHANGE_BYBIT_LINEAR)// linear bybit usdt
     {
      return(2);
     }
   if(id == EXCHANGE_BYBIT)// bybit spot
     {
      return(2);
     }
   if(id == EXCHANGE_BYBIT_OPTIONS) // bybit options
     {
      return(2);
     }
   if(id == EXCHANGE_BITMEX)
     {
      return(3);
     }
   if(id == EXCHANGE_KUCOIN)
     {
      return(4);
     }
   if(id == EXCHANGE_BINANCE_FUTURES)
     {
      return(5);
     }
   if(id == EXCHANGE_BINANCE_US)
     {
      return(6);
     }
   if(id == EXCHANGE_DERIBIT)
     {
      return(7);
     }
   if(id == EXCHANGE_OKEX)
     {
      return(8);
     }
   if(id == EXCHANGE_COINBASE)
     {
      return(9);
     }
   if(id == EXCHANGE_BITFINEX)
     {
      return(10);
     }
   if(id == EXCHANGE_BITSTAMP)
     {
      return(11);
     }
   if(id == EXCHANGE_FTX)
     {
      return(12);
     }
   if(id == EXCHANGE_SATANG)
     {
      return(13);
     }
   if(id == EXCHANGE_DIGITEX)
     {
      return(14);
     }
   if(id == EXCHANGE_HUOBI)
     {
      return(15);
     }
   if(id == EXCHANGE_PHEMEX)
     {
      return(16);
     }
   if(id == EXCHANGE_ZBG)
     {
      return(17);
     }
   if(id == EXCHANGE_KRAKEN)
     {
      return(18);
     }
   if(id == EXCHANGE_KUCOIN_FUTURES)
     {
      return(19);
     }
   if(id == EXCHANGE_BTSE)
     {
      return(20);
     }
   if(id == EXCHANGE_BINANCE_FUTURES_COIN)//binance futures coin
     {
      return(21);
     }

   if(id == EXCHANGE_GEMINI)
     {
      return(25);
     }
// TESTNETS
   if(id == ".bnft") // binance futures usdt testnet
     {
      return(26);
     }
   if(id == ".bndt") // binance futures coin testnet
     {
      return(27);
     }
   if(id == EXCHANGE_ASCENDEX)
     {
      return(28);
     }
   if(id == EXCHANGE_BITHUMB)
     {
      return(29);
     }
   if(id == EXCHANGE_MEXC)
     {
      return(30);
     }

   if(id == EXCHANGE_AEVO)
     {
      return(32);
     }
   if(id == EXCHANGE_BLOFIN)
     {
      return(33);
     }
   if(id == EXCHANGE_PHEMEX_FUTURES)
     {
      return(34);
     }
   return(-1);
  }
/*
         BTCUSDT.binance

         returns .binance
*/
string GetExchangeSuffixFromChartSymbol(string symbol)
  {
   string sep=".";              // A separator as a character
   ushort u_sep;                  // The code of the separator character
   string result[];               // An array to get strings
   u_sep=StringGetCharacter(sep,0);
   int k=StringSplit(symbol,u_sep,result);
   string value ="";
   if(k>=2)
     {
      value = sep + result[1];
      return(value);
     }
   return(value);
  }
/*
         BTCUSDT.binance

         returns BTCUSDT
*/
string RemoveSuffixFromChartSymbol(string symbol)
  {
   string sep=".";              // A separator as a character
   ushort u_sep;                  // The code of the separator character
   string result[];               // An array to get strings
   u_sep=StringGetCharacter(sep,0);
   int k=StringSplit(symbol,u_sep,result);
   string value ="";
   if(k>=2)
     {
      value = result[0];
      return(value);
     }
   return(value);
  }
/*

- binance futures coin perps/futures
   - account balance is in coins
   - 1 contract == 10 usd
   - every market is based in USD (Feb 2021)

   - wallets are in coins
      - take the market name and return the coin name
         - parse out USD

*/
string GetQuoteAsset(string symbol)
  {
   int index = StringFind(symbol,"USD",0);
   string quote = StringSubstr(symbol,0,index);
   return(quote);
  }
/*

    GetQuoteAsset("BTCUSDT", "USDT")

    returns BTC

*/
string GetQuoteAsset(string symbol, string base)
  {
   int index = StringFind(symbol,base,0);
   string quote = StringSubstr(symbol,0,index);
   return(quote);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double CreateTickSizeFromSymbolDigits(int sym_digits)
  {

   if(sym_digits == 0)
     {
      return (1.0);
     }
   if(sym_digits == 1)
     {
      return (0.1);
     }
   if(sym_digits == 2)
     {
      return (0.01);
     }
   if(sym_digits == 3)
     {
      return (0.001);
     }
   if(sym_digits == 4)
     {
      return (0.0001);
     }
   if(sym_digits == 5)
     {
      return (0.00001);
     }
   if(sym_digits == 6)
     {
      return (0.000001);
     }
   if(sym_digits == 7)
     {
      return (0.0000001);
     }
   if(sym_digits == 8)
     {
      return (0.00000001);
     }
// can MT5 chart assets beyond 8 decimals?

   if(sym_digits == 9)
     {
      return (0.000000001);
     }
   if(sym_digits == 10)
     {
      return (0.0000000001);
     }
   if(sym_digits == 11)
     {
      return (0.00000000001);
     }
   if(sym_digits == 12)
     {
      return (0.000000000001);
     }
   if(sym_digits == 13)
     {
      return (0.0000000000001);
     }
   if(sym_digits == 14)
     {
      return (0.00000000000001);
     }
   if(sym_digits == 15)
     {
      return (0.000000000000001);
     }
   if(sym_digits == 16)
     {
      return (0.0000000000000001);
     }
   if(sym_digits == 17)
     {
      return (0.00000000000000001);
     }
   if(sym_digits == 18)
     {
      return (0.000000000000000001);
     }

   return (1);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CreateDigitsFromTickSize(string value)
  {
   double in = StringToDouble(value);
   if(in == 0.1)
     {
      return(1);
     }
   if(in == 0.01)
     {
      return(2);
     }
   if(in == 0.001)
     {
      return(3);
     }
   if(in == 0.0001)
     {
      return(4);
     }
   if(in == 0.00001)
     {
      return(5);
     }
   if(in == 0.000001)
     {
      return(6);
     }
   if(in == 0.0000001)
     {
      return(7);
     }
   if(in == 0.00000001)
     {
      return(8);
     }
// can MT5 chart assets beyond 8 decimals?

   if(in == 0.000000001)
     {
      return(9);
     }
   if(in == 0.0000000001)
     {
      return(10);
     }
   if(in == 0.00000000001)
     {
      return(11);
     }
   if(in == 0.000000000001)
     {
      return(12);
     }
   if(in == 0.0000000000001)
     {
      return(13);
     }
   if(in == 0.00000000000001)
     {
      return(14);
     }
   if(in == 0.000000000000001)
     {
      return(15);
     }
   if(in == 0.0000000000000001)
     {
      return(16);
     }
   if(in == 0.00000000000000001)
     {
      return(17);
     }
   if(in == 0.000000000000000001)
     {
      return(18);
     }
   if(in == 1)
     {
      return(0);
     }
   return(0);
  }
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void create_custom_symbol(string customSymbolName, int symbolDigits, string folderName, bool openChart)
  {

   if(!SymbolSelect(customSymbolName, true))
     {
      // Symbol Name,  Sub Group, and what Symbol_Properties to copy ( symbol properties? )
      if(!CustomSymbolCreate(customSymbolName, folderName, NULL))
        {
         Print("CustomSymbolCreate failed: " + IntegerToString(GetLastError()));
         ResetLastError();
         return;
        }
      //QUOTE
      if(!CustomSymbolSetSessionQuote(customSymbolName,SUNDAY,0, StringToTime("2021.2.7 00:00"),StringToTime("2021.2.7 23:59")))
        {
         Print("CustomSymbolSetSessionQuote | --- | Failed" + IntegerToString(GetLastError()));
         ResetLastError();
        }
      if(!CustomSymbolSetSessionQuote(customSymbolName,MONDAY,0, StringToTime("2021.2.8 00:00"),StringToTime("2021.2.8 23:59")))
        {
         Print("CustomSymbolSetSessionQuote | --- | Failed" + IntegerToString(GetLastError()));
         ResetLastError();
        }
      if(!CustomSymbolSetSessionQuote(customSymbolName,TUESDAY,0, StringToTime("2021.2.9 00:00"),StringToTime("2021.2.9 23:59")))
        {
         Print("CustomSymbolSetSessionQuote | --- | Failed" + IntegerToString(GetLastError()));
         ResetLastError();
        }
      if(!CustomSymbolSetSessionQuote(customSymbolName,WEDNESDAY,0, StringToTime("2021.2.10 00:00"),StringToTime("2021.2.10 23:59")))
        {
         Print("CustomSymbolSetSessionQuote | --- | Failed" + IntegerToString(GetLastError()));
         ResetLastError();
        }
      if(!CustomSymbolSetSessionQuote(customSymbolName,THURSDAY,0, StringToTime("2021.2.11 00:00"),StringToTime("2021.2.11 23:59")))
        {
         Print("CustomSymbolSetSessionQuote | --- | Failed" + IntegerToString(GetLastError()));
         ResetLastError();
        }
      if(!CustomSymbolSetSessionQuote(customSymbolName,FRIDAY,0, StringToTime("2021.2.12 00:00"),StringToTime("2021.2.12 23:59")))
        {
         Print("CustomSymbolSetSessionQuote | --- | Failed" + IntegerToString(GetLastError()));
         ResetLastError();
        }
      if(!CustomSymbolSetSessionQuote(customSymbolName,SATURDAY,0, StringToTime("2021.2.13 00:00"),StringToTime("2021.2.13 23:59")))
        {
         Print("CustomSymbolSetSessionQuote | --- | Failed" + IntegerToString(GetLastError()));
         ResetLastError();
        }
      //TRADE
      if(!CustomSymbolSetSessionTrade(customSymbolName,SUNDAY,0, StringToTime("2021.2.7 00:00"),StringToTime("2021.2.7 23:59")))
        {
         Print("CustomSymbolSetSessionTrade | --- | Failed" + IntegerToString(GetLastError()));
         ResetLastError();
        }
      if(!CustomSymbolSetSessionTrade(customSymbolName,MONDAY,0, StringToTime("2021.2.8 00:00"),StringToTime("2021.2.8 23:59")))
        {
         Print("CustomSymbolSetSessionTrade | --- | Failed" + IntegerToString(GetLastError()));
         ResetLastError();
        }
      if(!CustomSymbolSetSessionTrade(customSymbolName,TUESDAY,0, StringToTime("2021.2.9 00:00"),StringToTime("2021.2.9 23:59")))
        {
         Print("CustomSymbolSetSessionTrade | --- | Failed" + IntegerToString(GetLastError()));
         ResetLastError();
        }
      if(!CustomSymbolSetSessionTrade(customSymbolName,WEDNESDAY,0, StringToTime("2021.2.10 00:00"),StringToTime("2021.2.10 23:59")))
        {
         Print("CustomSymbolSetSessionTrade | --- | Failed" + IntegerToString(GetLastError()));
         ResetLastError();
        }
      if(!CustomSymbolSetSessionTrade(customSymbolName,THURSDAY,0, StringToTime("2021.2.11 00:00"),StringToTime("2021.2.11 23:59")))
        {
         Print("CustomSymbolSetSessionTrade | --- | Failed" + IntegerToString(GetLastError()));
         ResetLastError();
        }
      if(!CustomSymbolSetSessionTrade(customSymbolName,FRIDAY,0, StringToTime("2021.2.12 00:00"),StringToTime("2021.2.12 23:59")))
        {
         Print("CustomSymbolSetSessionTrade | --- | Failed" + IntegerToString(GetLastError()));
         ResetLastError();
        }
      if(!CustomSymbolSetSessionTrade(customSymbolName,SATURDAY,0, StringToTime("2021.2.13 00:00"),StringToTime("2021.2.13 23:59")))
        {
         Print("CustomSymbolSetSessionTrade | --- | Failed" + IntegerToString(GetLastError()));
         ResetLastError();
        }
      //SYMBOL_TICKS_BOOKDEPTH
      if(!CustomSymbolSetInteger(customSymbolName, SYMBOL_TICKS_BOOKDEPTH, 20))
        {
         Print("CustomSymbolSetInteger | SYMBOL_DIGITS | Failed" + IntegerToString(GetLastError()));
         ResetLastError();
        }
      //SYMBOL_DIGITS
      if(symbolDigits > 8)
        {
         symbolDigits = 8;
        }
      if(!CustomSymbolSetInteger(customSymbolName, SYMBOL_DIGITS, symbolDigits))
        {
         Print("CustomSymbolSetInteger | SYMBOL_DIGITS | Failed" + IntegerToString(GetLastError()));
         ResetLastError();
        }
      //SYMBOL_CHART_MODE
      if(!CustomSymbolSetInteger(customSymbolName, SYMBOL_CHART_MODE, SYMBOL_CHART_MODE_BID))
        {
         Print("CustomSymbolSetInteger | SYMBOL_CHART_MODE | Failed" + IntegerToString(GetLastError()));
         ResetLastError();
        }
      /*
        //SYMBOL_VISIBLE
         if(!CustomSymbolSetInteger(customSymbolName,SYMBOL_VISIBLE,true))
        {
         Print("CustomSymbolSetInteger | SYMBOL_VISIBLE | Failed" + IntegerToString( GetLastError() ) );
         ResetLastError();
         return;
        }
      */
      //SYMBOL_SPREAD_FLOAT
      if(!CustomSymbolSetInteger(customSymbolName, SYMBOL_SPREAD_FLOAT, true))
        {
         Print("CustomSymbolSetInteger | SYMBOL_SPREAD_FLOAT | Failed" + IntegerToString(GetLastError()));
         ResetLastError();
        }
      //SYMBOL_TRADE_STOPS_LEVEL
      if(!CustomSymbolSetInteger(customSymbolName, SYMBOL_TRADE_STOPS_LEVEL, 0))
        {
         Print("CustomSymbolSetInteger | SYMBOL_TRADE_STOPS_LEVEL | Failed" + IntegerToString(GetLastError()));
         ResetLastError();
        }
      //SYMBOL_TRADE_FREEZE_LEVEL
      if(!CustomSymbolSetInteger(customSymbolName, SYMBOL_TRADE_FREEZE_LEVEL, 0))
        {
         Print("CustomSymbolSetInteger | SYMBOL_TRADE_FREEZE_LEVEL | Failed" + IntegerToString(GetLastError()));
         ResetLastError();
        }
      //SYMBOL_POINT
      if(!CustomSymbolSetDouble(customSymbolName, SYMBOL_POINT, CreateTickSizeFromSymbolDigits(symbolDigits)))
        {
         Print("CustomSymbolSetDouble | SYMBOL_POINT | Failed" + IntegerToString(GetLastError()));
         ResetLastError();
        }
      if(!CustomSymbolSetInteger(customSymbolName, SYMBOL_TRADE_CALC_MODE, SYMBOL_CALC_MODE_CFDLEVERAGE))
        {
         Print("CustomSymbolSetInteger | SYMBOL_TRADE_CALC_MODE | Failed" + IntegerToString(GetLastError()));
         ResetLastError();
        }
      //SYMBOL_TRADE_CONTRACT_SIZE
      if(!CustomSymbolSetDouble(customSymbolName, SYMBOL_TRADE_CONTRACT_SIZE, 1))
        {
         Print("CustomSymbolSetDouble | SYMBOL_TRADE_CONTRACT_SIZE | Failed" + IntegerToString(GetLastError()));
         ResetLastError();
        }
      //SYMBOL_TRADE_TICK_SIZE
      if(!CustomSymbolSetDouble(customSymbolName, SYMBOL_TRADE_TICK_SIZE, CreateTickSizeFromSymbolDigits(symbolDigits)))
        {
         Print("CustomSymbolSetDouble | SYMBOL_TRADE_TICK_SIZE | Failed" + IntegerToString(GetLastError()));
         ResetLastError();
        }
      //SYMBOL_TRADE_TICK_VALUE
      if(!CustomSymbolSetDouble(customSymbolName, SYMBOL_TRADE_TICK_VALUE, 1))
        {
         Print("CustomSymbolSetDouble | SYMBOL_TRADE_TICK_VALUE | Failed" + IntegerToString(GetLastError()));
         ResetLastError();
        }
      //SYMBOL_VOLUME_MIN
      if(!CustomSymbolSetDouble(customSymbolName, SYMBOL_VOLUME_MIN,  0.00000001))
        {
         Print("CustomSymbolSetDouble | SYMBOL_VOLUME_MIN | Failed" + IntegerToString(GetLastError()));
         ResetLastError();
        }
      //SYMBOL_VOLUME_MAX
      if(!CustomSymbolSetDouble(customSymbolName, SYMBOL_VOLUME_MAX, 99999999))
        {
         Print("CustomSymbolSetInteger | SYMBOL_VOLUME_MAX | Failed" + IntegerToString(GetLastError()));
         ResetLastError();
        }
      //SYMBOL_VOLUME_LIMIT
      if(!CustomSymbolSetDouble(customSymbolName, SYMBOL_VOLUME_LIMIT, 999999999))
        {
         Print("CustomSymbolSetDouble | SYMBOL_VOLUME_LIMIT | Failed" + IntegerToString(GetLastError()));
         ResetLastError();
        }
      //SYMBOL_SECTOR

      if(!CustomSymbolSetInteger(customSymbolName, SYMBOL_SECTOR, SECTOR_CURRENCY_CRYPTO))
        {
         Print("CustomSymbolSetInteger | SYMBOL_DIGITS | Failed" + IntegerToString(GetLastError()));
         ResetLastError();
        }
      //SYMBOL_INDUSTRY
      if(!CustomSymbolSetInteger(customSymbolName, SYMBOL_INDUSTRY, INDUSTRY_INTERNET_CONTENT))
        {
         Print("CustomSymbolSetInteger | SYMBOL_DIGITS | Failed" + IntegerToString(GetLastError()));
         ResetLastError();
        }


      if(!SymbolSelect(customSymbolName, true))
        {
         Print("Creating the CustomChart Failed for some reason: " + IntegerToString(GetLastError()));
         Alert("Creating the CustomChart Failed for some reason: " + IntegerToString(GetLastError()));
         ResetLastError();
        }
      else
        {
         if(openChart)
           {
            ChartOpen(customSymbolName, PERIOD_M1);
           }
        }
     }
   else
     {
      if(openChart)
        {
         ChartOpen(customSymbolName, PERIOD_M1);
        }
     }
  }

//+------------------------------------------------------------------+

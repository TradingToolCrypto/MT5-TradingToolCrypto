//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
// #define MacrosYear    2010
#define EXCHANGE_BINANCE_DEX ".bnx"
#define EXCHANGE_BINANCE ".bnc"
#define EXCHANGE_BYBIT ".byb"
#define EXCHANGE_BITMEX ".mex"
#define EXCHANGE_KUCOIN ".kuc"
#define EXCHANGE_BINANCE_FUTURES ".bnf"
#define EXCHANGE_BINANCE_FUTURES_COIN ".bnd"
#define EXCHANGE_BINANCE_US ".bnu"
#define EXCHANGE_DERIBIT ".der"
#define EXCHANGE_OKEX ".okx"
#define EXCHANGE_COINBASE ".cbs"
#define EXCHANGE_BITFINEX ".btf"
#define EXCHANGE_BITSTAMP ".bsp"
#define EXCHANGE_FTX ".ftx"
#define EXCHANGE_SATANG ".sat"
#define EXCHANGE_DIGITEX ".dig"
#define EXCHANGE_HUOBI ".huo"
#define EXCHANGE_PHEMEX ".pme"
#define EXCHANGE_ZBG ".zbg"
#define EXCHANGE_KRAKEN ".kra"
#define EXCHANGE_KUCOIN_FUTURES ".kuf"
#define EXCHANGE_BTSE ".bts"

string GLOBAL_exchange = "";
string get_suffix_exchange_name(string suffix, int id)
  {
   if(suffix == "")
     {
      if(id == 0)
        {
         return(".bnx");
        }
      if(id == 1)
        {
         GLOBAL_exchange = "Binance";
         return(".bnc");
        }
      if(id == 2)
        {
         GLOBAL_exchange = "Bybit";
         return(".byb");
        }
      if(id == 3)
        {
         GLOBAL_exchange = "Binance";
         return(".mex");
        }
      if(id == 4)
        {
         GLOBAL_exchange = "Kucoin";
         return(".kuc");
        }
      if(id == 5)
        {
         GLOBAL_exchange = "BinanceFutures";
         return(".bnf");
        }
      if(id == 6)
        {
         GLOBAL_exchange = "BinanceUS";
         return(".bnu");
        }
      if(id == 7)
        {
         GLOBAL_exchange = "Deribit";
         return(".der");
        }
      if(id == 8)
        {
         GLOBAL_exchange = "Okex";
         return(".okx");
        }
      if(id == 9)
        {
         GLOBAL_exchange = "Coinbase";
         return(".cbs");
        }

      if(id == 10)
        {
         GLOBAL_exchange = "Bitfinex";
         return(".btf");
        }

      if(id == 11)
        {
         GLOBAL_exchange = "Bitstamp";
         return(".bsp");
        }
      if(id == 12)
        {
         GLOBAL_exchange = "FTX";
         return(".ftx");
        }
      if(id == 13)
        {
         GLOBAL_exchange = "Satang";
         return(".sat");
        }
      if(id == 14)
        {
         GLOBAL_exchange = "Digitex";
         return(".dig");
        }
      if(id == 15)
        {
         GLOBAL_exchange = "Huobia";
         return(".huo");
        }
      if(id == 16)
        {
         GLOBAL_exchange = "Phemex";
         return(".phe");
        }
      if(id == 17)
        {
         GLOBAL_exchange = "ZBG";
         return(".zbg");
        }
      if(id == 18)
        {
         GLOBAL_exchange = "Kraken";
         return(".kra");
        }
      if(id == 19)
        {
         GLOBAL_exchange = "KucoinFutures";
         return(".kuf");
        }

      if(id == 20)
        {
         GLOBAL_exchange = "BTSE";
         return(".bts");
        }

      if(id == 21)
        {
         GLOBAL_exchange = "BinanceFuturesC";
         return(".bnd");
        }

      if(id == 22)
        {
         GLOBAL_exchange = "BybitU";
         return(".byt");
        }
      if(id == 23)
        {
         GLOBAL_exchange = "Bybit";
         return(".bybt");
        }
      if(id == 24)
        {
         GLOBAL_exchange = "BybitU";
         return(".bytt");
        }
     }
   return(suffix);
  }

/*
 suffix is unqiue for each exchange api 
 - input the suffix and get the exchange_number for the cryptobridgeproClass
*/
int suffix_exchange_number(string id)
  {
   if(id == ".bnx")
     {
      return(0);
     }
   if(id == ".bnc")
     {
      return(1);
     }
   if(id == ".byb")
     {
      return(2);
     }
   if(id == ".mex")
     {
      return(3);
     }
   if(id == ".kuc")
     {
      return(4);
     }
   if(id == ".bnf")
     {
      return(5);
     }
   if(id == ".bnu")
     {
      return(6);
     }
   if(id == ".der")
     {
      return(7);
     }
   if(id == ".okx")
     {
      return(8);
     }
   if(id == ".cbs")
     {
      return(9);
     }
   if(id == ".btf")
     {
      return(10);
     }
   if(id == ".bsp")
     {
      return(11);
     }
   if(id == ".ftx")
     {
      return(12);
     }
   if(id == ".sat")
     {
      return(13);
     }
   if(id == ".dig")
     {
      return(14);
     }
   if(id == ".huo")
     {
      return(15);
     }
   if(id == ".phe")
     {
      return(16);
     }
   if(id == ".zbg")
     {
      return(17);
     }
   if(id == ".kra")
     {
      return(18);
     }
   if(id == ".kuf")
     {
      return(19);
     }
   if(id == ".bts")
     {
      return(20);
     }
   if(id == ".bnd")//binance futures coin
     {
      return(21);
     }
   if(id == ".byt")// bybit usdt
     {
      return(22);
     }
   if(id == ".bybt")// bybit coin testnet
     {
      return(2);
     }
   if(id == ".bytt") // bybit usdt testnet
     {
      return(22);
     }
   return(-1);
  }
/*
         BTCUSDT.binance
    
         returns .binance
*/
string get_suffix_from_symbol(string symbol){
      string sep=".";              // A separator as a character
      ushort u_sep;                  // The code of the separator character
      string result[];               // An array to get strings
      u_sep=StringGetCharacter(sep,0);
      int k=StringSplit(symbol,u_sep,result);
      string value ="";
      if(k==2){
         value = sep + result[1];
         return(value);
      }
      return(value);
}
/*
         BTCUSDT.binance
        
         returns BTCUSDT
*/
string remove_suffix_from_symbol(string symbol){
      string sep=".";              // A separator as a character
      ushort u_sep;                  // The code of the separator character
      string result[];               // An array to get strings
      u_sep=StringGetCharacter(sep,0);
      int k=StringSplit(symbol,u_sep,result);
      string value ="";
      if(k==2){
         value = result[0];
         return(value);
      }
      return(value);
}

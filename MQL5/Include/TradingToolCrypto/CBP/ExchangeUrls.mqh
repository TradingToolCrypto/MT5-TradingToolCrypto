//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string GetTimeStampUrl(int exchange_list)
  {

   if(exchange_list == 1)
     {
      return ("https://api.binance.com/api/v3/time");
     }
   if((exchange_list == 2) || (exchange_list == 22) || (exchange_list == 23) || (exchange_list == 24) || (exchange_list == 31))
     {
      return ("https://api.bybit.com/v5/market/time");
     }
   if(exchange_list == 3)
     {
      return ("https://www.bitmex.com/api/v1/instrument?reverse=true&count=1");
     }
   if(exchange_list == 4)
     {
      return ("https://api.kucoin.com/api/v1/market/orderbook/level1?symbol=BTC-USDT");
     }
   if(exchange_list == 5)
     {
      return ("https://fapi.binance.com/fapi/v1/time");
     }
   if(exchange_list == 6)
     {
      return ("https://api.binance.us/api/v3/time");
     }
   if(exchange_list == 7)
     {
      return ("https://www.deribit.com/api/v2/public/get_time?");
     }
   if(exchange_list == 8)
     {
      return ("https://api.switcheo.network/v2/exchange/timestamp");
     }
   if(exchange_list == 9)
     {
      return ("https://api.pro.coinbase.com/time");
     }
   if(exchange_list == 10)
     {
      return ("https://api-pub.bitfinex.com/v2/trades/tBTCUSD/hist?limit=1");
     }
   if(exchange_list == 11)  // Bitstamp
     {
      return ("https://www.bitstamp.net/api/v2/ticker/btcusd");
     }
   if(exchange_list == 12)
     {
      return ("https://ftx.com/api/markets/BTC-PERP/trades?limit=1");
     }
   if(exchange_list == 13)
     {
      return ("https://api.tdax.com/api/v3/exchangeInfo");
     }
   if(exchange_list == 14)
     {
      return ("https://rest.mapi.digitexfutures.com/api/v1/public/time");
     }
   if(exchange_list == 15)
     {
      return ("https://api.hbdm.com/api/v1/timestamp");
     }
   if((exchange_list == 16) || (exchange_list == 34))
     {
      return ("https://api.phemex.com/public/time");
     }
   if(exchange_list == 17)
     {
      return ("https://kline.zbg.com/api/data/v1/entrusts?marketName=BTC_USDT&dataSize=1");
     }
   if(exchange_list == 18)
     {
      return ("https://api.kraken.com/0/public/Time");
     }
   if(exchange_list == 19)
     {
      return ("https://api-futures.kucoin.com/api/v1/timestamp");
     }
   if(exchange_list == 20)
     {
      return ("https://api.btse.com/futures/api/v2.1/orderbook/L2?symbol=BTCPFC");
     }
   if(exchange_list == 21)
     {
      return ("https://dapi.binance.com/dapi/v1/time");
     }
   if(exchange_list == 25)
     {
      // gemini
      return ("https://api.gemini.com/v1/pubticker/btcusd");
     }
   if(exchange_list == 26)
     {
      return ("https://testnet.binancefuture.com/fapi/v1/time");
     }
   if(exchange_list == 27)
     {
      return ("https://testnet.binancefuture.com/dapi/v1/time");
     }
   if(exchange_list == 28)
     {
      return ("https://ascendex.com/api/pro/v1/trades?symbol=BTC/USDT");
     }
   if(exchange_list == 29)
     {
      return ("https://global-openapi.bithumb.pro/openapi/v1/serverTime");
     }
   if(exchange_list == 30)
     {
      return ("https://api.mexc.com/api/v3/time");
     }
// BLOFIN
   if(exchange_list == 33)
     {
      return ("https://openapi.blofin.com/api/v1/market/tickers?instId=BTC-USDT");
     }

   return ("https://api.mexc.com/api/v3/time");
  }

//+------------------------------------------------------------------+

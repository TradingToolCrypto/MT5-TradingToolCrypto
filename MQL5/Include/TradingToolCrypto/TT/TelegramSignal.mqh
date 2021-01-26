#include <TradingToolCrypto\MQL\Arrays\ArrayString.mqh>
#include <TradingToolCrypto\MQL\Arrays\ArrayObj.mqh>
//+------------------------------------------------------------------+
//|                                                              
//+------------------------------------------------------------------+
class Signal : public CObject
{
public:
   string            symbol;           //BTCUSD
   datetime          signal_time;      //158585949494
   int               order_type;       // BUY SELL
   double            price_entry;      // 8948
   double            price_sl;         // 5667
   double            price_tp;         // 25000

   string Signal::to_string()
   {
      return StringFormat("Signal Executed\n%s(%s) @ %.5f, SL=%.5f, TP=%.5f - Time %s",
         
         symbol,
         orderTypeToString(order_type),
         price_entry,
         price_sl,
         price_tp,
         TimeToString(signal_time|TIME_DATE)
      );
   }
   
   string orderTypeToString(int x){
      
      if(x==0){
         return("BUY");
      }
      if(x==1){
         return("SELL");
      } 
      return("LIMIT/STOP");
   }
};
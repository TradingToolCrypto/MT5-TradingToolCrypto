//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
enum ENUM_AVAILABLE_TIMEFRAME {
   MIN_1 = 1,
   MIN_3 = 3,
   MIN_5 = 5,
   MIN_30 = 30,
   H_1 = 60,
   H_2 = 120,
   H_4 = 240,
   H_6 = 360,
   H_8 = 480,
   H_12 = 720,
   D_1 = 1440
};


//+------------------------------------------------------------------+
//|                                   GLOBALS                               |
//+------------------------------------------------------------------+
/*
 What are these values doing

 - Store Alerts
*/
long store_alerts_id[];
string store_alerts_sym[];
string store_alerts[];

double store_alerts_up[];
double store_alerts_dn[];

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void MarketWatchResetAlerts()
{

   ArrayFree(store_alerts_id);
   ArrayFree(store_alerts_sym);
   ArrayFree(store_alerts);
   ArrayFree(store_alerts_up);
   ArrayFree(store_alerts_dn);

}


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string MarketWatchListAlerts()
{

   string mess = "";
   int loop = ArraySize(store_alerts);

   for(int x = 0; x< loop ; x++) {

      if(store_alerts_id[x] != 0) {

         mess += store_alerts_sym[x] + " " + store_alerts[x] + " ";

         if(store_alerts_up[x] != 0) {
            mess += (string) store_alerts_up[x];
         } else if(store_alerts_dn[x] != 0) {
            mess += (string) store_alerts_dn[x];
         }

         mess += "\n/delete_" + (string) store_alerts_id[x]+ "\n\n";

      }
   }

   return(mess);
}

//+------------------------------------------------------------------+
//|  Save alert information to the internal array memory
//+------------------------------------------------------------------+
void MarketWatchDelete(long id)
{
   int loop = ArraySize(store_alerts);
   for(int x = 0; x< loop ; x++) {

      if(id == store_alerts_id[x]) {
         Print("MarketWatchDelete");
         Alert("MarketWatchDelete");
         store_alerts[x] = "";
         store_alerts_sym[x] = "";
         store_alerts_up[x]= 0;
         store_alerts_dn[x]= 0;
         store_alerts_id[x] = 0;

      }

   }

}
//+------------------------------------------------------------------+
//|  Save alert information to the internal array memory
//+------------------------------------------------------------------+
void MarketWatchSave(string sym, string alert, double up, double dn)
{
   int size = ArraySize(store_alerts);

   // Reset arrays
   ArrayResize(store_alerts, size+ 1);
   ArrayResize(store_alerts_sym, size+ 1);
   ArrayResize(store_alerts_up, size+ 1);
   ArrayResize(store_alerts_dn, size+ 1);
   ArrayResize(store_alerts_id, size+ 1);

   /*
   Store the values
   */
   if(size==0) {
      store_alerts[0] = alert;
      store_alerts_sym[0] = sym;
      store_alerts_up[0]= up;
      store_alerts_dn[0]= dn;
      store_alerts_id[0] = (long)TimeGMT();
   } else {
      store_alerts[size] = alert;
      store_alerts_sym[size] = sym;
      store_alerts_up[size]= up;
      store_alerts_dn[size]= dn;
      store_alerts_id[size] = (long)TimeGMT();
   }
}
//+------------------------------------------------------------------+
//|                Search for Exact Symbol name                  |
//+------------------------------------------------------------------+
string MarketWatchFind(string sym)
{

   string mess = "";
   string out = "";
   string id = "";
   int loop = ArraySize(store_alerts);
   for(int x = 0; x< loop ; x++) {
      mess = "";// Rest on each loop
      if(sym == store_alerts_sym[x]) {
         /*
         The alert exists, now we need to compare the alert information with the correct price
         */
         double price = SymbolInfoDouble(sym,SYMBOL_BID);

         if(price >=  store_alerts_up[x] &&  store_alerts_up[x] != 0 ) {
            mess+= "\nAlert : " + sym + " : @" + (string) price +

                   "\n/delete_" + (string)store_alerts_id[x] ;
         }

         if(price <=  store_alerts_dn[x] &&  store_alerts_dn[x] != 0 ) {
            mess+= "\nAlert : " + sym + " : @" + (string) price +
                   "\n/delete_" + (string)store_alerts_id[x] ;

         }

         out+=mess;
      }
   }
   return(out);
}


//+------------------------------------------------------------------+
//|                                 Main Function to call            |
//+------------------------------------------------------------------+
string MarketWatchSearch(bool scanOnlyMarketWatch)
{
   string out = "";
   int symbols_list = SymbolsTotal(scanOnlyMarketWatch);
   for(int x=0; x<symbols_list;x++) {
      string symOpenChart = SymbolName(x,scanOnlyMarketWatch);// get the symbol database name based on the index
      if(SymbolSelect(symOpenChart, true)) {
         /*
         Loop through all avaliable markets in the Market Watch
         and scan for the alerts
         */
         out+=  MarketWatchFind(symOpenChart);
      }
   }
   return(out);
}


/*
2024 - August :
redesign for Price_alerts Telegram bot

scan for symbol
scan and remove  "USDxyz.suffix.all"
scan and remove "-,/,_,etc"

RESOLVE:
user enters: btc
mt5 symbol : btc_usdb.fck.suf.fix

*/

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string MapAssetToSymbol(string user_symbol)// out : mt5_symbol
{
   string out ="";
   StringToUpper(user_symbol);

   int length_sym = 0;
   int find_sym = 0;
   int ifFoundHasValue =  -1;
   int symbols_list = SymbolsTotal(true);

   for(int x=0; x<symbols_list;x++) {
      string symOpenChart = SymbolName(x,true);// get the symbol database name based on the index
      if(SymbolSelect(symOpenChart, true)) {
         /*
         Loop through all avaliable markets in the Market Watch
         and scan for the alerts
         */
         length_sym = StringLen(symOpenChart);
         find_sym = StringLen(user_symbol);
         ifFoundHasValue =   StringFind(symOpenChart,user_symbol,0);
         if(ifFoundHasValue==0) {
            out = StringSubstr(symOpenChart,find_sym);
         }
      }
   }

   return(user_symbol+ out);
}
//+------------------------------------------------------------------+

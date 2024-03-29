//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
//#include <TradingToolCrypto\CBP\CryptoBridgeProClass.mqh>
#include <TradingToolCrypto\TT\Indicators_Plus.mqh>

//CryptoBridge bridge;

input string MESSAGE_ALERT_BUY =" Buy Signal Alert on MA Cross ";
input string MESSAGE_ALERT_SELL =" Sell Signal Alert on MA Cross ";


string symName = "";
int OnInit()
  {

   symName = Symbol();
   init_Indicators(symName);
   EventSetTimer(60);

//---
   return(INIT_SUCCEEDED);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTimer()
  {
   comparePrices();
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool comparePrices()
  {

   string logic =  get_signal_EMA_CROSS();

   if(logic =="CROSSUP")
     {
      sendAlert(MESSAGE_ALERT_BUY);
     }

   if(logic =="CROSSDOWN")
     {
      sendAlert(MESSAGE_ALERT_SELL);
     }

   return(false);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool sendAlert(string message)
  {
   SendMail("MT5 ", message);
   SendNotification(message);
   Alert(message);
   Print(message);

   return(false);
  }

//+------------------------------------------------------------------+

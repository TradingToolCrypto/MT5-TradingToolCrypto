//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, TradingToolCrypto Corp."
#property link      "https://github.com/tradingtoolcrypto"
#property description "Tools=> Options => ExpertAdvisors => Allow Webrequests \nExample of URL: https://api.binance.com\n\nMake a payment with PaymentBot before using(Pro Package)"
#property description "\n\nFeatures: \nAuto Exchange Setup: Enter Api Keys and begin trading\nTrade Any Market: Attach to a CB_Charts, CB_ChartAll, CB_ChartPro generated chart to begin trading"
#property version "1.01"


#include <TradingToolCrypto\CBP\CBPFrameWork.mqh>
#include <TradingToolCrypto\TT\RobotFrameWork.mqh>
#include <TradingToolCrypto\TT\create_objects.mqh>

CBPFrameWork cb;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   ObjCreateButton("hide_1", false, 187,1, 20, 18, "^", clrLightGray, clrBlack, 0, CORNER_LEFT_UPPER,8,"Arial",0,false,OBJ_ALL_PERIODS);
   ObjCreateButton("balance_1", false, 147,1, 20, 18, "B", clrLightGray, clrBlack, 0, CORNER_LEFT_UPPER,8,"Arial",0,false,OBJ_ALL_PERIODS);
   ObjCreateButton("position_1", false, 167,1, 20, 18, "P", clrLightGray, clrBlack, 0, CORNER_LEFT_UPPER,8,"Arial",0,false,OBJ_ALL_PERIODS);
   ChartRedraw();
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   function_hide_gui();

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {
   ObjectSetString(0,"buy_2",OBJPROP_TEXT, DoubleToString(cb.symbolAsk(), cb.symbolDigit()));
   ObjectSetString(0,"sell_2",OBJPROP_TEXT, DoubleToString(cb.symbolBid(), cb.symbolDigit()));
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void function_make_gui(double bid, double ask, int digit)
  {
   ObjCreateButton("buy_1", false, 157,20, 50, 20, "BUY", EntryColorLong, clrBlack, 0, CORNER_LEFT_UPPER,8,"Arial",0,false,OBJ_ALL_PERIODS);
   ObjCreateButton("buy_2", false, 107,40, 100, 50, DoubleToString(ask,digit), EntryColorLong, clrBlack, 0, CORNER_LEFT_UPPER,12,"Arial",0,false,OBJ_ALL_PERIODS);
   ObjCreateButton("sell_1", false, 5,20, 50, 20, "SELL", EntryColorShort, clrBlack, 0, CORNER_LEFT_UPPER,8,"Arial",0,false,OBJ_ALL_PERIODS);
   ObjCreateButton("sell_2", false, 5,40, 100, 50, DoubleToString(ask,digit), EntryColorShort, clrBlack, 0, CORNER_LEFT_UPPER,12,"Arial",0,false,OBJ_ALL_PERIODS);
   ObjCreateEditAlign("lot_1", "0.0000", 56,20,100,19,0,ANCHOR_LEFT_UPPER,CORNER_LEFT_UPPER,clrWhite,clrBlack,8,"Arial", 0, false, 0,OBJ_ALL_PERIODS,false,false);
   ObjCreateEditAlign("status_1", "tradingtoolcrypto.com", 5,90,202,19,0,ANCHOR_LEFT_UPPER,CORNER_LEFT_UPPER,clrWhite,clrBlack,8,"Arial", 0, false, 0,OBJ_ALL_PERIODS,false,false);
   ChartRedraw();
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void function_hide_gui()
  {
   ObjectDelete(0,"buy_1");
   ObjectDelete(0,"buy_2");
   ObjectDelete(0,"sell_1");
   ObjectDelete(0,"sell_2");
   ObjectDelete(0,"lot_1");
   ObjectDelete(0,"status_1");
   ChartRedraw();
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,         // event ID
                  const long& lparam,   // event parameter of the long type
                  const double& dparam, // event parameter of the double type
                  const string& sparam) // event parameter of the string type
  {

   if(id == CHARTEVENT_OBJECT_CLICK)
     {
      if(sparam =="hide_1")
        {
         long value = ObjectGetInteger(0,sparam,OBJPROP_STATE,0);
         if(value == 0)
           {
            function_hide_gui();
           }
         else
           {
            function_make_gui(0, 0, 0);
           }
        }

      if(sparam =="balance_1")
        {
         cb.balance("",0,20);
         ObjectSetInteger(0, sparam, OBJPROP_STATE, false);
         ChartRedraw();
        }

      if(sparam =="position_1")
        {
         cb.positionTotal();
         ObjectSetInteger(0, sparam, OBJPROP_STATE, false);
         ChartRedraw();
        }

      if(sparam =="buy_2")
        {
         string  value = ObjectGetString(0,"lot_1",OBJPROP_TEXT);
         double lot = DoubleToString(value,8);
         if(cb.tradeBuy(lot))
           {
            ObjectSetString(0,"status_1",OBJPROP_TEXT, "Buy Market Sent: Volume: " + value);
           }
         cb.positionTotal();
         cb.balance("",0,20);
         ObjectSetInteger(0, sparam, OBJPROP_STATE, false);
         ChartRedraw();
        }

      if(sparam =="sell_2")
        {
         string  value = ObjectGetString(0,"lot_1",OBJPROP_TEXT);
         double lot = DoubleToString(value,8);
         if(cb.tradeSell(lot))
           {
            ObjectSetString(0,"status_1",OBJPROP_TEXT, "Sell Market Sent: Volume: " + value);
           }
         cb.positionTotal();
         cb.balance("",0,20);
         ObjectSetInteger(0, sparam, OBJPROP_STATE, false);
         ChartRedraw();
        }

     }

   if(id == CHARTEVENT_OBJECT_ENDEDIT)
     {
      if(sparam =="lot_1")
        {
         string  value = ObjectGetString(0,"lot_1",OBJPROP_TEXT);
         ObjectSetString(0,"status_1",OBJPROP_TEXT, "Volume Changed: " + value);
         ObjectSetInteger(0, sparam, OBJPROP_STATE, false);
         ChartRedraw();
        }
     }

  }
//+------------------------------------------------------------------+

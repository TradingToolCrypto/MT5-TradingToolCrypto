//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
int GLOBAL_binance_MaxBars = 999;
int GLOBAL_bybit_MaxBars = 1000; // v5
int GLOBAL_bitmex_MaxBars = 200;
int GLOBAL_switcheo_MaxBars = 1000;
int GLOBAL_deribit_MaxBars = 200;
int GLOBAL_kucoin_MaxBars = 500;
int GLOBAL_kucoin_Futures_MaxBars = 200;
int GLOBAL_satang_MaxBars = 500;
int GLOBAL_ftx_MaxBars = 1000;
int GLOBAL_coinbase_MaxBars = 300;
int GLOBAL_digitex_MaxBars = 1500;
int GLOBAL_huobifutures_MaxBars = 1000;
int GLOBAL_kraken_MaxBars = 720;
int GLOBAL_zbg_MaxBars = 500;
int GLOBAL_btse_MaxBars = 200;
int GLOBAL_bitstamp_MaxBars = 1000;
int GLOBAL_bitfinex_MaxBars = 1000;
int GLOBAL_gemini_MaxBars = 1000;
int GLOBAL_ascendex_MaxBars = 500;
int GLOBAL_bithumb_MaxBars = 500;
int GLOBAL_mexc_MaxBars = 1000;
int GLOBAL_phemex_MaxBars = 1000;
int GLOBAL_blofin_MaxBars = 1000;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
datetime GetTickTimeStamp(int gmt_shift) export
  {

   int time_seconds = (int)TimeLocal();
   datetime ok = 0;

   if(gmt_shift > 0)
     {
      // Hours / Minutes /sec
      ok = time_seconds - ((gmt_shift * 60) * 60);
      return (ok);
     }
   else
     {
      ok = time_seconds + ((gmt_shift * 60) * 60);
      return (ok);
     }

   return (0);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
datetime GetBarTimeStamp(int gmt_shift)
  {

   MqlDateTime local_;
   datetime local = TimeLocal();
   int local_int = (int)local;
   TimeToStruct(local, local_);

   int server_edit = 0;

   int sec_l = local_.sec;

   if(gmt_shift > 0)
     {
      server_edit = local_int - ((gmt_shift * 60) * 60);
      server_edit = server_edit - sec_l;
      return (server_edit);
     }
   else
     {

      server_edit = local_int + ((gmt_shift * 60) * 60);
      server_edit = server_edit - sec_l;
      return (server_edit);
     }

   return (0);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
datetime ConvertMSToDatetime(string bar_timeA)
  {
   long time_open = StringToInteger(bar_timeA) / 1000; // Remove millisecond and normalize
   datetime time_open_adjust = (datetime)time_open;
   return (time_open_adjust);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
datetime ConvertISOToDatetime(string iso)
  {


   int what = StringReplace(iso, "-", ".");


   int what_1 = StringReplace(iso, "T", " ");


   int what_2 = StringReplace(iso, "Z", "");


   datetime x = StringToTime(iso);

   return (x);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string ConvertDatetimeToISO(datetime anydatetime)
  {

   datetime time_local = anydatetime;
   MqlDateTime myStruct;
   TimeToStruct(time_local, myStruct);

   int year = myStruct.year;
   int month = myStruct.mon;
   int day = myStruct.day;
   int hour = myStruct.hour;
   int minute = myStruct.min;
   int second = myStruct.sec;

   string ISO_Date = IntegerToString(year) + "-" + CheckTimeValue(month) + "-" + CheckTimeValue(day) + "T";
// 08:34:50.761Z
   string ISO_Time = CheckTimeValue(hour) + ":" + CheckTimeValue(minute) + ":" + CheckTimeValue(second) + ".000Z";

   string ISO8601 = ISO_Date + ISO_Time;

   return (ISO8601);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string CheckTimeValue(int check_value)
  {
   if(check_value < 10)
     {
      string convert = "0" + IntegerToString(check_value);
      return (convert);
     }
   else
     {
      string keep = IntegerToString(check_value);
      return (keep);
     }
   return ("FAILED");
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int GetRequiredWebRequestCount(int timeframe, int limit, datetime start, datetime end)
  {

   if(timeframe == 0 || limit == 0)
      return (0);

   int diff = (int)end -(int)start;
   double minutes = diff / 60;
   double try_minutes = minutes / timeframe; // 200/1 = 200 bars
   double fits = try_minutes / limit;



   if(fits > 1.0 && 2.0 >= fits)
     {
      return (2);
     }
   if(fits <= 1.0)
     {
      return (1);
     }

   return ((int)NormalizeDouble(fits, 0) + 1);// Add 1 extra to fill to most correct bar
  }

//+------------------------------------------------------------------+
//|         18328944 + 1 *60 ( 1 bar) times max Bars in one request  |
//+------------------------------------------------------------------+
datetime GetNextEndTime(datetime start, int timeframe, int limit, datetime lastservertime)
  {
   bool debug = false;
   if(start <= 0)
     {
      if(debug)
         Print("Debug:GetNextEndTime:start=0: | Error if 0 | start= " + (string)start);
      return (0);
     }

   if(lastservertime <= 0)
     {
      if(debug)
         Print("Debug:GetNextEndTime:end=0: | Error if 0 | end= " + (string)lastservertime);
      return (0);
     }

   if(timeframe <= 0)
     {
      if(debug)
         Print("Debug:GetNextEndTime:timeframe=0: | Error if 0 | timeframe= " + (string)timeframe);
      return (0);
     }

   if(limit <= 0)
     {
      if(debug)
         Print("Debug:GetNextEndTime:limit=0: | Error if 0 | limit= " + (string)limit);
      return (0);
     }

   datetime end = start + (timeframe * 60) * limit;

   /*
       if calculations of end time is past the original ending time, then edit endtime return to original ending time(servertime)
    */
   if(lastservertime < end)
     {
      end = lastservertime;
     }

   return (end);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int GMTShiftByHours(datetime server)
  {
   int seconds_L = (int)TimeLocal();//  Print("GMTShiftByHours(): " + hours_shift);
   int seconds_S = (int)server;
   static int hours_shift = 0;
   if(seconds_L > seconds_S)
     {
      hours_shift = ((seconds_L - seconds_S) / 60) / 60;
     }
   else
     {
      hours_shift = ((seconds_S - seconds_L) / 60) / 60;
     }
   return (hours_shift);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int HowManyCandles(datetime a, datetime b)
  {
   int seconds_total = (int)b - (int)a;
   int bars = (seconds_total / 60); // remove the timeframe since all charts will be created with M1 bars ==>  60*Select_Timeframe
   return (bars);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int GetMaxBars(int exchange)
  {

   if((exchange == 1) || (exchange == 5) || (exchange == 6) || (exchange == 21) || (exchange == 26) || (exchange == 27))
     {
      return (GLOBAL_binance_MaxBars);
     }

   if((exchange == 2) || (exchange == 22) || (exchange == 23) || (exchange == 24) || (exchange == 31))
     {
      return (GLOBAL_bybit_MaxBars);
     }
   if(exchange == 3)
     {
      return (GLOBAL_bitmex_MaxBars);
     }
   if(exchange == 4)
     {
      return (GLOBAL_kucoin_MaxBars);
     }

   if(exchange == 7)
     {
      return (GLOBAL_deribit_MaxBars);
     }

   if(exchange == 8)
     {
      return (GLOBAL_switcheo_MaxBars);
     }

   if(exchange == 9)
     {
      return (GLOBAL_coinbase_MaxBars);
     }

   if(exchange == 10)
     {
      return (GLOBAL_bitfinex_MaxBars);
     }

   if(exchange == 11)
     {
      return (GLOBAL_bitstamp_MaxBars);
     }

   if(exchange == 12)
     {
      return (GLOBAL_ftx_MaxBars);
     }

   if(exchange == 13)
     {
      return (GLOBAL_satang_MaxBars);
     }

   if(exchange == 14)
     {
      return (GLOBAL_digitex_MaxBars);
     }

   if(exchange == 15)
     {
      return (GLOBAL_huobifutures_MaxBars);
     }

   if((exchange == 16) || (exchange == 34))
     {
      return (GLOBAL_phemex_MaxBars);
     }

   if(exchange == 17)
     {
      return (GLOBAL_zbg_MaxBars);
     }

   if(exchange == 18)
     {
      return (GLOBAL_kraken_MaxBars);
     }
   if(exchange == 19)
     {
      return (GLOBAL_kucoin_Futures_MaxBars);
     }
   if(exchange == 20)
     {
      return (GLOBAL_btse_MaxBars);
     }
   if(exchange == 25)
     {
      return (GLOBAL_gemini_MaxBars);
     }
   if(exchange == 28)
     {
      return (GLOBAL_ascendex_MaxBars);
     }
   if(exchange == 29)
     {
      return (GLOBAL_bithumb_MaxBars);
     }
   if(exchange == 30)
     {
      return (GLOBAL_mexc_MaxBars);
     }

   if(exchange == 33)
     {
      return (GLOBAL_blofin_MaxBars);
     }

   return (1);
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
enum ENUM_AVAILABLE_TIMEFRAME
  {
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
//|                                                                  |
//+------------------------------------------------------------------+
datetime ConvertMSToDatetime(string bar_timeA)
  {
   long time_open = StringToInteger(bar_timeA) / 1000; // Remove millisecond and normalize
   datetime time_open_adjust = (int)time_open;
   return (time_open_adjust);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
datetime ConvertISOToDatetime(string iso)
  {

   bool debug = false;

   int what = StringReplace(iso,"-",".");

   if(debug)
      Print(iso + " what " + what);

   int what_1 = StringReplace(iso,"T"," ");

   if(debug)
      Print(iso + " what_1 " + what_1);

   int what_2 = StringReplace(iso,"Z","");

   if(debug)
      Print(iso + " what_2 " + what_2);

   datetime x = StringToTime(iso);

   if(debug)
      Print("Final: " + (int) x);

   return(x);

  }
//+------------------------------------------------------------------+

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
//08:34:50.761Z
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
//|         18328944 + 1 *60 ( 1 bar) times max Bars in one request  |
//+------------------------------------------------------------------+
datetime GetNextEndTime(datetime start, int timeframe, int limit, datetime lastservertime)
  {
   bool debug = false;
   if(start <= 0)
     {
      if(debug)
         Print("Debug:GetNextEndTime:start=0: | Error if 0 | start= " + start);
      return (0);
     }

   if(lastservertime <= 0)
     {
      if(debug)
         Print("Debug:GetNextEndTime:end=0: | Error if 0 | end= " + lastservertime);
      return (0);
     }

   if(timeframe <= 0)
     {
      if(debug)
         Print("Debug:GetNextEndTime:timeframe=0: | Error if 0 | timeframe= " + timeframe);
      return (0);
     }

   if(limit <= 0)
     {
      if(debug)
         Print("Debug:GetNextEndTime:limit=0: | Error if 0 | limit= " + limit);
      return (0);
     }

   datetime end = start + (timeframe * 60) * limit;

   if(debug)
      Print(" start " + start + " timeframe " + timeframe + " limit " + limit +  " lastservertime " +  lastservertime  + " end " + end);


   /*
       if calculations of end time is past the original ending time, then edit endtime return to original ending time(servertime)
    */
   if(lastservertime < end)
     {
      end = lastservertime;
     }

   return (end);
  }



/*
 Get the local time,
 - adjust the local time +/- gmt shift
 - gmt_shift == a positive number if the timelocal is > server time
*/
datetime ticktimestamp(int gmt_shift)
  {

   int time_seconds = (int) TimeLocal();
   datetime ok = 0;

   if(gmt_shift>0)
     {
      // Hours / Minutes / Seconds
      ok = time_seconds - ((gmt_shift * 60)*60);
      return(ok);
     }
   else
     {
      ok = time_seconds + ((gmt_shift * 60)*60);
      return(ok);
     }

   return(0);
  }


/*

   Get the local time
      - adjust the local time based on the server GMT shift
      - Convert the date time to int == seconds
      - subsctract the current seconds within the bar so, the Bar start time is the same on ever call

*/
datetime bartimestamp(int gmt_shift)
  {

   MqlDateTime local_;
   datetime local = TimeLocal();
   int local_int = (int)local;
   TimeToStruct(local,local_);

   int server_edit =0;

   int sec_l =  local_.sec;

   if(gmt_shift>0)
     {
      server_edit = local_int - ((gmt_shift * 60)*60);
      server_edit = server_edit - sec_l;
      return(server_edit);
     }
   else
     {

      server_edit = local_int + ((gmt_shift * 60)*60);
      server_edit = server_edit - sec_l;
      return(server_edit);

     }

   return(0);
  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int convert_string_to_timeframe(string value)
  {

   Print(" COnvert " + value +"|");
   if(value == "1Min")
     {
      return(1);
     }
   if(value == "5Min")
     {
      return(5);
     }
   if(value == "15Min")
     {
      return(15);
     }
   if(value == "30Min")
     {
      return(30);
     }
   if(value == "1H")
     {
      return(60);
     }
   if(value == "2H")
     {
      return(120);
     }
   if(value == "4H")
     {
      return(240);
     }
   if(value == "1D")
     {
      return(1440);
     }
   return(1);
  }
//+------------------------------------------------------------------+

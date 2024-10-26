//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, TradingToolCrypto Corp"
#property link "https://github.com/TradingToolCrypto/TradingTool-Wiki/wiki/6.-Reactivation-of-Licence"
#property version   "1.100"
#property  script_show_inputs

input string FileName_ID = "";


input string License_ID = "";
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnStart()
  {

   read_file(FileName_ID);

   if(License_ID!="")
     {
      GlobalVariableSet(License_ID,0);
     }

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void read_file(string tx)
  {
   int file_handle=FileOpen(tx+".txt",FILE_READ|FILE_TXT);
   string str;
   int count_lines=0;
   if(file_handle==INVALID_HANDLE)
     {
      Alert("Incorrect File Name - Check MQL5/Files Folder for file name (such as CPFC4SUFHYRHDJDHE3848HD) ");
      return;
     }
   if(file_handle!=INVALID_HANDLE)
     {
      //--- read data from the file
      while(!FileIsEnding(file_handle))//!FileIsLineEnding(file_handle) &&
        {
         str= FileReadString(file_handle,-1);
         if(count_lines == 0)             //CRT
           {
            GlobalVariableSet(str,0);
           }
         if(count_lines == 1 && str !="2") //TTC
           {
            GlobalVariableSet(str,0);
           }
         if(count_lines == 2 && str !="3") //PRO
           {
            GlobalVariableSet(str,0);
           }
         if(count_lines == 3 && str !="4") //ELITE
           {
            GlobalVariableSet(str,0);
           }
         if(count_lines == 4 && str !="5") //PRIME
           {
            GlobalVariableSet(str,0);
           }
         count_lines++;
        }
      //--- close the file
      FileClose(file_handle);
     }
   Alert("License Key Loaded in Memory: Run this script anytime you experience (Expired License) message");
  }
//+------------------------------------------------------------------+

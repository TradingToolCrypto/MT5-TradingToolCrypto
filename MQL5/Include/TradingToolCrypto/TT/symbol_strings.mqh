#property copyright "Copyright 2020, TradingToolCrypto Corp."
#property link      "https://github.com/tradingtoolcrypto"

/*
  EURUSD.suffic
  GBPUSD_LMAX
  TRYGBP.Lmx
  
  ("eurusd" , ".")
*/
string format_symbol_uppercase(string text, string suffix_identifier){
               string array_text[];                         // An array to get strings
               string sep=suffix_identifier;                // A separator as a character
               ushort u_sep;                                // The code of the separator character              
               //--- Get the separator code
               u_sep=StringGetCharacter(sep,0);
               int dash_count = StringSplit(text,u_sep,array_text);
               if(dash_count>1){
               //--- Work with the strings individually
                  StringToUpper(array_text[0]);
                  StringToLower(array_text[1]);
                  string format = array_text[0] + sep +array_text[1];
                  return(format);
               
               }else{
               //--- No suffix found, return the same string
                  StringToUpper(text);
                  return(text);
               }
               
               
      return(text);         
}

//order_type( PositionGetInteger(POSITION_TYPE)) 
string order_type(int type_order)
  {
   if(type_order == 0){
      return("Buy");
   }
   if(type_order == 1){
      return("Sell");
   }
   return("Limit/Stop");

  }

string GLOBAL_SYMBOL_LIST_1 = "";
string GLOBAL_SYMBOL_LIST_2 = "";
string GLOBAL_SYMBOL_LIST_3 = "";
string GLOBAL_SYMBOL_LIST_4 = "";
string GLOBAL_SYMBOL_LIST_5 = "";
string GLOBAL_SYMBOL_LIST_6 = "";
string GLOBAL_SYMBOL_LIST_7 = "";
string GLOBAL_SYMBOL_LIST_8 = "";
string GLOBAL_SYMBOL_LIST_9 = "";
string GLOBAL_SYMBOL_LIST_10 = "";
void list_symbols(bool ListOnlyMarketWatch ,int list_length){

    int loop =  SymbolsTotal(true);
    string msg = "";
      for(int i = 0; loop>i;i++){
      
         if(list_length > i){
         GLOBAL_SYMBOL_LIST_1 += "\n" + SymbolName(i,ListOnlyMarketWatch);
         }
         if(list_length*2 < i && i < list_length*3){
         GLOBAL_SYMBOL_LIST_2 += "\n" + SymbolName(i,ListOnlyMarketWatch);
         }
         if(list_length *3< i&& i < list_length*4){
         GLOBAL_SYMBOL_LIST_3 += "\n" + SymbolName(i,ListOnlyMarketWatch);
         }
         if(list_length*4 < i&& i < list_length*5){
         GLOBAL_SYMBOL_LIST_4 += "\n" + SymbolName(i,ListOnlyMarketWatch);
         }
         if(list_length*5 < i&& i < list_length*6){
         GLOBAL_SYMBOL_LIST_5 += "\n" + SymbolName(i,ListOnlyMarketWatch);
         }
         if(list_length*6 < i&& i < list_length*7){
         GLOBAL_SYMBOL_LIST_6 += "\n" + SymbolName(i,ListOnlyMarketWatch);
         }
         if(list_length*7 < i&& i < list_length*8){
         GLOBAL_SYMBOL_LIST_7 += "\n" + SymbolName(i,ListOnlyMarketWatch);
         }
         if(list_length*8 < i&& i < list_length*9){
         GLOBAL_SYMBOL_LIST_8 += "\n" + SymbolName(i,ListOnlyMarketWatch);
         }
         if(list_length*9 < i && i < list_length*10){
         GLOBAL_SYMBOL_LIST_9 += "\n" + SymbolName(i,ListOnlyMarketWatch);
         }
         if(list_length*10 < i && i < list_length*11){
         GLOBAL_SYMBOL_LIST_10 += "\n" + SymbolName(i,ListOnlyMarketWatch);
         }
      
      }
}
string str_cornix_signal_truncate(double price , int price_digit ){
 
  string value1 = DoubleToString(price,price_digit);
  if(price >=1.0){
   return(value1);
  }
 
  
   
  int search1 = StringFind(value1,"0.0000000",0);
  if( search1 != -1  ){
     value1 =  StringSubstr(value1,9,-1);
     return(value1);
  }
  
  int search2 = StringFind(value1,"0.000000",0);
  if( search2 != -1  ){
     value1 =  StringSubstr(value1,8,-1);
     return(value1);
  }
  
  int search3 = StringFind(value1,"0.00000",0);
  if( search3 != -1  ){
     value1 =  StringSubstr(value1,7,-1);
     return(value1);
  }
  
  int search4 = StringFind(value1,"0.0000",0);
  if( search4 != -1  ){
     value1 =  StringSubstr(value1,6,-1);
     return(value1);
  }
  
  int search5 = StringFind(value1,"0.000",0);
  if( search5 != -1  ){
     value1 =  StringSubstr(value1,5,-1);
     return(value1);
  }
  
  int search6 = StringFind(value1,"0.00",0);
  if( search6 != -1  ){
     value1 =  StringSubstr(value1,4,-1);
     return(value1);
  }
  
  int search7 = StringFind(value1,"0.0",0);
  if( search7 != -1  ){
     value1 =  StringSubstr(value1,3,-1);
     return(value1);
  }
  
  int search8 = StringFind(value1,"0.",0);
  if( search8 != -1  ){
     value1 =  StringSubstr(value1,2,-1);
     return(value1);
  }
   return(value1);
}

string str_change_side_longshort(string side){

   if(side == "BUY"){
      return("LONG");
   }
   if(side == "SELL"){
      return("SHORT");
   }
   
   // no match
   return(side);


}

/*
 /alert symbol 12345
*/


string symbol_uppercase(string text, string suffix_identifier){
               string array_text[];                         // An array to get strings
               string sep=suffix_identifier;                // A separator as a character
               ushort u_sep;                                // The code of the separator character              
               //--- Get the separator code
               u_sep=StringGetCharacter(sep,0);
               int dash_count = StringSplit(text,u_sep,array_text);
               if(dash_count>1){
               //--- Work with the strings individually
               
                 
                  StringToUpper(array_text[1]);
                  return(array_text[1]); 
                 
               
               }
               
               
      return("");         
}


string symbol_price(string text, string suffix_identifier){
               string array_text[];                         // An array to get strings
               string sep=suffix_identifier;                // A separator as a character
               ushort u_sep;                                // The code of the separator character              
               //--- Get the separator code
               u_sep=StringGetCharacter(sep,0);
               int dash_count = StringSplit(text,u_sep,array_text);
               if(dash_count>1){
               //--- Work with the strings individually
                  return(array_text[2]); 
               }   
      return("");         
}
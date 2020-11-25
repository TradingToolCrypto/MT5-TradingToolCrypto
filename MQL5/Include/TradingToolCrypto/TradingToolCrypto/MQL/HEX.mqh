string convert_String_HEX(string convert_this){
  int counter=0;
  int length = StringLen(convert_this);
  //Print("Length:" + length + " unforrmatted: " +  convert_this);
 
     string add;
     string symbol;
     
  
     for(int i = 0 ; i< length; i++){
      symbol= StringSubstr(convert_this,i,1);
   //   Print("convert_String_HEX (symbol):" + symbol);
      
      ushort b = StringGetCharacter(symbol,0);
    //  Print("convert_String_HEX (ushort):" + b);
      add +=""+ hex(b);
    //  Print("convert_String_HEX hex():" + add);
      counter++;
     }
   //  Print(" Counter: " + counter + " Length" + length);
  return(add);
}

string hex(ushort value  ){
   return(   StringFormat("%x",
              value) );
}

string return_HEX_2Byte(string var){

 const long num =   StringToInteger(var);
 
   if(num == 1){
      return("31");
   }
   if(num == 2){
      return("32");
   }
   if(num == 3){
      return("33");
   }
   if(num == 4){
      return("34");
   }
   if(num == 5){
      return("35");
   }
   if(num == 6){
      return("36");
   }
   if(num == 7){
      return("37");
   }
   if(num == 8){
      return("38");
   }
   if(num == 9){
      return("39");
   }
  
  
   // SYMBOLS
   if(var =="a"){
      return("61");
   }
    if(var =="A"){
      return("41");
   }
   if(var =="b"){
      return("62");
   }
   if(var =="B"){
      return("42");
   }
   if(var =="c"){
      return("63");
   }
    if(var =="C"){
      return("43");
   }
   
   if(var =="d"){
      return("64");
   }
   if(var =="D"){
      return("44");
   }
   if(var =="e"){
      return("65");
   }
   if(var =="E"){
      return("45");
   }
   if(var =="f"){
      return("66");
   }
    if(var =="F"){
      return("46");
   }
   if(var =="g"){
      return("67");
   }
   if(var =="G"){
      return("47");
   }
   if(var =="h"){
      return("68");
   }
    if(var =="H"){
      return("48");
   }
   if(var =="i"){
      return("69");
   }
       if(var =="I"){
            return("49");
         }
    if(var =="j"){
      return("6a");
   }
    if(var =="J"){
      return("4a");
   }
   if(var =="k"){
      return("6b");
   }
   if(var =="K"){
      return("4b");
   }
   if(var =="l"){
      return("6c");
   }
    if(var =="L"){
      return("4c");
   }
   if(var =="m"){
      return("6d");
   }
    if(var =="M"){
      return("4d");
   }
   if(var =="n"){
      return("6e");
   }
   if(var =="N"){
      return("4e");
   }
    if(var =="o"){
      return("6f");
   }
    if(var =="O"){
      return("4f");
   }
   if(var =="p"){
      return("70");
   }
   if(var =="P"){
      return("50");
   }
   
   if(var =="q"){
      return("71");
   }
    if(var =="Q"){
      return("51");
   }
   if(var =="r"){
      return("72");
   }
    if(var =="R"){
      return("52");
   }
   if(var =="s"){
      return("73");
   }
   if(var =="S"){
      return("53");
   }
   if(var =="t"){
      return("74");
   }
   if(var =="T"){
      return("54");
   }
   if(var =="u"){
      return("75");
   }
    if(var =="U"){
      return("55");
   }
   if(var =="v"){
      return("76");
   }
   if(var =="V"){
      return("56");
   }
   if(var =="w"){
      return("77");
   }
   if(var =="W"){
      return("57");
   }
   if(var =="x"){
      return("78");
   }
   if(var =="X"){
      return("58");
   }
   if(var =="y"){
      return("79");
   }
    if(var =="Y"){
      return("59");
   }
   if(var =="z"){
      return("7a");
   }
   if(var =="Z"){
      return("5a");
   }
   
   
   //=== 
   if(num == 0){
      return("30");
   }
   
  return("");
}


#define TO_HEX(i) (i <= 9 ? '0' + i : 'A' - 10 + i)

ushort run_hex(int value){
   int x = value;
   char res[5];
   
   if (x <= 0xFFFF)
   {
       res[0] = TO_HEX(((x & 0xF000) >> 12));   
       res[1] = TO_HEX(((x & 0x0F00) >> 8));
       res[2] = TO_HEX(((x & 0x00F0) >> 4));
       res[3] = TO_HEX((x & 0x000F));
       res[4] = '\0';
   }
   
//   Print(" 0 " + res[0]  );
//   Print(" 1 " + res[1]  );
//   Print(" 2 " + res[2]  );
//   Print(" 3 " + res[3]  );
//   Print(" 4 " + res[4]  );
   
   
   return( res[0]);
}



//+------------------------------------------------------------------+
//| convert integer to string contained input's hexadecimal notation |
//+------------------------------------------------------------------+
string IntegerToHexString(int integer_number)
  {
   string hex_string="00000000";
   int    value,shift=28;
//---
   for(int i=0; i<8; i++)
     {
     
     
     
      value=(integer_number>>shift)&0x0F;
      
       
      if(value<10)
         hex_string=StringSetCharacter(hex_string,i,ushort(value+'0'));
      else
         hex_string=StringSetCharacter(hex_string,i,ushort((value-10)+'A'));
      shift-=4;
      
      Print("index: " + i + " input: " + integer_number  + " value:" + value +" hexstring:" + hex_string );
      
     }
     
     
     /*  MT5
     Returns copy of a string with a changed character in a specified position.

      bool  StringSetCharacter(
      string&   string_var,       // string
      int       pos,              // position
      ushort    character         // character
      );
      
      MT4
      Returns true is a symbol is successfully inserted to the passed string.

      bool  StringSetCharacter(
         string&   string_var,       // string
         int       pos,              // position
         ushort    character         // character
         );
   
   */
     
     
     
     
//---
   return(hex_string);
  }
//+------------------------------------------------------------------+


 /*
 SHA256 Lib
 https://www.mql5.com/en/code/21065
 
 Hex encoding is performed by converting the 8 bit data to 2 hex characters.
 
 
 StringGetChar("q", 0) returns 113 (ASCII code) instead of 81 (key code).
  
//+------------------------------------------------------------------+
//| HEXtoInteger                                                  |
//+------------------------------------------------------------------+
 int hexToInteger(string str)
{
   int result=0;
   int power=0;
   for(int pos=StringLen(str)-1; pos>=0; pos--)
   {
      
      int c=StringGetChar( str, pos);
      int value = 0; 
      if(c>='0' && c<='9')
         value=c-'0';
      else if(c>='a' && c<='f')
         value=c-'a'+10;   
      else if(c>='A' && c<='F')
         value=c-'A'+10;      
      
      result += value*MathPow(16.0, power);
      power++;   
   }   
   return(result);
}
 
 
 //+------------------------------------------------------------------+
//| LongToHEX                                                     |
//+------------------------------------------------------------------+
 string long_to_hex(ulong value){
   string result="";
   do{
      result = string(value & 0xF)+result;
      value >>= 8;
   }while(value != 0);
   return result;
}

//+------------------------------------------------------------------+
//| ArrayToHex                                                       |
//+------------------------------------------------------------------+

*/

string ArrayToHex(uchar &arr[],int count=-1)
  {
   string res="";
//--- check
   if(count<0 || count>ArraySize(arr))
      count=ArraySize(arr);
//--- transform to HEX string
   for(int i=0; i<count; i++)
      res+=StringFormat("%.2X",arr[i]);
//---
   return(res);
  }
 
 
 



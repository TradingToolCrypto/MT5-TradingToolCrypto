/*
   Functions for the Exchange Libraries
*/

#import "TTC_KEY.ex5"
void ttc_g_pro();
string ttc_e();
string ttc_d(string hexData);
#import

#include <TradingToolCrypto\MQL\sha256.mqh>
#include <TradingToolCrypto\MQL\Jason.mqh>
SHA256 hash256;
string GLOBAL_Parse = "#";


/*
   Take any number represented as a string and normalize the decimal accuracy

   Example:

   normalizeString("958.8483, 2) == 958.84
*/

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string NormalizeString(string value, int digit)
  {


   /*
    Check the string for "." if the value is not found, return the string
   */
   if(StringFind(value,".",0) == -1)
     {
      return(value);
     }
   /*
       if we want to normalize digit = 0 , then search for the "." and remove the values
     Check the string for "." if the value is not found, return the string
    */
   if(digit == 0)
     {
      const int placement = StringFind(value,".",0);
      const int lengt = StringLen(value);
      //  Print(" Length " + IntegerToString(lengt) + " placement " + IntegerToString(placement));
      if(placement >=0)
        {

         value = StringSubstr(value,0,placement);
         return(value);
        }

     }

   string sep=".";
   ushort u_sep;
   string result[];

   u_sep=StringGetCharacter(sep,0);

   int k=StringSplit(value,u_sep,result);

   string s_whole = result[0];

   string s_decimal = result[1];

   int length = StringLen(s_decimal);

   string add = StringSubstr(s_decimal,0,digit);

   string ok = s_whole + "." + add;

   return(ok);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string urlencode(string value)
  {
   int len = StringLen(value);
   string concatenate ="";
   uchar characters[];
   StringToCharArray(value,characters);
   for(int i = 0; i<len ; i++)
     {
      concatenate+= (StringFormat("%%%02x", characters[i]));
     }
   return(concatenate);
  }
/*

    Convert string to double
    remove all values after the decimal and return a new string as a whole number

*/
string in(string message)
  {

   double number =  StringToDouble(message);
   string result ="";
   if(number>0)
     {
      result =  DoubleToString(number,0);
     }
   else
     {
      return(message);  // Letters.
     }
   return(result);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Get_Trailing_Zeros_digits(double has_zeros)
  {
   /*
      this string has zeros,
   */
   double zeros = has_zeros;

   /*

   string A =  DoubleToString(has_zeros);

   int decimal_location = StringFind(A,".",0);

   int z8 = StringFind(A,"0",decimal_location+8);
   int z7 = StringFind(A,"0",decimal_location+7);
   int z6 = StringFind(A,"0",decimal_location+6);
   int z5 = StringFind(A,"0",decimal_location+5);
   int z4 = StringFind(A,"0",decimal_location+4);
   int z3 = StringFind(A,"0",decimal_location+3);
   int z2 = StringFind(A,"0",decimal_location+2);
   int z1 = StringFind(A,"0",decimal_location+1);
   int z0 = StringFind(A,"0",decimal_location+0);

   Print(" String: " + A + " dec: " + decimal_location +
   "\mZero Location8" + z8 +
   "\mZero Location8" + z7 +
   "\mZero Location8" + z6 +
   "\mZero Location8" + z5 +
   "\mZero Location8" + z4 +
   "\mZero Location8" + z3 +
   "\mZero Location2: " + z2 +
   "\mZero Location1: " + z1 +
   "\mZero Location0: " + z0 );

   int length = StringLen(A);
   */
   if(zeros > 1)
     {
      //  Print(" has+Zeros(out): " +  DoubleToString(zeros,1) );
      return(1);

     }
   if(zeros > 0.1)
     {
      //  Print(" has+Zeros(out): " +  DoubleToString(zeros,2) );
      return(2);

     }
   if(zeros > 0.01)
     {
      // Print(" has+Zeros(out): " +  DoubleToString(zeros,3) );
      return(3);

     }
   if(zeros > 0.001)
     {
      //  Print(" has+Zeros(out): " +  DoubleToString(zeros,4) );
      return(4);

     }
   if(zeros > 0.0001)
     {
      //   Print(" has+Zeros(out): " +  DoubleToString(zeros,5) );
      return(5);

     }
   if(zeros > 0.00001)
     {
      // Print(" has+Zeros(out): " +  DoubleToString(zeros,6) );
      return(6);

     }
   if(zeros > 0.000001)
     {
      //  Print(" has+Zeros(out): " +  DoubleToString(zeros,7) );
      return(7);

     }
   if(zeros > 0.0000001)
     {
      //  Print(" has+Zeros(out): " +  DoubleToString(zeros,8) );
      return(8);

     }

   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string Get_Trailing_ZerosB(string has_zeros)
  {
   /*
      this string has zeros,
   */
   int digit=0;
   double zeros = StringToDouble(has_zeros);

   if(zeros==0)
      return(has_zeros);


   string  format_string=StringFormat("%%.%df",
                                      zeros);
   return(format_string);




   if(zeros > 1)
     {

      return(DoubleToString(zeros,1));

     }
   if(zeros > 0.1)
     {

      return(DoubleToString(zeros,2));

     }
   if(zeros > 0.01)
     {

      return(DoubleToString(zeros,3));

     }
   if(zeros > 0.001)
     {

      return(DoubleToString(zeros,4));

     }
   if(zeros > 0.0001)
     {

      return(DoubleToString(zeros,5));

     }
   if(zeros > 0.00001)
     {

      return(DoubleToString(zeros,6));

     }
   if(zeros > 0.000001)
     {

      return(DoubleToString(zeros,7));

     }
   if(zeros > 0.0000001)
     {

      return(DoubleToString(zeros,8));

     }

   return("");
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string Get_Trailing_ZerosC(string has_zeros)
  {


   return(StringSubstr(has_zeros,0,8));

   /*
      this string has zeros,
   */
   int digit=0;
   double zeros = StringToDouble(has_zeros);
   string out = "";

//  Print(" String In: " + has_zeros + "  DoubleOut: " + DoubleToString(zeros,8));

   if(zeros > 1)
     {
      out = DoubleToString(zeros,1);
      Print(" String Out: " + out);
      return(out);

     }
   if(zeros > 0.1 && zeros <= 1)
     {

      out = DoubleToString(zeros,2);
      Print(" String Out: " + out);
      return(out);

     }
   if(zeros > 0.01 && zeros <= 0.1)
     {

      out = DoubleToString(zeros,3);
      Print(" String Out: " + out);
      return(out);
     }
   if(zeros > 0.001 && zeros <= 0.01)
     {

      out = DoubleToString(zeros,4);
      Print(" String Out: " + out);
      return(out);

     }
   if(zeros > 0.0001 && zeros <= 0.001)
     {

      out = DoubleToString(zeros,5);
      Print(" String Out: " + out);
      return(out);

     }
   if(zeros > 0.00001 && zeros <= 0.0001)
     {

      out = DoubleToString(zeros,6);
      Print(" String Out: " + out);
      return(out);

     }
   if(zeros > 0.000001 && zeros <= 0.00001)
     {

      out = DoubleToString(zeros,7);
      Print(" String Out: " + out);
      return(out);

     }
   if(zeros > 0.0000001 && zeros <= 0.000001)
     {
      Print(" String Out: " + out);
      out = DoubleToString(zeros,8);
      Print(" String Out: " + out);
      return(out);

     }

   return(DoubleToString(zeros,8));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Global_Delete(string text)
  {
   if(text !="")
     {
      GlobalVariablesDeleteAll(text,0);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Object_Delete(string objectname)
  {

   int loop = ObjectsTotal(0, 1, -1);
   for(int i = 0; i < loop; i++)
     {

      if(ObjectDelete(ChartID(), objectname) == false)
        {
         Print(objectname + " Object_Delete Failed Error: " + IntegerToString(GetLastError()));
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void SetText_subWindow(string name, string text, int x, int y, color colour, int size = 12)
  {
   int find = ObjectFind(0, name);
   if(find >= 0)  // Object found in window 0 or window 1
     {
      //  Print("OBJECT FOUND "+name  + " chart window():" + find );
      string ob_text = ObjectGetString(0, name, OBJPROP_TEXT, 0);
      //  Print("OBJECT FOUND "+name+" obj(text):"+ob_text+" change obj(text): "+text);
      if(ob_text != text)
        {

         if(ObjectSetString(0, name, OBJPROP_TEXT, text))
           {
            // Print("SetText_subWindow() Text Updated: "+text);
           }
         else
           {
            Print(" objectSetString failed; Error(): " + IntegerToString(GetLastError()));
           }
        }
     }
   else
     {
      //+------------------------------------------------------------------+
      //|                                                                  |
      //+------------------------------------------------------------------+
      if(ObjectCreate(0, name, OBJ_LABEL, 1, 0, 0))
        {
         ObjectSetInteger(0, name, OBJPROP_XDISTANCE, x);
         ObjectSetInteger(0, name, OBJPROP_YDISTANCE, y);
         ObjectSetInteger(0, name, OBJPROP_COLOR, colour);
         ObjectSetInteger(0, name, OBJPROP_FONTSIZE, size);
         ObjectSetInteger(0, name, OBJPROP_CORNER, CORNER_LEFT_UPPER);
         ObjectSetString(0, name, OBJPROP_TEXT, text);

        }
      else
        {
         Print(" object creation failed; Error(): " + IntegerToString(GetLastError()));
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ObjCreateEdit(
   string aObjName,
   string aText,
   int aX = 30,
   int aY = 30,
   int aXSize = 380,
   int aYSize = 240,
   int aWindow = 0,
   int aAnchor = ANCHOR_LEFT_UPPER,
   int aCorner = CORNER_LEFT_UPPER,
   color aBgColor = LightYellow,
   color aColor = Chocolate,
   int aFontSize = 8,
   string aFont = "Arial",
   int aChartID = 0,
   bool aBack = false,
   double aAngle = 0,
   long aTimeFrames = OBJ_ALL_PERIODS,
   bool aSelectable = false,
   bool aSelected = false)
  {
   ObjectCreate(aChartID, aObjName, OBJ_EDIT, aWindow, 0, 0);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_ANCHOR, aAnchor);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_BACK, aBack);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_COLOR, aColor);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_BGCOLOR, aBgColor);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_CORNER, aCorner);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_FONTSIZE, aFontSize);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_SELECTABLE, aSelectable);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_SELECTED, aSelected);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_TIMEFRAMES, aTimeFrames);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_XDISTANCE, aX);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_YDISTANCE, aY);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_XSIZE, aXSize);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_YSIZE, aYSize);
   ObjectSetString(aChartID, aObjName, OBJPROP_FONT, aFont);
   ObjectSetString(aChartID, aObjName, OBJPROP_TEXT, aText);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ObjCreateEditAlign(
   string aObjName,
   string aText,
   int aX = 30,
   int aY = 30,
   int aXSize = 380,
   int aYSize = 240,
   int aWindow = 0,
   int aAnchor = ANCHOR_LEFT_UPPER,
   int aCorner = CORNER_LEFT_UPPER,
   color aBgColor = LightYellow,
   color aColor = Chocolate,
   int aFontSize = 8,
   string aFont = "Arial",
   int aChartID = 0,
   bool aBack = false,
   double aAngle = 0,
   long aTimeFrames = OBJ_ALL_PERIODS,
   bool aSelectable = false,
   bool aSelected = false)
  {
   ObjectCreate(aChartID, aObjName, OBJ_EDIT, aWindow, 0, 0);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_ANCHOR, aAnchor);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_BACK, aBack);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_COLOR, aColor);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_BGCOLOR, aBgColor);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_CORNER, aCorner);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_FONTSIZE, aFontSize);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_SELECTABLE, aSelectable);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_SELECTED, aSelected);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_TIMEFRAMES, aTimeFrames);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_XDISTANCE, aX);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_YDISTANCE, aY);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_XSIZE, aXSize);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_YSIZE, aYSize);
   ObjectSetString(aChartID, aObjName, OBJPROP_FONT, aFont);
   ObjectSetString(aChartID, aObjName, OBJPROP_TEXT, aText);
   ObjectSetInteger(aChartID,aObjName,OBJPROP_ALIGN,ALIGN_CENTER);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ObjCreateButton(
   string aObjName,
   bool aState,
   int aX = 30,
   int aY = 30,
   int aWidth = 100,
   int aHeight = 30,
   string aCaption = "Push Me",
   color aBgColor = Silver,
   color aTextColor = Red,
   int aWindow = 0,
   int aCorner = CORNER_LEFT_UPPER,
   int aFontSize = 8,
   string aFont = "Arial",
   long aChartID = 0,
   bool aBack = false,
   long aTimeFrames = OBJ_ALL_PERIODS)
  {
   ObjectDelete(aChartID, aObjName);
   ObjectCreate(aChartID, aObjName, OBJ_BUTTON, aWindow, 0, 0);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_SELECTABLE, false);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_SELECTED, false);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_STATE, aState);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_CORNER, aCorner);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_XDISTANCE, aX);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_YDISTANCE, aY);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_XSIZE, aWidth);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_YSIZE, aHeight);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_BGCOLOR, aBgColor);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_COLOR, aTextColor);
   ObjectSetString(aChartID, aObjName, OBJPROP_FONT, aFont);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_FONTSIZE, aFontSize);
   ObjectSetString(aChartID, aObjName, OBJPROP_TEXT, aCaption);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_BACK, aBack);
   ObjectSetInteger(aChartID, aObjName, OBJPROP_TIMEFRAMES, aTimeFrames);
  }

/*

 take the market name BTCUSD_PERP and return BTCUSDPERP

 NormalizeSymbol("BTCUSD_PERP", "_");

*/
string NormalizeSymbol(string symbolname, string seperator)
  {
   string sep=seperator;
   ushort u_sep;
   string result[];
   u_sep=StringGetCharacter(sep,0);
   int k=StringSplit(symbolname,u_sep,result);
   /*
   found the sep
   */
   string merge = "";
   if(k==2)
     {
      merge = result[0]+result[1];
      return(merge);
     }
   return(symbolname);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string RemoveZerosFromString(string value)
  {
   bool debug = false;
   string create = "";
   string result = "";

   int decimal = StringFind(value, ".",0);
   string decimal_before = StringSubstr(value, 0,decimal);
   string decimal_after = StringSubstr(value, decimal+1,-1);
   int decimal_length = StringLen(decimal_after);
   int try1 = StringFind(decimal_after, "0",decimal_length-1);


   if(try1 != -1)
     {
      string found_zero_1 = StringSubstr(decimal_after,0,decimal_length-1);
      if(debug)
         Print(" Found then Edit ==> " +found_zero_1);
      int try2 = StringFind(found_zero_1, "0",decimal_length-2);
      if(try2 != -1)
        {
         string found_zero_2 = StringSubstr(found_zero_1,0,decimal_length-2);
         if(debug)
            Print(" Found then Edit ==> " +found_zero_2);
         int try3 = StringFind(found_zero_2, "0",decimal_length-3);
         if(try3 != -1)
           {
            string found_zero_3 = StringSubstr(found_zero_2,0,decimal_length-3);
            if(debug)
               Print(" Found then Edit ==> " +found_zero_3);
            int try4 = StringFind(found_zero_3, "0",decimal_length-4);
            if(try4 != -1)
              {
               string found_zero_4 = StringSubstr(found_zero_3,0,decimal_length-4);
               if(debug)
                  Print(" Found then Edit ==> " +found_zero_4);
               int try5 = StringFind(found_zero_4, "0",decimal_length-5);
               if(try5 != -1)
                 {
                  string found_zero_5 = StringSubstr(found_zero_4,0,decimal_length-5);
                  if(debug)
                     Print(" Found then Edit ==> " +found_zero_5);
                  int try6 = StringFind(found_zero_5, "0",decimal_length-6);
                  if(try6 != -1)
                    {
                     string found_zero_6 = StringSubstr(found_zero_5,0,decimal_length-6);
                     if(debug)
                        Print(" Found then Edit ==> " +found_zero_6);
                     int try7 = StringFind(found_zero_6, "0",decimal_length-7);
                     if(try7 != -1)
                       {
                        string found_zero_7 = StringSubstr(found_zero_6,0,decimal_length-7);
                        if(debug)
                           Print(" Found then Edit ==> " +found_zero_7);
                        int try8 = StringFind(found_zero_7, "0",decimal_length-8);
                        if(try8 != -1)
                          {
                           string found_zero_8 = StringSubstr(found_zero_7,0,decimal_length-8);
                           if(debug)
                              Print(" Found then Edit ==> " +found_zero_8);
                           int try9 = StringFind(found_zero_8, "0",decimal_length-9);

                          }
                        else
                          {
                           create  = found_zero_7;
                          }
                       }
                     else
                       {
                        create  = found_zero_6;
                       }
                    }
                  else
                    {
                     create  = found_zero_5;
                    }
                 }
               else
                 {
                  create  = found_zero_4;
                 }
              }
            else
              {
               create  = found_zero_3;
              }
           }
         else
           {
            create  = found_zero_2;
           }
        }
      else
        {
         create  = found_zero_1;
        }
     }
   else
     {
      create = decimal_after;
     }


   if(create != "")
     {
      result = decimal_before + "." + create;
     }
   else
     {
      result = decimal_before;
     }

   if(debug)
      Print(" FINAL RESULT " + result);
   return(result);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Converts a hex string into a string and char array               |
//+------------------------------------------------------------------+
string hexStringToCharArray(string hex,uchar &decode[])
  {
   if(MathMod(StringLen(hex),2)!=0)
      return NULL;
   uchar array[];
   int result[];
   uchar A[],Zero[];
   int n=0;
   StringToCharArray("A",A);
   StringToCharArray("0",Zero);
   StringToCharArray(hex,array);
   int sizeArray=ArraySize(array);
   ArrayResize(result,sizeArray);
   ArrayResize(decode,((sizeArray-1)/2));
   for(int i=0; i<sizeArray; i++)
     {
      if(MathMod(i,2)==0)
        {
         if(array[i]>=A[0])
            result[i]=(array[i]-A[0]+10)*16;
         else
            result[i]=(array[i]-Zero[0])*16;
        }
      else
        {
         if(array[i]>=A[0])
            result[i]=(array[i]-A[0]+10);
         else
            result[i]=(array[i]-Zero[0]);
         decode[n]=(uchar)(result[i-1]+result[i]);
         n++;
        }
     }
   return CharArrayToString(decode);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+

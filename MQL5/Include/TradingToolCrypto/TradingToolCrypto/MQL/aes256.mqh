//+------------------------------------------------------------------+
//|                                                       Bcrypt.mqh |
//|                                    Copyright 2015, Romeu Bertho. |
//|                         https://login.mql5.com/en/users/c4b3l3r4 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, Romeu Bertho."
#property link      "https://login.mql5.com/en/users/c4b3l3r4"
#property version   "1.2"
#include "Object.mqh"
//+------------------------------------------------------------------+
//| Class CBcrypt.                                                   |
//| Appointment: Class encryption operations with AES-256.           |
//|              Derives from class CObject.                         |
//+------------------------------------------------------------------+
class CBcrypt : public CObject
  {
protected:
   string            m_key_p; // Primary key
   string            m_key_s; // Secondary key
   uchar             m_key_m[]; // Master Key
   string            m_data; // String data
   uchar             m_udata[]; // Uchar data array

public:
                     CBcrypt();
                    ~CBcrypt();
   void              Init(const string primary_key,const string secondary_key=NULL,const string text=NULL);
   void              InitDefault();
   void              SetData(const string data);
   string            Encrypt();
   string            Decrypt(string hexData);

protected:
   void              GenerateKey();
   string            ArrayToHex(uchar &arr[],int count=-1);
   string            HexToString(string hex,uchar &decode[]);

  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CBcrypt::CBcrypt(void) : m_key_p(""),
                         m_key_s(""),
                         m_data("")
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CBcrypt::~CBcrypt()
  {
  }
//+------------------------------------------------------------------+
//| Encrypt data                                                     |
//+------------------------------------------------------------------+
string CBcrypt::Encrypt(void)
  {
   uchar dst[];
   int res=CryptEncode(CRYPT_AES256,m_udata,m_key_m,dst);
   if(res>0)
      return ArrayToHex(dst);
   return "-1,error";
  }
//+------------------------------------------------------------------+
//| Decrypt AES-256 data                                             |
//+------------------------------------------------------------------+
string CBcrypt::Decrypt(string hexData)
  {
   uchar decodedHex[],src[];
   HexToString(hexData,decodedHex);
   int res=CryptDecode(CRYPT_AES256,decodedHex,m_key_m,src);
   if(res>0)
      return CharArrayToString(src);
   return "-1,error";
  }
//+------------------------------------------------------------------+
//| Set the Key(s) and text to be encrypted later on                 |
//| or                                                               |
//| Set only the key(s) to decrypt some data later on                |
//+------------------------------------------------------------------+
void CBcrypt::Init(const string primary_key=NULL,const string secondary_key=NULL,const string text=NULL)
  {
   m_key_p=primary_key;
   m_key_s=secondary_key;
   m_data=text;
   StringToCharArray(m_data,m_udata);
   GenerateKey();
  }
//+------------------------------------------------------------------+
//| Set default keys                                                 |
//+------------------------------------------------------------------+
void CBcrypt::InitDefault(void)
  {
  //--- default primary key
   m_key_p="7E846B635877D53A2BD51B320D9453407E8F4C22C104E1E9481783A50FADD162";
   //--- default secondary key
   m_key_s=(string)AccountInfoInteger(ACCOUNT_LOGIN);
   GenerateKey();
  }
//+------------------------------------------------------------------+
//| Set text to be encrypted later on                                |
//+------------------------------------------------------------------+
void CBcrypt::SetData(const string text)
  {
   m_data=text;
   StringToCharArray(m_data,m_udata);
  }
//+------------------------------------------------------------------+
//| Generate the key of encryption                                   |
//+------------------------------------------------------------------+
void CBcrypt::GenerateKey(void)
  {
  //--- if primary key is null
   if(m_key_p==NULL)
     {
      PrintFormat("Primary key must be different than NULL");
      return;
     }
     //--- if secondary key is null
   if(m_key_s==NULL)
      StringToCharArray(m_key_p,m_key_m);
      //--- otherwise
   else if(m_key_p!=NULL && m_key_s!=NULL)
     {
      string key_temp=m_key_s;
      int ok=StringReplace(key_temp," ",m_key_p);
      if(ok>0)
         StringToCharArray(key_temp,m_key_m);
      if(ok<=0)
         key_temp=m_key_s+m_key_p;
      StringToCharArray(key_temp,m_key_m);
     }
  }
//+------------------------------------------------------------------+
//| Converts a char array into a hex string                          |
//+------------------------------------------------------------------+
string CBcrypt::ArrayToHex(uchar &arr[],int count=-1)
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
//+------------------------------------------------------------------+
//| Converts a hex string into a string and char array               |
//+------------------------------------------------------------------+
string CBcrypt::HexToString(string hex,uchar &decode[])
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
   for(int i=0;i<sizeArray;i++)
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

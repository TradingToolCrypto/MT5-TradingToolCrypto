//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, TradingToolCrypto Corp"
#property link "https://github.com/TradingToolCrypto"

// Open Web Browser for payment processing
#import "shell32.dll"
int ShellExecuteW(int hWnd, string Verb, string File, string Parameter, string Path, int ShowCmd);
#import
bool Shell(string file, string parameters = "")
  {
#define DEFDIRECTORY NULL
#define OPERATION "open" // or print
#define SW_SHOWNORMAL 1
   int r = ShellExecuteW(0, OPERATION, file, parameters, DEFDIRECTORY, SW_SHOWNORMAL);
   if(r > 32)
      return (true);
// Alert("Shell failed: ",r);
   return (false);
  }

const string URL_BASE = "https://api.nowpayments.io/v1"; // https://api.nowpayments.io/v1/invoice
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool openURL(string url)
  {
   string file = "Google" + ".URL";
   int handle = FileOpen(file, FILE_CSV | FILE_WRITE, '~');
   if(handle < 1)
     {
      int GLE = GetLastError();
      Print("Last Error Code: " + (string)GLE);
      ResetLastError();
     }
   FileWrite(handle, "[InternetShortcut]");
   FileWrite(handle, "URL=" + url);
   FileClose(handle);
   return (Shell(TerminalInfoString(TERMINAL_DATA_PATH) + "\\MQL5\\Files\\" + file)); // or "cmd.exe", "/C "+file
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string nowpayments_tx_status(string payment_id, string header)
  {

   string server_string = "";
   char body_char[];
   char result_char[];
   string result_headers;
   const string headers = header;
   string url = URL_BASE + "/payment/" + payment_id;

   Print("tx status request url " + url);

// WEBREQUEST CALL
   int res = WebRequest("GET", url, headers, 15000, body_char, result_char, result_headers);
   if(res == -1)
     {
      Print("ERROR" + IntegerToString(GetLastError()));
      return ("false");
     }
   else
     {

      Print("NowPayments.io Request code: " + IntegerToString(res));
      server_string = CharArrayToString(result_char, 0, WHOLE_ARRAY);
      Print("NowPayments.io Request: " + server_string);
      return (server_string);
     }
   return ("");
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string nowpayments_make_invoice(double amount, string id, string header)
  {

   string server_string = "";
   char body_char[];
   char result_char[];
   string result_headers;
   const string headers = header;
   string url = URL_BASE + "/invoice"; // https://api.nowpayments.io/v1/invoice

   string body = "";

   string data_filter_1 = "{\"price_amount\":\"" + DoubleToString(amount, 2) + "\",";
   string data_filter_2 = "\"price_currency\":\"usd\",";
   string data_filter_3 = "\"order_id\":\"" + id + "\",";
   string data_filter_4 = "\"order_description\":\"TTC-Membership\",";
   string data_filter_5 = "\"cancel_url\":\"https://ttc.box\"}";

   body = data_filter_1 + data_filter_2 + data_filter_3 + data_filter_4 + data_filter_5;

   /*
     `{
   "price_amount": 1000,
   "price_currency": "usd",
   "order_id": "RGDBP-21314",
   "order_description": "Apple Macbook Pro 2019 x 1",
   "ipn_callback_url": "https://nowpayments.io",
   "success_url": "https://nowpayments.io",
   "cancel_url": "https://nowpayments.io"
   }`

   */

   Print("u: " + url);
   Print("h: " + headers);
   Print("b: " + body);

   StringToCharArray(body, body_char, 0, WHOLE_ARRAY, CP_UTF8);
   ArrayResize(body_char, ArraySize(body_char) - 1);

// WEBREQUEST CALL
   int res = WebRequest("POST", url, headers, 15000, body_char, result_char, result_headers);

   if(res == -1)
     {
      Print("ERROR" + IntegerToString(GetLastError()));
      return ("false");
     }
   else
     {
      Print("Bitmex OpenOrders Request code: " + IntegerToString(res));
      server_string = CharArrayToString(result_char, 0, WHOLE_ARRAY);
      Print("Bitmex OpenOrders Request: " + server_string);

      return (server_string);
     }

   return ("");
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string make_headers(string api_key)
  {
   string headers;
// static
   headers += "Content-Type: application/json";
   headers += "\r\nx-api-key: " + api_key;

   return (headers);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string build_help_command()
  {

   const string list =

      "\n/email <your@email.com>" +
      "\n/coin_list" +
      "\n/confirmpayment" +

      "\n/start";

   return (list);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string build_start_command()
  {

   const string welcome = "Welcome to our payment bot powered by CoinPayments.net" +
                          "\n\nWe have a few different services in the works. Please select your interest";

   return (welcome);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string build_service_1()
  {
   const string welcome = "This bot will collect your email address, generate an invoice and allow you confirm your payment." +
                          "\n\nOnce your payment is confirmed you will get an invite link to join the channel and group" +
                          "\n\nStep 1 - enter this command /email with your email after the command such as\n\n/email my@email.com";
   return (welcome);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string build_service_2()
  {
   const string welcome = "This bot will collect your email address, generate an invoice and allow you confirm your payment." +
                          "\n\nOnce your payment is confirmed you will get an invite link to join the channel and group" +
                          "\n\nStep 1 - enter this command /email with your email after the command such as\n\n/email my@email.com";
   return (welcome);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string build_service_3()
  {
   const string welcome = "This bot will collect your email address, generate an invoice and allow you confirm your payment." +
                          "\n\nOnce your payment is confirmed you will get an invite link to join the channel and group" +
                          "\n\nStep 1 - enter this command /email with your email after the command such as\n\n/email my@email.com";
   return (welcome);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string build_service_4()
  {
   const string welcome = "This bot will collect your email address, generate an invoice and allow you confirm your payment." +
                          "\n\nOnce your payment is confirmed you will get an invite link to join the channel and group" +
                          "\n\nStep 1 - enter this command /email with your email after the command such as\n\n/email my@email.com";
   return (welcome);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string build_service_5()
  {
   const string welcome = "This bot will collect your email address, generate an invoice and allow you confirm your payment." +
                          "\n\nOnce your payment is confirmed you will get an invite link to join the channel and group" +
                          "\n\nStep 1 - enter this command /email with your email after the command such as\n\n/email my@email.com";
   return (welcome);
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string service_paid_1(string tx_id)
  {
   string payment = "Payment Recieved for TX ID (" + tx_id + ")";

   return (payment);
  }

//+------------------------------------------------------------------+

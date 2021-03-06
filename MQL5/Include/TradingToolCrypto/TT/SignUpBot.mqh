//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, TradingToolCrypto Corp"
#property link "https://github.com/TradingToolCrypto"

input string Service_Command_1 = "Annual";
input string Service_Command_2 = "Monthly";
input string Service_Command_3 = "Daily";
input string Service_Command_4 = "";
input string Service_Command_5 = "";

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string build_help_command()
  {

   const string list =

      "\n/" + Service_Command_1 +
      "\n/" + Service_Command_2 +
      "\n/" + Service_Command_3 +
      "\n/" + Service_Command_4 +
      "\n/" + Service_Command_5 +


      "\n/email <your@email.com>" +
      "\n/coin_list" +
      "\n/confirmpayment" +

      "\n/start";

   return(list);

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string build_start_command()
  {

   const string welcome = "Welcome to our payment bot powered by CoinPayments.net" +
                          "\n\nWe have a few different services in the works. Please select your interest" +
                          "\n/" + Service_Command_1 +
                          "\n/" + Service_Command_2 +
                          "\n/" + Service_Command_3 +
                          "\n/" + Service_Command_4 +
                          "\n/" + Service_Command_5;

   return(welcome);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string build_service_1()
  {
   const string welcome = "This bot will collect your email address, generate an invoice and allow you confirm your payment."+
                          "\n\nOnce your payment is confirmed you will get an invite link to join the channel and group" +
                          "\n\nStep 1 - enter this command /email with your email after the command such as\n\n/email my@email.com";
   return(welcome);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string build_service_2()
  {
   const string welcome = "This bot will collect your email address, generate an invoice and allow you confirm your payment."+
                          "\n\nOnce your payment is confirmed you will get an invite link to join the channel and group" +
                          "\n\nStep 1 - enter this command /email with your email after the command such as\n\n/email my@email.com";
   return(welcome);

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string build_service_3()
  {
   const string welcome = "This bot will collect your email address, generate an invoice and allow you confirm your payment."+
                          "\n\nOnce your payment is confirmed you will get an invite link to join the channel and group" +
                          "\n\nStep 1 - enter this command /email with your email after the command such as\n\n/email my@email.com";
   return(welcome);

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string build_service_4()
  {
   const string welcome = "This bot will collect your email address, generate an invoice and allow you confirm your payment."+
                          "\n\nOnce your payment is confirmed you will get an invite link to join the channel and group" +
                          "\n\nStep 1 - enter this command /email with your email after the command such as\n\n/email my@email.com";
   return(welcome);

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string build_service_5()
  {
   const string welcome = "This bot will collect your email address, generate an invoice and allow you confirm your payment."+
                          "\n\nOnce your payment is confirmed you will get an invite link to join the channel and group" +
                          "\n\nStep 1 - enter this command /email with your email after the command such as\n\n/email my@email.com";
   return(welcome);

  }
//+------------------------------------------------------------------+

input string Channel_Invite = "";
input string Group_Invite = "";

string service_paid_1(string tx_id)
  {
   string payment = "Payment Recieved for TX ID (" + tx_id + ")" +
                  "\n Channel Invite link : " + Channel_Invite + 
                  "\n Group Invite Link : " + Group_Invite + 
                  "\n Welcome Aboard";
   return(payment);

  }
  
  string service_paid_2(string tx_id)
  {
   string payment = "Payment Recieved for TX ID (" + tx_id + ")" +
                  "\n Channel Invite link : " + Channel_Invite + 
                  "\n Group Invite Link : " + Group_Invite + 
                  "\n Welcome Aboard";
   return(payment);

  }
  
  string service_paid_3(string tx_id)
  {
   string payment = "Payment Recieved for TX ID (" + tx_id + ")" +
                  "\n Channel Invite link : " + Channel_Invite + 
                  "\n Group Invite Link : " + Group_Invite + 
                  "\n Welcome Aboard";
   return(payment);

  }
  
  string service_paid_4(string tx_id)
  {
   string payment = "Payment Recieved for TX ID (" + tx_id + ")" +
                  "\n Channel Invite link : " + Channel_Invite + 
                  "\n Group Invite Link : " + Group_Invite + 
                  "\n Welcome Aboard";
   return(payment);

  }
  
  string service_paid_5(string tx_id)
  {
   string payment = "Payment Recieved for TX ID (" + tx_id + ")" +
                  "\n Channel Invite link : " + Channel_Invite + 
                  "\n Group Invite Link : " + Group_Invite + 
                  "\n Welcome Aboard";
   return(payment);

  }
  
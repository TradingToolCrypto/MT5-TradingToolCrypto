bool timer_trigger_1 = false;
bool timer_trigger_2 = false;
bool timer_trigger_3 = false;
bool timer_trigger_4 = false;
bool timer_trigger_5 = false;
bool timer_trigger_6 = false;
bool timer_trigger_7 = false;
bool timer_trigger_8 = false;
bool timer_trigger_9 = false;
bool timer_trigger_10 = false;

void timer_reset(){
 timer_trigger_1 = false;
 timer_trigger_2 = false;
 timer_trigger_3 = false;
 timer_trigger_4 = false;
 timer_trigger_5 = false;
 timer_trigger_6 = false;
 timer_trigger_7 = false;
 timer_trigger_8 = false;
 timer_trigger_9 = false;
 timer_trigger_10 = false;

}


bool next_request(int microsecond, string loopname){
   // timer 
   const ulong now = GetMicrosecondCount();
   static ulong last_time = 0;
   
   if(now > last_time){
      last_time = now + microsecond;
     // Print("loop request now " + now + " Loopname " + loopname );
      return(true);
   }
   return(false);
}


bool next_request_1(int microsecond, string loopname){
   // timer 
   const ulong now = GetMicrosecondCount();
   static ulong last_time = 0;
   
   if(now > last_time){
      last_time = now + microsecond;
     // Print("loop request now " + now + " Loopname " + loopname );
      return(true);
   }
   return(false);
}


bool next_request_2(int microsecond, string loopname){
   // timer 
   const ulong now = GetMicrosecondCount();
   static ulong last_time = 0;
   
   if(now > last_time){
      last_time = now + microsecond;
    //  Print("loop request now " + now + " Loopname " + loopname );
      return(true);
   }
   return(false);
}

bool next_request_3(int microsecond, string loopname){
   // timer 
   const ulong now = GetMicrosecondCount();
   static ulong last_time = 0;
   
   if(now > last_time){
      last_time = now + microsecond;
    //  Print("loop request now " + now + " Loopname " + loopname );
      return(true);
   }
   return(false);
}

bool next_request_4(int microsecond, string loopname){
   // timer 
   const ulong now = GetMicrosecondCount();
   static ulong last_time = 0;
   
   if(now > last_time){
      last_time = now + microsecond;
   //   Print("loop request now " + now + " Loopname " + loopname );
      return(true);
   }
   return(false);
}
bool next_request_5(int microsecond, string loopname){
   // timer 
   const ulong now = GetMicrosecondCount();
   static ulong last_time = 0;
   
   if(now > last_time){
      last_time = now + microsecond;
    //  Print("loop request now " + now + " Loopname " + loopname );
      return(true);
   }
   return(false);
}
bool next_request_6(int microsecond, string loopname){
   // timer 
   const ulong now = GetMicrosecondCount();
   static ulong last_time = 0;
   
   if(now > last_time){
      last_time = now + microsecond;
   //   Print("loop request now " + now + " Loopname " + loopname );
      return(true);
   }
   return(false);
}
bool next_request_7(int microsecond, string loopname){
   // timer 
   const ulong now = GetMicrosecondCount();
   static ulong last_time = 0;
   
   if(now > last_time){
      last_time = now + microsecond;
   //   Print("loop request now " + now + " Loopname " + loopname );
      return(true);
   }
   return(false);
}
bool next_request_8(int microsecond, string loopname){
   // timer 
   const ulong now = GetMicrosecondCount();
   static ulong last_time = 0;
   
   if(now > last_time){
      last_time = now + microsecond;
    //  Print("loop request now " + now + " Loopname " + loopname );
      return(true);
   }
   return(false);
}
bool next_request_9(int microsecond, string loopname){
   // timer 
   const ulong now = GetMicrosecondCount();
   static ulong last_time = 0;
   
   if(now > last_time){
      last_time = now + microsecond;
   //   Print("loop request now " + now + " Loopname " + loopname );
      return(true);
   }
   return(false);
}
bool next_request_10(int microsecond, string loopname){
   // timer 
   const ulong now = GetMicrosecondCount();
   static ulong last_time = 0;
   
   if(now > last_time){
      last_time = now + microsecond;
   //   Print("loop request now " + now + " Loopname " + loopname );
      return(true);
   }
   return(false);
}
bool next_request_11(int microsecond, string loopname){
   // timer 
   const ulong now = GetMicrosecondCount();
   static ulong last_time = 0;
   
   if(now > last_time){
      last_time = now + microsecond;
   //   Print("loop request now " + now + " Loopname " + loopname );
      return(true);
   }
   return(false);
}
bool next_request_12(int microsecond, string loopname){
   // timer 
   const ulong now = GetMicrosecondCount();
   static ulong last_time = 0;
   
   if(now > last_time){
      last_time = now + microsecond;
  //    Print("loop request now " + now + " Loopname " + loopname );
      return(true);
   }
   return(false);
}
bool next_request_13(int microsecond, string loopname){
   // timer 
   const ulong now = GetMicrosecondCount();
   static ulong last_time = 0;
   
   if(now > last_time){
      last_time = now + microsecond;
  //    Print("loop request now " + now + " Loopname " + loopname );
      return(true);
   }
   return(false);
}
bool next_request_14(int microsecond, string loopname){
   // timer 
   const ulong now = GetMicrosecondCount();
   static ulong last_time = 0;
   
   if(now > last_time){
      last_time = now + microsecond;
   //   Print("loop request now " + now + " Loopname " + loopname );
      return(true);
   }
   return(false);
}
bool next_request_15(int microsecond, string loopname){
   // timer 
   const ulong now = GetMicrosecondCount();
   static ulong last_time = 0;
   
   if(now > last_time){
      last_time = now + microsecond;
   //   Print("loop request now " + now + " Loopname " + loopname );
      return(true);
   }
   return(false);
}
bool next_request_16(int microsecond, string loopname){
   // timer 
   const ulong now = GetMicrosecondCount();
   static ulong last_time = 0;
   
   if(now > last_time){
      last_time = now + microsecond;
   //   Print("loop request now " + now + " Loopname " + loopname );
      return(true);
   }
   return(false);
}
bool next_request_17(int microsecond, string loopname){
   // timer 
   const ulong now = GetMicrosecondCount();
   static ulong last_time = 0;
   
   if(now > last_time){
      last_time = now + microsecond;
   //   Print("loop request now " + now + " Loopname " + loopname );
      return(true);
   }
   return(false);
}
bool next_request_18(int microsecond, string loopname){
   // timer 
   const ulong now = GetMicrosecondCount();
   static ulong last_time = 0;
   
   if(now > last_time){
      last_time = now + microsecond;
   //   Print("loop request now " + now + " Loopname " + loopname );
      return(true);
   }
   return(false);
}
bool next_request_19(int microsecond, string loopname){
   // timer 
   const ulong now = GetMicrosecondCount();
   static ulong last_time = 0;
   
   if(now > last_time){
      last_time = now + microsecond;
   //   Print("loop request now " + now + " Loopname " + loopname );
      return(true);
   }
   return(false);
}
bool next_request_20(int microsecond, string loopname){
   // timer 
   const ulong now = GetMicrosecondCount();
   static ulong last_time = 0;
   
   if(now > last_time){
      last_time = now + microsecond;
   //   Print("loop request now " + now + " Loopname " + loopname );
      return(true);
   }
   return(false);
}
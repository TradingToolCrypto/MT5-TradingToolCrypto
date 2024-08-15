//+------------------------------------------------------------------+
//|                                       [branched from] Symbol.mqh |
//|                               https://www.mql5.com/en/code/18855 |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class SYMBOL
{
public:
   const string Name;

   SYMBOL( const string Symb = NULL, const string Path = NULL ) : Name((Symb == NULL) ? _Symbol : Symb)
   {
      if (!SYMBOL::SymbolIsExist(this.Name))
         ::CustomSymbolCreate(this.Name, Path);
   }

   static bool SymbolIsExist( const string Symb = NULL )
   {
      ::ResetLastError();

      ::SymbolInfoInteger((Symb == NULL) ? _Symbol : Symb, SYMBOL_CUSTOM);

      return(::GetLastError() != ERR_MARKET_UNKNOWN_SYMBOL);
   }

   bool SetProperty( const ENUM_SYMBOL_INFO_DOUBLE Property, double Value ) const
   {
      return(::CustomSymbolSetDouble(this.Name, Property, Value));
   }

   bool SetProperty( const ENUM_SYMBOL_INFO_INTEGER Property, long Value ) const
   {
      return(::CustomSymbolSetInteger(this.Name, Property, Value));
   }

   bool SetProperty( const ENUM_SYMBOL_INFO_STRING Property, string Value ) const
   {
      return(::CustomSymbolSetString(this.Name, Property, Value));
   }

   long GetProperty( const ENUM_SYMBOL_INFO_INTEGER Property ) const
   {
      return(::SymbolInfoInteger(this.Name, Property));
   }

   double GetProperty( const ENUM_SYMBOL_INFO_DOUBLE Property ) const
   {
      return(::SymbolInfoDouble(this.Name, Property));
   }

   string GetProperty( const ENUM_SYMBOL_INFO_STRING Property ) const
   {
      return(::SymbolInfoString(this.Name, Property));
   }

   bool Delete( void ) const
   {
      return(this.IsCustom() && this.Off() && ::CustomSymbolDelete(this.Name));
   }

#define CLONE(A) this.SetProperty(A, Source.GetProperty(A))

   bool CloneProperties( const string Symb = NULL ) const
   {
      const SYMBOL Source(Symb);

      return(SYMBOL::SymbolIsExist(Symb) && this.IsCustom() &&
             CLONE(SYMBOL_BASIS) &&
             CLONE(SYMBOL_CURRENCY_BASE) &&
             CLONE(SYMBOL_CURRENCY_MARGIN) &&
             CLONE(SYMBOL_CURRENCY_PROFIT) &&
             CLONE(SYMBOL_DESCRIPTION) &&
             CLONE(SYMBOL_FORMULA) &&
             CLONE(SYMBOL_ISIN) &&
             CLONE(SYMBOL_PAGE) &&
             CLONE(SYMBOL_PATH) &&

             CLONE(SYMBOL_MARGIN_HEDGED) &&
             CLONE(SYMBOL_MARGIN_INITIAL) &&
             CLONE(SYMBOL_MARGIN_MAINTENANCE) &&
             CLONE(SYMBOL_OPTION_STRIKE) &&
             CLONE(SYMBOL_POINT) &&
             CLONE(SYMBOL_SESSION_PRICE_LIMIT_MAX) &&
             CLONE(SYMBOL_SESSION_PRICE_LIMIT_MIN) &&
             CLONE(SYMBOL_SESSION_PRICE_SETTLEMENT) &&
             CLONE(SYMBOL_SWAP_LONG) &&
             CLONE(SYMBOL_SWAP_SHORT) &&
             CLONE(SYMBOL_TRADE_ACCRUED_INTEREST) &&
             CLONE(SYMBOL_TRADE_CONTRACT_SIZE) &&
             CLONE(SYMBOL_TRADE_FACE_VALUE) &&
             CLONE(SYMBOL_TRADE_LIQUIDITY_RATE) &&
             CLONE(SYMBOL_TRADE_TICK_SIZE) &&
             CLONE(SYMBOL_TRADE_TICK_VALUE) &&
             CLONE(SYMBOL_VOLUME_LIMIT) &&
             CLONE(SYMBOL_VOLUME_MAX) &&
             CLONE(SYMBOL_VOLUME_MIN) &&
             CLONE(SYMBOL_VOLUME_STEP) &&

             CLONE(SYMBOL_BACKGROUND_COLOR) &&
             CLONE(SYMBOL_CHART_MODE) &&
             CLONE(SYMBOL_DIGITS) &&
             CLONE(SYMBOL_EXPIRATION_MODE) &&
             CLONE(SYMBOL_EXPIRATION_TIME) &&
             CLONE(SYMBOL_FILLING_MODE) &&
             CLONE(SYMBOL_MARGIN_HEDGED_USE_LEG) &&
             CLONE(SYMBOL_OPTION_MODE) &&
             CLONE(SYMBOL_OPTION_RIGHT) &&
             CLONE(SYMBOL_ORDER_GTC_MODE) &&
             CLONE(SYMBOL_ORDER_MODE) &&
             CLONE(SYMBOL_SPREAD) &&
             CLONE(SYMBOL_SPREAD_FLOAT) &&
             CLONE(SYMBOL_START_TIME) &&
             CLONE(SYMBOL_SWAP_MODE) &&
             CLONE(SYMBOL_SWAP_ROLLOVER3DAYS) &&
             CLONE(SYMBOL_TICKS_BOOKDEPTH) &&
             CLONE(SYMBOL_TRADE_CALC_MODE) &&
             CLONE(SYMBOL_TRADE_EXEMODE) &&
             CLONE(SYMBOL_TRADE_FREEZE_LEVEL) &&
             CLONE(SYMBOL_TRADE_MODE) &&
             CLONE(SYMBOL_TRADE_STOPS_LEVEL));
   }

#undef CLONE

   int CloneHistory( string Symb = NULL ) const
   {
      return(::MathMax(this.CloneRates(Symb), this.CloneTicks(Symb)));
   }

   int CloneRates( const MqlRates &Rates[] ) const
   {
      return(this.IsCustom() ? ::CustomRatesReplace(this.Name, 0, LONG_MAX, Rates) : -1);
   }

   int CloneRates( string Symb = NULL ) const
   {
      int Res = this.IsCustom() && SYMBOL::SymbolIsExist(Symb) ? 0 : -1;

      if (Res != -1) {
         Symb = (Symb == NULL) ? _Symbol : Symb;
         MqlRates Rates[];

         ::CopyRates(Symb, PERIOD_M1, 0, (int)::SeriesInfoInteger(Symb, PERIOD_M1, SERIES_BARS_COUNT), Rates);

         Res = this.CloneRates(Rates);
      }

      return(Res);
   }

   int CloneTicks( const MqlTick &Ticks[] ) const
   {
      return(this.IsCustom() ? ::CustomTicksReplace(this.Name, 0, LONG_MAX, Ticks) : -1);
   }

   int CloneTicks( string Symb = NULL ) const
   {
      Symb = (Symb == NULL) ? _Symbol : Symb;

      int Res = this.IsCustom() && ::SymbolInfoInteger(Symb, SYMBOL_CUSTOM) ? 0 : -1;

      if (Res != -1) {
         MqlTick Ticks[];

         ::CopyTicksRange(Symb, Ticks, COPY_TICKS_ALL, 0, LONG_MAX);

         Res = this.CloneTicks(Ticks);
      }

      return(Res);
   }

   bool Clone( const string Symb = NULL ) const
   {
      return(this.CloneProperties(Symb) && (this.CloneHistory(Symb) != -1));
   }

   virtual bool operator =( const string Symb ) const
   {
      return(this.Clone(Symb));
   }

   bool On( void ) const
   {
      return(::SymbolSelect(this.Name, true));
   }

   bool Off( void ) const
   {
      return(::SymbolSelect(this.Name, false));
   }

   bool IsCustom( void ) const
   {
      return(this.GetProperty(SYMBOL_CUSTOM));
   }

   bool IsExist( void ) const
   {
      return(SYMBOL::SymbolIsExist(this.Name));
   }
};
//+------------------------------------------------------------------+

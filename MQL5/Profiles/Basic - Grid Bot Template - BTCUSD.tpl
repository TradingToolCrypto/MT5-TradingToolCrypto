<chart>
id=132151136142034575
symbol=BTCUSD
description=Bitcoin vs US Dollar
period_type=0
period_size=1
digits=0
tick_size=0.000000
position_time=1601812800
scale_fix=0
scale_fixed_min=37543.958442
scale_fixed_max=38890.083117
scale_fix11=0
scale_bar=0
scale_bar_val=1.000000
scale=4
mode=1
fore=0
grid=0
volume=0
scroll=1
shift=1
shift_size=19.956379
fixed_pos=0.000000
ticker=1
ohlc=0
one_click=0
one_click_btn=1
bidline=1
askline=1
lastline=0
days=0
descriptions=0
tradelines=1
tradehistory=0
window_left=367
window_top=0
window_right=734
window_bottom=521
window_type=3
floating=0
floating_left=0
floating_top=0
floating_right=0
floating_bottom=0
floating_type=1
floating_toolbar=1
floating_tbstate=
background_color=0
foreground_color=16777215
barup_color=16777215
bardown_color=16760576
bullcandle_color=16777215
bearcandle_color=16760576
chartline_color=65535
volumes_color=3329330
grid_color=986895
bidline_color=64636
askline_color=3937500
lastline_color=49152
stops_color=255
windows_total=2

<expert>
name=Grid_v10
path=Experts\TTC\Grid_v10.ex5
expertmode=5
<inputs>
PLEASE_ADJUST_BB_STATEGY=------------------------------------
MA_PERIOD_A=20
MA_TYPE=1
MA_DATA_TYPE=5
MA_DEVIATION=2
MA_BAR_SHIFT=0
PLEASE_ADJUST_EMA_STATEGY=------------------------------------
EMA_PERIOD_A=50
EMA_PERIOD_B=100
EMA_TYPE=1
EMA_DATA_TYPE=1
EMA_BAR_SHIFT=0
EMASPREAD_BUY=-0.6
EMASPREAD_SELL=0.6
PLEASE_ADJUST_RSI_STATEGY=------------------------------------
RSI_PERIOD_A=14
RSI_DATA_TYPE=1
RSI_BUY=20
RSI_SELL=80
PLEASE_SELECT_STATEGY=------------------------------------
SelectStrategy_BUY=1
SelectStrategy_SELL=2
PLEASE_ADJUST_ROBOT=------------------------------------
INTRODUCTION_0=Non Aggressive Dollar Cost Averaging robot
INTRODUCTION_1=Scale in/out of positions for rebates(bitmex/bybit)
text_1=Minimum Volume Size 
Order_Buy_Volume=0.1
Order_Sell_Volume=0.1
text_1_1=Martingale
Martingale_Expo=2
text_2=Cumulative Maximum OrderVolume 
text_2_1=if you only want to enter one layer (Times your Order_Level value by Order_Volume value) = Max 
text_2_2=Only Buy? Order_Sell_Volume_Max = 0 | Only Sell? Order_Buy_Volume_Max = 0
Order_Buy_Volume_Max=1
Order_Sell_Volume_Max=1
text_3=Distance between orders
text_3_1=Not pips or points but in BASE CURRENCY
text_3_2=Forex EURUSD 0.0010 = 10 pips
text_3_3=Forex GPBPJPY 0.10 = 10 pips
Order_Buy_Space=30
Order_Sell_Space=20
text_4=Distance from the bid/ask price to place the first order
text_4_1=Not pips or points but in BASE CURRENCY
text_4_2=Forex EURUSD 0.0010 = 10 pips
text_4_3=Forex GPBPJPY 0.10 = 10 pips
Order_Buy_Offset=10
Order_Sell_Offset=10
text_5=How many orders to place on each side (long/short)
Order_Buy_Level=6
Order_Sell_Level=6
text_6=If you want to Create a New layer, change the Order_Comment
Order_Comment=Grid Layer
UpdateSpeed_In_Seconds=30
</inputs>
</expert>

<window>
height=110.804020
objects=0

<indicator>
name=Main
path=
apply=1
show_data=1
scale_inherit=0
scale_line=0
scale_line_percent=50
scale_line_value=0.000000
scale_fix_min=0
scale_fix_min_val=0.000000
scale_fix_max=0
scale_fix_max_val=0.000000
expertmode=0
fixed_height=-1
</indicator>

<indicator>
name=Bollinger Bands
path=
apply=1
show_data=1
scale_inherit=0
scale_line=0
scale_line_percent=50
scale_line_value=0.000000
scale_fix_min=0
scale_fix_min_val=0.000000
scale_fix_max=0
scale_fix_max_val=0.000000
expertmode=0
fixed_height=-1

<graph>
name=
draw=131
style=0
width=1
color=7451452
</graph>

<graph>
name=
draw=131
style=0
width=1
color=7451452
</graph>

<graph>
name=
draw=131
style=0
width=1
color=7451452
</graph>
period=20
deviation=2.000000
</indicator>

<indicator>
name=Moving Average
path=
apply=1
show_data=1
scale_inherit=0
scale_line=0
scale_line_percent=50
scale_line_value=0.000000
scale_fix_min=0
scale_fix_min_val=0.000000
scale_fix_max=0
scale_fix_max_val=0.000000
expertmode=0
fixed_height=-1

<graph>
name=
draw=129
style=0
width=2
color=8421504
</graph>
period=50
method=0
</indicator>

<indicator>
name=Moving Average
path=
apply=1
show_data=1
scale_inherit=0
scale_line=0
scale_line_percent=50
scale_line_value=0.000000
scale_fix_min=0
scale_fix_min_val=0.000000
scale_fix_max=0
scale_fix_max_val=0.000000
expertmode=0
fixed_height=-1

<graph>
name=
draw=129
style=0
width=3
color=8421504
</graph>
period=100
method=0
</indicator>
</window>

<window>
height=50.000000
objects=0

<indicator>
name=Relative Strength Index
path=
apply=1
show_data=1
scale_inherit=0
scale_line=0
scale_line_percent=50
scale_line_value=0.000000
scale_fix_min=1
scale_fix_min_val=0.000000
scale_fix_max=1
scale_fix_max_val=100.000000
expertmode=0
fixed_height=-1

<graph>
name=
draw=1
style=0
width=1
color=16748574
</graph>

<level>
level=20.000000
style=2
color=12632256
width=1
descr=
</level>

<level>
level=80.000000
style=2
color=12632256
width=1
descr=
</level>
period=14
</indicator>
</window>
</chart>
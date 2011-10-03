FHADRSY ; HISC/NCA - Purge Old Annual Dietetic Data ;4/25/95  12:47
 ;;5.5;DIETETICS;;Jan 28, 2005
EN1 ; Purge Data Older than three years
 S X="T-1095",%DT="X" D ^%DT S EDT=$E(+Y,1,3)_"0500"
 S FLG=0 F QTR=1:1:4 S PRE=$E(EDT,1,4)_QTR_"00" I $D(^FH(117.3,"B",PRE,PRE)) S FLG=1 Q
 I 'FLG W !!,"Already Purged to ",$E(EDT,2,3) G KIL
D1 W !!,"Purge To The Year: ",$E(EDT,2,3)," // " R X:DTIME G:'$T!(X="^") KIL G:X="" D2 S %DT="E" D ^%DT G:U[X!$D(DTOUT) KIL G:Y<1 D1
 S Y=$E(+Y,1,3)_"0000" I Y>EDT W *7,!!,"CANNOT PURGE TO YEAR THAT IS GREATER THAN THE DEFAULT!" G D1
 S EDT=+Y
D2 F PRE=0:0 S PRE=$O(^FH(117.3,PRE)) Q:PRE'<EDT  D K0
 W !!,"... Done"
KIL G KILL^XUSCLEAN
K0 K ^FH(117.3,PRE),^FH(117.3,"B",PRE,PRE) Q

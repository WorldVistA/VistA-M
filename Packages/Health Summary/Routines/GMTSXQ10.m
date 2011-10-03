GMTSXQ10 ; SLC/JER - XQORM4 for Export w/Health Summary ;1/10/92  15:06
 ;;2.5;Health Summary;;Dec 16, 1992
XQORM4 ; SLC/KCM - Menu Messages ;10/19/90  14:31 ;
 ;;6.52;Copyright 1990, DVA;
HELP ;From: XQORM1
 Q:XQORM(0)'["A"
 I $D(XQORM("??")) X:$L(XQORM("??")) XQORM("??") Q
 I X="?" D:XQORM(0)'["D" DISP^XQORM1 D HELP1^XQORM5 Q
 D HELP1^XQORM5,HELP2^XQORM5 F I=0:0 W !!,$S(XQORM(0)["D":"Red",1:"D"),"isplay items" S %=1 D YN^DICN Q:%  W !!?4,"Enter a ""Y"" or ""N""."
 D:%=1 DISP^XQORM1 W !
 Q
 ;Error messages  From: XQORM routines
CC W !!,">>>  Control characters and function keys may not be entered.",! Q
LL W !!,">>>  Entry is too long.",! Q
NE W !!,">>>  Only "_+XQORM(0)_$S(+XQORM(0)=1:" entry",1:" entries")_" allowed.",! Q
IR W !!,">>>  Range entered improperly: ",X,".",! Q
LR W !!,">>>  Range too large: ",X,".",! Q
NS W !!,">>>  ",$P(Y(ORUB),"^",3)," may not be selected at this point.",! Q
NN W !!,">>>  The ""-"" may not be used with " D SHO W ".",! Q
NF W !!,ORUW," is not a valid selection.",! Q
SC W !!,">>>  Semi-colon may not be at the front of an item.  To jump, use '^^'.",! Q
NU I $L(XQORM("NO^")),XQORM("NO^")'="OUTOK" W !!,">>>  ",@XQORM("NO^"),! Q
 W !!,">>>  Up-arrow not allowed.",!
 Q
SHO I $D(^XUTL("XQORM",XQORM,ORUDA,0)) W $P(^(0),"^",3)
 Q
ALL ;From: XQORM2
 N X K ^UTILITY("XQORM",$J)
 S ORUDA=0 F I=0:0 S ORUDA=$O(^XUTL("XQORM",XQORM,ORUDA)) Q:ORUDA'>0  I $D(^(ORUDA,0)),+^(0) S ORUB=1000*$P(ORUDA,".",2)+$P(ORUDA,".",1),^UTILITY("XQORM",$J,ORUB)=ORUDA
 S ORUB=0 F I=0:0 S ORUB=$O(^UTILITY("XQORM",$J,ORUB)) Q:ORUB'>0  S ORUDA=+^(ORUB) D UPD^XQORM3
 K ^UTILITY("XQORM",$J) Q
LAST ;From: XQORM2
 S X="" F I=0:0 S I=$O(^DISV(DUZ,"XQORM",XQORM,I)) Q:I'>0  S X=X_^DISV(DUZ,"XQORM",XQORM,I)_"," I $L(X)>160 K ^DISV(DUZ,"XQORM",XQORM) S X="" Q
 S X=$E(X,1,$L(X)-1) ;I $L(X) W:XQORM(0)["A" X
 Q

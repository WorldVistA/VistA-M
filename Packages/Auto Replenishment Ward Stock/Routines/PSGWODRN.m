PSGWODRN ;BHAM ISC/MPH,PTD,CML-Enter an On-Demand Request - for Nursing Staff ;Oct 17, 2017@14:48
 ;;2.3;Automatic Replenishment/Ward Stock;**11,19**;4 JAN 94;Build 45
 N PSGWITMC S PSGWITMC=0 ; PSGWITMC is a counter of the number of passes through ITEM
 I '$D(PSGWSITE) D ^PSGWSET Q:'$D(PSGWSITE)  S PSGWFLG=1
 S BCFLG=0 G DATE ; I '$P(PSGWSITE,"^",27) S BCFLG=0 G DATE
 W !!,"This option can be used with a Bar Code Reader and a printed listing from",!,"the option 'LIST BAR CODED STOCK ITEMS'.",!!,"If you choose to use a bar code reader, you MUST use it to enter both",!,"the AOU and the ITEM."
ASK W !!,"Do you wish to use a Bar Code Reader" S %=2 D YN^DICN G:%<0!(%="") BOT I %<1 W !,"PLEASE ANSWER 'YES' OR 'NO'." G ASK
 S BCFLG=$S(%<2:1,1:0)
DATE S PSGWV="AMIS COMPILE FLAG" R !!,"SELECT DATE/TIME FOR ON-DEMAND REQUEST: NOW // ",ODT:DTIME S:'$T ODT="^" G:ODT="^" BOT S:ODT="" ODT="NOW"
 I "?"[$E(ODT) S X="?",DIC(0)="M",DIC="^PSI(58.1,",D="OND" D IX^DIC K DIC G DATE
DT S %DT="ET",%DT(0)="-NOW",X=ODT D ^%DT K %DT(0) G:Y<0 DATE S (ODT,PSGWADT)=Y,PSGWCAT="W",AMISFL=0,PRTFLG=0
AOU R !,"Select MEDICATION AREA OF USE: ",X:DTIME S:'$T X="^" G BOT:"^"[X I BCFLG,X'?1"A".N W *7,"  ??",!,"Wand the bar code.  It should be in the format of an 'A' followed by a series",!,"of number(s).  Ex. - 'A123'" G AOU
 S:BCFLG X=$P(X,"A",2) S DIC="^PSI(58.1,",DIC(0)="QEMN",DIC("S")="I $S('$D(^(""I"")):1,'^(""I""):1,^(""I"")>DT:1,1:0)" D ^DIC K DIC
 G:X?1."?" AOU G:Y<0 BOT S (AOU,PSGWAOU)=+Y S:($P(^PSI(58.1,AOU,0),"^",3)'=1)&($P(PSGWSITE,"^",25)=1) AMISFL=1
 I '$D(^PSI(58.1,AOU,1,0)) S ^(0)="^58.11IP^^"
ITEM R !,"Select ITEM: ",X:DTIME S:'$T X="^" G BOT:(X="^"&(PSGWITMC<1)),END:X="" I BCFLG,X'?1"I".N W *7,"  ??",!,"Wand the bar code.  It should be in the format of an 'I' followed by a series",!,"of number(s).  Ex. - 'I123'" G ITEM
 S:BCFLG X=$P(X,"I",2) S DIC="^PSI(58.1,AOU,1,",DIC(0)="QEM",DA(1)=AOU,DIC("S")="S DRGDA=+^(0) I $S('$D(^(""I"")):1,$O(^(""I"",0))'>DT:0,1:1) D SCR2^PSGWOD2" D ^DIC K DIC G ITEM:X?1."?"!(Y<0) S (PSGDR,PSGWDN)=$P(Y,"^",2),ITEM=+Y
BACKOD S X=PSGDR,PSGBOT=0,DIC="^PSI(58.3,",DIC(0)="" D ^DIC K DIC G:Y<0 UPD S PSGBON=+Y
 F J=0:0 S J=$S($D(^PSI(58.3,PSGBON,1,AOU,1,J)):$O(^(J)),1:0) Q:J'>0  S:$S($P(^(J,0),"^",5)="":1,1:0) PSGBOT=PSGBOT+$P(^(0),"^",2)
 W:PSGBOT'=0 !!,"Item is on BACKORDER.  You may not enter a quantity.",!,"Total Backordered for this item is ",PSGBOT,".",!!
UPD I PSGBOT'>0 S DR(2,58.11)="16///"_ODT,DR(3,58.28)="2////"_DUZ_";S PSGWOLD=$P(^PSI(58.1,AOU,1,DA(1),5,DA,0),""^"",2);1T;S PSGWQD=X-PSGWOLD"
 I $$GET^XPAR("ALL","PSGW_WS_LVL_ON") N IEN S IEN=ITEM_","_AOU_"," W !,"Stock Level Allowed is ",$$GET1^DIQ(58.11,IEN,1),"." K IEN ;Patch PSWG*2.3*19
 I PSGBOT'>0 S PSGDR=$P(^PSDRUG(PSGDR,0),"^"),DIE("NO^")="Other value",DIE="^PSI(58.1,",DA=AOU,DR="1///"_PSGDR D ^DIE I $D(PSGWQD),(PSGWQD'=0) S PRTFLG=1 I AMISFL=1 S ^PSI(58.5,"AMIS",$H,PSGWADT,PSGWCAT,PSGWAOU,PSGWDN,PSGWQD)=""
DONE K PSGBON,PSGBOT,PSGDR,PSGWDN,PSGWQD,PSGWOLD,X,Y,J,DR,IEN S PSGWITMC=PSGWITMC+1 G ITEM
END ;
 G:'PRTFLG BOT
 N PSGWTEMP S PSGWTEMP=$$GET1^DIQ(3.5,$P(PSGWSITE,"^",32),.01)
 I PSGWTEMP'="" D AUTOQ K PSGWTEMP,PSGWITMC
 R !!,"Do you wish to print a copy of this on-demand request ? N//",ANS:DTIME S:'$T ANS="^" S:ANS="" ANS="^" G:ANS="^" BOT
 I "YyNn"'[$E(ANS) W !!,"Answer ""Y"" or ""N"". If you answer yes, the program will print a ""pick list"" or",!,"hard copy of this on-demand request. The report lists the date, AOU, items,",!,"quantities, and person entering request." G END
 I "Yy"[$E(ANS) S ALL=0,(BDT,EDT)=ODT G DEV^PSGWODP
BOT K %,BCFLG,PSGBON,PSGBOT,PSGDR,DR,AOU,ODT,ANS,PSGWADT,PSGWCAT,PSGWDN,PSGWOLD,PSGWQD,PSGWAOU,AMISFL,KEY,PSGWV,DA,D,DIE,%DT,%W,D0,D1,D2,DI,DLAYGO,DQ,ITEM,PRTFLG,DRGDA,PSGWTEMP,PSGWITMC K:$D(PSGWFLG) PSGWSITE,PSGWFLG Q
AUTOQ ;Patch to Auto queue Ward Stock Request to pharmacy printer (PSGW*2.3*19)
 S ALL=0,(BDT,EDT)=ODT
 S ZTIO=$$GET1^DIQ(3.5,$P(PSGWSITE,"^",32),.01)
 S ZTDESC="AUTO-PRINT WARD STOCK REQUEST" S ZTRTN="ENQ^PSGWODP" S:$D(AOULP) ZTSAVE("AOULP*")="" F G="BDT","EDT" S:$D(@G) ZTSAVE(G)="" S ZTDTH=$H
 D ^%ZTLOAD
 K ZTRTN,ZTDEC,ZTIO,ZTSAVE
 Q
 ;

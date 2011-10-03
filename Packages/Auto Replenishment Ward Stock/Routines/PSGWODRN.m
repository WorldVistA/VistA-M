PSGWODRN ;BHAM ISC/MPH,PTD,CML-Enter an On-Demand Request - for Nursing Staff ; 17 Mar 97 / 2:48 PM
 ;;2.3; Automatic Replenishment/Ward Stock ;**11**;4 JAN 94
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
ITEM R !,"Select ITEM: ",X:DTIME S:'$T X="^" G BOT:X="^",END:X="" I BCFLG,X'?1"I".N W *7,"  ??",!,"Wand the bar code.  It should be in the format of an 'I' followed by a series",!,"of number(s).  Ex. - 'I123'" G ITEM
 S:BCFLG X=$P(X,"I",2) S DIC="^PSI(58.1,AOU,1,",DIC(0)="QEM",DA(1)=AOU,DIC("S")="S DRGDA=+^(0) I $S('$D(^(""I"")):1,$O(^(""I"",0))'>DT:0,1:1) D SCR2^PSGWOD2" D ^DIC K DIC G ITEM:X?1."?"!(Y<0) S (PSGDR,PSGWDN)=$P(Y,"^",2),ITEM=+Y
BACKOD S X=PSGDR,PSGBOT=0,DIC="^PSI(58.3,",DIC(0)="" D ^DIC K DIC G:Y<0 UPD S PSGBON=+Y
 F J=0:0 S J=$S($D(^PSI(58.3,PSGBON,1,AOU,1,J)):$O(^(J)),1:0) Q:J'>0  S:$S($P(^(J,0),"^",5)="":1,1:0) PSGBOT=PSGBOT+$P(^(0),"^",2)
 W:PSGBOT'=0 !!,"Item is on BACKORDER.  You may not enter a quantity.",!,"Total Backordered for this item is ",PSGBOT,".",!!
UPD I PSGBOT'>0 S DR="16///"_ODT,DR(2,58.28)="2////"_DUZ_";S PSGWOLD=$P(^PSI(58.1,AOU,1,DA(1),5,DA,0),""^"",2);1T;S PSGWQD=X-PSGWOLD"
 I  S PSGDR=$P(^PSDRUG(PSGDR,0),"^"),DIE="^PSI(58.1,AOU,1,",DA(1)=AOU,DA=ITEM D ^DIE K DIE I $D(PSGWQD),(PSGWQD'=0) S PRTFLG=1 I AMISFL=1 S ^PSI(58.5,"AMIS",$H,PSGWADT,PSGWCAT,PSGWAOU,PSGWDN,PSGWQD)=""
DONE K PSGBON,PSGBOT,PSGDR,PSGWDN,PSGWQD,PSGWOLD,X,Y,J,DR G ITEM
END G:'PRTFLG BOT R !!,"Do you wish to print a copy of this on-demand request ? N//",ANS:DTIME S:'$T ANS="^" S:ANS="" ANS="^" G:ANS="^" BOT
 I "YyNn"'[$E(ANS) W !!,"Answer ""Y"" or ""N"". If you answer yes, the program will print a ""pick list"" or",!,"hard copy of this on-demand request. The report lists the date, AOU, items,",!,"quantities, and person entering request." G END
 I "Yy"[$E(ANS) S ALL=0,(BDT,EDT)=ODT G DEV^PSGWODP
BOT K %,BCFLG,PSGBON,PSGBOT,PSGDR,DR,AOU,ODT,ANS,PSGWADT,PSGWCAT,PSGWDN,PSGWOLD,PSGWQD,PSGWAOU,AMISFL,KEY,PSGWV,DA,D,DIE,%DT,%W,D0,D1,D2,DI,DLAYGO,DQ,ITEM,PRTFLG,DRGDA K:$D(PSGWFLG) PSGWSITE,PSGWFLG Q

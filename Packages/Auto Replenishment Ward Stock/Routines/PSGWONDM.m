PSGWONDM ;BHAM ISC/MPH,PTD,CML,KKA-Enter an On-Demand Request - for Pharmacy Use ; 19 May 93 / 9:19 AM
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
 I '$D(PSGWSITE) D ^PSGWSET Q:'$D(PSGWSITE)  S PSGWFLG=1
 S PRTFLG=0,BCFLG=0 G DATE ; I '$P(PSGWSITE,"^",27) S BCFLG=0 G DATE
 W !!,"This option can be used with a Bar Code Reader and a printed listing from",!,"the option 'LIST BAR CODED STOCK ITEMS'.",!!,"If you choose to use a bar code reader, you MUST use it to enter both",!,"the AOU and the ITEM."
ASK W !!,"Do you wish to use a Bar Code Reader" S %=2 D YN^DICN G:%<0!(%="") BOT I %<1 D HELP G ASK
 S BCFLG=$S(%<2:1,1:0)
DATE S PSGWV="AMIS COMPILE FLAG" R !!,"SELECT DATE/TIME FOR ON-DEMAND REQUEST: ",PSGWDT:DTIME S:'$T PSGWDT="^" G:"^"[PSGWDT END
 I "?"[$E(PSGWDT) S X="?",DIC(0)="M",DIC="^PSI(58.1,",D="OND" D IX^DIC K DIC G DATE
DT S %DT="ET",%DT(0)="-NOW",X=PSGWDT D ^%DT K %DT(0) G:Y<0 DATE S:'$D(PSGWODT) BDT=Y S (EDT,PSGWODT,ADT)=Y,CAT="W"
AOU R !,"Select AOU: ",X:DTIME S:'$T X="^" G BOT:X="^",DATE:X="" I BCFLG,X'?1"A".N W *7,"  ??",!,"Wand the bar code.  It should be in the format of an 'A' followed by a series",!,"of number(s).  Ex. - 'A123'" G AOU
 S:BCFLG X=$P(X,"A",2) S AMISFL=0,DIC="^PSI(58.1,",DIC(0)="QEMNZ",DIC("S")="I $S('$D(^(""I"")):1,'^(""I""):1,^(""I"")>DT:1,1:0)" D ^DIC K DIC
 G AOU:X?1."?",DATE:Y<0 S (AOU,PSGWAOU)=+Y I ($P(^PSI(58.1,AOU,0),"^",3)'=1)&($P(PSGWSITE,"^",25)=1) S AMISFL=1
 I '$D(^PSI(58.1,AOU,1,0)) S ^(0)="^58.11IP^^"
ITEM R !,"Select ITEM: ",X:DTIME S:'$T X="^" G BOT:X="^",AOU:X="" I BCFLG,X'?1"I".N W *7,"  ??",!,"Wand the bar code.  It should be in the format of an 'I' followed by a series",!,"of number(s).  Ex. - 'I123'" G ITEM
 S:BCFLG X=$P(X,"I",2) S DIC="^PSI(58.1,"_AOU_",1,",DIC(0)="QLOEM",DIC("DR")="12///1",DA(1)=AOU,DIC("S")="D SCR^PSGWOD2" D ^DIC K DIC G ITEM:X?1."?"!(Y<0) S (PSGDR,PSGWDN)=$P(Y,"^",2),NEWI=$P(Y,"^",3),ITEM=+Y
 I 'NEWI S PSGWDUZ=DUZ,PREV=0 S PREV=$O(^PSI(58.1,"OND",BDT,AOU,+Y,0)) I +PREV S PSGWDUZ=$P(^PSI(58.1,AOU,1,+Y,5,PREV,0),"^",3) D NOW^%DTC S EDITDT=%
BACKOD S X=PSGDR,BOT=0,DIC="^PSI(58.3,",DIC(0)="" D ^DIC G:Y<0 NEWI S BON=+Y
 F J=0:0 S J=$S($D(^PSI(58.3,BON,1,AOU,1,J)):$O(^(J)),1:0) Q:J'>0  S:$S($P(^(J,0),"^",5)="":1,1:0) BOT=BOT+$P(^(0),"^",2)
 W:BOT'=0 !!,"Total Backordered for this item is ",BOT
RD I BOT>0 R !,"Do you wish to continue the demand request" S %=2 D YN^DICN G:%<0!(%="") END G:%=2 DONE I %<1 D HELP G RD
NEWI I NEWI D DIENEW^PSGWOD2 ;R !,"Is this new item a one-time request" S %=1 D YN^DICN G:%<0!(%="") BOT D:%<1 HELP G:%<1 NEWI D DIENEW
 I 'NEWI S DR="16///"_PSGWODT,DR(2,58.28)="2////"_PSGWDUZ_";S OLD=$P(^PSI(58.1,AOU,1,DA(1),5,DA,0),""^"",2);1;S QD=X-OLD" I PREV S DR(2,58.28)=DR(2,58.28)_";4////"_DUZ_";5///"_EDITDT
UPD S PSGDR=$P(^PSDRUG(PSGDR,0),"^"),DIE="^PSI(58.1,AOU,1,",DA(1)=AOU,DA=ITEM D ^DIE K DIE I $D(QD),(QD'=0) S PRTFLG=1 I AMISFL=1 S ^PSI(58.5,"AMIS",$H,ADT,CAT,PSGWAOU,PSGWDN,QD)=""
 ;S PSGDR=$P(^PSDRUG(PSGDR,0),"^"),DIE="^PSI(58.1,",DA=AOU,DR="1///"_PSGDR D ^DIE K DIE I $D(QD),(QD'=0) S PRTFLG=1 I AMISFL=1 S ^PSI(58.5,"AMIS",$H,ADT,CAT,PSGWAOU,PSGWDN,QD)=""
EXP I 'NEWI,'BCFLG,$P(^PSI(58.1,AOU,0),"^",4) S DA(1)=AOU,DA=ITEM,DIE="^PSI(58.1,"_DA(1)_",1,",DR="35T" D ^DIE K DIE,DIC
DONE K %,EDITDT,PREV,BON,BOT,PSGDR,NEWI,X,Y,J,DR,PSGWDN,PSGWDUZ,QD,OLD,DRGDA G ITEM
END G:'PRTFLG BOT R !!,"Do you wish to print a copy of this on-demand request ? N//",ANS:DTIME S:'$T ANS="^" G:"^"[ANS BOT
 I "YyNn"'[$E(ANS,1,1) W !!,"Answer ""Y"" or ""N"".If you answer yes, the program will print a ""pick list"" or",!," hard copy of this on-demand request. The report lists the date, AOU, items",!," and quantities dispensed." G END
 I "Yy"[$E(ANS,1,1) G EN^PSGWODP
BOT K %,%H,%I,BCFLG,BON,BOT,PSGDR,NEWI,DR,AOU,PSGWODT,PSGWDT,ANS,PSGWD,ADT,CAT,PSGWDN,QD,OLD,AMISFL,KEY,PSGWV,PSGWAOU,BDT,EDT,DIC,PSGWDRG,%DT,D,J,%W,C,D0,D1,D2,DI,DLAYGO,DQ,X,Y,DRGDA,DA,DIE,EDITDT,PREV,PSGWDUZ,ITEM,PRTFLG
 K:$D(PSGWFLG) PSGWFLG,PSGWSITE Q
 ;
HELP W !,"PLEASE ANSWER ""YES"" OR ""NO""." Q

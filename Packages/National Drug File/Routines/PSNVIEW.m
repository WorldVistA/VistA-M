PSNVIEW ;BIR/WRT-look-up into drug file ; 10/13/98 13:27
 ;;4.0; NATIONAL DRUG FILE;; 30 Oct 98
BEGIN F ZZ=0:0 D ASK Q:PSNANS="^"  Q:PSNANS=""
KILL K CL,PSNSYN,BILLT,ANS,PSNANS,PRC,IFN,VV,X,Y,ZZ,BILL,CLDA,CLS,CST,GG,NAM,PSNB,^TMP($J,"PSNV") Q
ASK R !!,"You may look-up by DRUG GENERIC NAME or VA CLASS CODE ",!!,"Enter a ""G"" for GENERIC NAME or a ""C"" for VA CLASS CODE:  ",PSNANS:DTIME S:'$T PSNANS="^" Q:PSNANS="^"
 I PSNANS="" Q
 I "?"[$E(PSNANS) W !!,?5,"Enter a ""G"" to inquire by Generic Name or Synonym",!,?5,"Enter a ""C"" to inquire by a particular VA Drug Class Code.",!,?5,"You may enter an ""^"" to exit.",! K PSNANS G ASK
 I "^"[$E(PSNANS) Q
 I "GgCc"'[$E(PSNANS) G ASK
 I $D(PSNANS),PSNANS?.E1C.E K PSNANS G ASK
 I "Gg"[$E(PSNANS) W ?67,"GENERIC",! D LOOK Q:Y<0
 I "Cc"[$E(PSNANS) W ?67,"CLASS",! D LOOK1 Q:Y<0  W:'$D(^TMP($J,"PSNV")) !!,"No drug found with this classification.",!
 Q
LOOK S DIC="^PSDRUG(",DIC(0)="EM",DIC("S")="I $S('$D(^PSDRUG(+Y,""I"")):1,'^(""I""):1,DT'>^(""I""):1,1:0)" R !!,"Select DRUG GENERIC NAME :  ",BILL:DTIME S:'$T BILL="^" S X=BILL D ^DIC K DIC G:$E(BILL)["?" LOOK I Y>0 S IFN=+Y D DSPLY Q
 Q
LOOK1 K ^TMP($J,"PSNV") S DIC=50.605,DIC(0)="EMQ" R !!,"Select VA CLASS CODE :  ",BILLT:DTIME S:'$T BILLT="^" S X=BILLT D ^DIC K DIC G:$E(BILLT)["?" LOOK1 Q:Y<0  S BILLT=$P(Y,U,2)
LOOP F CLDA=0:0 S CLDA=$O(^PSDRUG("VAC",CLDA)) Q:'CLDA  I $D(^PS(50.605,CLDA)) S CLS=$P(^PS(50.605,CLDA,0),"^",1) I CLS=BILLT D LOOP1,LOOP2
 Q
LOOP1 F PSNB=0:0 S PSNB=$O(^PSDRUG("VAC",CLDA,PSNB)) Q:'PSNB  S PRC=$S('$D(^PSDRUG(PSNB,660)):"No Price",'$P(^PSDRUG(PSNB,660),"^",6):"No Price",$P(^PSDRUG(PSNB,660),"^",6)]"":+$P(^PSDRUG(PSNB,660),"^",6),1:"No Price") D SET
 Q
SET I '$P(^PSDRUG(PSNB,0),"^",9) I '$D(^PSDRUG(PSNB,"I")) S ^TMP($J,"PSNV",PRC,$P(^PSDRUG(PSNB,0),"^"))=PSNB,ANS=""
 Q
LOOP2 S CST="" F VV=0:0 S CST=$O(^TMP($J,"PSNV",CST)) Q:CST=""  Q:ANS="^"  S NAM="" F GG=0:0 S NAM=$O(^TMP($J,"PSNV",CST,NAM)) Q:NAM=""  Q:ANS="^"  S IFN=$P(^TMP($J,"PSNV",CST,NAM),"^",1) D READ Q:ANS="^"  D DSPLY1
 Q
READ R !!,?5,"Press <RET> to continue or an ""^"" to exit  : ",ANS:DTIME S:'$T ANS="^" Q:ANS="^"
 I ANS="?" W !!,"Press <RETURN> to see next drug or you may enter an ""^"" to exit.",! K ANS G READ
 I ANS="^" Q
 I ANS]"" G READ
 I ANS']"" W @IOF
 Q
DSPLY1 W !,?14,"GENERIC NAME: ",$P(^PSDRUG(IFN,0),"^"),!!,?8,"VA DRUG CLASS CODE: ",$P(^PS(50.605,CLDA,0),"^",1),"    ",$P(^PS(50.605,CLDA,0),"^",2),!,?5,"PRICE/DISPENSING UNIT: ",CST,!!
 W ?5,"MESSAGE:  ",$P(^PSDRUG(IFN,0),"^",10),!!,"SYNONYM(S):  " I $D(^PSDRUG(IFN,1,0)) D SYN W !!!!
 Q
DSPLY I $P(^PSDRUG(IFN,0),"^",9) W !!,"This is a NON-FORMULARY drug",! Q
 W @IOF W !?14,"GENERIC NAME:  ",$P(^PSDRUG(IFN,0),"^"),!!,?8,"VA DRUG CLASS CODE:  " I $D(^PSDRUG(IFN,"ND")) S CL=$P(^("ND"),"^",6) I $D(^PS(50.605,CL)) W $P(^PS(50.605,CL,0),"^",1),"    ",$P(^PS(50.605,CL,0),"^",2)
 W !,?5,"PRICE/DISPENSING UNIT:  ",$S($D(^PSDRUG(IFN,660)):$P(^PSDRUG(IFN,660),"^",6),1:"")
 W !!,?5,"MESSAGE:  ",$P(^PSDRUG(IFN,0),"^",10),!!,"SYNONYM(S):  " I $D(^PSDRUG(IFN,1,0)) D SYN W !!!
 Q
SYN F PSNSYN=0:0 S PSNSYN=$O(^PSDRUG(IFN,1,PSNSYN)) Q:'PSNSYN  I $P(^PSDRUG(IFN,1,PSNSYN,0),"^",3)'=1 W !?5,$P(^PSDRUG(IFN,1,PSNSYN,0),"^",1)
 Q

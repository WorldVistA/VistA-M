YSSR1 ;SLC/AFE-SECLUSION/RESTRAINT - Observation,Release & Review ; 1/27/04 11:17am
 ;;5.01;MENTAL HEALTH;**82**;Dec 30, 1994;Build 3
ENRLS ; Called from MENU option YSSR RELEASE
 ;
 ; Release of patient from S/R episode.
 W @IOF,!?IOM-$L("RELEASE FROM SECLUSION/RESTRAINT")\2,"RELEASE FROM SECLUSION/RESTRAINT",! S OPT=1,MSG1="No patients listed as requiring release."
 D LKUP^YSSR I '$D(A1) D END^YSSR Q 
 D ^YSLRP I YSDFN'>0 D END^YSSR Q
 S DIC="^YS(615.2,",DIC(0)="X",D="AC",X=YSDFN D IX^DIC S B=+Y I B<1 W $C(7),!!,"Patient not listed as in Seclusion/Restraint." D END^YSSR Q
 I $D(^YS(615.2,B,40)) S Y=+$P($G(^(40)),U,3) D DD^%DT W !!,$C(7),YSN," shown as released ",Y D END^YSSR Q
 W ! S DIE="^YS(615.2,",DA=B,DR="40:41;42//NOW" K Y L +^YS(615.2,DA) D ^DIE L -^YS(615.2,DA) S YSTOUT=$D(DTOUT),YSUOUT=$O(Y(""))]""
 I YSTOUT!YSUOUT K ^YS(615.2,B,40) W !!?10,"< RELEASE DELETED >" D END^YSSR Q
 S DR="43///^S X=""`""_DUZ;44///NOW;45" L +^YS(615.2,DA) D ^DIE L -^YS(615.2,DA) W !!?10,"PATIENT NOTED AS RELEASED."
 D END^YSSR
 Q
ENREV ; Called from MENU option YSSR REVIEW
 ; Review of S/R action.
 W @IOF,!?IOM-$L("REVIEW OF SECLUSION/RESTRAINT ASSESSMENT")\2,"REVIEW OF SECLUSION/RESTRAINT ASSESSMENT",!
REV ;
 I '$O(^YS(615.2,"AD",0)) W !!,"No review action required." D END^YSSR Q
 S RVN=0,QRVN=1 W !,"The following S/R actions have not been reviewed: ",! S B=0 F  S B=$O(^YS(615.2,"AD",B)) Q:'B  S B1=0 F  S B1=$O(^YS(615.2,"AD",B,B1)) Q:'B1  S RVN=RVN+1,RVP(RVN)=B1 D REVLST
ASK ;
 W !!,"Select action for review: ",QRVN,"// " R A1:DTIME S YSTOUT='$T,YSUOUT=A1["^" Q:YSTOUT!YSUOUT  S:A1="" A1=QRVN I A1'?.N S A1=0
 I A1<1!(A1>RVN) W !!,$C(7),"Not valid - re-enter." K A1 G ASK
 W @IOF S (DA,FN)=RVP(A1),DIC="^YS(615.2," D EN^DIQ W !,"**********"
 S DIE="^YS(615.2,",DA=FN,DR="50;51//A;52//NOW" L +^YS(615.2,DA) D ^DIE L -^YS(615.2,DA) S YSTOUT=$D(DTOUT),YSUOUT=$D(DUOUT)
 I YSTOUT!YSUOUT!($O(Y(""))]"") K ^YS(615.2,FN,50),DA,DIE,DR W !!?10,"< REVIEW ACTION DELETED >" D END^YSSR Q
 S DR="53///^S X=""`""_DUZ;54///NOW;55" L +^YS(615.2,DA) D ^DIE W !!?10,"REVIEW ACTION NOTED." L -^YS(615.2,DA) K DA,DIE,DR
 I '$D(^YS(615.2,"AD")) W !,"No other review action required." D END^YSSR Q
 G REV
 ;
REVLST ;
 S RVNM=$P(^DPT(B,0),U),Y=$P(^YS(615.2,B1,0),U,3) D DD^%DT W !?3,RVN,?8,$P(RVNM,",",2)_" "_$P(RVNM,",",1),?40,Y
 Q
 ;
ENCK ; Called from MENU option YSSR 15-CHECK
 ; Observation of patient in S/R.
 S YSB=0 D LKUP^YSSR G:'$D(A1) END^YSSR
 D ^YSLRP I YSDFN'>0 D END^YSSR Q
 S YSB=$O(^YS(615.2,"AC",YSDFN,YSB)) Q:'YSB  I '$D(^YS(615.2,YSB,60)) S ^YS(615.2,YSB,60,0)="^615.3DA^^"
 S DIC="^YS(615.2,YSB,60,",DIC(0)="AMELQ",DLAYGO=615,DIC("B")="NOW",DA(1)=YSB D ^DIC K DIC("B") I Y<1 D END^YSSR Q
 S DIE=DIC,DA=+Y,DR="1;4" L +^YS(615.2,YSB) D ^DIE L -^YS(615.2,YSB) S YSTOUT=$D(DTOUT),YSUOUT=$D(DUOUT)
 I YSTOUT!YSUOUT!('$P($G(^YS(615.2,DA(1),60,DA,0)),U,2))!('$O(^YS(615.2,DA(1),60,DA,60,0))) S DIK=DIE D ^DIK W !!?10,"< OBSERVATION DELETED >" D END^YSSR Q
 S DR="2///^S X=""`""_DUZ;3///NOW" L +^YS(615.2,YSB) D ^DIE W !!?15,"OBSERVATION NOTED." L -^YS(615.2,YSB)
 D END^YSSR
 Q
ENWO ; Called from MENU option YSSR W-ORDER
 ; Entry/edit of Type of S/R Order
 W @IOF,!?IOM-$L("EDIT OF TYPE OF SECLUSION/RESTRAINT ORDER")\2,"EDIT OF TYPE OF SECLUSION/RESTRAINT ORDER",!
 W !,"SECLUSION/RESTRAINT EPISODES REQUIRING WRITTEN ORDERS:  ",!
 D HEADER^YSSR S A=0 F  S A=$O(^YS(615.2,"AF",A)) Q:'A  S A1=0 F  S A1=$O(^YS(615.2,"AF",A,A1)) Q:'A1  D PNAMES^YSSR S YSWN=1,YSA1=A1
 I '$D(YSWN) W !!,"No patients listed as requiring a written order.",! D END^YSSR Q
 I $D(YS02) W !!," * Written Order Required.",!
 I $D(YS04) W:'$D(YS02) !! W " # Record incomplete, please contact IRM.",!
 K YS02,YS04
 D ^YSLRP I YSDFN'>0 D END^YSSR Q
WOLKUP ;
 S YSA1=$O(^YS(615.2,"AF",YSDFN,0)) I 'YSA1 W !!,"Written order not required for this patient.",! D END^YSSR Q
 S DIE="^YS(615.2,",DA=YSA1,DR="25:27;28///NOW" L +^YS(615.2,YSA1) D ^DIE L -^YS(615.2,YSA1)
 I $P(^YS(615.2,YSA1,25),U,2)="w" K ^YS(615.2,"AF",YSDFN,YSA1)
 D END^YSSR Q

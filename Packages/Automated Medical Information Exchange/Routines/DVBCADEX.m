DVBCADEX ;ALB/GTS-557/THM-ADD C&P EXAMS TO REQUESTS, PART 1 ; 6/28/91  9:32 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
SETUP D HOME^%ZIS S FF=IOF,HD="Add a C & P Exam for",HD1="Veteran Selection",HD2="Exam selection",HD3="2507 Exam Addition"
 ;
EN K DVBCLCKD D KILL W @FF,!?(IOM-$L(HD3)\2),HD3,!!?(IOM-$L(HD1)\2),HD1,!!!
 S DIC(0)="AEQM",DIC="^DVB(396.3,",DIC("A")="Select VETERAN NAME: "
 S DIC("W")="D DICW^DVBCUTIL"
 S:$D(DVBAROUS) DIC("S")="I $P(^(0),U,10)'=""E""" ;**DVBAROUS set by menu
 D ^DIC G:X=""!(X=U) EXIT
 S:+Y>0 EXCNT=0,(DA,REQDA)=+Y,DFN=$P(Y,U,2) I +Y<0 W "   ???",*7 H 1 G EN
 S X=^DVB(396.3,REQDA,0),OWNDOM=$P(X,U,22)
 I OWNDOM]"" W *7,!!,"This request is a TRANSFER IN and exams cannot be added.",!! H 3 G EN
 S STAT=$P(X,U,18) K NCN
 F DTB="X","RX","T","C","R","CT","NT" I STAT=DTB S NCN=1 Q
 I $D(NCN) W !!,*7,"This request has been ",$S(STAT["X":"cancelled",STAT="T":"transcribed",STAT["C":"completed",STAT="R":"released",STAT="NT":"transferred in",1:"given an incorrect status"),".",!! H 3 G EN
 S DTA=^DPT(DFN,0),PNAM=$P(DTA,U,1),SSN=$P(DTA,U,9),CNUM=$S($D(^DPT(DFN,.31)):$P(^(.31),U,3),1:"Unknown") S:CNUM="" CNUM="Unknown" D HDR,^DVBCEEXM W !!,"Press RETURN     " R ANS:DTIME G:'$T EXIT
 D ^DVBCADE2,KILL G:$D(OUT)!($D(DVBCLCKD)) EXIT
 G EN
 ;
EXIT K DVBCLCKD G KILL^DVBCUTIL
 ;
HDR W @FF,?(IOM-$L(HD)\2),HD,!!,"Veteran name: ",$P(PNAM,",",2,99)," ",$P(PNAM,",",1),?55,"SSN: ",SSN,!?53,"C-NUM: ",CNUM,!
 F LINE=1:1:IOM W "="
 W ! Q
 ;
KILL K CNUM,DFN,DIK,DR,DTA,DXCOD,DXNUM,EDIT,EX,EXMNM,FMT,PNAM,SSN,PCT,SC,REQDA,CTIM,VX,JY,JJ,X,%,^TMP($J),Y,DA,DIC,DIE,ANS,%Y,%,DTOUT,DUOUT,TEMP,DVBCCONT
 K DVBAINDA
 Q

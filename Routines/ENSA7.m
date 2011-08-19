ENSA7 ;(WASH ISC)/DH-Print Actual Test Results ;9-18-95
 ;;7.0;ENGINEERING;**21**;Aug 17, 1993
DEVICE ;Identify piece of equipment
 I ENLBL?.N S ENEQ=ENLBL
 I $E(ENLBL,3,8)[" EE" D
 . I $D(^ENG(6914,"OEE",ENLBL)) S ENEQ=$O(^(ENLBL,0)) Q
 . I $D(^ENG(6914,"EE",ENLBL)) S ENEQ=$O(^(ENLBL,0)) Q
 . S ENEQ=+$P(ENLBL,"EE",2)
 I ENLBL?4N1"-"4N0.1U S ENPMN=ENLBL,ENEQ=$O(^ENG(6914,"C",ENPMN,0))
 I ENEQ="",ENMOD(0)]"",ENSN(0)]"",$D(^ENG(6914,"E",ENMOD(0))) F ENEQ=0:0 S ENEQ=$O(^ENG(6914,"E",ENMOD(0),ENEQ)) Q:ENEQ'>0  I $D(^ENG(6914,ENEQ,0)),$D(^(1)),$P(^(1),U,3)=ENSN(0) Q
 I ENEQ>0,$D(^ENG(6914,ENEQ,0)) D DEVCK G:'$D(ENXP("?")) DEV1
 Q:'ENPAPER  W !,"DEVICE INFORMATION" W:'$D(ENXP("?")) "  (* Item not found in Equipment File *)" W !
 W ?5,X(1),!?5,X(2),!
 Q
DEV1 Q:'ENPAPER  W "Equipment ID: ",ENEQ,?40,"Location: ",ENLOC,!
 S (ENCAT,ENSN,ENMOD,ENMAN,ENPMN)="" I $D(^ENG(6914,ENEQ,1)) S EN(1)=^(1),ENCAT=$P(EN(1),U,1),ENMOD=$P(EN(1),U,2),ENSN=$P(EN(1),U,3),ENMAN=$P(EN(1),U,4)
 I ENCAT]"",$D(^ENG(6911,ENCAT,0)) S ENCAT=$P(^(0),U,1)
 I ENMAN]"",$D(^ENG("MFG",ENMAN,0)) S ENMAN=$P(^(0),U,1)
 K EN I $D(^ENG(6914,ENEQ,3)) S ENPMN=$P(^(3),U,6)
 W ?5,"Equip Cat: ",ENCAT,?40,"Man: ",ENMAN,!
 W ?5,"Mod: ",ENMOD,?30,"S/N: ",ENSN,?55,"PM#: ",ENPMN,!
 Q
LNPRNT ;Print uploaded data
 U IO S X=^ENG("TMP",ENTID,ENSA1)
 I X["MedTester" S ENY=IOSL W:ENSA1>1 @IOF
 Q:X']""  S X1=$E(X,1,4) W:X1="ECG:"!(X1="CASE") ?5
 W X,!
 Q
DEVCK ;Consistency check
 K ENXP("?") I ENMOD(0)]"",ENSN(0)]"",$D(^ENG(6914,ENEQ,1)) G DEVCK1
 Q  ;Insufficient info - can't tell
DEVCK1 I $P(^ENG(6914,ENEQ,1),U,2)]"",$P(^(1),U,2)'=ENMOD(0) G DEVCK2
 I $P(^ENG(6914,ENEQ,1),U,3)]"",$P(^(1),U,3)'=ENSN(0) G DEVCK2
 I $D(^ENG(6914,ENEQ,3)),$D(ENPMN),$P(^(3),U,6)]"",$P(^(3),U,6)'=ENPMN G DEVCK2
 Q  ;OK
DEVCK2 ;Inconsistency
 S ENXP("?")=1
 Q
DEVCK3 S ENMSG="Please check MedTester REC # "_ENREC_"  against Equipment File.",ENMSG(0,1)="Apparent inconsistency between Serial Numbers; Models; or (perhaps) VA PM#." D XCPTN^ENSA2
 Q
 ;ENSA7

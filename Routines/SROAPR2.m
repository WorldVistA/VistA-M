SROAPR2 ;BIR/MAM - PAGE 2 PREOP SCREEN ;01/19/06
 ;;3.0; Surgery ;**38,100,125,142,153**;24 Jun 93;Build 11
 K SRA,SRAO
START Q:SRSOUT  D:SRACLR RET S SRACLR=0 K SRA,SRAO D ^SROAPS2
ASK W !!,"Select Preoperative Information to Edit: " R X:DTIME I '$T!("^"[X) D CONCC^SROAPRE S SRSOUT=1 Q
 S:X="a" X="A" S:X="n" X="N"
 I $L(X)=2,'$D(SRAO(X)),X?1N1A S Z=$E(X,2),Z=$TR(Z,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ") I $D(SRAO($E(X)_Z)) S X=$E(X)_Z
 I '$D(SRAO(X)),(X'?1N1":"1N),(X'="A"),(X'="N") D HELP Q:SRSOUT  G START
 I X="A" S X="1:3"
 I X?1N1":"1N S Y=$E(X),Z=$P(X,":",2) I Y<1!(Z>3)!(Y>Z) D HELP Q:SRSOUT  G START
 I X="N" D  G START
 .W ! K DIR S DIR(0)="Y",DIR("B")="NO",DIR("A")="Are you sure you want to set all fields on this page to NO"
 .D ^DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 .I Y D NO2ALL^SROAPRE2
 S SRPAGE="" D HDR^SROAUTL
 I X?1N1":"1N D RANGE G START
 I $D(SRAO(X)),+X=X S EMILY=X D  G START
 .I $$LOCK^SROUTL(SRTN) D ^SROAPRE2,UNLOCK^SROUTL(SRTN)
 I $D(SRAO(X)) D  G START
 .I $$LOCK^SROUTL(SRTN) W !! S DA=SRTN,DIE=130,DR=$P(SRAO(X),"^",2)_"T" D ^DIE K DA,DIE,DR D UNLOCK^SROUTL(SRTN)
 S SRSOUT=1 Q
HELP W @IOF,!!!!,"Enter the number, number/letter combination, or range of numbers you want to",!,"edit.  Examples of proper responses are listed below."
 W !!,"1. Enter 'A' to update all information.",!!,"2. Enter 'N' to set all fields on this page to NO."
 W !!,"3. Enter a number (1-3) to update the information in that group.  (For",!,"   example, enter '2' to update all Central Nervous System information)"
 W !!,"4. Enter a number/letter combination to update a specific occurrence. (To ",!,"   update Impaired Sensorium, enter '2A')"
 W !!,"5. Enter a range of numbers (2-3) separated by a ':' to enter all",!,"   Central Nervous System and Nutritional/Immune/Other information."
 W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1
 Q
RANGE ; range of numbers
 I $$LOCK^SROUTL(SRTN) D  D UNLOCK^SROUTL(SRTN)
 .F EMILY=1,2,3 D ^SROAPRE2 Q:SRSOUT
 Q
RET Q:SRSOUT  W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 Q

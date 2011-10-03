SROAPRE ;BIR/MAM - PREOPERATIVE INFO ;10/04/10
 ;;3.0; Surgery ;**38,47,55,88,100,125,142,166,174**;24 Jun 93;Build 8
 I '$D(SRTN) W !!,"A Surgery Risk Assessment must be selected prior to using this option.",!!,"Press <RET> to continue  " R X:DTIME G END
 S (SRSOUT,SRACLR)=0,SRSUPCPT=1 D ^SROAUTL,DUP^SROAUTL G:SRSOUT END
START D:SRACLR RET G:SRSOUT END S SRACLR=0 K SRA,SRAO D ^SROAPS1
ASK W !,"Select Preoperative Information to Edit: " R X:DTIME I '$T!(X["^") D CONCC G END
 S:X="" X="+1" S:X="a" X="A" S:X="n" X="N"
 I $L(X)=2,'$D(SRAO(X)),X?1N1A S Z=$E(X,2),Z=$TR(Z,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ") I $D(SRAO($E(X)_Z)) S X=$E(X)_Z
 I '$D(SRAO(X)),(X'?.N1":".N),(X'="A"),(X'="N"),(X'="+1") D HELP G:SRSOUT END G START
 I X="+1" D CONCC,^SROAPR2 G START
 I X="A" S X="1:6"
 I X?.N1":".N S Y=$E(X),Z=$P(X,":",2) I Y<1!(Z>6)!(Y>Z) D HELP G:SRSOUT END G START
 I X="N" D  G:SRSOUT END G START
 .W ! K DIR S DIR(0)="Y",DIR("B")="NO",DIR("A")="Are you sure you want to set all fields on this page to NO"
 .D ^DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 .I Y D NO2ALL^SROAPRE1
 S SRPAGE="" D HDR^SROAUTL
 I X?.N1":".N D RANGE G START
 I $D(SRAO(X)),+X=X S EMILY=X D  G START
 .I $$LOCK^SROUTL(SRTN) W ! D:EMILY<4 ^SROAPRE1 D:EMILY>3 ^SROAPR1A D UNLOCK^SROUTL(SRTN)
 I $D(SRAO(X)),$$LOCK^SROUTL(SRTN) D  D UNLOCK^SROUTL(SRTN)
 .S SRX=X W ! K DR,DIE S DA=SRTN,DR=$P(SRAO(X),"^",2)_"T",DIE=130 D ^DIE K DR
 G START
END I '$D(SREQST) W @IOF D ^SRSKILL
 Q
HELP W @IOF,!!!!,"Enter the number, number/letter combination, or range of numbers you want to",!,"edit.  Examples of proper responses are listed below."
 W !!,"1. Enter 'A' to update all information.",!!,"2. Enter 'N' to set all fields on this page to NO."
 W !!,"3. Enter a number (1-6) to update the information in that group.  (For",!,"   example, enter '5' to update all cardiac information)"
 W !!,"4. Enter a number/letter combination to update a specific occurrence. (To ",!,"   update Current Pneumonia, enter '2C'.)"
 W !!,"5. Enter a range of numbers (1-6) separated by a ':' to enter a range of",!,"   occurrences.  (For example, enter '2:4' to enter all pulmonary,",!,"   hepatobiliary, and gastrointestinal information)"
 W !!,"6. Press <RET> to continue to page 2 of this option."
 W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1
 Q
RANGE ; range of numbers
 I $$LOCK^SROUTL(SRTN) D  D UNLOCK^SROUTL(SRTN)
 .S SHEMP=$P(X,":"),CURLEY=$P(X,":",2) W:SHEMP<9 ! F EMILY=SHEMP:1:CURLEY Q:SRSOUT  D:EMILY<4 ^SROAPRE1 D:EMILY>3 ^SROAPR1A
 Q
RET Q:SRSOUT  W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 Q
CONCC ; check for concurrent case and update if one exists
 S SRCON=$P($G(^SRF(SRTN,"CON")),"^") Q:'SRCON
 Q:$P($G(^SRF(SRCON,"RA")),"^",2)="C"
 S SRI="" F  S SRI=$O(SRAO(SRI)) Q:SRI=""  S SRZ=$P(SRAO(SRI),"^",2) K DA,DIC,DIQ,DR,SRY D
 .S DA=SRTN,DR=SRZ,DIC="^SRF(",DIQ="SRY",DIQ(0)="I" D EN^DIQ1 S SRX=SRY(130,SRTN,SRZ,"I") S:SRX="" SRX="@"
 .I $$LOCK^SROUTL(SRTN) K DA,DIE,DR S DA=SRCON,DIE=130,DR=SRZ_"////"_SRX D ^DIE K DR D UNLOCK^SROUTL(SRTN)
 Q

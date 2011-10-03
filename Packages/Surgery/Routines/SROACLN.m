SROACLN ;BIR/MAM - CLINICAL DATA ;07/25/04  1:32 PM
 ;;3.0; Surgery ;**38,47,71,95,100,125,142,174**;24 Jun 93;Build 8
 I '$D(SRTN) W !!,"A Surgery Risk Assessment must be selected prior to using this option.",!!,"Press <RET> to continue  " R X:DTIME G END
 S SRACLR=0,SRSOUT=0,SRSUPCPT=1 D ^SROAUTL
START D:SRACLR RET G:SRSOUT END S SRACLR=0 K SRA,SRAO D ^SROACL1
ASK W !!,"Select Clinical Information to Edit: " R X:DTIME I '$T!("^"[X) G END
 S:X="a" X="A" I '$D(SRAO(X)),(X'?.N1":".N),(X'="A") D HELP G:SRSOUT END G START
 I X="A" S X="1:25"
 I X?.N1":".N S Y=$E(X),Z=$P(X,":",2) I Y<1!(Z>25)!(Y>Z) D HELP G:SRSOUT END G START
 D HDR^SROAUTL
 I X?.N1":".N D RANGE G START
 I $D(SRAO(X)) S EMILY=X D  G START
 .I $$LOCK^SROUTL(SRTN) W !! D ONE,UNLOCK^SROUTL(SRTN)
END I '$D(SREQST) W @IOF D ^SRSKILL
 Q
HELP W @IOF,!!!!,"Enter the number or range of numbers you want to edit.  Examples of proper",!,"responses are listed below."
 W !!,"1. Enter 'A' to update all information.",!!,"2. Enter a specific number to update the information in that field.  (For",!,"   example, enter '8' to update Current Smoker)"
 W !!,"3. Enter a range of numbers separated by a ':' to enter a range of",!,"   information.  (For example, enter '7:9' to enter Pulmonary Rales,",!,"   Current Smoker, and Active Endocarditis.)"
 W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1
 Q
RANGE ; range of numbers
 I $$LOCK^SROUTL(SRTN) D  D UNLOCK^SROUTL(SRTN)
 .W !! S SHEMP=$P(X,":"),CURLEY=$P(X,":",2) F EMILY=SHEMP:1:CURLEY Q:SRSOUT  D ONE
 Q
ONE ; edit one item
 I EMILY=11 D FUNCT Q
 I EMILY=15 D ^SROACL2 K DR,DIE S DA=SRTN,DR="485///"_$P(SRAO(15),"^"),DIE=130 D ^DIE K DR S:$D(Y) SRSOUT=1 Q
 K DR,DIE S DA=SRTN,DR=$P(SRAO(EMILY),"^",2)_"T",DIE=130 D ^DIE K DR I $D(Y) S SRSOUT=1
 I EMILY=14,$P($G(^SRF(SRTN,206)),"^",15)=0 S $P(^SRF(SRTN,206),"^",42)=0
 Q
RET Q:SRSOUT  W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 Q
FUNCT K DA,DIR S DA=SRTN,DIR(0)="130,240",DIR("A")="Functional Status" D ^DIR K DIR D  Q
 .I $D(DTOUT)!$D(DUOUT) Q
 .I X="@" K DIE,DR S DIE=130,DR="240///@" D ^DIE K DA,DIE,DR Q
 .K DIE,DR S DIE=130,DR="240////"_Y D ^DIE K DA,DIE,DR
 Q

SROACLN ;BIR/MAM - CLINICAL DATA ;09/01/2011
 ;;3.0;Surgery;**38,47,71,95,100,125,142,174,175,176,182**;24 Jun 93;Build 49
 I '$D(SRTN) W !!,"A Surgery Risk Assessment must be selected prior to using this option.",!!,"Press <RET> to continue  " R X:DTIME G END
 S SRACLR=0,SRSOUT=0,SRSUPCPT=1 D ^SROAUTL
START D:SRACLR RET G:SRSOUT END S SRACLR=0 K SRA,SRAO D ^SROACL1
ASK W !!,"Select Clinical Information to Edit: " R X:DTIME I '$T!("^"[X) G END
 S X=$S(X="a":"A",X="n":"N",1:X) I '$D(SRAO(X)),(X'?.N1":".N),(X'="A"),(X'="N") D HELP G:SRSOUT END G START
 I X="A" S X="1:31"
 I X?.N1":".N S Y=$E(X),Z=$P(X,":",2) I Y<1!(Z>31)!(Y>Z) D HELP G:SRSOUT END G START
 I X="N" D  G:SRSOUT END G START
 .W ! K DIR S DIR(0)="Y",DIR("B")="NO",DIR("A")="Are you sure you want to set all fields on this page to NO"
 .D ^DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 .I Y D NO2ALL
 D HDR^SROAUTL
 I X?.N1":".N D RANGE G START
 I $D(SRAO(X)) S EMILY=X D  G START
 .I $$LOCK^SROUTL(SRTN) W !! D ONE,UNLOCK^SROUTL(SRTN)
END I '$D(SREQST) W @IOF D ^SRSKILL
 Q
HELP W @IOF,!!!!,"Enter the number or range of numbers you want to edit.  Examples of proper",!,"responses are listed below."
 W !!,"1. Enter 'A' to update all information.",!!,"2. Enter 'N' to set all fields on this page to NO."
 W !!,"3. Enter a specific number to update the information in that field.  (For",!,"   example, enter '8' to update Pulmonary Rales)"
 W !!,"4. Enter a range of numbers separated by a ':' to enter a range of",!,"   information.  (For example, enter '7:9' to enter Cardiomegaly (X-ray),",!,"   Pulmonary Rales, and Tobacco Use.)"
 W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1
 Q
RANGE ; range of numbers
 I $$LOCK^SROUTL(SRTN) D  D UNLOCK^SROUTL(SRTN)
 .W !! S SHEMP=$P(X,":"),CURLEY=$P(X,":",2) F EMILY=SHEMP:1:CURLEY Q:SRSOUT  D ONE
 Q
ONE ; edit one item
 I EMILY=14 D FUNCT Q
 I EMILY=18 S X=18 D ^SROACL2 S SRAO(18)=Y K DR,DIE S DA=SRTN,DR="485///"_$P(SRAO(18),"^"),DIE=130 D ^DIE K DR S:$D(Y) SRSOUT=1 Q
 K DR,DIE S DA=SRTN,DR=$P(SRAO(EMILY),"^",2)_"T",DIE=130 D ^DIE K DR I $D(Y) S SRSOUT=1
 I EMILY=17,$P($G(^SRF(SRTN,206)),"^",15)=0 S $P(^SRF(SRTN,206),"^",42)=0
 Q
RET Q:SRSOUT  W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 Q
FUNCT K DA,DIR S DA=SRTN,DIR(0)="130,240",DIR("A")="Functional Status" D ^DIR K DIR D  Q
 .I $D(DTOUT)!$D(DUOUT) Q
 .I X="@" K DIE,DR S DIE=130,DR="240///@" D ^DIE K DA,DIE,DR Q
 .K DIE,DR S DIE=130,DR="240////"_Y D ^DIE K DA,DIE,DR
 Q
NO2ALL ; set all fields to NO
 N II K DR,DIE S DA=SRTN,DIE=130
 F II=203,209,348,349,350,353,354,355,474,509,267,207 S DR=$S($D(DR):DR_";",1:"")_II_"////N"
 F II=205,352,485 S DR=DR_";"_II_"////0"
 S DR=DR_";517////1;518////NA;519////1;520////1;521////0;522////0;618////1;641////1;643////1;265////1;640////1"
 D ^DIE K DR
 Q

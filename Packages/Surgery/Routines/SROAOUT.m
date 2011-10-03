SROAOUT ;BIR/SJA - OUTCOMES DATA ;04/03/07
 ;;3.0; Surgery ;**125,135,142,160,174**;24 Jun 93;Build 8
 I '$D(SRTN) W !!,"A Surgery Risk Assessment must be selected prior to using this option.",!!,"Press <RET> to continue  " R X:DTIME G END
 D SRA^SROES S SRACLR=0,SRSOUT=0,SRSUPCPT=1 D ^SROAUTL
START D:SRACLR RET G:SRSOUT END S SRACLR=0 K SRA,SRAO D ^SROUTC
ASK W !!,"Select Outcomes Information to Edit: " R X:DTIME I '$T!("^"[X) G END
 S:X="a" X="A" I '$D(SRAO(X)),(X'?.N1":".N),(X'="A") D HELP G:SRSOUT END G START
 I X="A" S X="0:14"
 I X?.N1":".N S Y=$E(X),Z=$P(X,":",2) I Y<0!(Z>14)!(Y>Z) D HELP G:SRSOUT END G START
 D HDR^SROAUTL
 I X?.N1":".N D RANGE G START
 I $D(SRAO(X)) S EMILY=X D  G START
 .I $$LOCK^SROUTL(SRTN) W !! D ONE,UNLOCK^SROUTL(SRTN)
END D:$D(SRTN) EXIT^SROES W @IOF D ^SRSKILL
 Q
HELP W @IOF,!!!!,"Enter the number or range of numbers you want to edit.  Examples of proper",!,"responses are listed below."
 W !!,"1. Enter 'A' to update all information.",!!,"2. Enter a number (0-14) to update the information in that field.  (For",!,"   example, enter '4' to update Mediastinitis)"
 W !!,"3. Enter a range of numbers separated by a ':' to enter a range of",!,"   information.  (For example, enter '11:13' to enter Stroke,",!,"   Coma >= 24 hr, and New Mech Circ Support)"
 W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1
 Q
RANGE ; range of numbers
 I $$LOCK^SROUTL(SRTN) D  D UNLOCK^SROUTL(SRTN)
 .W !! S SHEMP=$P(X,":"),CURLEY=$P(X,":",2) F EMILY=SHEMP:1:CURLEY Q:SRSOUT  D ONE
 Q
ONE ; edit one item
 N SRBEF
 S DIC="^SRF(",DA=SRTN,DIQ="SRY",DIQ(0)="I",DR=$P(SRAO(EMILY),"^",2) D EN^DIQ1 K DA,DIC,DIQ,DR S SRBEF=SRY(130,SRTN,$P(SRAO(EMILY),"^",2),"I")
 K DR,DIE S DA=SRTN,DR=$P(SRAO(EMILY),"^",2)_"T",DIE=130 D ^DIE K DA,DIE,DR I $D(Y)!$D(DTOUT) S SRSOUT=1
 Q:'EMILY
 I 'SRSOUT,SRBEF'="Y",X="Y" D UPDATE^SROUTC Q
 I 'SRSOUT,SRBEF="Y",X="Y",EMILY=8 D  K DA,DR,DIE Q
 .N SROCC,SRSTAT S SROCC=0 F  S SROCC=$O(^SRF(SRTN,16,SROCC)) Q:'SROCC  I $P(^SRF(SRTN,16,SROCC,0),"^",2)=27 S SRSTAT=$P(^SRF(SRTN,16,SROCC,0),"^",5) Q
 .K DIR S DIR(0)="130.22,8",DIR("A")="Cardiopulmonary Bypass Status",DA(1)=SRTN,DA=SROCC D ^DIR K DA,DR,DIE,DIR
 .I ($G(SRSTAT)=""&((X="")!(X="@")!(X["^")))!(Y=0) D DEL^SROUTC S DA=SRTN,DIE=130,DR="391////N" D ^DIE Q
 .I $G(SRSTAT)'="",X["^" Q
 .I $G(SRSTAT)'=Y,Y'="" S DA=SROCC,DA(1)=SRTN,DIE="^SRF(SRTN,16,",DR="8////"_Y D ^DIE Q
 I 'SRSOUT,SRBEF="Y",(X=""!(X="N")) D DEL^SROUTC
 Q
RET Q:SRSOUT  W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 Q

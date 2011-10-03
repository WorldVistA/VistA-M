SROACAR ;BIR/MAM - OPEATIVE DATA ;12/03/07
 ;;3.0; Surgery ;**38,71,93,95,100,125,142,153,166,174**;24 Jun 93;Build 8
 I '$D(SRTN) W !!,"A Surgery Risk Assessment must be selected prior to using this option.",!!,"Press <RET> to continue  " R X:DTIME G END
 S SRACLR=0,SRSOUT=0,SRSUPCPT=1 D ^SROAUTL
START D:SRACLR RET G:SRSOUT END S SRACLR=0 K SRA,SRAO D ^SROACR1
ASK W !,"Select Cardiac Procedures Operative Information to Edit: " R X:DTIME I '$T!("^"[X) G END
 S X=$S(X="a":"A",X="n":"N",1:X) I '$D(SRAO(X)),(X'?.N1":".N),(X'="A"),(X'="N") D HELP G:SRSOUT END G START
 I X="A" S X="1:22"
 I X?.N1":".N S Y=$E(X),Z=$P(X,":",2) I Y<1!(Z>22)!(Y>Z) D HELP G:SRSOUT END G START
 I X="N" D  G:SRSOUT END G START
 .W ! K DIR S DIR(0)="Y",DIR("B")="NO",DIR("A")="Are you sure you want to set all fields on this page to NO"
 .D ^DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 .I Y D NO2ALL
 D HDR^SROAUTL
 I X?.N1":".N D RANGE G START
 I $D(SRAO(X)),+X=X S EMILY=X D  G START
 .I $$LOCK^SROUTL(SRTN) W ! D ONE,UNLOCK^SROUTL(SRTN)
 I $D(SRAO(X)) W ! S EMILY=X D  G START
 .I $$LOCK^SROUTL(SRTN) D ONE,UNLOCK^SROUTL(SRTN)
END I 'SRSOUT D ^SROACR2
 W @IOF D ^SRSKILL
 Q
HELP W @IOF,!!!!,"Enter the number or range of numbers you want to edit.  Examples of proper",!,"responses are listed below."
 W !!,"1. Enter 'A' to update all information.",!!,"2. Enter 'N' to set all fields on this page to NO."
 W !!,"3. Enter a number (1-22) to update the information in that field.  (For",!,"   example, enter '9' to update Aortic Valve Procedure.)"
 W !!,"4. Enter a range of numbers (1-22) separated by a ':' to enter a range of",!,"   information.  (For example, enter '9:11' to enter Aortic Valve",!,"   Procedure, Mitral Valve Procedure, and Tricuspid Valve Procedure.)"
 D RET
 Q
RANGE ; range of numbers
 I $$LOCK^SROUTL(SRTN) D  D UNLOCK^SROUTL(SRTN)
 .W ! S SHEMP=$P(X,":"),CURLEY=$P(X,":",2) F EMILY=SHEMP:1:CURLEY Q:SRSOUT  D ONE
 Q
ONE ; edit one item
 ;I EMILY=16 D MIS^SROACR1 Q
 I EMILY=22 D OPS Q
 K DR,DIE S DA=SRTN,DR=$P(SRAO(EMILY),"^",2)_"T",DIE=130 D ^DIE K DR I $D(Y) S SRSOUT=1
 I 'SRSOUT,EMILY=8!(EMILY=13) D OK
 Q
NO2ALL ; set all fields to NO
 N II K DR,DIE S DA=SRTN,DIE=130
 F II=367,368,369,493,371,481,483,376,380,378,377,379,373,372,505,502 S DR=$S($D(DR):DR_";",1:"")_II_"////N"
 F II=365,366,464,465,416 S DR=DR_";"_II_"////0"
 S DR=DR_";"_512_"////N"
 D ^DIE K DR
 Q
OK N SRISCH,SRCPB S X=$G(^SRF(SRTN,206)),SRISCH=$P(X,"^",36),SRCPB=$P(X,"^",37)
 I SRISCH,SRCPB,SRISCH>SRCPB W !!,"  ***  NOTE: Ischemic Time is greater than CPB Time!!  Please check.  ***",! D RET W !
 Q
RET Q:SRSOUT  W ! K DIR S DIR(0)="E" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
OPS ; enter other cardiac procedures, specify
 S DIE=130,DA=SRTN,DR="502T" D ^DIE K DR Q:$D(Y)
 I X'="Y" K ^SRF(SRTN,209.1) Q
 S DIE=130,DA=SRTN,DR="484T" D ^DIE K DR
 Q

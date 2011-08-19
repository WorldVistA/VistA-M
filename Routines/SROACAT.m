SROACAT ;BIR/MAM - CARDIAC CATH INFO ;04/13/04  3:00 PM
 ;;3.0; Surgery ;**38,47,100,125,142,153**;24 Jun 93;Build 11
 I '$D(SRTN) W !!,"A Surgery Risk Assessment must be selected prior to using this option.",!!,"Press <RET> to continue  " R X:DTIME G END
 S SRACLR=0,SRSOUT=0,SRSUPCPT=1 D ^SROAUTL
START D:SRACLR RET G:SRSOUT END S SRACLR=0 D ^SROACTH
ASK W !!,"Select Cardiac Catheterization and Angiographic Information to Edit: " R X:DTIME I '$T!("^"[X) G END
 S:X="a" X="A" I '$D(SRAO(X)),(X'?.N1":".N),(X'="A") D HELP G:SRSOUT END G START
 I X="A" S X="1:8"
 I X?.N1":".N S Y=$E(X),Z=$P(X,":",2) I Y<1!(Z>8)!(Y>Z) D HELP G:SRSOUT END G START
 D HDR^SROAUTL
 I X?.N1":".N D RANGE G START
 I $D(SRAO(X)) S EMILY=X D  G START
 .I $$LOCK^SROUTL(SRTN) W !! D ONE,UNLOCK^SROUTL(SRTN)
END I 'SRSOUT D ^SROACTH1
 I '$D(SREQST) W @IOF D ^SRSKILL
 Q
HELP W @IOF,!!!!,"Enter the number or range of numbers you want to edit.  Examples of proper",!,"responses are listed below."
 W !!,"1. Enter 'A' to update all information.",!!,"2. Enter a number (1-8) to update the information in that field.  (For",!,"   example, enter '3' to update Aortic Systolic Pressure.)"
 W !!,"3. Enter a range of numbers (1-8) separated by a ':' to enter a range of",!,"   information.  (For example, enter '1:3' to update Procedure, LVEDP",!,"   and Aortic Systolic Pressure.)"
 W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1
 Q
RANGE ; range of numbers
 I $$LOCK^SROUTL(SRTN) D  D UNLOCK^SROUTL(SRTN)
 .W !! S SHEMP=$P(X,":"),CURLEY=$P(X,":",2) F EMILY=SHEMP:1:CURLEY Q:SRSOUT  D ONE
 Q
ONE ; edit one item
 N SRB S:EMILY=1 SRB=$P($G(^SRF(SRTN,209)),"^",4)
 K DR,DIE S DA=SRTN,DR=$P(SRAO(EMILY),"^",2)_"T",DIE=130 D ^DIE K DR I $D(Y)!$D(DTOUT) S SRSOUT=1 Q
 I EMILY=1 I SRB="NS"&($P($G(^SRF(SRTN,209)),"^",4)'="NS") D KAA
 I EMILY=1 I ($P($G(^SRF(SRTN,209)),"^",4)="NS") D ALL
 Q
RET Q:SRSOUT  W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 Q
ALL ; Entering NS for the procedure field should make all other fields in this Cath section default to NS also 
 K DIR S DIR("A")="Do you want to automatically enter 'NS' for NO STUDY for all other fields within  this option ",DIR("B")="YES"
 S DIR(0)="Y",DIR("?",1)="Enter ""YES"" to allow the software to automatically enter 'NS' on all fields within  this option.",DIR("?")="Enter ""NO"" to only enter 'NS' in the Procedure Type field."
 D ^DIR K DIR I $D(DTOUT)!$D(DUOUT)!('Y) Q
 K DIE,DR S DA=SRTN,DIE=130,DR="357////"_"NS"_";358////"_"NS"_";359////"_"NS"_";360////"_"NS"_";363////"_"NS"_";415////"_"NS"_";477////"_"NS"
 S DR=DR_";361////"_"NS"_";362.1////"_"NS"_";362.2////"_"NS"_";362.3////"_"NS"_";478////"_"NS"_";479////"_"NS"_";480////"_"NS"
 D ^DIE K DR
 Q
KAA ; if the value of the procedure type field is changed from NS to somthing else then prompt the user to delete the rest of the fields 
 N SRI K DIR W !,"You have changed the answer from ""NS""."
 S DIR("A")="Do you want to clear 'NS' from all other fields within this option ",DIR("B")="NO"
 S DIR(0)="Y",DIR("?",1)="Enter ""YES"" to allow the software to automatically clear 'NS' from all fields within this option.",DIR("?")="Enter ""NO"" to only delete 'NS' in the Procedure Type field."
 D ^DIR K DIR I $D(DTOUT)!$D(DUOUT)!('Y) Q
 K DIE,DR S DR="",DA=SRTN F SRI=357,358,359,360,363,415,477,361,362.1,362.2,362.3,478,479,480 I $$GET1^DIQ(130,SRTN,SRI,"I")="NS" S DR=DR_";"_SRI_"///@"
 S DR=$P(DR,";",2,20) I $L(DR)=0 K DR Q
 S DIE=130 D ^DIE K DR
 Q

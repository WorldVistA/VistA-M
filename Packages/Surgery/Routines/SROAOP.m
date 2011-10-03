SROAOP ;BIR/MAM - ENTER OPERATION INFO ;06/25/10
 ;;3.0; Surgery ;**19,38,47,63,67,81,86,97,100,125,142,153,160,166,171,174**;24 Jun 93;Build 8
 I '$D(SRTN) W !!,"A Surgery Risk Assessment must be selected prior to using this option.",!!,"Press <RET> to continue  " R X:DTIME G END
 S SRSOUT=0,SRSUPCPT=1 D ^SROAUTL
START G:SRSOUT END K SRAOTH,SRACON D ^SROAOP1
ASK W !!,"Select Operative Information to Edit: " R SRASEL:DTIME I '$T!(SRASEL["^") S SRSOUT=1 G END
 I SRASEL="" G END
 S SRN=13 S:SRASEL="a" SRASEL="A" I '$D(SRAO(SRASEL)),(SRASEL'?.N1":".N),(SRASEL'="A") D HELP G:SRSOUT END G START
 I SRASEL="A" S SRASEL="1:"_SRN
 I SRASEL?.N1":".N S Y=$E(SRASEL),Z=$P(SRASEL,":",2) I Y<1!(Z>SRN)!(Y>Z) D HELP G:SRSOUT END G START
 S MM=$E(SRASEL) I MM'=3,(MM'=4),(MM'=5) S SRHDR(.5)=SRDOC D HDR^SROAUTL
 I SRASEL?.N1":".N D RANGE G START
 Q:'$D(SRAO(SRASEL))
 S EMILY=SRASEL D  G START
 .I $$LOCK^SROUTL(SRTN) D ONE,UNLOCK^SROUTL(SRTN)
END I $D(SRSOUT),'SRSOUT D ^SROAOP2
 I $D(SRTN) S SROERR=SRTN D ^SROERR0
 W @IOF D ^SRSKILL
 Q
HELP W @IOF,!!!!,"Enter the number or range of numbers you want to edit. Examples of proper"
 W !,"responses are listed below.",!!,"1. Enter 'A' to update all information."
 W !!,"2. Enter a number (1-"_SRN_") to update the information in that field. (For"
 W !,"   example, enter '2' to update Principal Operation.)"
 W !!,"3. Enter a range of numbers (1-"_SRN_") separated by a ':' to enter a range of"
 W !,"   information. (For example, enter '6:8' to update PGY of Primary Surgeon,"
 W !,"   Surgical Priority and Wound Classification.)",!
PRESS K DIR S DIR(0)="E" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
RANGE ; range of numbers
 I $$LOCK^SROUTL(SRTN) D  D UNLOCK^SROUTL(SRTN)
 .S SHEMP=$P(SRASEL,":"),CURLEY=$P(SRASEL,":",2) F EMILY=SHEMP:1:CURLEY Q:SRSOUT  D ONE
 Q
ONE ; edit one item
 I EMILY=3 D DISP^SROAUTL0 Q
 I EMILY=10 D ANES Q
 I EMILY=4 D ^SROTHER Q
 I EMILY=5 D CONCUR Q
 I EMILY=6,SRASEL[":",($P(SRASEL,":")'=6) S SRPAGE="" S SRHDR(.5)=SRDOC D HDR^SROAUTL
 K DR,DIE S DA=SRTN,DR=$P(SRAO(EMILY),"^",2)_"T",DIE=130 D ^DIE K DR I $D(Y) S SRSOUT=1
 I EMILY=2 D ^SROAUTL
 Q
RET Q:SRSOUT  W !!,"Press ENTER to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 Q
CONCUR ; concurrent case information
 N SRPROC,SRCSTAT S SRLINE="" F I=1:1:80 S SRLINE=SRLINE_"-"
 S CON=$P($G(^SRF(SRTN,"CON")),"^") I CON,($P($G(^SRF(CON,30)),"^")!($P($G(^SRF(CON,31)),"^",8))) S CON=""
 S SRPAGE="" D HDR^SROAUTL
 W !,"Concurrent Procedure: An additional operative procedure performed by a"
 W !,"different surgical team (i.e., a different specialty/service) under the"
 W !,"same anesthetic which has a CPT code different from that of the Principal"
 W !,"Operative Procedure (e.g., fixation of a femur fracture in a patient"
 W !,"undergoing a laparotomy for trauma). This field should be verified and,"
 W !,"if need be, report discrepancies to the official CPT coder for surgery."
 I CON D CC W !!,"Concurrent Procedure: ",?22,SROPS(1) I $D(SROPS(2)) W !,?22,SROPS(2) I $D(SROPS(3)) W !,?22,SROPS(3) I $D(SROPS(4)) W !,?22,SROPS(4)
 I $D(SRCSTAT) W !!,?22,SRCSTAT
 W !!,"Press ENTER to continue " R X:DTIME
 Q
CC ; list concurrent procedure
 N SRTN,SRL,SRZ S SRCSTAT=">> Coding "_$S($P($G(^SRO(136,CON,10)),"^"):"",1:"Not ")_"Complete <<"
 S SRL=55,SRTN=CON D CPTS^SROAUTL0
 I SRPROC(1)="NOT ENTERED"!'$D(SRPROC(1)) S SRPROC(1)="CPT NOT ENTERED" K SRCSTAT
 S SROPER=$P(^SRF(CON,"OP"),"^")_" (" F I=1:1 Q:'$D(SRPROC(I))  S SROPER=SROPER_SRPROC(I)
 S SROPER=SROPER_")"
 K SROPS,MM,MMM S:$L(SROPER)<57 SROPS(1)=SROPER
 I $L(SROPER)>56 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 Q
LOOP ; break procedures
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<57  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
ANES N SRANE,SRNEW
 I $P(SRAO(10),"^")="NOT ENTERED",'$O(^SRF(SRTN,6,0)) D  Q
 .K DIR S DIR("A")="Select ANESTHESIA TECHNIQUE: ",DIR(0)="130.06,.01OA" D ^DIR K DIR S SRANE=Y I $D(DTOUT)!$D(DUOUT)!(Y="") Q
 .K DD,DO S DIC="^SRF(SRTN,6,",X=SRANE,DA(1)=SRTN,DIC(0)="L" D FILE^DICN K DIC,DD,DO I '+Y Q
 .S SRNEW=+Y
 .K DA,DIE,DR S DA=SRNEW,DA(1)=SRTN,DIE="^SRF(SRTN,6,",DR=".05T;42T" D ^DIE
 K DR,DIE,DA S DA=SRTN,DR=".37T",DR(2,130.06)=".01T;.05T;42T",DIE=130 D ^DIE K DR
 Q

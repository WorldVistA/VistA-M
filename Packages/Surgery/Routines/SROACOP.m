SROACOP ;BIR/MAM - CARDIAC OPERATIVE RISK SUMMARY ;05/05/10
 ;;3.0;Surgery;**38,47,71,88,95,107,100,125,142,153,160,166,174,175,182,184**;24 Jun 93;Build 35
 I '$D(SRTN) W !!,"A Surgery Risk Assessment must be selected prior to using this option.",!!,"Press <RET> to continue  " R X:DTIME G END
 N SRCSTAT S SRACLR=0,SRSOUT=0,SRSUPCPT=1 D ^SROAUTL
START D:SRACLR RET G:SRSOUT END S SRACLR=0 K SRA,SRAO
 F I=206,206.1,208 S SRA(I)=$G(^SRF(SRTN,I))
 S Y=$P($G(^SRF(SRTN,1.1)),"^",3),C=$P(^DD(130,1.13,0),"^",2) D:Y'="" Y^DIQ S SRAO(1)=Y_"^1.13"
 S SRAO(2)=$P(SRA(208),"^",12)_"^414"
 S Y=$P(SRAO(2),"^") I Y'="" S C=$P(^DD(130,414,0),"^",2) D Y^DIQ S $P(SRAO(2),"^")=Y
 S Y=$P(SRA(208),"^",13) D DT S SRAO("2A")=X_"^414.1"
 S SRCSTAT=">> Coding "_$S($P($G(^SRO(136,SRTN,10)),"^"):"",1:"Not ")_"Complete <<"
 S SRPAGE="PAGE: 1" D HDR^SROAUTL S SRAO(3)=""
 W !," 1. ASA Classification:",?31,$P(SRAO(1),"^"),!," 2. Surgical Priority:",?31,$P(SRAO(2),"^")
 S X=$P(SRAO("2A"),"^") I X'="" W !,?3," A. Date/Time Collected:    "_X
 N SRPROC,SRL S SRL=49 D CPTS^SROAUTL0 W !," 3. CPT Codes (view only):"
 F I=1:1 Q:'$D(SRPROC(I))  W:I=1 ?31,SRPROC(I) W:I'=1 !,?31,SRPROC(I)
 S Y=$P($G(^SRF(SRTN,"1.0")),"^",8),C=$P(^DD(130,1.09,0),"^",2) D:Y'="" Y^DIQ S SRAO(4)=Y_"^1.09"
 W !," 4. Wound Classification: ",?31,$P(SRAO(4),"^")
 W ! D CHCK
 W !! F MOE=1:1:80 W "-"
ASK W !,"Select Operative Risk Summary Information to Edit: " R X:DTIME I '$T!("^"[X) G END
 S:X="a" X="A" I '$D(SRAO(X)),(X'?.N1":".N),(X'="A") D HELP G:SRSOUT END G START
 I X="A" S X="1:4"
 I X?.N1":".N S Y=$E(X),Z=$P(X,":",2) I Y<1!(Z>4)!(Y>Z) D HELP G:SRSOUT END G START
 I X'=4 D HDR^SROAUTL
 I X?.N1":".N D RANGE S SROERR=SRTN D ^SROERR0 G START
 I $D(SRAO(X))!(X=4) S EMILY=X D  S SROERR=SRTN D ^SROERR0 G START
 .I $$LOCK^SROUTL(SRTN) W !! D ONE,UNLOCK^SROUTL(SRTN)
END I '$D(SREQST) W @IOF D ^SRSKILL
 Q
DT I 'Y S X="" Q
 X ^DD("DD") S X=$P(Y,"@")_" "_$P(Y,"@",2)
 Q
HELP W @IOF,!!!!,"Enter the number or range of numbers you want to edit.  Examples of proper",!,"responses are listed below."
 W !!,"1. Enter 'A' to update all information.",!!,"2. Enter the corresponding number to update the information in a particular",!,"   field.  (For example, enter '2' to update Surgical Priority)"
 W !!,"3. Enter two numbers separated by a ':' to enter a range of information.",!,"   (For example, enter '1:2' to update ASA Classification",!,"   Surgical Priority.)"
 W !!,"Press ENTER to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1
 Q
RANGE ; range of numbers
 I $$LOCK^SROUTL(SRTN) D  D UNLOCK^SROUTL(SRTN)
 .W !! S SHEMP=$P(X,":"),CURLEY=$P(X,":",2) F EMILY=SHEMP:1:CURLEY Q:SRSOUT  D ONE
 Q
ONE ; edit one item
 I EMILY=3 D DISP^SROAUTL0 Q
 K DR,DIE S DA=SRTN,DIE=130,DR=$P(SRAO(EMILY),"^",2)
 S DR=DR_"T",DIE=130 S DR=DR_$S(EMILY=2:";414.1T",1:"") D ^DIE K DR I $D(Y) S SRSOUT=1
 Q
RET Q:SRSOUT  W !!,"Press ENTER to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 Q
NOW ; update date/time of estimate of mortality
 N X D NOW^%DTC S $P(^SRF(DA,206),"^",32)=$E(%,1,12)
 Q
KNOW ; delete date/time of estimate of mortality
 S $P(^SRF(DA,206),"^",32)=""
 Q
YN ; store answer
 S SHEMP=$S(NYUK="NS":"Unknown",NYUK="N":"NO",NYUK="Y":"YES",1:"")
 Q
CHCK ;compare dates
 N SRINO,SRSP
 S SRSP=$P($G(^SRF(SRTN,208)),"^",13),SRINO=$P($G(^SRF(SRTN,.2)),"^",10)
 I SRSP'="",SRINO'="",SRSP'<SRINO W !!,"*** NOTE: D/Time of Surgical Priority should be < the D/Time Patient in OR.***"
 Q

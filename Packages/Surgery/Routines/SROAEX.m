SROAEX ;BIR/MAM - EXCLUSION CRITERIA ;03/22/07
 ;;3.0; Surgery ;**38,47,63,88,142,153,160**;24 Jun 93;Build 7
 N SRCSTAT S SRACLR=0,SRSOUT=0 D NCODE^SROAUTL
START D:SRACLR RET G:SRSOUT END S SRACLR=0 K SRA,SRAO S SRAO(4)=""
 S SR(0)=^SRF(SRTN,0),Y=$P($G(^SRF(SRTN,"RA")),"^",7) D CRITERIA S SRAO(1)=NYUK_"^102"
 S SRAO(2)=$P(SR(0),"^",10)_"^.035",X=$P(SRAO(2),"^") I X'="" S $P(SRAO(2),"^")=$S(X="EL":"ELECTIVE",X="EM":"EMERGENT",X="U":"URGENT",X="A":"ADD ON TODAY (NONEMERGENT)",X="S":"STANDBY",1:"")
 S SHEMP=$P(SR(0),"^",4) S:SHEMP SHEMP=$P(^SRO(137.45,SHEMP,0),"^"),SRAO(3)=SHEMP_"^.04"
 S SRCSTAT=">> Coding "_$S($P($G(^SRO(136,SRTN,10)),"^"):"",1:"Not ")_"Complete <<"
 D TECH^SROPRIN S:SRTECH="NOT ENTERED" SRTECH="" S SRAO(5)=SRTECH
 D TSTAT^SRO1L1,HDR^SROAUTL
 W !,"1. Exclusion Criteria: ",?35,$P(SRAO(1),"^"),!,"2. Surgical Priority:",?35,$P(SRAO(2),"^"),!,"3. Surgical Specialty:",?35,$P(SRAO(3),"^")
 N SRPROC,SRL S SRL=45 D CPTS^SROAUTL0 W !,"4. CPT Codes (view only):"
 F I=1:1 Q:'$D(SRPROC(I))  W:I=1 ?35,SRPROC(I) W:I'=1 !,?35,SRPROC(I)
 W !,"5. Principal Anesthesia Technique: "_$P(SRAO(5),"^"),!! F LINE=1:1:80 W "-"
ASK W !!,"Select Excluded Case Information to Edit: " R X:DTIME I '$T!("^"[X) G END
 S:X="a" X="A" I '$D(SRAO(X)),(X'?.N1":".N),(X'="A") D HELP G:SRSOUT END G START
 I X="A" S X="1:5"
 I X?.N1":".N S Y=$E(X),Z=$P(X,":",2) I Y<1!(Z>5)!(Y>Z) D HELP G:SRSOUT END G START
 D TSTAT^SRO1L1,HDR^SROAUTL
 I X?.N1":".N D RANGE,AQ G START
 I $D(SRAO(X)) S EMILY=X W !! D ONE,AQ G START
END D AQ W @IOF D ^SRSKILL
 Q
HELP W @IOF,!!!!,"Enter the number or range of numbers you want to edit. Examples of proper"
 W !,"responses are listed below.",!!,"1. Enter 'A' to update all information."
 W !!,"2. Enter a number (1-5) to update the information in that field. (For"
 W !,"   example, enter '2' to update Surgical Priority)"
 W !!,"3. Enter a range of numbers (1-5) separated by a ':' to enter a range of"
 W !,"   information. (For example, enter '1:2' to update the Exclusion Criteria "
 W !,"   and Surgical Priority)" D RET
 Q
AQ ; update transmission status
 K DA,DIK S DIK="^SRF(",DIK(1)=".232^AQ",DA=SRTN D EN1^DIK K DA,DIK
 Q
RANGE ; range of numbers
 W !! S SHEMP=$P(X,":"),CURLEY=$P(X,":",2) F EMILY=SHEMP:1:CURLEY Q:SRSOUT  D ONE I EMILY=4 D HDR^SROAUTL
 Q
ONE ; edit one item
 I EMILY=1 D REASON Q
 I EMILY=4 D DISP^SROAUTL0 Q
 I EMILY=5 D UPANES Q
 K DR,DIE S DA=SRTN,DR=$P(SRAO(EMILY),"^",2)_"T",DIE=130 D ^DIE K DR I $D(Y) S SRSOUT=1
 Q
RET Q:SRSOUT  W ! K DIR S DIR(0)="E" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
CRITERIA ; expand set of codes for exclusion criteria
 S C=$P(^DD(130,102,0),"^",2) D Y^DIQ S NYUK=Y
 S SHEMP=$P(^SRF(SRTN,0),"^",10),MOE=$S(SHEMP="E":"ELECTIVE",SHEMP="M":"EMERGENCY",SHEMP="U":"URGENT",1:"")
 Q
UPANES K DR,DIE,DA S DA=SRTN,DR=.37,DR(2,130.06)=".01T;.05T;42T",DIE=130 D ^DIE K DR
 Q
REASON W ! K DIR S DIR(0)="130,102",DIR("A")="Reason for not Creating an Assessment",DIR("B")=$P(SRAO(1),"^") D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 I X="@" D DELETE^SRONASS S SRSOUT=1 Q
 I Y'="" K DR,DIE,DA S DA=SRTN,DIE=130,DR="102////"_Y D ^DIE K DA,DIE,DR
 Q

SROACCR ;B'HAM ISC/MAM - CARDIAC COMPLICATON DATA ; 5 MAR 1992 10:00 am
 ;;3.0; Surgery ;;24 Jun 93
 I '$D(SRTN) W !!,"A Surgery Risk Assessment must be selected prior to using this option.",!!,"Press <RET> to continue  " R X:DTIME G END
 S SRACLR=0,SRSOUT=0,DFN=$P(^SRF(SRTN,0),"^") D DEM^VADPT S SRANAME=$P(VADM(1),"^")_"  ("_VA("PID")_")"
START D:SRACLR RET G:SRSOUT END S SRACLR=0 K SRA,SRAO D ^SROACRC
ASK W !!,"Select Complication Information to Edit: " R X:DTIME I '$T!("^"[X) G END
 S:X="a" X="A" I '$D(SRAO(X)),(X'?.N1":".N),(X'="A"),(X'="NONE") D HELP G:SRSOUT END G START
 I X="NONE" K DR S DIE=130,DA=SRTN,DR="[SRISK-CCOMP]" D ^DIE K DR,DIE,DA G START
 I X="A" S X=1
 I X?.N1":".N S Y=$E(X),Z=$P(X,":",2) I Y<1!(Z>13)!(Y>Z) D HELP G:SRSOUT END G START
 W @IOF,!,SRANAME,! F MOE=1:1:80 W "-"
 I X?.N1":".N D RANGE G START
 I $D(SRAO(X)) S EMILY=X W !! D ONE G START
END W @IOF D ^SRSKILL
 Q
HELP W @IOF,!!!!,"Enter the number or range of numbers you want to edit.  Examples of proper",!,"responses are listed below."
 W !!,"1. Enter 'A' to update all information.",!!,"2. Enter a number (1-14) to update the information in that field.  (For",!,"   example, enter '7' to update Mediastinitis)"
 W !!,"3. Enter a range of numbers (1-14) separated by a ':' to enter a range of",!,"   information.  (For example, enter '3:5' to update Preoperative MI,",!,"   Endocarditis, and Renal Failure Requiring Dialysis)"
 W !!,"4. Enter 'NONE' to answer all complications as 'NO'"
 W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1
 Q
RANGE ; range of numbers
 W !! K NOGO S SHEMP=$P(X,":"),CURLEY=$P(X,":",2) F EMILY=SHEMP:1:CURLEY Q:SRSOUT!($D(NOGO))  D ONE
 Q
ONE ; edit one item
 I EMILY>1 D NOGO Q
 K DR,DIE S DA=SRTN,DR=$P(SRAO(EMILY),"^",2)_"T",DIE=130 D ^DIE K DR I $D(Y) S SRSOUT=1
 Q
RET Q:SRSOUT  W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 Q
NOGO ; no updates to complications
 W @IOF,!,"You cannot update any fields within this option except 'Operative Death (Y/N)'.",!!,"The complication information must be entered using the options within the",!,"Complications Menu found on your main Surgery Risk Assessment menu."
 W !!,"Press RETURN to continue  " R X:DTIME
 S NOGO=1
 Q

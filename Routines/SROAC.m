SROAC ;B'HAM ISC/MAM - NON-CARDIAC COMPLICATIONS ; 4 MAR 1992  7:55 am
 ;;3.0; Surgery ;;24 Jun 93
 S SRSOUT=0,DFN=$P(^SRF(SRTN,0),"^") D DEM^VADPT S SRANAME=$P(VADM(1),"^")_"  ("_VA("PID")_")"
START Q:SRSOUT  K SRAO,SRA D ^SROACS
ASK W !!,"Select Postoperative Complication: " R X:DTIME I '$T!("^"[X) G END
 I '$D(SRAO(X)),(X'?1N1":"1N),(X'="A"),(X'="NONE") D HELP G:SRSOUT END G START
 I X?1N1":"1N S Y=$P(X,":"),Z=$P(X,":",2) I Y<1!(Z>6)!(Y>Z) D HELP G:SRSOUT END G START
 I X="NONE" K DR,DIE S DA=SRTN,DIE=130,DR="[SRA-NOCOMP]" D ^DIE G START
 W @IOF,!,SRANAME,! F MOE=1:1:80 W "-"
 I X="A" S X="1:6"
 W !! I X?1N1":"1N D RANGE G START
 I $D(SRAO(X)),+X=X S EMILY=X D ^SROAC2 G START
 I $D(SRAO(X)) K DR,DIE S DA=SRTN,DR=$P(SRAO(X),"^",2)_"T",DIE=130 D ^DIE K DR G START
END Q
HELP W @IOF,!!!!,"Enter the number, number/letter combination, or range of numbers you want to",!,"edit.  Examples of proper responses are listed below."
 W !!,"1. Enter 'A' to update all complications.",!!,"2. Enter a number (1-6) to update the complications in that group.  (For",!,"   example, enter '5' to update all cardiac complications)"
 W !!,"3. Enter a number/letter combination to update a specific complication. (To ",!,"   update Acute Renal Failure, enter '3B')"
 W !!,"4. Enter a range of numbers (1-6) separated by a ':' to enter a range of",!,"   complications.  (For example, enter '2:4' to enter all respiratory, urinary",!,"   tract, and CNS complications)"
 W !!,"5. Enter 'NONE' to enter 'NO' for all complications."
 W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1
 Q
RANGE ; range of numbers
 S SHEMP=$P(X,":"),CURLEY=$P(X,":",2) F EMILY=SHEMP:1:CURLEY Q:SRSOUT  D ^SROAC2
 Q
RET Q:SRSOUT  W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 I X["?" W !!,"Enter <RET> to re-display all complication information, or '^' to return to",!,"the previous menu." G RET
 Q

SROAO ;B'HAM ISC/MAM - OUTCOMES ; [ 01/29/01  9:22 AM ]
 ;;3.0; Surgery ;**100**;24 Jun 93
 I '$D(SRTN) W !!,"A Surgery Risk Assessment must be selected prior to using this option.",!!,"Press <RET> to continue  " R X:DTIME G END
 S SRSOUT=0,DFN=$P(^SRF(SRTN,0),"^") D DEM^VADPT S SRANAME=$P(VADM(1),"^")_"  ("_VA("PID")_")"
START G:SRSOUT END D ^SROAOSET
ASK W !!,"Select Postoperative Outcome: " R X:DTIME I '$T!(X["^") G END
 I X="" G END
 I '$D(SRAO(X)),(X'?1N1":"1N),(X'="A") D HELP G:SRSOUT END G START
 I X?1N1":"1N S Y=$P(X,":"),Z=$P(X,":",2) I Y<1!(Z>3)!(Y>Z) D HELP G:SRSOUT END G START
 W @IOF,!,SRANAME,! F MOE=1:1:80 W "-"
 I X="A" S X="1:3"
 I X?1N1":"1N W !! D RANGE G START
 I $D(SRAO(X)),+X=X S EMILY=X D  G START
 .I $$LOCK^SROUTL(SRTN) W:X<6 !! D ONE,UNLOCK^SROUTL(SRTN)
END W @IOF D ^SRSKILL
 Q
HELP W @IOF,!!!!,"Enter the number, number/letter combination, or range of numbers you want to",!,"edit.  Examples of proper responses are listed below."
 W !!,"1. Enter 'A' to update all outcome information.",!!,"2. Enter a number (1-3) to update an individual outcome element.  (For",!,"   example, enter '1' to update all postoperative diagnosis)"
 W !!,"3. Enter a range of numbers (1-3) separated by a ':' to enter a range of",!,"   outcomes.  (For example, enter '1:3' to enter postoperative diagnosis,",!,"   length of postoperative stay, and 30 day postoperative status)"
 W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1
 Q
RANGE ; range of numbers
 I $$LOCK^SROUTL(SRTN) D  D UNLOCK^SROUTL(SRTN)
 .S SHEMP=$P(X,":"),CURLEY=$P(X,":",2) F EMILY=SHEMP:1:CURLEY Q:SRSOUT  D ONE
 Q
ONE ; edit one item
 K DR,DA,DIE S DR=$P(SRAO(EMILY),"^",2)_"T",DA=SRTN,DIE=130 D ^DIE K DR,DA
 Q

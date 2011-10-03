SROALN2 ;BIR/MAM - LAB INFO ;01/27/06
 ;;3.0; Surgery ;**38,88,100,153**;24 Jun 93;Build 11
 S SRSOUT=0 I '$D(SRTN) W !!,"A Surgery Risk Assessment must be selected prior to using this option.",!!,"Press <RET> to continue  " R X:DTIME G END
 D ^SROAUTL
START G:SRSOUT END K SRA,SRAO D ^SROALN3
ASK W !!,"Select Postoperative Laboratory Information to Edit: " R X:DTIME I '$T!(X["^") S SRSOUT=1 G END
 I X="" Q
 S:X="a" X="A" I '$D(SRAO(X)),(X'?.N1":".N),(X'="A") D HELP G:SRSOUT END G START
 I X="A" S X="1:13"
 I X?.N1":".N S Y=$E(X),Z=$P(X,":",2) I Y<1!(Z>13)!(Y>Z) D HELP G:SRSOUT END G START
 S SRPAGE="" D HDR^SROAUTL
 I X?.N1":".N D RANGE G START
 I $D(SRAO(X)) S EMILY=X D  G START
 .I $$LOCK^SROUTL(SRTN) D ONE,UNLOCK^SROUTL(SRTN)
END W @IOF
 Q
HELP W @IOF,!!!!,"Enter the number or range of numbers you want to edit.  Examples of proper",!,"responses are listed below."
 W !!,"1. Enter 'A' to update all information.",!!,"2. Enter a number (1-13) to update the information in that field.  (For",!,"   example, enter '6' to update Highest Serum Creatinine)"
 W !!,"3. Enter a range of numbers (1-13) separated by a ':' to enter a range of",!,"   information.  (For example, enter '2:4' to update Highest Serum Sodium,",!,"   Lowest Serum Sodium, and Highest Potassium)"
 W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1
 Q
RANGE ; range of numbers
 I $$LOCK^SROUTL(SRTN) D  D UNLOCK^SROUTL(SRTN)
 .S SRNOMORE=0,SHEMP=$P(X,":"),CURLEY=$P(X,":",2) F EMILY=SHEMP:1:CURLEY Q:SRNOMORE  D ONE
 Q
ONE ; edit one item
 K DR,DIE S DA=SRTN,DR=$P(SRAO(EMILY),"^",3)_"T;"_$P(SRAO(EMILY),"^",4)_"T",DIE=130 D ^DIE S:$D(Y) SRNOMORE=1 K DR
 Q
RET Q:SRSOUT  W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 Q

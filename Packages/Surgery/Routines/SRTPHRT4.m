SRTPHRT4 ;BIR/SJA - HEART-RISK ASSESSMENT INFO ;03/04/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 I '$D(SRTPP) W !!,"A Transplant Assessment must be selected prior to using this option.",!!,"Press <RET> to continue  " R X:DTIME G END
START Q:SRSOUT  D DISP
 W !!,"Select Transplant Information to Edit: " R X:DTIME I '$T!(X["^") S SRSOUT=1 G END
 I X="" D ^SRTPHRT5 G END
 S:X="a" X="A" I '$D(SRAO(X)),(X'?.N1":".N),(X'="A") D HELP G:SRSOUT END G START
 I X?1.2N1":"1.2N S Y=$P(X,":"),Z=$P(X,":",2) I Y<1!(Z>SRX)!(Y>Z) D HELP G:SRSOUT END G START
 I X="A" S X="1:"_SRX
 D HDR^SRTPUTL
 I X?.N1":".N D RANGE G START
 I $D(SRAO(X)) S SREMIL=X W !! D ONE G START
END W @IOF
 Q
HELP W @IOF,!!!!,"Enter the number or range of numbers you want to edit.  Examples of proper",!,"responses are listed below."
 W !!,"1. Enter 'A' to update all information.",!!,"2. Enter a number (1-"_SRX_") to update the information in that field.  (For",!,"   example, enter '1' to update Liver Disease)"
 W !!,"3. Enter a range of numbers (1-"_SRX_") separated by a ':' to enter a range",!,"   of items.  (For example, enter '1:4' to update items 1, 2, 3 and 4.)",!
 W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1
 Q
RANGE ; range of numbers
 W !! S SRNOMORE=0,SRSHEMP=$P(X,":"),SRCURL=$P(X,":",2) F SREMIL=SRSHEMP:1:SRCURL Q:SRNOMORE  D ONE
 Q
ONE ; edit one item
 K DR,DIE S DA=SRTPP,DR=$P(SRAO(SREMIL),"^",2)_"T",DIE=139.5 D ^DIE K DR I $D(Y) S SRNOMORE=1
 Q
DISP ; display fields
 S SRPAGE="PAGE: 4 OF "_$S(SRNOVA:6,1:4),SRHPG="RISK ASSESSMENT INFORMATION" D HDR^SRTPUTL
 K SRAO,DR S SRDR="75;154;108;115;81;82;90;83;153"
 K DA,DIC,DIQ,SRX,SRY S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
 W !,"1. Liver Disease:",?36,$P(SRAO(1),"^")
 W !,"2. Creatinine on Day of Transplant:",?36,$P(SRAO(2),"^")
 W !,"3. HIV+ (positive):",?36,$P(SRAO(3),"^")
 W !,"4. Active Infection Pre-Transplant:",?36,$P(SRAO(4),"^")
 W !,"5. Pre-Transplant Skin Malignancy:",?36,$P(SRAO(5),"^")
 W !,"6. Pre-Transplant Other Malignancy:",?36,$P(SRAO(6),"^")
 W !,"7. Non-Compliance (Med and Diet):",?36,$P(SRAO(7),"^")
 W !,"8. Recipient Substance Abuse:",?36,$P(SRAO(8),"^")
 W !,"9. Prior Blood Transfusion:",?36,$P(SRAO(9),"^")
 W !!,SRLINE
 Q

SRTPLUN1 ;BIR/SJA - LUNG-RECIPIENT INFORMATION ;03/04/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 I '$D(SRTPP) W !!,"A Transplant Assessment must be selected prior to using this option.",!!,"Press <RET> to continue  " R X:DTIME G END
 S (SRSOUT,SRNXT)=0,$P(SRLINE,"-",80)="" D SRHDR^SRTPUTL
START Q:SRSOUT!(SRNXT)  D DISP
 W !,"Select Transplant Information to Edit: " R X:DTIME I '$T!(X["^") S SRSOUT=1 G END
 I X="" D ^SRTPLUN2 G END
 S:X="a" X="A" I '$D(SRAO(X)),(X'?.N1":".N),(X'="A") D HELP G:SRSOUT END G START
 I X?1.2N1":"1.2N S Y=$P(X,":"),Z=$P(X,":",2) I Y<1!(Z>SRX)!(Y>Z) D HELP G:SRSOUT END G START
 I X="A" S X="1:"_SRX
 D HDR^SRTPUTL
 I X?.N1":".N D RANGE G START
 I $D(SRAO(X)) S SREMIL=X W !! D ONE G START
END W @IOF
 Q
HELP W @IOF,!!!!,"Enter the number or range of numbers you want to edit.  Examples of proper",!,"responses are listed below."
 W !!,"1. Enter 'A' to update all information.",!!,"2. Enter a number (1-"_SRX_") to update the information in that field.  (For",!,"   example, enter '1' to update VACO ID.)"
 W !!,"3. Enter a range of numbers (1-"_SRX_") separated by a ':' to enter a range",!,"   of items.  (For example, enter '1:4' to update items 1, 2, 3 and 4.)",!
 W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1
 Q
RANGE ; range of numbers
 W !! S SRNOMORE=0,SRSHEMP=$P(X,":"),SRCURL=$P(X,":",2) F SREMIL=SRSHEMP:1:SRCURL Q:SRNOMORE  D ONE
 Q
ONE ; edit one item
 K DR,DIE S DA=SRTPP,DR=$P(SRAO(SREMIL),"^",2)_"T",DIE=139.5 D ^DIE K DR I $D(Y) S SRNOMORE=1 Q
 I $P(SRAO(SREMIL),"^",2)=1!($P(SRAO(SREMIL),"^",2)=3) D SRHDR^SRTPUTL
 Q
DISP ; display fields
 K SRCT S SRPAGE="PAGE: 1 OF "_$S(SRNOVA:5,1:4),SRHPG="RECIPIENT INFORMATION" D HDR^SRTPUTL
 K SRAO,DR S:SRNOVA SRDR="3;1;11;4;5;10;12;40;41;24;25;32;129;19;43;22;128;94"
 S:'SRNOVA SRDR="3;11;10;12;40;41;24;25;32;43;22;128;94;129;19"
 K DA,DIC,DIQ,SRX,SRY S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
 I SRNOVA D HW^SRTPUTL D
 .W !,"1.  VACO ID:",?37,$P(SRAO(1),"^"),?55,"15. Sarcoidosis:",?72,$P(SRAO(15),"^")
 .S Y=$P(SRAO(2),"^") X ^DD("DD") W !,"2.  Date of Transplant:",?37,Y,?55,"16. Lung Cancer:",?72,$P(SRAO(16),"^")
 .W !,"3.  Date Placed on Waiting List:",?37,$P(SRAO(3),"^"),?55,"17: Emphysema:",?72,$P(SRAO(17),"^")
 .S SRAO(4)=$$OUT(4,$P(^SRT(SRTPP,0),"^",4))_"^4"
 .W !,"4.  Recipient Height:",?37,$P(SRAO(4),"^"),?55,"18. Rejection:",?72,$P(SRAO(18),"^")
 .S SRAO(5)=$$OUT(5,$P(^SRT(SRTPP,0),"^",5))_"^5"
 .W !,"5.  Recipient Weight:",?37,$P(SRAO(5),"^")
 .W !,"6.  Recipient ABO Blood Type:",?37,$P(SRAO(6),"^")
 .W !,"7.  Recipient CMV:",?37,$P(SRAO(7),"^")
 .W !,"8.  Pulmonary Fibrosis:",?37,$P(SRAO(8),"^")
 .W !,"9.  Pulmonary Hypertension:",?37,$P(SRAO(9),"^")
 .W !,"10. Alpha 1 Anti-Trypsin Deficiency:",?37,$P(SRAO(10),"^")
 .W !,"11. Bronchiectasis:",?37,$P(SRAO(11),"^")
 .W !,"12. Interstitial Lung Disease:",?37,$P(SRAO(12),"^")
 .W !,"13. Other Diagnosis: ",$P(SRAO(13),"^")
 .W !!,"14. Transplant Comments: " S SREXT=$P(SRAO(14),"^") D COMM^SRTPLIV1
 I 'SRNOVA D
 .W !,"1.  VACO ID:",?37,$P(SRAO(1),"^")
 .W !,"2.  Date Placed on Waiting List:",?37,$P(SRAO(2),"^")
 .W !,"3.  Recipient ABO Blood Type:",?37,$P(SRAO(3),"^")
 .W !,"4.  Recipient CMV:",?37,$P(SRAO(4),"^")
 .W !,"5.  Pulmonary Fibrosis:",?37,$P(SRAO(5),"^")
 .W !,"6.  Pulmonary Hypertension:",?37,$P(SRAO(6),"^")
 .W !,"7.  Alpha 1 Anti-Trypsin Deficiency:",?37,$P(SRAO(7),"^")
 .W !,"8.  Bronchiectasis:",?37,$P(SRAO(8),"^")
 .W !,"9.  Interstitial Lung Disease:",?37,$P(SRAO(9),"^")
 .W !,"10. Sarcoidosis:",?37,$P(SRAO(10),"^")
 .W !,"11. Lung Cancer:",?37,$P(SRAO(11),"^")
 .W !,"12. Emphysema:",?37,$P(SRAO(12),"^")
 .W !,"13. Rejection:",?37,$P(SRAO(13),"^")
 .W !,"14. Other Diagnosis: ",$P(SRAO(14),"^")
 .W !!,"15. Transplant Comments: " S SREXT=$P(SRAO(15),"^") D COMM^SRTPLIV1
 W !,SRLINE
 Q
OUT(SRFLD,SRY) ; get data in output form
 N C,Y,Z
 S Y=SRY,C=$P(^DD(139.5,SRFLD,0),"^",2) D:Y'="" Y^DIQ
 I Y="NO STUDY" S Y="NS"
 I SRFLD=4!(SRFLD=5) S Y=$E(Y,1,15)
 Q Y

SRTPHRT1 ;BIR/SJA - HEART-RECIPIENT INFORMATION ;03/04/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 I '$D(SRTPP) W !!,"A Transplant Assessment must be selected prior to using this option.",!!,"Press <RET> to continue  " R X:DTIME S SRSOUT=1 G END
 S SRSOUT=0,$P(SRLINE,"-",80)="" D SRHDR^SRTPUTL
START Q:SRSOUT  D DISP
 W !,"Select Transplant Information to Edit: " R X:DTIME I '$T!(X["^") S SRSOUT=1 G END
 I X="" D ^SRTPHRT2 G END
 S:X="a" X="A" I '$D(SRAO(X)),(X'?.N1":".N),(X'="A") D HELP G:SRSOUT END G START
 I X?1.2N1":"1.2N S Y=$P(X,":"),Z=$P(X,":",2) I Y<1!(Z>SRX)!(Y>Z) D HELP G:SRSOUT END G START
 I X="A" S X="1:"_SRX
 D HDR^SRTPUTL
 I X?.N1":".N D RANGE G START
 I $D(SRAO(X)) S SREMIL=X D ONE G START
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
 S SRHPG="RECIPIENT INFORMATION",SRPAGE="PAGE: 1 OF "_$S(SRNOVA:6,1:4) D HDR^SRTPUTL
 K SRAO,DR S SRQ=0
 S SRDR=$S(SRNOVA:"3;1;11;58;57;4;5;10;12;167;168;163;164;19;165;89;166;68",1:"3;11;58;57;163;164;165;89;166;68;10;12;19")
 K DA,DIC,DIQ,SRX,SRY S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
  ; heart Transplant Assessments (VA)
VA I 'SRNOVA D
 .W !,"1.  VACO ID:",?29,$P(SRAO(1),"^")
 .W !,"2.  Date Listed with UNOS:",?29,$P(SRAO(2),"^")
 .W !,"3.  UNOS at Time of Listing:",?29,$P(SRAO(3),"^")
 .W !,"4.  UNOS at Time of Trans:",?29,$P(SRAO(4),"^")
 .W !,"5.  PVR Before Vasodilation:",?29,$P(SRAO(5),"^")
 .W !,"6.  PVR After Vasodilation:",?29,$P(SRAO(6),"^")
 .W !,"7.  LVEF %:",?29,$P(SRAO(7),"^")
 .W !,"8.  Total Isch. time:",?29,$P(SRAO(8),"^")
 .W !,"9.  PRA %:",?29,$P(SRAO(9),"^")
 .W !,"10. Crossmatch D/R:",?29,$P(SRAO(10),"^")
 .W !,"11. ABO Blood Type:",?29,$P(SRAO(11),"^")
 .W !,"12. Recipient CMV:",?29,$P(SRAO(12),"^")
 .W !!,"13. Transplant Comments: " S SREXT=$P(SRAO(13),"^") D COMM^SRTPLIV1
 ; heart Transplant Assessments (non-VA)
NONVA I SRNOVA D
 .W !,"1.  VACO ID:",?29,$P(SRAO(1),"^")
 .S Y=$P(SRAO(2),"^") X ^DD("DD") W !,"2.  Date of Transplant:",?29,Y
 .W !,"3.  Date Listed with UNOS:",?29,$P(SRAO(3),"^"),?45,"15. LVEF %:",?67,$P(SRAO(15),"^")
 .W !,"4.  UNOS at Time of Listing:",?29,$P(SRAO(4),"^"),?45,"16. Total Isch. Time:",?67,$P(SRAO(16),"^")
 .W !,"5.  UNOS at Time of TX:",?29,$P(SRAO(5),"^"),?45,"17. PRA %:",?67,$P(SRAO(17),"^")
 .D HW^SRTPUTL
 .S SRAO(6)=$$OUT^SRTPLUN1(4,$P(^SRT(SRTPP,0),"^",4))_"^4"
 .W !,"6.  Recipient Height:",?29,$P(SRAO(6),"^"),?45,"18. Crossmatch D/R:",?67,$P(SRAO(18),"^")
 .S SRAO(7)=$$OUT^SRTPLUN1(5,$P(^SRT(SRTPP,0),"^",5))_"^5"
 .W !,"7.  Recipient Weight:",?29,$P(SRAO(7),"^")
 .W !,"8.  ABO Blood Type:",?29,$P(SRAO(8),"^")
 .W !,"9.  Recipient CMV:",?29,$P(SRAO(9),"^")
 .W !,"10. PA Systolic Pressure:",?29,$P(SRAO(10),"^")
 .W !,"11. PAW Mean Pressure:",?29,$P(SRAO(11),"^")
 .W !,"12. PVR Before Vasodilation:",?29,$P(SRAO(12),"^")
 .W !,"13. PVR After Vasodilation:",?29,$P(SRAO(13),"^")
 .W !!,"14. Transplant Comments: " S SREXT=$P(SRAO(14),"^") D COMM^SRTPLIV1
 W !,SRLINE
 Q

SRTPLIV1 ;BIR/SJA - LIVER-RECIPIENT INFORMATION ;03/04/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 I '$D(SRTPP) W !!,"A Transplant Assessment must be selected prior to using this option.",!!,"Press <RET> to continue  " R X:DTIME S SRSOUT=1 G END
 S SRSOUT=0,$P(SRLINE,"-",80)="" D SRHDR^SRTPUTL
START Q:SRSOUT  D DISP
 W !!,"Select Transplant Information to Edit: " R X:DTIME I '$T!(X["^") S SRSOUT=1 G END
 I X="" D ^SRTPLIV2 G END
 S:X="a" X="A" I '$D(SRAO(X)),(X'?.N1":".N),(X'="A") D HELP G:SRSOUT END G START
 I X?1.2N1":"1.2N S Y=$P(X,":"),Z=$P(X,":",2) I Y<1!(Z>SRX)!(Y>Z) D HELP G:SRSOUT END G START
 I X="A" S X="1:"_SRX
 D HDR^SRTPUTL
 I X?.N1":".N D RANGE G START
 I $D(SRAO(X)) S SREMIL=X W !! D ONE G START
END W @IOF
 Q
HELP W @IOF,!!!!,"Enter the number or range of numbers you want to edit.  Examples of proper",!,"responses are listed below."
 W !!,"1. Enter 'A' to update all information.",!!,"2. Enter a number (1-"_SRX_") to update the information in that field.  (For",!,"   example, enter '3' to update "_$S('SRNOVA:"Recipient ABO Blood Type",1:"Date Placed on Waiting List")_")"
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
 S SRPAGE="PAGE: 1 OF "_$S(SRNOVA:7,1:5),SRHPG="RECIPIENT INFORMATION" D HDR^SRTPUTL
 K SRAO,DR
 S SRDR=$S(SRNOVA:"3;1;11;4;5;10;12;52;53;54;55;19",1:"3;11;10;12;52;53;54;55;19")
 K DA,DIC,DIQ,SRX,SRY S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
VA I 'SRNOVA D  W !!,SRLINE Q
 .W !,"1. VACO ID:",?35,$P(SRAO(1),"^")
 .W !,"2. Date Placed on Waiting List:",?35,$P(SRAO(2),"^")
 .W !,"3. Recipient ABO Blood Type:",?35,$P(SRAO(3),"^")
 .W !,"4. Recipient CMV:",?35,$P(SRAO(4),"^")
 .W !,"5. MELD Score at Listing:",?35,$P(SRAO(5),"^")
 .W !,"6. Biologic MELD Score at Listing:",?35,$P(SRAO(6),"^")
 .W !,"7. Meld Score at Transplant:",?35,$P(SRAO(7),"^")
 .W !,"8. Biologic MELD Score at TX:",?35,$P(SRAO(8),"^")
 .W !!,"9. Transplant Comments: " S SREXT=$P(SRAO(9),"^") D COMM
NONVA I SRNOVA D
 .W !,"1.  VACO ID:",?36,$P(SRAO(1),"^")
 .S Y=$P(SRAO(2),"^") X ^DD("DD") W !,"2.  Date of Transplant:",?36,Y
 .W !,"3.  Date Placed on Waiting List:",?36,$P(SRAO(3),"^")
 .D HW^SRTPUTL
 .S SRAO(4)=$$OUT^SRTPLUN1(4,$P(^SRT(SRTPP,0),"^",4))_"^4" W !,"4.  Recipient Height:",?36,$P(SRAO(4),"^")
 .S SRAO(5)=$$OUT^SRTPLUN1(5,$P(^SRT(SRTPP,0),"^",5))_"^5" W !,"5.  Recipient Weight:",?36,$P(SRAO(5),"^")
 .W !,"6.  Recipient ABO Blood Type:",?36,$P(SRAO(6),"^")
 .W !,"7.  Recipient CMV:",?36,$P(SRAO(7),"^")
 .W !,"8.  MELD Score at Listing:",?36,$P(SRAO(8),"^")
 .W !,"9.  Biologic MELD Score at Listing:",?36,$P(SRAO(9),"^")
 .W !,"10. Meld Score at Transplant:",?36,$P(SRAO(10),"^")
 .W !,"11. Biologic MELD Score at TX:",?36,$P(SRAO(11),"^")
 .W !!,"12. Transplant Comments: " S SREXT=$P(SRAO(12),"^") D COMM
 W !!,SRLINE
 Q
COMM ; comment field
 I $L(SREXT)<52 W ?25,SREXT Q 
 N I,J,X,Y S X=SREXT F  D  W:$L(X) ! I $L(X)<52!($L(X)>51&(X'[" ")) W ?25,X Q
 .F I=0:1:50 S J=51-I,Y=$E(X,J) I Y=" " W ?25,$E(X,1,J-1) S X=$E(X,J+1,$L(X)) Q
 Q

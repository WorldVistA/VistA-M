SRTPHRT2 ;BIR/SJA - HEART-DIAGNOSIS INFORMATION ;03/04/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 I '$D(SRTPP) W !!,"A Transplant Assessment must be selected prior to using this option.",!!,"Press <RET> to continue  " R X:DTIME G END
START Q:SRSOUT  D DISP
 W !!,"Select Transplant Information to Edit: " R X:DTIME I '$T!(X["^") S SRSOUT=1 G END
 I X="" D ^SRTPHRT3 G END
 S:X="a" X="A" I '$D(SRAO(X)),(X'?.N1":".N),(X'="A") D HELP G:SRSOUT END G START
 I X?1.2N1":"1.2N S Y=$P(X,":"),Z=$P(X,":",2) I Y<1!(Z>SRX)!(Y>Z) D HELP G:SRSOUT END G START
 I X="A" S X="1:"_SRX
 D HDR^SRTPUTL
 I X?.N1":".N D RANGE G START
 I $D(SRAO(X)) S SREMIL=X W !! D ONE G START
END W @IOF
 Q
HELP W @IOF,!!!!,"Enter the number or range of numbers you want to edit.  Examples of proper",!,"responses are listed below."
 W !!,"1. Enter 'A' to update all information.",!!,"2. Enter a number (1-"_SRX_") to update the information in that field.  (For",!,"   example, enter '3' to update Ischemic Cardiomyopathy.)"
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
 S SRPAGE="PAGE: 2 OF "_$S(SRNOVA:6,1:4),SRHPG="TRANSPLANT INFORMATION" D HDR^SRTPUTL
 K SRAO,DR S SRQ=0
 S SRDR="155;156;157;158;159;43;160;161;162;94;112;13;14;15;16;17;18"
 K DA,DIC,DIQ,SRX,SRY S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
 W !,"Recipient Diagnosis",?40,"HLA Typing (#,#,#)"
 W !,"==================================",?40,"=================="
 W !,"1.  Dilated Cardiomyopathy:",?31,$P(SRAO(1),"^"),?40,"12. Recipient HLA-A:  ",$P(SRAO(12),"^")
 W !,"2.  Coronary Artery Disease:",?31,$P(SRAO(2),"^"),?40,"13. Recipient HLA-B:  ",$P(SRAO(13),"^")
 W !,"3.  Ischemic Cardiomyopathy:",?31,$P(SRAO(3),"^"),?40,"14. Recipient HLA-C:  ",$P(SRAO(14),"^")
 W !,"4.  Alcoholic Cardiomyopathy:",?31,$P(SRAO(4),"^"),?40,"15. Recipient HLA-BW: ",$P(SRAO(15),"^")
 W !,"5.  Valvular Cardiomyopathy:",?31,$P(SRAO(5),"^"),?40,"16. Recipient HLA-DR: ",$P(SRAO(16),"^")
 W !,"6.  Sarcoidosis:",?31,$P(SRAO(6),"^"),?40,"17. Recipient HLA-DQ: ",$P(SRAO(17),"^")
 W !,"7.  Idiopathic Cardiomyopathy:",?31,$P(SRAO(7),"^")
 W !,"8.  Viral Cardiomyopathy:",?31,$P(SRAO(8),"^")
 W !,"9.  Peripartum Cardiomyopathy:",?31,$P(SRAO(9),"^")
 W !,"10. Rejection:",?31,$P(SRAO(10),"^")
 W !,"11. Other Cardiomyopathy:" S SREXT=$P(SRAO(11),"^") D COMM
 W !!,SRLINE
 Q
COMM ; Other Cardiomyopathy
 I $L(SREXT)<52 W ?27,SREXT Q 
 N I,J,X,Y S X=SREXT F  D  W:$L(X) ! I $L(X)<52!($L(X)>51&(X'[" ")) W ?27,X Q
 .F I=0:1:50 S J=51-I,Y=$E(X,J) I Y=" " W ?27,$E(X,1,J-1) S X=$E(X,J+1,$L(X)) Q
 Q

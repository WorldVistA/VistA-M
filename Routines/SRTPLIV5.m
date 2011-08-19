SRTPLIV5 ;BIR/SJA - LIVER-RISK ASSESSMENT INFO ;03/04/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 I '$D(SRTPP) W !!,"A Transplant Assessment must be selected prior to using this option.",!!,"Press <RET> to continue  " R X:DTIME G END
 N SRX,SRY,SRZ
START Q:SRSOUT  D DISP
 W !!,"Select Transplant Information to Edit: " R X:DTIME I '$T!(X["^") S SRSOUT=1 G END
 I X="" D:SRNOVA ^SRTPLIV6 G END
 S:X="a" X="A" I '$D(SRAO(X)),(X'?.N1":".N),(X'="A") D HELP G:SRSOUT END G START
 I X?1.2N1":"1.2N S Y=$P(X,":"),Z=$P(X,":",2) I Y<1!(Z>SRX)!(Y>Z) D HELP G:SRSOUT END G START
 I X="A" S X="1:"_SRX
 D HDR^SRTPUTL
 I X?1.2N1":"1.2N D RANGE G START
 I $D(SRAO(X)),+X=X S SREMIL=X D ONE G START
END W @IOF
 Q
HELP W @IOF,!!!!,"Enter the number or range of numbers you want to edit.  Examples of proper",!,"responses are listed below."
 W !!,"1. Enter 'A' to update all items.",!!,"2. Enter a number (1-"_SRX_") to update the information in that field. (For example,",!,"   enter '1' to update Preop Trans. Skin Malignancy)"
 W !!,"3. Enter a range of numbers (1-"_SRX_") separated by a ':' to enter a range",!,"   of items.  (For example, enter '1:4' to update items 1, 2, 3 and 4.)",!
PRESS W ! K DIR S DIR("A")="Press the return key to continue or '^' to exit: ",DIR(0)="FOA" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
RANGE ; range of numbers
 S SRNOMORE=0,SRSHEMP=$P(X,":"),SRCURL=$P(X,":",2) F SREMIL=SRSHEMP:1:SRCURL Q:SRNOMORE  D ONE
 Q
ONE ; edit one item
 K DR,DIE S DA=SRTPP,DR=$P(SRAO(SREMIL),"^",2)_"T",DIE=139.5 D ^DIE K DR I $D(Y) S SRNOMORE=1
 Q
DISP ; display fields
 S SRHPG="RISK ASSESSMENT INFORMATION",SRPAGE="PAGE: "_$S(SRNOVA:"5",1:"")_" OF "_$S(SRNOVA:7,1:"") D HDR^SRTPUTL
 K DR,SRAO S (DR,SRDR)="81;82;88;83;109;110;145;132;146;131"
 K DA,DIC,DIQ,SRX,SRY,SRZ S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
 W !,"1.  Preop Transplant Skin Malignancy:",?52,$P(SRAO(1),"^")
 W !,"2.  Other Pre-Transplant Malignancy:",?52,$P(SRAO(2),"^")
 W !,"3.  Ascites:",?52,$P(SRAO(3),"^")
 W !,"4.  Recipient Substance Abuse:",?52,$P(SRAO(4),"^")
 W !,"5.  Post TX Prophylaxis - CMV/Anti-Viral Treatment:",?52,$P(SRAO(5),"^")
 W !,"6.  Post TX Prophylaxis - PCP/Antibiotic Treatment:",?52,$P(SRAO(6),"^")
 W !,"7.  Hypertension Requiring Meds:",?52,$P(SRAO(7),"^")
 W !,"8.  Peripheral Vascular Disease:",?52,$P(SRAO(8),"^")
 W !,"9.  Transfusion >4 RBC Units:",?52,$P(SRAO(9),"^")
 W !,"10. Preop Functional Health Status:",?52,$P(SRAO(10),"^")
 W !!,SRLINE
 Q

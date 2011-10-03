SRTPLUN3 ;BIR/SJA - LUNG-PREOPERATIVE RISK ASSESSMENT ;03/04/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 I '$D(SRTPP) W !!,"A Transplant Assessment must be selected prior to using this option.",!!,"Press <RET> to continue  " R X:DTIME G END
START Q:SRSOUT  D DISP
 W !!,"Select Transplant Information to Edit: " R X:DTIME I '$T!(X["^") S SRSOUT=1 G END
 I X="" D:SRNOVA ^SRTPLIV6 D ^SRTPLUN5 G END
 S:X="a" X="A" I '$D(SRAO(X)),(X'?.N1":".N),(X'="A") D HELP G:SRSOUT END G START
 I X?1.2N1":"1.2N S Y=$P(X,":"),Z=$P(X,":",2) I Y<1!(Z>SRX)!(Y>Z) D HELP G:SRSOUT END G START
 I X="A" S X="1:"_SRX
 D HDR^SRTPUTL
 I X?1.2N1":"1.2N D RANGE G START
 I $D(SRAO(X)),+X=X S SREMIL=X D ONE G START
END W @IOF
 Q
HELP W @IOF,!!!!,"Enter the number or range of numbers you want to edit.  Examples of proper",!,"responses are listed below."
 W !!,"1. Enter 'A' to update all items.",!!,"2. Enter a number (1-"_SRX_") to update an individual item.  (For example,",!,"   enter '1' to update "_$S(SRNOVA:"Diabetes Mellitus",1:"Diabetic Retinopathy")_")"
 W !!,"3. Enter a range of numbers (1-"_SRX_") separated by a ':' to enter a range",!,"   of items.  (For example, enter '1:4' to update items 1, 2, 3 and 4.)",!
 I $D(SRFLG) W !,"4. Enter 'N' or 'NO' to enter negative response for all items.",!!,"5. Enter '@' to delete information from all items.",!
PRESS W ! K DIR S DIR("A")="Press the return key to continue or '^' to exit: ",DIR(0)="FOA" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
RANGE ; range of numbers
 S SRNOMORE=0,SRSHEMP=$P(X,":"),SRCURL=$P(X,":",2) F SREMIL=SRSHEMP:1:SRCURL Q:SRNOMORE  D ONE
 Q
ONE ; edit one item
 K DR,DIE S DA=SRTPP,DR=$P(SRAO(SREMIL),"^",2)_"T",DIE=139.5 D ^DIE K DR I $D(Y) S SRNOMORE=1
 Q
DISP ; display fields
 S SRHPG="PREOPERATIVE RISK ASSESSMENT",SRPAGE="PAGE: 3 OF "_$S(SRNOVA:5,1:4) D HDR^SRTPUTL
 K DR,SRAO,II
 S:SRNOVA SRDR="147;59;60;71;108;61;75;113;114;131;115;90;83;109;110;145;132;146;80"
 S:'SRNOVA SRDR="59;60;71;108;61;75;113;114;80;115;90;83;109;110"
 K DA,DIC,DIQ,SRX,SRY S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
VA I 'SRNOVA D  W !!,SRLINE Q
 .W !,"1.  Diabetic Retinopathy:",?26,$P(SRAO(1),"^")
 .W !,"2.  Diabetic Neuropathy:",?26,$P(SRAO(2),"^")
 .W !,"3.  Elevated PAP:",?26,$P(SRAO(3),"^")
 .W !,"4.  HIV + (positive):",?26,$P(SRAO(4),"^")
 .W !,"5.  Cardiac Disease:",?26,$P(SRAO(5),"^")
 .W !,"6.  Liver Disease:",?26,$P(SRAO(6),"^")
 .W !,"7.  Lung Disease:",?26,$P(SRAO(7),"^")
 .W !,"8.  Renal impairment:",?26,$P(SRAO(8),"^")
 .W !,"9.  H/O Pre-Transplant Malignancy:",?35,$P(SRAO(9),"^")
 .W !,"10. Active Infection Immediately Pre-TX Requiring Antibiotics:",?63,$P(SRAO(10),"^")
 .W !,"11. Non-Compliance (Med and Diet):",?63,$P(SRAO(11),"^")
 .W !,"12. Recipient Substance Abuse:",?63,$P(SRAO(12),"^")
 .W !,"13. Post Transplant Prophylaxis for CMV/Antiviral Treatment:",?63,$P(SRAO(13),"^")
 .W !,"14. Post Transplant Prophylaxis for PCP/Antibiotic Treatment:",?63,$P(SRAO(14),"^")
NONVA I SRNOVA D
 .W !,"1.  Diabetes Mellitus:",?26,$P(SRAO(1),"^"),?36,"16. Hypertension Requiring Meds:",?69,$P(SRAO(16),"^")
 .W !,"2.  Diabetic Retinopathy:",?26,$P(SRAO(2),"^"),?36,"17. Peripheral Vascular Disease:",?69,$P(SRAO(17),"^")
 .W !,"3.  Diabetic Neuropathy:",?26,$P(SRAO(3),"^"),?36,"18. Transfusion >4 RBC Units:",?69,$P(SRAO(18),"^")
 .W !,"4.  Elevated PAP:",?26,$P(SRAO(4),"^"),?36,"19. Pre-Transplant Malignancy:",?69,$P(SRAO(19),"^")
 .W !,"5.  HIV + (positive):",?26,$P(SRAO(5),"^")
 .W !,"6.  Cardiac Disease:",?26,$P(SRAO(6),"^")
 .W !,"7.  Liver Disease:",?26,$P(SRAO(7),"^")
 .W !,"8.  Lung Disease: ",?26,$P(SRAO(8),"^")
 .W !,"9.  Renal impairment:",?26,$P(SRAO(9),"^")
 .W !,"10. Preop Functional Status:",?29,$P(SRAO(10),"^")
 .W !,"11. Active Infection Immediately Pre-TX Requiring Antibiotics:",?69,$P(SRAO(11),"^")
 .W !,"12. Non-Compliance (Med and Diet):",?69,$P(SRAO(12),"^")
 .W !,"13. Recipient Substance Abuse:",?69,$P(SRAO(13),"^")
 .W !,"14. Post Transplant Prophylaxis for CMV/Antiviral Treatment:",?69,$P(SRAO(14),"^")
 .W !,"15. Post Transplant Prophylaxis for PCP/Antibiotic Treatment:",?69,$P(SRAO(15),"^")
 W !!,SRLINE
 Q

SRTPKID3 ;BIR/SJA - KIDNEY-PREOPERATIVE RISK ASSESSMENT ;03/04/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 I '$D(SRTPP) W !!,"A Transplant Assessment must be selected prior to using this option.",!!,"Press <RET> to continue  " R X:DTIME G END
START Q:SRSOUT  D DISP
 W !!,"Select Transplant Information to Edit: " R X:DTIME I '$T!(X["^") S SRSOUT=1 G END
 I X="" D:SRNOVA ^SRTPKID4  D:'SRNOVA ^SRTPDONR G END
 S:X="a" X="A" I '$D(SRAO(X)),(X'?1.2N1":"1.2N),X'="A" D HELP G:SRSOUT END G START
 I X?1.2N1":"1.2N S Y=$P(X,":"),Z=$P(X,":",2) I Y<1!(Z>SRX)!(Y>Z) G:SRSOUT END G START
 I X="A" S X="1:"_SRX
 D HDR^SRTPUTL
 I X?1.2N1":"1.2N D RANGE G START
 I $D(SRAO(X)),+X=X S SREMIL=X D ONE G START
END W @IOF
 Q
HELP W @IOF,!!!!,"Enter the number or range of numbers you want to edit.  Examples of proper",!,"responses are listed below."
 W !!,"1. Enter 'A' to update all items.",!!,"2. Enter a number (1-"_SRX_") to update the information in that group. (For example,",!," enter '1' to update "_$S(SRNOVA:"Diabetes Mellitus",1:"Diabetic Retinopathy")_")"
 W !!,"3. Enter a range of numbers (1-"_SRX_") separated by a ':' to enter a range",!,"   of items.  (For example, enter '1:4' to update items 1, 2, 3 and 4.)",!
 W ! K DIR S DIR("A")="Press the return key to continue or '^' to exit: ",DIR(0)="FOA" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
RANGE ; range of numbers
 S SRNOMORE=0,SRSHEMP=$P(X,":"),SRCURL=$P(X,":",2) F SREMIL=SRSHEMP:1:SRCURL Q:SRNOMORE  D ONE
 Q
ONE ; edit one item
 K DR,DIE S DA=SRTPP,DR=$P(SRAO(SREMIL),"^",2)_"T",DIE=139.5 D ^DIE K DR I $D(Y) S SRNOMORE=1
 Q
DISP ; display fields
 S SRHPG="RISK ASSESSMENT",SRPAGE="PAGE: 3 OF "_$S(SRNOVA:6,1:5) D HDR^SRTPUTL
 K DR,SRAO S:SRNOVA SRDR="147;59;60;61;75;108;113;80;83;131;115;109;110;92;145;132;146;90"
 S:'SRNOVA SRDR="59;60;61;75;108;113;80;115;90;83;109;110;92;133"
 K DA,DIC,DIQ,SRX,SRY S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
VA I 'SRNOVA D  W !!,SRLINE Q
 .W !,"1.  Diabetic Retinopathy:",?31,$P(SRAO(1),"^")
 .W !,"2.  Diabetic Neuropathy:",?31,$P(SRAO(2),"^")
 .W !,"3.  Cardiac Disease:",?31,$P(SRAO(3),"^")
 .W !,"4.  Liver Disease:",?31,$P(SRAO(4),"^")
 .W !,"5.  HIV + (positive):",?31,$P(SRAO(5),"^")
 .W !,"6.  Lung Disease:",?31,$P(SRAO(6),"^")
 .W !,"7.  Pre-Transplant Malignancy:",?31,$P(SRAO(7),"^")
 .W !,"8.  Active Infection Immediately Pre-TX req. Antibiotics:",?60,$P(SRAO(8),"^")
 .W !,"9.  Non-Compliance (Med and Diet):",?60,$P(SRAO(9),"^")
 .W !,"10. Recipient Substance Abuse:",?60,$P(SRAO(10),"^")
 .W !,"11. Post-TX Prophylaxis for CMV/Antiviral Treatment:",?60,$P(SRAO(11),"^")
 .W !,"12. Post-TX Prophylaxis for PCP/Antibiotic Treatment:",?60,$P(SRAO(12),"^")
 .W !,"13. Post-TX Prophylaxis for TB/Antimycobacterial Treatment:",?60,$P(SRAO(13),"^")
 .W !,"14. Graft Failure Date:",?31,$P(SRAO(14),"^")
NONVA I SRNOVA D
 .W !,"1.  Diabetes Mellitus:",?26,$P(SRAO(1),"^"),?37,"15. Hypertension Requiring Meds:",?72,$P(SRAO(15),"^")
 .W !,"2.  Diabetic Retinopathy:",?26,$P(SRAO(2),"^"),?37,"16. Peripheral Vascular Disease:",?72,$P(SRAO(16),"^")
 .W !,"3.  Diabetic Neuropathy:",?26,$P(SRAO(3),"^"),?37,"17. Transfusion >4 RBC Units:",?72,$P(SRAO(17),"^")
 .W !,"4.  Cardiac Disease:",?26,$P(SRAO(4),"^"),?37,"18. Non-Compliance (Med and Diet):",?72,$P(SRAO(18),"^")
 .W !,"5.  Liver Disease:",?26,$P(SRAO(5),"^")
 .W !,"6.  HIV + (positive):",?26,$P(SRAO(6),"^")
 .W !,"7.  Lung Disease:",?26,$P(SRAO(7),"^")
 .W !,"8.  Pre-Transplant Malignancy:",?32,$P(SRAO(8),"^")
 .W !,"9.  Recipient Substance Abuse:",?32,$P(SRAO(9),"^")
 .W !,"10. Preop Functional Status:",?32,$P(SRAO(10),"^")
 .W !,"11. Active Infection Immediately Pre-Transplant Req. Antibiotics:",?72,$P(SRAO(11),"^")
 .W !,"12. Post-Transplant Prophylaxis for CMV/Antiviral Treatment:",?72,$P(SRAO(12),"^")
 .W !,"13. Post-Transplant Prophylaxis for PCP/Antibiotic Treatment:",?72,$P(SRAO(13),"^")
 .W !,"14. Post-Transplant Prophylaxis for TB/Antimycobacterial Treatment:",?72,$P(SRAO(14),"^")
 W !!,SRLINE
 Q

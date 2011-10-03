SRTPHRT3 ;BIR/SJA - HEART-RISK ASSESSMENT INFO ;09/10/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 I '$D(SRTPP) W !!,"A Transplant Assessment must be selected prior to using this option.",!!,"Press <RET> to continue  " R X:DTIME G END
START Q:SRSOUT  D DISP
 W !!,"Select Transplant Information to Edit: " R X:DTIME I '$T!(X["^") S SRSOUT=1 G END
 I X="",SRNOVA D ^SRTPHRT4 G END
 I X="",'SRNOVA D ^SRTPHRT6 D:'SRSOUT ^SRTPCOM G END
 S:X="a" X="A" I '$D(SRAO(X)),(X'?.N1":".N),(X'="A") D HELP G:SRSOUT END G START
 I X?1.2N1":"1.2N S Y=$P(X,":"),Z=$P(X,":",2) I Y<1!(Z>SRX)!(Y>Z) D HELP G:SRSOUT END G START
 I X="A" S X="1:"_SRX
 D HDR^SRTPUTL
 I X?.N1":".N D RANGE G START
 I $D(SRAO(X)) S SREMIL=X W !! D ONE G START
END W @IOF
 Q
HELP W @IOF,!!!!,"Enter the number or range of numbers you want to edit.  Examples of proper",!,"responses are listed below."
 W !!,"1. Enter 'A' to update all information.",!!,"2. Enter a number (1-"_SRX_") to update the information in that field.  (For",!,"   example, enter '1' to update "_$S(SRNOVA:"COPD",1:"Inotrope Dependent Pre-TX")_")"
 W !!,"3. Enter a range of numbers (1-"_SRX_") separated by a ':' to enter a range",!,"   of items.  (For example, enter '1:4' to update items 1, 2, 3 and 4.)",!
 W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1
 Q
RANGE ; range of numbers
 W !! S SRNOMORE=0,SRSHEMP=$P(X,":"),SRCURL=$P(X,":",2) F SREMIL=SRSHEMP:1:SRCURL Q:SRNOMORE  D ONE
 Q
ONE ; edit one item
 K DR,DIE S DA=SRTPP,DR=$S($P(SRAO(SREMIL),"^",2)=145:"145Hypertension",1:$P(SRAO(SREMIL),"^",2)_"T"),DIE=139.5 D ^DIE K DR I $D(Y) S SRNOMORE=1
 Q
DISP ; display fields
 S SRPAGE="PAGE: 3 OF "_$S(SRNOVA:6,1:4),SRHPG="RISK ASSESSMENT INFORMATION" D HDR^SRTPUTL
 K SRAO,DR S SRQ=0
 S:'SRNOVA SRDR="62;149;150;151;59;60;152;108;153;74;115;81;82;109;110;90;83;75;154"
 S:SRNOVA SRDR="76;169;177;149;173;174;175;62;176;74;152;171;172;179;178;132;145;150;151;147;59;60"
 K DA,DIC,DIQ,SRX,SRY S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
VA I 'SRNOVA D
 .W !,"1.  Inotrope Dependent Pre-TX:",?31,$P(SRAO(1),"^"),?40,"16. Non-Compliance(Med/Diet):",?71,$P(SRAO(16),"^")
 .W !,"2.  Amiodarone Use:",?31,$P(SRAO(2),"^"),?40,"17. Recipient Substance Abuse:",?71,$P(SRAO(17),"^")
 .W !,"3.  Heparin Sensitivity:",?31,$P(SRAO(3),"^"),?40,"18. Liver Disease:",?71,$P(SRAO(18),"^")
 .W !,"4.  Hyperlipidemia History:",?31,$P(SRAO(4),"^"),?40,"19. Creatinine on Day of TX:",?71,$P(SRAO(19),"^")
 .W !,"5.  Diabetic Retinopathy:",?31,$P(SRAO(5),"^")
 .W !,"6.  Diabetic Neuropathy:",?31,$P(SRAO(6),"^")
 .W !,"7.  Ventricular Tachycardia:",?31,$P(SRAO(7),"^")
 .W !,"8.  HIV+ (Positive):",?31,$P(SRAO(8),"^")
 .W !,"9.  Prior Blood Transfusion:",?31,$P(SRAO(9),"^")
 .W !,"10. Pulmonary Hypertension/Elevated PAP not reversible:",?71,$P(SRAO(10),"^")
 .W !,"11. Active Infection Immediately Pre-Transplant Req. Antibiotics:",?71,$P(SRAO(11),"^")
 .W !,"12. History of Pre-Transplant Skin Malignancy:",?71,$P(SRAO(12),"^")
 .W !,"13. History of Pre-Transplant Other Malignancy:",?71,$P(SRAO(13),"^")
 .W !,"14. Post-Transplant Prophylaxis for CMV/Anti-Viral Treatment:",?71,$P(SRAO(14),"^")
 .W !,"15. Post-Transplant Prophylaxis for PCP/Antibiotic Treatment:",?71,$P(SRAO(15),"^")
NONVA I SRNOVA D
 .W !,"1.  COPD:",?34,$P(SRAO(1),"^"),?44,"17. Hypertension:",?72,$P(SRAO(17),"^")
 .W !,"2.  FEV1:",?34,$P(SRAO(2),"^"),?44,"18. Heparin Sensitivity:",?72,$P(SRAO(18),"^")
 .W !,"3.  Current Digoxin Use:",?34,$P(SRAO(3),"^"),?44,"19. Hyperlipidemia History:",?72,$P(SRAO(19),"^")
 .W !,"4.  Amiodarone Use:",?34,$P(SRAO(4),"^"),?44,"20. Diabetes:",?72,$P(SRAO(20),"^")
 .W !,"5.  Number prior heart surgeries:",?34,$P(SRAO(5),"^"),?44,"21. Diabetes Retinopathy:",?72,$P(SRAO(21),"^")
 .W !,"6.  Cerebral Vascular Disease:",?34,$P(SRAO(6),"^"),?44,"22. Diabetes Neuropathy:",?72,$P(SRAO(22),"^")
 .W !,"7.  CHF (NYHA Functional Class):",?34,$P(SRAO(7),"^")
 .W !,"8.  Inotrope Dependent Pre-TX:",?34,$P(SRAO(8),"^")
 .W !,"9.  IV NTG within 48 hours:",?34,$P(SRAO(9),"^")
 .W !,"10. Pulmonary Hypertension/Elevated PAP: ",$P(SRAO(10),"^")
 .W !,"11. Ventricular Tachycardia:",?34,$P(SRAO(11),"^")
 .W !,"12. Current Smoker:",?34,$P(SRAO(12),"^")
 .W !,"13. Prior MI:",?34,$P(SRAO(13),"^")
 .W !,"14. Preop Circulatory Device:",?34,$P(SRAO(14),"^")
 .W !,"15. Current Diuretic Use:",?34,$P(SRAO(15),"^")
 .W !,"16. Peripheral Vascular Disease:",?34,$P(SRAO(16),"^")
 W !,SRLINE
 Q

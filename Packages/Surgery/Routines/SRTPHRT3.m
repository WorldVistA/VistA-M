SRTPHRT3 ;BIR/SJA - HEART-RISK ASSESSMENT INFO ;08/11/2011
 ;;3.0;Surgery;**167,176**;24 Jun 93;Build 8
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
 K SRAO,DR S SRQ=0 D TUT^SRTPUTL
 S:'SRNOVA SRDR="62;149;150;151;59;60;152;108;153;74;115;81;82;109;110;90;83;75;154"
 S:SRNOVA SRDR="76;169;177;149;173;202;203;175;62;176;74;152;198;199;172;179;178;132;145;150;151;200;201;59;60"
 K DA,DIC,DIQ,SRX,SRY S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I D
 .I SRZ=202 S Y=$P(^SRT(SRTPP,.55),"^",28),SRAO(I)=$S(Y=0:"NO CVD",Y=1:"YES/NO SURG",Y=2:"YES/PRIOR SURG",1:"")_"^202" Q
 .I SRZ=203 S Y=$P(^SRT(SRTPP,.55),"^",29),SRAO(I)=$S(Y=0:"NO CVD",Y=1:"HIST OF TIA'S",Y=2:"CVA W/O NEURO DEF",Y=3:"CVA W/ NEURO DEF",1:"")_"^203" Q
 .S SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
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
 .W !,"1.  COPD:",?34,$P(SRAO(1),"^"),?44,"17. Current Diuretic Use:",?77,$J($P(SRAO(17),"^"),3)
 .W !,"2.  FEV1:",?34,$P(SRAO(2),"^"),?44,"18. Peripheral Vascular Disease: ",$J($P(SRAO(18),"^"),3)
 .W !,"3.  Current Digoxin Use:",?34,$P(SRAO(3),"^"),?44,"19. Hypertension:",?72,$J($P(SRAO(19),"^"),8)
 .W !,"4.  Amiodarone Use:",?34,$P(SRAO(4),"^"),?44,"20. Heparin Sensitivity:",?77,$J($P(SRAO(20),"^"),3)
 .W !,"5.  Number prior heart surgeries:",?34,$P(SRAO(5),"^"),?44,"21. Hyperlipidemia History:",?77,$J($P(SRAO(21),"^"),3)
 .W !,"6.  CVD Repair/Obstruct: ",?(40-$L($P(SRAO(6),"^"))),$P(SRAO(6),"^"),?44,"22. Diabetes - Long Term:",?73,$J($P(SRAO(22),"^"),7)
 .W !,"7.  History of CVD: ",?(40-$L($P(SRAO(7),"^"))),$P(SRAO(7),"^"),?44,"23. Diabetes - 2 Wks Preop:",?73,$J($P(SRAO(23),"^"),7)
 .W !,"8.  CHF (NYHA Functional Class):",?34,$P(SRAO(8),"^"),?44,"24. Diabetes Retinopathy:",?77,$J($P(SRAO(24),"^"),3)
 .W !,"9.  Inotrope Dependent Pre-TX:",?34,$P(SRAO(9),"^"),?44,"25. Diabetes Neuropathy:",?77,$J($P(SRAO(25),"^"),3)
 .W !,"10. IV NTG within 48 hours:",?34,$P(SRAO(10),"^")
 .W !,"11. Pulmonary Hypertension/Elevated PAP: ",$P(SRAO(11),"^")
 .W !,"12. Ventricular Tachycardia:",?34,$P(SRAO(12),"^")
 .W !,"13. Tobacco Use:",?21,$J($P(SRAO(13),"^"),21)
 .W !,"14. Tobacco Use Timeframe:",?28,$P(SRAO(14),"^")
 .W !,"15. Prior MI:",?34,$P(SRAO(15),"^")
 .W !,"16. Preop Circulatory Device:",?34,$P(SRAO(16),"^")
 W !,SRLINE
 Q

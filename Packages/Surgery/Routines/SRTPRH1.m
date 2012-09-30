SRTPRH1 ;BIR/SJA - PRINT HEART RISK ASSESSMENT INFO ;07/20/2011
 ;;3.0;Surgery;**167,176**;24 Jun 93;Build 8
 W:$E(IOST)="P" ! W !,?28,"RISK ASSESSMENT INFORMATION",!
 K SRAO,SRX,Y,DR
 S:'SRNOVA SRDR="62;149;150;151;59;60;152;108;153;74;115;81;82;109;110;90;83;75;154"
 S:SRNOVA SRDR="76;169;177;149;173;202;203;175;62;176;74;152;198;199;172;179;178;132;145;150;151;200;201;59;60"
 K DA,DIC,DIQ,SRX,SRY S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I D
 .I SRZ=202 S Y=$P(^SRT(SRTPP,.55),"^",28),SRAO(I)=$S(Y=0:"NO CVD",Y=1:"YES/NO SURG",Y=2:"YES/PRIOR SURG",1:"")_"^202" Q
 .I SRZ=203 S Y=$P(^SRT(SRTPP,.55),"^",29),SRAO(I)=$S(Y=0:"NO CVD",Y=1:"HIST OF TIA'S",Y=2:"CVA W/O NEURO DEF",Y=3:"CVA W/ NEURO DEF",1:"")_"^203" Q
 .S SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
VA I 'SRNOVA D
 .W !,"Inotrope Dependent Pre-TX:",?27,$P(SRAO(1),"^"),?40,"Non-Compliance:",?67,$P(SRAO(16),"^")
 .W !,"Amiodarone Use:",?27,$P(SRAO(2),"^"),?40,"Recipient Substance Abuse:",?67,$P(SRAO(17),"^")
 .W !,"Heparin Sensitivity:",?27,$P(SRAO(3),"^"),?40,"Liver Disease:",?67,$P(SRAO(18),"^")
 .W !,"Hyperlipidemia History:",?27,$P(SRAO(4),"^"),?40,"Creatinine on Day of TX:",?67,$P(SRAO(19),"^")
 .W !,"Diabetic Retinopathy:",?27,$P(SRAO(5),"^")
 .W !,"Diabetic Neuropathy:",?27,$P(SRAO(6),"^")
 .W !,"Ventricular Tachycardia:",?27,$P(SRAO(7),"^")
 .W !,"HIV+ (Positive):",?27,$P(SRAO(8),"^")
 .W !,"Prior Blood Transfusion:",?27,$P(SRAO(9),"^")
 .W !,"Pulmonary Hypertension/Elevated PAP not reversible:",?67,$P(SRAO(10),"^")
 .W !,"Active Infection Immediately Pre-Transplant Req. Antibiotics:",?67,$P(SRAO(11),"^")
 .W !,"H/O Pre-Transplant Skin Malignancy:",?67,$P(SRAO(12),"^")
 .W !,"H/O Pre-Transplant Other Malignancy:",?67,$P(SRAO(13),"^")
 .W !,"Post-Tx Prophylaxis for CMV/Anti-Viral Treatment:",?67,$P(SRAO(14),"^")
 .W !,"Post-Tx Prophylaxis for PCP/Antibiotic Treatment:",?67,$P(SRAO(15),"^")
NONVA I SRNOVA D
 .W !,"COPD:",?30,$P(SRAO(1),"^"),?42,"Current Diuretic Use:",?71,$P(SRAO(17),"^")
 .W !,"FEV1:",?30,$P(SRAO(2),"^"),?42,"Peripheral Vascular Disease:",?71,$P(SRAO(18),"^")
 .W !,"Current Digoxin Use:",?30,$P(SRAO(3),"^"),?42,"Hypertension:",?71,$P(SRAO(19),"^")
 .W !,"Amiodarone Use:",?30,$P(SRAO(4),"^"),?42,"Heparin Sensitivity:",?71,$P(SRAO(20),"^")
 .W !,"Number prior heart surgeries:",?30,$P(SRAO(5),"^"),?42,"Hyperlipidemia History:",?71,$P(SRAO(21),"^")
 .W !,"CVD Repair/Obstruct:",?(39-$L($P(SRAO(6),"^"))),$P(SRAO(6),"^"),?42,"Diabetes - Long Term:",?71,$P(SRAO(22),"^")
 .W !,"History of CVD:",?(39-$L($P(SRAO(7),"^"))),$P(SRAO(7),"^"),?42,"Diabetes - 2 Wks Preop:",?71,$P(SRAO(23),"^")
 .W !,"CHF (NYHA Functional Class):",?30,$P(SRAO(8),"^"),?42,"Diabetes Retinopathy:",?71,$P(SRAO(24),"^")
 .W !,"Inotrope Dependent Pre-TX:",?30,$P(SRAO(9),"^"),?42,"Diabetes Neuropathy:",?71,$P(SRAO(25),"^")
 .W !,"IV NTG within 48 hours:",?30,$P(SRAO(10),"^")
 .W !,"Pulmonary Hyper/Elevated PAP:",?30,$P(SRAO(11),"^")
 .W !,"Ventricular Tachycardia:",?30,$P(SRAO(12),"^")
 .W !,"Tobacco Use:",?(39-$L($P(SRAO(13),"^"))),$P(SRAO(13),"^")
 .W !,"Tobacco Use Timeframe: ",?(39-$L($P(SRAO(14),"^"))),$P(SRAO(14),"^")
 .W !,"Prior MI: ",?30,$E($P(SRAO(15),"^"),1,15)
 .W !,"Preop Circulatory Device:",?30,$E($P(SRAO(16),"^"),1,10)
 D:SRNOVA RISK
 I $E(IOST)'="P" D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
 I $E(IOST)="P" G:SRSOUT END^SRTPPAS I $Y+20>IOSL D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
 G ^SRTPRH2
 Q
RISK ;
 K DR,SRAO,SRX,Y
 S SRDR="75;154;108;115;81;82;90;83;153"
 K DA,DIC,DIQ,SRX,SRY S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
 W !,"Liver Disease:",?30,$P(SRAO(1),"^"),?42,"Pre-TX Other Malignancy:",?71,$P(SRAO(6),"^")
 W !,"Creatinine on Day of TX:",?30,$P(SRAO(2),"^"),?42,"Non-Compliance:",?71,$P(SRAO(7),"^")
 W !,"HIV+ (positive):",?30,$P(SRAO(3),"^"),?42,"Recipient Substance Abuse:",?71,$P(SRAO(8),"^")
 W !,"Active Infection Pre-TX:",?30,$P(SRAO(4),"^"),?42,"Prior Blood Transfusion:",?71,$P(SRAO(9),"^")
 W !,"Pre-TX Skin Malignancy:",?30,$P(SRAO(5),"^")
 Q

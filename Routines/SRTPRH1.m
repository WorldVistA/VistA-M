SRTPRH1 ;BIR/SJA - PRINT HEART RISK ASSESSMENT INFO ;04/21/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 W:$E(IOST)="P" ! W !,?28,"RISK ASSESSMENT INFORMATION",!
 K SRAO,SRX,Y,DR
 S:'SRNOVA SRDR="62;149;150;151;59;60;152;108;153;74;115;81;82;109;110;90;83;75;154"
 S:SRNOVA SRDR="76;169;177;149;173;174;175;62;176;74;152;171;172;179;178;132;145;150;151;147;59;60"
 K DA,DIC,DIQ,SRX,SRY S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
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
 .W !,"COPD:",?30,$P(SRAO(1),"^"),?44,"Hypertension:",?71,$P(SRAO(17),"^")
 .W !,"FEV1:",?30,$P(SRAO(2),"^"),?44,"Heparin Sensitivity:",?71,$P(SRAO(18),"^")
 .W !,"Current Digoxin Use:",?30,$P(SRAO(3),"^"),?44,"Hyperlipidemia History:",?71,$P(SRAO(19),"^")
 .W !,"Amiodarone Use:",?30,$P(SRAO(4),"^"),?44,"Diabetes:",?71,$P(SRAO(20),"^")
 .W !,"Number prior heart surgeries:",?30,$P(SRAO(5),"^"),?44,"Diabetes Retinopathy:",?71,$P(SRAO(21),"^")
 .W !,"Cerebral Vascular Disease:",?30,$P(SRAO(6),"^"),?44,"Diabetes Neuropathy:",?71,$P(SRAO(22),"^")
 .W !,"CHF (NYHA Functional Class):",?30,$P(SRAO(7),"^")
 .W !,"Inotrope Dependent Pre-TX:",?30,$P(SRAO(8),"^")
 .W !,"IV NTG within 48 hours:",?30,$P(SRAO(9),"^")
 .W !,"Pulmonary Hyper/Elevated PAP:",?30,$P(SRAO(10),"^")
 .W !,"Ventricular Tachycardia:",?30,$P(SRAO(11),"^")
 .W !,"Current Smoker:",?30,$E($P(SRAO(12),"^"),1,22)
 .W !,"Prior MI: ",?30,$E($P(SRAO(13),"^"),1,15)
 .W !,"Preop Circulatory Device:",?30,$E($P(SRAO(14),"^"),1,10)
 .W !,"Current Diuretic Use:",?30,$P(SRAO(15),"^")
 .W !,"Peripheral Vascular Disease:",?30,$P(SRAO(16),"^")
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
 W !,"Liver Disease:",?30,$P(SRAO(1),"^"),?44,"Pre-TX Other Malignancy:",?71,$P(SRAO(6),"^")
 W !,"Creatinine on Day of TX:",?30,$P(SRAO(2),"^"),?44,"Non-Compliance:",?71,$P(SRAO(7),"^")
 W !,"HIV+ (positive):",?30,$P(SRAO(3),"^"),?44,"Recipient Substance Abuse:",?71,$P(SRAO(8),"^")
 W !,"Active Infection Pre-TX:",?30,$P(SRAO(4),"^"),?44,"Prior Blood Transfusion:",?71,$P(SRAO(9),"^")
 W !,"Pre-TX Skin Malignancy:",?30,$P(SRAO(5),"^")
 Q

SRTPRLU1 ;BIR/SJA - PRINT LUNG-PREOPERATIVE RISK ASSESSMENT ;04/21/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 K DR,II,SRAO,SRX,Y
 W:$E(IOST)="P" ! W !,?28,"PREOPERATIVE RISK ASSESSMENT",!
 S:SRNOVA SRDR="147;59;60;71;108;61;75;113;114;131;115;90;83;109;110;145;132;146;80"
 S:'SRNOVA SRDR="59;60;71;108;61;75;113;114;80;115;90;83;109;110"
 K DA,DIC,DIQ,SRX,SRY S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
VA I 'SRNOVA D
 .W !,"Diabetic Retinopathy:",?22,$P(SRAO(1),"^"),?40,"H/O Pre-Trans Malignancy:",?71,$P(SRAO(9),"^")
 .W !,"Diabetic Neuropathy:",?22,$P(SRAO(2),"^"),?40,"Active Infection Immediately"
 .W !,"Elevated PAP:",?22,$P(SRAO(3),"^"),?43,"Pre-Trans Req. Antibiotics:",?71,$P(SRAO(10),"^")
 .W !,"HIV + (positive):",?22,$P(SRAO(4),"^"),?40,"Non-Compliance:",?71,$P(SRAO(11),"^")
 .W !,"Cardiac Disease:",?22,$P(SRAO(5),"^"),?40,"Recipient Substance Abuse:",?71,$P(SRAO(12),"^")
 .W !,"Liver Disease:",?22,$P(SRAO(6),"^"),?40,"Post Transplant Prophylaxis for"
 .W !,"Lung Disease:",?22,$P(SRAO(7),"^"),?40," - CMV/Antiviral Treatment:",?71,$P(SRAO(13),"^")
 .W !,"Renal impairment:",?22,$P(SRAO(8),"^"),?40," - PCP/Antibiotic Treatment:",?71,$P(SRAO(14),"^")
NONVA I SRNOVA D
 .W !,"Diabetes Mellitus:",?22,$P(SRAO(1),"^"),?40,"Hypertension Requiring Meds:",?71,$P(SRAO(16),"^")
 .W !,"Diabetic Retinopathy:",?22,$P(SRAO(2),"^"),?40,"Peripheral Vascular Disease:",?71,$P(SRAO(17),"^")
 .W !,"Diabetic Neuropathy:",?22,$P(SRAO(3),"^"),?40,"Transfusion >4 RBC Units:",?71,$P(SRAO(18),"^")
 .W !,"Elevated PAP:",?22,$P(SRAO(4),"^"),?40,"Pre-Trans Malignancy:",?71,$P(SRAO(19),"^")
 .W !,"HIV + (positive):",?22,$P(SRAO(5),"^")
 .W !,"Cardiac Disease:",?22,$P(SRAO(6),"^")
 .W !,"Liver Disease:",?22,$P(SRAO(7),"^")
 .W !,"Lung Disease:",?22,$P(SRAO(8),"^")
 .W !,"Renal impairment:",?22,$P(SRAO(9),"^")
 .W !,"Preop Functional Status:",?25,$P(SRAO(10),"^")
 .W !,"Active Infection Immediately Pre-Trans Req. Antibiotics:",?71,$P(SRAO(11),"^")
 .W !,"Non-Compliance (Med and Diet):",?71,$P(SRAO(12),"^")
 .W !,"Recipient Substance Abuse:",?71,$P(SRAO(13),"^")
 .W !,"Post Transplant Prophylaxis for CMV/Antiviral Treatment:",?71,$P(SRAO(14),"^")
 .W !,"Post Transplant Prophylaxis for PCP/Antibiotic Treatment:",?71,$P(SRAO(15),"^")
 I $E(IOST)'="P" D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
 I $E(IOST)="P" G:SRSOUT END^SRTPPAS I $Y+20>IOSL D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
 G ^SRTPRLU2

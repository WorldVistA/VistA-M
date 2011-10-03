SRTPRLI1 ;BIR/SJA - PRINT LIVER-DIAGNOSIS/RISK INFORMATION ;04/21/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 K DR,SRAO,SRX,Y
DIAG W:$E(IOST)="P" ! W !,?28,"TRANSPLANT INFORMATION",!
 S (DR,SRDR)="85;87;89;68;13;14;15;17;16;18"
 K DA,DIC,DIQ,SRX,SRY,SRZ S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
 W !,"Warm Ischemia time:",?21,$P(SRAO(1),"^")
 W !,"Cold Ischemia time:",?21,$P(SRAO(2),"^")
 W !,"Total Ischemia time:",?21,$P(SRAO(3),"^")
 W !,"Crossmatch D/R:",?21,$P(SRAO(4),"^")
 W !!,"HLA Typing (#,#,#)",!,"==================="
 W !,"Recipient HLA-A:",?21,$P(SRAO(5),"^")
 W !,"Recipient HLA-B:",?21,$P(SRAO(6),"^")
 W !,"Recipient HLA-C:",?21,$P(SRAO(7),"^")
 W !,"Recipient HLA-DR:",?21,$P(SRAO(8),"^")
 W !,"Recipient HLA-BW:",?21,$P(SRAO(9),"^")
 W !,"Recipient HLA-DQ:",?21,$P(SRAO(10),"^")
 I $E(IOST)'="P" D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
 I $E(IOST)="P" G:SRSOUT END^SRTPPAS I $Y+20>IOSL D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
RISK K DR,SRAO,SRX,Y
 W !,?28,"RISK ASSESSMENT INFORMATION",!
 S:'SRNOVA SRDR="86;84;59;60;108;113;114;90;91;78;79;81;82;83;109;110"
 I SRNOVA S SRDR="86;84;147;59;60;113;108;114;90;91;78;79"
 K DA,DIC,DIQ,SRX,SRY S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
VA I 'SRNOVA D
 .W !,"Acute or Chronic Encephalopathy:",?48,$P(SRAO(1),"^")
 .W !,"Active Infection (for PSC):",?48,$P(SRAO(2),"^")
 .W !,"Diabetic Retinopathy:",?48,$P(SRAO(3),"^")
 .W !,"Diabetic Neuropathy:",?48,$P(SRAO(4),"^")
 .W !,"HIV + (positive):",?48,$P(SRAO(5),"^")
 .W !,"Lung Disease:",?48,$P(SRAO(6),"^")
 .W !,"Renal impairment:",?48,$P(SRAO(7),"^")
 .W !,"Non-Compliance (Med and Diet):",?48,$P(SRAO(8),"^")
 .W !,"On Methadone:",?48,$P(SRAO(9),"^")
 .W !,"Porto Pulmonary Hypertension:",?48,$P(SRAO(10),"^")
 .W !,"Esophageal and/or Gastric Varices:",?48,$P(SRAO(11),"^")
 .W !,"Preop Transplant Skin Malignancy:",?48,$P(SRAO(12),"^")
 .W !,"Other Pre-Transplant Malignancy:",?48,$P(SRAO(13),"^")
 .W !,"Recipient Substance Abuse:",?48,$P(SRAO(14),"^")
 .W !,"Post TX Prophylaxis - CMV/Antiviral Treatment:",?48,$P(SRAO(15),"^")
 .W !,"Post TX Prophylaxis - PCP/Antibiotic Treatment:",?48,$P(SRAO(16),"^")
NONVA I SRNOVA D
 .W !,"Acute or Chronic Encephalopathy:",?33,$P(SRAO(1),"^")
 .W !,"Active Infection (for PSC):",?33,$P(SRAO(2),"^")
 .W !,"Diabetes Mellitus:",?33,$P(SRAO(3),"^")
 .W !,"Diabetic Retinopathy:",?33,$P(SRAO(4),"^")
 .W !,"Diabetic Neuropathy:",?33,$P(SRAO(5),"^")
 .W !,"Lung Disease:",?33,$P(SRAO(6),"^")
 .W !,"HIV + (positive):",?33,$P(SRAO(7),"^")
 .W !,"Renal impairment:",?33,$P(SRAO(8),"^")
 .W !,"Non-Compliance:",?33,$P(SRAO(9),"^")
 .W !,"On Methadone:",?33,$P(SRAO(10),"^")
 .W !,"Porto Pulmonary Hypertension:",?33,$P(SRAO(11),"^")
 .W !,"Esophageal - Gastric Varices:",?33,$P(SRAO(12),"^")
 I $E(IOST)'="P" D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
 I $E(IOST)="P" G:SRSOUT END^SRTPPAS I $Y+20>IOSL D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
END G ^SRTPRLI2
 Q

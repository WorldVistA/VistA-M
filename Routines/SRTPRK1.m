SRTPRK1 ;BIR/SJA - PRINT KIDNEY-TRANSPLANT INFO/PREOP RISK ASSESSMENT INFO ;04/21/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
TRANS ; print page 2
 W:$E(IOST)="P" ! W !,?28,"KIDNEY TRANSPLANT INFORMATION",!
 K DR,SRAO,SRX,Y
 S SRDR="85;87;89;68;143;144;9;197;13;14;15;17;16;18"
 K DA,DIC,DIQ,SRX,SRY S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
 W !,"Ischemia Time for Organ (minutes)"
 W !," - Warm Ischemia:",?19,$P(SRAO(1),"^"),?49,"Recipient HLA-A:  ",$P(SRAO(9),"^")
 W !," - Cold Ischemia:",?19,$P(SRAO(2),"^"),?49,"Recipient HLA-B:  ",$P(SRAO(10),"^")
 W !," - Total Ischemia:",?19,$P(SRAO(3),"^"),?49,"Recipient HLA-C:  ",$P(SRAO(11),"^")
 W !,"Crossmatch D/R:",?19,$P(SRAO(4),"^"),?49,"Recipient HLA-DR: ",$P(SRAO(12),"^")
 W !,"PRA at Listing:",?19,$P(SRAO(5),"^"),?49,"Recipient HLA-BW: ",$P(SRAO(13),"^")
 W !,"PRA at Transplant:",?19,$P(SRAO(6),"^"),?49,"Recipient HLA-DQ: ",$P(SRAO(14),"^")
 W !,"IVIG Recipient:",?19,$P(SRAO(7),"^")
 W !,"Plasmapheresis:",?19,$P(SRAO(8),"^"),!
 I $E(IOST)'="P" D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
 I $E(IOST)="P" G:SRSOUT END^SRTPPAS I $Y+20>IOSL D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
PREOP ; print page 3
 W !,?28,"RISK ASSESSMENT",!
 K DR,SRAO,SRX,Y
 S:SRNOVA SRDR="147;59;60;61;75;108;113;80;83;131;115;109;110;92;145;132;146;90"
 S:'SRNOVA SRDR="59;60;61;75;108;113;80;115;90;83;109;110;92;133"
 K DA,DIC,DIQ,SRX,SRY S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
VA I 'SRNOVA D
 .W !,"Diabetic Retinopathy:",?29,$P(SRAO(1),"^"),?40,"Non-Compliance (Med and Diet):",?75,$P(SRAO(9),"^")
 .W !,"Diabetic Neuropathy:",?29,$P(SRAO(2),"^"),?40,"Recipient Substance Abuse:",?75,$P(SRAO(10),"^")
 .W !,"Cardiac Disease:",?29,$P(SRAO(3),"^"),?40,"Post Transplant Prophylaxis for"
 .W !,"Liver Disease:",?29,$P(SRAO(4),"^"),?48,"- CMV/Antiviral Treatment: ",$P(SRAO(11),"^")
 .W !,"HIV + (positive):",?29,$P(SRAO(5),"^"),?47,"- PCP/Antibiotic Treatment: ",?66,$P(SRAO(12),"^")
 .W !,"Lung Disease:",?29,$P(SRAO(6),"^"),?41,"- TB/Antimycobacterial Treatment: ",?68,$P(SRAO(13),"^")
 .W !,"Pre-Transplant Malignancy:",?29,$P(SRAO(7),"^"),?40,"Graft Failure Date: ",?66,$P(SRAO(14),"^")
 .W !,"Active Infection Immediately"
 .W !," Pre-Trans Req. Antibiotics:",?29,$P(SRAO(8),"^")
NONVA I SRNOVA D
 .W !,"Diabetes Mellitus:",?29,$P(SRAO(1),"^"),?40,"Hypertension Requiring Meds:",?69,$P(SRAO(15),"^")
 .W !,"Diabetic Retinopathy:",?29,$P(SRAO(2),"^"),?40,"Peripheral Vascular Disease:",?69,$P(SRAO(16),"^")
 .W !,"Diabetic Neuropathy:",?29,$P(SRAO(3),"^"),?40,"Transfusion >4 RBC Units:",?69,$P(SRAO(17),"^")
 .W !,"Cardiac Disease:",?29,$P(SRAO(4),"^"),?40,"Non-Compliance:",?69,$P(SRAO(18),"^")
 .W !,"Liver Disease:",?29,$P(SRAO(5),"^")
 .W !,"HIV + (positive):",?29,$P(SRAO(6),"^")
 .W !,"Lung Disease:",?29,$P(SRAO(7),"^")
 .W !,"Pre-Transplant Malignancy:",?29,$P(SRAO(8),"^")
 .W !,"Recipient Substance Abuse:",?29,$P(SRAO(9),"^")
 .W !,"Preop Functional Status:",?29,$P(SRAO(10),"^")
 .W !,"Active Infection Immediately Pre-Transplant Req. Antibiotics:",?69,$P(SRAO(11),"^")
 .W !,"Post Transplant Prophylaxis for CMV/Antiviral Treatment:",?69,$P(SRAO(12),"^")
 .W !,"Post Transplant Prophylaxis for PCP/Antibiotic Treatment:",?69,$P(SRAO(13),"^")
 .W !,"Post Transplant Prophylaxis for TB/Antimycobacterial Treatment:",?69,$P(SRAO(14),"^")
 I $E(IOST)'="P" D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
 I $E(IOST)="P" G:SRSOUT END^SRTPPAS I $Y+20>IOSL D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
 G ^SRTPRK2
 Q

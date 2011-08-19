SRTPRLU ;BIR/SJA - PRINT LUNG-RECIPIENT/TRANSPLANT INFORMATION ;04/21/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 K DR,SRAO,SRX,Y
 S:SRNOVA SRDR="1;11;4;5;10;12;40;41;24;25;32;43;22;128;129;19;94"
 S:'SRNOVA SRDR="11;10;12;40;41;24;25;32;43;22;128;129;19;94"
 K DA,DIC,DIQ,SRX,SRY S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
 I SRNOVA D
 .D HW^SRTPUTL
 .W !,"Date on Waiting List:",?24,$P(SRAO(2),"^"),?40,"Alpha 1 Anti-Trypsin Deficiency:",?73,$P(SRAO(9),"^")
 .S SRAO(3)=$$OUT^SRTPLUN1(4,$P(^SRT(SRTPP,0),"^",4))_"^4"
 .W !,"Recipient Height:",?24,$P(SRAO(3),"^"),?40,"Bronchiectasis:",?73,$P(SRAO(10),"^")
 .S SRAO(4)=$$OUT^SRTPLUN1(5,$P(^SRT(SRTPP,0),"^",5))_"^5"
 .W !,"Recipient Weight:",?24,$P(SRAO(4),"^"),?40,"Interstitial Lung Disease:",?73,$P(SRAO(11),"^")
 .W !,"ABO Blood Type:",?24,$P(SRAO(5),"^"),?40,"Sarcoidosis:",?73,$P(SRAO(12),"^")
 .W !,"Recipient CMV:",?24,$P(SRAO(6),"^"),?40,"Lung Cancer:",?73,$P(SRAO(13),"^")
 .W !,"Pulmonary Fibrosis:",?24,$P(SRAO(7),"^"),?40,"Emphysema:",?73,$P(SRAO(14),"^")
 .W !,"Pulmonary Hypertension:",?24,$P(SRAO(8),"^"),?40,"Rejection:",?73,$P(SRAO(17),"^")
 .W !,"Other Diagnosis: ",$P(SRAO(15),"^")
 .W !!,"Transplant Comments: " S SREXT=$P(SRAO(16),"^") D COMM^SRTPLIV1
 I 'SRNOVA D
 .W !,"Date Placed on Waiting List:",?29,$P(SRAO(1),"^"),?45,"Bronchiectasis:",?72,$P(SRAO(7),"^")
 .W !,"Recipient ABO Blood Type:",?29,$P(SRAO(2),"^"),?45,"Interstitial Lung Disease:",?72,$P(SRAO(8),"^")
 .W !,"Recipient CMV:",?29,$P(SRAO(3),"^"),?45,"Sarcoidosis:",?72,$P(SRAO(9),"^")
 .W !,"Pulmonary Fibrosis:",?29,$P(SRAO(4),"^"),?45,"Lung Cancer:",?72,$P(SRAO(10),"^")
 .W !,"Pulmonary Hypertension:",?29,$P(SRAO(5),"^"),?45,"Emphysema:",?72,$P(SRAO(11),"^")
 .W !,"Alpha 1 Anti-Trypsin Deficiency: ",$P(SRAO(6),"^"),?45,"Rejection:",?72,$P(SRAO(14),"^")
 .W !,"Other Diagnosis: ",$P(SRAO(12),"^")
 .W !!,"Transplant Comments: " S SREXT=$P(SRAO(13),"^") D COMM^SRTPLIV1
 I $E(IOST)'="P" D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
 I $E(IOST)="P" G:SRSOUT END^SRTPPAS I $Y+20>IOSL D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
TRANS ;
 K DR,SRAO,SRX,Y
 W:$E(IOST)="P" ! W !,?28,"LUNG TRANSPLANT INFORMATION",!
 S (DR,SRDR)="50;51;85;87;89;68;13;14;15;17;16;18"
 K DA,DIC,DIQ,SRX,SRY,SRZ S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
 W !,"LAS Score at Listing: ",?25,$P(SRAO(1),"^")
 W !,"LAS Score at Transplant: ",?25,$P(SRAO(2),"^"),?44,"Recipient HLA-A:  ",$P(SRAO(7),"^")
 W !,"Ischemia Time for Organ (minutes)",?44,"Recipient HLA-B:  ",$P(SRAO(8),"^")
 W !," - Warm Ischemia time:",?25,$P(SRAO(3),"^"),?44,"Recipient HLA-C:  ",$P(SRAO(9),"^")
 W !," - Cold Ischemia time:",?25,$P(SRAO(4),"^"),?44,"Recipient HLA-DR: ",$P(SRAO(10),"^")
 W !," - Total Ischemia time:",?25,$P(SRAO(5),"^"),?44,"Recipient HLA-BW: ",$P(SRAO(11),"^")
 W !,"Crossmatch D/R:",?25,$P(SRAO(6),"^"),?44,"Recipient HLA-DQ: ",$P(SRAO(12),"^")
 I $E(IOST)'="P" D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
 I $E(IOST)="P" G:SRSOUT END^SRTPPAS I $Y+20>IOSL D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
 G ^SRTPRLU1
 Q

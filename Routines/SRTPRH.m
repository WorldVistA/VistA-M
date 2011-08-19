SRTPRH ;BIR/SJA - PRINT HEART RECIPIENT/DIAGNOSIS INFORMATION ;04/21/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 K DR,SRAO,SRX,Y
 S SRDR=$S(SRNOVA:"11;58;57;4;5;10;12;167;168;163;164;165;89;166;68;19",1:"11;58;57;163;164;165;89;166;68;10;12;19")
 K DA,DIC,DIQ,SRX,SRY S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
 I 'SRNOVA D
 .W !,"Date Listed with UNOS:",?25,$P(SRAO(1),"^"),?40,"Total Ischemia time:",?66,$P(SRAO(7),"^")
 .W !,"UNOS at Time of Listing:",?25,$P(SRAO(2),"^"),?40,"PRA %:",?66,$P(SRAO(8),"^")
 .W !,"UNOS at Time of TX:",?25,$P(SRAO(3),"^"),?40,"Crossmatch D/R:",?66,$P(SRAO(9),"^")
 .W !,"PVR Before Vasodilation:",?25,$P(SRAO(4),"^"),?40,"Recipient ABO Blood Type:",?66,$P(SRAO(10),"^")
 .W !,"PVR After Vasodilation:",?25,$P(SRAO(5),"^"),?40,"Recipient CMV:",?66,$P(SRAO(11),"^")
 .W !,"LVEF %:",?25,$P(SRAO(6),"^")
 .W !!,"Transplant Comments: " S SREXT=$P(SRAO(12),"^") D COMM^SRTPLIV1
 I SRNOVA D
 .W !,"Date Listed with UNOS:",?25,$P(SRAO(1),"^"),?40,"PAW Mean Pressure:",?65,$P(SRAO(9),"^")
 .W !,"UNOS at Time of Listing:",?25,$P(SRAO(2),"^"),?40,"PVR Before Vasodilation:",?65,$P(SRAO(10),"^")
 .W !,"UNOS at Time of TX:",?25,$P(SRAO(3),"^"),?40,"PVR After Vasodilation:",?65,$P(SRAO(11),"^")
 .D HW^SRTPUTL
 .S SRAO(4)=$$OUT^SRTPLUN1(4,$P(^SRT(SRTPP,0),"^",4))_"^4"
 .W !,"Recipient Height:",?25,$P(SRAO(4),"^"),?40,"LVEF %:",?65,$P(SRAO(12),"^")
 .S SRAO(5)=$$OUT^SRTPLUN1(5,$P(^SRT(SRTPP,0),"^",5))_"^5"
 .W !,"Recipient Weight:",?25,$P(SRAO(5),"^"),?40,"Total Isch. Time:",?65,$P(SRAO(13),"^")
 .W !,"ABO Blood Type:",?25,$P(SRAO(6),"^"),?40,"PRA %:",?65,$P(SRAO(14),"^")
 .W !,"Recipient CMV:",?25,$P(SRAO(7),"^"),?40,"Crossmatch D/R:",?65,$P(SRAO(15),"^")
 .W !,"PA Systolic Pressure:",?25,$P(SRAO(8),"^")
 .W !!,"Transplant Comments: " S SREXT=$P(SRAO(16),"^") D COMM^SRTPLIV1
 I $E(IOST)'="P" D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
 I $E(IOST)="P" G:SRSOUT END^SRTPPAS I $Y+20>IOSL D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
DIAG K DR,SRAO,SRX,Y
 W:$E(IOST)="P" ! W !,?28,"TRANSPLANT INFORMATION",!
 S SRDR="155;156;157;158;159;43;160;161;162;94;112;13;14;15;16;17;18"
 K DA,DIC,DIQ,SRX,SRY S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
 W !,"Dilated Cardiomyopathy:",?27,$P(SRAO(1),"^")
 W !,"Coronary Artery Disease:",?27,$P(SRAO(2),"^"),?45,"Recipient HLA-A:  ",$P(SRAO(12),"^")
 W !,"Ischemic Cardiomyopathy:",?27,$P(SRAO(3),"^"),?45,"Recipient HLA-B:  ",$P(SRAO(13),"^")
 W !,"Alcoholic Cardiomyopathy:",?27,$P(SRAO(4),"^"),?45,"Recipient HLA-C:  ",$P(SRAO(14),"^")
 W !,"Valvular Cardiomyopathy:",?27,$P(SRAO(5),"^"),?45,"Recipient HLA-BW: ",$P(SRAO(15),"^")
 W !,"Sarcoidosis:",?27,$P(SRAO(6),"^"),?45,"Recipient HLA-DR: ",$P(SRAO(16),"^")
 W !,"Idiopathic Cardiomyopathy:",?27,$P(SRAO(7),"^"),?45,"Recipient HLA-DQ: ",$P(SRAO(17),"^")
 W !,"Viral Cardiomyopathy:",?27,$P(SRAO(8),"^")
 W !,"Peripartum Cardiomyopathy:",?27,$P(SRAO(9),"^")
 W !,"Rejection:",?27,$P(SRAO(10),"^")
 W !,"Other Cardiomyopathy:" S SREXT=$P(SRAO(11),"^") D COMM^SRTPHRT2
 I $E(IOST)'="P" D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
 I $E(IOST)="P" G:SRSOUT END^SRTPPAS I $Y+25>IOSL D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
 G ^SRTPRH1
 Q

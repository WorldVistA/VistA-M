SRTPRLI ;BIR/SJA - PRINT LIVER-RECIPIENT/DIAGNOSIS INFORMATION ;04/21/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 K DR,SRAO,SRX,Y
 S SRDR=$S(SRNOVA:"1;11;4;5;10;12;52;53;54;55;19",1:"11;10;12;52;53;54;55;19")
 K DA,DIC,DIQ,SRX,SRY S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
VA I 'SRNOVA D
 .W !,"Date on Waiting List:",?32,$P(SRAO(1),"^")
 .W !,"Recipient ABO Blood Type:",?32,$P(SRAO(2),"^")
 .W !,"Recipient CMV:",?32,$P(SRAO(3),"^")
 .W !,"MELD Score at Listing:",?32,$P(SRAO(4),"^")
 .W !,"Biologic MELD Score at Listing:",?32,$P(SRAO(5),"^")
 .W !,"Meld Score at Transplant:",?32,$P(SRAO(6),"^")
 .W !,"Biologic MELD Score at TX:",?32,$P(SRAO(7),"^")
 .W !!,"Transplant Comments: " S SREXT=$P(SRAO(8),"^") D COMM^SRTPLIV1
NONVA I SRNOVA D
 .W !,"Date on Waiting List:",?32,$P(SRAO(2),"^")
 .D HW^SRTPUTL
 .S SRAO(3)=$$OUT^SRTPLUN1(4,$P(^SRT(SRTPP,0),"^",4))_"^4"
 .W !,"Recipient Height:",?32,$P(SRAO(3),"^")
 .S SRAO(4)=$$OUT^SRTPLUN1(5,$P(^SRT(SRTPP,0),"^",5))_"^5"
 .W !,"Recipient Weight:",?32,$P(SRAO(4),"^")
 .W !,"Recipient ABO Blood Type:",?32,$P(SRAO(5),"^")
 .W !,"Recipient CMV:",?32,$P(SRAO(6),"^")
 .W !,"MELD Score at Listing:",?32,$P(SRAO(7),"^")
 .W !,"Biologic MELD Score at Listing:",?32,$P(SRAO(8),"^")
 .W !,"Meld Score at Transplant:",?32,$P(SRAO(9),"^")
 .W !,"Biologic MELD Score at TX:",?32,$P(SRAO(10),"^")
 .W !!,"Transplant Comments: " S SREXT=$P(SRAO(11),"^") D COMM^SRTPLIV1
 I $E(IOST)'="P" D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
 I $E(IOST)="P" G:SRSOUT END^SRTPPAS I $Y+20>IOSL D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
DIAG K DR,SRAO,SRX,Y W:$E(IOST)="P" ! W !,?28,"DIAGNOSIS INFORMATION",!
 S (DR,SRDR)="21;20;23;99;100;101;27;28;29;30;102;34;35;38;105;39;106;107;47;56;111;120;127;94"
 K DA,DIC,DIQ,SRX,SRY,SRZ S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
 W !,"Acute Liver Failure:",?29,$P(SRAO(1),"^"),?39,"Primary Biliary Cholangitis:",?71,$P(SRAO(14),"^")
 W !,"Acetaminophen Toxicity:",?29,$P(SRAO(2),"^"),?39,"Primary Non-Function:",?71,$P(SRAO(15),"^")
 W !,"Alcoholic Cirrhosis:",?29,$P(SRAO(3),"^"),?39,"Primary Sclerosing Cholangitis:",?71,$P(SRAO(16),"^")
 W !,"Autoimmune Hepatitis:",?29,$P(SRAO(4),"^"),?39,"Second Sclerosing Cholangitis:",?71,$P(SRAO(17),"^")
 W !,"Cryptogenic Cirrhosis:",?29,$P(SRAO(5),"^"),?39,"Toxic Exposure:",?71,$P(SRAO(18),"^")
 W !,"Chronic Rejection:",?29,$P(SRAO(6),"^"),?39,"Biliary Stricture:",?71,$P(SRAO(19),"^")
 W !,"Graft Failure:",?29,$P(SRAO(7),"^"),?39,"Bile Leak:",?71,$P(SRAO(20),"^")
 W !,"HBV Cirrhosis (Hepatitis B):",?29,$P(SRAO(8),"^"),?39,"Portal Vein Thrombosis:",?71,$P(SRAO(21),"^")
 W !,"HCC (Hepatocellular CA):",?29,$P(SRAO(9),"^"),?39,"Psychosis:",?71,$P(SRAO(22),"^")
 W !,"HCV Cirrhosis (Hepatitis C):",?29,$P(SRAO(10),"^"),?39,"Seizures:",?71,$P(SRAO(23),"^")
 W !,"Hepatic Artery Thrombosis:",?29,$P(SRAO(11),"^"),?39,"Rejection:",?71,$P(SRAO(24),"^")
 W !,"Metabolic:",?29,$P(SRAO(12),"^")
 W !,"NASH:",?29,$P(SRAO(13),"^")
 G:SRSOUT END^SRTPPAS I $Y+20>IOSL D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
 I $E(IOST)="P" G:SRSOUT END^SRTPPAS I $Y+20>IOSL D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
 G ^SRTPRLI1
 Q

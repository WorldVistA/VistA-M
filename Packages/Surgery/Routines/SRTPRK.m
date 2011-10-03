SRTPRK ;BIR/SJA - PRINT KIDNEY - RECIPIENT INFORMATION ;04/21/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 K DR,SRAO,SRX,Y
 S SRDR=$S(SRNOVA:"1;11;187;10;12;4;5;96;26;27;95;97;33;98;37;42;19;94",1:"11;187;10;12;96;26;27;95;97;33;98;37;42;19;94")
 K DA,DIC,DIQ,SRX,SRY S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
VA I 'SRNOVA D
 .W !!,"Date Placed on Waiting:",?24,$P(SRAO(1),"^"),?40,"Recipient CMV:",?71,$P(SRAO(4),"^")
 .W !,"Date Started Dialysis:",?24,$P(SRAO(2),"^"),?40,"Recipient ABO Blood Type:",?71,$P(SRAO(3),"^")
 .W !,"Calcineurin Inhibitor Toxicity:",?32,$P(SRAO(5),"^"),?40,"Membranous Nephropathy:",?71,$P(SRAO(10),"^")
 .W !,"Glomerular Sclerosis/Nephritis:",?32,$P(SRAO(6),"^"),?40,"Obstructive Uropathy from BPH:",?71,$P(SRAO(11),"^")
 .W !,"Graft Failure:",?32,$P(SRAO(7),"^"),?40,"Polycistic Disease:",?71,$P(SRAO(12),"^")
 .W !,"IgA Nephropathy:",?32,$P(SRAO(8),"^"),?40,"Renal Cancer:",?71,$P(SRAO(13),"^")
 .W !,"Lithium Toxicity:",?32,$P(SRAO(9),"^"),?40,"Rejection:",?71,$P(SRAO(15),"^")
 .W !!,"Transplant Comments: " S SREXT=$P(SRAO(14),"^") D COMM^SRTPLIV1
NONVA I SRNOVA D
 .D HW^SRTPUTL
 .W !!,"Date Placed on Waiting:",?24,$P(SRAO(2),"^"),?46,"Recipient CMV:",?64,$P(SRAO(5),"^")
 .W !,"Date Started Dialysis: ",?24,$P(SRAO(3),"^")
 .S SRAO(6)=$$OUT^SRTPLUN1(4,$P(^SRT(SRTPP,0),"^",4))_"^4" W ?46,"Recipient Height:",?64,$P(SRAO(6),"^")
 .W !,"ABO Blood Type:",?24,$P(SRAO(4),"^")
 .S SRAO(7)=$$OUT^SRTPLUN1(5,$P(^SRT(SRTPP,0),"^",5))_"^5" W ?46,"Recipient Weight:",?64,$P(SRAO(7),"^")
 .W !!,"Calcineurin Inhibitor Toxicity:",?32,$P(SRAO(8),"^"),?40,"Membranous Nephropathy:",?71,$P(SRAO(13),"^")
 .W !,"Glomerular Sclerosis/Nephritis:",?32,$P(SRAO(9),"^"),?40,"Obstructive Uropathy from BPH:",?71,$P(SRAO(14),"^")
 .W !,"Graft Failure:",?32,$P(SRAO(10),"^"),?40,"Polycistic Disease:",?71,$P(SRAO(15),"^")
 .W !,"IgA Nephropathy:",?32,$P(SRAO(11),"^"),?40,"Renal Cancer:",?71,$P(SRAO(16),"^")
 .W !,"Lithium Toxicity:",?32,$P(SRAO(12),"^"),?40,"Rejection:",?71,$P(SRAO(18),"^")
 .W !!,"Transplant Comments: " S SREXT=$P(SRAO(17),"^") D COMM^SRTPLIV1
 I $E(IOST)'="P" D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
 I $E(IOST)="P" G:SRSOUT END^SRTPPAS I $Y+20>IOSL D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
 G ^SRTPRK1
 Q

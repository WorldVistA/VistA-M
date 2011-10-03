SRTPRK2 ;BIR/SJA - PRINT KIDNEY-OUTCOME/DONOR INFORMATION ;04/21/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 K SRAO,SRX,Y
 ; print outcome information for non-VA transplants
 I 'SRNOVA G DONOR
 W:$E(IOST)="P" ! W !,?28,"OUTCOME INFORMATION",!
 K DR S (DR,SRDR)="116;117;118;119;192;121;122;123;124;125;126;193;133"
 K DA,DIC,DIQ,SRX,SRY,SRZ S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
 W !,"Bleeding/Transfusions:",?30,$P(SRAO(1),"^"),?45,"Superficial Incisional SSI:",?76,$P(SRAO(8),"^")
 W !,"Pneumonia:",?30,$P(SRAO(2),"^"),?45,"Deep Incisional SSI:",?76,$P(SRAO(9),"^")
 W !,"On Ventilator >48 hours:",?30,$P(SRAO(3),"^"),?45,"Systemic Sepsis:",?76,$P(SRAO(10),"^")
 W !,"Cardiac Arrest Requiring CPR:",?30,$E($P(SRAO(4),"^"),1,13),?45,"Return to Surgery w/i 30 Days:",?76,$P(SRAO(11),"^")
 W !,"Myocardial Infarction:",?30,$P(SRAO(5),"^"),?45,"Operative Death:",?76,$P(SRAO(12),"^")
 W !,"Stroke/CVA:",?30,$P(SRAO(6),"^"),?45,"Graft Failure Date:",?66,$P(SRAO(13),"^")
 W !,"Coma >= 24 hr:",?30,$P(SRAO(7),"^")
 I $E(IOST)'="P" D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
 I $E(IOST)="P" G:SRSOUT END^SRTPPAS I $Y+35>IOSL D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
DONOR ; print donor information
 K SRAO,SRX,Y
 W:$E(IOST)="P" ! W !,?28,"DONOR INFORMATION",!
 K DR,SRAO S (DR,SRDR)="45;31;36;70;46;48;49;77;69;103;104;64;65;66;73;67;72" S SRAO(1)=""
 K DA,DIC,DIQ,SRX,SRY,SRZ S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I+1)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
 ; race information
 K SRY,SRZ S DIC="^SRT(",DR=44,DA=SRTPP,DR(139.544)=".01"
 S (II,JJ)=0 F  S II=$O(^SRT(SRTPP,44,II)) Q:'II  S SRACE=$G(^SRT(SRTPP,44,II,0)) D  K SRY
 .S DA(139.544)=II,DIQ="SRY",DIQ(0)="E" D EN^DIQ1
 .S JJ=JJ+1,SRZ(139.544,JJ)=SRACE_"^"_$G(SRY(139.544,II,.01,"E")),SRZ(139.544)=JJ
 D RACE^SRTPDONR
 W !,"Donor Race:" S SRAO(1)="" I $G(SRZ(139.544)) F D=1:1:SRNUM1-1 W:D=1 ?17,SROL(D) W:D'=1 !,?17,SROL(D)
 W !,"Donor Gender:",?17,$P(SRAO(2),"^")
 W !,"Donor Height:",?17,$P(SRAO(3),"^")
 W !,"Donor Weight:",?17,$P(SRAO(4),"^")
 W !,"Donor DOB:",?17,$P(SRAO(5),"^"),?45,"Donor HLA-A:  ",$P(SRAO(13),"^")
 W !,"Donor Age:",?17,$P(SRAO(6),"^"),?45,"Donor HLA-B:  ",$P(SRAO(14),"^")
 W !,"ABO Blood Type:",?17,$P(SRAO(7),"^"),?45,"Donor HLA-C:  ",$P(SRAO(15),"^")
 W !,"Donor CMV:",?17,$P(SRAO(8),"^"),?45,"Donor HLA-DR: ",$P(SRAO(16),"^")
 W !,"Substance Abuse:",?17,$P(SRAO(9),"^"),?45,"Donor HLA-BW: ",$P(SRAO(17),"^")
 W !,"Deceased Donor:",?17,$P($P(SRAO(10),"^"),"("),?45,"Donor HLA-DQ: ",$P(SRAO(18),"^")
 W !,"Living Donor:",?17,$P(SRAO(11),"^")
 W !,"With Malignancy:",?17,$P(SRAO(12),"^")
 I $E(IOST)'="P" D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
 I $E(IOST)="P" G:SRSOUT END^SRTPPAS I $Y+20>IOSL D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
 G ^SRTPRK3
 Q

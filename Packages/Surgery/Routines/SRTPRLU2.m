SRTPRLU2 ;BIR/SJA - PRINT LUNG-OUTCOME/DONOR INFORMATION ;04/21/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 I 'SRNOVA G DONOR
 K DR,SRAO,SRX,Y,DR,II
 W !,?28,"OUTCOME INFORMATION",!
 S (DR,SRDR)="116;117;118;119;192;121;122;123;124;125;126;193"
 K DA,DIC,DIQ,SRX,SRY,SRZ S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
 W !,"Bleeding/Transfusions:",?25,$P(SRAO(1),"^"),?44,"Coma >= 24 hr:",?75,$P(SRAO(7),"^")
 W !,"Pneumonia:",?25,$P(SRAO(2),"^"),?44,"Superficial Incisional SSI:",?75,$P(SRAO(8),"^")
 W !,"On Ventilator >48 hours:",?25,$P(SRAO(3),"^"),?44,"Deep Incisional SSI:",?75,$P(SRAO(9),"^")
 W !,"Cardiac Arrest Req CPR:",?25,$P(SRAO(4),"^"),?44,"Systemic Sepsis:",?75,$P(SRAO(10),"^")
 W !,"Myocardial Infarction:",?25,$P(SRAO(5),"^"),?44,"Return to Surgery w/i 30 Days:",?75,$P(SRAO(11),"^")
 W !,"Stroke/CVA:",?25,$P(SRAO(6),"^"),?44,"Operative Death:",?75,$P(SRAO(12),"^")
 I $E(IOST)'="P" D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
 I $E(IOST)="P" G:SRSOUT END^SRTPPAS I $Y+20>IOSL D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
DONOR ;
 K DR,SRAO,SRX,Y W:$E(IOST)="P" ! W !,?28,"DONOR INFORMATION",!
 S (DR,SRDR)="45;31;36;70;46;48;49;77;69;103;104;64;65;66;73;67;72" S SRAO(1)=""
 K DA,DIC,DIQ,SRX,SRY,SRZ S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I+1)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
 ; race information
 K SRY,SRZ S DIC="^SRT(",DR=44,DA=SRTPP,DR(139.544)=".01"
 S (II,JJ)=0 F  S II=$O(^SRT(SRTPP,44,II)) Q:'II  S SRACE=$G(^SRT(SRTPP,44,II,0)) D  K SRY
 .S DA(139.544)=II,DIQ="SRY",DIQ(0)="E" D EN^DIQ1
 .S JJ=JJ+1,SRZ(139.544,JJ)=SRACE_"^"_$G(SRY(139.544,II,.01,"E")),SRZ(139.544)=JJ
 D RACE^SRTPDONR
 W !,"Donor Race:" S SRAO(1)="" I $G(SRZ(139.544)) F D=1:1:SRNUM1-1 W:D=1 ?17,SROL(D) W:D'=1 !,?17,SROL(D)
 W !,"Donor Gender:",?17,$P(SRAO(2),"^"),?40,"Living Donor:",?57,$P(SRAO(11),"^")
 W !,"Donor Height:",?17,$P(SRAO(3),"^"),?40,"With Malignancy:",?57,$P(SRAO(12),"^")
 W !,"Donor Weight:",?17,$P(SRAO(4),"^")
 W !,"Donor DOB:",?17,$P(SRAO(5),"^"),?40,"Donor HLA-A:",?57,$P(SRAO(13),"^")
 W !,"Donor Age:",?17,$P(SRAO(6),"^"),?40,"Donor HLA-B:",?57,$P(SRAO(14),"^")
 W !,"ABO Blood Type:",?17,$P(SRAO(7),"^"),?40,"Donor HLA-C:",?57,$P(SRAO(15),"^")
 W !,"Donor CMV:",?17,$P(SRAO(8),"^"),?40,"Donor HLA-DR:",?57,$P(SRAO(16),"^")
 W !,"Substance Abuse:",?17,$P(SRAO(9),"^"),?40,"Donor HLA-BW:",?57,$P(SRAO(17),"^")
 W !,"Deceased Donor:",?17,$P($P(SRAO(10),"^"),"("),?40,"Donor HLA-DQ:",?57,$P(SRAO(18),"^")
 I $E(IOST)="C" W !! K DIR S DIR(0)="FOA",DIR("A")="Press RETURN to continue" D ^DIR K DIR
 G END^SRTPPAS

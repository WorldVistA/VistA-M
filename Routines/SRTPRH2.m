SRTPRH2 ;BIR/SJA - PRINT HEART - OUTCOME/DONOR INFORMATION ;04/21/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 I 'SRNOVA G DONOR
 W !,?28,"OUTCOME INFORMATION",!
 K DR,SRAO,SRX,Y
 S SRDR="193;170;192;191;190;119;189;148;118;121;122;130;109;110"
 K DA,DIC,DIQ,SRX,SRY,SRZ S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
 W !,"Operative Death:",?29,$P(SRAO(1),"^"),?48,"On ventilator >= 48 hr:",?75,$P(SRAO(9),"^")
 W !,"Date/Time of Death:",?29,$P(SRAO(2),"^"),?48,"Stroke:",?75,$P(SRAO(10),"^")
 W !,"Perioperative MI:",?29,$P(SRAO(3),"^"),?48,"Coma >= 24 hr:",?75,$P(SRAO(11),"^")
 W !,"Renal Failure Req. dialysis:",?29,$P(SRAO(4),"^"),?48,"New Mech Circ Support: ",$E($P(SRAO(12),"^"),1,9)
 W !,"Mediastinitis:",?29,$P(SRAO(5),"^"),?48,"Post-Transplant Prophylaxis for"
 W !,"Cardiac Arrest Req. CPR:",?29,$P(SRAO(6),"^"),?48," CMV/Anti-Viral Treatment:",?75,$P(SRAO(13),"^")
 W !,"Tracheostomy:",?29,$P(SRAO(7),"^"),?48," PCP/Antibiotic Treatment:",?75,$P(SRAO(14),"^")
 W !,"Reoperation for Bleeding:",?29,$P(SRAO(8),"^")
 I $E(IOST)'="P" D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
 I $E(IOST)="P" G:SRSOUT END^SRTPPAS I $Y+20>IOSL D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
DONOR W !!,?28,"DONOR INFORMATION",!
 K DR,SRAO,SRX,Y
 S (DR,SRDR)="45;31;36;70;46;48;49;77;69;104;64;65;66;73;67;72" S SRAO(1)=""
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
 W !,"Donor DOB:",?17,$P(SRAO(5),"^"),?45,"Donor HLA-A:  ",$P(SRAO(12),"^")
 W !,"Donor Age:",?17,$P(SRAO(6),"^"),?45,"Donor HLA-B:  ",$P(SRAO(13),"^")
 W !,"ABO Blood Type:",?17,$P(SRAO(7),"^"),?45,"Donor HLA-C:  ",$P(SRAO(14),"^")
 W !,"Donor CMV:",?17,$P(SRAO(8),"^"),?45,"Donor HLA-DR: ",$P(SRAO(15),"^")
 W !,"Substance Abuse:",?17,$P(SRAO(9),"^"),?45,"Donor HLA-BW: ",$P(SRAO(16),"^")
 W !,"Deceased Donor:",?17,$P($P(SRAO(10),"^"),"("),?45,"Donor HLA-DQ: ",$P(SRAO(17),"^")
 W !,"With Malignancy:",?17,$P(SRAO(11),"^")
 I $E(IOST)="C" W !! K DIR S DIR(0)="FOA",DIR("A")="Press RETURN to continue" D ^DIR K DIR
 G END^SRTPPAS

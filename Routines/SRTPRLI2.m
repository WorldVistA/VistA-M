SRTPRLI2 ;BIR/SJA - PRINT LIVER-RISK ASSESSMENT/OUTCOME INFORMATION ;04/21/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 I 'SRNOVA G DONOR
RISK K DR,SRAO,SRX,Y
 S (DR,SRDR)="81;82;88;83;109;110;145;132;146;131"
 K DA,DIC,DIQ,SRX,SRY,SRZ S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
 W !,"Preop TX Skin Malignancy:",?48,$P(SRAO(1),"^")
 W !,"Other Pre-TX Malignancy:",?48,$P(SRAO(2),"^")
 W !,"Ascites:",?48,$P(SRAO(3),"^")
 W !,"Recipient Substance Abuse:",?48,$P(SRAO(4),"^")
 W !,"Post TX Prophylaxis - CMV/Anti-Viral Treatment:",?48,$P(SRAO(5),"^")
 W !,"Post TX Prophylaxis - PCP/Antibiotic Treatment:",?48,$P(SRAO(6),"^")
 W !,"Hypertension Requiring Meds:",?48,$P(SRAO(7),"^")
 W !,"Peripheral Vascular Disease:",?48,$P(SRAO(8),"^")
 W !,"Transfusion >4 RBC Units:",?48,$P(SRAO(9),"^")
 W !,"Preop Functional Health Status:",?48,$P(SRAO(10),"^")
 I $E(IOST)'="P" D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
 I $E(IOST)="P" G:SRSOUT END^SRTPPAS I $Y+20>IOSL D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
OUTCOME K DR,SRAO,SRX,Y
 W:$E(IOST)="P" ! W !,?28,"OUTCOME INFORMATION",!
 S (DR,SRDR)="116;117;118;119;192;121;122;123;124;125;126;193"
 K DA,DIC,DIQ,SRX,SRY,SRZ S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
 W !,"Bleeding/Transfusions:",?33,$P(SRAO(1),"^")
 W !,"Pneumonia:",?33,$P(SRAO(2),"^")
 W !,"On Ventilator >48 hours:",?33,$P(SRAO(3),"^")
 W !,"Cardiac Arrest Req. CPR:",?33,$P(SRAO(4),"^")
 W !,"Myocardial Infarction:",?33,$P(SRAO(5),"^")
 W !,"Stroke/CVA:",?33,$P(SRAO(6),"^")
 W !,"Coma >= 24 hr:",?33,$P(SRAO(7),"^")
 W !,"Superficial Incisional SSI:",?33,$P(SRAO(8),"^")
 W !,"Deep Incisional SSI:",?33,$P(SRAO(9),"^")
 W !,"Systemic Sepsis:",?33,$P(SRAO(10),"^")
 W !,"Return to Surgery < 30 Days:",?33,$P(SRAO(11),"^")
 W !,"Death within 30 Days:",?33,$P(SRAO(12),"^")
 I $E(IOST)'="P" D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
 I $E(IOST)="P" G:SRSOUT END^SRTPPAS I $Y+20>IOSL D PAGE^SRTPPAS I SRSOUT G END^SRTPPAS
DONOR K DR,SRAO,SRX,Y
 W:$E(IOST)="P" ! W !,?28,"DONOR INFORMATION",!
 S (DR,SRDR)="45;31;36;70;46;48;49;77;69;103;104;64;65;66;73;67;72" S SRAO(1)=""
 K DA,DIC,DIQ,SRX,SRY,SRZ S DIC="^SRT(",DA=SRTPP,DIQ="SRY",DIQ(0)="E",DR=SRDR D EN^DIQ1 K DA,DIC,DIQ,DR
 S (SRX,SRZ)=0 F I=1:1 S SRZ=$P(SRDR,";",I) Q:'SRZ  S SRX=I,SRAO(I+1)=SRY(139.5,SRTPP,SRZ,"E")_"^"_SRZ
 ; race information
 K SRY,SRZ S DIC="^SRT(",DR=44,DA=SRTPP,DR(139.544)=".01"
 S (II,JJ)=0 F  S II=$O(^SRT(SRTPP,44,II)) Q:'II  S SRACE=$G(^SRT(SRTPP,44,II,0)) D  K SRY
 .S DA(139.544)=II,DIQ="SRY",DIQ(0)="E" D EN^DIQ1
 .S JJ=JJ+1,SRZ(139.544,JJ)=SRACE_"^"_$G(SRY(139.544,II,.01,"E")),SRZ(139.544)=JJ
 D RACE^SRTPLIV7
 W !,"Donor Race:" S SRAO(1)="" I $G(SRZ(139.544)) F D=1:1:SRNUM1-1 W:D=1 ?17,SROL(D) W:D'=1 !,?17,SROL(D)
 W !,"Donor Gender:",?17,$P(SRAO(2),"^")
 W !,"Donor Height:",?17,$P(SRAO(3),"^"),?40,"Donor HLA Typing (#,#,#)"
 W !,"Donor Weight:",?17,$P(SRAO(4),"^"),?40,"========================"
 W !,"Donor DOB:",?17,$P(SRAO(5),"^"),?40,"Donor HLA-A:  ",$P(SRAO(13),"^")
 W !,"Donor Age:",?17,$P(SRAO(6),"^"),?40,"Donor HLA-B:  ",$P(SRAO(14),"^")
 W !,"ABO Blood Type:",?17,$P(SRAO(7),"^"),?40,"Donor HLA-C:  ",$P(SRAO(15),"^")
 W !,"Donor CMV:",?17,$P(SRAO(8),"^"),?40,"Donor HLA-DR: ",$P(SRAO(16),"^")
 W !,"Substance Abuse:",?17,$P(SRAO(9),"^"),?40,"Donor HLA-BW: ",$P(SRAO(17),"^")
 W !,"Deceased Donor:",?17,$P($P(SRAO(10),"^"),"("),?40,"Donor HLA-DQ: ",$P(SRAO(18),"^")
 W !,"Living Donor:",?17,$P(SRAO(11),"^")
 W !,"With Malignancy:",?17,$P(SRAO(12),"^")
 I $E(IOST)="C" W !! K DIR S DIR(0)="FOA",DIR("A")="Press RETURN to continue" D ^DIR K DIR
 G END^SRTPPAS

ONCGPC1 ;Hines OIFO/GWB - 2001 Gastric Cancers PCE Study ;02/27/01
 ;;2.11;ONCOLOGY;**29**;Mar 07, 1995
 ;Patient Information 
 S DIE="^ONCO(165.5,",DA=ONCONUM,DR=""
 W @IOF D HEAD^ONCGPC0
 W !," PATIENT INFORMATION"
 W !," -------------------"
 S DR(1,165.5,1)="1400.6  1. CO-MORBID CONDITIONS (YES/NO)."
 S DR(1,165.5,2)="I $G(X)=0 D CC1^ONCGPC1,CC2^ONCGPC1,CC3^ONCGPC1,CC4^ONCGPC1,CC5^ONCGPC1,CC6^ONCGPC1 S Y=1500"
 S DR(1,165.5,3)="1571      CO-MORBID CONDITION #1......."
 S DR(1,165.5,3.1)="I ($G(X)="""")&($P($G(^ONCO(165.5,DA,""LUN1"")),U,76)=1) D ITEM1ED^ONCGPC1 S Y=1571"
 S DR(1,165.5,4)="1571.1      CO-MORBID CONDITION #2......."
 S DR(1,165.5,4.1)="I $G(X)="""" D CC3^ONCGPC1,CC4^ONCGPC1,CC5^ONCGPC1,CC6^ONCGPC1 S Y=1500"
 S DR(1,165.5,5)="1571.2      CO-MORBID CONDITION #3......."
 S DR(1,165.5,5.1)="I $G(X)="""" D CC4^ONCGPC1,CC5^ONCGPC1,CC6^ONCGPC1 S Y=1500"
 S DR(1,165.5,6)="1571.3      CO-MORBID CONDITION #4......."
 S DR(1,165.5,6.1)="I $G(X)="""" D CC5^ONCGPC1,CC6^ONCGPC1 S Y=1500"
 S DR(1,165.5,7)="1571.4      CO-MORBID CONDITION #5......."
 S DR(1,165.5,7.1)="I $G(X)="""" D CC6^ONCGPC1 S Y=1500"
 S DR(1,165.5,8)="1571.5      CO-MORBID CONDITION #6......."
 S DR(1,165.5,9)="W !"
 S DR(1,165.5,10)="1500  2. PRIOR EXPOSURE TO RADIATION..."
 S DR(1,165.5,11)="W !"
 S DR(1,165.5,12)="1501  3. ALCOHOL CONSUMPTION..........."
 S DR(1,165.5,13)="W !"
 S DR(1,165.5,14)="1572  4. DURATION OF TOBACCO USE......."
 S DR(1,165.5,15)="W !"
 S DR(1,165.5,16)="I SEX'=1 S Y=""@5"""
 S DR(1,165.5,17)="1502////8"
 S DR(1,165.5,18)="W !,""  5. MENOPAUSAL STATUS AND HORMONE"""
 S DR(1,165.5,19)="W !,""      REPLACEMENT THERAPY..........: NA, male patient"""
 S DR(1,165.5,20)="W !"
 S DR(1,165.5,21)="S Y=1503"
 S DR(1,165.5,22)="@5"
 S DR(1,165.5,23)="1502  5. MENOPAUSAL STATUS AND HORMONE                                                    REPLACEMENT THERAPY.........."
 S DR(1,165.5,24)="W !"
 S DR(1,165.5,25)="1503  6. H2 BLOCKER/PROTON PUMP                                                           INHIBITOR USE................"
 S DR(1,165.5,26)="W !"
 S DR(1,165.5,27)="1504  7. FAMILY HISTORY OF GASTRIC                                                        CANCER......................."
 S DR(1,165.5,28)="W !"
 S DR(1,165.5,29)="S DEF="""" D ITEM3^ONCLPC1 K DEF"
 S DR(1,165.5,30)="1573  8. PERSONAL HISTORY OF OTHER                                                        INVASIVE MALIGNANCIES PRIOR                                                      TO THIS CANCER DIAGNOSIS....//^S X=PHDEF"
 S DR(1,165.5,31)="W !"
 S DR(1,165.5,32)="W !,""  9. ASSOCIATED BENIGN CONDTIONS:"""
 S DR(1,165.5,33)="1505      H-PYLORI INFECTION..........."
 S DR(1,165.5,34)="1506      DUODENAL ULCER..............."
 S DR(1,165.5,35)="1507      GASTRIC ULCER................"
 S DR(1,165.5,36)="1508      HEARTBURN...................."
 S DR(1,165.5,37)="1509      PERNICIOUS ANEMIA............"
 S DR(1,165.5,38)="1510      POLYPS OF STOMACH............"
 S DR(1,165.5,39)="1511      POLYPOSIS OF SMALL OR LARGE                                                      BOWEL......................."
 S DR(1,165.5,40)="1512      BARRET'S ESOPHAGUS..........."
 S DR(1,165.5,41)="1513      ATROPHIC GASTRITIS..........."
 S DR(1,165.5,42)="1514      GASTRIC METAPLASIA..........."
 S DR(1,165.5,43)="W !"
 S DR(1,165.5,44)="W !,"" 10. H-PYLORI DRUGS GIVEN:"""
 S DR(1,165.5,44.1)="I ($$GET1^DIQ(165.5,D0,1505,""I"")=2)!($$GET1^DIQ(165.5,D0,1505,""I"")=4) D HDG1^ONCGPC1,HDG2^ONCGPC1,HDG3^ONCGPC1,HDG4^ONCGPC1 S Y=1519"
 S DR(1,165.5,45)="1515      ANTIBIOTICS.................."
 S DR(1,165.5,45.1)="I $G(X)=8 D HDG2^ONCGPC1,HDG3^ONCGPC1,HDG4^ONCGPC1 S Y=1519"
 S DR(1,165.5,46)="1516      PROTON PUMP INHIBITORS......."
 S DR(1,165.5,46.1)="I $G(X)=8 D HDG3^ONCGPC1,HDG4^ONCGPC1 S Y=1519"
 S DR(1,165.5,47)="1517      H2 BLOCKERS.................."
 S DR(1,165.5,47.1)="I $G(X)=8 D HDG4^ONCGPC1 S Y=1519"
 S DR(1,165.5,48)="1518      BISMUTH COMPOUNDS............"
 S DR(1,165.5,49)="W !"
 S DR(1,165.5,50)="1519 11. PRIOR INTRA-ABDOMINAL SURGERY."
 S DR(1,165.5,51)="W !"
 S DR(1,165.5,52)="1520 12. YEAR OF PRIOR GASTRIC                                                            RESECTION...................."
 D ^DIE
 W !
 K DIR S DIR(0)="E" D ^DIR S:$D(DIRUT) OUT="Y"
EXIT K DIC,DR,DA,DIQ,DIE,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 K PHDEF
 Q
ITEM1ED ;ITEM 1 EDIT
 W !
 W !,"     CO-MORBID CONDITIONS (YES/NO) equals ""Yes"""
 W !,"      CO-MORBID CONDITION #1 may not be blank"
 W !
 Q 
CC1 S $P(^ONCO(165.5,D0,"GAS2"),U,33)=""
 W !,"      CO-MORBID CONDITION #1.......: 000.00 No co-morbidities"
 Q
CC2 S $P(^ONCO(165.5,D0,"GAS2"),U,34)=""
 W !,"      CO-MORBID CONDITION #2.......:"
 Q
CC3 S $P(^ONCO(165.5,D0,"GAS2"),U,35)=""
 W !,"      CO-MORBID CONDITION #3.......:"
 Q
CC4 S $P(^ONCO(165.5,D0,"GAS2"),U,36)=""
 W !,"      CO-MORBID CONDITION #4.......:"
 Q
CC5 S $P(^ONCO(165.5,D0,"GAS2"),U,37)=""
 W !,"      CO-MORBID CONDITION #5.......:"
 Q
CC6 S $P(^ONCO(165.5,D0,"GAS2"),U,38)=""
 W !,"      CO-MORBID CONDITION #6.......:"
 W !
 Q
HDG1 S $P(^ONCO(165.5,D0,"GAS1"),U,16)=8
 W !,"      ANTIBIOTICS..................: H-pylori not present"
 Q
HDG2 S $P(^ONCO(165.5,D0,"GAS1"),U,17)=8
 W !,"      PROTON PUMP INHIBITORS.......: H-pylori not present"
 Q
HDG3 S $P(^ONCO(165.5,D0,"GAS1"),U,18)=8
 W !,"      H2 BLOCKERS..................: H-pylori not present"
 Q
HDG4 S $P(^ONCO(165.5,D0,"GAS1"),U,19)=8
 W !,"      BISMUTH COMPOUNDS............: H-pylori not present"
 W !
 Q

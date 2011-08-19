ONCLPC1 ;Hines OIFO/GWB - 2001 Lung (NSCLC) Cancers PCE Study ;05/04/01
 ;;2.11;ONCOLOGY;**29**;Mar 07, 1995
 ;Patient Information 
 S DIE="^ONCO(165.5,",DA=ONCONUM,DR=""
 W @IOF D HEAD^ONCLPC0
 W !," PATIENT INFORMATION"
 W !," -------------------"
 S DR(1,165.5,1)="1400.6  1. CO-MORBID CONDITIONS (YES/NO)."
 S DR(1,165.5,2)="I $G(X)=0 D CC1^ONCLPC1,CC2^ONCLPC1,CC3^ONCLPC1,CC4^ONCLPC1,CC5^ONCLPC1,CC6^ONCLPC1 S Y=1401"
 S DR(1,165.5,3)="1400      CO-MORBID CONDITION #1......."
 S DR(1,165.5,4)="I ($G(X)="""")&($P($G(^ONCO(165.5,DA,""LUN1"")),U,76)=1) D ITEM1ED^ONCLPC1 S Y=1400"
 S DR(1,165.5,5)="1400.1      CO-MORBID CONDITION #2......."
 S DR(1,165.5,6)="I $G(X)="""" D CC3^ONCLPC1,CC4^ONCLPC1,CC5^ONCLPC1,CC6^ONCLPC1 S Y=1401"
 S DR(1,165.5,7)="1400.2      CO-MORBID CONDITION #3......."
 S DR(1,165.5,8)="I $G(X)="""" D CC4^ONCLPC1,CC5^ONCLPC1,CC6^ONCLPC1 S Y=1401"
 S DR(1,165.5,9)="1400.3      CO-MORBID CONDITION #4......."
 S DR(1,165.5,10)="I $G(X)="""" D CC5^ONCLPC1,CC6^ONCLPC1 S Y=1401"
 S DR(1,165.5,11)="1400.4      CO-MORBID CONDITION #5......."
 S DR(1,165.5,12)="I $G(X)="""" D CC6^ONCLPC1 S Y=1401"
 S DR(1,165.5,13)="1400.5      CO-MORBID CONDITION #6......."
 S DR(1,165.5,14)="W !"
 S DR(1,165.5,15)="1401  2. DURATION OF TOBACCO USE......."
 S DR(1,165.5,16)="W !"
 S DR(1,165.5,17)="S DEF="""" D ITEM3^ONCLPC1 K DEF"
 S DR(1,165.5,18)="1403  3. PERSONAL HISTORY OF OTHER                                                        INVASIVE MALIGNANCIES PRIOR                                                      TO THIS CANCER DIAGNOSIS....//^S X=PHDEF"
 D ^DIE
 W !
 K DIR S DIR(0)="E" D ^DIR S:$D(DIRUT) OUT="Y"
EXIT K DIC,DR,DA,DIQ,DIE,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 Q
ITEM1ED ;ITEM 1 EDIT
 W !
 W !,"     CO-MORBID CONDITIONS (YES/NO) equals ""Yes"""
 W !,"      CO-MORBID CONDITION #1 may not be blank"
 W !
 Q 
CC1 S $P(^ONCO(165.5,D0,"LUN1"),U,1)=""
 W !,"      CO-MORBID CONDITION #1.......: 000.00 No co-morbidities"
 Q
CC2 S $P(^ONCO(165.5,D0,"LUN1"),U,2)=""
 W !,"      CO-MORBID CONDITION #2.......:"
 Q
CC3 S $P(^ONCO(165.5,D0,"LUN1"),U,3)=""
 W !,"      CO-MORBID CONDITION #3.......:"
 Q
CC4 S $P(^ONCO(165.5,D0,"LUN1"),U,4)=""
 W !,"      CO-MORBID CONDITION #4.......:"
 Q
CC5 S $P(^ONCO(165.5,D0,"LUN1"),U,5)=""
 W !,"      CO-MORBID CONDITION #5.......:"
 Q
CC6 S $P(^ONCO(165.5,D0,"LUN1"),U,6)=""
 W !,"      CO-MORBID CONDITION #6.......:"
 W !
 Q
ITEM3 ;PERSONAL HISTORY OF OTHER INVASIVE MALIGNANCIES PRIOR TO THIS CANCER
 ;DIAGNOSIS and Item 8 of the 2001 Gastric Cancers PCE Study
 ;(165.5,1403) and (165.5,1573)
 ;XECUTABLE 'HELP'
 N PHOM,PATIEN,PRIMIEN,PHOMDTXI,PHOMDTXE,PHOMTOP,PNUM,PHDTDX,PHLAST
 S PATIEN=$P(^ONCO(165.5,D0,0),U,2),PRIMIEN=""
 F  S PRIMIEN=$O(^ONCO(165.5,"C",PATIEN,PRIMIEN)) Q:PRIMIEN'>0  I $P($G(^ONCO(165.5,PRIMIEN,"DIV")),U,1)=DUZ(2) D
 .Q:PRIMIEN=D0
 .S PHODTXI=$$GET1^DIQ(165.5,PRIMIEN,3,"I")
 .S PHODTXE=$$GET1^DIQ(165.5,PRIMIEN,3,"E")
 .S PHOMTOP=$$GET1^DIQ(165.5,PRIMIEN,20.1)
 .Q:(PHODTXI="")!(PHOMTOP="")
 .S PHOM(PHODTXI)=PHODTXE_U_PHOMTOP
 I $D(DEF) D  Q
 .I '$D(PHOM) S PHDEF="C88.8" Q
 .S PHDTDX="",PHLAST=$O(PHOM(PHDTDX),-1),PHDEF=$P(PHOM(PHLAST),U,2) Q
 W !?3,"This item describes the patient's prior history of other invasive"
 W !?3,"malignancies.  If the patient has a history of other malignancies"
 W !?3,"report the ICD-O-3 site code for the most recently diagnosed disease."
 W !?3,"If the patient has no personal history of other cancer, code C88.8. If"
 W !?3,"the patient's personal history of other invasive malignancies is not"
 W !?3,"documented, code C99.9."
 W !
 W !?3,"Allowable Codes: C00.0 thru C80.9 - valid ICD-0-3 site (topography) codes"
 W !?3,"                 C88.8 - no personal history of other cancer"
 W !?3,"                 C99.9 - personal history of other cancer not documented"
 W !
 I '$D(PHOM) W !?3,"This patient has no other primaries." G ITEM3EX
 W !?3,"Other primaries for this patient:",!
 W !?3,"Date DX"
 W !?3,"-----------------"
 S PNUM="" F  S PNUM=$O(PHOM(PNUM)) Q:PNUM'>0  D
 .W !?3,$P(PHOM(PNUM),U,1),?15,$P(PHOM(PNUM),U,2)
ITEM3EX W ! K DIR S DIR(0)="E" D ^DIR S:$D(DIRUT) OUT="Y"
 Q

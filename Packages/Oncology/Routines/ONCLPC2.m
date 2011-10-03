ONCLPC2 ;Hines OIFO/GWB - 2001 Lung (NSCLC) Cancers PCE Study ;05/04/01
 ;;2.11;ONCOLOGY;**29**;Mar 07, 1995
 ;Tumor Identification and Diagnosis 
 K DR S DIE="^ONCO(165.5,",DA=ONCONUM,DR=""
 W @IOF D HEAD^ONCLPC0
 W !," TUMOR IDENTIFICATION AND DIAGNOSIS"
 W !," ----------------------------------"
 S DR(1,165.5,1)="W !,""  4. SYMPTOMS PRESENT AT INITIAL DIAGNOSIS:"""
 S DR(1,165.5,2)="1404      COUGH........................"
 S DR(1,165.5,3)="1404.1      SHORTNESS OF BREATH.........."
 S DR(1,165.5,4)="1404.2      WEIGHT LOSS.................."
 S DR(1,165.5,5)="1404.3      HEMOPTYSIS..................."
 S DR(1,165.5,6)="1404.4      PALPABLE LYMPH NODES........."
 S DR(1,165.5,7)="W !"
 S DR(1,165.5,8)="W !,""  5. SCREENING FOR HIGH RISK/ASYMPTOMATIC PRESENTATION:"""
 S DR(1,165.5,9)="1405      CHEST X-RAY.................."
 S DR(1,165.5,10)="1405.1      CT SCAN......................"
 S DR(1,165.5,11)="1405.2      BRONCHOSCOPY................."
 S DR(1,165.5,12)="W !"
 S DR(1,165.5,13)="W !,""  6. INITIAL DIAGNOSTIC STUDIES (PRE-THERAPY):"""
 S DR(1,165.5,14)="1406      HISTORY AND PHYSICAL........."
 S DR(1,165.5,15)="1406.1      BRONCHOSCOPY................."
 S DR(1,165.5,16)="1406.2      FNAB........................."
 S DR(1,165.5,17)="1406.3      MEDIASTINOSCOPY.............."
 S DR(1,165.5,18)="1406.4      THOROCOTOMY/OPEN BIOPSY......"
 S DR(1,165.5,19)="1406.5      VATS........................."
 D ^DIE
 W !
 K DIR S DIR(0)="E" D ^DIR S:$D(DIRUT) OUT="Y"
EXIT K DIC,DR,DA,DIQ,DIE,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 Q

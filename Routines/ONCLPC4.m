ONCLPC4 ;Hines OIFO/GWB - 2001 Lung (NSCLC) Cancers PCE Study ;05/04/01
 ;;2.11;ONCOLOGY;**29**;Mar 07, 1995
 ;Pathology 
 K DR S DIE="^ONCO(165.5,",DA=ONCONUM,DR=""
 W @IOF D HEAD^ONCLPC0
 W !," PATHOLOGY"
 W !," ---------"
 S DR(1,165.5,1)="1402 11. DATE OF FIRST TISSUE DIAGNOSIS"
 S DR(1,165.5,2)="W !"
 S DR(1,165.5,3)="W !,"" 12. DISTANCE IN MILLIMETERS TO CLOSEST MARGIN:"""
 S DR(1,165.5,4)="1429      PROXIMAL MARGIN.............."
 S DR(1,165.5,5)="1429.1      DISTAL MARGIN................"
 S DR(1,165.5,6)="W !"
 S DR(1,165.5,7)="1417 13. FROZEN SECTION................"
 S DR(1,165.5,8)="W !"
 S DR(1,165.5,9)="W !,"" 14. INVASION:"""
 S DR(1,165.5,10)="1418      VASCULAR....................."
 S DR(1,165.5,11)="1418.1      LYMPHATICS..................."
 S DR(1,165.5,12)="1418.2      PLEURA......................."
 S DR(1,165.5,13)="1418.3      CHEST WALL..................."
 S DR(1,165.5,14)="1418.4      OTHER........................"
 D ^DIE
 W !
 K DIR S DIR(0)="E" D ^DIR S:$D(DIRUT) OUT="Y"
EXIT K DIC,DR,DA,DIQ,DIE,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 Q

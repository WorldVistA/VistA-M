ONCGPC4 ;Hines OIFO/GWB - 2001 Gastric Cancers PCE Study ;03/08/01
 ;;2.11;ONCOLOGY;**29**;Mar 07, 1995
 ;Treatment Complications 
 K DR S DIE="^ONCO(165.5,",DA=ONCONUM,DR=""
 W @IOF D HEAD^ONCGPC0
 W !," TREATMENT COMPLICATIONS"
 W !," -----------------------"
 S DR(1,165.5,1)="1426.5 47. COMPLICATIONS (YES/NO)........"
 S DR(1,165.5,2)="I $G(X)=0 D NOCMP^ONCGPC4 S Y=""@99"""
 S DR(1,165.5,3)="1579      COMPLICATION #1.............."
 S DR(1,165.5,4)="1579.1      COMPLICATION #2.............."
 S DR(1,165.5,5)="1579.2      COMPLICATION #3.............."
 S DR(1,165.5,6)="1579.3      COMPLICATION #4.............."
 S DR(1,165.5,7)="1579.4      COMPLICATION #5.............."
 S DR(1,165.5,8)="@99"
 D ^DIE
 W ! K DIR S DIR(0)="E" D ^DIR S:$D(DIRUT) OUT="Y"
EXIT K DIC,DR,DA,DIQ,DIE,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 Q
NOCMP ;Item 47. COMPLICATIONS
 F PIECE=48:1:52 S $P(^ONCO(165.5,D0,"GAS2"),U,PIECE)=""
 W !,"      COMPLICATION #1..............: 000.00 No complications"
 W !,"      COMPLICATION #2..............:"
 W !,"      COMPLICATION #3..............:"
 W !,"      COMPLICATION #4..............:"
 W !,"      COMPLICATION #5..............:"
 W !
 K PIECE
 Q

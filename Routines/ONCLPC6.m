ONCLPC6 ;Hines OIFO/GWB - 2001 Lung (NSCLC) Cancers PCE Study ;05/09/01
 ;;2.11;ONCOLOGY;**29**;Mar 07, 1995
 ;Treatment Complications 
 K DR S DIE="^ONCO(165.5,",DA=ONCONUM,DR=""
 W @IOF D HEAD^ONCLPC0
 W !," TREATMENT COMPLICATIONS"
 W !," -----------------------"
 S DR(1,165.5,1)="1426.5 29. COMPLICATIONS (YES/NO)........"
 S DR(1,165.5,2)="I $G(X)=0 D TC1^ONCLPC6,TC2^ONCLPC6,TC3^ONCLPC6,TC4^ONCLPC6,TC5^ONCLPC6 S Y=""@99"""
 S DR(1,165.5,3)="1426      COMPLICATION #1.............."
 S DR(1,165.5,4)="I ($G(X)="""")&($P($G(^ONCO(165.5,DA,""LUN2"")),U,40)=1) D ITM29ED^ONCLPC6 S Y=1426"
 S DR(1,165.5,5)="1426.1      COMPLICATION #2.............."
 S DR(1,165.5,6)="I $G(X)="""" D TC3^ONCLPC6,TC4^ONCLPC6,TC5^ONCLPC6 S Y=""@99"""
 S DR(1,165.5,7)="1426.2      COMPLICATION #3.............."
 S DR(1,165.5,8)="I $G(X)="""" D TC4^ONCLPC6,TC5^ONCLPC6 S Y=""@99"""
 S DR(1,165.5,9)="1426.3      COMPLICATION #4.............."
 S DR(1,165.5,10)="I $G(X)="""" D TC5^ONCLPC6 S Y=""@99"""
 S DR(1,165.5,11)="1426.4      COMPLICATION #5.............."
 S DR(1,165.5,12)="@99"
 D ^DIE
 W !
 K DIR S DIR(0)="E" D ^DIR S:$D(DIRUT) OUT="Y"
EXIT K DIC,DR,DA,DIQ,DIE,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 Q
ITM29ED ;ITEM 1 EDIT
 W !
 W !,"     COMPLICATIONS (YES/NO) equals ""Yes"""
 W !,"      COMPLICATION #1 may not be blank"
 W !
 Q 
ITEM29 ;COMPLICATIONS
TC1 S $P(^ONCO(165.5,D0,"LUN2"),U,33)=""
 W !,"      COMPLICATION #1..............: 000.00 No complications"
 Q
TC2 S $P(^ONCO(165.5,D0,"LUN2"),U,34)=""
 W !,"      COMPLICATION #2..............:"
 Q
TC3 S $P(^ONCO(165.5,D0,"LUN2"),U,35)=""
 W !,"      COMPLICATION #3..............:"
 Q
TC4 S $P(^ONCO(165.5,D0,"LUN2"),U,36)=""
 W !,"      COMPLICATION #4..............:"
 Q
TC5 S $P(^ONCO(165.5,D0,"LUN2"),U,37)=""
 W !,"      COMPLICATION #5..............:"
 Q

IBDFC3 ;ALB/CJM - ENCOUNTER FORM - replace original form with converted form ;MAR 3, 1995
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
REPLACE ;replaces the original form with the converted form
 N IBFORM,OLDFORM,IBCNVRT,NODE,OLDNAME,NEWNAME
 S VALMBCK="R"
 ;D FULL^VALM1
 W !,"The original form will be replaced with the converted form in all of the",!,"clinics and divisions where it is used."
 K DIR S DIR(0)="Y",DIR("B")="YES",DIR("A")="Is that okay"
 D ^DIR K DIR
 I (Y=1)&'$D(DIRUT) D
 .X IBAPI("SELECT")
 .Q:'IBFORM
 .Q:'IBCNVRT
 .S NODE=$G(^IBD(359,IBCNVRT,0))
 .S OLDFORM=$P(NODE,"^",2),OLDNAME=$P(NODE,"^",3)
 .Q:'OLDFORM
 .D LOOP
 .S $P(^IBD(359,IBCNVRT,0),"^",5)=1
 .;
 .;delete the original?
 .W !,"The converted form has been substituted everywhere for the original"
 .S DIR(0)="Y",DIR("B")="YES",DIR("A")="Do you want the original form deleted"
 .D ^DIR K DIR
 .I (Y=1)&'$D(DIRUT) D
 ..D DELETE^IBDFU2C(OLDFORM,357)
 ..;rename the converted form to take out the CNV. prefix
 ..S NAME=$P($G(^IBE(357,IBFORM,0)),"^") I $E(NAME,1,4)="CNV." S NAME=$E(NAME,5,45) S:(NAME=$E(OLDNAME,1,$L(NAME))) NAME=OLDNAME D
 ...K DIE,DA,DR S DIE="^IBE(357,",DA=IBFORM,DR=".01////"_NAME D ^DIE K DIE,DA,DR
 .;
 .D IDXFORMS^IBDFC1
 K Y
 Q
 ;
LOOP ;loops through the clinic setups and divisions setups, making the substitutions
 N SETUP,NODE,PIECE,FOUND
 S SETUP=0 F  S SETUP=$O(^SD(409.95,SETUP)) Q:'SETUP  D
 .S NODE=$G(^SD(409.95,SETUP,0))
 .K DR S DR=""
 .S FOUND=0
 .F PIECE=2:1:12 I $P(NODE,"^",PIECE)=OLDFORM S DR=DR_(.01*PIECE)_"////"_IBFORM_";",FOUND=1
 .I FOUND K DIE,DA S DIE="^SD(409.95,",DA=SETUP D ^DIE
 .K DIE,DR,DA
 Q

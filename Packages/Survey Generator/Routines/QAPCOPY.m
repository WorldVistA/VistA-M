QAPCOPY ;557/THM-COPY A SURVEY [ 06/20/96  10:02 AM ]
 ;;2.0;Survey Generator;**5**;Jun 20, 1995
 ;
 D SCREEN^QAPUTIL
EN W @IOF,! S QAPHDR="Copy a Survey" X QAPBAR W !,BLDON,"Type RETURN or ^ to exit",BLDOFF,!!
 S QAPCOPY=1,DIC("S")="I $P(^(0),U,5)=DUZ!($D(^XUSEC(""QAP MANAGER"",DUZ)))!($D(^QA(748,""AB"",DUZ,+Y)))" ;only authors or editors
 S DIC="^QA(748,",DIC(0)="AEQMZ",DIC("A")="Select survey to copy: " D ^DIC G:X=""!(X[U) EXIT S OSRVDA=+Y,OSRVNAM=$P(Y(0),U)
 S DA=OSRVDA D ^QAPCHKST G:$D(STOP) EXIT K DA
 I $D(NOPEN)!($D(CANCEL)) W !!,*7,"The survey COPY may need editing before it can be used.",! H 2 K NOPEN,CANCEL
 ;
NEWN W !!,"Enter NEW survey name: " R NWNAM:DTIME G:NWNAM=""!(NWNAM[U)!('$T) EXIT
 S NWNAM=$TR(NWNAM,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 I NWNAM["?" W !!,"Enter the new name for this survey copy." G NEWN
 I NWNAM'?1.65AE W !!,*7,"The new name must be from 1-65 alpha characters." G NEWN
 X CLEOP W "Survey to copy: ",OSRVNAM,!?6,"New name: ",NWNAM,!!
 W !! K DIR S DIR("A")="Is everything Ok",DIR("B")="NO",DIR(0)="Y" D ^DIR G:$D(DIRUT) EXIT G:Y'=1 EN
 S OSRVQDA=$O(^QA(748.25,"B",OSRVDA,0))
 I OSRVQDA="" W !!,*7,"Survey questions not found for "_OSRVNAM_"!",!! H 2 G EXIT
 ;create the new survey record
 K X,%X,%Y,%Z,DIC
 S DIC(0)="EQM",(DIC,DIE)="^QA(748,",X=NWNAM,DIC("DR")=".055////"_DUZ
 K DO,DD D FILE^DICN S NSRVDA=+Y
 I NSRVDA<0 W !!,"New survey creation error !",! D DEL G EXIT
 ;create the new question record
 K DINUM,X K DIC
 S DIC(0)="EQM",(DIC,DIE)="^QA(748.25,",(DINUM,X)=NSRVDA K DO,DD D FILE^DICN
 W !!,"Copying ",OSRVNAM," . . .  " H 1
 S %X="^QA(748,OSRVDA,",%Y="^QA(748,NSRVDA," D %XY^%RCR
 I $D(^QA(748,NSRVDA))<10 W !!,*7,"An error occurred while copying the main survey data",!,"from "_OSRVNAM W *7 D DEL G EXIT ;possible zero node, nothing else
 W !!,"Copying the questions . . .  " H 1
 S %X="^QA(748.25,OSRVDA,",%Y="^QA(748.25,NSRVDA," D %XY^%RCR
 I $D(^QA(748.25,NSRVDA))<10 W !!,*7,"An error occurred while copying the questions",!,"from "_OSRVNAM W *7 D DEL G EXIT ;possible zero node, nothing else
 K DIC,DA S DA=NSRVDA,DIC(0)="EQM",(DIC,DIE)="^QA(748,",DR=".01///"_NWNAM_";.05////d;.055////"_DUZ D ^DIE ;reset name of copy, status, make copier the developer
 S $P(^QA(748.25,NSRVDA,0),U,1)=NSRVDA S DIK="^QA(748.25,",DA=NSRVDA D IX^DIK
 S DIK="^QA(748,",DA=NSRVDA D IX^DIK K DA,DIK
 W !!,"Finished.",! H 1
 W !!,"Press RETURN to continue    " R ANS:DTIME
 ;
EXIT K QAPCOPY G EXIT^QAPUTIL
 ;
DEL S DIK="^QA(748," S DA=NSRVDA D ^DIK
 S DIK="^QA(748.25," S DA=NSRVDA D ^DIK
 W !!,"The partial records have been deleted.  " H 2
 K DIK Q

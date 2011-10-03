QAMDUP0 ;HISC/DAD-COPY OLD MONITOR TO NEW ONE ;2/10/92  07:33
 ;;1.0;Clinical Monitoring System;;09/13/1993
EN1 K DIC,DIDEL,DINUM,DLAYGO S DIC="^QA(743,",DIC(0)="AEMNQZ",DIC("A")="Select MONITOR TO COPY: " W ! D ^DIC K DIC G:Y'>0 EXIT
 S QAMD0=+Y,QAMCODE=$E("Copy of "_$P(Y(0),"^"),1,30),QAMTITLE=$E("Copy of "_$P(Y(0),"^",2),1,30)
 S QAMS0=$O(^QA(743,"B",QAMCODE,0)) I QAMS0 W !!?5,"*** A `",QAMCODE,"' already exists! ***",*7 S QAMD0=QAMS0 G EDIT
ASK W !!,"Are you sure you want to copy this monitor" S %=2 D YN^DICN G EN1:%=2,EXIT:%=-1
 I '% W !!?5,"Answering Y(es) produces a duplicate copy of the selected monitor",!?5,"which you may then edit.  Answering N(o) takes you back to the",!?5,"previous prompt." G ASK
 W !!,"Copying monitor, please wait..."
 S QAMZERO=^QA(743,0),QAMS0=$P(QAMZERO,"^",3)+1 F QAMS0=QAMS0:1 L +^QA(743,QAMS0,0):0 Q:$T&('$D(^QA(743,QAMS0,0)))  L -^QA(743,QAMS0,0):0
 S $P(^QA(743,0),"^",3,4)=QAMS0_"^"_($P(QAMZERO,"^",4)+1)
 S %X="^QA(743,"_QAMD0_",",%Y="^QA(743,"_QAMS0_"," L -^QA(743,QAMS0,0):0 D %XY^%RCR S DIK="^QA(743,",DA=QAMS0 D IX^DIK S QAMD0=QAMS0
EDIT K DR S DIE="^QA(743,",DR=".01///"_QAMCODE_";.02///"_QAMTITLE_";7///UNDER CONSTRUCTION;54///OFF",DA=QAMD0 D ^DIE S QAMFIN=0
 W !!,"You may now edit the copy of the monitor, please change the CODE and TITLE.",! D EN2^QAMEDT0 G EN1
EXIT ;
 K %,%DT,%X,%Y,D0,D1,DA,DI,DIC,DIE,DIK,DQ,DR,J,QA,QAM,QAMAUTO,QAMCODE,QAMD0,QAMD1,QAMDFLT,QAMFIN,QAMPCODE,QAMS0,QAMTITLE,QAMZERO,X,Y
 Q

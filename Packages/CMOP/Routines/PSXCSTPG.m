PSXCSTPG ;BIR/JMB-Purges Cost Data/One Day Compile/Recompile Cost Data ;[ 04/08/97   2:06 PM ]
 ;;2.0;CMOP;;11 Apr 97
 I '$D(^XUSEC("PSXCOST",DUZ)) W !,"You are not authorized to use this option!" Q
 ;If no data in file, print error msg.
 S PSXBDT=$O(^PSX(552.5,"AD",0)) I '$D(PSXBDT) W !!,"There is no data in the cost file." K PSXBDT Q
 ;Determine 3 month back.
 S X1=DT,X2=-(93+$E(DT,6,7)) D C^%DTC S PSXDT90=$E(X,1,5)_"00"
 ;If beginning date is not 3 months ago, display error msg.
 I PSXBDT'<PSXDT90 S Y=PSXBDT D DD^%DT W !!,"The cost file contains data beginning with ",Y,".",!!,"Data for three complete months must remain",!,"in the cost file. No data can be purged.",! Q
 S Y=PSXBDT D DD^%DT S PSXBDTR=Y,Y=PSXDT90 D DD^%DT S PSXDT90R=Y
PDT ;Get & validate purge date range
 W !!,"Data for three complete months must remain in the cost file.",!?10,PSXBDTR_" through "_PSXDT90R_" can be purged.",!
 S %DT="EPA",%DT(0)=PSXBDT,%DT("A")="Purge data from "_PSXBDTR_" through: " D ^%DT G:"^"[X END^PSXCSUTL G:Y<0 PDT
 I PSXDT90<Y!($E(Y,1,5)>$E(PSXDT90,1,5)) W "  Invalid month." G PDT
 S PSXEDT=Y D DD^%DT W !!,"Purge from "_PSXBDTR_" to "_Y,!
 I PSXEDT'=PSXDT90,$E(PSXEDT,6,7)="00" S PSXEDT=$E(PSXEDT,1,5)_$P("31^29^31^30^31^30^31^31^30^31^30^31","^",$E(PSXEDT,4,5))
 S DIR("A")="Are you sure",DIR(0)="Y",DIR("B")="N" D ^DIR K DIR I $G(DIRUT)!('Y) W !!,"No data has been purged." G END^PSXCSUTL
 ;Looks for active task working on this date range's data.
 S PSXCOM=0 D CHECK^PSXCSLOG G:$G(PSXERR) PDT
 ;Queue job
 S PSXSTART=9999999.999999-$E($$HTFM^XLFDT($H),1,14),PSXJOB="P"
 W ! S ZTDTH="",ZTRTN="P^PSXCSTPG",ZTDESC="CMOP Cost Data Purge",ZTIO="" F PSXG="PSXBDT","PSXEDT","PSXSTART" S:$D(@PSXG) ZTSAVE(PSXG)=""
 D ^%ZTLOAD W:$D(ZTSK) !!,"Task Queued!",!
 S PSXEDT=$E(PSXEDT,1,5)_"00" D QUE^PSXCSLG1 S:$D(ZTQUEUED) ZTREQ="@"
 G END^PSXCSUTL
P ;Queued entry point
 D RUN^PSXCSLG1 ;Updates cost task log
 ;Loops thru date range & deletes drug data nodes
 F DA=(PSXBDT-1):0 S DA=$O(^PSX(552.5,"AD",DA)) Q:'DA!(DA>PSXEDT)  D
 .F DA(2)=0:0 S DA(2)=$O(^PSX(552.5,"AD",DA,DA(2))) Q:'+DA(2)  F DA(1)=0:0 S DA(1)=$O(^PSX(552.5,"AD",DA,DA(2),DA(1))) Q:'+DA(1)  S DIK="^PSX(552.5,"_DA(2)_",1,"_DA(1)_",1," D ^DIK
P2 ;Deletes sub-file nodes if no drug data nodes
 K DA F DA(1)=0:0 S DA(1)=$O(^PSX(552.5,"B",DA(1))) Q:'DA(1)  D
 .S PSXDIV="" F  S PSXDIV=$O(^PSX(552.5,DA(1),1,"B",PSXDIV)) Q:PSXDIV=""  D
 ..F DA=0:0 S DA=$O(^PSX(552.5,DA(1),1,"B",PSXDIV,DA)) Q:'DA  D
 ...I '$O(^PSX(552.5,DA(1),1,DA,1,0)) S DIK="^PSX(552.5,"_DA(1)_",1," D ^DIK K DIK
 K DA F DA=0:0 S DA=$O(^PSX(552.5,"B",DA)) Q:'DA  I '$O(^PSX(552.5,DA,1,0)) S DIK="^PSX(552.5," D ^DIK K DIK
 D END^PSXCSLG1 ;Updates cost task log
 G END^PSXCSUTL
DAY ;Entry point for One Day Compile/Recompile Cost Data
 I '$D(^XUSEC("PSXCOST",DUZ)) W !,"You are not authorized to use this option!" Q
 W ! S %DT(0)=-DT,%DT("A")="Date: " S %DT="EPXA" D ^%DT G:"^"[X END^PSXCSUTL G DAY:'Y S (PSXBDT,PSXEDT)=Y K %DT(0) S PSXCOM=1
 S PSXFND=$O(^PSX(552.4,"AD",PSXBDT-1)) I PSXFND>PSXEDT!(+PSXFND=0) S Y=PSXBDT X ^DD("DD") S PSXSDATE=Y W !!?5,"There is no prescription data for "_PSXSDATE_".",! G END^PSXCSUTL
 W ! S DIR("A")="Are you sure",DIR(0)="Y",DIR("B")="N" D ^DIR K DIR I $G(DIRUT)!('Y) W !!,"No data has been compiled/recompiled." G DAY
 W ! D QUE^PSXCST,END^PSXCSUTL
 Q

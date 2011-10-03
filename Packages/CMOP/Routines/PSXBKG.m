PSXBKG ;BIR/WPB-Routine to schedule background jobs [ 05/01/97  12:56 PM ]
 ;;2.0;CMOP;**1**;11 Apr 97
DREL W !!
 I $D(^PSX(554,"AS")) D  Q
 .S DIR(0)="Y",DIR("B")="NO",DIR("A",1)="This job is already scheduled.",DIR("A")="Do you want to unschedule this job" D ^DIR K DIR G:(Y<1)!($D(DIRUT)) EXIT G:Y=1 UNSCH
 S %DT="AEXR",%DT("A")="Enter starting date/time: ",%DT("B")="TODAY@2330" D ^%DT G:Y<0!($D(DTOUT)) EXIT S PSXDATE=Y K %DT,%DT("A"),%DT("B"),Y,X
 K Y,X,DTOUT,DUOUT,DIRUT,DIROUT,DIR,DIR("A"),DIR("?"),DIR(0)
 S DIR(0)="N",DIR("B")="10",DIR("A")="Enter number of days of data to keep",DIR("?")="This is the number of days of data to keep on file." D ^DIR K DIR S KEEP=Y G:$D(DIRUT)!($D(DUOUT))!($D(DTOUT))!($D(DIROUT)) EXIT
 K Y,X,DTOUT,DUOUT,DIRUT,DIROUT,DIR,DIR("A"),DIR("?"),DIR(0)
 S ZTIO="",ZTDTH=PSXDATE,ZTDESC="CMOP Background Purge for Release Data",ZTRTN="RDPRG^PSXBKG" D ^%ZTLOAD
 I $G(ZTSK)>0 W !,"Job Queued.",! D
 .K DD,DO
 .S:'$D(^PSX(554,1,1,0)) ^PSX(554,1,1,0)="^554.01SA^^"
 .S DIC(0)="LZ",DA(1)=1,DIC="^PSX(554,"_DA(1)_",1,",X=4,DIC("DR")="1////"_PSXDATE_";2////"_ZTSK_";3////S;4////"_DUZ_";7////"_KEEP D FILE^DICN K DIC,DIC(0),DIC("DR"),Y,X
 S ZTREQ="@"
EXIT K Y,%DT("A"),%DT("B"),N,PSXDATE,STDATE,TIME,DIR,DIRUT,DIROUT,DTOUT,DUOUT,KEEP,REC,ZTIO,ZTDESC,ZTDTH,ZTRTN
 Q
UNSCH N ZTSK
 S REC=$O(^PSX(554,"AS",""))
 S ZTSK=$P(^PSX(554,1,1,REC,0),"^",3)
 I $G(ZTSK)'>0 W !,"This job doesn't exist.",! Q
 D STAT^%ZTLOAD
 I ZTSK(1)=2 W !,"This task is currently running, wait until the task has finished before stopping the job.",! Q
 I ZTSK(1)'=2 D KILL^%ZTLOAD
 I ZTSK(0)=1 W !,"Job stopped.",! D
 .D NOW^%DTC
 .S DA=REC,DA(1)=1,DIE="^PSX(554,"_DA(1)_",1,",DR="2////@;3////S;5////"_%_";6////"_DUZ D ^DIE K DA,DIE,DR
 K Y,ZTSK
 G EXIT
 ;Called by Taskman to schedule background purge of Release Data
RDPRG Q:'$D(^PSX(554,"AS"))
 S RC=$O(^PSX(554,"AS",""))
 D NOW^%DTC
 S ZTSK=$P(^PSX(554,1,1,RC,0),"^",3),TIME="24H",ZTIO="",ZTDESC="CMOP Background Purge for Release Data",ZTRTN="RDPRG^PSXBKG",ZTDTH=TIME D REQ^%ZTLOAD
 Q:$P(^PSX(554,1,1,RC,0),"^",4)="R"
 S $P(^PSX(554,1,1,RC,0),"^",4)="R",$P(^PSX(554,1,1,RC,0),"^",9)=% K %
 S RC=$O(^PSX(554,"AS","")),KEEP=$P(^PSX(554,1,1,RC,0),"^",8) S:$G(KEEP)'>0 KEEP=14
 D NOW^%DTC S END=$$FMADD^XLFDT(%,-KEEP,0,0,0) K %
 S MDT=0 F  S MDT=$O(^PSX(554,1,3,"B",MDT)) Q:MDT'>0  S REC=0 F  S REC=$O(^PSX(554,1,3,"B",MDT,REC)) Q:REC'>0  D
 .Q:$P(^PSX(554,1,3,REC,0),"^",7)=""
 .Q:$P(^PSX(554,1,3,REC,0),"^")>$G(END)
 .S DA(1)=1,DA=REC,DIK="^PSX(554,"_DA(1)_",3," D ^DIK K DA,DIK
 S $P(^PSX(554,1,1,RC,0),"^",4)="S"
 K RC,END,MDT,REC,KEEP,PSXTSK,ZTRTN,ZTDESC,ZTIO,ZTDTH
 Q

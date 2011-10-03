PSXPURG ;BIR/WPB-Purges Files at Host and Remote Facilities ;12 Dec 2001
 ;;2.0;CMOP;**28,41**;11 Apr 97
EN ;
 Q:'$G(PSXSYST)
PURG ;Purge CMOP System file purge multiple of all but last ten days entries
 ; now called by PSXBLD
 S LAST=$$FMADD^XLFDT(DT,-10,0,0,0)
 S PSXPURG=0 F PSXCNT=1:1 S PSXPURG=$O(^PSX(550,+PSXSYST,"P",PSXPURG)) Q:'PSXPURG  I $P($P(^PSX(550,+PSXSYST,"P",PSXPURG,0),"^"),".")<LAST S DA=PSXPURG,DA(1)=+PSXSYST,DIK="^PSX(550,"_DA(1)_",""P""," D  K DA
 . N I F I=1:1:4 L +^PSX(550,DA(1),"P",DA):600 Q:$T  I I=4 S PSXFILE="CMOP SYSTEM" D RALRT^PSXUTL
 . D ^DIK
 . L -^PSX(550,DA(1),"P",DA)
 K PSXCNT,PSXPURG,DA,DIK
 D NOW^%DTC S BTM=%,QUECNT=0
 Q
LOGACK ; called from acknowledgement process
 S:'$D(^PSX(550,+PSXSYST,"P",0)) ^PSX(550,+PSXSYST,"P",0)="^550.08DA^^"
 L +^PSX(550,+PSXSYST):600
LOG S DA=+PSXSYST,DIE="^PSX(550,",DR="6////"_PSXBAT D ^DIE
 L -^PSX(550,+PSXSYST) K DIE,DA,DR,DO,DD
 D NOW^%DTC S BTM=%,QUECNT=EMSG-BMSG+1
 S DA(1)=+PSXSYST,X=BTM,DIC(0)="Z",DIC="^PSX(550,"_+PSXSYST_",""P"","
 S DIC("DR")="1////"_QUECNT_";3////"_BMSG_";4////"_EMSG
 D FILE^DICN G:$P($G(Y),U,3)'=1 LOG
 K DIC,DA,QUECNT,BMSG,EMSG,PSXSYST,REC,BTM,XXX,Y,X,DTOUT,DUOUT
 S XMSER=PSXSER,XMZ=PSXXMZ D REMSBMSG^XMA1C
 Q
REPT S DIC(0)="AEQMZ",DIC("A")="Enter CMOP System:  ",DIC=550 D ^DIC K DIC  G:Y<0!($D(DTOUT))!($D(DUOUT)) EX S SYS=+Y,SYSTEM=$P($G(Y),U,2)
 F XX=0:0 S XX=$O(^PSX(550,SYS,"P",XX)) Q:XX'>0  S LAST=XX
 W @IOF,!!
 W ?24,"Purge Status of CMOP Rx Queue"
 I '$D(LAST) W !!,SYSTEM_" does not have any purge data to report." G EX
 S DTTM=$$FMTE^XLFDT($P($G(^PSX(550,SYS,"P",LAST,0)),U,1),1)
 W !!,"Date/Time of Last Purge:  ",$P($G(DTTM),":",1,2)
 W !,"Starting Message Number:  ",$P($G(^PSX(550,SYS,"P",LAST,0)),U,4)
 W !,"Ending Message Number  :  ",$P($G(^PSX(550,SYS,"P",LAST,0)),U,5)
 W !,"Total Orders Purged    :  ",$P($G(^PSX(550,SYS,"P",LAST,0)),U,2)
EX K SYS,SYSTEM,DTTM,LAST,XX,Y,X,DIC,DTOUT,DUOUT
 Q
EXIT K XX,LAST,DTTM,NN,P514,PSXBAT,PSXPURG,PSXER,PSXXMZ,RX1,SYS,SYSTEM,XMSER,XMZ,XX1,YY,Z,ZZ,XXX,NN,MM,%,PSXSER
 Q
QUE W !!
 I $D(^PSX(554,"AD")) D  Q
 .S DIR(0)="Y",DIR("B")="NO",DIR("A",1)="This job is already scheduled.",DIR("A")="Do you want to unschedule this job" D ^DIR K DIR G:(Y<1)!($D(DIRUT)) EXIT1 G:Y=1 UNSCH
 S %DT="AEXR",%DT("B")="NOW",%DT("A")="Enter the date and time to start purge:  " D ^%DT K %DT G:Y<0!($D(DTOUT)) EXIT1 S (PSXDATE,STDATE)=Y
 S ZTDTH=PSXDATE,ZTDESC="CMOP Background Purge for CMOP Database file",ZTIO="",ZTRTN="ENHOST^PSXPURG",ZTSAVE("DUZ")="" D ^%ZTLOAD
 I $G(ZTSK)>0 W !,"Job Queued." D
 .K DD,DO
 .S:'$D(^PSX(554,1,1,0)) ^PSX(554,1,1,0)="^554.01SA^^"
 .S DIC(0)="Z",DA(1)=1,X=3,DIC="^PSX(554,"_DA(1)_",1,",DIC("DR")="1////"_PSXDATE_";2////"_ZTSK_";3////S;4////"_DUZ D FILE^DICN K DIC,DIC(0),DIC("DR"),Y,X
 K STDATE,Y,TIME,X,N,PSXDATE,ZTDTH,ZTDESC,ZTRTN,ZTIO,ZTSAVE("DUZ")
 Q
ENHOST ;Called by Taskman to purge and close the files at the host site, job tasked every 24 hours
 S PSXZTSK=ZTSK,ZTREQ="@"
 D NEXT
 Q:'$D(^PSX(552.1,"APRG"))
 F I=0:0 S I=$O(^PSX(552.1,"APRG",I)) Q:'I  D
 .Q:'$D(^PSX(552.1,I))  Q:"346"'[+$P($G(^PSX(552.1,I,0)),"^",2)
 .S BAT=$P($G(^PSX(552.1,I,0)),"^"),BEG=$P($G(^PSX(552.1,I,1)),"^",1),END=$P($G(^PSX(552.1,I,1)),"^",2)
 .Q:$D(^PSX(552.2,"AQ",BAT))!($G(BEG)'>0)!($G(END)'>0)
 .K ^PSX(552.1,I,"S")
 .S DIK="^PSX(552.2,"
 .F J=BEG:1:END S MSG=BAT_"-"_J,REC=$O(^PSX(552.2,"B",MSG,"")) Q:$G(REC)=""  D
 ..Q:($G(^PSX(552.2,REC,0))="")!("2/3/5/99"'[+$P($G(^PSX(552.2,REC,0)),"^",2))
 ..S DA=REC D ^DIK K REC,MSG,DA
 .I $D(^PSX(552.1,I,0)) S DIE=552.1,DA=I,DR="19////2" L +^PSX(552.1,DA):600 D ^DIE L -^PSX(552.1,DA)
 .K BEG,END,BAT,MSG,J,DIE,DA,DR
 K I,DIK,DIE,DA,DR,PSXZTSK
 D ^PSXPURG1
 Q
NEXT S FREQ="24H",ZTSK=PSXZTSK,ZTRTN="ENHOST^PSXPURG",ZTIO="",ZTDESC="CMOP Background Purge for CMOP Database file",ZTDTH=FREQ D REQ^%ZTLOAD
 D NOW^%DTC
 S RE=$O(^PSX(554,"AD","")) S:$G(RE)>0 $P(^PSX(554,1,1,RE,0),"^",9)=%
EXIT1 K ZTDESC,ZTRTN,ZTSK,ZTIO,ZTDTH,FREQ,ZTSAVE("DUZ"),ZTREQ,PSXZTSK,DTOUT,DIRUT,DIROUT,DUOUT,DIR,%,RE
 Q
UNSCH ;kills the background purge of the database file (552.1)
 N ZTSK
 S REC=$O(^PSX(554,"AD",""))
 S ZTSK=$P(^PSX(554,1,1,REC,0),"^",3)
 I $G(ZTSK)'>0 W !,"This job doesn't exist.",! Q
 D STAT^%ZTLOAD
 I ZTSK(1)=2 W !,"This task is currently running, wait until the task has finished before stopping the job.",! Q
 I ZTSK(1)'=2 D KILL^%ZTLOAD
 I ZTSK(0)=1 W !,"Job stopped.",! D
 .D NOW^%DTC
 .S DA=REC,DA(1)=1,DIE="^PSX(554,"_DA(1)_",1,",DR="2////@;3////S;5////"_%_";6////"_DUZ L +^PSX(554,DA(1),1,DA):600 D ^DIE L -^PSX(554,DA(1),1,DA) K DA,DIE,DR
 K Y,ZTSK,REC
 Q

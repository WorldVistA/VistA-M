PSXBKD ;BIR/WPB,PWC-Routine to Control Host Background Jobs ;08 Apr 98  4:22 AM
 ;;2.0;CMOP;**38,44**;11 Apr 97
DELREL W !!
 I $D(^PSX(554,"AR")) S DIR(0)="Y",DIR("B")="NO",DIR("A",1)="This job is already scheduled.",DIR("A")="Do you want to unschedule this job" D ^DIR K DIR G:(Y<1)!($D(DIRUT)) EXIT G:Y=1 UNSCH
 S %DT="AEXR",%DT("A")="Enter starting date/time: ",%DT("B")="TODAY@2300" D ^%DT G:Y<0!($D(DTOUT)) EXIT S PSXDATE=Y K %DT,%DT("A"),%DT("B"),Y,X
 S ZTIO="",ZTDTH=PSXDATE,ZTDESC="CMOP Background Purge for CMOP Release File",ZTRTN="DEL513A^PSXBKD" D ^%ZTLOAD
 I $G(ZTSK)>0 W !,"Job Started.",! D
 .K DD,DO
 .S:'$D(^PSX(554,1,1,0)) ^PSX(554,1,1,0)="^554.01SA^^"
 .S DIC(0)="Z",DA(1)=1,DIC="^PSX(554,"_DA(1)_",1,",X=2,DIC("DR")="1////"_PSXDATE_";2////"_ZTSK_";3////S;4////"_DUZ D FILE^DICN K DIC,DIC(0),DIC("DR"),Y,X
 S ZTREQ="@"
EXIT K Y,%DT("A"),%DT("B"),N,PSXDATE,STDATE,TIME,DIR,DIRUT,DIROUT,DTOUT,DUOUT
 Q
 ;Called by Taskman to update 554 and purge 552.3
DEL513A S PSXTSK1=ZTSK D RESCH
D513AA S REC=$O(^PSX(554,"AR","")) L +^PSX(554,1,1,REC):600 G:'$T D513AA
 S DA=REC,DA(1)=1,DIE="^PSX(554,"_DA(1)_",1,",DR="3////R" D ^DIE
 L -^PSX(554,1,1,REC) K DIE,DA,DR
 S DEL=0 F  S DEL=$O(^PSX(552.3,"AF",DEL)) Q:DEL'>0  S DA=DEL,DIK="^PSX(552.3," D ^DIK K DIK,DA
D513AB S REC=$O(^PSX(554,"AR","")) L +^PSX(554,1,1,REC):600 G:'$T D513AB
 S DA=REC,DA(1)=1,DIE="^PSX(554,"_DA(1)_",1,",DR="3////S" D ^DIE
 L -^PSX(554,1,1,REC) K DIE,DA,DR
 K DEL,ZTIO,ZTDESC,ZTRTN,ZTSK,ZTDTH,REC
 Q
RESCH S ZTSK=PSXTSK1,TIME="24H",ZTIO="",ZTDESC="CMOP Background Purge for CMOP Release File",ZTRTN="DEL513A^PSXBKD",ZTDTH=TIME D REQ^%ZTLOAD
 D NOW^%DTC
 S RE=$O(^PSX(554,"AR","")) S:$G(RE)>0 $P(^PSX(554,1,1,RE,0),"^",9)=%
 K PSXTSK1,%,RE
 Q
UNSCH N ZTSK
 S REC=$O(^PSX(554,"AR",""))
 S ZTSK=$P(^PSX(554,1,1,REC,0),"^",3)
 I $G(ZTSK)'>0 W !,"This job doesn't exist.",! Q
 D STAT^%ZTLOAD
 I ZTSK(1)=2 W !,"This task is currently running, wait until the task has finished before stopping the job.",! Q
 I ZTSK(1)'=2 D KILL^%ZTLOAD
UNSCH1 I ZTSK(0)=1 W !,"Job stopped.",! L +^PSX(554,1,1,REC):600 G:'$T UNSCH1 D
 .D NOW^%DTC S DA=REC,DA(1)=1
 .S DIE="^PSX(554,"_DA(1)_",1,",DR="2////@;3////S;5////"_%_";6////"_DUZ
 .D ^DIE K DA,DIE,DR
 L -^PSX(554,1,1,REC) K Y,ZTSK
 Q
STOPJOB N ZTSK
 S REC=$O(^PSX(554,"AB",""))
 S ZTSK=$P(^PSX(554,1,1,REC,0),"^",3)
 I $G(ZTSK)'>0 W !,"This job doesn't exist.",! Q
 D STAT^%ZTLOAD
 I ZTSK(1)=2 W !,"This task is currently running, wait until the task has finished before stopping the job.",! Q
 I ZTSK(1)'=2 D KILL^%ZTLOAD
STOP1 I ZTSK(0)=1 W !,"Job stopped.",! L +^PSX(554,REC):600 G:'$T STOP1 D
 .D NOW^%DTC S DA=REC,DA(1)=1,DIE="^PSX(554,"_DA(1)_",1,"
 .S DR="2////@;3////S;5////"_%_";6////"_DUZ D ^DIE
 .L -^PSX(554,REC) K DA,DIE,DR,REC
 Q
STATUS N PSXSTAT,PSXTXT
 S PSXSTAT=$G(^PSX(553,1,"S"))
 Q:PSXSTAT=""
 S PSXTXT="CMOP Interface is "_$S(PSXSTAT="R":"RUNNING!!!",1:"Stopped.")
 W !!,?((IOM\2)-($L(PSXTXT)\2)-3),PSXTXT
 N PSX1,PSX2 S (CNT,BCNT,OCNT,TRX,QFLG,TTRX)=0
 G:'$O(^PSX(553.1,0)) ST1
 S QRY=$P(^PSX(553.1,0),"^",3) G:$G(QRY)'>0 ST1
 S STAT=$P(^PSX(553.1,QRY,0),"^",5) D
 .I $G(STAT)'=1&($G(STAT)'=5) S QRY=QRY-1 S TRX=$P(^PSX(553.1,QRY,0),"^",6),QTM=$$FMTE^XLFDT($P($G(^PSX(553.1,QRY,0)),"^",4),1) S:$G(TRX)="" TRX=0 Q
 .I $G(STAT)=5 S QFLG=1,TTRX=$P(^PSX(553.1,QRY,0),"^",6) S:$G(TRX)="" TTRX=0 S TRX=$P(^PSX(553.1,QRY-1,0),"^",6) S:$G(TRX)="" TRX=0 S QTM=$$FMTE^XLFDT($P($G(^PSX(553.1,QRY-1,0)),"^",4),1) Q
 .I $G(STAT)=1 S TRX=$P(^PSX(553.1,QRY,0),"^",6),QTM=$$FMTE^XLFDT($P($G(^PSX(553.1,QRY,0)),"^",4),1) S:$G(TRX)="" TRX=0
ST1 I $P($G(^PSX(552.1,0)),"^",3)'>0 S NDATA=1 G EX
 S PSX1=$G(^PSX(553,1,99)) Q:PSX1=""  S ST=$P(PSX1,"-",1),ST2=$O(^PSX(552.1,"B",$P(PSX1,"-",1,2),""))
 ;S X=ST S:$D(^PSX(552,"D",X)) X=$E(X,2,99) S DIC="4",DIC(0)="MOZX" D ^DIC S ST1=+Y I $G(ST1)="" W !,"Remote site is not in the Institution file." Q  ;****DOD L1
 S X=ST,AGNCY="VASTANUM" S:$D(^PSX(552,"D",X)) X=$E(X,2,99),AGNCY="DMIS" S ST1=$$IEN^XUMF(4,AGNCY,X) I $G(ST1)="" W !,"Remote site is not in the Institution file." Q  ;****DOD L1
 S SITE=$P(Y,"^",2),IEN512=$O(^PSX(552.2,"B",PSX1,"")) K DIC,Y,X
 S:$G(IEN512)'="" ACKTM=$$HTE^XLFDT($P($G(^PSX(552.2,$G(IEN512),0)),"^",4),1)
 S:$G(IEN512)="" ACKTM=$$FMTE^XLFDT($P(^PSX(552.1,ST2,0),"^",6),1)
 I '$D(^PSX(552.1,"AQ")) S CNT=0
 I $D(^PSX(552.1,"AQ")) S XXX="" F  S XXX=$O(^PSX(552.1,"AQ",XXX)) Q:'XXX  S BCNT=BCNT+1,YYY="" F  S YYY=$O(^PSX(552.1,"AQ",XXX,YYY)) Q:'YYY  S ZZZ=0 F  S ZZZ=$O(^PSX(552.1,"AQ",XXX,YYY,ZZZ)) Q:ZZZ'>0  D
 .S CNT=$P($G(^PSX(552.1,ZZZ,1)),"^",4)+CNT,OCNT=$P($G(^PSX(552.1,ZZZ,1)),"^",3)+OCNT
 W !!,"Last Order Processed ",?22,":",?24,$G(SITE)," ",PSX1
 W !,"Date and Time",?22,":",?24,$G(ACKTM)
 W !!,"Total in the Queue",?22,":",?24,$G(BCNT)," Transmissions with ",$G(OCNT)_"/"_$G(CNT)," Orders/Rx's"
EX I $G(NDATA)>0 W !!,"No data has been sent to the automated system."
 I $G(QRY)>0 W !!,"Last Query Request",?22,":",?24,$S($G(QFLG)=0:$G(QRY),$G(QFLG)=1:$G(QRY)-1,1:""),!,"  Rx's received",?22,":",?24,$G(TRX),!,"  Date and Time",?22,":",?24,$G(QTM)
 I $G(QFLG)=1 W !!,"Query# ",$G(QRY)," in progress ",$G(TTRX)," Rx's have been received."
 W !
 S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR K DIR,Y W @IOF
EX1 K PSX1,ST,ST1,ST2,SITE,XXX,YYY,ZZZ,CNT,BCNT,OCNT,QRY,TRX,PSXSTAT,PSXTXT,ACKTM,IEN512,QFLG,QTM,STAT,TTRX,NDATA,DTOUT,DIROUT,DIRUT,DUOUT
 Q

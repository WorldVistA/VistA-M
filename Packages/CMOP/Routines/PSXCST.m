PSXCST ;BIR/JMB-Queues cost data compilation ;[ 04/08/97   2:06 PM ]
 ;;2.0;CMOP;;11 Apr 97
INIT ;Entry point for Initialize Nightly Compile Job
 I '$D(^XUSEC("PSXCOST",DUZ)) W !,"You are not authorized to use this option!" Q
 W !!?3,"A job will be tasked every night which compiles yesterday's cost",!?3,"statistics. This job should be run during off hours. The suggested",!?3,"time is 1 o'clock in the morning."
 W !!?3,"** CAUTION: Check with IRM to make sure the",!?15,"job has not already been queued.",!!
 S DIR(0)="Y",DIR("A")="Continue ",DIR("B")="N" D ^DIR K DIR G:$G(DIRUT)!('Y) END^PSXCSUTL S X1=DT,X2=1 D C^%DTC S Y=X_".0100" X ^DD("DD") S PSXEDTR=Y
TIME W ! D NOW^%DTC S %DT(0)=%,%DT="EFATX",%DT("A")="Enter date/time: ",%DT("B")=PSXEDTR D ^%DT G:$G(DTOUT)!($G(Y)<0) END^PSXCSUTL
 W ! S X=Y D H^%DTC S ZTDTH=%H_","_$S($G(%T):%T,1:"3600"),X1=$P(Y,"."),X2=-1 D C^%DTC S (PSXBDT,PSXEDT)=X
 G NQUE
NIGHT ;Entry point for nightly job
 S ZTDTH=$H+1_","_$P(ZTDTH,",",2),PSXHOLD=PSXSTART,(PSXBDT,PSXEDT)=DT D NQUE
 S PSXSTART=PSXHOLD S X1=DT,X2=-1 D C^%DTC S (PSXBDT,PSXEDT)=X D ^PSXCSDA K PSXHOLD
 I $E(DT,6,7)="01" S PSXJOB="C",PSXSTART=9999999.999999-$E($$HTFM^XLFDT($H),1,14) D QUE^PSXCSLG1 D
 .S PSXMON=$E(DT,4,5),PSXMON=$P("10^11^12^01^02^03^04^05^06^07^08^09","^",PSXMON),PSXYR=$S(+PSXMON>10:($E(DT,1,3)-1),1:$E(DT,1,3)),(PSXBDT,PSXEDT)=PSXYR_PSXMON_"00" D ^PSXCSCMN
 K PSXLOC S PSXCNT=0 F PSXIEN=0:0 S PSXIEN=$O(^PSX(554,1,2,PSXIEN)) Q:'PSXIEN  S PSXCNT=PSXCNT+1 S:PSXCNT>30 PSXLOC(PSXIEN)=""
 I PSXCNT>30 S DIK="^PSX(554,1,2,",DA(1)=1 F DA=0:0 S DA=$O(PSXLOC(DA)) Q:'DA  D ^DIK
 G END^PSXCSUTL
NQUE ;Queues nightly job.
 S PSXJOB="C",PSXSTART=9999999.999999-$E($$HTFM^XLFDT($H),1,14)
 S ZTIO="",ZTRTN="NIGHT^PSXCST",ZTDESC="CMOP Daily Compile of Cost Data",ZTIO="",ZTSAVE("PSXSTART")="" D ^%ZTLOAD W:$D(ZTSK)&('$D(ZTQUEUED)) !,"Task Queued!",! S:$D(ZTQUEUED) ZTREQ="@"
 D QUE^PSXCSLG1 G END^PSXCSUTL
RECOM ;Entry point for Date Range Compile/Recompile Cost Data
 I '$D(^XUSEC("PSXCOST",DUZ)) W !,"You are not authorized to use this option!" D END^PSXCSUTL Q
 W ! S %DT(0)=-DT,%DT("A")="Beginning date: " S %DT="EPA" D ^%DT G:"^"[X END^PSXCSUTL G:'Y RECOM S PSXBEG=Y K %DT(0)
REDT W ! S %DT(0)=PSXBEG,%DT("A")="   Ending date: " D ^%DT G:"^"[X END^PSXCSUTL G:Y<0 REDT S PSXEND=Y
 W ! S DIR("A")="Are you sure",DIR(0)="Y",DIR("B")="N" D ^DIR K DIR I $G(DIRUT)!('Y) W !!,"No data has been compiled/recompiled." G RECOM
 D ^PSXCST1 I $G(PSXERR) D END^PSXCSUTL G RECOM
 G END^PSXCSUTL
QUE ;Queues One Day & Date Range Compile/Recompile Cost Data
 D CHECK^PSXCSLOG I $G(PSXERR) N PSXERR D END^PSXCSUTL Q
 W !!,$S($G(PSXCOM)=1:"One Day",$G(PSXCOM)=2:"Daily",1:"Monthly")_" data compilation queued from "_$$FMTE^XLFDT(PSXBDT)_" to "_$$FMTE^XLFDT(PSXEDT)_"."
 S PSXJOB="C",PSXSTART=9999999.999999-$E($$HTFM^XLFDT($H),1,14)
 S ZTDTH="",ZTRTN=$S($G(PSXCOM):"^PSXCSDA",1:"^PSXCSCMN"),ZTDESC="CMOP Cost Data - Recompile "_$S($G(PSXCOM)=1:"One Day",$G(PSXCOM)=2:"Daily Data",1:"Monthly Data"),ZTIO=""
 F PSXG="PSXBDT","PSXEDT","PSXEND","PSXSTART" S:$D(@PSXG) ZTSAVE(PSXG)=""
 D ^%ZTLOAD I $D(ZTSK) W !!,"Task Queued!",! D QUE^PSXCSLG1
 S:$D(ZTQUEUED) ZTREQ="@"
 Q

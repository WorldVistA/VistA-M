RTFIX ;PKE/ISC-ALBANY-Cleanup 190.3 Routine; ; 4/7/93  11:45 AM ; [ 08/01/93  9:42 PM ]
 ;;v 2.0;Record Tracking;**12**;10/22/91 
 ;check movement file, #190.3 for pointers, x-ref 
 ;
EN ;entry point
 L +^TMP("RTFIX","START"):300 E  W !!?3,"Another RTFIX is running" Q
 ;
 ;if RTDB=0 just checks for bad nodes(debug)
 I '$D(RTDB) S RTDB=1
 ;
 ;if debug was on, start over
 I RTDB,$D(^TMP("RTFIX","DEBUG")) K ^TMP("RTFIX")
 ;if debug is on, remember
 I RTDB=0 S ^TMP("RTFIX","DEBUG")=""
 ;
 S RT=$S('$D(^TMP("RTFIX","START")):0,1:+^("START")) I RT S RT=RT-1
 D DT^DICRW,NOW^%DTC S RTIME=%,RTIM=X
 ;purge-node if using xtmp
 S X1=X,X2=5 D C^%DTC
 S $P(^TMP("RTFIX",0),"^",1,2)=X_"^"_RTIM
 S ^TMP("RTFIX","START")=RT_"^"_RTIME
 K ^TMP("RTFIX","STOP")
 ;
CONT F RTCT=1:1 S RT=$O(^RTV(190.3,"B",RT)) Q:'RT  DO
 .I RTCT#1000=0 DO
 ..S $P(^TMP("RTFIX","START"),"^",1)=RT
 ..I '$D(^TMP("RTFIX","RATE")) S (RATE,^("RATE"))=$P($H,",",2)
 ..E  S RATE=$P(^("RATE"),"^"),RATE=(+$P($H,",",2))-RATE ;naked ref to tmp(rtfix,rate)
 ..S RATE=$J((RATE/60),5,1)
 ..S ^("RATE")=$P($H,",",2)_"^"_RATE_"^"_RT ;naked ref to tmp(rtfix,rate)
 ..I $D(^TMP("RTFIX","STOP")) S RT="Zend" Q  ;stop if stopjob^rtfix
 ..I $$S^%ZTLOAD S RT="Zend",^TMP("RTFIX","STOP")="",ZTSTOP=1 Q
 ..I '$D(ZTQUEUED) W "."
 .;
 .S RTH=0
 .F  S RTH=$O(^RTV(190.3,"B",RT,RTH)) Q:'RTH  DO
 ..I '$D(^RTV(190.3,RTH,0)) DO  Q
 ...L +^RTV(190.3,RTH)
 ...K:RTDB ^RTV(190.3,"B",RT,RTH) L -^RTV(190.3,RTH)
 ...S ^TMP("RTFIX","XREF",RTH)=RT
 ...Q
 ..I +^RTV(190.3,RTH,0)'=RT DO  Q
 ...S RTM0=^(0) ;naked ref to rtv(190.3,rth,0)
 ...I 'RTM0,$D(^RT(RT,"CL")),+$P(^("CL"),"^",2)=RTH Q
 ...L +^RTV(190.3,RTH)
 ...K:RTDB ^RTV(190.3,"B",RT,RTH) L -^RTV(190.3,RTH)
 ...S DA=RTH,DIK="^RTV(190.3,"
 ...I '$D(^RT(+RTM0,0)) D:RTDB ^DIK S ^TMP("RTFIX","XMOVE",RTH)=RT Q
 ...I RTM0 D:RTDB IX^DIK S ^TMP("RTFIX","XINDEX",RTH)=RT
 ...Q
 ..Q
 ;
 L -^TMP("RTFIX","START")
 D NOW^%DTC I $D(^TMP("RTFIX","STOP")) S ^("STOP")=%_"^"_RTCT N ZTSTOP D KILL Q
 K:RTDB ^TMP("RTFIX")
KILL D KILL^XUSCLEAN Q
 ;
QUE ;entry to queue with taskman from prog mode
 S ZTIO="",ZTRTN="EN^RTFIX",ZTDESC="RT Check/Fix file 190.3"
 D ^%ZTLOAD Q
 ;
JOB S ZTQUEUED="" G EN^RTFIX Q
 ;
DEBUG S RTDB=0 G EN^RTFIX Q
 ;
STOPJOB ;entry to stop job after about 1000 records if jobbed or tasked
 S ^TMP("RTFIX","STOP")=""
 W !?5,"The RTFIX routine will be stopping soon . .  ." Q
 ;
RATE ;entry to see how its going
 Q:'$D(^TMP("RTFIX","RATE"))
 L +^TMP("RTFIX","RATE")
 W !?3,"Minutes/1K records = ",$P(^TMP("RTFIX","RATE"),"^",2)
 W !?3,"  Current Record # =   ",$P(^TMP("RTFIX","RATE"),"^",3)
 W !?3,"     Last Record # =   ",$P(^RT(0),"^",3),!
 L -^TMP("RTFIX","RATE") Q
 ;
DOC ;The routine can run from programmer mode by
 ;D ^RTFIX
 ;
 ;The routine can be queued through TaskMan by
 ;D QUE^RTFIX
 ;
 ;The routine can be run in DEBUG mode by
 ;D DEBUG^RTFIX
 ;
 ;The routine can be stopped at any time by
 ;D STOPJOB^RTFIX or TBOX option for a taskman job
 ;
 ;The routine can be restarted where it left off as
 ;long as the global ^TMP("RTFIX" still exists.
 ;
 ;The status of the job can be monitored by
 ;D RATE^RTFIX
 ;
 ;XQ XUTL $J NODES option should be suspended on cpu when this
 ;routine is running to prevent ^TMP from being killed
 ;
 ;^TMP is only used to store start/stop and bad movements found
 ;
 ; Can be changed to use standard use of ^xtmp global by changing
 ; every ^tmp to ^xtmp.  Will set nodes correctly to avoid xtmp
 ; purge.
 ; 
 ;^TMP(nodes)          description                     action
 ;
 ;^("XREF",RTMOV)=RT   means a "B" entry with      xref deleted 
 ;                     no zero node               
 ;^("XMOVE"...         means  no record            movement deleted
 ;^("XINDEX"...        means  different record     xref corrected

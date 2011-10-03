HLEVAPI0 ;O-OIFO/LJA - Event Monitor APIs ;02/04/2004 14:42
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
ONOFFM(HLEVIENE,STATUS) ;Turn on/off event monitor...
 D DEBUG^HLEVAPI2("ONOFFM") ; Debug data created conditionally
 ;
 ; Stop all event monitoring to enable on-site debugging...
 QUIT:$G(^TMP("HLEVFLAG",$J))["STOP"  ;->
 ;
 QUIT $$ONOFF(776.1,+HLEVIENE,STATUS)
 ;
ONOFFS(HLEVIEN,STATUS) ; Turn on/off system...
 QUIT $$ONOFF(776.999,+HLEVIEN,STATUS)
 ;
ONOFF(FILE,HLEVIENE,STATUS) ; Turn on/off event monitor or system...
 ; FILE can = 776.1 or 776.999
 ; Actually, HLEVIENE can be the IEN of the monitor, or the system.
 ; If STATUS="A", sets status to ACTIVE.
 ; If STATUS="I", sets status to INACTIVE.
 ; If STATUS=null or undefined (not passed), present status returned...
 ;
 N DA,DATA,DIE,DR,STAT,X,Y
 ;
 ; Find entry and IEN and zero node data...
 S FILE=+$G(FILE) I FILE'=776.1&(FILE'=776.999) QUIT "^Invalid file number" ;->
 S HLEVIENE=$G(HLEVIENE)
 S:FILE=776.999 HLEVIENE=1 ; Just overwrite anything passed by user...
 I $L($G(STATUS))>1 QUIT "^Invalid STATUS passed" ;->
 S STATUS=$$UP^XLFSTR($E($G(STATUS)_" "))
 I " AI"'[STATUS QUIT "^Invalid STATUS passed" ;->
 ;
 ; If they passed the name of the entry...
 I HLEVIENE'=+HLEVIENE D  QUIT:HLEVIENE'>0 "^Couldn't find entry" ;->
 .  I $TR(HLEVIENE," ","")']"" QUIT  ;->
 .  S HLEVIENE(1)=$O(^HLEV(FILE,"B",HLEVIENE,0)) ; Must have passed in name
 .  I HLEVIENE(1)'>0 D
 .  .  S HLEVIENE(1)=$O(^HLEV(FILE,"B",$$UP^XLFSTR(HLEVIENE),0))
 .  S HLEVIENE=HLEVIENE(1)
 ;
 ; Get zero node...
 S DATA=$G(^HLEV(FILE,+HLEVIENE,0)) QUIT:DATA']"" "^Couldn't find entry" ;->
 ;
 ; Get current status...
 S STAT=$E($P(DATA,U,2)_" ")
 ;
 ; If current status not yet entered in field...
 I " AI"'[STAT D  QUIT STAT ;->
 .  ; Passed-in STATUS not A or I, so just tell them value of status...
 .  I "AI"'[STATUS S STAT="^Status not entered yet" QUIT  ;->
 .  ; User passed in a value to set the status to, so set it for them...
 .  S DA=+HLEVIENE,DIE=FILE,DR="2///"_STATUS
 .  D ^DIE
 .  S STAT=STATUS
 ;
 ; If all they want is the status...
 I STATUS=" " QUIT STAT ;->
 ;
 ; Status entered in field before call...
 ;
 ; If passed-in status is the same as the current status in entry...
 I STAT=STATUS QUIT STATUS ;-> Already set...
 ;
 ; Change status of field to passed-in value...
 S DA=+HLEVIENE,DIE=FILE,DR="2///"_STATUS
 D ^DIE
 ;
 Q STATUS
 ;
ONOFFEV ; Turn on/off event monitor
 N CHG
 ;
 N DATA,DIC,IEN,IENR
 D HDR^HLEVREP("Turn on/off Event Monitors")
 ;
S7761 KILL DATA,DIC,IEN,IENR
 W !
 S IEN=$$ASKIEN^HLEVREP(776.1) QUIT:IEN'>0  ;->
 D HDR^HLEVREP("Turn on/off Event Monitors",IEN)
 D VIEW7761(+IEN)
 D RUNS7761^HLEVREP(+IEN)
 I $D(^TMP($J,"HLRUNS")) D
 .  W !!,"Recent Checks of the Monitor by Master Job"
 .  W !,$$REPEAT^XLFSTR("-",IOM)
 .  W !,"Check-time",?18,"Results"
 .  W !,$$REPEAT^XLFSTR("-",IOM)
 .  S IENR=0
 .  F  S IENR=$O(^TMP($J,"HLRUNS",IENR)) Q:IENR'>0  D
 .  .  S DATA=$G(^TMP($J,"HLRUNS",IENR)) QUIT:DATA']""  ;->
 .  .  W !,$$SDT^HLEVX001($P(DATA,U,2)),?18,$$STAT2M^HLEVX001($P(DATA,U))
 W !
 S CHG=$$ACTINACT(776.1,+IEN,2,"Event monitor status")
 I CHG D
 .  D HDR^HLEVREP("Turn on/off Event Monitors",IEN)
 .  D VIEW7761(+IEN)
 F  Q:(IOSL-$Y)<4  W !
 ;S X=$$BTE^HLCSMON("Press RETURN to continue... ")
 G S7761 ;->
 ;
VIEW7761(IEN) ; Actual display code for entry...
 N NODE,P1,P2,P3,P4,P5,P6,PAR,PCE
 ;
 S NODE=$G(^HLEV(776.1,+IEN,0))
 F PCE=1:1:6 S @("P"_PCE)=$P(NODE,U,PCE)
 ;
 ; Store under field number...
 F PCE=1:1:8 S PAR(PCE)=$P($G(^HLEV(776.1,+IEN,40)),U,PCE)
 ;
 D SH7761("Description",$S(P3]"":P3,1:"---"))
 D SH7761("Status",$S(P2="A":"ACTIVE",1:"INACTIVE"))
 D SH7761("Requeue minutes",$S(P4:P4_"min",P4=0:"0 [Immediate Run]",1:"---"))
 D SH7761("Notification mail group",$S(P5:$P($G(^XMB(3.8,+P5,0)),U),1:"---"))
 D SH7761("M startup",$S(P6]"":P6,1:"---"))
 W !,$$CJ^XLFSTR(" Parameter ""Variable"" Descriptors ",IOM,"-")
 F PCE=1:1:8 I PAR(PCE)]"" D
 .  W !,?25,"Parameter - "_PCE_" = ",PAR(PCE)
 ;
 Q
 ;
SH7761(TAG,VAL) ;
 W !,?(35-$L(TAG)-2),TAG,":",?45,VAL
 Q
 ;
ONOFFPAR ; Turn on/off parameters...
 N CHG
 ;
 D VIEW7769^HLEVREP(0)
 ;
 W !
 ;
 S CHG=0
 S X=$$ACTINACT(776.999,1,2,"STATUS-MASTER JOB") I X=1 S CHG=1
 S X=$$ACTINACT(776.999,1,6,"STATUS-EVENT MONITORING") I X=1 S CHG=1
 ;
 I CHG D VIEW7769^HLEVREP(0)
 ;
 W !
 F  Q:(IOSL-$Y)<3  W !
 S X=$$BTE^HLCSMON("Press RETURN to exit... ")
 ;
 Q
 ;
ACTINACT(FILE,IEN,FLD,TAG) ; Turn on/off status fields...
 N DA,DIE,DR,STAT,X,Y
 S STAT=$P($G(^HLEV(FILE,IEN,0)),U,+FLD)
 S X=$$YN^HLCSRPT4("Change '"_TAG_"' to "_$S(STAT="A":"INACTIVE",1:"ACTIVE"),"No") I X'=1 D  QUIT "" ;->
 .  W "  ... nothing changed ..."
 S DA=IEN,DIE=FILE,DR=FLD_"///"_$S(STAT="A":"I",1:"A")
 D ^DIE
 W "     changed!"
 Q 1
 ;
EVENTCHK(HLEVIENM) ; Loop thru all MONITORs...
 ; NOEVCHK,ZTSKMST -- req
 N HLEVIENE,HLEVNM
 ;
 ; Check STATUS-EVENT...
 S NO=$O(^HLEV(776.999,":"),-1) QUIT:$P($G(^HLEV(776.999,+NO,0)),U,6)'="A"  ;->
 ;
 S HLEVNM=0
 F  S HLEVNM=$O(^HLEV(776.1,"B",HLEVNM)) Q:HLEVNM']""  D
 .  S HLEVIENE=0
 .  F  S HLEVIENE=$O(^HLEV(776.1,"B",HLEVNM,HLEVIENE)) Q:'HLEVIENE  D
 .  .  D EVENTONE^HLEVAPI3(HLEVIENM,HLEVNM,HLEVIENE)
 .  .  S NOEVCHK=$G(NOEVCHK)+1
 ;
 Q
 ;
EVRES(HLEVIENM,HLEVIENE,RES,HLEVIENJ) ; Record result of queued task...
 ; ZTSK -- req
 N MIEN,NODE,STATUS
 ;
 ; Initial sets...
 S STATUS=$P($G(^HLEV(776,+$G(HLEVIENJ),0)),U,4)
 S RES=$E($$UP^XLFSTR($G(RES)))
 ;
 ; If any call made here, the job is running by definition...
 I $G(^HLEV(776,+$G(HLEVIENJ),0))]"" D
 .  ; ABORT^HLEVAPI might have set status to ERROR.  Don't override!
 .  S $P(^HLEV(776,+$G(HLEVIENJ),0),U,4)=$S(STATUS="E":"E",RES="X":"E",RES="F":"F",1:"R")
 ;
 ; If no master job, or RUNNING, quit...
 I HLEVIENM=9999999!(RES="R") QUIT  ;->
 ;
 ; Store results in 776.2...
 S MIEN=$O(^HLEV(776.2,+HLEVIENM,51,"B",+HLEVIENE,0)) QUIT:MIEN'>0  ;->
 S NODE=$G(^HLEV(776.2,+HLEVIENM,51,+MIEN,0)) QUIT:NODE']""  ;->
 ; Various jobs will set... QUIT:$P(NODE,U,4)'=$G(ZTSK)  ;->
 S $P(NODE,U,5)=$G(RES),$P(NODE,U,6)=$$NOW^XLFDT
 S ^HLEV(776.2,+HLEVIENM,51,+MIEN,0)=NODE
 ;
 Q
 ;
RUNEV(LASTRUN,LAPSE) ; Is LASTRUN (FM) LAPSE(min) before NOW?
 N WHENRUN
 QUIT:LASTRUN']"" "" ;->
 S WHENRUN=$$FMADD^XLFDT($$NOW^XLFDT,0,0,-LAPSE)
 Q $S(WHENRUN>LASTRUN:1,1:"")
 ;
OKMCODE(MREF) ; Is this a valid M subrtn^rtn reference?
 N TXT
 QUIT:MREF'?1.8E1"^"1.8E "" ;->
 S TXT=$T(@MREF)
 Q $S(TXT]"":1,1:"")
 ;
Q1TIME(HLEVIENE,OVERRIDE,QTIME,XTMP) ; Start a one-time run of event monitor (w/no master job)
 N DATA,HLEVIENJ,HLEVNM,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 ;
 ; Override inactive entry?
 S OVERRIDE=$S($G(OVERRIDE):1,1:0)
 ;
 ; Queue to future time?
 S QTIME=$G(QTIME)
 ;
 ; Is event active?
 S DATA=$G(^HLEV(776.1,+$G(HLEVIENE),0)) QUIT:DATA']"" "^Entry not found" ;->
 I $P(DATA,U,2)'="A",'OVERRIDE QUIT "^Event not active" ;->
 ;
 ; More variable sets...
 S HLEVNM=$P(DATA,U)
 S HLEVIENM=9999999 ; A one-time, no master job, run...
 ;
 ; Create a monitor stub entry...
 S HLEVIENJ=$$NEWEVENT^HLEVAPI(HLEVIENE,QTIME)
 I HLEVIENJ'>0 QUIT "^Entry creation failure" ;->
 ;
 ; Queue a new job w/stub entry's IEN...
 S ZTIO="",ZTDTH=$S(QTIME?7N1"."1.N:$$FMTH^XLFDT(QTIME),1:$H)
 S ZTDESC="HL Event Monitor - #"_HLEVIENE
 S ZTRTN="QUEUEV^HLEVAPI3"
 S ZTSAVE("HLEVIENJ")="",ZTSAVE("HLEVIENE")=""
 S ZTSAVE("HLEVNM")="",ZTSAVE("HLEVIENM")=""
 I $G(XTMP)]"" S ZTSAVE("XTMP")=""
 D ^%ZTLOAD
 ;
 I $G(^HLEV(776,+$G(HLEVIENJ),0))]"",$G(ZTSK)>0 D
 .  N DA,DIE,DR
 .  S DA=+HLEVIENJ,DIE=776,DR="8///"_ZTSK
 .  D ^DIE
 ;
 Q $G(ZTSK)_U_$G(HLEVIENJ)
 ;
EOR ;HLEVAPI0 - Event Monitor APIs ;5/16/03 14:42

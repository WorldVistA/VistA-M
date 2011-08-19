HLEVMST ;O-OIFO/LJA - Event Monitor MASTER JOB ;02/04/2004 14:42
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
 ; Calling STARTJOB always queues a new master job NOW...
 ;
MSTENV ; Display environment to user...
 ;
 ;
 ; Collect Master Job Information
 ;
 ;
 ; Collect Active Event Monitors
 ;
 ;
 Q
 ;
CHECKMST ; Called from outside Event Monitoring, from the Link Manager,
 ; to see if the master job needs to be started.  (See ^HLCSLM.)
 ; When the Link Manager calls here, two actions potentially occur:
 ;
 ; * Check is made whether this CHECKMST code has been run before,
 ;   and if so, how long ago.  This check is performed by $$TIMECHK.
 ; * If never run, or if run more than four hours ago, CHECKMST is run.
 ;
 ; CHECKMST checks whether a master job is running, or is properly 
 ; queued.  If not, it queues a master job.
 ;
 N LAPSE,LASTDT,LASTIEN,NODE,PAR0,RUNOW,RUNTIME,X
 ;
 QUIT:'$$TIMECHK  ;->
 ;
 ; Set last check time for later use by $$TIMECHK...
 S HLEVLCHK(1)=$$SEC^HLEVMST0($H)
 ;
 ; Parameter status check...
 S PAR0=$G(^HLEV(776.999,1,0)) Q:PAR0']""  ;->
 I $P(PAR0,U,2)'="A" D  QUIT  ;-> Not ACTIVE...
 .  D SHOWQUIT("Master job not started.  Parameter STATUS is INACTIVE...")
 ;
 ; Lapse (since last run) check...
 S LAPSE=$P(PAR0,U,3) I LAPSE'>0 D  QUIT  ;->
 .  D SHOWQUIT("Master job not started.  Master Job Interval not set up...")
 ; Get IEN for last master job run
 S LASTDT=$O(^HLEV(776.2,"B",":"),-1)
 S LASTIEN=$O(^HLEV(776.2,"B",+LASTDT,":"),-1)
 ;
 I LASTIEN'>0 D STARTJOB QUIT  ;->
 S NODE=$G(^HLEV(776.2,+LASTIEN,0))
 S X=$P(NODE,U,4) I X="E"!(X="P") D STARTJOB QUIT  ;->
 S RUNTIME=$P(NODE,U,6) ; Queue time for last run...
 S RUNOW=$$RUNEV^HLEVAPI0(RUNTIME,LAPSE+15) ; No start unless 15" overdue
 I RUNOW D STARTJOB QUIT  ;-> 15" overdue!!  So, start master job
 D SHOWQUIT("Master job not started.  Not time yet...")
 ;
 Q
 ;
TIMECHK() ; Every loop in the Link Manager code in HLCSLM results in one
 ; call being made to CHECKMST^HLEVMST.  The CHECKMST subroutine in turn
 ; calls here to ensure that the Event Monitor's master job is running
 ; properly.  However, the CHECKMST subroutine should be run by HLCSLM
 ; only once every four hours.  The code in this subroutine uses
 ; HLEVLCHK(#) variables to ensure that this every four hour rule is
 ; followed.  (HLEVLCHK is newed at the top of HLCSLM.)
 ;
 ; Set the time NOW in seconds...
 S HLEVLCHK(0)=$$SEC^HLEVMST0($H)
 ;
 ; This is the time of last check.  Make sure it exists...
 S HLEVLCHK(1)=$G(HLEVLCHK(1))
 ;
 ; If no check every made, make a check now...
 I HLEVLCHK(1)'>0 QUIT 1 ;->
 ;
 ; Set the number seconds between NOW and time of last check...
 S HLEVLCHK(3)=HLEVLCHK(0)-HLEVLCHK(1) ; DIFF = NOW - LAST CHECK
 ;
 ; If less than 4 hours since last check, quit w/no check...
 QUIT:HLEVLCHK(3)<(60*60*4) "" ;->
 ;
 Q 1 ; Check should be made...
 ;
SHOWQUIT(TXT) QUIT:$D(ZTQUEUED)  ;->
 W !!,TXT,!
 Q
 ;
STARTJOB ; Start a new job with optional display to screen...
 N JOBS
 S JOBS=$$NEWMSTR(0,1) QUIT:$D(ZTQUEUED)  ;->
 W !!,"New master job queued to task# ",+JOBS,"..."
 W !,"Entry #",$P(JOBS,U,2)," created in HL7 Monitor Master Job file..."
 Q
 ;
MASTER ; Whenever a master job starts, here's where it's queued...
 ; HLEVIENM - req
 ;
 N D,D0,DA,DIE,DR,FLD,NOEVCHK,NOPURG,NOW,RES,ZTSKMST
 ;
 S ZTREQ="@",NOW=$$NOW^XLFDT
 ;
 S ZTSKMST=$G(ZTSK) QUIT:ZTSKMST'>0  ;->
 ;
 QUIT:$G(^HLEV(776.2,+$G(HLEVIENM),0))']""  ;->
 ;
 ; Check parameter...
 I $P($G(^HLEV(776.999,1,0)),U,2)'="A" D  QUIT  ;->
 .  F FLD=2,3,8 D UPDFLDM(+HLEVIENM,FLD,NOW)
 .  D UPDFLDM(+HLEVIENM,4,"A")
 ;
 ; Give (possibly just executed) $$NEWMSTR(0) DIE call time to execute...
 H 2
 ;
 ; Queue next job...
 S NEWJOB=$$NEWMSTR(1)
 ;
 ; What if job requested to stop?
 I $P($G(^HLEV(776.2,+HLEVIENM,0)),U,4)="S" D  QUIT  ;->
 .  F FLD=2,3,8 D UPDFLDM(+HLEVIENM,FLD,NOW)
 .  D UPDFLDM(+HLEVIENM,4,"A")
 ;
 ; Mark entry to show it successfully started...
 D UPDFLDM(+HLEVIENM,4,"R")
 F FLD=3,8 D UPDFLDM(+HLEVIENM,FLD,NOW)
 D UPDFLDM(+HLEVIENM,50,"Queued job started at "_$$NOW^XLFDT)
 ;
 ; Work starts here...
 KILL NOEVCHK
 S NOEVCHK=0
 D EVENTCHK^HLEVAPI0(+HLEVIENM)
 ;
 ; Purge MONITOR and MASTER entries...
 D PURGEALL^HLEVUTIL(+HLEVIENM)
 ;
 ; Mark ERROR any monitors still RUNNING by not current..
 D MARKERR^HLEVAPI3
 ;
 ; Done...
 D UPDFLDM(+HLEVIENM,2,$$NOW^XLFDT)
 D UPDFLDM(+HLEVIENM,4,"F")
 D UPDFLDM(+HLEVIENM,50,"Queued job finished at "_$$NOW^XLFDT)
 D UPDFLDM(+HLEVIENM,50,"# events checked = "_$G(NOEVCHK))
 S RES=""
 F  S RES=$O(NOEVCHK(RES)) Q:RES']""  D
 .  S RES(1)=$S(RES="E":" were not queued (too early.)",RES="I":" were not queued (inactivated.)",RES="Q":" were queued to execute.",RES="R":" Previous job still running.",RES="X":" errored, for some reason.",1:" have unknown disposition.")
 .  I RES="M" S RES(1)=" M code check failed."
 .  S RES(1)="#"_NOEVCHK(RES)_" Events"_RES(1)
 .  D UPDFLDM(+HLEVIENM,50,RES(1))
 ;
 Q
 ;
NEWMSTR(FUTURE,SILENT) ; Create a new master job...
 ; 
 ; If FUTURE=0, then master job will be queued for NOW...
 ; If FUTURE=1, then master job will be q'd for CUTMIN in future...
 ;
 N CUTMIN,DA,DIC,DIE,DD,DO,DR,HLEVIENM,X,Y,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSK
 ;
 ; Should this process be silent?
 S SILENT=$S($G(SILENT)>0:1,1:0)
 ;
 ; Check parameter...
 I $P($G(^HLEV(776.999,1,0)),U,2)'="A" D  QUIT "" ;->
 .  QUIT:$D(ZTQUEUED)!(SILENT)  ;->
 .  W !!,"Exiting!  Master job not started.  Parameter turned off..."
 .  H 2
 ;
 ; Make master stub entry...
 S X=$$NOW^XLFDT,DIC="^HLEV(776.2,",DIC(0)="L"
 D FILE^DICN
 S HLEVIENM=$S(+Y>0:+Y,1:"") I HLEVIENM'>0 D  QUIT "" ;->
 .  QUIT:$D(ZTQUEUED)!(SILENT)  ;->
 .  W !!,"Exiting!  Master job not started.  Stub record creation failed..."
 .  H 2
 ;
 ; Get CUTMIN and queue new job...
 S CUTMIN=$H ; Default to NOW...
 I $G(FUTURE) D
 .  S CUTMIN=$O(^HLEV(776.999,":"),-1),CUTMIN=$P($G(^HLEV(776.999,+CUTMIN,0)),U,3)
 .  S CUTMIN=$S(CUTMIN:CUTMIN,1:60) ; Default to 60 minutes between jobs...
 .  S CUTMIN=$$FMTH^XLFDT($$FMADD^XLFDT($$NOW^XLFDT,0,0,CUTMIN))
 S ZTIO="",ZTDTH=CUTMIN,ZTDESC="HL Master Job - Event Monitoring"
 S ZTRTN="MASTER^HLEVMST"
 S ZTSAVE("HLEVIENM")=""
 D ^%ZTLOAD
 ;
 ; Store task #, etc...
 KILL DA,DD,DIC,DO,X,Y
 S DA=+HLEVIENM,DIE=776.2,DR="4///Q;5///"_ZTSK_";6////"_$$HTFM^XLFDT(CUTMIN)_";7////"_+DUZ
 D ^DIE
 ;
 I '$D(ZTQUEUED)&('SILENT) D
 .  W !!,"Master job created.  Task# ",ZTSK,", and Event# ",HLEVIENM,"..."
 .  H 2
 ;
 QUIT $G(ZTSK)_U_HLEVIENM
 ;
UPDFLDM(HLEVIENM,FLD,VAL) ; Update a specific piece in 776.2...
 N D,D0,DA,DI,DIE,DR
 ;
 QUIT:$G(^HLEV(776.2,+$G(HLEVIENM),0))']""!($G(VAL)']"")  ;->
 ;
 ; Call call here to store one 50 diary entry.  (Required that
 ; FLD=50 and VAL=Text to store on line.  Must call here one time
 ; for every line to be stored.)
 I FLD=50 D  QUIT  ;->  Call call here to store one 50 diary entry
 .  S NODE=$G(^HLEV(776.2,+HLEVIENM,50,0))
 .  S:NODE']"" NODE="^776.201^^"
 .  S CT=$O(^HLEV(776.2,+HLEVIENM,50,":"),-1)+1
 .  S $P(NODE,U,3)=CT,$P(NODE,U,4)=CT
 .  S ^HLEV(776.2,+HLEVIENM,50,0)=NODE
 .  S ^HLEV(776.2,+HLEVIENM,50,+CT,0)=VAL
 ;
 I FLD=51 QUIT  ;-> Not allowed!
 ;
 ; Store zero node information...
 S DA=+HLEVIENM,DIE=776.2,DR=FLD_"///"_VAL
 D ^DIE
 ;
 Q
 ;
STAMPM(HLEVIENM) ; Update TIMESTAMP field in event..
 N D,D0,DA,DI,DIE,DR
 QUIT:$G(^HLEV(776.2,+$G(HLEVIENM),0))']""  ;->
 S DA=+HLEVIENM,DIE=776.2,DR="3////"_$$NOW^XLFDT
 D ^DIE
 Q
 ;
PURGEM(HLEVIENM) ; Purge master job entries...
 N CUTIME,IENM,LOOPTM,NOPURG,RETHRM
 ;
 ; Check parameter...
 QUIT:$P($G(^HLEV(776.999,1,0)),U,2)'="A" "" ;->
 ;
 S NOPURG=0
 ;
 ; Get retention time (HR) for master job data...
 S RETHRM=$O(^HLEV(776.999,":"),-1)
 S RETHRM=$P($G(^HLEV(776.999,+RETHRM,0)),U,5)
 S RETHRM=$S(RETHRM>0:RETHRM,1:96) ; Default to 96 hours
 ;
 ; Cutoff time...
 S CUTIME=$$FMADD^XLFDT($$NOW^XLFDT,0,-RETHRM)
 ;
 F  S CUTIME=$O(^HLEV(776.2,"B",CUTIME),-1) Q:CUTIME'>0  D
 .  S IEN=0
 .  F  S IEN=$O(^HLEV(776.2,"B",CUTIME,IEN)) Q:IEN'>0  D
 .  .  QUIT:IEN=HLEVIENM  ;-> Don't delete yourself!!
 .  .  S NOPURG=NOPURG+1
 .  .  D PURGEME^HLEVUTIL(+IEN) ; Delete events in master job...
 .  .  D DELETE^HLEVUTIL(776.2,+IEN)
 ;
 Q NOPURG
 ;
EOR ;HLEVMST - Event Monitor MASTER JOB ;5/16/03 14:42

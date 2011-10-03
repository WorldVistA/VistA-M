HLEVMST0 ;O-OIFO/LJA - Event Monitor MASTER JOB ;02/04/2004 14:42
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
UNQUEUE ; Unqueue master job...
 N DIFF,IOINHI,IOINORM,LAST0,LASTDT,LASTIEN,NEXTH,SECNEXT
 N SECNOW,TASKNO,ZTDTH,ZTSK
 ;
 S X="IOINHI;IOINORM" D ENDR^%ZISS
 ;
 D HDU
 D EXU
 ;
 W !
 ;
 S LASTDT=$O(^HLEV(776.2,"B",":"),-1)
 S LASTIEN=$O(^HLEV(776.2,"B",+LASTDT,":"),-1)
 S LAST0=$G(^HLEV(776.2,+LASTIEN,0)) I $P(LAST0,U,4)'="Q" D  QUIT  ;->
 .  D TELL("The most recently queued master job is no longer active...","1^2^999")
 ;
 S LASTSK=$P(LAST0,U,5) I LASTSK>0 D
 .  W !,"The current master job is task# ",$P(LAST0,U,5),", queued for "
 .  W $$FMTE^XLFDT(+$P(LAST0,U,6)),"."
 ;
 W !
 I '$$YN^HLCSRPT4("OK to stop master job now","No") D  QUIT  ;->
 .  W "     no action taken..."
 ;
 W "   Master job stopped..."
 W !!,IOINHI,"Important!!",IOINORM,"  You must remember to start a new master job!!"
 ;
 D UNQ^HLEVUTIL(+LASTIEN,+LASTSK,"Master job stopped by "_$P($G(^VA(200,+$G(DUZ),0)),U)_".")
 ;
 D TELL("","0^0^999")
 ;
 Q
 ;
HDU W @IOF,$$CJ^XLFSTR("Unqueue Master Job",IOM)
 W !,$$REPEAT^XLFSTR("=",IOM)
 QUIT
 ;
EXU N I,T F I=1:1 S T=$T(EXU+I) QUIT:T'[";;"  W !,$P(T,";;",2,99)
 ;;If a master job has been queued to a future time, it can be unqueued now.
 ;;
 ;;Note:  If you unqueue this task, no future master jobs will run until you
 ;;       manually start a new master job.  (Start new master jobs with the 
 ;;       '' menu option.)
 QUIT
 ;
MSTNOW ; Start queued master job now!
 N DIFF,LAST0,LASTDT,LASTIEN,NEXTH,SECNEXT,SECNOW,TASKNO,ZTDTH,ZTSK
 ;
 W @IOF,$$CJ^XLFSTR("Master Job ""Run Now"" Utility",IOM)
 W !,$$REPEAT^XLFSTR("=",IOM)
 W !
 ;
 S LASTDT=$O(^HLEV(776.2,"B",":"),-1) ; Last (probably queued) job time
 S LASTIEN=$O(^HLEV(776.2,"B",+LASTDT,":"),-1)
 S LAST0=$G(^HLEV(776.2,+LASTIEN,0)) I LAST0']"" D
 .  W !,"Couldn't find last master job entry..."
 ;
 S TASKNO=$P(LAST0,U,5) I '$D(^%ZTSK(+TASKNO)) D
 .  W !,"Couldn't find task",$S(TASKNO:"# "_TASKNO_"...",1:".")
 ;
 S TASK0=$G(^%ZTSK(+TASKNO,0)) I TASK0']""  D
 .  W !,"Couldn't find task# ",TASKNO,"'S zero node..."
 ;
 S NEXTH=$P(TASK0,U,6) I NEXTH'?1.N1","1.N D
 .  W !,"Invalid future queue time ($H)..."
 ;
 S SECNEXT=$$SEC(NEXTH)
 S SECNOW=$$SEC($H)
 ;
 S DIFF=SECNEXT-SECNOW
 I DIFF<60 D  QUIT  ;->
 .  I DIFF<1 W !,"Master job will start any moment!" QUIT  ;->
 .  W !,"Master job will start on its own in ",DIFF," seconds..."
 ;
 I '$D(^%ZTSCH(SECNEXT,TASKNO)) D
 .  W !,"Couldn't find ^%ZTSK(SEC,ZTSK) node..."
 ;
 W !,"This utility allows you to run the master job ahead of it's currently"
 W !,"scheduled time to run."
 ;
 W !!,"Master task# ",TASKNO," is queued to "
 W $$SDT^HLEVX001($$HTFM^XLFDT(NEXTH))
 W " and it will be started now..."
 ;
 W !
 I '$$YN^HLCSRPT4("OK to start now","No") D  QUIT  ;->
 .  W "     no action taken..."
 ;
 S ZTSK=TASKNO,ZTDTH=$H
 D REQ^%ZTLOAD
 ;
 W !!,"Master job requeued to 'now'..."
 ;
 Q
 ;
STARTMST ; Start brand new master job now (interactively)!
 N DIFF,IOINHI,IOINORM,LAST0,LASTDT,LASTIEN,NEXTH,SECNEXT
 N SECNOW,TASKNO,ZTDTH,ZTSK
 ;
 S LASTDT=$O(^HLEV(776.2,"B",":"),-1)
 S LASTIEN=$O(^HLEV(776.2,"B",+LASTDT,":"),-1)
 S LAST0=$G(^HLEV(776.2,+LASTIEN,0))
 S TASKNO=$P(LAST0,U,5)
 ;
 ; If this option is accessed by queued background job, just unqueue
 ; everything to make sure, and start a new master job for NOW...
 I $D(ZTQUEUED) D  QUIT  ;->
 .  D UNQ^HLEVUTIL(+LASTIEN,+TASKNO,"Reboot unqueue/requeue master job.")
 .  D STARTJOB^HLEVMST
 ;
 S X="IOINHI;IOINORM" D ENDR^%ZISS
 ;
 D HD
 D EX
 ;
 W !
 ;
 I $P(LAST0,U,4)="Q" D  QUIT  ;->
 .  D TELL("It appears as if task# "_$P(LAST0,U,5)_" has already been queued.","1^2^999")
 ;
 I $P(LAST0,U,5)>0 D
 .  W !!,"The ",IOINHI,"last",IOINORM
 .  W " master job was task# ",$P(LAST0,U,5),", queued "
 .  W $$FMTE^XLFDT(+LAST0),"."
 ;
 W !
 I '$$YN^HLCSRPT4("OK to start a "_IOINHI_"new"_IOINORM_" master task now","No") D  QUIT  ;->
 .  W "     no action taken..."
 ;
 D STARTJOB^HLEVMST
 ;
 D TELL("Press RETURN to exit... ","0^0^999")
 ;
 Q
 ;
HD W @IOF,$$CJ^XLFSTR("Master Job Start",IOM)
 W !,$$REPEAT^XLFSTR("=",IOM)
 QUIT
 ;
EX N I,T F I=1:1 S T=$T(EX+I) QUIT:T'[";;"  W !,$P(T,";;",2,99)
 ;;This option will queue a new master job task if no master job is currently
 ;;running and no master job is queued for the future.
 ;;
 ;;Note:  A master job is queued every time the event monitoring software is
 ;;       installed, and every time the system is rebooted.  So, normally it
 ;;       is not necessary to use this option to create a new master job.  
 ;;       (The most common reason for using this option is if the queued
 ;;       master job was 'dequeued'.)
 QUIT
 ;
SEC(HORO) ; Convert $H to seconds...
 QUIT:HORO'?5.N1","1.N "" ;->
 QUIT ((86400*+HORO)+$P(HORO,",",2))
 ;
SECTHORO(SEC) ; Convert seconds to $H...
 N DAYS,SECH
 QUIT:SEC'?1.N "" ;->
 S DAYS=SEC\86400,SECH=SEC#86400
 QUIT DAYS_","_SECH
 ;
TELL(TXTINFO,ACT,TXTBT) ; Print TXTINFO, FF to bottom, and $$BTE(TXTBT)...
 ;
 ; ACT = #1 ^ #2 ^ #3 ^ #4 -> Controls pre-$$BTE positioning...
 ;
 ;       #1 => 0 = Spaces before printing TXTINFO (See #2). 
 ;             1 = Lines before printing TXTINFO (see #2).  [DEFAULT]
 ;       #2 => # = # Spaces (if #1=0) or lines (if #1=1-DEFAULT)
 ;       #3 => # = # lines before printing TXTBT (see #4).
 ;                 (# lines printed will never exceed IOSL unless
 ;                 overridden by #4.  Entering #3=999 just ensures that
 ;                 line feeds will be issued until cursor is at bottom
 ;                 of screen.
 ;       #4 => # = # lines that **must** be printed before TXTBT.
 ;
 ; Examples...
 ;
 ; 0^3^999^5 - Prints 3 spaces, TXTINFO and FFs to bottom.  If the 
 ;             screen was full when TELL was called, only one FF would
 ;             normally be issued (minimum, for spacing purposes).
 ;             However, the '5' ensures that at least 5 LFs are issued.
 ;             Then, TXTBT printed.
 ;
 ; 1^2^2     - Prints 2 LFs, TXTINFO, and 2 LFs, then TXTBT.  (If the
 ;             screen was full when TELL called, only 1 LF would be
 ;             printed before printing TXTBT.)
 ;
 N I,X
 ;
 S ACT=$G(ACT),TXTINFO=$G(TXTINFO)
 S TXTBT=$S($G(TXTBT)]"":TXTBT,1:"Press RETURN to exit... ")
 ;
 ; Default to line feeds...
 S:$P(ACT,U)'=0&($P(ACT,U)'=1) $P(ACT,U)=1
 ;
 ; Default to 1 line feed or 3 spaces...
 S:$P(ACT,U,2)'?1.N $P(ACT,U,2)=$S(+ACT=0:3,1:1)
 ;
 ; Default to bottom of form trailing lines...
 S:$P(ACT,U,3)'?1.N $P(ACT,U,3)=999
 ;
 ; Default to minimum lines after printing TXTINFO...
 S:$P(ACT,U,4)'?1.N $P(ACT,U,4)=1
 ;
 I +ACT=0 X "F I=1:1:$P(ACT,U,2) W "" """ W TXTINFO
 I +ACT=1 X "F I=1:1:$P(ACT,U,2) W !" W TXTINFO
 ;
 S ACT=$P(ACT,U,3,4)
 ;
 ; If positive, always issue at least one line feed...
 I ACT W ! S $P(ACT,U)=$P(ACT,U)-1
 ;
 F I=1:1:ACT Q:($Y+3)>IOSL&(ACT>$P(ACT,U,2))  W !
 ;
 S X=$$BTE^HLCSMON(TXTBT)
 ;
 Q
 ;
EOR ;HLEVMST0 - Event Monitor MASTER JOB ;5/16/03 14:42

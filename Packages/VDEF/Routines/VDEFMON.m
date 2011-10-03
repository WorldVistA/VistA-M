VDEFMON ;BPOIFO/JG - VDEF Queue Process Monitor ; 20 Dec 2005  13:00 PM
 ;;1.0;VDEF;**3**;Dec 28, 2004
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q  ; No bozos
 ;
START ; Main entry point for scheduling queue processor monitor in TaskMan
 I '$D(ZTQUEUED) W !,"Must be run from TaskMan." Q
 ;
START1 ; Non-TaskMan entry
 ;
 ; Only one of these needs to be running.
 L +^VDEFHL7("REQMON"):1 Q:'$T
 ;
 ; Start the Request Queue processor monitor
 N ZTDESC,ZTDTH,ZTIO,ZTPRI,ZTRTN,ZTSK
 S ZTRTN="MONITOR^VDEFMON",(ZTIO,ZTPRI)="",ZTDTH=$H
 S ZTDESC="VDEF Request Processor Monitor"
 L -^VDEFHL7("REQMON")
 D ^%ZTLOAD
 ;
 ; Check that TaskMan successfully queued up the Monitor task
 I '$G(ZTSK) D ALERT^VDEFUTIL("VDEF QUEUE PROCESS MONITOR DID NOT START. CHECK ERROR TRAP.")
 Q
 ;
 ; Main entry point for the Request Queue process monitor from TaskMan.
 ; Check the Request Queue processor for each queue that is defined
 ; and has a status of "R" (running). If it is not running, send an alert
 ; and restart it.
 ; If the Request Queue is currently suspended, send an alert telling
 ; site to restart it.
MONITOR L +^VDEFHL7("REQMON"):1 Q:'$T
 N QIEN,QUEFAIL,QUESTOP,VDEFTSK S VDEFTSK=ZTSK
MONITOR1 S QIEN=0
 F  S QIEN=+$O(^VDEFHL7(579.3,QIEN)) Q:'QIEN  D  D ALERTSUS:QUESTOP,ALERT:QUEFAIL
 . S (QUESTOP,QUEFAIL)=0
 . S QUESTOP=$P(^VDEFHL7(579.3,QIEN,0),U,9)="S" Q:QUESTOP
 . ;
 . ; Try to lock this Request Queue. If it's already locked,
 . ; assume that the Request queue processor is running OK.
 . L +^VDEFHL7(579.3,"QUEUE",QIEN):1 S QUEFAIL=$T
 . L -^VDEFHL7(579.3,"QUEUE",QIEN)
 ;
 ; Requeue any requests that are stuck in Checked Out or Errored Out status.
 S QIEN=0 N RQ
 F  S QIEN=+$O(^VDEFHL7(579.3,QIEN)) Q:'QIEN  D
 . I +$O(^VDEFHL7(579.3,"C","C",QIEN,"")) D
 .. D REQUEUE^VDEFQM(QIEN,.RQ)
 .. D:RQ ALERT^VDEFUTIL("VDEF HAS REQUEUED CHECKED OUT RECORDS. NO ACTION NEEDED.")
 . I +$O(^VDEFHL7(579.3,"C","E",QIEN,"")) D
 .. D RQERR^VDEFQM(QIEN,.RQ)
 .. D:RQ ALERT^VDEFUTIL("VDEF HAS REQUEUED ERRORED OUT RECORDS. NO ACTION NEEDED.")
 ;
 ; Wait for 10 minutes before checking the queue processors again.
 ; The wait process is in a loop so it can check if there
 ; has been a request to stop processing before the wait expires.
WAITLOOP N I F I=1:1:600 D  Q:ZTSTOP
 . S ZTSTOP=$$S^%ZTLOAD() Q:ZTSTOP
 . H 1
 ;
 ; Quit or resume processing
 G MONITOR1:'$G(ZTSTOP)
 ;
 ; Send an alert and delete this task's record
EXIT D ALERT^VDEFUTIL("VDEF QUEUE PROCESS MONITOR HAS EXITED.")
 L -^VDEFHL7("REQMON")
 S ZTSK=VDEFTSK,ZTSTOP=1,ZTREQ="@"
 Q
 ;
 ; Generate the failure/restart alert
ALERT N QUEUE,Y D ALERTDAT
 D ALERT^VDEFUTIL("VDEF QUEUE '"_QUEUE_"' AUTO-RESTARTED. NO ACTION REQUIRED.")
 ;
 ; Restart the Request Queue processor
 D REQ^VDEFCONT(QIEN)
 Q
 ;
 ; Generate the alert that a Request Queue is suspended.
ALERTSUS N QUEUE,Y D ALERTDAT
 D ALERT^VDEFUTIL("VDEF QUEUE '"_QUEUE_"' IS SUSPENDED. PLEASE START IT.")
 Q
 ;
 ; Get the queue name
ALERTDAT S QUEUE=$P(^VDEFHL7(579.3,QIEN,0),U)
 Q

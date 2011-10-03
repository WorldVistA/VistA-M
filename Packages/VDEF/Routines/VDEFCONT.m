VDEFCONT ;INTEGIC/AM & BPOIFO/JG - VDEF CONTROL PROGRAM ; 16 Nov 2005  1:08 PM
 ;;1.0;VDEF;**3**;Dec 28, 2004
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; IA: 10063 - $$S^%ZTLOAD
 ;     10063 - $$ASKSTOP^%ZTLOAD
 ;
 Q  ; No bozos
 ;
START ; Main entry point for scheduling queue processor jobs at Taskman
 ; Startup time
 I '$D(ZTQUEUED) W !,"Must be run from TaskMan." Q
 ;
 ; Start Request Queue processors
 N QIEN F QIEN=0:0 S QIEN=$O(^VDEFHL7(579.3,QIEN)) Q:'QIEN  D REQ(QIEN)
 ;
 ; Start the checked out request monitor job
 D MONCHKO
 ;
 ; Start the Request Queue processor monitor job
 D START^VDEFMON
 Q
 ;
MONCHKO ; Start the VDEF job to monitor checked out requests
 N ARR,ERR,FDA,ZTDESC,ZTDTH,ZTIO,ZTPRI,ZTRTN,ZTSK
 ;
 ; Check the status of the last VDEF Monitor task.
 D GETS^DIQ(579.5,"1,",".01;.02;.06","I","ARR","ERR")
 ; Don't start a new one if old one is scheduled.
 S ZTSK=+$G(ARR(579.5,"1,",.06,"I")) D STAT^%ZTLOAD
 I ZTSK(1)=1 Q
 ;
 ; Schedule a new task.
 S ZTRTN="MONITOR^VDEFCONT",ZTDESC="VDEF Checked Out Monitor"
 ;
 ; Calculate when to run the VDEF Monitor next time
 S ZTDTH=$$FUTURE^VDEFUTIL($G(ARR(579.5,"1,",.02,"I")))
 S (ZTPRI,ZTIO)=""
 D ^%ZTLOAD
 ;
 ; Check that TaskMan successfully queued up the Monitor task
 I '$G(ZTSK) D ALERT^VDEFUTIL("VDEF CHECKED OUT MONITOR FAILED TO START. CHECK ERROR TRAP.")
 ;
 ; File the task number of the task that has been queued up
 I $G(ZTSK) S FDA(1,579.5,"1,",.06)=ZTSK D FILE^DIE("","FDA(1)","ERR(1)")
 Q
 ;
MONITOR ; VDEF monitor task, executed on a schedule determined by queue
 ; parameter 'CHECK OUT TIME LIMIT'. Checks for potentially hung
 ; 'Checked Out' entries in the Request Queues
 ;
 N QIEN S (ZTSTOP,QIEN)=0
 F  S QIEN=$O(^VDEFHL7(579.3,"C","C",QIEN)) Q:'QIEN  D  Q:ZTSTOP
 . N IEN,LIMIT,QUEUE,QUEUENAM,QUIT
 . ;
 . ; Retrieve queue data
 . D GETS^DIQ(579.3,QIEN_",",".01;.04;.05","I","QUEUE","ERR")
 . S QUEUENAM=$G(QUEUE(579.3,QIEN_",",.01,"I"))
 . ;
 . ; Check-out Time Limit in seconds
 . S LIMIT=$G(QUEUE(579.3,QIEN_",",.05,"I"))
 . ;
 . ; Get a list of currently Checked-out Requests in this queue
 . S IEN=0 F  S IEN=$O(^VDEFHL7(579.3,"C","C",QIEN,IEN)) Q:'IEN  D  Q:ZTSTOP
 .. S ZTSTOP=$$S^%ZTLOAD() Q:ZTSTOP
 .. N CHECKOUT,ENTRY,ERR,FDA
 .. ;
 .. ; Get the related data for the request
 .. D GETS^DIQ(579.31,IEN_","_QIEN_",",".01;.02;.09;.15","I","ENTRY","ERR")
 .. ;
 .. ; Quit if Vista HL7 IRM already notified or if status is not "C"
 .. Q:$G(ENTRY(579.31,IEN_","_QIEN_",",.15,"I"))'=""
 .. Q:$G(ENTRY(579.31,IEN_","_QIEN_",",.02,"I"))'="C"
 .. ;
 .. ; Get the date when the request was checked out and compare with
 .. ; CHECK OUT TIME LIMIT parameter.
 .. S CHECKOUT=$G(ENTRY(579.31,IEN_","_QIEN_",",.09,"I"))
 .. ;
 .. ; If no checkout time, don't create a false alert.
 .. Q:'CHECKOUT
 .. Q:$$DIFF^VDEFUTIL(CHECKOUT,$H)'>LIMIT
 .. ;
 .. ; Request appears hung. Send a message to the Vista HL7 IRM.
 .. D ALERT^VDEFUTIL("RECORD "_IEN_" IN VDEF QUEUE '"_$E(QUEUENAM,1,35)_"' HUNG IN CHECKED OUT STATUS.")
 .. ;
 .. ; Update the time stamp in the entry so that the VDEF Monitor
 .. ; doesn't notify the Vista HL7 IRM more than once.
 .. L +^VDEFHL7(579.3,QIEN,IEN)
 .. D NOW^%DTC S FDA(1,579.31,IEN_","_QIEN_",",.15)=%
 .. D FILE^DIE("","FDA(1)","ERR(1)")
 .. L -^VDEFHL7(579.3,QIEN,IEN)
 .. Q
 ;
 ; Check if TaskMan requested a stop
 I ZTSTOP S X=$$ASKSTOP^%ZTLOAD(ZTSK),ZTREQ="@" Q
 ;
PURGE ; Purge old entries in Request Queues
 S (ZTSTOP,QIEN)=0
 F  S QIEN=$O(^VDEFHL7(579.3,"C","P",QIEN)) Q:'QIEN  D  Q:ZTSTOP
 . N ARCH,IEN,QUEUE,QUIT
 . ; Retrieve queue data
 . D GETS^DIQ(579.3,QIEN_",",".04","I","QUEUE","ERR")
 . ; Retrieve the queue's Archival Parameter (in seconds)
 . S ARCH=$G(QUEUE(579.3,QIEN_",",.04,"I"))
 . ; Initialize the flag that indicates whether the oldest Processed
 . ; entry in a given Request Queue is too recent to be purged
 . S QUIT=0
 . ; Loop through the list of "P"rocesses entries in this Request
 . ; Queue, starting with the oldest
 . F IEN=0:0 S IEN=$O(^VDEFHL7(579.3,"C","P",QIEN,IEN)) Q:'IEN  D  Q:QUIT!ZTSTOP
 .. S ZTSTOP=$$S^%ZTLOAD() Q:ZTSTOP
 .. N DTS,ENTRY,ERR,FDA
 .. ; Get this entry's data
 .. D GETS^DIQ(579.31,IEN_","_QIEN_",",".13","I","ENTRY","ERR")
 .. I $D(ERR) ; Add error processing here
 .. ; Retrieve the DTS when the Request was "P"rocessed
 .. S DTS=$G(ENTRY(579.31,IEN_","_QIEN_",",.13,"I"))
 .. ; Calculate how long it has been since this Request was "P"rocessed
 .. ; and, if the Request is more recent than the Archival Parameter
 .. ; for this Queue, set the "Quit" flag and stop processing the Queue
 .. I $$DIFF^VDEFUTIL(DTS,$H)<ARCH S QUIT=1 Q
 .. ; If we are here, then the entry is older than allowed by the
 .. ; Archival Parameter - purge this entry from the Request Queue
 .. S FDA(1,579.31,IEN_","_QIEN_",",.01)="@"
 .. D FILE^DIE("","FDA(1)","ERR(1)")
 ;
 ; Stop if TaskMan requested
 I ZTSTOP S X=$$ASKSTOP^%ZTLOAD(ZTSK),ZTREQ="@" Q
 ;
 ; Reschedule VDEF checked out monitor
 D MONCHKO
 S ZTREQ="@"
 Q
 ;
REQ(QIEN) ; Start a Request Queue Processor task for a single queue
 ; Try locking the Request Queue - if we fail, then there is 
 ; another Request Processor currently holding the lock, so skip it
 L +^VDEFHL7(579.3,"QUEUE",QIEN):3 Q:'$T
 N ERR,FDA,QNAME,QUEUE,ZTDESC,ZTDTH,ZTIO,ZTPRI,ZTRTN,ZTSAVE,ZTSK
 ; Retrieve queue data
 D GETS^DIQ(579.3,QIEN_",",".01;.02;.07;.08;.09","I","QUEUE","ERR")
 ; If this Request Queue is suspended, quit
 I $G(QUEUE(579.3,QIEN_",",.09,"I"))="S" G REQX
 ; TaskMan task number of the last Request Processor task for this queue
 S ZTSK=+$G(QUEUE(579.3,QIEN_",",.08,"I"))
 ; Check the status of the last Request Processor task
 D STAT^%ZTLOAD
 ; If the task is scheduled to run, then don't submit a new one - this
 ; means that the system is coming back after a restart which occurred
 ; while an old Request Processor task was scheduled for running
 I ZTSK(1)=1 G REQX
 ;
 ; Create TaskMan variables
 S ZTRTN="EN^VDEFREQ",(ZTIO,ZTPRI)=""
 S QNAME=$G(QUEUE(579.3,QIEN_",",.01,"I"))
 S ZTDESC="VDEF Request Processor for "_QNAME
 S ZTSAVE("QIEN")=QIEN,ZTDTH=$H
 D ^%ZTLOAD
 ; Check that TaskMan created the task.
 I '$G(ZTSK) D ALERT^VDEFUTIL("VDEF REQUEST PROCESS "_$E(QNAME,1,20)_" FAILED TO START. CHECK ERROR TRAP.")
 ; File the task number of the task that has been queued up
 I $G(ZTSK) D
 . S FDA(1,579.3,QIEN_",",.08)=ZTSK
 . D FILE^DIE("","FDA(1)","ERR(1)")
REQX L -^VDEFHL7(579.3,"QUEUE",QIEN)
 Q

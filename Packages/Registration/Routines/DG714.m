DG714 ;ALB/GAH - Deceased Patient Means Test Cleanup ; 18-SEP-2006 15:41
 ;;5.3;Registration;**714**;14-AUG-2006;Build 5
 ;
 ; This program will loop through all veterans on the system that
 ; have means tests.  For those people that are deceased, their last
 ; means test will be deleted if it has a status of REQUIRED.
 ; 
 ; ^XTMP("DG714",0,0)=DELRECS^DFNLST^STATUS^STARTTM^ENDTIME^TOTRECS
 ;    where   DELRECS = Number of patients that had means tests deleted
 ;            DFNLST  = Last record number examined
 ;            STATUS  = RUNNING   - Job is still processing
 ;                      COMPLETED - Job processed all records
 ;                      STOPPED   - Job was stopped before completion
 ;            STARTTM = Date/Time when job was started in FM format
 ;            ENDTIME = Date/Time when job stopped or completed in FM format
 ;            TOTRECS = Total number of record examined
 ;
 ; ^XTMP("DG714",1,"TASK")=ZTSK
 ;    where   ZTSK    = Taskman task number
 ;
 ; ^XTMP("DG714",1,"STOP")=ZTSTOP
 ;    where   ZTSTOP    = 1 to stop the job
 ;
 ; ^XTMP("DG714","TEST")=""
 ;    This node is set to send mail to a test account during testing
 ;    It will not be set in production
 ;
 ; Must be run from line tag
 Q
 ;
START ;Start process
 N NAMSPC,TASK,U
 S U="^"
 S NAMSPC=$$NAMSPC
 S TASK=$P($G(^XTMP(NAMSPC,1,"TASK")),U,3)
 Q:TASK&$$ACTIVE(TASK)   ; Quit if already running
 D QUEUE($$QTIME)
 Q
QUEUE(ZTDTH)    ; Queue the process
 N NAMSPC,ZTRTN,ZTDESC,ZTIO,ZTSK
 S NAMSPC=$$NAMSPC
 S ZTRTN="QUE^"_NAMSPC
 S ZTDESC=NAMSPC_" - Remove REQUIRED MT for deceased patients"
 S ZTIO=""
 D ^%ZTLOAD
 K ^XTMP(NAMSPC,1,"TASK")
 I '$D(ZTSK) S ^XTMP(NAMSPC,1,"TASK")="Unable to queue post-install process."
 I $D(ZTSK) S ^XTMP(NAMSPC,1,"TASK")=$G(ZTSK)
 D HOME^%ZIS
 Q
QTIME() ; Get the run time for queuing
 N %,%H,%I,X
 D NOW^%DTC
 Q $P(%,".")_"."_$E($P(%,".",2),1,4)
 ;
TEST(START,END,PROCESS) ;Entry point for testing
 ; There is a range given so no need for the old data in ^XTMP
 K ^XTMP($$NAMSPC,0)
 S START=+START
 ; START is the first record to be processed so prime it for $O
 I START'=0 S START=$O(^DGMT(408.31,"AID",1,START),-1)
 I END'="" S END=$O(^DGMT(408.31,"AID",1,END))
 S TESTING=1
 D QUE
 Q
QUE    ;
 N ZTSTOP,X,U,NAMSPC,COMPLETE
 S U="^"
 S NAMSPC=$$NAMSPC
 I '$D(TESTING) N TESTING S TESTING=0
 S X=$$SETUPX(90)
 S X=$G(^XTMP(NAMSPC,0,0))
 S $P(X,U,3)="RUNNING"
 S $P(X,U,4)=$$NOW^XLFDT
 S ^XTMP(NAMSPC,0,0)=X
 ;
 S ZTSTOP=$$CLEAN(TESTING)
 S X=$G(^XTMP(NAMSPC,0,0))
 S $P(X,U,3)=$S(ZTSTOP:"STOPPED",1:"COMPLETED")
 S $P(X,U,5)=$$NOW^XLFDT
 S ^XTMP(NAMSPC,0,0)=X
 D MAIL($P(X,U,4),$P(X,U,5),$P(X,U),$P(X,U,6),'ZTSTOP)
 K TESTING,^XTMP(NAMSPC,1)
 L -^XTMP(NAMSPC)
 Q
SETUPX(EXPDAYS) ;
 ; requires EXPDAYS - number of days to keep XTMP around
 N BEGTIME,PURGDT,NAMSPC,U
 S U="^"
 S NAMSPC=$$NAMSPC
 S BEGTIME=$$NOW^XLFDT()
 S PURGDT=$$FMADD^XLFDT(BEGTIME,EXPDAYS)
 S ^XTMP(NAMSPC,0)=PURGDT_U_BEGTIME
 S $P(^XTMP(NAMSPC,0),U,3)="MEANS TEST DATE OF DEATH CLEANUP"
 Q 1
STOP()     ;returns stop flag
 N ZTSTOP,U,X,NAMSPC
 S U="^"
 S NAMSPC=$$NAMSPC
 S ZTSTOP=0
 ; Check to see if the job is set to stop either manually
 ; or through Taskman
 I $$S^%ZTLOAD!$G(^XTMP(NAMSPC,1,"STOP")) D
 . K ^XTMP(NAMSPC,1,"STOP")
 . S ZTSTOP=1
 Q ZTSTOP
ACTIVE(ZTSK)    ;check if job is running, stopped, or complete
 N NAMSPC,STAT,Y
 S NAMSPC=$$NAMSPC
 S ZTSK=+$G(^XTMP(NAMSPC,1,"TASK"))
 D STAT^%ZTLOAD
 S Y=ZTSK(1)
 I Y=0 S STAT=-1
 I ",1,2,4,"[(","_Y_",") S STAT=1
 I ",3,5,"[(","_Y_",") S STAT=0
 ; If the job is not active but the status is running, change status to
 ; STOPPED
 I $P($G(^XTMP(NAMSPC,0,0)),U,3)="RUNNING",STAT'>0 S $P(^XTMP(NAMSPC,0,0),U,3)="STOPPED"
 Q STAT
 ;
NAMSPC() ;
 Q $T(+0)
CLEAN(TESTING) ; Loop through veterans to compare data
 N CRF,DATA,DFN,DGMTI,NAMSPC,DELRECS,HIT,REC11,REC12,REC132,STARTTM,STATUS,TOTRECS,U,ZTSTOP
 S NAMSPC=$$NAMSPC
 S U="^"
 S (DELRECS,ZTSTOP)=0
 S STARTTM=$$NOW^XLFDT
 S DATA=^XTMP(NAMSPC,0,0)
 I 'TESTING S END="",DFN=0
 I TESTING S DFN=START   ;If testing, get range
 N STOP
 S STOP=0
 K ^XTMP(NAMSPC,"TEST","AUDIT")
 ;
 ; Loop through the means test cross reference
 F TOTRECS=0:1 S DFN=$O(^DGMT(408.31,"AID",1,DFN)) D  Q:ZTSTOP!STOP
 . I DFN=END!(DFN'?1.N.1(1"."1.N)) S STOP=1 Q
 . ; Keep track of the last DFN processes
 . S $P(^XTMP(NAMSPC,0,0),U,2)=DFN
 . ; Check that there is a date of death and that the last means test
 . ; has a status of REQUIRED
 . S $P(^XTMP(NAMSPC,0,0),U,2)=DFN
 . S HIT=0
 . F  Q:'$$OK2DEL^DGMTDELS(DFN,.DGMTI)  D
 . . S HIT=1
 . . ; Save the audit info if testing
 . . I TESTING S ^XTMP(NAMSPC,"TEST","AUDIT",DFN)=DGMTI
 . . ; Delete the means test
 . . D:'TESTING!(TESTING&$G(PROCESS)) DELMT^DGMTDELS(DGMTI)
 . ; Check to see if the job has been signalled to stop
 . I TOTRECS,TOTRECS#1000=0 S ZTSTOP=$$STOP
 . S:HIT DELRECS=DELRECS+1  ;increment new record counter if means test deleted
 ;
 I TESTING S ^XTMP(NAMSPC,"TEST","TOT")="PROCESSED:"_TOTRECS_"  DELETED:"_DELRECS
 ; Do some recordkeeping
 S DATA=^XTMP(NAMSPC,0,0)
 S $P(DATA,U,1)=DELRECS
 S $P(DATA,U,4)=STARTTM
 S $P(DATA,U,6)=TOTRECS
 S ^XTMP(NAMSPC,0,0)=DATA
 Q ZTSTOP
MAIL(STARTTM,ENDTIME,DELRECS,TOTRECS,COMPLETE)  ; Send mail message
 N XMDUZ,XMY,XMSUB,XMTEXT
 S NAMSPC=$$NAMSPC
 S U="^"
 ; Set FROM duz
 S XMDUZ=.5
 ; Send completion message to developer
 S XMY(DUZ)=""
 S XMSUB="DG MEANS TEST DATE OF DEATH CLEANUP"
 I COMPLETE D
 . S ^TMP(NAMSPC,$J,"MSG",0)=6
 . S ^TMP(NAMSPC,$J,"MSG",1)="   Means Test Date of Death Cleanup"
 . S ^TMP(NAMSPC,$J,"MSG",2)=""
 . S ^TMP(NAMSPC,$J,"MSG",3)="      Started at: "_$TR($$FMTE^XLFDT(STARTTM,2),"@"," ")
 . S ^TMP(NAMSPC,$J,"MSG",4)="    Completed at: "_$TR($$FMTE^XLFDT(ENDTIME,2),"@"," ")
 . S ^TMP(NAMSPC,$J,"MSG",5)="Records Examined: "_TOTRECS
 . S ^TMP(NAMSPC,$J,"MSG",6)=" Records Deleted: "_DELRECS
 . S XMTEXT="^TMP(NAMSPC,$J,""MSG"","
 I 'COMPLETE D
 . S ^TMP(NAMSPC,$J,"MSG",0)=8
 . S ^TMP(NAMSPC,$J,"MSG",1)="        Means Test Date of Death Cleanup"
 . S ^TMP(NAMSPC,$J,"MSG",2)="          ***Processing not complete***"
 . S ^TMP(NAMSPC,$J,"MSG",3)=""
 . S ^TMP(NAMSPC,$J,"MSG",4)="           Started at: "_$TR($$FMTE^XLFDT(STARTTM,2),"@"," ")
 . S ^TMP(NAMSPC,$J,"MSG",5)="           Stopped at: "_$TR($$FMTE^XLFDT(ENDTIME,2),"@"," ")
 . S ^TMP(NAMSPC,$J,"MSG",6)="     Records Examined: "_TOTRECS
 . S ^TMP(NAMSPC,$J,"MSG",7)="      Records Deleted: "_DELRECS
 . S ^TMP(NAMSPC,$J,"MSG",8)="Last Record Processed: "_$P($G(^XTMP(NAMSPC,0,0)),U,2)
 . S XMTEXT="^TMP(NAMSPC,$J,""MSG"","
 D ^XMD
 K ^TMP(NAMSPC)
 Q

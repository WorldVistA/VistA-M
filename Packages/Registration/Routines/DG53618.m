DG53618 ;ALB/GN/PHH,EG - DG*5.3*618 CLEANUP DANGLING RECS; 04/27/2005
 ;;5.3;Registration;**618**;Aug 13, 1993
 ;
 ; Cleans up dangling file Income Relation file #408.12 records where
 ; it points to bad or non-existent Income Person file #408.13 and
 ; Patient file #2 records.
 ;
 ; 1. If it points to file 2, that doesn't exist or has a bad 0 node,
 ;     delete the 408.12 rec that points to the bad 2 rec, then
 ;     delete the 408.21 that points to 408.12 rec, then
 ;     delete the 408.22 rec that points to the 408.21.
 ; 2. Same logic will be used if points to bad 408.13 recs
 ;
 Q
 ;
POST ;post install entry tag call.  processes entire file in live mode
 N ZTDTH,ZTDESC,ZTIO,ZTRTN,ZTSK,ZTQUEUED,ZTSAVE,CHKPNT
 D MES^XPDUTL("")
 D MES^XPDUTL("=====================================================")
 D MES^XPDUTL("Queuing Bad Patient Relation Pointers cleanup process.....")
 I $$CHKSTAT(1) D  Q
 . D BMES^XPDUTL("ABORTING  Post Install Cleanup Queuing")
 . D MES^XPDUTL("=====================================================")
 . Q
 S ZTRTN="QUE^DG53618"
 S ZTDESC="Cleanup Bad Pointers In Patient Relation File"
 S ZTIO="",ZTDTH=$H
 S CHKPNT=0,ZTSAVE("CHKPNT")=""
 D ^%ZTLOAD
 D MES^XPDUTL("This request queued as Task # "_ZTSK)
 D MES^XPDUTL("=====================================================")
 D MES^XPDUTL("")
 Q
 ;
TEST ; Entry point for taskman (testing mode)
 N TESTING,ZTQUEUED
 S TESTING=1,ZTQUEUED=0
 ;if running again, check to see if complete
 ;if so, ask user to rerun
 I $$CHKSTAT(0) D  Q
 . U 0 W !,"Task is already running or user opted to not restart"
 . Q
 D QUE
 Q
QUE ; Entry point for taskman (live mode)
 N NAMSPC S NAMSPC=$$NAMSPC^DG53618
 N QQ,ZTSTOP,XREC,MTIEN,DIK,DA,DGTOT,DGDEL12,BEGTIME,PURGDT,DGDEL21
 N TMP,ICDT,COUNT,TYPE,TYPNAM,DGDEL22,REC12,REC21,REC22
 N DGBAD03,DGBADPAT,DGBADPER
 N R12,PT,DFN,X,U
 S U="^"
 I '$D(TESTING) N TESTING S TESTING=0
 I '$D(ZTQUEUED) N ZTQUEUED S ZTQUEUED=1
 ;
 ;get last run info if exists
 S XREC=$G(^XTMP(NAMSPC,0,0))
 S R12=+$P(XREC,U,1)              ;last REC processed
 S DGTOT=+$P(XREC,U,2)            ;total records processed
 S DGDEL12=+$P(XREC,U,3)          ;total bad 408.12 records purged
 S DGDEL21=+$P(XREC,U,7)          ;total bad 408.21 records found
 S DGDEL22=+$P(XREC,U,8)          ;total bad 408.22 records found
 S DGBADPAT=+$P(XREC,U,9)         ;total bad pointer to file #2
 S DGBADPER=+$P(XREC,U,10)        ;total bad pointer to file #408.13
 S DGBAD03=+$P(XREC,U,11)         ;null or bad field # 03
 ;
 ;setup XTMP according to stds.
 D SETUPX(90)
 ;
 ;init status field and start date & time if null
 S $P(^XTMP(NAMSPC,0,0),U,5,6)="RUNNING^"
 S:$P(^XTMP(NAMSPC,0,0),U,4)="" $P(^XTMP(NAMSPC,0,0),U,4)=$$NOW^XLFDT
 ;
 ;drive through 408.12 looking for bad variable pointers
 S ZTSTOP=0
 F QQ=1:1 S R12=$O(^DGPR(408.12,R12)) Q:(R12'>0)!ZTSTOP  D
 . ;check for stop request after every 20 processed DFN recs
 . I QQ#20=0 D
 . . S:$$S^%ZTLOAD ZTSTOP=1
 . . I $D(^XTMP(NAMSPC,0,"STOP")) S ZTSTOP=1 K ^XTMP(NAMSPC,0,"STOP")
 . . Q
 . I ZTSTOP Q
 . S DGTOT=DGTOT+1
 . S $P(^XTMP(NAMSPC,0,0),U,1,2)=R12_U_DGTOT
 . ;
 . S DFN=$$GET1^DIQ(408.12,R12_",",.01,"I")
 . S PT=$$GET1^DIQ(408.12,R12_",",.03,"I")
 . ;
 . ;good patient (#.01),good variable pointer (#.03)...quit
 . I $$GOODPAT(DFN)="Y",$$GOODPTR(PT)="Y" Q
 . ;
 . ; cleanup Income Relation file #408.12 & the bad pointed to file
 . ; either Patient file #2 or Income Person file #408.13
 . I 'ZTQUEUED W !!,"File #408.12, ien ",R12," has a bad pointer to "
 . ;if patient (#.01) is null
 . I DFN="" D
 . . S X="null patient (field #.01)"
 . . I 'ZTQUEUED W X
 . . S ^XTMP(NAMSPC,"BADPR",R12,"ERR",1)=X
 . . S DGBADPAT=DGBADPAT+1
 . . D ACHK03(R12,PT,ZTQUEUED,TESTING,.DGBADPAT,.DGBADPER,.DGBAD03)
 . . Q
 . ;patient #.01 not found
 . I DFN'="",$$GOODPAT(DFN)="N" D
 . . S X="patient "_DFN_" (field #.01)"
 . . I 'ZTQUEUED W X
 . . S ^XTMP(NAMSPC,"BADPR",R12,"ERR",1)=X
 . . S DGBADPAT=DGBADPAT+1
 . . ;I 'TESTING S DA=DFN,DIK="^DPT(" D ^DIK
 . . D ACHK03(R12,PT,ZTQUEUED,TESTING,.DGBADPAT,.DGBADPER,.DGBAD03)
 . . Q
 . ;patient (#.03) is also a patient, is bad, but patient (# .01) is ok
 . I $$GOODPAT(DFN)="Y",PT["DPT",$$GOODPTR(PT)="N" D
 . . S X="patient "_$P(PT,";",1)_" (field #.03)"
 . . I 'ZTQUEUED W X
 . . S ^XTMP(NAMSPC,"BADPR",R12,"ERR",1)=X
 . . S DGBADPAT=DGBADPAT+1
 . . ;I 'TESTING S DA=$P(PT,";",1),DIK="^DPT(" D ^DIK
 . . Q
 . ;patient (#.01) is good, but income person is bad
 . I $$GOODPAT(DFN)="Y",PT["DGPR",$$GOODPTR(PT)="N" D
 . . S X="income person "_$P(PT,";",1)_" (field #.03)"
 . . I 'ZTQUEUED W X
 . . S ^XTMP(NAMSPC,"BADPR",R12,"ERR",1)=X
 . . S DGBADPER=DGBADPER+1
 . . I 'TESTING S DA=$P(PT,";",1),DIK="^DGPR(408.13," D ^DIK
 . . Q
 . ;patient #.01 is good, but #.03 is null
 . I $$GOODPAT(DFN)="Y",PT="" D
 . . S X="null field #.03"
 . . I 'ZTQUEUED W X
 . . S ^XTMP(NAMSPC,"BADPR",R12,"ERR",1)=X
 . . S DGBAD03=DGBAD03+1
 . . Q
 . ;patient #.01 is good, but #.03 is not null
 . ;and is bad
 . I $$GOODPAT(DFN)="Y",PT'["DGPR",PT'["DPT",PT'="",$$GOODPTR(PT)="N" D
 . . S X="variable pointer "_$P(PT,";",1)_" (field #.03)"
 . . I 'ZTQUEUED W X
 . . S ^XTMP(NAMSPC,"BADPR",R12,"ERR",1)=X
 . . S DGBAD03=DGBAD03+1
 . . Q
 . D DEL40812(R12,.DGDEL12,.DGDEL21,.DGDEL22,ZTQUEUED,TESTING,NAMSPC)
 . Q
 ;
 ;update last processed info
 S X=$G(^XTMP(NAMSPC,0,0))
 S $P(X,U,3)=DGDEL12,$P(X,U,7)=DGDEL21
 S $P(X,U,8)=DGDEL22,$P(X,U,9)=DGBADPAT
 S $P(X,U,10)=DGBADPER,$P(X,U,11)=DGBAD03
 S ^XTMP(NAMSPC,0,0)=X
 ;set status and mail stats
 I ZTSTOP S $P(^XTMP(NAMSPC,0,0),U,5,6)="STOPPED"_U_$$NOW^XLFDT
 E  S $P(^XTMP(NAMSPC,0,0),U,5,6)="COMPLETED"_U_$$NOW^XLFDT
 S X=$$MAIL^DG53618M(TESTING)
 K TESTING
 L -^XTMP($$NAMSPC)
 Q
 ;
GOODPAT(DFN) ;determine if patient is there
 N X,U
 S U="^"
 I DFN="" Q "N"
 I '$D(^DPT(DFN,0)) Q "N"
 S X=$G(^DPT(DFN,0)) I X="" Q "N"
 I X?13"^".E Q "N"
 Q "Y"
 ;
GOODPTR(PT) ;determine if reference is there
 N X,U,SUB,GL,REF
 S U="^"
 I PT'["DPT",PT'["DGPR" Q "N"
 S SUB=$P(PT,";",1),GL=$P(PT,";",2)
 I SUB="" Q "N"
 I SUB'=+SUB S SUB=$C(34)_SUB_$C(34)
 I GL'="DPT(",GL'="DGPR(408.13," Q "N"
 S REF="^"_GL_SUB_",0)"
 S X=$G(@REF)
 I '$D(@REF) Q "N"
 I $G(GL)["DPT",X?13"^".E Q "N"
 I $G(GL)["DGPR",$P(X,U,1)="" Q "N"
 Q "Y"
 ;
 ;at this point, you have a bad .01 field, but want
 ;to check .03 also
ACHK03(R12,PT,ZTQUEUED,TESTING,DGBADPAT,DGBADPER,DGBAD03) ;
 ;update counters to include bad variable pointers
 ;bad pointer to patient
 I PT["DPT",$$GOODPTR(PT)="N" D  Q
 . S DGBADPAT=DGBADPAT+1
 . S X="and bad patient pointer "_$P(PT,";",1)_" (field #.03)"
 . I 'ZTQUEUED W !,"     ",X
 . S ^XTMP(NAMSPC,"BADPR",R12,"ERR",2)=X
 . ;I 'TESTING S DA=$P(PT,";",1),DIK="^DPT(" D ^DIK
 . Q
 ;bad pointer to income person
 I PT["DGPR",$$GOODPTR(PT)="N" D  Q
 . S DGBADPER=DGBADPER+1
 . S X="and bad income person pointer "_$P(PT,";",1)_" (field #.03)"
 . I 'ZTQUEUED W !,"    ",X
 . S ^XTMP(NAMSPC,"BADPR",R12,"ERR",2)=X
 . I 'TESTING S DA=$P(PT,";",1),DIK="^DGPR(408.13," D ^DIK
 . Q
 ;null variable pointer
 I PT="" D  Q
 . S X="and null pointer (field #.03)"
 . I 'ZTQUEUED W !,"     ",X
 . S DGBAD03=DGBAD03+1
 . S ^XTMP(NAMSPC,"BADPR",R12,"ERR",2)=X
 . Q
 ;bad variable pointer
 I $$GOODPTR(PT)="N" D
 . S X="and bad variable pointer "_$P(PT,";",1)_" (field #.03)"
 . I 'ZTQUEUED W !,"     ",X
 . S DGBAD03=DGBAD03+1
 . S ^XTMP(NAMSPC,"BADPR",R12,"ERR",2)=X
 . Q
 Q
 ;
DEL40812(R12,DGDEL12,DGDEL21,DGDEL22,ZTQUEUED,TESTING,NAMSPC) ;
 ; Kill bad #408.12 file rec and files that point to it
 N DA,DIK,R21,R22,X
 S DA=R12,DIK="^DGPR(408.12," D ^DIK:'TESTING
 S DGDEL12=DGDEL12+1
 I 'ZTQUEUED W !,?2,"Deleting 408.12 ien > ",R12
 ;
 ;kill all 408.21's that point to the bad 408.12
 S R21=0
 F  S R21=$O(^DGMT(408.21,"C",R12,R21)) Q:'R21  D
 . I 'TESTING S DA=R21,DIK="^DGMT(408.21," D ^DIK
 . S DGDEL21=DGDEL21+1
 . S X="Deleting related ien "_R21_" in file #408.21"
 . I 'ZTQUEUED W !,?4,X
 . S ^XTMP(NAMSPC,"BADPR",R12,"REL",R21)=X
 . ;
 . ;kill all 408.22's that point to the bad 408.21
 . S R22=0
 . F  S R22=$O(^DGMT(408.22,"AIND",R21,R22)) Q:'R22  D
 . . I 'TESTING S DA=R22,DIK="^DGMT(408.22," D ^DIK
 . . S DGDEL22=DGDEL22+1
 . . S X="Deleting related ien "_R22_" in file # 408.22"
 . . I 'ZTQUEUED W !,?6,X
 . . S ^XTMP(NAMSPC,"BADPR",R12,"REL",R21,R22)=X
 . . Q
 . Q
 Q
 ;
CHKSTAT(POST) ;
 N Y,DUOUT,DTOUT,QUIT,STAT,STIME,NAMSPC
 S QUIT=0
 S NAMSPC=$$NAMSPC
 L +^XTMP(NAMSPC):1
 I '$T D BMES^XPDUTL("*** ALREADY RUNNING ***") Q 1
 ;
 ; get job status
 S STAT=$P($G(^XTMP(NAMSPC,0,0)),U,5)
 S STIME=$P($G(^XTMP(NAMSPC,0,0)),U,6)
 ;
 I POST D KILIT Q 0
 ;
 ;if job Completed and run from menu opt, ask to Re-Run
 I STAT="COMPLETED" D
 . W " was Completed on "_$$FMTE^XLFDT(STIME)
 . W !,"  Do you want to Re-Run again?"
 . K DIR
 . S DIR("?",1)="  Entering Y, will delete the XTMP global where theprevious cleanup"
 . S DIR("?")="  information was stored and begin a new job, or N to cancel request"
 . S DIR(0)="Y" D ^DIR
 . I 'Y S QUIT=1 Q
 . W !," ARE YOU SURE?"
 . K DIR
 . S DIR("?")="Enter Y to begin a new Job or N to cancel request"
 . S DIR(0)="Y" D ^DIR
 . I 'Y S QUIT=1 Q
 . ;fall thru to re-run mode, kill ^XTMPs
 . D KILIT
 . Q
 Q QUIT
 ;
KILIT ; kill Xtmp work file for a re-run
 S:'$D(NAMSPC) NAMSPC=$$NAMSPC^DG53618
 K ^XTMP(NAMSPC)
 Q
 ;
STOP ; alternate stop method
 S ^XTMP($$NAMSPC,0,"STOP")=""
 Q
 ;
SETUPX(EXPDAY) ;Setup XTMP
 N BEGTIME,PURGDT,NAMSPC,U
 S U="^"
 S NAMSPC=$$NAMSPC^DG53618
 S BEGTIME=$$NOW^XLFDT()
 S PURGDT=$$FMADD^XLFDT(BEGTIME,EXPDAY)
 S ^XTMP(NAMSPC,0)=PURGDT_U_BEGTIME
 S $P(^XTMP(NAMSPC,0),U,3)="Cleanup Bad Pointers In PATIENT RELATION File"
 Q
 ;
NAMSPC() ; Return a consistent name space variable
 Q $T(+0)

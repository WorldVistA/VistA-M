DG53558 ;ALB/GN - DG*5.3*558 CLEANUP FOR DUPE MEANS TEST FILE ; 8/15/08 12:27pm
 ;;5.3;Registration;**558,579,688**;Aug 13, 1993;Build 29
 ;
 ; Read through the Mean Test file (#408.31) via the "C" xref.
 ; Search for duplicate & Bad tests and delete them.  Duplicates are
 ; defined as more than one test for the same patient for the same day
 ; and the same status.  All dupes but the primary test will be
 ; deleted and when no primary test on a given day then the last
 ; transmission for that day will be kept
 ;
 ; Bad tests are defined as those that have a NULL status code in
 ; the 0 node of file 408.31.
 ;
 ; DG*5.3*579 - changes were made to fix a problem when future dated
 ; tests come in and flip a test from Primary to Non-Primary.  This
 ; should not be done for IVM converted cases.  This patch will
 ; find those IVM tests and flip them back to Priamry and flip the
 ; future test that caused this back to Non-Primary.
 Q
TEST ; Entry point for testing this routine
 S TESTING=1
EN ;  Entry point for purging Duplicate Means Tests
 ;
 N QUIT,ZTDESC,ZTIO,ZTRTN,ZTSK,ZTQUEUED,ZTSAVE,CHKPNT
 S CHKPNT=5
 W !,"Do you want to process a group of "_CHKPNT_" duplicates and stop? "
 K DIR
 S DIR("?",1)="  Enter Y to process at least "_CHKPNT_" dupes and stop the utility.  This will "
 S DIR("?",2)="  allow you to verify the cleanup in small steps.  Enter N to process the "
 S DIR("?")="  remainder of the file to completion."
 S DIR(0)="Y" D ^DIR
 I $D(DTOUT)!$D(DUOUT) W !,"Cancelled...",! Q
 ;
 S:'Y CHKPNT=0                               ;do not use check points
 ;
 ; setup TM variables and Load 
 S ZTRTN=$S($G(TESTING):"QUET^DG53558",1:"QUE^DG53558")
 S ZTDESC="Cleanup Duplicates in the Means Test file"
 S ZTIO=""
 S ZTSAVE("CHKPNT")=""
 ;
 W !!,ZTDESC,!
 ;check if already running or completed.
 S QUIT=$$CHKSTAT(0)
 Q:QUIT
 D ^%ZTLOAD
 L -^XTMP($$NAMSPC)
 I $D(ZTSK) D
 . W !,"This request queued as Task # ",ZTSK,!
 Q
 ;
POST ;
 N ZTDTH,ZTDESC,ZTIO,ZTRTN,ZTSK,ZTQUEUED,ZTSAVE,CHKPNT
 D MES^XPDUTL("")
 D MES^XPDUTL("=====================================================")
 D MES^XPDUTL("Queuing Dupe Income Test Purge Utility.....")
 I $$CHKSTAT(1) D  Q
 . D BMES^XPDUTL("ABORTING  Post Install Utility Queuing")
 . D MES^XPDUTL("=====================================================")
 S ZTRTN="QUE^DG53558"
 S ZTDESC="Cleanup Duplicates in the Means Test file"
 S ZTIO="",ZTDTH=$H
 S CHKPNT=0,ZTSAVE("CHKPNT")=""
 D ^%ZTLOAD
 L -^XTMP($$NAMSPC)
 D MES^XPDUTL("This request queued as Task # "_ZTSK)
 D MES^XPDUTL("=====================================================")
 D MES^XPDUTL("")
 Q
 ;
QUET ; Entry point for taskman (testing mode)
 S TESTING=1
QUE ; Entry point for taskman (live mode)
 N NAMSPC S NAMSPC=$$NAMSPC^DG53558
 L +^XTMP(NAMSPC):10 I '$T D  Q   ;quit if can't get a lock
 . S $P(^XTMP(NAMSPC,0,0),U,5)="NO LOCK GAINED"
 N QQ,ZTSTOP,XREC,MTIEN,DIK,DA,IVMTOT,IVMPUR,BEGTIME,PURGDT,IVMBAD
 N DFN,TMP,ICDT,MTST,IVMDUPE,COUNT,PRI,TYPE,TYPNAM,DELETED,IVMIEN,PRIM
 N SRCE,TMPIVM,XX,IVMCV,MAX,IVMIEND,IVMPFL,LINK,LTYP,LTNAM,MTVER
 S TESTING=+$G(TESTING)
 ;
 ;get last run info if exists
 S XREC=$G(^XTMP(NAMSPC,0,0))
 S DFN=$P(XREC,U,1)         ;last REC processed
 S IVMTOT=+$P(XREC,U,2)          ;total records processed
 S IVMPUR=+$P(XREC,U,3)          ;total dupe records purged
 S IVMBAD=+$P(XREC,U,7)          ;total bad records purged
 S IVMPFL=+$P(XREC,U,8)          ;total PRIM records fliped
 S IVMDUPE=IVMPUR
 ;
 ;setup XTMP according to stds. & for 60 day expiration
 D SETUPX^DG53558M(60)
 ;
 ;init status field and start date & time if null
 S $P(^XTMP(NAMSPC,0,0),U,5,6)="RUNNING^"
 S:$P(^XTMP(NAMSPC,0,0),U,4)="" $P(^XTMP(NAMSPC,0,0),U,4)=$$NOW^XLFDT
 ;
 ;drive through "C" XREF level of  MT  file
 S ZTSTOP=0,DELETED=0
 F QQ=1:1 S DFN=$O(^DGMT(408.31,"C",DFN)) Q:'DFN  D  Q:ZTSTOP
 . I $G(CHKPNT)>1,IVMPUR>IVMDUPE,IVMPUR-CHKPNT>IVMDUPE S ZTSTOP=1 Q
 . K TMP,TMPIVM
 . S IVMTOT=IVMTOT+1
 . ;
 . ;build local TMP and prioritize dupes
 . S MTIEN=0
 . F  S MTIEN=$O(^DGMT(408.31,"C",DFN,MTIEN)) Q:'MTIEN  D
 . . I '$D(^DGMT(408.31,MTIEN,0)) K ^DGMT(408.31,"C",DFN,MTIEN) Q
 . . S ICDT=$P(^DGMT(408.31,MTIEN,0),"^",1)
 . . S MTST=$P(^DGMT(408.31,MTIEN,0),"^",3)
 . . S PRI=+$G(^DGMT(408.31,MTIEN,"PRIM"))
 . . S SRCE=+$P(^DGMT(408.31,MTIEN,0),"^",23)
 . . S MTVER=+$P($G(^DGMT(408.31,MTIEN,2)),"^",11)
 . . S MAX=0
 . . S:$D(^DGMT(408.31,MTIEN,"C")) MAX=$O(^DGMT(408.31,MTIEN,"C",""),-1)
 . . S IVMCV=0               ;init IVM converted flag to no DG*5.3*579
 . . F XX=1:1:MAX D  Q:IVMCV
 . . . S:^DGMT(408.31,MTIEN,"C",XX,0)["Z06 MT via Edb" IVMCV=1
 . . I SRCE=2,IVMCV D                     ;IVM converted test from EDB
 . . . S TMPIVM(DFN,ICDT,MTST)=MTIEN,TMPIVM(DFN,ICDT)=MTIEN
 . . . S PRI=1                            ;set as PRIMARY
 . . ;
 . . ;test for null MT status & flag as BAD and delete
 . . I MTST="" D  Q
 . . . S TYPE=$P($G(^DGMT(408.31,MTIEN,0)),"^",19),TYPNAM=""
 . . . S:TYPE]"" TYPNAM=$G(^DG(408.33,TYPE,0))
 . . . D DELBAD(MTIEN,DFN,.IVMBAD,.DELETED)
 . . . Q:'DELETED
 . . . S ^XTMP(NAMSPC,DFN,ICDT,MTVER,999999,MTIEN,"BAD")=TYPE
 . . . S ^XTMP(NAMSPC_".DET",DFN,ICDT,MTVER,MTIEN,"BAD")=TYPNAM
 . . . S $P(^XTMP(NAMSPC,0,0),U,7)=IVMBAD
 . . ;
 . . S COUNT=+$G(TMP(DFN,ICDT,MTST))+1
 . . S TMP(DFN,ICDT,MTVER,MTST)=COUNT
 . . S TMP(DFN,ICDT,MTVER,MTST,MTIEN)=PRI
 . . S:PRI TMP(DFN,ICDT,MTVER,MTST,"P")=MTIEN
 . ;
 . D CLNDUPS^DG53558N(DFN)
 . ;update last processed info
 . S $P(^XTMP(NAMSPC,0,0),U,1,3)=DFN_U_IVMTOT_U_IVMPUR
 . S $P(^XTMP(NAMSPC,0,0),U,7,8)=IVMBAD_U_IVMPFL
 . ;
 . ;check for stop request after every 100 processed DFN recs
 . I QQ#100=0 D
 . . S:$$S^%ZTLOAD ZTSTOP=1
 . . I $D(^XTMP(NAMSPC,0,"STOP")) S ZTSTOP=1 K ^XTMP(NAMSPC,0,"STOP")
 ;
 ;set status and mail stats
 I ZTSTOP S $P(^XTMP(NAMSPC,0,0),U,5,6)="STOPPED"_U_$$NOW^XLFDT
 E  S $P(^XTMP(NAMSPC,0,0),U,5,6)="COMPLETED"_U_$$NOW^XLFDT
 D MAIL^DG53558M
 K TESTING
 L -^XTMP($$NAMSPC)
 Q
 ;
 ;DG*5.3*579 released SETPRIM and 688 moved it to DG53558M
 ;
DELBAD(IEN,DFN,PUR,DELETED) ; Kill Bad test
 S DELETED=0
 Q:'$G(IEN)
 S TESTING=+$G(TESTING,1),DFN=$G(DFN)
 I 'TESTING S DELETED=$$DEL^DG53558M(IEN,.LINK,DFN)
 S:TESTING DELETED=1
 Q:'DELETED
 S IVMBAD=IVMBAD+1
 I '$D(ZTQUEUED) W !,"Deleting BAD IEN in 408.31 > ",IEN," for DFN > ",DFN
 Q
 ;
CHKSTAT(POST) ;check if job is running, stopped, or completed
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
 I POST D KILIT Q 0                                     ;DG*5.3*579
 ;
 ;if job Completed and run from menu opt, ask to Re-Run
 I STAT="COMPLETED" D
 . W " was Completed on "_$$FMTE^XLFDT(STIME)
 . W !,"  Do you want to Re-Run again?"
 . K DIR
 . S DIR("?",1)="  Entering Y, will delete the XTMP global where the previous cleanup"
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
 Q QUIT
 ;
KILIT ; kill Xtmp work files for a re-run
 S:'$D(NAMSPC) NAMSPC=$$NAMSPC^DG53558
 K ^XTMP(NAMSPC),^XTMP(NAMSPC_".DET")
 Q
 ;
STOP ; alternate stop method
 S ^XTMP($$NAMSPC,0,"STOP")=""
 Q
 ;
NAMSPC() ; Return a consistent name space variable
 Q "DG53558"

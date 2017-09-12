DG53591 ;ALB/GN - DG*5.3*591 CLEANUP FOR OVERLAYED INCOME TEST THRESHOLD AND STATUS; 3/17/04 12:26pm ; 7/29/04 11:33am
 ;;5.3;Registration;**591**;Aug 13, 1993
 Q
 ;
SITETEST ; Site test Entry tag.  Allows incremental testing in live mode
 N QUIT,ZTDESC,ZTIO,ZTRTN,ZTSK,ZTQUEUED,ZTSAVE,CHKPNT
 S CHKPNT=3
 W !,"Do you want to process the next "_CHKPNT_" bad tests and stop for review? "
 K DIR
 S DIR("?",1)="  Enter Y to process the next "_CHKPNT_" bad tests it finds and stop the utility."
 S DIR("?",2)="  This will allow you to verify the cleanup in small steps.  Enter N to process"
 S DIR("?")="  the remainder of the file to completion."
 S DIR(0)="Y" D ^DIR
 I $D(DTOUT)!$D(DUOUT) W !,"Cancelled...",! Q
 ;
 S:'Y CHKPNT=0                               ;do not use check points
 ;
 ; setup TM variables and Load 
 S ZTRTN=$S($G(TESTING):"TEST^DG53591",1:"QUE^DG53591")
 S ZTDESC="Cleanup Bad Thresholds in the Means Test file"
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
POST ;post install entry tag call.  processes entire file in live mode
 I +$G(XPDQUES("POS1"))=0 D  Q
 . D MES^XPDUTL("")
 . D MES^XPDUTL("==================================================")
 . D MES^XPDUTL(" POST INSTALL ABORTED AND WAS NOT SENT TO TASKMAN")
 . D MES^XPDUTL("==================================================")
 . D MES^XPDUTL("")
 N ZTDTH,ZTDESC,ZTIO,ZTRTN,ZTSK,ZTQUEUED,ZTSAVE,CHKPNT
 D MES^XPDUTL("")
 D MES^XPDUTL("=====================================================")
 D MES^XPDUTL("Queuing Bad Income Threshold Test Purge Utility.....")
 I $$CHKSTAT(1) D  Q
 . D BMES^XPDUTL("ABORTING  Post Install Utility Queuing")
 . D MES^XPDUTL("=====================================================")
 S ZTRTN="QUE^DG53591"
 S ZTDESC="Cleanup Bad Thresholds in the Means Test file"
 S ZTIO="",ZTDTH=$H
 S CHKPNT=0,ZTSAVE("CHKPNT")=""
 D ^%ZTLOAD
 L -^XTMP($$NAMSPC)
 D MES^XPDUTL("This request queued as Task # "_ZTSK)
 D MES^XPDUTL("=====================================================")
 D MES^XPDUTL("")
 D EN^DG53591C                        ;restore eff date recs in error
 D POST^DG53591A                      ;link 2nd cleanup to start later
 Q
 ;
TEST ; Entry point for taskman (testing mode)
 S TESTING=1
QUE ; Entry point for taskman (live mode)
 N NAMSPC S NAMSPC=$$NAMSPC^DG53591
 L +^XTMP(NAMSPC):10 I '$T D  Q   ;quit if can't get a lock
 . S $P(^XTMP(NAMSPC,0,0),U,5)="NO LOCK GAINED"
 N QQ,ZTSTOP,XREC,MTIEN,DIK,DA,IVMTOT,IVMPUR,BEGTIME,PURGDT,IVMBAD
 N DFN,TMP,ICDT,MTST,IVMDUPE,COUNT,PRI,TYPE,TYPNAM,IVMIEN,PRIM
 N BADYR,FOUND,GOODIEN,SRCE,TMPIVM,XX,IVMCV,MAX,IVMIEND,LINKB,LINKG
 N MTDT,R40831,THRS,YEAR,YRIEN
 S TESTING=+$G(TESTING)
 ;
 ;get last run info if exists
 S XREC=$G(^XTMP(NAMSPC,0,0))
 S DFN=$P(XREC,U,1)         ;last REC processed
 S IVMTOT=+$P(XREC,U,2)          ;total records processed
 S IVMPUR=+$P(XREC,U,3)          ;total bad records purged
 S IVMBAD=+$P(XREC,U,7)          ;total bad records found
 ;
 ;setup XTMP according to stds.
 D SETUPX(30)
 ;
 ;init status field and start date & time if null
 S $P(^XTMP(NAMSPC,0,0),U,5,6)="RUNNING^"
 S:$P(^XTMP(NAMSPC,0,0),U,4)="" $P(^XTMP(NAMSPC,0,0),U,4)=$$NOW^XLFDT
 ;
 ;drive through 408.31 looking for bad threshold values per INCYR
 S ZTSTOP=0
 F QQ=1:1 S DFN=$O(^DGMT(408.31,"C",DFN)) Q:'DFN  D  Q:ZTSTOP
 . S MTIEN=""
 . K TMP S FOUND=0
 . F  S MTIEN=$O(^DGMT(408.31,"C",DFN,MTIEN),-1) Q:MTIEN=""  D  Q:ZTSTOP!(FOUND)
 . . S IVMTOT=IVMTOT+1                            ;tot ien's processed
 . . Q:'$D(^DGMT(408.31,MTIEN,0))                 ;bad 0 node, quit
 . . Q:$E(+$G(^DGMT(408.31,MTIEN,0)),1,3)<303     ;skip < 2003
 . . S R40831=^DGMT(408.31,MTIEN,0)
 . . S MTDT=+R40831 Q:$L(MTDT)'=7                 ;bad MT date, quit
 . . S TYPE=$P(R40831,"^",19) Q:TYPE>1            ;not a MT, quit
 . . S THRS=+$P(R40831,"^",12)                    ;get MT threshold
 . . Q:'THRS                                      ;thrs. not > 0, quit
 . . S YEAR=$E(MTDT,1,3)_"0000"                   ;build MT thrs. year
 . . ;
 . . ;find and save the bad year & IEN, also save related good year
 . . ;quit when the first good ien is found
 . . I THRS'=$P($G(^DG(43,1,"MT",YEAR,0)),"^",2) D
 . . . S TMP(NAMSPC,DFN,"BAD",YEAR,MTIEN)=^DGMT(408.31,MTIEN,0)
 . . . S BADYR=YEAR
 . . . S IVMBAD=IVMBAD+1
 . . E  D
 . . . I $D(TMP(NAMSPC,DFN,"BAD",YEAR)) D
 . . . . S TMP(NAMSPC,DFN,"GOOD",YEAR,MTIEN)=^DGMT(408.31,MTIEN,0)
 . . . . S FOUND=1
 . ;
 . ;cleanup, delete any bad tests that also have a corresponding good
 . ;test for that same Income year, then re-transmit that year to HEC
 . S YEAR=0
 . F  S YEAR=$O(TMP(NAMSPC,DFN,"BAD",YEAR)) Q:'YEAR  D
 . . ;if no Good MT found, then cleanup and quit
 . . I '$D(TMP(NAMSPC,DFN,"GOOD",YEAR)) K TMP(NAMSPC,DFN,"BAD",YEAR) Q
 . . S MTIEN=""
 . . F  S MTIEN=$O(TMP(NAMSPC,DFN,"BAD",YEAR,MTIEN)) Q:MTIEN=""  D
 . . . ;
 . . . ;if Good MT exists for year then delete Bad MT
 . . . S GOODIEN=$O(TMP(NAMSPC,DFN,"GOOD",YEAR,0))
 . . . D:GOODIEN]"" SETPRIM(GOODIEN,1)                  ;insure a PRIM
 . . . D DELMT(MTIEN,DFN,.IVMPUR)                       ;del MT
 . . . ;
 . . . ;if a linked RXCT see if it needs to be deleted or re-pointed
 . . . S LINKB=$P($G(^DGMT(408.31,MTIEN,2)),"^",6)
 . . . ;if bad MT is linked & RX is linked back to bad MT, then relink
 . . . I LINKB,$P($G(^DGMT(408.31,LINKB,2)),"^",6)=MTIEN D LINKED
 . . . ;
 . . . ;set year to be re-transmitted
 . . . S YRIEN=$O(^IVM(301.5,"AYR",YEAR,DFN,0))
 . . . S DATA(.03)=0
 . . . I 'TESTING,$$UPD^DGENDBS(301.5,YRIEN,.DATA)
 . ;
 . ;update last processed info
 . S $P(^XTMP(NAMSPC,0,0),U,1,3)=DFN_U_IVMTOT_U_IVMPUR
 . S $P(^XTMP(NAMSPC,0,0),U,7)=IVMBAD
 . M ^XTMP(NAMSPC)=TMP(NAMSPC)
 . ;
 . ;check for stop request after every 20 processed DFN recs
 . I QQ#20=0 D
 . . S:$$S^%ZTLOAD ZTSTOP=1
 . . I $D(^XTMP(NAMSPC,0,"STOP")) S ZTSTOP=1 K ^XTMP(NAMSPC,0,"STOP")
 ;
 ;set status and mail stats
 I ZTSTOP S $P(^XTMP(NAMSPC,0,0),U,5,6)="STOPPED"_U_$$NOW^XLFDT
 E  S $P(^XTMP(NAMSPC,0,0),U,5,6)="COMPLETED"_U_$$NOW^XLFDT
 D MAIL^DG53591M
 K TESTING
 L -^XTMP($$NAMSPC)
 Q
 ;
LINKED ;Resolve the linked RX tests to a bad MT
 S LINKG=$P($G(^DGMT(408.31,GOODIEN,2)),"^",6)
 ;
 ;if the Good MT is linked
 I LINKG D
 . ;good MT not linked to the same RX as the Bad MT, then delete 
 . ;the bad linked RX
 . I LINKG'=LINKB D
 . . D DELMT(LINKB,DFN,.IVMPUR)
 . . S TMP(NAMSPC,DFN,"DELLNK",YEAR,LINKB)=^DGMT(408.31,LINKB,0)
 . ;
 . ;else both MT point to same RX, then point RX back to Good MT
 . E  D
 . . D REPOINT(LINKB,GOODIEN)
 . . S TMP(NAMSPC,DFN,"PNTLNK",YEAR,LINKB)=^DGMT(408.31,LINKB,0)
 ;
 ;else save RX and point to Good MT & point Good MT back to RX
 E  D
 . D REPOINT(LINKB,GOODIEN)
 . S TMP(NAMSPC,DFN,"PNTLNK",YEAR,LINKB)=^DGMT(408.31,LINKB,0)
 Q
 ;
DELMT(IEN,DFN,PUR,BAD) ; delete 408.31 ien only, no income related files
 Q:'$G(IEN)
 N DA,DIK
 S TESTING=+$G(TESTING,1),DFN=$G(DFN)
 ;
 S DA=IEN,DIK="^DGMT(408.31," D:'TESTING ^DIK        ;del MT here
 S PUR=PUR+1
 S BAD(IEN)=""
 W:'$D(ZTQUEUED) !,"Deleting Bad IEN in 408.31 > ",IEN," for DFN > ",DFN
 ;
 Q
 ;
REPOINT(LINK,MT) ;  repoint a linked RXCT to MT and vice versa
 Q:'$G(LINK)!('$G(MT))
 N DATA
 S TESTING=+$G(TESTING,1)
 S DATA(2.06)=MT
 I 'TESTING,$$UPD^DGENDBS(408.31,LINK,.DATA)
 I $$UPD^DGENDBS(408.31,LINK,.DATA)
 W:'$D(ZTQUEUED) !,"Point RXCT in 408.31 > ",LINK," to Good MT > ",MT
 S DATA(2.06)=LINK
 I 'TESTING,$$UPD^DGENDBS(408.31,MT,.DATA)
 I $$UPD^DGENDBS(408.31,MT,.DATA)
 W:'$D(ZTQUEUED) !,"Point Good MT in 408.31 > ",MT," to RXCT > ",LINK
 ;
 Q
 ;
SETPRIM(DA,PR) ; set an Income Test (in #408.31) to Prim or Not
 ; Input: DA= ien in 408.31 to set "PRIM" node
 ;        PR= what to set PRIM node to; 0 or 1
 Q:'$D(DA)
 Q:'$D(PR)
 Q:PR=$G(^DGMT(408.31,DA,"PRIM"))
 N DR,DIE
 S DR="2////"_PR,DIE="^DGMT(408.31,"
 D:'$G(TESTING) ^DIE
 D ^DIE
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
 I POST D KILIT Q 0
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
KILIT ; kill Xtmp work file for a re-run
 S:'$D(NAMSPC) NAMSPC=$$NAMSPC^DG53591
 K ^XTMP(NAMSPC)
 Q
 ;
STOP ; alternate stop method
 S ^XTMP($$NAMSPC,0,"STOP")=""
 Q
 ;
SETUPX(EXPDAY) ;Setup XTMP according to standards and set expiration days
 N BEGTIME,PURGDT,NAMSPC
 S NAMSPC=$$NAMSPC^DG53591
 S BEGTIME=$$NOW^XLFDT()
 S PURGDT=$$FMADD^XLFDT(BEGTIME,EXPDAY)
 S ^XTMP(NAMSPC,0)=PURGDT_U_BEGTIME
 S $P(^XTMP(NAMSPC,0),U,3)="Cleanup Bad Thresholds in the Means Test File"
 Q
 ;
NAMSPC() ; Return a consistent name space variable
 Q $T(+0)

DG488 ;ALB/GN - CLEANUP PATIENT RELATION & INCOME FILES;12/11/02 ; 2/4/03 1:25pm
 ;;5.3;REGISTRATION;**488**;5-1-2001
 ;
 Q
 ;
TEST ; Entry point for testing this routine, then fall thru.
 S TESTING=1
EN ; Entry point to start job
 ;
 N QUIT,ZTDESC,ZTIO,ZTRTN,ZTSK,ZTQUEUED,ZTSAVE
 ;
 S TESTING=+$G(TESTING)
 ; setup TM variables and Load 
 S ZTSAVE("TESTING")=""
 S ZTRTN=("TASK^DG488")
 S ZTDESC="Cleanup Patient Relation & Income Files"
 S ZTIO=""
 W !!,ZTDESC,!
 ;
 ;check if already running or completed.
 S QUIT=$$CHKSTAT
 I QUIT L -^XTMP($$NAMSPC) K TESTING Q
 D ^%ZTLOAD
 L -^XTMP($$NAMSPC)
 K TESTING
 I $D(ZTSK) D
 . W !,"This request queued as Task # ",ZTSK,!
 Q
 ;
TASK ; Entry point for taskman
 L +^XTMP($$NAMSPC):10 I '$T D  Q   ;quit if can't get a lock
 . S $P(^XTMP($$NAMSPC,0,0),U,12)="NO LOCK GAINED"
 N ZTSTOP,LSTREC,DIK,DA,NAMSPC,DGT12,DG12,DG12X,DGT22,DG22,DG22X
 N BEGTIME,PURGDT,DGFIL,IEN,DGIEN,BTIME,STAT,STIME,DGT21,DG21,DG21X
 S NAMSPC=$$NAMSPC
 S ZTDESC=$G(ZTDESC,"Cleanup of Patient Related Income files")
 ;
 S TESTING=$G(TESTING,1)        ;assume testing if not defined
 ;setup XTMP according to stds.
 S BEGTIME=$$NOW^XLFDT()
 S PURGDT=$$FMADD^XLFDT(BEGTIME,30)
 S ^XTMP(NAMSPC,0)=PURGDT_U_BEGTIME_U_ZTDESC
 S ^XTMP(NAMSPC,0,"TASKID")=$G(ZTSK,"DIRECT")
 S ^XTMP(NAMSPC,0,"TESTING")=TESTING
 ;get last run data
 D GETLAST
 ;init begin time, if not there, and status & stop time fields
 S $P(^XTMP(NAMSPC,0,0),U,12,13)="RUNNING^"
 S:$P(^XTMP(NAMSPC,0,0),U,11)="" $P(^XTMP(NAMSPC,0,0),U,11)=$$NOW^XLFDT
 ;start/restart cleanups
 S:DGFIL="" DGFIL=408.12
 I DGFIL=408.12 D
 . S IEN=DGIEN,DGIEN=0
 . D DG40812(IEN)
 . S:'ZTSTOP DGFIL=408.21       ;continue if stop not requested
 I DGFIL=408.21 D
 . S IEN=DGIEN,DGIEN=0
 . D DG40821(IEN)
 . S:'ZTSTOP DGFIL=408.22       ;continue if stop not requested
 I DGFIL=408.22 D
 . S IEN=DGIEN
 . D DG40822(IEN)
 ;
 ;set status and mail stats
 I ZTSTOP S $P(^XTMP(NAMSPC,0,0),U,12,13)="STOPPED"_U_$$NOW^XLFDT
 E  S $P(^XTMP(NAMSPC,0,0),U,12,13)="COMPLETED"_U_$$NOW^XLFDT
 D MAIL^DG488M
 L -^XTMP(NAMSPC)
 K TESTING
 Q
 ;
DG40812(IEN) ; Main Cleanup driver for file 408.12
 N REC12 S ZTSTOP=0
 F  S IEN=$O(^DGPR(408.12,"B",IEN)) Q:('IEN)!(ZTSTOP)  D
 . S REC12=0
 . F  S REC12=$O(^DGPR(408.12,"B",IEN,REC12)) Q:('REC12)!(ZTSTOP)  D
 . . S DGT12=DGT12+1
 . . ;
 . . ;if bad xref then kill the xref, else check for damaged 0 node
 . . I '$D(^DGPR(408.12,REC12)) D
 . . . S ^XTMP(NAMSPC,408.12,"B",IEN,REC12)=""
 . . . I 'TESTING K ^DGPR(408.12,"B",IEN,REC12)
 . . . S DG12X=DG12X+1
 . . E  D
 . . . Q:+$P(^DGPR(408.12,REC12,0),U,3)      ;quit if piece 3 is there
 . . . M ^XTMP(NAMSPC,"408.12",REC12)=^DGPR(408.12,REC12)
 . . . D DEL40821(REC12,.DG21,.DG21X)
 . . . ;
 . . . ;delete bad 408.12
 . . . S DIK="^DGPR(408.12,",DA=REC12
 . . . I 'TESTING D ^DIK
 . . . K DIK,DA
 . . . S DG12=DG12+1
 . . ;
 . . ;check for stop request after every 100 processed recs
 . . I DGT12#100=0 D
 . . . S:$$S^%ZTLOAD ZTSTOP=1
 . . . I $D(^XTMP(NAMSPC,0,"STOP")) S ZTSTOP=1 K ^XTMP(NAMSPC,0,"STOP")
 . . S LSTREC=DGFIL_"/"_IEN
 . . S $P(^XTMP(NAMSPC,0,0),U,1)=LSTREC
 . . S $P(^XTMP(NAMSPC,0,0),U,2,6)=DGT12_U_DG12_U_DG12X_U_DGT22_U_DG22
 . . S $P(^XTMP(NAMSPC,0,0),U,9,10)=DG21_U_DG21X
 Q
 ;
DEL40821(R12,DG21,DG21X) ; Delete any entries in 408.21 that point to the bad
 ;                 408.12 record.
 N REC21 S REC21=0
 F  S REC21=$O(^DGMT(408.21,"C",R12,REC21)) Q:'REC21  D
 . ;if bad xref then kill the xref, else kill the real record
 . I '$D(^DGMT(408.21,REC21)) D
 . . S ^XTMP(NAMSPC,408.21,"C",R12,REC21)=""
 . . I 'TESTING K ^DGMT(408.21,"C",R12,REC21)
 . . S DG21X=DG21X+1
 . E  D
 . . M ^XTMP(NAMSPC,"408.21",REC21)=^DGMT(408.21,REC21)
 . . D DG22AIND(REC21)
 . . S DIK="^DGMT(408.21,",DA=REC21
 . . I 'TESTING D ^DIK
 . . K DIK,DA
 . . S DG21=DG21+1
 Q
 ;
DG22AIND(R21) ;Delete any entries in 408.22 that is pointing to the bad 408.21
 N REC22 S REC22=0
 F  S REC22=$O(^DGMT(408.22,"AIND",R21,REC22)) Q:'REC22  D
 . S DGT22=DGT22+1
 . ;if bad xref then kill the xref, else kill the real record
 . I '$D(^DGMT(408.22,REC22)) D
 . . I 'TESTING K ^DGMT(408.22,"AIND",R21,REC22)
 . . S DG22=DG22+1
 . E  D
 . . M ^XTMP(NAMSPC,"408.22",REC22)=^DGMT(408.22,REC22)
 . . S DIK="^DGMT(408.22,",DA=REC22
 . . I 'TESTING D ^DIK
 . . K DIK,DA
 . . S DG22=DG22+1
 Q
 ;
DG40821(IEN) ; Main Cleanup driver for file 408.21, If 408.21 not pointed to
 ; by any 408.22 record, then delete it and check 408.12 for possible
 ; deletion as well.
 N REC21 S ZTSTOP=0
 F  S IEN=$O(^DGMT(408.21,"B",IEN)) Q:('IEN)!(ZTSTOP)  D
 . S REC21=0
 . F  S REC21=$O(^DGMT(408.21,"B",IEN,REC21)) Q:('REC21)!(ZTSTOP)  D
 . . S DGT21=DGT21+1
 . . ;if bad xref then kill the xref, else check for damaged 0 node
 . . I '$D(^DGMT(408.21,REC21)) D
 . . . S ^XTMP(NAMSPC,408.21,"B",IEN,REC21)=""
 . . . I 'TESTING K ^DGMT(408.21,"B",IEN,REC21)
 . . . S DG21X=DG21X+1
 . . E  D
 . . . Q:$D(^DGMT(408.22,"AIND",REC21))     ;quit if 408.21 pointed to
 . . . M ^XTMP(NAMSPC,"408.21",REC21)=^DGMT(408.21,REC21)
 . . . S REC12=0
 . . . D DEL21(REC21,.REC12,.DG21)
 . . . D:REC12 CHK40812(REC12,REC21,.DG12)
 . . ;
 . . ;check for stop request after every 100 processed recs
 . . I DGT21#100=0 D
 . . . S:$$S^%ZTLOAD ZTSTOP=1
 . . . I $D(^XTMP(NAMSPC,0,"STOP")) S ZTSTOP=1 K ^XTMP(NAMSPC,0,"STOP")
 . . S LSTREC=DGFIL_"/"_IEN
 . . S $P(^XTMP(NAMSPC,0,0),U,1)=LSTREC
 . . S $P(^XTMP(NAMSPC,0,0),U,3)=DG12
 . . S $P(^XTMP(NAMSPC,0,0),U,8,10)=DGT21_U_DG21_U_DG21X
 Q
 ;
DEL21(R21,R12,DG21) ; save to Xtmp & associated REC12, then delete the 408.21
 Q:'$D(^DGMT(408.21,R21))
 M ^XTMP(NAMSPC,"408.21",R21)=^DGMT(408.21,R21)
 S R12=+$P($G(^DGMT(408.21,R21,0)),U,2)
 S DIK="^DGMT(408.21,",DA=R21
 I 'TESTING D ^DIK
 K DIK,DA
 S DG21=DG21+1
 Q
 ;
CHK40812(R12,R21,DG12) ; delete 408.12's if no other 408.21's pointing to it
 N XX,OK,REC21 S (REC21,OK)=0
 F XX=0:1 S REC21=$O(^DGMT(408.21,"C",R12,REC21)) Q:'REC21  D
 . S:REC21=R21 OK=1
 Q:XX>1                 ;quit if other 408.21's are pointing to 408.12
 Q:(XX=1)&('OK)         ;quit if only one rec and not the correct one
 ;
 M ^XTMP(NAMSPC,"408.12",R12)=^DGPR(408.12,R12)
 S DIK="^DGPR(408.12,",DA=R12
 I 'TESTING D ^DIK
 K DIK,DA
 S DG12=DG12+1
 Q
 ;
DG40822(IEN) ; Main Cleanup driver for file 408.22
 N REC22 S ZTSTOP=0
 F  S IEN=$O(^DGMT(408.22,"B",IEN)) Q:('IEN)!(ZTSTOP)  D
 . S REC22=0
 . F  S REC22=$O(^DGMT(408.22,"B",IEN,REC22)) Q:('REC22)!(ZTSTOP)  D
 . . S DGT22=DGT22+1
 . . ;
 . . ;if bad xref then kill the xref, else check for damaged 0 node
 . . I '$D(^DGMT(408.22,REC22)) D
 . . . S ^XTMP(NAMSPC,"408.22","B",IEN,REC22)=""
 . . . I 'TESTING K ^DGMT(408.22,"B",IEN,REC22)
 . . . S DG22X=DG22X+1
 . . E  D
 . . . Q:+$P(^DGMT(408.22,REC22,0),U,2)      ;quit if piece 2 is there
 . . . ;save & delete bad 408.22 rec
 . . . M ^XTMP(NAMSPC,"408.22",REC22)=^DGMT(408.22,REC22)
 . . . S DIK="^DGMT(408.22,",DA=REC22
 . . . I 'TESTING D ^DIK
 . . . K DIK,DA
 . . . S DG22=DG22+1
 . . ;
 . . ;check for stop request after every 100 processed recs
 . . I DGT22#100=0 D
 . . . S:$$S^%ZTLOAD ZTSTOP=1
 . . . I $D(^XTMP(NAMSPC,0,"STOP")) S ZTSTOP=1 K ^XTMP(NAMSPC,0,"STOP")
 . . S LSTREC=DGFIL_"/"_IEN
 . . S $P(^XTMP(NAMSPC,0,0),U,1)=LSTREC
 . . S $P(^XTMP(NAMSPC,0,0),U,5,7)=DGT22_U_DG22_U_DG22X
 Q
 ;
CHKSTAT() ;check if job is running, stopped, or completed
 N Y,DUOUT,DTOUT,QUIT,NAMSPC
 S QUIT=0
 S NAMSPC=$$NAMSPC
 L +^XTMP(NAMSPC):1
 I '$T W !!,*7,"*** ALREADY RUNNING ***" H 4 Q 1
 ;
 ; get current mode
 N TESTMODE S TESTMODE=$G(^XTMP(NAMSPC,0,"TESTING"))
 ; get job status
 S STAT=$P($G(^XTMP(NAMSPC,0,0)),U,12)
 S STIME=$P($G(^XTMP(NAMSPC,0,0)),U,13)
 Q:STAT="" QUIT
 ;
 ;if job Completed or trying to resume in Live mode when previously
 ;incompleted in Test mode,  ask to Re-Run
 I STAT="COMPLETED" D
 . D MSG(.QUIT)
 E  D
 . I ('TESTING&TESTMODE)!(TESTING&'TESTMODE) D MSG(.QUIT)
 Q QUIT
 ;
GETLAST ;get last run info
 S DGFIL=$P($G(^XTMP(NAMSPC,0,0)),"/")      ;file
 S DGIEN=+$P($G(^XTMP(NAMSPC,0,0)),"/",2)   ;ien
 S DGT12=+$P($G(^XTMP(NAMSPC,0,0)),U,2)     ;tot 408.12 recs processed
 S DG12=+$P($G(^XTMP(NAMSPC,0,0)),U,3)      ;tot 408.12 recs purged
 S DG12X=+$P($G(^XTMP(NAMSPC,0,0)),U,4)     ;tot bad 408.12 "B" purged
 S DGT22=+$P($G(^XTMP(NAMSPC,0,0)),U,5)     ;tot 408.22 recs processed
 S DG22=+$P($G(^XTMP(NAMSPC,0,0)),U,6)      ;tot 408.22 recs purged
 S DG22X=+$P($G(^XTMP(NAMSPC,0,0)),U,7)     ;tot bad 408.22 "B" purged
 S DGT21=+$P($G(^XTMP(NAMSPC,0,0)),U,8)     ;tot 408.21 recs processed
 S DG21=+$P($G(^XTMP(NAMSPC,0,0)),U,9)      ;tot 408.21 recs purged
 S DG21X=+$P($G(^XTMP(NAMSPC,0,0)),U,10)    ;tot bad 408.21 "C" purged
 S BTIME=$P($G(^XTMP(NAMSPC,0,0)),U,11)     ;begin time
 S STAT=$P($G(^XTMP(NAMSPC,0,0)),U,12)      ;status
 S STIME=$P($G(^XTMP(NAMSPC,0,0)),U,13)     ;stop time
 Q
 ;
MSG(QUIT) ;print message to user
 W " was "_STAT_" on "_$$FMTE^XLFDT(STIME)
 W " in "_$S(TESTMODE:"TEST",1:"LIVE")_" mode "
 W !,"  Do you want to Re-Run in "_$S(TESTING:"TEST",1:"LIVE")
 W " mode?"
 K DIR
 S DIR("?",1)="  Entering Y, will delete the XTMP global where the previous cleanup"
 S DIR("?")="  information was stored and begin a new job, or N to cancel request"
 S DIR(0)="Y" D ^DIR
 I 'Y S QUIT=1 Q
 W !," ARE YOU SURE?"
 K DIR
 S DIR("?")="Enter Y to begin a new Job or N to cancel request"
 S DIR(0)="Y" D ^DIR
 I 'Y S QUIT=1 Q
 ;fall thru to re-run mode, kill ^XTMP
 K ^XTMP(NAMSPC)
 Q
 ;
STOP ; alternate stop method
 S ^XTMP($$NAMSPC,0,"STOP")=""
 Q
NAMSPC() ;
 Q "DG*5.3*488"

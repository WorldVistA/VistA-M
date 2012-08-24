DG53829P ; ALB/LBD - DG*5.3*829 POST INSTALL CLEAN-UP ROUTINE ; 4/11/11 9:37am
 ;;5.3;Registration;**829**;Aug 13, 1993;Build 4
 ;
EN ; Entry point for post installation routine DG*5.3*829
 N ZTDESC,ZTDTH,ZTRTN,ZTSK,ZTIO
 S ZTRTN="CLUP^DG53829P"
 S ZTDESC="DG*5.3*829 Clean Up Merged Pt Recs in File #38.5"
 S ZTIO="",ZTDTH=$$NOW^XLFDT
 D ^%ZTLOAD
 D BMES^XPDUTL("Clean Up Merged Patient Recs in File #38.5 started - task #"_$G(ZTSK))
 Q
 ;
CLUP ; entry for deleting merged patient records from the
 ; INCONSISTENT DATA file (#38.5)
 N DGNOW,DGCNT,DGREC,DFN,Z
 I '$D(^XTMP("DG53829")) D
 . S ^XTMP("DG53829",0)=$$FMADD^XLFDT(DT,180)_U_DT_U_"CLEAN UP MERGED PATIENT RECS IN FILE #38.5",^XTMP("DG53829","PARAMS")=""
 S Z=$G(^XTMP("DG53829","PARAMS"))
 I $P(Z,U,4)="RUNNING" D  Q
 . S DGNOW=$O(^XTMP("DG53829","RUNNING",""))
 . D BULL(,,DGNOW,"RUNNING")
 . S ^XTMP("DG53829","RUNNING",$$NOW^XLFDT)="CLEANUP ALREADY RUNNING"
 I $P(Z,U,4)="DONE" D  Q
 . S DGNOW=$O(^XTMP("DG53829","RUNNING",""))
 . D BULL(,,DGNOW,"DONE")
 . S ^XTMP("DG53829","RUNNING",$$NOW^XLFDT)="CLEANUP ALREADY COMPLETED"
 S $P(^XTMP("DG53829","PARAMS"),U,4)="RUNNING"
 S DGNOW=$$NOW^XLFDT,^XTMP("DG53829","RUNNING",DGNOW)="",^XTMP("DG53829","RUNNING",DGNOW,+$G(ZTSK))=""
 S DGCNT=+Z,DFN=+$P(Z,U,2),DGREC=+$P(Z,U,3)
 ; Loop through the INCONSISTENT DATA file (#38.5)
 F  S DFN=$O(^DGIN(38.5,DFN)) Q:'DFN  Q:$$STOP(DGREC)  D
 . S DGREC=DGREC+1,$P(^XTMP("DG53829","PARAMS"),U,2,3)=DFN_U_DGREC
 . ; If record is pointing to a merged patient in the PATIENT file (#2), delete it
 . I $D(^DPT(DFN,-9)) D
 .. N DA,DIK
 .. S DIK="^DGIN(38.5,",DA=DFN D ^DIK
 .. S DGCNT=DGCNT+1,$P(^XTMP("DG53829","PARAMS"),U,1)=DGCNT
 .. S ^XTMP("DG53829","REC_DELETED",DFN)=""
 S $P(^XTMP("DG53829","PARAMS"),U,4)=$S('$G(ZTSTOP):"DONE",1:"STOPPED"),^XTMP("DG53829","RUNNING",DGNOW)=$$NOW^XLFDT
 D BULL(DGCNT,DGREC,DGNOW,'$G(ZTSTOP))
 Q
 ;
BULL(DELETED,READ,WHEN,DONE) ; Send bulletin
 N LN,TMP,XMDUZ,XMSUB,XMTEXT,XMY
 S XMY(DUZ)="",XMY("G.DGEN ELIGIBILITY ALERT")="",XMDUZ=.5,XMTEXT="TMP("""_"DG53829"_""","
 ; Set up copay test 'links' deleted bulletin
 S XMSUB="DG*5.3*829 - INCONSISTENT DATA FILE CLEANUP RESULTS"
 S LN=1
 S TMP("DG53829",LN)=""
 I DONE="RUNNING" D  Q
 . S LN=LN+1
 . S TMP("DG53829",LN)="Sorry, the INCONSISTENT DATA file (#38.5) clean up is already running."
 . S LN=LN+1
 . S TMP("DG53829",LN)=""
 . S LN=LN+1
 . S TMP("DG53829",LN)="Date/Time Started: "_WHEN
 . S LN=LN+1
 . S TMP("DG53829",LN)=""
 . D ^XMD
 I DONE="DONE" D  Q
 . S LN=LN+1
 . S TMP("DG53829",LN)="Sorry, the INCONSISTENT DATA file (#38.5) clean up has already completed."
 . S LN=LN+1
 . S TMP("DG53829",LN)=""
 . S LN=LN+1
 . S TMP("DG53829",LN)="Date/Time Completed: "_$$FMTE^XLFDT($G(^XTMP("DG53829","RUNNING",WHEN)))
 . D ^XMD
 S LN=LN+1
 S TMP("DG53829",LN)="This message contains the results of the job to clean up records in"
 S LN=LN+1
 S TMP("DG53829",LN)="the INCONSISTENT DATA file (#38.5).  Patient records that pointed to"
 S LN=LN+1
 S TMP("DG53829",LN)="merged patients in the PATIENT file (#2) were deleted."
 S LN=LN+1
 S TMP("DG53829",LN)=""
 S LN=LN+1
 S TMP("DG53829",LN)="The cleanup has "_$S(DONE:"run to completion",1:"finished a partial run")_".  Here are the results"_$S(DONE:"",1:" to date")_":"
 S LN=LN+1
 S TMP("DG53829",LN)=""
 S LN=LN+1
 S TMP("DG53829",LN)="  Start Date/Time: "_$$FMTE^XLFDT(WHEN)
 S LN=LN+1
 S TMP("DG53829",LN)="    End Date/Time: "_$$FMTE^XLFDT($G(^XTMP("DG53829","RUNNING",WHEN)))
 S LN=LN+1
 S TMP("DG53829",LN)=""
 S LN=LN+1
 S TMP("DG53829",LN)="  Total File #38.5 Records Processed: "_READ
 S LN=LN+1
 S TMP("DG53829",LN)="Total Merged Patient Records Deleted: "_DELETED
 S LN=LN+1
 S TMP("DG53829",LN)=""
 S LN=LN+1
 S TMP("DG53829",LN)="Deleted records are referenced in the global ^XTMP("""_"DG53829"_""",""REC_DELETED"""
 S LN=LN+1
 S TMP("DG53829",LN)=""
 D ^XMD
 Q
 ;
STOP(DGREC) ; Check if asked to stop
 ; Only check if tasked and every 1000 records read
 Q:$S('$G(ZTSK):1,1:DGREC#1000) 0
 N X
 S X=$$S^%ZTLOAD
 I X S ZTSTOP=1
 Q $G(ZTSTOP)
 ;
 ;
RESTART ; Restart copay test invalid link
 N ZTDESC,ZTDTH,ZTRTN,ZTSK,ZTIO
 S $P(^XTMP("DG53829","PARAMS"),U,4)=""
 S ZTRTN="CLUP^DG53829P"
 S ZTDESC="DG*5.3*829 Clean Up Merged Pt Recs in File #38.5 Restart"
 S ZTIO="",ZTDTH=$$NOW^XLFDT
 D ^%ZTLOAD
 W !,"TASK # IS: ",$G(ZTSK)
 Q
 ;

DG53661P ; ALB/TK,LBD - DG*5.3*661 POST INSTALL CONVERSION ROUTINE ; 5/18/10 1:11pm
 ;;5.3;Registration;**661**;Aug 13, 1993;Build 5
 ;
EN ; Entry point for post installation routine DG*5.3*661
 N NAMSPC,ZTDESC,ZTDTH,ZTRTN,ZTSK
 S NAMSPC=$$NAMSPC
 S ZTRTN="CTLINKS^DG53661P("""_NAMSPC_""")"
 S ZTDESC="DG*5.3*661 Cleanup Invalid MT/CT Links"
 S ZTIO="",ZTDTH=$$NOW^XLFDT
 D ^%ZTLOAD
 D BMES^XPDUTL("Cleanup Invalid MT/CT Links Process started - task #"_$G(ZTSK))
 Q
 ;
CTLINKS(NAMSPC) ; entry for clearing invalid Rx copay test links
 N CT,CT1,DA,DFN,DIE,DR,IVM,IVMCT,IVMNOW,X,Y,Z
 I '$D(^XTMP(NAMSPC)) D
 . S ^XTMP(NAMSPC,0)=$$FMADD^XLFDT(DT,180)_U_DT_U_"CLEAN UP INVALID MEANS TEST/COPAY TEST LINKS",^XTMP(NAMSPC,"PARAMS")=""
 S Z=$G(^XTMP(NAMSPC,"PARAMS"))
 I $P(Z,U,4)="RUNNING" D  Q
 . S ^XTMP(NAMSPC,"RUNNING",$$NOW^XLFDT)="UPDATE ALREADY RUNNING"
 . D BULL(NAMSPC,,,,"RUNNING")
 I $P(Z,U,4)="DONE" D  Q
 . S ^XTMP(NAMSPC,"RUNNING",$$NOW^XLFDT)="UPDATE ALREADY COMPLETE"
 . D BULL(NAMSPC,,,,"DONE")
 S $P(^XTMP(NAMSPC,"PARAMS"),U,4)="RUNNING"
 S IVMNOW=$$NOW^XLFDT,^XTMP(NAMSPC,"RUNNING",IVMNOW)="",^XTMP(NAMSPC,"RUNNING",IVMNOW,+$G(ZTSK))=""
 S CT=+Z,IVM=+$P(Z,U,2),CT1=+$P(Z,U,3)
 F  S IVM=$O(^DGMT(408.31,IVM)) Q:'IVM  D
 . S IVMCT=$P($G(^DGMT(408.31,IVM,2)),U,6) Q:$$STOP(CT1)  S CT1=CT1+1,$P(^XTMP(NAMSPC,"PARAMS"),U,2,3)=IVM_U_CT1
 . S DFN=+$P($G(^DGMT(408.31,IVM,0)),U,2)
 . I IVMCT D  ; Check for copay test for same income year as means test
 .. ; OK if years match
 .. I $$YR(IVM)=$$YR(IVMCT) Q
 .. ; Delete link to income test in a different income year
 .. S DA=IVM,DIE="^DGMT(408.31,",DR="2.06///@"
 .. D ^DIE
 .. S CT=CT+1,$P(^XTMP(NAMSPC,"PARAMS"),U,1)=CT
 .. S ^XTMP(NAMSPC,"LINK_DELETED",IVM,IVMCT)=""
 S $P(^XTMP(NAMSPC,"PARAMS"),U,4)=$S('$G(ZTSTOP):"DONE",1:"STOPPED"),^XTMP(NAMSPC,"RUNNING",IVMNOW)=$$NOW^XLFDT
 D BULL(NAMSPC,CT,CT1,IVMNOW,'$G(ZTSTOP))
 Q
 ;
BULL(NAMSPC,CHANGED,READ,WHEN,DONE) ; Send bulletin
 N LN,TMP,XMDUZ,XMSUB,XMTEXT,XMY
 S XMY(DUZ)="",XMY("G.DGEN ELIGIBILITY ALERT")="",XMDUZ=.5,XMTEXT="TMP("""_NAMSPC_""","
 ; Set up copay test 'links' deleted bulletin
 S XMSUB=NAMSPC_": COPAY TEST LINK CLEANUP - SUMMARY REPORT"
 S LN=1
 S TMP(NAMSPC,LN)=""
 S LN=LN+1
 S TMP(NAMSPC,LN)="COPAY TEST INVALID LINK UPDATE RESULTS"
 S LN=LN+1
 S TMP(NAMSPC,LN)="--------------------------------------"
 S LN=LN+1
 S TMP(NAMSPC,LN)=""
 I DONE="RUNNING" D  Q
 . S LN=LN+1
 . S TMP(NAMSPC,LN)="Sorry, a copay test link clean up is already running."
 . S LN=LN+1
 . S TMP(NAMSPC,LN)=""
 . D ^XMD
 I DONE="DONE" D  Q
 . S LN=LN+1
 . S TMP(NAMSPC,LN)="Sorry, the copay test link clean up has already completed."
 . S LN=LN+1
 . S TMP(NAMSPC,LN)=""
 . D ^XMD
 S LN=LN+1
 S TMP(NAMSPC,LN)="The cleanup has "_$S(DONE:"run to completion",1:"finished a partial run")_".  Here are the results"_$S(DONE:"",1:" to date")_":"
 S LN=LN+1
 S TMP(NAMSPC,LN)=""
 S LN=LN+1
 S TMP(NAMSPC,LN)="  Start Date/Time: "_$$FMTE^XLFDT(WHEN)
 S LN=LN+1
 S TMP(NAMSPC,LN)="    End Date/Time: "_$$FMTE^XLFDT($G(^XTMP(NAMSPC,"RUNNING",WHEN)))
 S LN=LN+1
 S TMP(NAMSPC,LN)=""
 S LN=LN+1
 S TMP(NAMSPC,LN)="Current Counts: "
 S LN=LN+1
 S TMP(NAMSPC,LN)="  Total File #408.31 Records Processed: "_READ
 S LN=LN+1
 S TMP(NAMSPC,LN)="                 Total Links Corrected: "_CHANGED
 S LN=LN+1
 S TMP(NAMSPC,LN)=""
 S LN=LN+1
 S TMP(NAMSPC,LN)="Cleaned up records are referenced in ^XTMP("""_NAMSPC_""",""LINK_DELETED"" global"
 S LN=LN+1
 S TMP(NAMSPC,LN)=""
 D ^XMD
 Q
 ;
YR(IVM) ; Return year of the means test
 Q $E($P($G(^DGMT(408.31,+IVM,0)),U),1,3)
 ;
STOP(CT1) ; Check if asked to stop
 ; Only check if tasked and every 6000 records read
 Q:$S('$G(ZTSK):1,1:CT1#6000) 0
 N X
 S X=$$S^%ZTLOAD
 I X S ZTSTOP=1
 Q $G(ZTSTOP)
 ;
NAMSPC() ; 
 Q "DG53661"
 ;
CTSTART ; Restart copay test invalid link
 N NAMSPC,ZTDESC,ZTDTH,ZTRTN,ZTSK
 S NAMSPC=$$NAMSPC,$P(^XTMP(NAMSPC,"PARAMS"),U,4)=""
 S ZTRTN="CTLINKS^DG53661P("_NAMSPC_")"
 S ZTDESC="DG*5.3*661 Cleanup Invalid MT/CT Links Process Restart"
 S ZTIO="",ZTDTH=$$NOW^XLFDT
 D ^%ZTLOAD
 W !,"TASK # IS: ",$G(ZTSK)
 Q
 ;

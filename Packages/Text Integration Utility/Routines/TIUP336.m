TIUP336 ;SLC/TDP - Copy/Paste Clean-up of Division ;Jul 29, 2020@10:24:36
 ;;1.0;TEXT INTEGRATION UTILITIES;**336**;Jun 20, 1997;Build 4
 ;ICR
 ;10141-^XPDUTL  ;10063-^%ZTLOAD  ;10090-^DIC(4  ;10103-^XLFDT  ;10015-^DIQ1
 Q
PRE ;pre-init
 Q
 ;
POST ;post-init
 N ZTDTH,ZTIO,ZTSK,ZTRTN,ZTDESC
 D BMES^XPDUTL("Tasking job to search for Copy/Paste data saved to the wrong Division...")
 S ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT,0,0,0,10)
 S ZTRTN="SRCH^TIUP336",ZTDESC="TIU*1*336 Conversion of file #8928 institution pointers"
 S ZTIO=""
 D ^%ZTLOAD
 I +$G(ZTSK)=0 D
 . D BMES^XPDUTL("Unable to queue the file #8928 institution conversion job, file a help desk ticket for assistance.")
 E  D
 . D BMES^XPDUTL("DONE - Task #"_ZTSK)
 Q
 ;
CNVRT(TST) ;Convert Station Numbers stored as Institution IEN pointers
 ; If TST = 1, then print data for conversion but don't actually convert
 ; If TST = 2,
 S TST=+$G(TST)
 I TST=0 S TST=1
 I TST<1,TST>2 D BMES^XPDUTL("Invalid parameter passed in.  Must be a 1 or 2.")
 D BMES^XPDUTL("Searching for Copy/Paste data saved to the wrong Division...")
 D MES^XPDUTL("")
 D SEARCH(TST)
 D MES^XPDUTL("Search completed")
 Q
 ;
SRCH ;Entry point for Post-Init
 D SEARCH(0)
 Q
SEARCH(TST) ;Search for Copy/Paste data stored with wrong division
 N CNT,CNT1,DA,DIC,DIQ,DIV,DIV1,DR,RSLT,STN,STOP,TIUIEN,TMP
 S CNT=0
 S TST=+$G(TST)
 I TST=1 D
 . D MES^XPDUTL("This is a test run! Data Conversion will not occur!")
 . D MES^XPDUTL("")
 S (CNT1,DIV,STOP)=0
 S DIC="^DIC(4," ;Institution file
 S DR="99" ;Station Number
 S DIQ="RSLT(" ;Array to return search
 S DIQ(0)="I" ;Internal value returned
 S TIUIEN=+$P($G(^TIUP(8928,0)),U,3)+1 ;Starting ien to search back to beginning
 I TIUIEN<1 Q
 F  S TIUIEN=$O(^TIUP(8928,TIUIEN),-1) Q:+TIUIEN<1  D  Q:STOP
 . S CNT1=CNT1+1
 . S DIV=$P($G(^TIUP(8928,TIUIEN,0)),U,3) ;Institution IEN stored in Paste data
 . I +DIV<1 Q  ;If not valid quit
 . K RSLT
 . S DA=DIV
 . D EN^DIQ1 ;FileMan call to return Station Number for the Institution IEN (DA)
 . S STN=$G(RSLT(4,DA,99,"I"))
 . I STN="" Q  ;Station Number does not exist
 . I STN'=+STN Q  ;Station Number is not all numerics
 . I DIV=STN Q  ;Station Number is same as ien in the Institution (#4) file
 . S DIV1=$$FIND1^DIC(4,"","X",DIV,"D","","ERR") ;Search for Station Number that matches Institution IEN
 . I +DIV1<1 Q  ;Division IEN does not exist as a Station Number for another institution entry
 . I TST'=1 S $P(^TIUP(8928,TIUIEN,0),U,3)=DIV1 ;Set new Institution ien into Paste data
 . I CNT=0 S TMP=+TIUIEN
 . I TST D
 .. D MES^XPDUTL("   Changed ^TIUP(8928,"_TIUIEN_")")
 .. D MES^XPDUTL("      Paste Date:  "_$$FMTE^XLFDT($P($G(^TIUP(8928,TIUIEN,0)),U,1)))
 .. D MES^XPDUTL("      Old Institution:  "_$P($G(^DIC(4,DIV,0)),U,1)_" ("_DIV_")")
 .. D MES^XPDUTL("      New Institution:  "_$P($G(^DIC(4,DIV1,0)),U,1)_" ("_DIV1_")")
 .. D MES^XPDUTL("")
 . S CNT=CNT+1
 . I '$D(TMP(DIV)) D
 .. S TMP(DIV)=DIV1
 . I '(CNT1#1000) S STOP=$$REQ2STOP()
 I TST D
 . D MES^XPDUTL("   Total Converted Count = "_CNT)
 . D MES^XPDUTL("")
 I $D(TMP(DIV)) D
 . N %H,X,X1,X2
 . ;S X1=DT
 . ;S X2=30
 . ;D C^%DTC
 . S ^XTMP("TIUP336 - Post-Init",0)=$$FMADD^XLFDT(DT,30)_U_DT_U_CNT_" changed institution pointers in file #8928 - "_TMP
 . S DIV=""
 . F  S DIV=$O(TMP(DIV)) Q:DIV=""  D
 .. S DIV1=$G(TMP(DIV))
 .. S ^XTMP("TIUP336 - Post-Init",DIV)=DIV1
 Q
 ;
REVERT ;Task off the Reversion process
 N ZTDTH,ZTIO,ZTSK,ZTRTN,ZTDESC
 S ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT,0,0,0,10)
 S ZTRTN="RVRTJB^TIUP336",ZTDESC="TIU*1*336 Reverting modified #8928 institution pointers"
 S ZTIO=""
 D ^%ZTLOAD
 I +$G(ZTSK)=0 D
 . W !!,"Unable to queue the file #8928 institution reversion job, file a help desk ticket for assistance."
 E  D
 . W !!,"DONE - Task #"_ZTSK
 Q
 ;
RVRTJB ;Reversion Tasked Job entry
 D RVRTJOB(0)
 Q
RVRTJOB(TST) ;Revert changed data back to original value
 N CNT,CNT1,DIV,DIV1,PREVCNT,STOP,TIUIEN,TMP
 D MES^XPDUTL("Reverting previously converted Institution file pointers in file #8928")
 D MES^XPDUTL("")
 S TST=+$G(TST)
 I TST=1 D
 . D MES^XPDUTL("This is a test run! Data Reversion will not occur!")
 . D MES^XPDUTL("")
 S (CNT,CNT1,STOP)=0
 S TIUIEN=$P($G(^XTMP("TIUP336 - Post-Init",0)),"- ",2)+1 ;Starting ien to search back to beginning
 S PREVCNT=+$P($G(^XTMP("TIUP336 - Post-Init",0)),U,3)
 S DIV=0
 F  S DIV=$O(^XTMP("TIUP336 - Post-Init",DIV))  Q:DIV=""  D
 . S DIV1=+$G(^XTMP("TIUP336 - Post-Init",DIV))
 . I +DIV1<1 Q
 . S TMP(DIV1)=DIV
 I '$D(TMP) Q
 I TIUIEN<1 S TIUIEN=+$P($G(^TIUP(8928,0)),U,3)+1
 F  S TIUIEN=$O(^TIUP(8928,TIUIEN),-1) Q:+TIUIEN<1  D  Q:STOP
 . S DIV1=$P($G(^TIUP(8928,TIUIEN,0)),U,3) ;Institution IEN stored in Paste data
 . I '$D(TMP(DIV1)) Q
 . S DIV=$G(TMP(DIV1))
 . I DIV<1 Q
 . I TST'=1 S $P(^TIUP(8928,TIUIEN,0),U,3)=DIV
 . S CNT=CNT+1
 . I TST D
 .. D MES^XPDUTL("   Reverted ^TIUP(8928,"_TIUIEN_")")
 .. D MES^XPDUTL("      Paste Date:  "_$$FMTE^XLFDT($P($G(^TIUP(8928,TIUIEN,0)),U,1)))
 .. D MES^XPDUTL("      Old Institution:  "_$P($G(^DIC(4,DIV1,0)),U,1)_" ("_DIV1_")")
 .. D MES^XPDUTL("      New Institution:  "_$P($G(^DIC(4,DIV,0)),U,1)_" ("_DIV_")")
 .. D MES^XPDUTL("")
 . I '(CNT1#1000) S STOP=$$REQ2STOP()
 I CNT=0 D MES^XPDUTL("     No Institution file pointers were converted in file #8928")
 I TST D
 . D BMES^XPDUTL("   Total Converted Count = "_PREVCNT)
 . D MES^XPDUTL("   Total Reverted Count = "_CNT)
 I 'STOP,TST'=1 K ^XTMP("TIUP336 - Post-Init")
 I 'STOP D BMES^XPDUTL("Reversion complete!")
 I STOP D BMES^XPDUTL("Reversion stopped prematurely!")
 Q
 ;
REQ2STOP() ;
 ; Check for task stop request
 ; Returns 1 if stop request made.
 ; If process was queued/tasked, then ZTQUEUED variable exists
 N STATUS,X
 S STATUS=0
 I '$D(ZTQUEUED) Q 0
 S X=$$S^%ZTLOAD()
 I X D  ;
 . S STATUS=1
 . S X=$$S^%ZTLOAD("Received shutdown request")
 ;
 Q STATUS

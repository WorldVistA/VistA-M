XT73P129 ;OAK/MKO-POST-INSTALL ROUTINE FOR XT*7.3*129 ;25 Jan 2011  10:17 PM
 ;;7.3;TOOLKIT;**129**;Apr 25, 1995;Build 1
 Q
 ;
EN ; **129,MPIC_2382
 ; This entry point is called from the POST-INSTALL of patch XT*7.3*129.
 ; It queues a process to purge File #15 of entries that meet the following criteria:
 ;   - STATUS (Field #.03) = 'P' for POTENTIAL DUPLICATE, UNVERIFIED
 ;   - MERGE STATUS (Field #.05) = 0 or ""
 ;   - WHO CREATED (field #.09) = POSTMASTER (.5)
 D MSG
 D QUEUE Q:$G(XPDABORT)
 Q
 ;
PURGE ; Purge records. This is the entry point for the queued task.
 N PAIR,DA,DIK,X,Y,MSG,XTMPNAME
 ;
 ; Set the header nodes in ^XTMP
 S XTMPNAME=$$SETXTMP
 ;
 ; Loop through records in the "APOT" index for records pertaining to
 ; the Patient file and call ^DIK
 S DIK="^VA(15,"
 S PAIR="" F  S PAIR=$O(^VA(15,"APOT","DPT(",PAIR)) Q:PAIR=""  D
 . S DA=0 F  S DA=$O(^VA(15,"APOT","DPT(",PAIR,DA)) Q:'DA  D
 .. ; Screen on WHO CREATED = .5 (POSTMASTER) AND MERGE STATUS = 0 OR ""
 .. I $D(^VA(15,DA,0))#2,$P(^(0),U,9)=.5,'$P(^(0),U,5) D
 ... ; Record status info in ^XTMP, save 0 node of record
 ... ; and write to console if not queued
 ... N STR
 ... S STR="IEN="_DA_", DFN pair="_PAIR
 ... S @XTMPNAME@(0,"STATUS")="Deleting "_STR
 ... S @XTMPNAME@(DA,0)=$G(^VA(15,DA,0))
 ... W:'$D(ZTQUEUED) !,"Deleting "_STR
 ... ;
 ... ; Delete the record and update count and status
 ... D ^DIK
 ... S @XTMPNAME@(0,"CNT")=$G(@XTMPNAME@(0,"CNT"))+1
 ... S @XTMPNAME@(0,"STATUS")="Deleted "_STR
 ;
 ; Record results in ^XTMP
 S @XTMPNAME@(0,"STATUS")="Completed successfully."
 S @XTMPNAME@(0,"COMPLETED")=$$NOW^XLFDT
 ;
 ; Delete task and send MailMan message if queued.
 ; Write a message if not queued.
 I $D(ZTQUEUED) D
 . S ZTREQ="@"
 . D EMAIL(XTMPNAME)
 E  D
 . W !!,"Process completed successfully, "_@XTMPNAME@(0,"CNT")_" records deleted.",!
 Q
 ;
SETXTMP() ; Set up nodes in ^XTMP("XT73P129")
 ; Return the string ^XTMP("XT73P129",fmStartTime)
 N TSTAMP,XTMPNAME
 S TSTAMP=$$NOW^XLFDT
 S ^XTMP("XT73P129",0)=$$FMADD^XLFDT($$DT^XLFDT,60)_U_TSTAMP_U_"Purge of DUPLICATE RECORD File (#15) of POTENTIAL DUPLICATE, UNVERIFIED patient records created by the POSTMASTER (#.5)"
 S XTMPNAME=$NA(^XTMP("XT73P129",TSTAMP))
 S @XTMPNAME@(0,"CNT")=0
 S @XTMPNAME@(0,"DUZ")=$S($G(XTQUEDUZ)>0:XTQUEDUZ,$G(DUZ)>0:DUZ,1:.5)
 S @XTMPNAME@(0,"STATUS")="Process started."
 S @XTMPNAME@(0,"STARTED")=TSTAMP
 Q XTMPNAME
 ;
QUEUE ; Queue the purging process
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSK,XTQUEDUZ
 S ZTRTN="PURGE^XT73P129"
 S ZTDESC="Purge 'Potential Duplicate, Unverified' patient records from DUPLICATE RECORD File (#15)."
 S ZTDTH=$H
 S ZTIO=""
 S XTQUEDUZ=$S($G(DUZ)>0:DUZ,1:.5),ZTSAVE("XTQUEDUZ")=""
 D ^%ZTLOAD
 I $D(ZTSK)[0 D
 . D BMES^XPDUTL("*** Failed to queue the purging process. Post installation aborted. ***")
 . S:$G(XPDNM)]"" XPDABORT=1
 E  D
 . D BMES^XPDUTL("Purging process queued. Task: "_ZTSK)
 Q
 ;
MSG ; Display/log introductory message
 N MSG
 D ADD(.MSG,"Queuing a TaskMan task to purge records from the DUPLICATE RECORD File (#15)")
 D ADD(.MSG,"that meet the following criteria:")
 D ADD(.MSG,"")
 D ADD(.MSG,"  - STATUS (Field #.03) = 'P' for POTENTIAL DUPLICATE, UNVERIFIED")
 D ADD(.MSG,"  - MERGE STATUS (Field #.05) = 0 or """"")
 D ADD(.MSG,"  - WHO CREATED (field #.09) = POSTMASTER (.5)")
 D ADD(.MSG,"")
 D ADD(.MSG,"The tasked process stores information in the ^XTMP(""XT73P129"") global.")
 D ADD(.MSG,"")
 D ADD(.MSG,"  ^XTMP(""XT73P129"",fmStartTime,IEN,0)         : 0 node of the record deleted")
 D ADD(.MSG,"  ^XTMP(""XT73P129"",fmStartTime,0,""CNT"")       : No. of records deleted")
 D ADD(.MSG,"  ^XTMP(""XT73P129"",fmStartTime,0,""COMPLETED"") : Completion time in FM format")
 D ADD(.MSG,"  ^XTMP(""XT73P129"",fmStartTime,0,""DUZ"")       : DUZ of user")
 D ADD(.MSG,"  ^XTMP(""XT73P129"",fmStartTime,0,""STARTED"")   : Start time in FM format")
 D ADD(.MSG,"  ^XTMP(""XT73P129"",fmStartTime,0,""STATUS"")    : Status information")
 D MES^XPDUTL(.MSG)
 Q
 ;
EMAIL(XTMPNAME) ; Send e-mail with summary information
 N XTQUEDUZ,STATUS,CNT,COMPLETE,START,XMDUZ,XMSUB,XMY,XMTEXT,XMMG,XTTEXT,DIFROM
 ;
 ; Get information from ^XTMP
 S XTQUEDUZ=$G(@XTMPNAME@(0,"DUZ"))
 S STATUS=$G(@XTMPNAME@(0,"STATUS"))
 S CNT=+$G(@XTMPNAME@(0,"CNT"))
 S START=$G(@XTMPNAME@(0,"STARTED"))
 S COMPLETE=$G(@XTMPNAME@(0,"COMPLETED"))
 ;
 ; Build and send an e-mail message to POSTMASTER and user who queued
 ; the process
 S XMDUZ=.5
 S XMSUB="XT*7.3*129 POST-INSTALL COMPLETE"
 S XMY(XTQUEDUZ)=""
 S XMY(.5)=""
 S XMTEXT="XTTEXT("
 D ADD(.XTTEXT,"Post Install for patch XT*7.3*129 has run to completion.")
 D ADD(.XTTEXT,"")
 D ADD(.XTTEXT,"       Time started: "_$$FMTE^XLFDT(START))
 D ADD(.XTTEXT,"     Time completed: "_$$FMTE^XLFDT(COMPLETE))
 D ADD(.XTTEXT,"")
 D ADD(.XTTEXT,CNT_" records were deleted from the DUPLICATE RECORD File (#15).")
 D ADD(.XTTEXT,"")
 D ADD(.XTTEXT,"The 0 nodes of deleted records are backed up in:")
 D ADD(.XTTEXT,"")
 D ADD(.XTTEXT,"  ^XTMP(""XT73P129"","_START_",IEN,0)")
 D ADD(.XTTEXT,"")
 D ADD(.XTTEXT,"You may now delete routine XT73P129.")
 D ^XMD
 Q
 ;
ADD(ARRAY,TXT) ; Add text to an array (passed by reference)
 S ARRAY($O(ARRAY(""),-1)+1)=TXT
 Q

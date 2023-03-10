OR3P453 ;SLC/RBD - Post Install 453 ;Nov 04, 2020@18:43:11
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**453**;Dec 17, 1997;Build 47
 ;
 ;
POST ; Post-Install for OR*3.0*453
 ; Rebuild EPRTRDT cross reference
 D BMES^XPDUTL("Rebuilding 'EPRTRDT' cross-reference.")
 D RBRDT
 D BMES^XPDUTL("'EPRTRDT' cross-reference rebuild completed.")
 N ORMSG
 S ORMSG(1)="This patch will create a new New Style cross reference"
 S ORMSG(2)="called 'EPRACDT' which will be at the ORDER file level"
 S ORMSG(3)="but on PROVIDER & DATE/TIME ORDERED sub-fields of the"
 S ORMSG(4)="ORDER ACTIONS Multiple."
 S ORMSG(5)=" "
 S ORMSG(6)="Creation of 'EPRACDT' will now go forward in the"
 S ORMSG(7)="Background."
 S ORMSG(8)=" "
 S ORMSG(9)="You will be given a TaskMan task # to check on or,"
 S ORMSG(10)="alternately, you can check your mail on MailMan for a"
 S ORMSG(11)="message expressing Completion of this Task with"
 S ORMSG(12)="appropriate details."
 S ORMSG(13)=" "
 S ORMSG(14)="Note Install of this Patch cannot be considered"
 S ORMSG(15)="Complete unless and until this Task is Completed."
 S ORMSG(16)=" "
 S ORMSG(17)="Note also that the Status of the 'EPRACDT' Creation"
 S ORMSG(18)="can be checked by requesting IT to run 'D CHECK^OR3P453'"
 S ORMSG(19)="at the Command Prompt."
 S ORMSG(20)=" "
 D BMES^XPDUTL(.ORMSG)
 I $D(^XTMP("OR3P453","START")) D
 . D MES^XPDUTL("Task to Create 'EPRACDT' Already Begun "_$$HTE^XLFDT(^XTMP("OR3P453","START"))_".")
 . D MES^XPDUTL("")
 I $D(^XTMP("OR3P453","FINISH")) D  Q
 . D MES^XPDUTL("...and Completed "_$$HTE^XLFDT(^XTMP("OR3P453","FINISH"))_".")
 . D MES^XPDUTL("")
 I $D(^XTMP("OR3P453","STOPPED")) D  G SKPQUIT
 . D MES^XPDUTL("...and Stopped "_$$HTE^XLFDT(^XTMP("OR3P453","STOPPED"))_".")
 . D MES^XPDUTL(""),MES^XPDUTL("...Resuming 'EPRACDT' Creation."),MES^XPDUTL("")
 Q:$D(^XTMP("OR3P453"))
SKPQUIT ;
 S ZTRTN="SETXREF^OR3P453",ZTIO="",ZTDTH=$H
 S ZTDESC="Creation of New Style X-Ref 'EPRACDT' in ORDER file" D ^%ZTLOAD
 I $G(ZTSK) D MES^XPDUTL("Task #"_ZTSK_" queued to start "_$$HTE^XLFDT($G(ZTSK("D")))) I 1
 E  D MES^XPDUTL("***** UNABLE TO QUEUE CREATION OF 'EPRACDT' ORDER FILE X-REF *****")
 K ZTRTN,ZTIO,ZTDTH,ZTDESC,ZTSK
 Q
 ;
SETXREF ; Set new EPRACDT New Style cross reference for old data
 N CNT,CNT2,DA,DIK,LASTREC,ORIEN,STOP,XTMPCNT,XTMPMSG,ZTREQ
 S U="^" S STOP=0 I $G(^XTMP("OR3P453","STOPPED"))]"" D  G RESUME
 . K ^XTMP("OR3P453","STOPPED") S XTMPCNT=$O(^XTMP("OR3P453"," "),-1)
 K ^XTMP("OR3P453")
 S ^XTMP("OR3P453",0)=$$FMADD^XLFDT($$DT^XLFDT(),90)
 S ^XTMP("OR3P453","START")=$H
 S ^XTMP("OR3P453","RECTOTAL")=$P($G(^OR(100,0)),U,4)
 S XTMPCNT=0
 S XTMPCNT=XTMPCNT+1
 S XTMPMSG="Creation of 'EPRACDT' X-Ref for ORDER file Started "
 S XTMPMSG=XTMPMSG_$$HTE^XLFDT(^XTMP("OR3P453","START"))_"."
 S ^XTMP("OR3P453",XTMPCNT)=XTMPMSG
 S XTMPCNT=XTMPCNT+1,^XTMP("OR3P453",XTMPCNT)=" "
RESUME ; Possibly resume here if previously stopped
 S LASTREC=$G(^XTMP("OR3P453","LAST_REC_PROCESSED"))
 S ORIEN=$P(LASTREC,U,1),CNT=$P(LASTREC,U,2)
 I ORIEN="" S ORIEN=" ",CNT=0 K ^OR(100,"EPRACDT")
 F  S ORIEN=$O(^OR(100,ORIEN),-1) Q:'ORIEN  D  I STOP Q
 . S DIK="^OR(100,"_ORIEN_",8,",DIK(1)=".01^EPRACDT",DA(1)=ORIEN D ENALL^DIK
 . S CNT=CNT+1,^XTMP("OR3P453","LAST_REC_PROCESSED")=ORIEN_U_CNT
 . I '(CNT#100000) D  I STOP Q  ;pause after every 100,000 records
 .. F CNT2=1:1:300 H 1 S STOP=$$REQ2STOP() I STOP Q  ;pause for 5 minutes
 . S STOP=$$REQ2STOP() I STOP Q
 I STOP Q
 S XTMPMSG="Creation of 'EPRACDT' X-Ref Completed."
 S XTMPCNT=XTMPCNT+1,^XTMP("OR3P453",XTMPCNT)=XTMPMSG
 S XTMPCNT=XTMPCNT+1,^XTMP("OR3P453",XTMPCNT)=" "
 S ^XTMP("OR3P453","FINISH")=$H
 S XTMPMSG="Background Task Finished "
 S XTMPMSG=XTMPMSG_$$HTE^XLFDT(^XTMP("OR3P453","FINISH"))_"."
 S XTMPCNT=XTMPCNT+1,^XTMP("OR3P453",XTMPCNT)=XTMPMSG
 ;
 ; Send Mail to installer to notify of completion
 S XMSUB="OR*3.0*453 post install has run to completion."
 S XMDUZ="Patch OR*3.0*453"
 S XTMPCNT=0
XRFLOOP S XTMPCNT=$O(^XTMP("OR3P453",XTMPCNT)) G:XTMPCNT'?1N.N FIN
 S ^TMP($J,"OR3P453",XTMPCNT,0)=^XTMP("OR3P453",XTMPCNT)
 G XRFLOOP
 ;
FIN S XMTEXT="^TMP($J,""OR3P453"","
 S XMY(DUZ)="" D ^XMD K ^TMP($J,"OR3P453") S ZTREQ="@"
 K XMDUZ,XMSUB,XMTEXT,XMY
 Q
 ;
REQ2STOP() ;
 ; Check for task stop request
 ; Returns 1 if stop request made.
 N STATUS,X
 S STATUS=0
 I '$D(ZTQUEUED) Q 0
 S X=$$S^%ZTLOAD()
 I X D  ;
 . S STATUS=1
 . S X=$$S^%ZTLOAD("Received shutdown request")
 ;
 I STATUS S ^XTMP("OR3P453","STOPPED")=$H
 Q STATUS
 ;
CHECK ; Check the Status of the Task by looking at XTMP information
 S U="^" N CNT,PCNT,RECTOTAL
 I '$D(^XTMP("OR3P453")) D  Q
 . D MES^XPDUTL("Task to Create 'EPRACDT' has either not started or has")
 . D MES^XPDUTL("automatically purged from the system.")
 . D MES^XPDUTL("")
 I $D(^XTMP("OR3P453","START")) D
 . D MES^XPDUTL("Task to Create 'EPRACDT' Begun "_$$HTE^XLFDT(^XTMP("OR3P453","START"))_".")
 . D MES^XPDUTL("")
 I $D(^XTMP("OR3P453","FINISH")) D  Q
 . D MES^XPDUTL("...and Completed "_$$HTE^XLFDT(^XTMP("OR3P453","FINISH"))_".")
 . D MES^XPDUTL("")
 I $D(^XTMP("OR3P453","STOPPED")) D
 . D MES^XPDUTL("...and Stopped "_$$HTE^XLFDT(^XTMP("OR3P453","STOPPED"))_".")
 . D MES^XPDUTL("")
 S CNT=$P($G(^XTMP("OR3P453","LAST_REC_PROCESSED")),U,2)
 I +$G(CNT)'>0 Q
 S RECTOTAL=$G(^XTMP("OR3P453","RECTOTAL"))
 S PCNT=$P(((CNT/RECTOTAL)*100),".",1)
 D MES^XPDUTL("...Currently, "_PCNT_"% of Records have been Processed.")
 D MES^XPDUTL("")
 Q
RBRDT ;
 N ORS1,ORS2,ORS3,ORS4
 S ORS1=0
 F  S ORS1=$O(^OR(100,"EPRTRDT",ORS1)) Q:'ORS1  D
 . S ORS2=0
 . F  S ORS2=$O(^OR(100,"EPRTRDT",ORS1,ORS2)) Q:'ORS2  D
 .. S ORS3=0
 .. F  S ORS3=$O(^OR(100,"EPRTRDT",ORS1,ORS2,ORS3)) Q:'ORS3  D
 ... S ORS4=0
 ... F  S ORS4=$O(^OR(100,"EPRTRDT",ORS1,ORS2,ORS3,ORS4)) Q:'ORS4  D
 .... K ^OR(100,"EPRTRDT",ORS1,ORS2,ORS3,ORS4)
 .... S DIK="^OR(100,ORS3,11,",DIK(1)=".03^EPRTRDT",DA=ORS4,DA(1)=ORS3 D EN1^DIK
 Q
 ;

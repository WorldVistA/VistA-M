SDRRC18 ;10N20/MAH - ENV/POST-INSTALL FOR PATCH SD*5.3*536 CONVERT PROVIDERS; 3/01/2008 12:24pm
 ;;5.3;Scheduling;**536**;Aug 13, 1993;Build 53
 ;;SDRR-RECALL REMINDER
 Q
ENV ;Environment check
 K ^XTMP("SDRRC18")
 S XPDABORT=""
 ;checks programmer variables
 D PROGCHK(.XPDABORT)
 ;check if install is running
 D ISRUNING(.XPDABORT)
 I XPDABORT="" K XPDABORT
POST ;Check for Clinic Recall provider file)
 I '$D(^DIZ(687067)) D  Q
 . D NOFILE
 D TASK
 Q
START ;Background job entry point
 N SDAIEN,SDANUSB,SDX,SDFDAIEN,SDARAY,SDERAY,SDSAVE,SDRRREC,SDRRFDA,TOTAL
 N SDTOT,SDENCPTR,SDCKCNT,SDRRSTOP,SDENT,SDFIL,PROVIDER
 S TOTAL=0
 D XTMP
 ;seed var's if Re-Run
 I $D(^XTMP("SDRRC18","TOT")) D
 . S SDTOT=+$G(^XTMP("SDRRC18","TOT"))
 . S (SDSAVE,SDAIEN)=+$G(^XTMP("SDRRC18","PROVIDER"))
 E  D
 . S SDAIEN=0 F  S SDAIEN=$O(^DIZ(687067,SDAIEN)) Q:SDAIEN<1  S SDRRREC=$G(^DIZ(687067,SDAIEN,0)) D
 . .S SDRRFDA(403.54,"+1,",.01)=$P(SDRRREC,U,1)
 . .S SDRRFDA(403.54,"+1,",1)=$P(SDRRREC,U,2)
 . .I $P($G(SDRRREC),U,3)'="" S SDRRFDA(403.54,"+1,",2)=$P($G(SDRRREC),U,3)
 . .I $P($G(SDRRREC),U,4)'="" S SDRRFDA(403.54,"+1,",3)=$P($G(SDRRREC),U,4)
 . .I $P($G(SDRRREC),U,5)'="" S SDRRFDA(403.54,"+1,",4)=$P($G(SDRRREC),U,5)
 . .I $P($G(SDRRREC),U,6)'="" S SDRRFDA(403.54,"+1,",5)=$P($G(SDRRREC),U,6)
 . .I $P($G(SDRRREC),U,7)'="" S SDRRFDA(403.54,"+1,",6)=$P($G(SDRRREC),U,7)
 . .N NEWREC S NEWREC(1)=SDAIEN
 . .D UPDATE^DIE("","SDRRFDA","NEWREC")
 . .S TOTAL=TOTAL+1
 S ^XTMP("SDRRC18","COMPLETED")=$$NOW^XLFDT()
 S ^XTMP("SDRRC18","TOT")=TOTAL
 K ^XTMP("SDRRC18","RUNNING")
 D SENDMSG
 Q
SENDMSG ;send MailMan msg to patch installer
 N DIFROM,SDMSG,SDTXT,SDLN,XMY,XMDUZ,XMSUB,XMTEXT,XMDUN,XMZ
 K ^TMP("SDRRC18",$J)
 S XMSUB="SD*5.3*536 OUTPATIENT CLINIC PROVIDER FILE CONVERSION REPORT"
 S XMTEXT="^TMP(""SDRRC18"",$J,",XMDUZ=.5,(XMY(DUZ),XMY(XMDUZ))=""
 S SDLN=0
 D ADD(.SDLN,"Patch:  SD*5.3*536 RECALL REMINDER PROVIDER FILE CONVERSION PROCESSING")
 D ADD(.SDLN," "),ADD(.SDLN,"************")
 D ADD(.SDLN,"The existing Class III file called OUTPATIENT CLINIC RECALL PROVIDER (687067), ")
 D ADD(.SDLN,"which contains Outpatient Clinic Recall Providers have been converted to")
 D ADD(.SDLN,"a new Class I file called Recall Reminder Providers (403.54)")
 D ADD(.SDLN,"which will provide the same functionality.")
 D ADD(.SDLN,"************"),ADD(.SDLN," "),ADD(.SDLN," ")
 D ADD(.SDLN,"SUMMARY OF PROCESSING RESULTS:")
 D ADD(.SDLN,"==============================")
 D ADD(.SDLN," ")
 D ADD(.SDLN,"<<< The Class III OUTPATIENT CLINIC RECALL PROVIDER File Conversion has "_$S(+$G(SDRRSTOP):"NOT ",1:"")_"Completed. >>>")
 I +$G(SDRRSTOP) D
 . D ADD(.SDLN,"    Please restart the post-install process from the following")
 . D ADD(.SDLN,"    programmer's prompt:")
 . D ADD(.SDLN,"                          D POST^SDRRC18")
 D ADD(.SDLN," "),ADD(.SDLN," ")
 D ADD(.SDLN,"  DATE/TIME TASK STARTED: "_$$FMTE^XLFDT(+$G(^XTMP("SDRRC18","START")),"P"))
 D ADD(.SDLN,"DATE/TIME TASK COMPLETED: "_$$FMTE^XLFDT(+$G(^XTMP("SDRRC18","COMPLETED")),"P"))
 I $D(^XTMP("SDRRC18","LAST RUN")) D
 . D ADD(.SDLN,"      DATE/TIME LAST RUN: "_$$FMTE^XLFDT(+$G(^XTMP("SDRRC18","LAST RUN")),"P"))
 D ADD(.SDLN," "),ADD(.SDLN," ")
 D ADD(.SDLN,"    TOTAL RECORDS THAT HAVE BEEN CONVERTED: "_+$G(^XTMP("SDRRC18","TOT")))
 D ADD(.SDLN,"                         <END OF REPORT> :")
 D ^XMD
 K ^TMP("SDRRC18",$J)
 Q
ADD(SDLN,SDTXT) ;add line
 Q:$L(SDTXT)'>0
 S SDLN=$G(SDLN)+1
 S ^TMP("SDRRC18",$J,SDLN)=SDTXT
 Q
PROGCHK(XPDABORT) ;checks programmer variables
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") D
 . D BMES^XPDUTL("******")
 . D MES^XPDUTL("Your programming variables are not set up properly.")
 . D MES^XPDUTL("Installation aborted.")
 . D MES^XPDUTL("******")
 . S XPDABORT=2
 Q
ISRUNING(XPDABORT) ;check if running
 I +$G(^XTMP("SDRRC18","RUNNING")) D
 . D BMES^XPDUTL("******")
 . D MES^XPDUTL("This patch is currently being Installed.  Try later.")
 . D MES^XPDUTL("Installation aborted...")
 . D MES^XPDUTL("******")
 . S XPDABORT=2
 Q
NOFILE ;no File
 D BMES^XPDUTL("******")
 D MES^XPDUTL("The Class III OUTPATIENT CLINIC RECALL PROVIDER  File Conversion is NOT necessary because")
 D MES^XPDUTL("file (#687067) does not exist on this system.")
 D MES^XPDUTL("Post-Install process terminated...For conversion to Recall Reminder Appt Types (#403.54)")
 D MES^XPDUTL("******")
 Q
TASK ;run TaskMan
 N ZTSK,ZTDTH,ZTRTN,ZTDESC,ZTIO,ZTSAVE,ZTREQ,ZTSTOP,SDSTOP
 S SDSTOP=+$G(^XTMP("SDRRC18","STOPPED"))
 S ZTRTN="START^SDRRC18"
 S ZTDESC="SD*5.3*536 OUTPATIENT CLINIC PROVIDER FILE CONVERSION REPORT"
 S ZTIO="",ZTDTH=$H,ZTREQ="@",ZTSAVE("ZTREQ")=""
 D ^%ZTLOAD
 D BMES^XPDUTL("******")
 I '$D(ZTSK) D
 . D MES^XPDUTL("Unable to schedule TaskMan task to run the Class III (687067) File")
 . D MES^XPDUTL("Conversion.")
 . D BMES^XPDUTL("Please re-run Post-Install routine POST^SDRRC18 from")
 . D MES^XPDUTL("the programmer prompt.")
 . ;
 E  D
 . D MES^XPDUTL("Task "_ZTSK_" has been "_$S(+SDSTOP:"Re-",1:"")_"started to run the Class III (687067) File")
 . D MES^XPDUTL("Conversion.")
 . I SDSTOP D
 . . D MES^XPDUTL("  <<< The last task run was STOPPED on "_$$FMTE^XLFDT(SDSTOP,"P")_". >>>")
 . D BMES^XPDUTL("You will receive a MailMan message when this task is completed")
 . D MES^XPDUTL("or if it has been manually stopped.")
 D MES^XPDUTL("******")
 Q
XTMP ;setup ^XTMP to control output for 90 days
 I $D(^XTMP("SDRRC18",0)) D
 . S ^XTMP("SDRRC18","LAST RUN")=$G(^XTMP("SDRRC18","START"))
 E  D
 . N SDX
 . S SDX=$$FMADD^XLFDT($$NOW^XLFDT(),90)_U_$$NOW^XLFDT()
 . S SDX=SDX_"^SD*5.3*536 OUTPATIENT CLINIC PROVIDER FILE CONVERSION REPORT"
 . S ^XTMP("SDRRC18",0)=SDX
 S ^XTMP("SDRRC18","START")=$$NOW^XLFDT()
 S ^XTMP("SDRRC18","RUNNING")="1"
 Q
UPXTMP(SDENCPTR,NODE,SDENT) ;add to ^XTMP
 ; Input:
 ;       NODE - Unique subscript
 ; Output: none
 Q:'$G(SDENCPTR)
 I $G(NODE)="" S NODE="UNKNOWN"
 S ^XTMP("SDRRC18","TOT2",NODE,SDENCPTR)=$G(SDENT)
 Q

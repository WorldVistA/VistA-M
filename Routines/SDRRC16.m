SDRRC16 ;10N20/MAH - POST-INSTALL FOR PATCH SD*5.3*536 CONVERT PARAMS FILE; 3/01/2008 12:24pm
 ;;5.3;Scheduling;**536**;Aug 13, 1993;Build 53
 ;;SDRR-RECALL REMINDER
 Q
ENV ;Environment check
 K ^XTMP("SDRRC16")
 S XPDABORT=""
 ;checks programmer variables
 D PROGCHK(.XPDABORT)
 ;check if install is running
 D ISRUNING(.XPDABORT)
 I XPDABORT="" K XPDABORT
POST ;Check for Clinic Recall PARAMS file)
 I '$D(^DIZ(190004.1)) D  Q
 . D NOFILE
 D TASK
 Q
START ;Background job entry point
 N SDAIEN,SDANUSB,SDX,SDFDAIEN,SDARAY,SDERAY,SDSAVE,SDRRREC,SDRRFDA,TOTAL
 N SDTOT,SDENCPTR,SDCKCNT,SDRRSTOP,SDENT,SDFIL,PARAM
 S TOTAL=0
 D XTMP
 ;seed var's if Re-Run
 I $D(^XTMP("SDRRC16","TOT")) D
 . S SDTOT=+$G(^XTMP("SDRRC16","TOT"))
 . S (SDSAVE,SDAIEN)=+$G(^XTMP("SDRRC16","PARAM"))
 E  D
 . S SDAIEN=0 F  S SDAIEN=$O(^DIZ(190004.1,SDAIEN)) Q:SDAIEN<1  S SDRRREC=$G(^DIZ(190004.1,SDAIEN,0)) D
 . .S SDRRFDA(403.53,"+1,",.01)=$P(SDRRREC,U,1)
 . .S SDRRFDA(403.53,"+1,",1)=$P(SDRRREC,U,2)
 . .I $P($G(SDRRREC),U,4)'="" S SDRRFDA(403.53,"+1,",3)=$P($G(SDRRREC),U,4)
 . .I $P($G(SDRRREC),U,5)'="" S SDRRFDA(403.53,"+1,",4)=$P($G(SDRRREC),U,5)
 . .N NEWREC S NEWREC(1)=SDAIEN
 . .D UPDATE^DIE("","SDRRFDA","NEWREC","")
 . .S TOTAL=TOTAL+1
 S ^XTMP("SDRRC16","COMPLETED")=$$NOW^XLFDT()
 S ^XTMP("SDRRC16","TOT")=TOTAL
 K ^XTMP("SDRRC16","RUNNING")
 D SENDMSG
 Q
SENDMSG ;send MailMan msg to patch installer
 N DIFROM,SDMSG,SDTXT,SDLN,XMY,XMDUZ,XMSUB,XMTEXT,XMDUN,XMZ
 K ^TMP("SDRRC16",$J)
 S XMSUB="SD*5.3*536 OUTPATIENT CLINIC PARAM FILE CONVERSION REPORT"
 S XMTEXT="^TMP(""SDRRC16"",$J,",XMDUZ=.5,(XMY(DUZ),XMY(XMDUZ))=""
 S SDLN=0
 D ADD(.SDLN,"Patch:  SD*5.3*536 RECALL REMINDER TEAM FILE CONVERSION PROCESSING")
 D ADD(.SDLN," "),ADD(.SDLN,"************")
 D ADD(.SDLN,"The existing Class III file called OUTPATIENT CLINIC RECALL PARAM (190004.1), ")
 D ADD(.SDLN,"which contains Clinic Recall params have been converted to")
 D ADD(.SDLN,"a new Class I file called Recall Reminder Parameters (403.53)")
 D ADD(.SDLN,"which will provide the same functionality.")
 D ADD(.SDLN,"************"),ADD(.SDLN," "),ADD(.SDLN," ")
 D ADD(.SDLN,"SUMMARY OF PROCESSING RESULTS:")
 D ADD(.SDLN,"==============================")
 D ADD(.SDLN," ")
 D ADD(.SDLN,"<<< The Class III OUTPATIENT CLINIC RECALL PARAM File Conversion has "_$S(+$G(SDRRSTOP):"NOT ",1:"")_"Completed. >>>")
 I +$G(SDRRSTOP) D
 . D ADD(.SDLN,"    Please restart the post-install process from the following")
 . D ADD(.SDLN,"    programmer's prompt:")
 . D ADD(.SDLN,"                          D POST^SDRRC16")
 D ADD(.SDLN," "),ADD(.SDLN," ")
 D ADD(.SDLN,"  DATE/TIME TASK STARTED: "_$$FMTE^XLFDT(+$G(^XTMP("SDRRC16","START")),"P"))
 D ADD(.SDLN,"DATE/TIME TASK COMPLETED: "_$$FMTE^XLFDT(+$G(^XTMP("SDRRC16","COMPLETED")),"P"))
 I $D(^XTMP("SDRRC16","LAST RUN")) D
 . D ADD(.SDLN,"      DATE/TIME LAST RUN: "_$$FMTE^XLFDT(+$G(^XTMP("SDRRC16","LAST RUN")),"P"))
 D ADD(.SDLN," "),ADD(.SDLN," ")
 D ADD(.SDLN,"    TOTAL RECORDS THAT HAVE BEEN CONVERTED: "_+$G(^XTMP("SDRRC16","TOT")))
 D ADD(.SDLN,"                         <END OF REPORT> :")
 D ^XMD
 K ^TMP("SDRRC16",$J)
 Q
ADD(SDLN,SDTXT) ;add line
 Q:$L(SDTXT)'>0
 S SDLN=$G(SDLN)+1
 S ^TMP("SDRRC16",$J,SDLN)=SDTXT
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
 I +$G(^XTMP("SDRRC16","RUNNING")) D
 . D BMES^XPDUTL("******")
 . D MES^XPDUTL("This patch is currently being Installed.  Try later.")
 . D MES^XPDUTL("Installation aborted...")
 . D MES^XPDUTL("******")
 . S XPDABORT=2
 Q
NOFILE ;no File
 D BMES^XPDUTL("******")
 D MES^XPDUTL("The Class III Outpatient Clinic Recall Params File Conversion is NOT necessary because")
 D MES^XPDUTL("file (#190004.1) does not exist on this system.")
 D MES^XPDUTL("Post-Install process terminated...For conversion to OUTPATIENT CLINIC PARAM FILE (#403.53)")
 D MES^XPDUTL("******")
 Q
TASK ;run TaskMan
 N ZTSK,ZTDTH,ZTRTN,ZTDESC,ZTIO,ZTSAVE,ZTREQ,ZTSTOP,SDSTOP
 S SDSTOP=+$G(^XTMP("SDRRC16","STOPPED"))
 S ZTRTN="START^SDRRC16"
 S ZTDESC="SD*5.3*536 OUTPATIENT CLINIC PARAM FILE CONVERSION REPORT"
 S ZTIO="",ZTDTH=$H,ZTREQ="@",ZTSAVE("ZTREQ")=""
 D ^%ZTLOAD
 D BMES^XPDUTL("******")
 I '$D(ZTSK) D
 . D MES^XPDUTL("Unable to schedule TaskMan task to run the Class III (190004.1) File")
 . D MES^XPDUTL("Conversion.")
 . D BMES^XPDUTL("Please re-run Post-Install routine POST^SSDRRC16 from")
 . D MES^XPDUTL("the programmer prompt.")
 . ;
 E  D
 . D MES^XPDUTL("Task "_ZTSK_" has been "_$S(+SDSTOP:"Re-",1:"")_"started to run the Class III (190004.1) File")
 . D MES^XPDUTL("Conversion.")
 . I SDSTOP D
 . . D MES^XPDUTL("  <<< The last task run was STOPPED on "_$$FMTE^XLFDT(SDSTOP,"P")_". >>>")
 . D BMES^XPDUTL("You will receive a MailMan message when this task is completed")
 . D MES^XPDUTL("or if it has been manually stopped.")
 D MES^XPDUTL("******")
 Q
XTMP ;setup ^XTMP to control output for 90 days
 I $D(^XTMP("SDRRC16",0)) D
 . S ^XTMP("SDRRC16","LAST RUN")=$G(^XTMP("SDRRC16","START"))
 E  D
 . N SDX
 . S SDX=$$FMADD^XLFDT($$NOW^XLFDT(),90)_U_$$NOW^XLFDT()
 . S SDX=SDX_"^SD*5.3*536 OUTPATIENT CLINIC PARAM FILE CONVERSION REPORT"
 . S ^XTMP("SDRRC16",0)=SDX
 S ^XTMP("SDRRC16","START")=$$NOW^XLFDT()
 S ^XTMP("SDRRC16","RUNNING")="1"
 Q
UPXTMP(SDENCPTR,NODE,SDENT) ;add to ^XTMP
 ; Input:
 ;       NODE - Unique subscript
 ; Output: none
 Q:'$G(SDENCPTR)
 I $G(NODE)="" S NODE="UNKNOWN"
 S ^XTMP("SDRRC16","TOT2",NODE,SDENCPTR)=$G(SDENT)
 Q

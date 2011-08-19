SD53P495 ;ALB/RBS - ENV/POST-INSTALL FOR PATCH SD*5.3*495 ; 5/2/07 12:24pm
 ;;5.3;Scheduling;**495**;Aug 13, 1993;Build 50
 Q
ENV ;Environment check
 S XPDABORT=""
 ;checks programmer variables
 D PROGCHK(.XPDABORT)
 ;check if install is running
 D ISRUNING(.XPDABORT)
 I XPDABORT="" K XPDABORT
 Q
POST ;Post-Install
 D POST1
 ;Check for SCOUT file
 I '$D(^ANUSB(626140)) D  Q
 . D NOFILE
 D TASK
 Q
POST1 ;Set parameter value
 N SDDAYS,SDERR,SDPARM
 S SDPARM="SDSC SITE PARAMETER",SDDAYS=30
 D EN^XPAR("DIV",SDPARM,1,SDDAYS,.SDERR)
 D BMES^XPDUTL("******")
 I '$G(SDERR) D
 . D MES^XPDUTL(SDPARM_" parameter set to "_SDDAYS_" days SUCCESSFULLY.")
 E  D
 . D MES^XPDUTL(SDPARM_" parameter set FAILED.")
 D MES^XPDUTL("******")
 Q
START ;Background job entry point
 N SDAIEN,SDANUSB,SDX,SDFDAIEN,SDARAY,SDERAY,SDSAVE
 N SDTOT,SDTOT1,SDTOT2,SDTOT3,SDENCPTR,SDCKCNT,SDSTOP,SDENT,SDFIL,DFN
 D XTMP
 ;seed var's if Re-Run
 I $D(^XTMP("SD53P495","TOT")) D
 . S SDTOT=+$G(^XTMP("SD53P495","TOT"))
 . S SDTOT1=+$G(^XTMP("SD53P495","TOT1"))
 . S SDTOT2=+$G(^XTMP("SD53P495","TOT2"))
 . S SDTOT3=+$G(^XTMP("SD53P495","TOT3"))
 . S (SDSAVE,SDENCPTR)=+$G(^XTMP("SD53P495","ENCOUNTER"))
 E  D
 . S (SDAIEN,SDENCPTR,SDSAVE,SDTOT,SDTOT1,SDTOT2,SDTOT3)=0
 S SDCKCNT=100,SDSTOP=0
 F  S SDENCPTR=$O(^ANUSB(626140,"B",SDENCPTR)) Q:'SDENCPTR  D  Q:SDSTOP
 . S SDSAVE=SDENCPTR
 . K SDANUSB,SDARAY,SDERAY,SDENT
 . I +SDTOT#SDCKCNT=0,$$S^%ZTLOAD() S SDSTOP=1 Q
 . S SDAIEN=$O(^ANUSB(626140,"B",SDENCPTR,""),-1)
 . Q:'$G(SDAIEN)
 . S SDANUSB=$G(^ANUSB(626140,SDAIEN,0))
 . Q:'SDANUSB
 . S SDTOT=SDTOT+1
 . I $D(^SDSC(409.48,SDENCPTR,0)) S SDTOT3=SDTOT3+1 Q
 . I '$$GETOE^SDOE(SDENCPTR) D  Q
 . . S DFN=$P(SDANUSB,U,11) D DEM^VADPT S DFN=$E(VADM(1),1,15)
 . . S SDENT=DFN_" "_$$FMTE^XLFDT($P(SDANUSB,U,7),2)
 . . D UPXTMP(SDENCPTR,"NO (O/P) ENCOUNTER RECORD (#409.68)",SDENT) S SDTOT2=SDTOT2+1
 . D GETS^DIQ(626140,SDAIEN_",","**","I","SDARAY","SDERAY")
 . I $D(SDERAY) D  Q
 . . S SDENT=$G(SDERAY("DIERR",1,"TEXT",1))
 . . D UPXTMP(SDENCPTR,"NO (SCOUT) FILE DATA (#626140)",SDENT) S SDTOT2=SDTOT2+1
 . S SDFIL=$$FILE(SDENCPTR,SDAIEN,.SDARAY)
 . I '+SDFIL D  Q
 . . D UPXTMP(SDENCPTR,"FILING ERROR TO (#409.48)",$P(SDFIL,"^",2)) S SDTOT2=SDTOT2+1
 . E  D
 . . S SDTOT1=SDTOT1+1
 I SDSTOP D
 . S ^XTMP("SD53P495","STOPPED")=$$NOW^XLFDT()
 . S ZTSTOP=1
 E  D
 . S ^XTMP("SD53P495","COMPLETED")=$$NOW^XLFDT()
 S ^XTMP("SD53P495","ENCOUNTER")=SDSAVE
 S ^XTMP("SD53P495","TOT")=SDTOT,^XTMP("SD53P495","TOT1")=SDTOT1
 S ^XTMP("SD53P495","TOT2")=SDTOT2,^XTMP("SD53P495","TOT3")=SDTOT3
 K ^XTMP("SD53P495","RUNNING") D KVA^VADPT
 D SENDMSG(SDSTOP)
 Q
FILE(SDENCPTR,SDAIEN,SDARAY) ;file new entry
 ; create #409.48 file
 ; Input:
 ;   SDENCPTR - [required] O/P Encounter file pointer (#409.68)
 ;     SDAIEN - [required] IEN of (#626140) record to convert
 ;     SDARAY - [required] Array of Internal values of all fields
 ; Output:
 ;   Function Value - returns 1 on success, 0 on failure and error msg
 I '+$G(SDENCPTR)!'+$G(SDAIEN)!('$D(SDARAY)) Q 0
 N SDERR,SDFDA,SDFLD,SDFDAIEN,SDI,SDIENS,SDNUM,SDSTR,SDSTR1,SDSUB
 N DIC,DICR,DIE,DIERR,DD,DG,DO,DR,DA
 ; DINUM=X setup so new file IEN = O/P Encounter IEN
 S SDFDAIEN(1)=SDENCPTR
 ; setup main fields
 S SDIENS="+1,",SDAIEN=SDAIEN_","
 S SDSTR=".01^.02^.03^.04^.05^.06^.07^.08^.09^.1^.11^.12"
 F SDI=1:1:12 D
 . S SDFLD=$P(SDSTR,U,SDI)
 . S SDFDA(409.48,SDIENS,SDFLD)=$G(SDARAY(626140,SDAIEN,SDFLD,"I"))
 S SDFDA(409.48,SDIENS,.13)=1  ;SCOUT was always a 1 (SC)
 ; setup fields of (#409.481) multiple
 I $D(SDARAY(626140.01)) D
 . S SDSTR1=".01^.02^.03^.04^.05^.06",SDNUM=1,(SDSUB,SDIENS)=""
 . F  S SDSUB=$O(SDARAY(626140.01,SDSUB)) Q:SDSUB=""  D
 . . S SDNUM=SDNUM+1
 . . F SDI=1:1:6 S SDFLD=$P(SDSTR1,U,SDI) D
 . . . S SDIENS="+"_SDNUM_",+1,"
 . . . S SDFDA(409.481,SDIENS,SDFLD)=$G(SDARAY(626140.01,SDSUB,SDFLD,"I"))
 D UPDATE^DIE("","SDFDA","SDFDAIEN","SDERR")
 Q $S($D(SDERR):0,1:1)_"^"_$S($D(SDERR):$G(SDERR("DIERR",1,"TEXT",1)),1:"")
SENDMSG(SDSTOP) ;send MailMan msg to patch installer
 N DIFROM,SDMSG,SDTXT,SDLN,XMY,XMDUZ,XMSUB,XMTEXT,XMDUN,XMZ
 K ^TMP("SD53P495",$J)
 S XMSUB="SD*5.3*495 (SCOUT) FILE CONVERSION REPORT"
 S XMTEXT="^TMP(""SD53P495"",$J,",XMDUZ=.5,(XMY(DUZ),XMY(XMDUZ))=""
 S SDLN=0
 D ADD(.SDLN,"Patch:  SD*5.3*495 Automated Service Connected Designation")
 D ADD(.SDLN," "),ADD(.SDLN,"************")
 D ADD(.SDLN,"The existing Class III (SCOUT) file, ANU SERVICE CONNECTED CHANGES (#626140),")
 D ADD(.SDLN,"which contains O/P Encounter records that have been compiled for additional")
 D ADD(.SDLN,"Service Connected (SC) review, has been used to create a new Class I file")
 D ADD(.SDLN,"which will provide the same functionality.")
 D ADD(.SDLN," ")
 D ADD(.SDLN,"Only valid O/P Encounter records from the Class III (SCOUT) file,")
 D ADD(.SDLN,"ANU SERVICE CONNECTED CHANGES (#626140), have been filed into")
 D ADD(.SDLN,"the new SDSC SERVICE CONNECTED CHANGES (#409.48) file.")
 D ADD(.SDLN," ")
 D ADD(.SDLN,"The new Automated Service Connected Designation (ASCD) Menu Options")
 D ADD(.SDLN,"enable user access to the O/P Encounter records in the (#409.48) file.")
 D ADD(.SDLN,"************"),ADD(.SDLN," "),ADD(.SDLN," ")
 D ADD(.SDLN,"SUMMARY OF PROCESSING RESULTS:")
 D ADD(.SDLN,"==============================")
 D ADD(.SDLN," ")
 D ADD(.SDLN,"<<< The Class III (SCOUT) File Conversion has "_$S(+$G(SDSTOP):"NOT ",1:"")_"Completed. >>>")
 I +$G(SDSTOP) D
 . D ADD(.SDLN,"    Please restart the post-install process from the following")
 . D ADD(.SDLN,"    programmer's prompt:")
 . D ADD(.SDLN,"                          D POST^SD53P495")
 D ADD(.SDLN," "),ADD(.SDLN," ")
 D ADD(.SDLN,"  DATE/TIME TASK STARTED: "_$$FMTE^XLFDT(+$G(^XTMP("SD53P495","START")),"P"))
 I $G(SDSTOP) D
 . D ADD(.SDLN,"  DATE/TIME TASK STOPPED: "_$$FMTE^XLFDT(+$G(^XTMP("SD53P495","STOPPED")),"P"))
 E  D
 . D ADD(.SDLN,"DATE/TIME TASK COMPLETED: "_$$FMTE^XLFDT(+$G(^XTMP("SD53P495","COMPLETED")),"P"))
 I $D(^XTMP("SD53P495","LAST RUN")) D
 . D ADD(.SDLN,"      DATE/TIME LAST RUN: "_$$FMTE^XLFDT(+$G(^XTMP("SD53P495","LAST RUN")),"P"))
 D ADD(.SDLN," "),ADD(.SDLN," ")
 D ADD(.SDLN,"        TOTAL O/P ENCOUNTER RECORDS FOUND: "_+$G(^XTMP("SD53P495","TOT")))
 I +$G(^XTMP("SD53P495","TOT3")) D
 . D ADD(.SDLN,"       TOTAL RECORDS PREVIOUSLY CONVERTED: "_+$G(^XTMP("SD53P495","TOT3")))
 D ADD(.SDLN,"    TOTAL O/P ENCOUNTER RECORDS CONVERTED: "_+$G(^XTMP("SD53P495","TOT1")))
 D ADD(.SDLN,"TOTAL O/P ENCOUNTER RECORDS NOT CONVERTED: "_+$G(^XTMP("SD53P495","TOT2")))
 I +$G(^XTMP("SD53P495","TOT2")) D
 . D ADD(.SDLN,"                                         :")
 . N SDSUB,SDIEN,SDENT
 . S (SDSUB,SDIEN)=""
 . F  S SDSUB=$O(^XTMP("SD53P495","TOT2",SDSUB)) Q:SDSUB=""  D
 . . D ADD(.SDLN,"                     REASON NOT CONVERTED: "_SDSUB)
 . . D ADD(.SDLN,"                        O/P ENCOUNTER IEN:")
 . . F  S SDIEN=$O(^XTMP("SD53P495","TOT2",SDSUB,SDIEN)) Q:'SDIEN  D
 . . . S SDENT=$E(^XTMP("SD53P495","TOT2",SDSUB,SDIEN),1,30)
 . . . D ADD(.SDLN,"                                         : "_SDIEN_"-"_SDENT)
 . . D ADD(.SDLN,"                                         :")
 D ADD(.SDLN,"                         <END OF REPORT> :")
 D ^XMD
 K ^TMP("SD53P495",$J)
 Q
ADD(SDLN,SDTXT) ;add line
 Q:$L(SDTXT)'>0
 S SDLN=$G(SDLN)+1
 S ^TMP("SD53P495",$J,SDLN)=SDTXT
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
 I +$G(^XTMP("SD53P495","RUNNING")) D
 . D BMES^XPDUTL("******")
 . D MES^XPDUTL("This patch is currently being Installed.  Try later.")
 . D MES^XPDUTL("Installation aborted...")
 . D MES^XPDUTL("******")
 . S XPDABORT=2
 Q
NOFILE ;no File
 D BMES^XPDUTL("******")
 D MES^XPDUTL("The Class III (SCOUT) File Conversion is NOT necessary because")
 D MES^XPDUTL("the ANU SERVICE CONNECTED CHANGES (#626140) file does not exist")
 D MES^XPDUTL("on this system.")
 D MES^XPDUTL("Post-Install process terminated...")
 D MES^XPDUTL("******")
 Q
TASK ;run TaskMan
 N ZTSK,ZTDTH,ZTRTN,ZTDESC,ZTIO,ZTSAVE,ZTREQ,ZTSTOP,SDSTOP
 S SDSTOP=+$G(^XTMP("SD53P495","STOPPED"))
 S ZTRTN="START^SD53P495"
 S ZTDESC="SD*5.3*495 (SCOUT) FILE CONVERSION PROCESSING"
 S ZTIO="",ZTDTH=$H,ZTREQ="@",ZTSAVE("ZTREQ")=""
 D ^%ZTLOAD
 D BMES^XPDUTL("******")
 I '$D(ZTSK) D
 . D MES^XPDUTL("Unable to schedule TaskMan task to run the Class III (SCOUT) File")
 . D MES^XPDUTL("Conversion.")
 . D BMES^XPDUTL("Please re-run Post-Install routine POST^SD53P495 from")
 . D MES^XPDUTL("the programmer prompt.")
 . ;
 E  D
 . D MES^XPDUTL("Task "_ZTSK_" has been "_$S(+SDSTOP:"Re-",1:"")_"started to run the Class III (SCOUT) File")
 . D MES^XPDUTL("Conversion.")
 . I SDSTOP D
 . . D MES^XPDUTL("  <<< The last task run was STOPPED on "_$$FMTE^XLFDT(SDSTOP,"P")_". >>>")
 . D BMES^XPDUTL("You will receive a MailMan message when this task is completed")
 . D MES^XPDUTL("or if it has been manually stopped.")
 D MES^XPDUTL("******")
 Q
XTMP ;setup ^XTMP to control output for 90 days
 I $D(^XTMP("SD53P495",0)) D
 . S ^XTMP("SD53P495","LAST RUN")=$G(^XTMP("SD53P495","START"))
 E  D
 . N SDX
 . S SDX=$$FMADD^XLFDT($$NOW^XLFDT(),90)_U_$$NOW^XLFDT()
 . S SDX=SDX_"^SD*5.3*495 (SCOUT) FILE CONVERSION PROCESSING"
 . S ^XTMP("SD53P495",0)=SDX
 S ^XTMP("SD53P495","START")=$$NOW^XLFDT()
 S ^XTMP("SD53P495","RUNNING")="1"
 Q
UPXTMP(SDENCPTR,NODE,SDENT) ;add to ^XTMP
 ; Input:
 ;   SDENCPTR - Encounter IEN
 ;       NODE - Unique subscript
 ; Output: none
 Q:'$G(SDENCPTR)
 I $G(NODE)="" S NODE="UNKNOWN"
 S ^XTMP("SD53P495","TOT2",NODE,SDENCPTR)=$G(SDENT)
 Q

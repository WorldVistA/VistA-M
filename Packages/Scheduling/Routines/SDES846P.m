SDES846P ;ALB/MGD,LAB - SD*5.3*846 Post Init Routine ; June 27, 2023
 ;;5.3;SCHEDULING;**846**;AUG 13, 1993;Build 12
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ;
EN ; Update the VS GUI version in #409.98
 D FIND,TASK,TASK2,TASK3,TASK^SDES846PENC
 Q
 ;
FIND ;FIND THE IEN FOR "VS GUI NATIONAL"
 N SDECDA,SDECDA1
 D MES^XPDUTL("")
 D MES^XPDUTL("   Updating SDEC SETTINGS file (#409.98)")
 S SDECDA=0,SDECDA=$O(^SDEC(409.98,"B","VS GUI NATIONAL",SDECDA)) G:$G(SDECDA)="" NOFIND
 D VERSION   ;update GUI version number and date
 Q
VERSION ;SET THE NEW VERSION UPDATE IN SDEC SETTING FILE #409.98 TO 1.7.44
 S DA=SDECDA,DIE=409.98,DR="2///1.7.44;3///"_DT D ^DIE  ;update VS GUI NATIONAL
 K DIE,DR,DA
 S SDECDA1=0,SDECDA1=$O(^SDEC(409.98,"B","VS GUI LOCAL",SDECDA1)) Q:$G(SDECDA1)=""    ;get DA for the VS GUI LOCAL
 S DA=SDECDA1,DIE=409.98,DR="2///1.7.44;3///"_DT D ^DIE  ;update VS GUI LOCAL
 K DIE,DR,DA
 Q
 ;
NOFIND ;"VS GUI NATIONAL" NOT FOUND
 D MES^XPDUTL("   VS GUI NATIONAL not found in the SDEC SETTINGS file (#409.98)")
 Q
 ;
TASK ;
 D MES^XPDUTL("")
 D MES^XPDUTL("   SD*5.3*846 Post-Install to fix improper DINUMed records")
 D MES^XPDUTL("   in the HOSPITAL LOCATION (#44) file is being queued to")
 D MES^XPDUTL("   run in the background.")
 D MES^XPDUTL("")
 N ZTDESC,ZTRTN,ZTIO,ZTSK,X,ZTDTH,ZTSAVE
 S ZTDESC="SD*5.3*846 Post Install Routine"
 D NOW^%DTC S ZTDTH=X,ZTIO="",ZTRTN="PRIVUSERSFIX^SDES846P",ZTSAVE("*")="" D ^%ZTLOAD
 I $D(ZTSK) D
 . D MES^XPDUTL("  >>>Task "_ZTSK_" has been queued.")
 . D MES^XPDUTL("")
 I '$D(ZTSK) D
 . D MES^XPDUTL("  UNABLE TO QUEUE THIS JOB.")
 . D MES^XPDUTL("  Please contact the National Help Desk to report this issue.")
 Q
 ;
PRIVUSERSFIX ; Clean up Privileged Users whose entries are no DINUMed correctly
 N CLINIEN,CLINNAME,DATA0,FIRSTPRIV,PRIVUSERIEN,PRIVUSER200,PRIVUSERNAME,ELGRETURN
 S CLINIEN=0
 F  S CLINIEN=$O(^SC(CLINIEN)) Q:'CLINIEN  D
 .S DATA0=$G(^SC(CLINIEN,0))
 .Q:DATA0=""
 .S FIRSTPRIV=1
 .S CLINNAME=$P(DATA0,U,1)
 .; Don't update ZZ Clinics
 .Q:$E(CLINNAME,1,2)="ZZ"
 .; Quit if no Priv Users
 .Q:'$D(^SC(CLINIEN,"SDPRIV"))
 .S PRIVUSERIEN=0
 .F  S PRIVUSERIEN=$O(^SC(CLINIEN,"SDPRIV",PRIVUSERIEN)) Q:'PRIVUSERIEN  D
 ..S PRIVUSER200=$G(^SC(CLINIEN,"SDPRIV",PRIVUSERIEN,0))
 ..S PRIVUSERNAME=$P($G(^VA(200,PRIVUSERIEN,0)),U,1)
 ..; Quit if DINUMed correctly
 ..Q:PRIVUSERIEN=PRIVUSER200
 ..; Delete Bad Entry
 ..D UPDPRIV^SDESLOC(.ELGRETURN,0,CLINIEN,PRIVUSERIEN)
 ..; Add DINUMed Entry
 ..D UPDPRIV^SDESLOC(.ELGRETURN,1,CLINIEN,PRIVUSER200)
 Q
 ;
TASK2 ;
 D MES^XPDUTL("")
 D MES^XPDUTL("   SD*5.3*846 Post-Install is being queued to run in the background.")
 D MES^XPDUTL("   This Post-install will fix a data issue where appointments were ")
 D MES^XPDUTL("   created with a different patients request. The post-install will ")
 D MES^XPDUTL("   create a new request for the appointment. The request will be ")
 D MES^XPDUTL("   reopened if there is not appointment made for the request patient.")
 D MES^XPDUTL("")
 N ZTDESC,ZTRTN,ZTIO,ZTSK,X,ZTDTH,ZTSAVE
 S ZTDESC="SD*5.3*846 Post Install Routine - Appointment mismatch cleanup"
 D NOW^%DTC S ZTDTH=X,ZTIO="",ZTRTN="SELECTDATA^SDES846P",ZTSAVE("*")="" D ^%ZTLOAD
 I $D(ZTSK) D
 . D MES^XPDUTL("  >>>Task "_ZTSK_" has been queued.")
 . D MES^XPDUTL("")
 I '$D(ZTSK) D
 . D MES^XPDUTL("  UNABLE TO QUEUE THIS JOB.")
 . D MES^XPDUTL("  Please contact the National Help Desk to report this issue.")
 Q
 ;
MAIL2 ;
 ; Appointment vs request data report
 ;
 N STANUM,MESS1,XMTEXT,XMSUB,XMY,XMDUZ,DIFROM
 S STANUM=$$KSP^XUPARAM("INST")_","
 S STANUM=$$GET1^DIQ(4,STANUM,99)
 S MESS1="Station: "_STANUM_" - "
 ;
 ; Send MailMan message
 S XMDUZ=DUZ
 S XMTEXT="^XTMP(""SDES846P"","
 S XMSUB=MESS1_"SD*5.3*846 - Post Install Data Report"
 S XMDUZ=.5,XMY(DUZ)="",XMY(XMDUZ)=""
 S XMY("BARBER.LORI@DOMAIN.EXT")=""
 S XMY("DILL.MATT@DOMAIN.EXT")=""
 S XMY("REESE,DARRYL M@DOMAIN.EXT")=""
 S XMY("DUNNAM.DAVID W@DOMAIN.EXT")=""
 D ^XMD
 K TEXT
 Q
SELECTDATA ;Select appointments where the request is not for the appointment patient
 N APPTIEN,CHECKIN,CANCELDTTM,STARTTM,POP,CNT,PURGEDT,TEXTCNT
 N APPTREQINFO,APPTDFN,APPTREQTYP,REQPATDFN,REOPEN,NEWREQIEN
 S PURGEDT=$$FMADD^XLFDT(DT,5)
 K ^XTMP("SDES846P")
 S ^XTMP("SDES846P",0)=PURGEDT_"^"_DT_"^846 Post Install Data report"
 S CNT=0
 S TEXTCNT=1
 S ^XTMP("SDES846P",TEXTCNT)="REQTYPE^REQIEN^REOPENED^APPTIEN^APPT DT/TM^APPT MADE^NEW REQIEN"
 S STARTTM=$$FMADD^XLFDT(DT,-180)
 F  S STARTTM=$O(^SDEC(409.84,"B",STARTTM)) Q:(STARTTM="")  D
 . S APPTIEN=""
 . S POP=0
 . F  S APPTIEN=$O(^SDEC(409.84,"B",STARTTM,APPTIEN)) Q:(APPTIEN="")  D
 .. S CHECKIN=$$GET1^DIQ(409.84,APPTIEN_",",.03)
 .. S CANCELDTTM=$$GET1^DIQ(409.84,APPTIEN_",",.12)
 .. S POP=(CHECKIN'="")!(CANCELDTTM'="")
 .. Q:POP
 .. ;Continue checking
 .. S APPTDFN=$$GET1^DIQ(409.84,APPTIEN_",",.05,"I")
 .. S APPTREQTYP=$$GET1^DIQ(409.84,APPTIEN_",",.22,"E")
 .. S APPTREQINFO=$$GET1^DIQ(409.84,APPTIEN_",",.22,"I")
 .. D:(APPTREQTYP="APPT") APPT(APPTREQINFO,APPTIEN,APPTDFN,APPTREQTYP,.CNT,.NEWREQIEN)
 .. D:(APPTREQTYP="CONSULT") CONSULT(APPTREQINFO,APPTIEN,APPTDFN,APPTREQTYP,.CNT,.CONSULTIEN,.NEWREQIEN)
 S TEXTCNT=TEXTCNT+1
 S ^XTMP("SDES846P",TEXTCNT)="TOTAL = "_CNT
 S ^XTMP("SDES846P",(TEXTCNT+1))="NOTE:  -1 NEW REQIEN indicates no update made"
 D MAIL2
 Q
 ;
APPT(APPTREQINFO,APPTIEN,APPTDFN,APPTREQTYP,CNT,NEWREQIEN) ;gather information for appt request
 N REQIEN
 S REQIEN=$P(APPTREQINFO,";",1)
 S REQPATDFN=$$GET1^DIQ(409.85,REQIEN_",",.01,"I")
 Q:APPTDFN=REQPATDFN
 S REOPEN=""
 D DATACLEANUP(APPTDFN,APPTIEN,REQIEN,REQPATDFN,APPTREQTYP,"",.NEWREQIEN,.REOPEN)
 D REPORT(REQIEN,APPTIEN,APPTREQTYP,NEWREQIEN,REOPEN,.CNT)
 ;
 Q
DATACLEANUP(APPTDFN,APPTIEN,REQIEN,REQPATDFN,APPTREQTYP,CONSULTIEN,NEWREQIEN,REOPEN) ;create appt request for patient on appointment and attach
 N SDDEMO,ARRAY,TODAY,REQSTAT,DISPOSITION,FDA,CONSTAT,RESCHED
 K FDA,SDDEMO,PRFLIST
 D PDEMO^SDECU3(.SDDEMO,APPTDFN)
 S ARRAY(2)=APPTDFN
 S ARRAY(3)=$P($$FMTONET^SDECDATE($$NOW^XLFDT),":")_":"_$P($$FMTONET^SDECDATE($$NOW^XLFDT),":",2)
 S ARRAY(5)="APPT"
 S ARRAY(6)=$$GET1^DIQ(409.831,$$GET1^DIQ(409.84,APPTIEN_",",.07,"I")_",",.04,"I")
 S ARRAY(7)=.5
 S ARRAY(8)="ASAP"
 S ARRAY(9)="PATIENT"
 S ARRAY(11)=$$FMTE^XLFDT($$GET1^DIQ(409.84,APPTIEN_",",.2,"I"),"5D")
 S ARRAY(12)="AUTO CREATED VIA SD*5.3*846 POST INSTALL TO CORRECT DATA ISSUE"
 S ARRAY(13)=$G(SDDEMO("PRIGRP"))
 S ARRAY(14)="NO"
 S ARRAY(15)=0
 S ARRAY(16)=0
 S ARRAY(18)=$G(SDDEMO("SVCCONN"))
 S ARRAY(19)=$G(SDDEMO("SVCCONNP"))
 D ARSET^SDECAR2(.RETN,.ARRAY)
 S NEWREQIEN=$TR($P($P(RETN,"^",2),"ERRORTEXT",2),$C(30)_"_")
 Q:NEWREQIEN=-1
 S FDA(409.84,APPTIEN_",",.22)=NEWREQIEN_";SDEC(409.85,"
 D FILE^DIE("","FDA") ;update the appointment with the new request ien
 S TODAY=$$FMTE^XLFDT(DT,"5D")
 K ARRAY
 S ARRAY(1)=NEWREQIEN
 S ARRAY(2)="REMOVED/SCHEDULED-ASSIGNED"
 S ARRAY(3)=.5
 S ARRAY(4)=TODAY
 S ARRAY(5)=TODAY
 K RETN
 D ARCLOSE^SDECAR(.RETN,.ARRAY) ;Close the request that was just attached to the appointment.
 K ARRAY,RETN
 I APPTREQTYP="APPT" D
 . S REQSTAT=$$GET1^DIQ(409.85,REQIEN_",",23,"E")
 . S DISPOSITION=$$GET1^DIQ(409.85,REQIEN_",",21,"E")
 . Q:(DISPOSITION'="REMOVED/SCHEDULED-ASSIGNED")&(DISPOSITION'="")  ;if request is open or dispositioned other than scheduled quit
 . S RESCHED=$$RESCHEDULED(REQPATDFN,REQIEN)
 . Q:RESCHED  ;quit and do not reopen if already attached to the patient
 . I (REQSTAT="CLOSED") D
 .. S REOPEN="*"
 .. D AROPEN^SDECAR(.RETN,"",REQIEN,"") ;open the other patients request back up
 I APPTREQTYP="CONSULT" D
 . S CONSTAT=$$GET1^DIQ(123,CONSULTIEN,8,"E")
 . I CONSTAT="SCHEDULED"!(CONSTAT="COMPLETE") D
 .. S RESCHED=$$RESCHEDULED(REQPATDFN,CONSULTIEN)
 .. I 'RESCHED D
 ... S REOPEN="*"
 ... D OPENCONSULT(CONSULTIEN)
 Q
 ;
OPENCONSULT(CONSULTIEN) ;reopen consult if not already attached to appointment with correct patient
 ; SETUP REQUIRED VARIABLES THEN CALL THE FOLLOWING
 N PROVIEN,COMMENT,ORMSG
 S COMMENT(1)="Auto reopened via SD*5.3*846 Post Install - consult originally attached to incorrect patient appointment."
 S PROVIEN=$$GET1^DIQ(123,CONSULTIEN_",",10,"I")
 N SDERR S SDERR=$$STATUS^GMRCGUIS(CONSULTIEN,6,3,PROVIEN,"","",.COMMENT)
 Q
 ;
CONSULT(APPTREQINFO,APPTIEN,APPTDFN,APPTREQTYP,CNT,CONSULTIEN,NEWREQIEN) ;gather consult information
 N CONSULTIEN,CONSULTPATDFN,CONSULTPATIENT
 S CONSULTIEN=$P(APPTREQINFO,";",1)
 S CONSULTPATDFN=$$GET1^DIQ(123,CONSULTIEN_",",.02,"I")
 Q:APPTDFN=CONSULTPATDFN
 S CONSULTPATIENT=$$GET1^DIQ(123,CONSULTIEN_",",.02,"E")
 ;
 S REOPEN=""
 D DATACLEANUP(APPTDFN,APPTIEN,"",CONSULTPATDFN,APPTREQTYP,CONSULTIEN,.NEWREQIEN,.REOPEN)
 D REPORT(CONSULTIEN,APPTIEN,APPTREQTYP,NEWREQIEN,REOPEN,.CNT)
 Q
 ;
REPORT(REQIEN,APPTIEN,APPTREQTYP,NEWREQIEN,REOPEN,CNT) ;report of data cleanup
 S CNT=CNT+1
 S TEXTCNT=TEXTCNT+1
 S ^XTMP("SDES846P",TEXTCNT)=APPTREQTYP_"^`"_REQIEN_"^"_REOPEN_"^`"_APPTIEN_"^"_$$GET1^DIQ(409.84,APPTIEN_",",.01,"E")_"^"_$$GET1^DIQ(409.84,APPTIEN_",",.09,"E")_"^"_NEWREQIEN
 Q
 ;
RESCHEDULED(DFN,APPTREQINFO) ;check to see if the request is already attached to another appointment
 N DTLOOP,CHECKAPTIEN,CHKREQ,RESCHED,DATECANCELLED,DATENOSHOWED
 Q:DFN="" 0
 S RESCHED=0
 S DTLOOP=0 F  S DTLOOP=$O(^SDEC(409.84,"APTDT",DFN,DTLOOP)) Q:'DTLOOP  D
 .S CHECKAPTIEN=0 F  S CHECKAPTIEN=$O(^SDEC(409.84,"APTDT",DFN,DTLOOP,CHECKAPTIEN)) Q:'CHECKAPTIEN  D
 ..; only records that point to the same request
 ..S CHKREQ=$P($$GET1^DIQ(409.84,CHECKAPTIEN,.22,"I"),";")
 ..I CHKREQ'=APPTREQINFO Q
 ..; cancellation date/time
 ..S DATECANCELLED=$$GET1^DIQ(409.84,CHECKAPTIEN,.12,"I")
 ..; no-show date/time
 ..S DATENOSHOWED=$$GET1^DIQ(409.84,CHECKAPTIEN,.1,"I")
 ..I 'DATECANCELLED&'DATENOSHOWED S RESCHED=CHECKAPTIEN
 Q:('RESCHED) 0
 Q 1
 ;
TASK3 ; Disposition old Appointment Requests
 D MES^XPDUTL("")
 D MES^XPDUTL("   SD*5.3*846 Post-Install to fix Disposition records")
 D MES^XPDUTL("   in the SDEC APPT REQUEST (#409.85) file is being")
 D MES^XPDUTL("   queued to run in the background. Once it finishes")
 D MES^XPDUTL("   a MailMan message will be sent to the installer to")
 D MES^XPDUTL("   provide them a job completion status and data summary.")
 D MES^XPDUTL("")
 N ZTDESC,ZTRTN,ZTIO,ZTSK,X,ZTDTH,ZTSAVE
 S ZTDESC="SD*5.3*846 Post Install Routine"
 D NOW^%DTC S ZTDTH=X,ZTIO="",ZTRTN="DISP^SDES846P",ZTSAVE("*")="" D ^%ZTLOAD
 I $D(ZTSK) D
 . D MES^XPDUTL("  >>>Task "_ZTSK_" has been queued.")
 . D MES^XPDUTL("")
 I '$D(ZTSK) D
 . D MES^XPDUTL("  UNABLE TO QUEUE THIS JOB.")
 . D MES^XPDUTL("  Please contact the National Help Desk to report this issue.")
 Q
 ;
DISP ; Disposition old Appointment Requests
 N APPTIEN,ARIEN,CANCREAS,DATA0,DATA2,DISP,DISPIEN,FDA,IEN627,REOPEN,STARTTIME,TCNT
 S TCNT=0
 S IEN627=$$FIND1^DIC(9.7,"","X","SD*5.3*627","B","","ERROR")
 ; Quit if this site had the 627 install record and has already run this logic
 I IEN627 D  Q
 .S TEXT(1)="This sites Disposition records were reviewed and fixed by the"
 .S TEXT(2)="SD*5.3*842 post install routine."
 .S TEXT(3)="Nothing else needs to be done."
 .D MAIL
 ;
 S DISPIEN=$$FIND1^DIC(409.853,"","X","CANCELLED NOT RE-OPENED","B","","ERROR")
 I 'DISPIEN D  Q
 .S TEXT(1)="The CANCELLED NOT RE-OPENED Disposition Reason could not be found"
 .S TEXT(2)="in the SDEC DISPOSITION REASON (#409.853) file. Please contact the"
 .S TEXT(3)="National Help Desk to report this issue."
 .D MAIL
 ;
 S STARTTIME=3170505 ;Compliance Date for SD*5.3*627 = MAY 05, 2017
 S STARTTIME=STARTTIME-.000001
 F  S STARTTIME=$O(^SDEC(409.84,"B",STARTTIME)) Q:'STARTTIME  D
 .S APPTIEN=""
 .F  S APPTIEN=$O(^SDEC(409.84,"B",STARTTIME,APPTIEN)) Q:'APPTIEN  D
 ..S DATA0=$G(^SDEC(409.84,APPTIEN,0))
 ..; Quit is this appt is NOT cancelled
 ..S CANCREAS=$P(DATA0,U,22)
 ..Q:'CANCREAS
 ..; Quit it Appt Req should NOT be re-opened
 ..S REOPEN=$$GET1^DIQ(409.2,CANCREAS,5,"I")
 ..Q:REOPEN  ; 1=re-open 0=don't re-open
 ..; Quit if this appointment doesn't point back to #409.85
 ..S DATA2=$P($G(^SDEC(409.84,APPTIEN,2)),"^",1)
 ..Q:DATA2'["409.85"
 ..S ARIEN=$P(DATA2,";",1)
 ..Q:'ARIEN
 ..Q:'$D(^SDEC(409.85,ARIEN))
 ..; Quit if this Appt Req has already been Dispositioned
 ..Q:$P($G(^SDEC(409.85,ARIEN,"DIS")),U,3)
 ..; Set Disposition fields for update
 ..S FDA(409.85,ARIEN_",",19)=$P($$GET1^DIQ(409.84,APPTIEN,.12,"I"),".",1) ; FIX TO JUST BE A DATE
 ..S FDA(409.85,ARIEN_",",20)=$$GET1^DIQ(409.84,APPTIEN,.121,"I")
 ..S FDA(409.85,ARIEN_",",21)=DISPIEN
 ..D FILE^DIE("","FDA","ERR84")
 ..I '$D(ERR84) S TCNT=TCNT+1
 ..K FDA,ERR84
 S TEXT(1)="The SD*5.3*846 post install has run to completion."
 S TEXT(2)="The data was reviewed and updated without any issues."
 S TEXT(3)="Total Appoint Requests updated: "_TCNT
 D MAIL
 Q
 ;
MAIL ;
 ; Get Station Number
 ;
 N STANUM,MESS1,XMTEXT,XMSUB,XMY,XMDUZ,DIFROM
 S STANUM=$$KSP^XUPARAM("INST")_","
 S STANUM=$$GET1^DIQ(4,STANUM,99)
 S MESS1="Station: "_STANUM_" - "
 ;
 ; Send MailMan message
 S XMDUZ=DUZ
 S XMTEXT="TEXT("
 S XMSUB=MESS1_"SD*5.3*846 - Post Install Update"
 S XMDUZ=.5,XMY(DUZ)="",XMY(XMDUZ)=""
 D ^XMD
 K TEXT
 Q

EAS25UEI ;ALB/CKN - GEOGRAPHIC MEANS TEST PHASE II ; 03-MAR-2003
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**25**;Mar 15, 2001
 ;This post install routine will check inpatient/outpatient encounters,
 ;future appointments and fee basis authorizations to determine
 ;User Enrollee status for each Veteran in PATIENT(#2) file.
 ;User Enrollee data will be stored in PATIENT file and transmitted
 ;to HEC via Z07 HL7 messages.
 Q
EP ;Entry point
 N DONE,TXT
 ;create bulletin message in install file.
 S TXT(1)="The Post Install will now process through PATIENT (#2) file"
 S TXT(2)="to determine User Enrollee status for each Veteran by checking"
 S TXT(3)="inpatient/outpatient encounter for current fiscal year, any"
 S TXT(4)="future appointments and any fee basis authorizations."
 S TXT(5)=" "
 D BMES^XPDUTL(.TXT)
 ;check for completion of checkpoint, quit if checkpoint completed.
 ;create new checkpoint if necessary
 D CHECK Q:DONE
 D QUETASK
 Q
CHECK ;Initial checking
 N STAT,TASKNUM
 S DONE=0
 I '$D(^XTMP("EAS*1*25")) Q
 I $G(^XTMP("EAS*1*25","COMPLETED"))=1 D  Q
 . N MSG,XMDUZ,XMSUB,XMTEXT,XMY
 . S (XMDUZ,XMSUB)="USER ENROLLEE INITIAL DETERMINATION PROCESS"
 . S (XMY(.5),XMY(DUZ))="",XMTEXT="MSG("
 . S MSG(1)="User Enrollee initial determination process was completed in previous run."
 . S DONE=1 D ^XMD
 . D BMES^XPDUTL(.MSG)
 S TASKNUM=$G(^XTMP("EAS*1*25","TASK"))
 I TASKNUM'="" D
 . S STAT=$$ACTIVE(TASKNUM)
 . I STAT>0 D
 . . N MSG,XMDUZ,XMSUB,XMTEXT,XMY
 . . S (XMDUZ,XMSUB)="USER ENROLLEE INITIAL DETERMINATION PROCESS"
 . . S (XMY(.5),XMY(DUZ))="",XMTEXT="MSG("
 . . S MSG(1)="Task: "_TASKNUM_" is currently running User Enrollee determination"
 . . S MSG(2)="process. Duplicate process cannot be started."
 . . S DONE=1 D ^XMD
 . . D BMES^XPDUTL(.MSG)
 Q
ACTIVE(TASK) ;Checks if task is running or not
 ;  input  --  The taskman ID
 ;  output --  1=The task is running
 ;             0=The task is not running
 ;
 N ZTSK,STAT,Y
 S STAT=0,ZTSK=+TASK
 D STAT^%ZTLOAD
 S Y=ZTSK(1)
 I Y=0 S STAT=-1
 I ",1,2,"[(","_Y_",") S STAT=1
 I ",3,5,"[(","_Y_",") S STAT=0
 Q STAT
 ;
QUETASK ;Queue the task
 N TXT,ZTRTN,ZTDESC,ZTSK,ZTIO,ZTDTH
 S ZTRTN="EP1^EAS25UEI",ZTIO="",ZTDTH=$$NOW^XLFDT()
 S ZTDESC="USER ENROLLEE INITIAL DETERMINATION PROCESS"
 D ^%ZTLOAD S ^XTMP("EAS*1*25","TASK")=ZTSK
 S TXT(1)="Task: "_ZTSK_" Queued."
 D BMES^XPDUTL(.TXT)
 Q
EP1 ;Entry point
 N X,X1,X2,BDT,FDT,UEST,CNT,TXT,XIEN,TOT,ZTSTOP
 S ZTSTOP=0
 S XIEN=+$G(^XTMP("EAS*1*25","CURRENT IEN"))
 S X1=DT,X2=60 D C^%DTC
 S ^XTMP("EAS*1*25",0)=X_"^"_$$DT^XLFDT_"^EAS*1*25 GMT PHASE II-UE POST INSTALL"
 ;store start date
 I '$D(^XTMP("EAS*1*25","DATE")) S $P(^XTMP("EAS*1*25","DATE"),"^",1)=$$FMTE^XLFDT($$NOW^XLFDT(),"5P")
 S TOT=$P($G(^XTMP("EAS*1*25",1)),"^"),CNT=$P($G(^XTMP("EAS*1*25",1)),"^",2)
 ;Loop through Patient file (#2)
 F  S XIEN=$O(^DPT(XIEN)) Q:+XIEN=0!(ZTSTOP)  D
 . S TOT=TOT+1  ;processed records counter
 . S ^XTMP("EAS*1*25","CURRENT IEN")=XIEN
 . I (TOT#1000=0),$$S^%ZTLOAD S ZTSTOP=1  ;Check for Stop request
 . I $$DECEASED^EASMTUTL(XIEN) D  Q  ; Quit if Deceased
 . . S ^XTMP("EAS*1*25",1)=TOT_"^"_CNT
 . ;Remove current value to avoid any invalid data
 . S CURUE=$P($G(^DPT(XIEN,.361)),"^",7,8)
 . I $P(CURUE,"^")'=""!($P(CURUE,"^",2)'="") D
 . . S (DATA(.3617),DATA(.3618))="@"
 . . S UPD=$$UPD^DGENDBS(2,XIEN,.DATA)
 . . K UPD,DATA,CURUE
 . K TEMP
 . D SCHED,ENC,FBENC  ;Determine UE status
 . S UEST=$O(TEMP("UE",9999999),-1)  ;get last from all encounters
 . I +$G(UEST) D
 . . S CNT=CNT+1  ;User Enrollee counter
 . . I $$UPDCHK^EASUER(XIEN,UEST) D FILE^EASUER(XIEN,UEST)  ;file data
 . S ^XTMP("EAS*1*25",1)=TOT_"^"_CNT
 S $P(^XTMP("EAS*1*25","DATE"),"^",2)=$$FMTE^XLFDT($$NOW^XLFDT(),"5P")
 I ZTSTOP D  Q
 . N MSG,XMDUZ,XMSUB,XMTEXT,XMY
 . S (XMDUZ,XMSUB)="USER ENROLLEE INITIAL DETERMINATION PROCESS"
 . S (XMY(.5),XMY(DUZ))="",XMTEXT="MSG("
 . S MSG(1)="USER ENROLLEE INITIAL DETERMINATION PROCESS     TASK: "_$G(^XTMP("EAS*1*25","TASK"))
 . S MSG(2)=""
 . S MSG(3)="User Enrollee initial determination process is requested to stop"
 . S MSG(4)="by the user. Please restart the process by using the following"
 . S MSG(5)="command at the programmer prompt:"
 . S MSG(6)=""
 . S MSG(7)="D EP^EAS25UEI"
 . D ^XMD
 D MAIL  ;send mailman message to User
 S ^XTMP("EAS*1*25","COMPLETED")=1
 D BMES^XPDUTL("Post install process for initial User Enrollee determination is completed.")
 Q
SCHED ;Check for future appointment
 N XDT,NODE,SDRESULT
 D GETAPPT^SDAMA201(XIEN,1,"R",DT,,.SDRESULT)
 I SDRESULT>0 D
 . S NODE=$O(^TMP($J,"SDAMA201","GETAPPT",""),-1)
 . S XDT=$G(^TMP($J,"SDAMA201","GETAPPT",NODE,1))
 . S XDT=$$FY^EASUER(XDT) I +$G(XDT) S TEMP("UE",XDT)="SCH"
 Q
ENC ;Check for Inpatient/Outpatient encounters
 N ENC,DFN,SDRESULT,DFN,VAIP
 S ENC=$$EXOE^SDOEOE(XIEN,3021001,DT)
 I ENC D  Q
 . S XDT=$$FY^EASUER(DT),TEMP("UE",XDT)="ENC"
 I $O(^DPT(XIEN,"S",9999999))="" D  ;Get appt between Oct1 - today
 . D GETAPPT^SDAMA201(XIEN,1,"R",3021001,DT,.SDRESULT)
 . I SDRESULT>0 D
 . . S XDT=$$FY^EASUER(DT),TEMP("UE",XDT)="ENC"
 I $G(SDRESULT)>0 Q
 S DFN=XIEN D IN5^VADPT I +$G(VAIP(10)) D  Q  ;Check for Inpatient
 . S XDT=$$FY^EASUER(DT),TEMP("UE",XDT)="ENC"
 Q
FBENC ;Check for Fee basis encounters
 N EDATE,TDATE
 S TDATE=$$AUTH^FBGMT2(XIEN)
 I TDATE=0!(TDATE<3021001) Q
 S TDATE=$$FY^EASUER(TDATE) I +$G(TDATE) S TEMP("UE",TDATE)="FB"
 Q
MAIL ;
 N MSG,XMDUZ,XMSUB,XMTEXT,XMY,SITE,STATN,SITENM
 S SITE=$$SITE^VASITE,STATN=$P($G(SITE),"^",3),SITENM=$P($G(SITE),"^",2)
 S (XMDUZ,XMSUB)="GMTII - USER ENROLLEE INITIAL DETERMINATION PROCESS"
 S (XMY(DUZ),XMY(.5))="",XMY("NAIK.CHINTAN@FORUM.VA.GOV")=""
 S XMTEXT="MSG("
 S MSG(1)="User Enrollee initial determination process is completed successfully."
 S MSG(1.5)="Task: "_$G(^XTMP("EAS*1*25","TASK"))
 S MSG(2)=""
 S MSG(3)="Site Station number: "_STATN
 S MSG(4)="Site Name: "_SITENM
 S MSG(5)=""
 S MSG(6)="Process started at           : "_$P($G(^XTMP("EAS*1*25","DATE")),"^",1)
 S MSG(7)="Process completed at         : "_$P($G(^XTMP("EAS*1*25","DATE")),"^",2)
 S MSG(8)="Total Veterans processed     : "_$P($G(^XTMP("EAS*1*25",1)),"^",1)
 S MSG(9)="Total Veterans with UE status: "_$P($G(^XTMP("EAS*1*25",1)),"^",2)
 D ^XMD
 Q

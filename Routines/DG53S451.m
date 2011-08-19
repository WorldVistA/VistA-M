DG53S451 ;ALB/TDM - Combat Veteran End Date Synchronization ; 6/3/04 3:43pm
 ;;5.3;Registration;**451**; Aug 13,1993
 ;This post install routine will loop through the "E" cross reference
 ;of the PATIENT (#2) file and trigger a Z07 message to the HEC system
 ;for all entries that have a value in the COMBAT VETERAN END DATE
 ;(#.5295) field that is less than 1/17/03.
 Q
 ;
EP ;Entry point
 N OK
 D CHK Q:'OK
 D MSG
 D QUETASK
 Q
 ;
QUETASK ;Queue the task
 N TXT,ZTRTN,ZTDESC,ZTSK,ZTIO,ZTDTH
 S ZTRTN="EP1^DG53S451",ZTIO="",ZTDTH=$$NOW^XLFDT()
 S ZTDESC="COMBAT VETERAN END DATE SYNCHRONIZATION PROCESS"
 K ^XTMP("DG53S451")
 D ^%ZTLOAD S ^XTMP("DG53S451","TASK")=ZTSK
 S TXT(1)="Task: "_ZTSK_" Queued."
 D BMES^XPDUTL(.TXT)
 Q
 ;
EP1 ;Entry point
 N X1,X2,X,XCVDT,XIEN,TOT,CNT,EVENT,IYR
 S X1=DT,X2=60 D C^%DTC
 S ^XTMP("DG53S451",0)=X_"^"_$$DT^XLFDT_"^DG*5.3*451 HVE PHASE II POST INSTALL"
 S $P(^XTMP("DG53S451","DATE"),"^")=$$FMTE^XLFDT($$NOW^XLFDT(),"5P")
 ;
 ;Create index by patient.
 I $D(^DPT("E")) D
 . S (XCVDT,XIEN)=0
 . F  S XCVDT=$O(^DPT("E",XCVDT)) Q:XCVDT=""  D
 . . F  S XIEN=$O(^DPT("E",XCVDT,XIEN)) Q:XIEN=""  D
 . . . S ^XTMP("DG53S451","INDEX",XIEN)=""
 ;
 ;Loop through ^XTMP("DG53S451","INDEX") index.
 I $D(^XTMP("DG53S451","INDEX")) D
 . S (XIEN,TOT,CNT)=0,EVENT("ENROLL")=1
 . F  S XIEN=$O(^XTMP("DG53S451","INDEX",XIEN)) Q:+XIEN=0  D
 . . S CVDT=$P($G(^DPT(XIEN,.52)),"^",15) Q:'CVDT    ;No CV End Date
 . . S TOT=TOT+1,$P(^XTMP("DG53S451",1),"^")=TOT     ;Tot records
 . . Q:(CVDT>3030116)                                ;CVEDT>01/16/03
 . . S IYR=$$INCYR(XIEN) Q:'$$LOG^IVMPLOG(XIEN,IYR,.EVENT)  ;Queue Z07
 . . S CNT=CNT+1,$P(^XTMP("DG53S451",1),"^",2)=CNT   ;Tot Z07's queued
 . . S ^XTMP("DG53S451","INDEX",XIEN)="Z07 Queued"
 S $P(^XTMP("DG53S451","DATE"),"^",2)=$$FMTE^XLFDT($$NOW^XLFDT(),"5P")
 S ^XTMP("DG53S451","COMPLETED")=1
 D MAIL  ;send mailman message to User
 D BMES^XPDUTL("Post install process for Combat Veteran End Date synchronization is complete.")
 Q
 ;
CHK ;check for completion
 N TXT,TASKNUM,STAT
 S OK=1
 I $D(^XTMP("DG53S451","COMPLETED")) D
 . S OK=0
 . N TXT
 . S TXT(1)="The Combat Veteran End Date synchronization process was completed in a"
 . S TXT(2)="previous run.  Nothing Done!"
 . D BMES^XPDUTL(.TXT)
 ;
 S TASKNUM=$G(^XTMP("DG53S451","TASK"))
 I +TASKNUM D  Q
 . S STAT=$$ACTIVE(TASKNUM)
 . I STAT>0 D
 . . S OK=0
 . . S TXT(1)="Task: "_TASKNUM_" is currently running the Combat Veteran End Date"
 . . S TXT(2)="synchronization process. Duplicate processes cannot be started."
 . . D BMES^XPDUTL(.TXT)
 Q
 ;
MSG ;create bulletin message in install file.
 N TXT
 S TXT(1)="This Post Install routine will queue a Z07 HL7 message to be sent to the"
 S TXT(2)="Health Eligibility Center (HEC) for all entries in the PATIENT (#2) file"
 S TXT(3)="that have a value in the COMBAT VETERAN END DATE (#.5295) field that is"
 S TXT(4)="prior to 1/17/03. "
 S TXT(5)=" "
 D BMES^XPDUTL(.TXT)
 Q
 ;
MAIL N SITE,STATN,SITENM,XMDUZ,XMSUB,XMY,XMTEXT,MSG
 S SITE=$$SITE^VASITE,STATN=$P($G(SITE),"^",3),SITENM=$P($G(SITE),"^",2)
 S:$$GET1^DIQ(869.3,"1,",.03,"I")'="P" STATN=STATN_" [TEST]"
 S XMDUZ="CV END DATE SYNCHRONIZATION",XMSUB=XMDUZ_" - "_STATN_" (DG*5.3*451)"
 S (XMY(DUZ),XMY(.5))=""
 S XMY("terry.moore3@med.va.gov")="",XMY("pat.wilson@med.va.gov")=""
 S XMTEXT="MSG("
 S MSG(1)="Combat Veteran End Date synchronization process has completed successfully."
 S MSG(1.5)="Task: "_$G(^XTMP("DG53S451","TASK"))
 S MSG(2)=""
 S MSG(3)="Site Station number: "_STATN
 S MSG(4)="Site Name: "_SITENM
 S MSG(5)=""
 S MSG(6)="Process started at           : "_$P($G(^XTMP("DG53S451","DATE")),"^",1)
 S MSG(7)="Process completed at         : "_$P($G(^XTMP("DG53S451","DATE")),"^",2)
 S MSG(8)="Total Veterans processed     : "_+$P($G(^XTMP("DG53S451",1)),"^",1)
 S MSG(9)="Total Veterans queued for Z07: "_+$P($G(^XTMP("DG53S451",1)),"^",2)
 D ^XMD
 Q
 ;
INCYR(XIEN) ;Get valid income year
 N I,LMT,TMP,INCYR
 I $D(^IVM(301.5,"APT",XIEN)) Q $O(^IVM(301.5,"APT",XIEN,""),-1)
 F I=1,2,4 S LMT=$$LST^DGMTU(XIEN,,I) S:+$G(LMT) TMP($P(LMT,"^",2))=""
 I $D(TMP) S LMT=$O(TMP(""),-1),INCYR=($E(LMT,1,3)-1)_"0000" Q INCYR
 S INCYR=($E(DT,1,3)-1)_"0000"
 Q INCYR
 ;
ACTIVE(TASK) ;Checks if task is running
 ;  input  --  The taskman ID
 ;  output --  1=The task is running
 ;             0=The task is not running
 N STAT,ZTSK,Y
 S STAT=0,ZTSK=+TASK
 D STAT^%ZTLOAD
 S Y=ZTSK(1)
 I Y=0 S STAT=-1
 I ",1,2,"[(","_Y_",") S STAT=1
 I ",3,5,"[(","_Y_",") S STAT=0
 Q STAT

IVM2B102 ;ALB/PJR - IVM*2.0*102 POST-INSTALL ; 12/30/04 3:51pm
 ;;2.0;INCOME VERIFICATION MATCH;**102**; 21-OCT-94
 ;
 ;This post install routine will loop through patient file (#2)
 ;and trigger a Z07 message to the HEC system
 ;for all entries that have a value in the DATE OF DEATH field (#.351)
 ;and a value in the SOURCE OF NOTIFICATION field (#.353)
 ;of 1, 2, 3, 4, 5, 8, or 9
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
 S ZTRTN="EP1^IVM2B102",ZTIO="",ZTDTH=$$NOW^XLFDT()
 S ZTDESC="DOD ENHANCEMENT POST-INSTALL"
 D ^%ZTLOAD S ^XTMP("IVM2B102","TASK")=ZTSK
 S TXT(1)="Task: "_ZTSK_" Queued."
 D BMES^XPDUTL(.TXT)
 Q
 ;
EP1 ;Entry point
 N X,XIEN,EVENT,IYR,ZCNT,ZIEN,ZEND,ZDATE,ZEDATE
 L +^XTMP("IVM2B102"):1 E  Q
 S X=$G(^XTMP("IVM2B102",0)),ZCNT=+X,ZIEN=+$P(X,U,4),ZEND=ZCNT+4999
 S ZDATE=$$DT^XLFDT D IVM2
 S ^XTMP("IVM2B102",0)=ZCNT_U_ZDATE_U_X_U_ZIEN
 S $P(^XTMP("IVM2B102","DATE"),"^")=$$FMTE^XLFDT($$NOW^XLFDT(),"5P")
 D LMINUS
 ;Loop through patient file
 F  S ZIEN=$O(^DPT(ZIEN)) Q:ZCNT>ZEND!('ZIEN)  D
 .S X=$G(^DPT(ZIEN,.35)) I X,"^1^2^3^4^5^8^9^"[("^"_$P(X,"^",3)_"^") D
 ..S IYR=$$INCYR(ZIEN) Q:IYR=""
 ..Q:'$$LOG^IVMPLOG(ZIEN,IYR,.EVENT)  ;Queue Z07
 ..S ZCNT=ZCNT+1 ;Tot Z07's queued
 S $P(^XTMP("IVM2B102","DATE"),"^",2)=$$FMTE^XLFDT($$NOW^XLFDT(),"5P")
 S ZDATE=$$DT^XLFDT,ZEDATE=$$FMTE^XLFDT(DT) D IVM2
 S ^XTMP("IVM2B102",0)=ZCNT_U_ZDATE_U_X_U_(ZIEN-1)
 I 'ZIEN S ^XTMP("IVM2B102","COMPLETED")=1 D MAIL
 D IVM2 S X="The "_X_" process is complete"
 I ZIEN S X=X_" for "_ZEDATE
 S X=X_"." D BMES^XPDUTL(X)
 Q
 ;
CHK ;check for completion
 N TXT,TASKNUM,STAT
 S OK=1 L +^XTMP("IVM2B102"):1 E  D  Q
 .S OK=0 D IVM2 S TXT(1)=X_" process has a lock table"
 .S TXT(2)="problem.  Nothing Done!"
 .D BMES^XPDUTL(.TXT),LMINUS
 ;
 I $G(^XTMP("IVM2B102","COMPLETED")) D  Q
 .S OK=0 D IVM2 S TXT(1)=X_" process was completed in a"
 .S TXT(2)="previous run.  Nothing Done!"
 .D BMES^XPDUTL(.TXT),LMINUS
 ;
 S X=$G(^XTMP("IVM2B102",0))
 I $$DT^XLFDT=$P(X,U,2) D  Q
 .S OK=0 D IVM2 S TXT(1)=X_" is complete for today."
 .S TXT(2)="Please re-start tomorrow."
 .D BMES^XPDUTL(.TXT),LMINUS
 ;
 S TASKNUM=$G(^XTMP("IVM2B102","TASK"))
 I +TASKNUM D  Q
 .S STAT=$$ACTIVE(TASKNUM)
 .I STAT>0 D
 ..S OK=0 D IVM2
 ..S TXT(1)="Task: "_TASKNUM_" is currently running the"
 ..S TXT(2)=X_" process."
 ..S TXT(3)="Duplicate processes cannot be started."
 ..D BMES^XPDUTL(.TXT)
 .D LMINUS
 ;
 D LMINUS Q
 ;
MSG ;create bulletin message in install file.
 N TXT
 S TXT(1)="This Post Install routine will queue a Z07 HL7 message to be sent to the"
 S TXT(2)="Health Eligibility Center (HEC) for all entries in the PATIENT (#2) file"
 S TXT(3)="that have a value in the DATE OF DEATH (#.531) field and a"
 S TXT(4)="SOURCE OF NOTIFICATION (#.533) value of 1, 2, 3, 4, 5, 8, or 9"
 S TXT(5)=" "
 D BMES^XPDUTL(.TXT)
 Q
 ;
MAIL N SITE,STATN,SITENM,XMDUZ,XMSUB,XMY,XMTEXT,MSG
 S SITE=$$SITE^VASITE,STATN=$P($G(SITE),"^",3),SITENM=$P($G(SITE),"^",2)
 S:$$GET1^DIQ(869.3,"1,",.03,"I")'="P" STATN=STATN_" [TEST]"
 D IVM2 S XMDUZ=X,XMSUB=XMDUZ_" - "_STATN_" (IVM*2.0*102)"
 S (XMY(DUZ),XMY(.5))=""
 S XMTEXT="MSG(" D IVM2
 S MSG(1)="The "_X_" process"
 S MSG(2)="has completed successfully."
 S MSG(3)="Task: "_$G(^XTMP("IVM2B102","TASK"))
 S MSG(4)=""
 S MSG(5)="Site Station number: "_STATN
 S MSG(6)="Site Name: "_SITENM
 S MSG(7)=""
 S MSG(8)="Final process started at     : "_$P($G(^XTMP("IVM2B102","DATE")),"^",1)
 S MSG(8)="Final process completed at   : "_$P($G(^XTMP("IVM2B102","DATE")),"^",2)
 S MSG(10)="Total Veterans queued for Z07: "_+$G(^XTMP("IVM2B102",0))
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
IVM2 S X="IVM*2.0*102 DOD Post-Install transmit Z07's to HEC" Q
LMINUS L -^XTMP("IVM2B102") Q

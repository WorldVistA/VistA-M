DG53B563 ;ALB/PJR - DOD Enhancement Post-Install ; 12/30/04 3:53pm
 ;;5.3;Registration;**563**; Aug 13,1993
 ;This post install routine will loop through patient file (#2)
 ;and delete the DEATH ENTERED BY field
 ;for all entries that have NO value in the DATE OF DEATH field (#.351)
 ;but DO have a value in the DEATH ENTERED BY field (#.352)
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
 S ZTRTN="EP1^DG53B563",ZTIO="",ZTDTH=$$NOW^XLFDT()
 S ZTDESC="DOD ENHANCEMENT POST-INSTALL"
 K ^XTMP("DG53B563")
 D ^%ZTLOAD S ^XTMP("DG53B563","TASK")=ZTSK
 S TXT(1)="Task: "_ZTSK_" Queued."
 D BMES^XPDUTL(.TXT)
 Q
 ;
EP1 ;Entry point
 N ZCNT,ZIEN,ZEND,ZDATE,ZEDATE,DA,DIE,DR,ZCK,ZII,ZXX,X
 L +^XTMP("DG53B563"):1 E  Q
 S (ZIEN,ZCNT)=0
 S ZDATE=$$DT^XLFDT D DG53
 S ^XTMP("DG53B563",0)=ZCNT_U_ZDATE_U_X
 S $P(^XTMP("DG53B563","DATE"),"^")=$$FMTE^XLFDT($$NOW^XLFDT(),"5P")
 D LMINUS
 ;Loop through patient file
 F  S ZIEN=$O(^DPT(ZIEN)) Q:'ZIEN  D
 .S ZXX=$G(^DPT(ZIEN,.35)),ZCK=0 I ZXX=""!ZXX Q
 .F ZII=1,2,3,5 I $P(ZXX,U,ZII)]"" S ZCK=1 D
 ..S DA=ZIEN,DIE="^DPT(",DR=".35"_ZII_"////@" D ^DIE
 .I ZCK S ZCNT=ZCNT+1 ;Tot records updated
 S $P(^XTMP("DG53B563","DATE"),"^",2)=$$FMTE^XLFDT($$NOW^XLFDT(),"5P")
 S ZDATE=$$DT^XLFDT,ZEDATE=$$FMTE^XLFDT(DT) D DG53
 S ^XTMP("DG53B563",0)=ZCNT_U_ZDATE_U_X
 S ^XTMP("DG53B563","COMPLETED")=1 D MAIL
 D DG53 S X="The "_X_" process is complete."
 D BMES^XPDUTL(X)
 Q
 ;
CHK ;check for completion
 N TXT,TASKNUM,STAT
 S OK=1 L +^XTMP("DG53B563"):1 E  D  Q
 .S OK=0 D DG53 S TXT(1)=X_" process has a lock table"
 .S TXT(2)="problem.  Nothing Done!"
 .D BMES^XPDUTL(.TXT),LMINUS
 ;
 I $G(^XTMP("DG53B563","COMPLETED")) D  Q
 .S OK=0 D DG53 S TXT(1)=X_" process was completed in a"
 .S TXT(2)="previous run.  Nothing Done!"
 .D BMES^XPDUTL(.TXT),LMINUS
 ;
 S TASKNUM=$G(^XTMP("DG53B563","TASK"))
 I +TASKNUM D  Q
 .S STAT=$$ACTIVE(TASKNUM)
 .I STAT>0 D
 ..S OK=0 D DG53
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
 S TXT(1)="This Post Install routine will loop through the Patient (#2) file"
 S TXT(2)="and delete the DEATH ENTERED BY field for all patients"
 S TXT(3)="that have NO value in the DATE OF DEATH (#.531) field"
 S TXT(4)="but DO have a value in the DEATH ENTERED BY field."
 S TXT(5)=" "
 D BMES^XPDUTL(.TXT)
 Q
 ;
MAIL N SITE,STATN,SITENM,XMDUZ,XMSUB,XMY,XMTEXT,MSG
 S SITE=$$SITE^VASITE,STATN=$P($G(SITE),"^",3),SITENM=$P($G(SITE),"^",2)
 S:$$GET1^DIQ(869.3,"1,",.03,"I")'="P" STATN=STATN_" [TEST]"
 D DG53 S XMDUZ=X,XMSUB=XMDUZ_" - "_STATN_" (DG*5.3*563)"
 S (XMY(DUZ),XMY(.5))=""
 S XMTEXT="MSG(" D DG53
 S MSG(1)="The "_X_" process"
 S MSG(2)="has completed successfully."
 S MSG(3)="Task: "_$G(^XTMP("DG53B563","TASK"))
 S MSG(4)=""
 S MSG(5)="Site Station number: "_STATN
 S MSG(6)="Site Name: "_SITENM
 S MSG(7)=""
 S MSG(8)="Process started at    : "_$P($G(^XTMP("DG53B563","DATE")),"^",1)
 S MSG(8)="Process completed at  : "_$P($G(^XTMP("DG53B563","DATE")),"^",2)
 S MSG(10)="Total Veterans updated: "_+$G(^XTMP("DG53B563",0))
 D ^XMD
 Q
 ;
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
DG53 S X="DG*5.3*563 DOD Post-Install cleanup DEATH ENTERED BY" Q
LMINUS L -^XTMP("DG53B563") Q

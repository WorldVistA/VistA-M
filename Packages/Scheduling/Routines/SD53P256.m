SD53P256 ;ALB/RPM - Pre/Post-Install;15-Nov-2001
 ;;5.3;Scheduling;**256**;Aug 13, 1993
 ;
 ;
ENV ;Main entry point for Environment check point.
 ;
 S XPDABORT=""
 D PROGCHK(.XPDABORT) ;checks programmer variables
 I XPDABORT="" K XPDABORT
 Q
 ;
 ;
PRE ;Main entry point for Pre-init items.
 ;
 Q
 ;
 ;
POST ;Main entry point for Post-init items.
 ;
 D POST1
 Q
 ;
 ;
PROGCHK(XPDABORT) ;checks for necessary programmer variables
 ;
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") DO
 .D BMES^XPDUTL("*****")
 .D MES^XPDUTL("Your programming variables are not set up properly.")
 .D MES^XPDUTL("Installation aborted.")
 .D MES^XPDUTL("*****")
 .S XPDABORT=2
 Q
 ;
POST1 ;Set up TaskMan to re-queue AmbCare records in the background
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSK
 S ZTRTN="SCAN^SD53P256"
 S ZTDESC="Re-queue AmbCare records for SD*5.3*256"
 ;Queue Task to start in 60 seconds
 S ZTDTH=$$SCH^XLFDT("60S",$$NOW^XLFDT)
 S ZTIO=""
 D ^%ZTLOAD
 D BMES^XPDUTL("*****")
 D
 . I $D(ZTSK)[0 D  Q
 . . D MES^XPDUTL("TaskMan task to requeue AmbCare records for SD*5.3*256 did not start.")
 . . D MES^XPDUTL("Re-run post-install routine POST^SD53P256.")
 . D MES^XPDUTL("Task "_ZTSK_" started to re-queue AmbCare records.")
 . I $D(ZTSK("D")) D
 . . D MES^XPDUTL("Task will start at "_$$HTE^XLFDT(ZTSK("D")))
 D MES^XPDUTL("*****")
 Q
 ;
SCAN ;Scan the OUTPATIENT CLASSIFICATION file (#409.42) for patients
 ;who have an Outpatient Classification Type of 6 - "HEAD AND/OR NECK
 ;CANCER".  Use $$FINDXMIT^SCDXFU01 to find corresponding entry in
 ;TRANSMITTED OUTPATIENT ENCOUNTER file (#409.73).
 ;
 N SDIEN    ;Outpatient Classification file IEN
 N SDTIEN   ;Transmitted Outpatient Encounter file IEN
 N SDENCPTR ;Outpatient Encounter file pointer
 N SDTYPE6  ;Count of encounters w/Type 6
 N SDREQUE  ;Count of messages re-queued
 N SDSTART  ;start date/time
 ;
 S SDSTART=$$NOW^XLFDT
 S (SDIEN,SDREQUE,SDTYPE6)=0
 F  S SDIEN=$O(^SDD(409.42,"B",6,SDIEN)) Q:'SDIEN  D
 . S SDTYPE6=SDTYPE6+1
 . S SDENCPTR=$P($G(^SDD(409.42,SDIEN,0)),U,2)
 . Q:'SDENCPTR
 . ;locate last transmitted message
 . S SDTIEN=$$FINDXMIT^SCDXFU01(SDENCPTR)
 . Q:'SDTIEN
 . ;store event information
 . D STREEVNT^SCDXFU01(SDTIEN,0)
 . ;set transmission flag to 'YES'
 . D XMITFLAG^SCDXFU01(SDTIEN)
 . S SDREQUE=SDREQUE+1
 ;send completion MailMan message
 D NOTIFY(SDSTART,SDREQUE,SDTYPE6)
 ;delete the task entry
 S ZTREQ="@"
 Q
 ;
NOTIFY(SDSTIME,SDREQ,SDTYP6) ;send job completion msg
 ;
 ;  Input
 ;    SDSTIME - job start date/time
 ;    SDREQ - count of AmbCare messages re-queued
 ;    SDTYP6 - count of Type 6 encounters
 ;
 ;  Output
 ;    none
 ;
 N DIFROM,XMDUZ,XMSUB,XMTEXT,XMY,XMZ
 N SDSITE,SDETIME,SDTEXT
 S SDSITE=$$SITE^VASITE
 S SDETIME=$$NOW^XLFDT
 S XMDUZ="AmbCare Re-queue"
 S XMSUB="Patch SD*5.3*256 Mill Bill Co-Pay Enhancements"
 S XMTEXT="SDTEXT("
 S XMY(DUZ)=""
 S SDTEXT(1)=""
 S SDTEXT(2)="          Facility Name:  "_$P(SDSITE,U,2)
 S SDTEXT(3)="         Station Number:  "_$P(SDSITE,U,3)
 S SDTEXT(4)=""
 S SDTEXT(5)="  Date/Time job started:  "_$$FMTE^XLFDT(SDSTIME)
 S SDTEXT(6)="  Date/Time job stopped:  "_$$FMTE^XLFDT(SDETIME)
 S SDTEXT(7)=""
 S SDTEXT(8)="Total Head/Neck Cancer Encounters: "_SDTYP6
 S SDTEXT(9)="Total AmbCare records re-queued  : "_SDREQ
 D ^XMD
 Q

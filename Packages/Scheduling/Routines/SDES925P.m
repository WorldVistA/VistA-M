SDES925P ;ALB/LAB - SD*5.3*925 Post Init Routine ; Aug 12, 2025
 ;;5.3;SCHEDULING;**925**;AUG 13, 1993;Build 1
  ;;Per VHA Directive 6402, this routine should not be modified
 ;;
 Q
 ;
EN ;
 D TASK
 Q
 ;
 ;
TASK ; tasks off process to update the direct patient schedule field in the hospital location file
 D MES^XPDUTL("")
 D MES^XPDUTL(" SD*5.3*925 Post-Install to remove erroneous patient comments from appointment")
 D MES^XPDUTL("")
 N ZTDESC,ZTRTN,ZTIO,ZTSK,X,ZTDTH,ZTSAVE
 S ZTDESC="SD*5.3*925 Post Install Routine Task 1"
 D NOW^%DTC
 S ZTDTH=X,ZTIO="",ZTRTN="PATCOM^SDES925P",ZTSAVE("*")=""
 D ^%ZTLOAD
 I $D(ZTSK) D
 . D MES^XPDUTL(" >>>Task "_ZTSK_" has been queued.")
 . D MES^XPDUTL("")
 I '$D(ZTSK) D
 . D MES^XPDUTL(" UNABLE TO QUEUE THIS JOB.")
 . D MES^XPDUTL(" Please contact the National Help Desk to report this issue.")
 Q
PATCOM ;
 N APPTIEN,CREATEDT,UPDATECNT,FDA
 K ^XTMP("SDES925P")
 S ^XTMP("SDES925P",0)=$$FMADD^XLFDT(DT,30)_"^"_DT_"^SD*5.3*925"
 K FDA
 S UPDATECNT=1
 S ^XTMP("SDES925P",UPDATECNT)="Appointment IEN with patient comments removed"
 S UPDATECNT=UPDATECNT+1
 S CREATEDT=3240205 ;compliance date of patch sd*5.3*866
 F  S CREATEDT=$O(^SDEC(409.84,"AC",CREATEDT)) Q:CREATEDT=""  D
 . S APPTIEN=""
 . F  S APPTIEN=$O(^SDEC(409.84,"AC",CREATEDT,APPTIEN)) Q:APPTIEN=""  D
 . . I $$GET1^DIQ(409.84,APPTIEN,.22,"E")'="APPT" D
 . . . I $D(^SDEC(409.84,APPTIEN,6)) D
 . . . . S ^XTMP("SDES925P",UPDATECNT)=APPTIEN
 . . . . S UPDATECNT=UPDATECNT+1
 . . . . S FDA(409.84,APPTIEN_",",4)="@"
 . . . . D FILE^DIE(,"FDA") K FDA
 S ^XTMP("SDES925P",UPDATECNT)="Total count = "_(UPDATECNT-2)
 D MAIL
 K ^XTMP("SDES925P")
 Q
 ;
MAIL     ;
 N STANUM,MESS1,XMTEXT,XMSUB,XMY,XMDUZ,DIFROM,%,D,D0,D1,D2,DG,DIC,DICR,DIW,XMDUN,XMZ
 S STANUM=$$KSP^XUPARAM("INST")_","
 S STANUM=$$GET1^DIQ(4,STANUM,99)
 S MESS1="Station: "_STANUM_" - "
 S XMDUZ=DUZ
 S XMTEXT="^XTMP(""SDES925P"","
 S XMSUB=MESS1_"SD*5.3*925 - Post Install Data Report"
 S XMDUZ=.5,XMY(DUZ)="",XMY(XMDUZ)=""
 S XMY("BARBER.LORI@DOMAIN.EXT")=""
 S XMY("DUNNAM.DAVID@DOMAIN.EXT")=""
 S XMY("CRUZ.ORLANDO@DOMAIN.EXT")=""
 D ^XMD
 Q
 ;

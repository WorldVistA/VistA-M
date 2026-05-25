SDES897P ;ALB/MGD,JAS - SD*5.3*897 Post Init Routine ; DEC 06, 2024
 ;;5.3;SCHEDULING;**897**;AUG 13, 1993;Build 2
 ;;Per VHA Directive 6402, this routine should not be modified
 ;;
 Q
 ;
EN ; Update the VS GUI version in #409.98
 D FIND
 D TASK
 D TASK2
 D TASK3
 D TASK4
 Q
 ;
 ;
FIND ;FIND THE IEN FOR "VS GUI NATIONAL"
 N SDECDA,SDECDA1
 D MES^XPDUTL("")
 D MES^XPDUTL("   Updating SDEC SETTINGS file (#409.98)")
 S SDECDA=0,SDECDA=$O(^SDEC(409.98,"B","VS GUI NATIONAL",SDECDA)) G:$G(SDECDA)="" NOFIND
 D VERSION   ;update GUI version number and date
 Q
VERSION ;SET THE NEW VERSION UPDATE IN SDEC SETTING FILE #409.98 TO 1.7.63
 S DA=SDECDA,DIE=409.98,DR="2///1.7.63;3///"_DT D ^DIE  ;update VS GUI NATIONAL
 K DIE,DR,DA
 S SDECDA1=0,SDECDA1=$O(^SDEC(409.98,"B","VS GUI LOCAL",SDECDA1)) Q:$G(SDECDA1)=""    ;get DA for the VS GUI LOCAL
 S DA=SDECDA1,DIE=409.98,DR="2///1.7.63;3///"_DT D ^DIE  ;update VS GUI LOCAL
 K DIE,DR,DA
 Q
 ;
NOFIND ;"VS GUI NATIONAL" NOT FOUND
 D MES^XPDUTL("   VS GUI NATIONAL not found in the SDEC SETTINGS file (#409.98)")
 Q
 ;
TASK ;
 D MES^XPDUTL("")
 D MES^XPDUTL("   SD*5.3*897 Post-Install to clear control characters from the CANCELLATION REMARKS")
 D MES^XPDUTL("   (#17) field from the APPOINTMENT (#2.98) sub-file of the PATIENT (#2) file")
 D MES^XPDUTL("   is being queued to run in the background.")
 D MES^XPDUTL("")
 N ZTDESC,ZTRTN,ZTIO,ZTSK,X,ZTDTH,ZTSAVE
 S ZTDESC="SD*5.3*897 Post Install Routine"
 D NOW^%DTC S ZTDTH=X,ZTIO="",ZTRTN="CLNREMRKS^SDES897P",ZTSAVE("*")="" D ^%ZTLOAD
 I $D(ZTSK) D
 . D MES^XPDUTL("  >>>Task "_ZTSK_" has been queued.")
 . D MES^XPDUTL("")
 I '$D(ZTSK) D
 . D MES^XPDUTL("  UNABLE TO QUEUE THIS JOB.")
 . D MES^XPDUTL("  Please contact the National Help Desk to report this issue.")
 Q
 ;
CLNREMRKS ;
 N APPTIEN,FDA,REM,SDDFN
 S SDDFN=0
 F  S SDDFN=$O(^DPT(SDDFN)) Q:'SDDFN  I $D(^DPT(SDDFN,"S")) D
 . S APPTIEN=0
 . F  S APPTIEN=$O(^DPT(SDDFN,"S",APPTIEN)) Q:'APPTIEN  D
 . . S REM=$$GET1^DIQ(2.98,APPTIEN_","_SDDFN_",",17,"I")
 . . I REM?.E1C.E D
 . . . S REM=$$CTRL^XMXUTIL1(REM)
 . . . S FDA(2.98,APPTIEN_","_SDDFN_",",17)=REM
 . . . D FILE^DIE("","FDA") K FDA
 Q
 ;
TASK2 ; tasks off process to remove control characters from Recall Reminders file
 D MES^XPDUTL("")
 D MES^XPDUTL("   SD*5.3*897 Post-Install to clear control characters from the COMMENT")
 D MES^XPDUTL("   (#2.5) field from the RECALL REMINDERS (#403.5) file and its COMMENT")
 D MES^XPDUTL("   AUDIT (#403.57) sub-file is being queued to run in the background.")
 D MES^XPDUTL("")
 N ZTDESC,ZTRTN,ZTIO,ZTSK,X,ZTDTH,ZTSAVE
 S ZTDESC="SD*5.3*897 Post Install Routine Task 2"
 D NOW^%DTC S ZTDTH=X,ZTIO="",ZTRTN="CLNRECREMS^SDES897P",ZTSAVE("*")="" D ^%ZTLOAD
 I $D(ZTSK) D
 . D MES^XPDUTL("  >>>Task "_ZTSK_" has been queued.")
 . D MES^XPDUTL("")
 I '$D(ZTSK) D
 . D MES^XPDUTL("  UNABLE TO QUEUE THIS JOB.")
 . D MES^XPDUTL("  Please contact the National Help Desk to report this issue.")
 Q
 ;
CLNRECREMS ;
 ;
 N RECREQIEN,COMAUDIEN,COMMENT,COMMENTS,FDA
 S RECREQIEN=0
 F  S RECREQIEN=$O(^SD(403.5,RECREQIEN)) Q:'RECREQIEN  I $D(^SD(403.5,RECREQIEN,0)) D
 . S COMMENTS=$$GET1^DIQ(403.5,RECREQIEN,2.5,"E") I COMMENTS?.E1C.E D
 . . S COMMENTS=$$CTRL^XMXUTIL1(COMMENTS)
 . . S FDA(403.5,RECREQIEN_",",2.5)=COMMENTS
 . . D FILE^DIE("","FDA") K FDA
 . . ;
 . . S COMAUDIEN=0
 . . F  S COMAUDIEN=$O(^SD(403.5,RECREQIEN,2,COMAUDIEN)) Q:'COMAUDIEN  D
 . . . Q:'$D(^SD(403.5,RECREQIEN,2,COMAUDIEN,0))
 . . . S COMMENT=$$GET1^DIQ(403.57,COMAUDIEN_","_RECREQIEN_",",2)
 . . . I COMMENT?.E1C.E D
 . . . . S FDA(403.57,COMAUDIEN_","_RECREQIEN_",",2)=$$CTRL^XMXUTIL1(COMMENT)
 . . . . D FILE^DIE("","FDA") K FDA
 Q
 ;
TASK3 ; tasks off process to remove control characters from SDEC Appt Request file
 D MES^XPDUTL("")
 D MES^XPDUTL("   SD*5.3*897 Post-Install to clear control characters from the COMMENTS")
 D MES^XPDUTL("   (#25) field from the SDEC APPT REQUEST (#409.85) file and its COMMENTS")
 D MES^XPDUTL("   AUDIT (#409.8527) sub-file is being queued to run in the background.")
 D MES^XPDUTL("")
 N ZTDESC,ZTRTN,ZTIO,ZTSK,X,ZTDTH,ZTSAVE
 S ZTDESC="SD*5.3*897 Post Install Routine Task 3"
 D NOW^%DTC S ZTDTH=X,ZTIO="",ZTRTN="CLNAPREQS^SDES897P",ZTSAVE("*")="" D ^%ZTLOAD
 I $D(ZTSK) D
 . D MES^XPDUTL("  >>>Task "_ZTSK_" has been queued.")
 . D MES^XPDUTL("")
 I '$D(ZTSK) D
 . D MES^XPDUTL("  UNABLE TO QUEUE THIS JOB.")
 . D MES^XPDUTL("  Please contact the National Help Desk to report this issue.")
 Q
 ;
CLNAPREQS ;
 ;
 N APREQIEN,COMAUDIEN,COMMENT,COMMENTS,FDA
 S APREQIEN=0
 F  S APREQIEN=$O(^SDEC(409.85,APREQIEN)) Q:'APREQIEN  I $D(^SDEC(409.85,APREQIEN,0)) D
 . Q:$$GET1^DIQ(409.85,APREQIEN,23,"I")="C"
 . S COMMENTS=$$GET1^DIQ(409.85,APREQIEN,25,"E") I COMMENTS?.E1C.E D
 . . S COMMENTS=$$CTRL^XMXUTIL1(COMMENTS)
 . . S FDA(409.85,APREQIEN_",",25)=COMMENTS
 . . D FILE^DIE("","FDA") K FDA
 . . ;
 . . S COMAUDIEN=0
 . . F  S COMAUDIEN=$O(^SDEC(409.85,APREQIEN,"COMAUD",COMAUDIEN)) Q:'COMAUDIEN  D
 . . . S COMMENT=$$GET1^DIQ(409.8527,COMAUDIEN_","_APREQIEN_",",2)
 . . . I COMMENT?.E1C.E D
 . . . . S FDA(409.8527,COMAUDIEN_","_APREQIEN_",",2)=$$CTRL^XMXUTIL1(COMMENT)
 . . . . D FILE^DIE("","FDA") K FDA
 Q
 ;
TASK4 ; tasks off process to remove control characters from SDEC Appointment file
 D MES^XPDUTL("")
 D MES^XPDUTL("   SD*5.3*897 Post-Install to clear control characters from the NOTE")
 D MES^XPDUTL("   (#1) field from the SDEC APPOINTMENT (#409.84) file and its NOTE")
 D MES^XPDUTL("   AUDIT (#409.847) sub-file is being queued to run in the background.")
 D MES^XPDUTL("")
 N ZTDESC,ZTRTN,ZTIO,ZTSK,X,ZTDTH,ZTSAVE
 S ZTDESC="SD*5.3*897 Post Install Routine Task 4"
 D NOW^%DTC S ZTDTH=X,ZTIO="",ZTRTN="CLNAPPTS^SDES897P",ZTSAVE("*")="" D ^%ZTLOAD
 I $D(ZTSK) D
 . D MES^XPDUTL("  >>>Task "_ZTSK_" has been queued.")
 . D MES^XPDUTL("")
 I '$D(ZTSK) D
 . D MES^XPDUTL("  UNABLE TO QUEUE THIS JOB.")
 . D MES^XPDUTL("  Please contact the National Help Desk to report this issue.")
 Q
 ;
CLNAPPTS ;
 ;
 N APPTIEN,APREQIEN,COMAUDIEN,COMMARRAY,COMMENT,COMMENTS,COMMIEN,DATEIEN,EDITEDNOTE,FDA,REQREC
 S DATEIEN=3231130.999999
 F  S DATEIEN=$O(^SDEC(409.84,"B",DATEIEN)) Q:'DATEIEN  D
 . S APPTIEN=0
 . F  S APPTIEN=$O(^SDEC(409.84,"B",DATEIEN,APPTIEN)) Q:'APPTIEN  I $D(^SDEC(409.84,APPTIEN,1)) D
 . . S REQREC=$$GET1^DIQ(409.84,APPTIEN_",",.22,"I")
 . . Q:REQREC'[409.85
 . . S APREQIEN=$P(REQREC,";")
 . . S COMMENTS=$$GET1^DIQ(409.85,APREQIEN,25,"E") I COMMENTS?.E1C.E D
 . . . ; Clean associated appt req record
 . . . S COMMENTS=$$CTRL^XMXUTIL1(COMMENTS)
 . . . S FDA(409.85,APREQIEN_",",25)=COMMENTS
 . . . D FILE^DIE("","FDA") K FDA
 . . . ;
 . . . S COMAUDIEN=0
 . . . F  S COMAUDIEN=$O(^SDEC(409.85,APREQIEN,"COMAUD",COMAUDIEN)) Q:'COMAUDIEN  D
 . . . . S COMMENT=$$GET1^DIQ(409.8527,COMAUDIEN_","_APREQIEN_",",2)
 . . . . I COMMENT?.E1C.E D
 . . . . . S FDA(409.8527,COMAUDIEN_","_APREQIEN_",",2)=$$CTRL^XMXUTIL1(COMMENT)
 . . . . . D FILE^DIE("","FDA") K FDA
 . . ;
 . . ; Now clean appt record
 . . S COMMIEN=0
 . . K COMMARRAY
 . . F  S COMMIEN=$O(^SDEC(409.84,APPTIEN,1,COMMIEN)) Q:'COMMIEN  S COMMARRAY(COMMIEN)=^SDEC(409.84,APPTIEN,1,COMMIEN,0)
 . . I $D(COMMARRAY) D
 . . . S COMMENTS=$$WPSTR^SDECUTL(.COMMARRAY)
 . . . I COMMENTS?.E1C.E D
 . . . . S EDITEDNOTE(1)=$$CTRL^XMXUTIL1(COMMENTS)
 . . . . D WP^DIE(409.84,APPTIEN_",",1,"","EDITEDNOTE")
 . . . . ;
 . . . . S COMAUDIEN=0
 . . . . F  S COMAUDIEN=$O(^SDEC(409.84,APPTIEN,"NOTEAUD",COMAUDIEN)) Q:'COMAUDIEN  D
 . . . . . S COMMENT=$$GET1^DIQ(409.847,COMAUDIEN_","_APPTIEN_",",2)
 . . . . . I COMMENT?.E1C.E D
 . . . . . . S FDA(409.847,COMAUDIEN_","_APPTIEN_",",2)=$$CTRL^XMXUTIL1(COMMENT)
 . . . . . . D UPDATE^DIE("","FDA") K FDA
 Q

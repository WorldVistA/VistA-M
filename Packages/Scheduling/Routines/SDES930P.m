SDES930P ;ALB/RN - SD*5.3*930 Post Init Routine ; MAR 03, 2026
 ;;5.3;SCHEDULING;**930**;AUG 13, 1993;Build 4
 ;;Per VHA Directive 6402, this routine should not be modified
 ;;
 Q
 ;
EN ;  ; Report of Clinics with Default Appointment type of "WORLD WAR II"
 D TASK
 Q
 ;
TASK ;
 D MES^XPDUTL("")
 D MES^XPDUTL("   SD*5.3*930 Post-Install creates a Report of Clinics")
 D MES^XPDUTL("   that have WORLD WAR II as default appointment type.")
 D MES^XPDUTL("   Job is queued to run in the background. Once it finishes")
 D MES^XPDUTL("   a MailMan message will be sent to Chad Mitchell, Katherine")
 D MES^XPDUTL("   and Siobhan to provide them the Clinic Report details.")
 D MES^XPDUTL("")
 N ZTDESC,ZTRTN,ZTIO,ZTSK,X,ZTDTH,ZTSAVE
 S ZTDESC="SD*5.3*930 Post Install Routine"
 D NOW^%DTC S ZTDTH=X,ZTIO="",ZTRTN="WWIITYPLST^SDES930P",ZTSAVE("*")="" D ^%ZTLOAD
 I $D(ZTSK) D
 . D MES^XPDUTL("  >>>Task "_ZTSK_" has been queued.")
 . D MES^XPDUTL("")
 I '$D(ZTSK) D
 . D MES^XPDUTL("  UNABLE TO QUEUE THIS JOB.")
 . D MES^XPDUTL("  Please contact the National Help Desk to report this issue.")
 Q
 ;
WWIITYPLST ; Report of Clinics with Default Appointment type of "WORLD WAR II"
 K ^XTMP("SDES930P")
 N CIEN,DEFAPTTYP,COUNT,CLINICNAME
 S CIEN=0,COUNT=1
 F  S CIEN=$O(^SC(CIEN)) Q:'CIEN  D
 .Q:$$INACTIVE^SDES2UTIL(CIEN)
 .S DEFAPTTYP=$$GET1^DIQ(44,CIEN,2507)
 .I DEFAPTTYP="WORLD WAR II" D
 ..S CLINICNAME=$$GET1^DIQ(44,CIEN,.01,"E")
 ..S COUNT=COUNT+1
 ..S ^XTMP("SDES930P",COUNT)=CIEN_"^"_CLINICNAME_"^"_DEFAPTTYP
 ;
 S ^XTMP("SDES930P",0)=$$FMADD^XLFDT(DT,30)_"^"_DT_"^SD*5.3*930"
 S ^XTMP("SDES930P",1)="CLINIC IEN^CLINIC NAME^DEFAULT APPOINTMENT TYPE"
 S COUNT=COUNT+1
 S ^XTMP("SDES930P",COUNT)="A total of "_(COUNT-2)_" records were identified."
 I COUNT=2 S ^XTMP("SDES930P",1)="No Clinics found with Default Appointment Type WORLD WAR II."
 S ^XTMP("SDES930P",COUNT+1)=""
 S ^XTMP("SDES930P",COUNT+2)="SDES930P post install Appt type WORLD WAR II (VSE-114488) has run to completion."
 D MAIL
 K ^XTMP("SDES930P")
 Q
 ;
MAIL     ;
 N STANUM,MESS1,XMTEXT,XMSUB,XMY,XMDUZ,DIFROM,%,D,D0,D1,D2,DG,DIC,DICR,DIW,XMDUN,XMZ
 S STANUM=$$KSP^XUPARAM("INST")_","
 S STANUM=$$GET1^DIQ(4,STANUM,99)
 S MESS1="Station: "_STANUM_" - "
 S XMDUZ=DUZ
 S XMTEXT="^XTMP(""SDES930P"","
 S XMSUB=MESS1_"SD*5.3*930 - Post Install Data Report"
 S XMDUZ=.5,XMY(DUZ)="",XMY(XMDUZ)=""
 S XMY("siobhan.kirkpatrick@domain.ext")=""
 S XMY("Chad.Mitchell@domain.ext")=""
 S XMY("Katherine.Shelor@domain.ext")=""
 D ^XMD
 Q
 ;

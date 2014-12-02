EC2P122 ;ALB/DAN Post-install events for Event Capture patch 122 ;2/5/14  16:42
 ;;2.0;EVENT CAPTURE;**122**;8 May 96;Build 2
 ;
POST ;Come here for post-install actions
 D ADDNEW ;Add new procedure reasons to the procedure reasons file
 D INACT ;Inactivate event code screens with inactive procedure codes
 Q
 ;
ADDNEW ;Add new entry to file 720.4
 ;
 N ECXFDA,ECXERR,ECREAS,I
 ;
 ;-get procedure reason
 F I=1:1 S ECREAS=$P($T(ADDREAS+I),";;",2) Q:ECREAS="QUIT"  D
 .;
 .;-quit w/error message if entry already exists in file #720.4
 .I $$FIND1^DIC(720.4,"","X",ECREAS) D  Q
 ..D BMES^XPDUTL(">>>..."_ECREAS_" not added, entry already exists.")
 .;
 .;Setup field values of new entry
 .S ECXFDA(720.4,"+1,",.01)=ECREAS
 .S ECXFDA(720.4,"+1,",.02)=1 ;Set "ACTIVE?" field to 1 (active)
 .;
 .;-add new entry to file #720.4
 .D UPDATE^DIE("E","ECXFDA","","ECXERR")
 .;
 .I '$D(ECXERR) D BMES^XPDUTL(">>>...."_ECREAS_" added to file.")
 .I $D(ECXERR) D BMES^XPDUTL(">>>....Unable to add "_ECREAS_" to file.")
 ;
 Q
 ;
INACT ;Find inactive event code screens with inactive procedure codes
 N DAYS,ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSK
 S DAYS=$S($$PROD^XUPROD:30,1:3) ;Event code screen clean up happens in 3 days if installed in test, 30 days if in production
 D BMES^XPDUTL("Identifying event code screens with inactive EC Procedure Codes.") D MES^XPDUTL("A list of findings will be emailed to holders of the ECMGR key.")
 D INACTSCR^ECUTL3(0) ;Start scanning event code screens in "report only" mode
 D BMES^XPDUTL("Any event code screens with inactive EC Procedure Codes will be") D MES^XPDUTL("automatically inactivated "_DAYS_" days from now.  Creating background task") D MES^XPDUTL("for this process.")
 S ZTRTN="INACTSCR^ECUTL3(1)",ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT,DAYS),ZTIO="",ZTDESC="Inactivation of event code screens with inactive EC Procedure Codes" D ^%ZTLOAD
 I $G(ZTSK) D BMES^XPDUTL("Task #"_ZTSK_" created.  An email will be sent to holders of the ECMGR") D MES^XPDUTL("key upon completion.")
 I '$G(ZTSK) D MES^XPDUTL("Task not created!  Contact customer support for assistance!")
 Q
ADDREAS ;List of new procedure reasons
 ;;CHAP ACUTE/SUBACUTE MH
 ;;CHAP CBOC
 ;;CHAP CLC
 ;;CHAP CONSULTS
 ;;CHAP CRITICAL CARE
 ;;CHAP ETHICS
 ;;CHAP GERO PSYCH
 ;;CHAP GRAND ROUNDS
 ;;CHAP HEM/ONC
 ;;CHAP HOME BASED PRIMARY CARE
 ;;CHAP HOMELESS
 ;;CHAP HOSPICE
 ;;CHAP IDT MEETING
 ;;CHAP MED/SURG UNIT[S]
 ;;CHAP MHICM
 ;;CHAP OIF/OEF/OND
 ;;CHAP PALLIATIVE
 ;;CHAP POLYTRAUMA
 ;;CHAP PRRP
 ;;CHAP PTSD
 ;;CHAP REHABILITATION
 ;;CHAP SAME DAY SURG
 ;;CHAP SPINAL CORD INJURY
 ;;CHAP SUBSTANCE USE DISORDER
 ;;CHAP TBI
 ;;CHAP TEAM ROUNDS
 ;;CHAP TELEHEALTH
 ;;CHAP WOMEN'S HEALTH CLINIC
 ;;CHAP INTERN
 ;;CHAP RESIDENT
 ;;CHAP FELLOW
 ;;CHAP SPVR TRNG
 ;;QUIT

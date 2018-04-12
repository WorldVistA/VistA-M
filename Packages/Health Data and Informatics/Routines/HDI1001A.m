HDI1001A ;BPFO/JRP - PATCH 1 POST INSTALL;5/12/2005
 ;;1.0;HEALTH DATA & INFORMATICS;**1**;Feb 22, 2005
 ;
POST ;Main entry point for post-install routine
 ; Input: None
 ;        All variables set by Kernel for KIDS post-installs
 ;Output: None
 N HDIMSG
 S HDIMSG(1)=" "
 S HDIMSG(2)="~~~~~~~~~~~~~~~~~~~~"
 S HDIMSG(3)="Post-Installation (POST^HDI1001A) will now be run"
 S HDIMSG(4)=" "
 D MES^XPDUTL(.HDIMSG) K HDIMSG
 D DELETE
 I '$$VUID() D PSTHALT Q
 S HDIMSG(1)=" "
 S HDIMSG(2)="Post-Installation ran to completion"
 S HDIMSG(3)="~~~~~~~~~~~~~~~~~~~~"
 S HDIMSG(4)=" "
 D MES^XPDUTL(.HDIMSG) K HDIMSG
 Q
 ;
PSTHALT ;Print post-install halted text
 N HDIMSG
 S HDIMSG(1)=" "
 S HDIMSG(2)="*****"
 S HDIMSG(3)="***** Post-installation has been halted"
 S HDIMSG(4)="***** Please contact Enterprise VistA Support"
 S HDIMSG(5)="*****"
 S HDIMSG(6)=" "
 D MES^XPDUTL(.HDIMSG)
 Q
 ;
VUID() ;Instantiate VUIDs for set of code fields
 ; Input: None
 ;Output: 0 = Stop post-install (error)
 ;        1 = Continue with post-install
 N HDIMSG
 S HDIMSG(1)=" "
 S HDIMSG(2)="Seeding XTID VUID FOR SET OF CODES file (#8985.1) with Allergy data"
 S HDIMSG(3)=" "
 D MES^XPDUTL(.HDIMSG) K HDIMSG
 I '$$VUIDL^HDISVU02("ALLERGY","HDI1001B") Q 0
 S HDIMSG(1)=" "
 S HDIMSG(2)="Seeding XTID VUID FOR SET OF CODES file (#8985.1) with Pharmacy data"
 S HDIMSG(3)=" "
 D MES^XPDUTL(.HDIMSG) K HDIMSG
 I '$$VUIDL^HDISVU02("PHARM","HDI1001C") Q 0
 Q 1
 ;
DELETE ;Delete VUID for ENTERED IN ERROR field (#22) of PATIENT
 ; ALLERGIES file (#120.8)
 ;
 ; Input: None
 ;Output: None
 N HDIFILE,HDIFLD,HDIZERO,HDIARR,HDIERR,DIK,DA,INDX,HDIMSG,VUID
 S HDIMSG(1)=" "
 S HDIMSG(2)="Deleting VUIDs for the ENTERED IN ERROR field (#22)"
 S HDIMSG(3)="of the PATIENT ALLERGIES file (#120.8)"
 S HDIMSG(4)=" "
 D MES^XPDUTL(.HDIMSG) K HDIMSG
 ;Find entry in XTID VUID FOR SET OF CODES file (#8985.1)
 S HDIFILE=120.8
 S HDIFLD=22
 S SCREEN="S HDIZERO=^(0) I $P(HDIZERO,""^"",1)=HDIFILE I $P(HDIZERO,""^"",2)=HDIFLD"
 D FIND^DIC(8985.1,,".01;.02;.03;99.99","Q",120.8,,"B",SCREEN,,"HDIARR","HDIERR")
 ;Delete entries found
 S INDX=0
 F  S INDX=+$O(HDIARR("DILIST",2,INDX)) Q:'INDX  D
 .S VUID=HDIARR("DILIST","ID",INDX,99.99)
 .S HDIMSG(1)=" "
 .S HDIMSG(2)="    Deleting VUID "_VUID_" ..."
 .D MES^XPDUTL(.HDIMSG) K HDIMSG
 .S DA=HDIARR("DILIST",2,INDX)
 .S DIK=$$GET1^DID(8985.1,,,"GLOBAL NAME")
 .D ^DIK
 Q

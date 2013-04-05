HDI1007A ;HRN/ART - PATCH 7 POST INSTALL;6/13/2008
 ;;1.0;HEALTH DATA & INFORMATICS;**7**;Feb 22, 2005;Build 33
 ;
POST ;Main entry point for post-install routine
 ; Input: None
 ;        All variables set by Kernel for KIDS post-installs
 ;Output: None
 N HDIMSG
 S HDIMSG(1)=" "
 S HDIMSG(2)="~~~~~~~~~~~~~~~~~~~~"
 S HDIMSG(3)="Post-Installation (POST^HDI1007A) will now be run"
 S HDIMSG(4)=" "
 D MES^XPDUTL(.HDIMSG) K HDIMSG
 D DELETE
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
DELETE ;Delete VUID for ENTERED IN ERROR field (#22) of PATIENT
 ; ALLERGIES file (#120.8)
 ;
 ; Input: None
 ;Output: None
 N HDIFILE,HDIFLD,HDIZERO,HDIARR,HDIERR,DIK,DA,HDIMSG,VUID,SCREEN
 N INDX1,INDX2,HDIDATA,CODE
 S HDIMSG(1)=" "
 S HDIMSG(2)="Deleting invalid VUIDs entered for Lab set of code fields."
 S HDIMSG(3)=" "
 D MES^XPDUTL(.HDIMSG) K HDIMSG
 ;Find entry in XTID VUID FOR SET OF CODES file (#8985.1)
 F INDX1=1:1 Q:$P($T(LAB+INDX1^HDI1007B),";;",2)=""  D
 .S HDIDATA=$P($T(LAB+INDX1^HDI1007B),";;",2)
 .S HDIFILE=$P(HDIDATA,"~",1)
 .S HDIFLD=$P(HDIDATA,"~",2)
 .S HDIMSG(1)=" "
 .S HDIMSG(2)=" File: "_HDIFILE_"  Field: "_HDIFLD
 .D MES^XPDUTL(.HDIMSG) K HDIMSG
 .S SCREEN="S HDIZERO=^(0) I $P(HDIZERO,""^"",1)=HDIFILE I $P(HDIZERO,""^"",2)=HDIFLD"
 .D FIND^DIC(8985.1,,".01;.02;.03;99.99","Q",HDIFILE,,"B",SCREEN,,"HDIARR","HDIERR")
 .;Delete entries found
 .S INDX2=0
 .F  S INDX2=+$O(HDIARR("DILIST",2,INDX2)) Q:'INDX2  D
 ..S VUID=HDIARR("DILIST","ID",INDX2,99.99)
 ..S CODE=HDIARR("DILIST","ID",INDX2,.03)
 ..S HDIMSG(1)=" "
 ..S HDIMSG(2)="    Deleting CODE "_CODE_"  VUID "_VUID_" ..."
 ..;S HDIMSG(2)="    Deleting VUID "_VUID_" ..."
 ..D MES^XPDUTL(.HDIMSG) K HDIMSG
 ..S DA=HDIARR("DILIST",2,INDX2)
 ..S DIK=$$GET1^DID(8985.1,,,"GLOBAL NAME")
 ..D ^DIK
 Q

HDI1011A ;HRN/ART - PATCH 11 POST INSTALL;2/11/2008
 ;;1.0;HEALTH DATA & INFORMATICS;**11**;Feb 22, 2005;Build 6
 ;
POST ;Main entry point for post-install routine
 ; Input: None
 ;        All variables set by Kernel for KIDS post-installs
 ;Output: None
 N HDIMSG,HDISERR,HDDOM,HDISDFFS
 S HDDOM="PROBLEM LIST"
 ;No files for this patch - setting of HDISDFFS is not required
 ;S HDISDFFS(999999)=""
 S HDISERR=0
 S HDIMSG(1)=" "
 S HDIMSG(2)="~~~~~~~~~~~~~~~~~~~~"
 S HDIMSG(3)="Post-Installation (POST^HDI1011A) will now be run"
 S HDIMSG(4)=" "
 D MES^XPDUTL(.HDIMSG) K HDIMSG
 ;Updates HDIS DOMAIN file and HDIS FILE/FIELD file
 ;I '$$UPDTDOM^HDISVCUT(HDDOM,.HDISDFFS) D PSTHALT Q
 I '$$UPDTDOM^HDISVCUT(HDDOM) D PSTHALT Q  ;<< No files
 ;Updates Sets of Codes
 ; I '$$VUID^HDISVCUT("PROBLIST","HDI1011B") D PSTHALT Q  -- SET OF CODES NOT BEING SET
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

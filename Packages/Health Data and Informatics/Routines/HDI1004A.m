HDI1004A ;BPFO/GRR,ALB/RMO - PATCH 4 POST INSTALL;2/08/2006
 ;;1.0;HEALTH DATA & INFORMATICS;**4**;Feb 22, 2005
 ;
POST ;Main entry point for post-install routine
 ; Input: None
 ;        All variables set by Kernel for KIDS post-installs
 ;Output: None
 N HDIMSG,HDISERR,HDDOM,HDISDFFS
 S HDDOM="TIU"
 S HDISDFFS(8925.6)=""
 S HDISDFFS(8926.1)=""
 S HDISDFFS(8926.2)=""
 S HDISDFFS(8926.3)=""
 S HDISDFFS(8926.4)=""
 S HDISDFFS(8926.5)=""
 S HDISDFFS(8926.6)=""
 S HDISERR=0
 S HDIMSG(1)=" "
 S HDIMSG(2)="~~~~~~~~~~~~~~~~~~~~"
 S HDIMSG(3)="Post-Installation (POST^HDI1004A) will now be run"
 S HDIMSG(4)=" "
 D MES^XPDUTL(.HDIMSG) K HDIMSG
 ;Updates HDIS DOMAIN file and HDIS FILE/FIELD file
 I '$$UPDTDOM^HDISVCUT(HDDOM,.HDISDFFS) D PSTHALT Q
 ;Updates Sets of Codes
 I '$$VUID^HDISVCUT(HDDOM,"HDI1004B") D PSTHALT Q
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

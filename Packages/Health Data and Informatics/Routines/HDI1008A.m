HDI1008A ;BPFO/TJH - PATCH 8 POST INSTALL;11/26/2007
 ;;1.0;HEALTH DATA & INFORMATICS;**8**;Feb 22, 2005;Build 7
 ;
POST ;Main       entry point for post-install routine
 ;
 N HDIMSG,HDISERR,HDDOM,HDISDFFS
 S HDDOM="PHARMACY DATA MANAGEMENT"
 S HDISDFFS(51.23)=""
 S HDISDFFS(51.24)=""
 S HDISERR=0
 S HDIMSG(1)=" "
 S HDIMSG(2)="~~~~~~~~~~~~~~~~~~~~"
 S HDIMSG(3)="Post-Installation (POST^HDI1008A) will now be run"
 S HDIMSG(4)=" "
 D MES^XPDUTL(.HDIMSG) K HDIMSG
 I '$$UPDTDOM^HDISVCUT(HDDOM,.HDISDFFS) D PSTHALT Q  ;Updates HDIS DOMAIN file and HDIS FILE/FIELD file
 ;I '$$VUID^HDISVCUT(HDDOM,"HDI1008B") D PSTHALT Q
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

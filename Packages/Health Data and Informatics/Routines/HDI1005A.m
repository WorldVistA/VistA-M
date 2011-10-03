HDI1005A ;BPFO/GRR - PATCH 5 POST INSTALL;12/12/2005
 ;;1.0;HEALTH DATA & INFORMATICS;**5**;Feb 22, 2005;Build 2
 ;
POST ;Main       entry point for post-install routine
 ;
 N HDIMSG,HDISERR,HDDOM,HDISDFFS
 S HDDOM="ORDERS"
 S HDISDFFS(100.01)=""
 S HDISDFFS(100.02)=""
 S HDISERR=0
 S HDIMSG(1)=" "
 S HDIMSG(2)="~~~~~~~~~~~~~~~~~~~~"
 S HDIMSG(3)="Post-Installation (POST^HDI1005A) will now be run"
 S HDIMSG(4)=" "
 D MES^XPDUTL(.HDIMSG) K HDIMSG
 I '$$UPDTDOM^HDISVCUT(HDDOM,.HDISDFFS) D PSTHALT Q  ;Updates HDIS DOMAIN file and HDIS FILE/FIELD file
 I '$$VUID^HDISVCUT(HDDOM,"HDI1005B") D PSTHALT Q
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

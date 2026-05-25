SDES918P ;ALB/TJB - SD*5.3*918 Post Init Routine ; July 30, 2025
 ;;5.3;SCHEDULING;**918**;AUG 13, 1993;Build 4
 ;;Per VHA Directive 6402, this routine should not be modified
 ;;
 Q
 ;
EN ;
 D TASK
 Q
 ;
TASK ; Add "Y" to the tasks off process to update the direct patient schedule field in the hospital location file
 D MES^XPDUTL("")
 D MES^XPDUTL(" SD*5.3*918 Post-Install to update CLINIC STOP file 40.7 to")
 D MES^XPDUTL(" populate the field PROVIDERS NOT REQUIRED (#7)")
 D MES^XPDUTL(" with the value of 'Y' for codes 192, 669 and 674")
 D MES^XPDUTL("")
 N FDA,ERR,STCODE,OUT,STIEN
 F STCODE=192,669,674 K OUT,ERROR D FIND^DIC(40.7,"","@;1","P",STCODE,,"C","","","OUT","ERROR") D
 . I $G(OUT("DILIST",0))=""  D MES^XPDUTL("Error retrieving Clinic Stop="_STCODE) Q
 . S STIEN(STCODE)=$P(OUT("DILIST",1,0),U,1)
 K FDA,ERR
 S FDA(40.7,STIEN(192)_",",7)="1"
 S FDA(40.7,STIEN(669)_",",7)="1"
 S FDA(40.7,STIEN(674)_",",7)="1"
 D FILE^DIE(,"FDA","ERR") K FDA
 I $D(ERR) D
 . D MES^XPDUTL("")
 . D MES^XPDUTL(" ERROR Setting field PROVIDERS NOT REQUIRED (#7)")
 . D MES^XPDUTL(" Please contact the National Help Desk to report this issue.")
 Q
MAIL ;
 N STANUM,MESS1,XMTEXT,XMSUB,XMY,XMDUZ,DIFROM,%,D,D0,D1,D2,DG,DIC,DICR,DIW,XMDUN,XMZ
 S STANUM=$$KSP^XUPARAM("INST")_","
 S STANUM=$$GET1^DIQ(4,STANUM,99)
 S MESS1="Station: "_STANUM_" - "
 S XMDUZ=DUZ
 S XMTEXT="^XTMP(""SDES918P"",""VSE-10267"","
 S XMSUB="SD*5.3*918 - Post Install Data Report VSE-10267"
 S XMDUZ=.5,XMY(DUZ)="",XMY(XMDUZ)=""
 S XMY("BARBER.LORI@DOMAIN.EXT")=""
 S XMY("DUNNAM.DAVID@DOMAIN.EXT")=""
 S XMY("BOYDA.THOMAS@DOMAIN.EXT")=""
 D ^XMD
 Q

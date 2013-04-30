ECX3P136 ;ALB/DAN - DSS FY2013 Conversion, Post-init ;6/7/12  15:04
 ;;3.0;DSS EXTRACTS;**136**;Dec 22, 1997;Build 28
 ;
 ;****************************************
 ;Every year: Populate FY Year's version
 ; TESTON^ECXTREX(XPDNM,"FY2013")
 ;****************************************
 ;
PRE ;Pre-install tasks
 ;Delete file 727.833 so that we start with a fresh data dictionary install
 N DIU
 S DIU=727.833,DIU(0)="D" ;D denotes that we're deleting data as well
 D EN^DIU2
 Q
POST ;post-init
 D TEST,REMENU,UPDMENU,ACT,QINDEX
 Q
 ;
TEST ;turn-on fld #73 in file #728 for Field Test Site;
 ;allows use of option ECX FISCAL YEAR EXTRACT by test sites;
 D MES^XPDUTL(" ")
 D MES^XPDUTL("Providing special menu option access for DSS FY Conversion test sites.")
 D TESTON^ECXTREX(XPDNM,"FY2013")
 D MES^XPDUTL(" ")
 ;if this is the national released version, then fld #73 will be turned-off
 ;the first time any user attempts to use ECX FISCAL YEAR EXTRACT option
 Q
 ;
REMENU ;Remove options from menu and place out of order
 N MENU,OPTION,CHECK,IEN
 S OPTION="ECX PHA SOURCE AUDIT",MENU="ECX SOURCE AUDITS"
 S CHECK=$$DELETE^XPDMENU(MENU,OPTION)
 D BMES^XPDUTL(">>> "_OPTION_" OPTION "_$S(CHECK:"REMOVED FROM ",1:"DOES NOT EXIST IN ")_MENU_" <<<")
 D OUT^XPDMENU(OPTION,"OUT OF ORDER, DO NOT USE THIS OPTION!!!")
 D BMES^XPDUTL(">>> "_OPTION_" OPTION PLACED OUT ORDER <<<")
 Q
 ;
UPDMENU ;Update Audit Menu Option
 N MENU,SMENU,PTR,DA,DIK
 S (MENU,SMENU,PTR)=""
 S ECXMSG(1)=" "
 S ECXMSG(2)="** Looking for ECX LBB SOURCE AUDIT menu **"
 S ECXMSG(3)="     If found, the submenu item will be updated  "
 D MES^XPDUTL(.ECXMSG)
 ;Order thru option file and find ECX DSSDEPT MGMT and retrieve IEN
 S MENU=$O(^DIC(19,"B","ECX LBB SOURCE AUDIT",MENU))
 I 'MENU D BMES^XPDUTL("** ECX LBB SOURCE AUDIT item not found **") Q
 S DR="1///Laboratory Blood Bank (LBB) Pre-Extract Audit",DIE="^DIC(19,",DA=MENU
 D ^DIE
 N ECXMSG
 S ECXMSG(1)=" "
 S ECXMSG(2)="*** ECX LBB SOURCE AUDIT menu has been updated. ***"
 D MES^XPDUTL(.ECXMSG)
 D BMES^XPDUTL("Updating extract menu display order...")
 S DA=$$ADD^XPDMENU("ECXMENU","ECXLBB",,10)
 S DA=$$ADD^XPDMENU("ECXMENU","ECXBCM",,8)
 S DA=$$ADD^XPDMENU("ECXMENU","ECXPRO",,60)
 S DA=$$ADD^XPDMENU("ECXMENU","ECXQSR",,63)
 D MES^XPDUTL("Display order updated")
 Q
 ;
INDEX ;Set the new "AO" index on file 728.904
 N DIK
 S DIK="^ECX(728.904,",DIK(1)=2.5
 D ENALL^DIK
 Q
 ;
ACT ; Activate BCM in EXTRACT DEFINITION file (#727.1)
 N ECXFDA,ECXERR,ECXMSG,ECXDA,ECXOFF
 D MES^XPDUTL("   Activating BCM entry ...")
 S ECXDA=+$O(^ECX(727.1,"C","BCM",0))
 I 'ECXDA D  Q
 .K ECXMSG
 .S ECXMSG(1)=" "
 .S ECXMSG(2)="   ** ERROR ACTIVATING BCM **"
 .S ECXMSG(3)="      Entry not found in file"
 .D MES^XPDUTL(.ECXMSG)
 K ECXFDA,ECXERR
 S ECXFDA(727.1,ECXDA_",",13)=0
 D FILE^DIE("","ECXFDA","ECXERR")
 Q:'$D(ECXERR)
 D BMES^XPDUTL("   ** ERROR ACTIVING BCM **")
 K ECXMSG D MSG^DIALOG("AE",.ECXMSG,65,6,"ECXERR")
 D MES^XPDUTL(.ECXERR)
 D BMES^XPDUTL("- Done -")
 Q
 ;
QINDEX ;Queue building of 'AO' xref of file 728.904 to the background
 N ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSK
 S ZTRTN="INDEX^ECX3P136",ZTDESC="ECX*3*136 POST INSTALL ROUTINE",ZTIO="",ZTDTH=$H
 D MES^XPDUTL(" ")
 D MES^XPDUTL("Sending building of 'AO' cross-reference of file 728.904 to the background")
 D ^%ZTLOAD I '$G(ZTSK) D BMES^XPDUTL("Cross-reference build not started - run INDEX^ECX3P136 after install finishes") Q
 D BMES^XPDUTL("Cross-reference build queued as task # "_$G(ZTSK))
 D BMES^XPDUTL(" ")
 Q

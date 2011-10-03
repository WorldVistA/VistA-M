ECX3P71 ; BPFO/JRC -  Post Utility for DSS Extracts ; 11/24/04 9:28am
 ;;3.0;DSS EXTRACTS;**71**;Dec 22, 1997
EN ;Main entry point
 ;Change menu option locks
 N MENU,PTR
 S (MENU,PTR)=""
 F MENU="ECXMGR","ECX MAINTENANCE","ECX TRANSMISSION","ECXSCLOAD","ECXSCEDIT","ECXSCAPPROV","ECX IV DIV EDIT","ECXLABRS","ECX LAB RESULTS TRANS EDIT" D
 .K ECXMSG
 .S ECXMSG(1)=" "
 .S ECXMSG(2)=$S(MENU="ECX MAINTENANCE":"** Removing ",MENU="ECX TRANSMISSION":"** Removing ",MENU="ECXMGR":"** Removing ",1:"** Adding ")_"ECXMGR lock for "_MENU_" menu **"
 .D MES^XPDUTL(.ECXMSG)
 .;Order thru option file and find menu and retrieve IEN
 .S PTR="",PTR=$O(^DIC(19,"B",MENU,PTR))
 .I 'PTR D BMES^XPDUTL("** "_MENU_" item not found, not updated **") Q
 .S $P(^DIC(19,PTR,0),U,6)=$S(MENU="ECX MAINTENANCE":"",MENU="ECX TRANSMISSION":"",MENU="ECXMGR":"",1:"ECXMGR")
 D BMES^XPDUTL("**  Menu locks update completed  **")
 ;
 ;Remove ECX DSSDEPT DECODE menu
 ;
 ;Init variables
 N MENU,SMENU,PTR,DA,DIK
 S (MENU,SMENU,PTR)=""
 S ECXMSG(1)=" "
 S ECXMSG(2)="** Looking for ECX DSSDEPT DECODE menu under ECX DSSDEPT MGMT **"
 S ECXMSG(3)="     If found, the submenu item will be deleted  "
 D MES^XPDUTL(.ECXMSG)
 ;Order thru option file and find ECX DSSDEPT MGMT and retrieve IEN
 S MENU=$O(^DIC(19,"B","ECX DSSDEPT MGMT",MENU))
 I 'MENU D BMES^XPDUTL("** ECX DSSDEPT MGMT item not found **") Q
 ;Order thru option file and find ECX DSSDEPT DECODE and retrieve IEN
 S SMENU=$O(^DIC(19,"B","ECX DSSDEPT DECODE",SMENU))
 I 'SMENU D BMES^XPDUTL("** ECX DSSDEPT DECODE menu item not found **") Q
 ;Order thru ECX DSSDEPT MGMT menu subfile check for ECX DSSDEPT DECODE
 S PTR=($O(^DIC(19,MENU,10,"B",SMENU,PTR)))
 I 'PTR D BMES^XPDUTL("** ECX DSSDEPT DECODE was not found as a submenu, nothing deleted **") Q
 D BMES^XPDUTL("** ECX DSSDEPT DECODE menu found under ECX DSSDEPT MGMT **")
 S DA(1)=MENU,DIK="^DIC(19,"_DA(1)_","_10_",",DA=PTR
 D ^DIK
 N ECXMSG
 S ECXMSG(1)=" "
 S ECXMSG(2)="*** ECX DSSDEPT DECODE menu deleted from ECX DSSDEPT MGMT menu ***"
 D MES^XPDUTL(.ECXMSG)
 Q

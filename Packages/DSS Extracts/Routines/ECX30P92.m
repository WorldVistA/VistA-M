ECX30P92 ; ALB/JRC -  Post Utility for DSS Extracts Patch 92 ; 8/15/06 8:45am
 ;;3.0;DSS EXTRACTS;**92**;Dec 22, 1997;Build 30
EN ;Main entry point
 ;Remove Clinic Extract file (#727.803) and all data
 N ECXMSG,DIU
 K ECXMSG
 S ECXMSG(1)=" "
 S ECXMSG(2)="** Removing Clinic Extract File (#727.803) and all data **"
 D MES^XPDUTL(.ECXMSG)
 S DIU=727.803,DIU(0)="DT"
 D EN^DIU2
 K ECXMSG
 S ECXMSG(1)=" "
 S ECXMSG(2)="** Clinic Extract File (#727.803) and all data removed **"
 ;
 ;Remove dental menus and disable them
 ;Init variables
 N MENU,PTR,SMENU,SPTR,NUM,DA,DIK
 F MENU="ECX SOURCE AUDITS","ECX SAS AUDITS" D
 .K ECXMSG
 .S ECXMSG(1)=" "
 .S ECXMSG(2)=$S(MENU="ECX SOURCE AUDITS":"Removing [ECX DEN SOURCE AUDIT] menu",MENU="ECX SAS AUDITS":"Removing [ECX SAS DENTAL] menu",1:"")
 .D MES^XPDUTL(.ECXMSG)
 .;Order thru option file and find menu and retrieve IEN
 .S PTR="",PTR=$O(^DIC(19,"B",MENU,PTR))
 .I 'PTR D BMES^XPDUTL("** "_MENU_" item not found, not updated **") Q
 .;resolve submenu to remove
 .S SMENU=$S(MENU="ECX SOURCE AUDITS":"ECX DEN SOURCE AUDIT",1:"ECX SAS DENTAL")
 .S SPTR="",SPTR=$O(^DIC(19,"B",SMENU,SPTR))
 .I 'SPTR D  Q
 ..D BMES^XPDUTL("** "_SMENU_" item not found, not updated **")
 .;Disable menu option
 .D OUT^XPDMENU(SMENU,"MENU OPTION NO LONGER USED")
 .D BMES^XPDUTL(SMENU_"   **  Menu option disabled  **")
 .;Remove menu option
 .S NUM=0,NUM=$O(^DIC(19,PTR,10,"B",SPTR,NUM))
 .I 'NUM D  Q
 ..D BMES^XPDUTL("** "_SMENU_" item not found, not updated **")
 .S DIK="^DIC(19,"_PTR_",10,"
 .S DA(1)=PTR,DA=NUM
 .D ^DIK
 D BMES^XPDUTL("**  Menu updates completed  **")
 Q
 ;

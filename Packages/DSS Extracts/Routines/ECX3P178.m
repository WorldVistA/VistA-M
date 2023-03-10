ECX3P178 ;ALB/CMD - DSS Patch 178 Post-init routine; Feb 07, 2020@16:50:34
 ;;3.0;DSS EXTRACTS;**178**;Dec 22, 1997;Build 67
POST ;Post-install items
 D TEST ;Set testing site information
 D MENU ;update menus
 D INACT ;Inactivate Quasar and Lab Results in extract file definitions 727.1
 Q
 ;
TEST ;turn-on fld #73 in file #728 for Field Test Site;
 ;allows use of option ECX FISCAL YEAR EXTRACT by test sites;
 D MES^XPDUTL(" ")
 D MES^XPDUTL("Providing special menu option access for DSS FY Conversion test sites.")
 D TESTON^ECXTREX(XPDNM,"FY2021")
 D MES^XPDUTL(" ")
 ;if this is the national released version, then fld #73 will be turned-off
 ;the first time any user attempts to use ECX FISCAL YEAR EXTRACT option
 Q
 ;
MENU ;Remove: Quasar Extract and Lab Result Extract from Package Extract options, Quasar and Lab Results Audit Extract and Lab Results LOINC Code Report.
 ;Add new option: ECX SUR Observation for Surgery Pre-Extract Audit Report.
 N DA,DIE,DR,MENU,OPTION,CHECK,CHOICE,TYPE,OFF,UPDATE
 S TYPE="MENUDEL" F OFF=1:1 S CHOICE=$P($T(@TYPE+OFF),";;",2) Q:CHOICE="DONE"  D
 .S OPTION=$P(CHOICE,"^"),MENU=$P(CHOICE,"^",2)
 .S CHECK=$$DELETE^XPDMENU(MENU,OPTION)
 .D BMES^XPDUTL(">>> "_OPTION_" OPTION "_$S(CHECK:"REMOVED FROM ",1:"DOES NOT EXIST IN ")_MENU_" <<<")
 D BMES^XPDUTL("Updating Surgery Pre-Extract Audit Report Menu")
 S CHECK=$$ADD^XPDMENU("ECX SURGERY PRE-EXTRACT","ECX SUR OBS",3,3)
 D BMES^XPDUTL("ECX SUR OBSERVATION Option "_$S('+$G(CHECK):"NOT ",1:"")_"added to menu ECX SURGERY PRE-EXTRACT")
 Q
 ;
MENUDEL ;Menu items to be removed.  Format is OPTION NAME^MENU TO BE REMOVED FROM
 ;;ECXQSR^ECXMENU
 ;;ECXLABR^ECXMENU
 ;;ECX LAR SOURCE AUDIT^ECX SOURCE AUDITS
 ;;ECX QSR SOURCE AUDIT^ECX SOURCE AUDITS
 ;;ECX LAR LOINC RPT^ECX MAINTENANCE
 ;;DONE
 ;
INACT ; Inactivate ECQ (Quasar)and LAR (Lab Results) in EXTRACT DEFINITION file (#727.1)
 N I,ECXFDA,ECXERR,ECXMSG,ECXDA,ECXOFF
 F I="ECQ","LAR" D
 .D MES^XPDUTL("  Inactivating "_I_" entry ...")
 .S ECXDA=+$O(^ECX(727.1,"C",I,0))
 .I 'ECXDA D  Q
 ..K ECXMSG
 ..S ECXMSG(1)=" "
 ..S ECXMSG(2)="   ** ERROR INACTIVATING "_I_" **"
 ..S ECXMSG(3)="      Entry not found in file"
 ..D MES^XPDUTL(.ECXMSG)
 .K ECXFDA,ECXERR
 .S ECXFDA(727.1,ECXDA_",",13)=1
 .D FILE^DIE("","ECXFDA","ECXERR")
 .Q:'$D(ECXERR)
 .D BMES^XPDUTL("   ** ERROR INACTIVING  **")
 .K ECXMSG D MSG^DIALOG("AE",.ECXMSG,65,6,"ECXERR")
 .D MES^XPDUTL(.ECXERR)
 D BMES^XPDUTL("- Done -")
 Q
 ;

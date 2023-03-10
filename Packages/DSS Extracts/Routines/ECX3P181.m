ECX3P181 ;ALB/CMD - DSS FY2022 Conversion, Post-init ;Feb 05, 2021@13:40
 ;;3.0;DSS EXTRACTS;**181**;Dec 22, 1997;Build 71
 ;
 ;Reference to MES^XPDUTL supported by ICR #10141
 ;Reference to BMES^XPDUTL supported by ICR #10141
 ;Reference to $$DELETE^XPDMENU supported by ICR #1157
 ;
 ;****************************************
 ;Every year: Populate FY Year's version
 ; TESTON^ECXTREX(XPDNM,"FY2022")
 ;****************************************
 ;
POST ;Post-install items
 D TEST ;Set testing site information
 D MENU
 Q
TEST ;turn-on fld #73 in file #728 for Field Test Site;
 ;allows use of option ECX FISCAL YEAR EXTRACT by test sites;
 D MES^XPDUTL(" ")
 D MES^XPDUTL("Providing special menu option access for DSS FY Conversion test sites.")
 D TESTON^ECXTREX(XPDNM,"FY2022")
 D MES^XPDUTL(" ")
 ;if this is the national released version, then fld #73 will be turned-off
 ;the first time any user attempts to use ECX FISCAL YEAR EXTRACT option
 Q
MENU ;Remove: Prosthetics YTD HCPCS Laboratory Report.
 ;
 N DA,DIE,DR,MENU,OPTION,CHECK,CHOICE,TYPE,OFF,UPDATE
 S TYPE="MENUDEL" F OFF=1:1 S CHOICE=$P($T(@TYPE+OFF),";;",2) Q:CHOICE="DONE"  D
 .S OPTION=$P(CHOICE,"^"),MENU=$P(CHOICE,"^",2)
 .S CHECK=$$DELETE^XPDMENU(MENU,OPTION)
 .D BMES^XPDUTL(">>> "_OPTION_" OPTION "_$S(CHECK:"REMOVED FROM ",1:"DOES NOT EXIST IN ")_MENU_" <<<")
 Q
 ;
MENUDEL ;Menu items to be removed.  Format is OPTION NAME^MENU TO BE REMOVED FROM
 ;;ECX PRO LAB REPORT^ECX PROSTHETICS MAINTENANCE
 ;;DONE
 ;

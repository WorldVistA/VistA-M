ECX3P184 ;ALB/CMD - DSS FY2023 Post-init ;01/31/2022  15:42
 ;;3.0;DSS EXTRACTS;**184**;Dec 22, 1997;Build 124
 ;
 ; Reference to MES^XPDUTL in ICR #10141
 ; Reference to ADD^XPDMENU,DELETE^XPDMENU in ICR #1157
 ;
 ;****************************************
 ;Every year: Populate FY Year's version
 ; TESTON^ECXTREX(XPDNM,"FY2023")
 ;****************************************
 ;
POST ;Post-install items
 D TEST ;Set testing site information
 D MENU
 Q
PRE ;Pre-install items
 ;Delete fields Admission Data and Admission Time from CLI extract (DD#727.827)
 N DIK,DA
 S DIK="^DD(727.827,",DA(1)=727.827 F DA=163:1:166 D ^DIK
 Q
 ;
MENU ;Remove Event Capture Pre-Extract Unusual Volume Report from Pre-Extract Audit Reports
 ; Add Event Capture as a sub-menu under Pre-Extract Audit Reports
 ; Add Event Capture Pre-Extract Unusual Volume Report to Event Capture 
 ; And Event Capture Pre-Extract Missing DSS ID Report to Event Capture
 N OPTION,MENU,TYPE,OFF,DA,NEWTXT,X
 S OPTION="ECX ECS VOL",MENU="ECX PRE-EXTRACT REPORTS"
 S CHECK=$$DELETE^XPDMENU(MENU,OPTION)
 D BMES^XPDUTL(">>> "_OPTION_" OPTION "_$S(CHECK:"REMOVED FROM ",1:"DOES NOT EXIST IN ")_MENU_" <<<")
 D BMES^XPDUTL("Updating Pre-Extract Reports Menu")
 S CHECK=$$ADD^XPDMENU("ECX PRE-EXTRACT REPORTS","ECX EVENT CAPTURE PRE-EXTRACT","ECS",1)
 S TYPE="MENUADD" F OFF=1:1 S CHOICE=$P($T(@TYPE+OFF),";;",2) Q:CHOICE="DONE"  D
 . S MENU=$P(CHOICE,"^"),OPTION=$P(CHOICE,"^",2),SYN=$P(CHOICE,"^",3),ORD=$P(CHOICE,"^",4)
 . S CHECK=$$ADD^XPDMENU(MENU,OPTION,SYN,ORD)
 . D BMES^XPDUTL(OPTION_" Option "_$S('+$G(CHECK):"NOT ",1:"")_"added to menu "_MENU)
 ;Update the menu text of the ECXWRD - Active MAS Wards Fiscal Year Print option
 S DA=$$LKOPT^XPDMENU("ECXWRD")
 S NEWTXT="Active Wards for Fiscal Year Print"
 S DR="1///^S X=NEWTXT",DIE="^DIC(19," D ^DIE
 Q
 ;
MENUADD ;Menu Items to be added.  Format is Menu to be Added to ^Option Name^Synonym^Display Order
 ;;ECX PRE-EXTRACT REPORTS^ECX EVENT CAPTURE PRE-EXTRACT^ECS^1
 ;;ECX EVENT CAPTURE PRE-EXTRACT^ECX ECS MISSING DSS ID^1^1
 ;;ECX EVENT CAPTURE PRE-EXTRACT^ECX ECS VOL^2^2
 ;;DONE
 ;;
TEST ;turn-on fld #73 in file #728 for Field Test Site;
 ;allows use of option ECX FISCAL YEAR EXTRACT by test sites;
 D MES^XPDUTL(" ")
 D MES^XPDUTL("Providing special menu option access for DSS FY Conversion test sites.")
 D TESTON^ECXTREX(XPDNM,"FY2023")
 D MES^XPDUTL(" ")
 ;if this is the national released version, then fld #73 will be turned-off
 ;the first time any user attempts to use ECX FISCAL YEAR EXTRACT option
 Q

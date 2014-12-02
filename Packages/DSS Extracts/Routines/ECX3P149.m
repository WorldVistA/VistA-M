ECX3P149 ;ALB/DAN - DSS FY2015 Conversion, Post-init ;7/29/14  09:57
 ;;3.0;DSS EXTRACTS;**149**;Dec 22, 1997;Build 27
 ;
POST ;Post-install items
 D TEST ;Set testing site information
 D MENU ;update menus
 D FIXBBC ;Fix blood bank "C" xref
 D INACT ;Inactivate Nutrition (NUT) in extract file definitions 727.1
 D UPDATE ;Update routine for blood bank extract
 Q
 ;
TEST ;turn-on fld #73 in file #728 for Field Test Site;
 ;allows use of option ECX FISCAL YEAR EXTRACT by test sites;
 D MES^XPDUTL(" ")
 D MES^XPDUTL("Providing special menu option access for DSS FY Conversion test sites.")
 D TESTON^ECXTREX(XPDNM,"FY2015")
 D MES^XPDUTL(" ")
 ;if this is the national released version, then fld #73 will be turned-off
 ;the first time any user attempts to use ECX FISCAL YEAR EXTRACT option
 Q
 ;
MENU ;update menus
 N DA,DIE,DR,MENU,OPTION,CHECK,IEN
 D BMES^XPDUTL("Updating option ECX NATIONAL CLINIC...")
 S DA=$$LKOPT^XPDMENU("ECX NATIONAL CLINIC")
 I 'DA D MES^XPDUTL("Update failed - contact product support for assistance!")
 S DIE="^DIC(19,",DR="4///R;25///ECXNCL;60///@;62///@;63///@;64///@"
 D ^DIE
 D MES^XPDUTL("Update successful.")
 S OPTION="ECXNUT",MENU="ECXMENU"
 S CHECK=$$DELETE^XPDMENU(MENU,OPTION)
 D BMES^XPDUTL(">>> "_OPTION_" OPTION "_$S(CHECK:"REMOVED FROM ",1:"DOES NOT EXIST IN ")_MENU_" <<<")
 D OUT^XPDMENU(OPTION,"OUT OF ORDER, DO NOT USE THIS OPTION!!!")
 D BMES^XPDUTL(">>> "_OPTION_" OPTION PLACED OUT ORDER <<<")
 S OPTION="ECX NUTRITION WORKSHEETS",MENU="ECX MAINTENANCE"
 S CHECK=$$DELETE^XPDMENU(MENU,OPTION)
 D BMES^XPDUTL(">>> "_OPTION_" OPTION "_$S(CHECK:"REMOVED FROM ",1:"DOES NOT EXIST IN ")_MENU_" <<<")
 D OUT^XPDMENU(OPTION,"OUT OF ORDER, DO NOT USE THIS OPTION!!!")
 D BMES^XPDUTL(">>> "_OPTION_" OPTION PLACED OUT ORDER <<<")
 S OPTION="ECX NUT SOURCE AUDIT",MENU="ECX SOURCE AUDITS"
 S CHECK=$$DELETE^XPDMENU(MENU,OPTION)
 D BMES^XPDUTL(">>> "_OPTION_" OPTION "_$S(CHECK:"REMOVED FROM ",1:"DOES NOT EXIST IN ")_MENU_" <<<")
 D OUT^XPDMENU(OPTION,"OUT OF ORDER, DO NOT USE THIS OPTION!!!")
 D BMES^XPDUTL(">>> "_OPTION_" OPTION PLACED OUT ORDER <<<")
 D BMES^XPDUTL("Updating routine information for option ECXLBB - Blood Bank Extract")
 S DA=$$LKOPT^XPDMENU("ECXLBB")
 I 'DA D BMES^XPDUTL("** ECXLBB Blood Bank Extract item not found **")
 I DA S DR="25///BEG^ECXLBB1" S DIE="^DIC(19," D ^DIE
 Q
 ;
FIXBBC ;Find any bad transfusion date/times and correct them.  This will fix the "C" xref in the file as well
 N DATE,IEN,DR,DIE,DA
 D BMES^XPDUTL("Reviewing transfusion date/time entries in the VBECS DSS EXTRACT file...")
 S DATE=" " F  S DATE=$O(^VBEC(6002.03,"C",DATE)) Q:'+DATE  S IEN=0 F  S IEN=$O(^VBEC(6002.03,"C",DATE,IEN)) Q:'+IEN  S DA=IEN,DIE=6002.03,DR="9///"_+DATE D ^DIE
 D MES^XPDUTL("Done")
 Q
UPDATE ;update LBB in EXTRACT DEFINITION file (#727.1)
 N ECXFDA,ECXERR,ECXMSG,ECXDA,ECXHDR,ECXOFF
 D MES^XPDUTL("   Updating LBB entry ...")
 F ECXOFF=1:1 S ECXHDR=$P($T(HDRS1+ECXOFF),";;",2) Q:ECXHDR=""  D
 .S ECXDA=+$O(^ECX(727.1,"C",ECXHDR,0))
 .I 'ECXDA D  Q
 ..K ECXMSG
 ..S ECXMSG(1)=" "
 ..S ECXMSG(2)="   ** ERROR UPDATING "_ECXHDR_" **"
 ..S ECXMSG(3)="      Entry not found in file"
 ..D MES^XPDUTL(.ECXMSG)
 .K ECXFDA,ECXERR
 .S ^ECX(727.1,ECXDA,"ROU")="ECXLBB1"
 D BMES^XPDUTL("- Done -")
 Q
INACT ; Inactivate NUT in EXTRACT DEFINITION file (#727.1)
 N ECXFDA,ECXERR,ECXMSG,ECXDA,ECXOFF
 D MES^XPDUTL("  Inactivating NUT entry ...")
 S ECXDA=+$O(^ECX(727.1,"C","NUT",0))
 I 'ECXDA D  Q
 .K ECXMSG
 .S ECXMSG(1)=" "
 .S ECXMSG(2)="   ** ERROR INACTIVATING NUT **"
 .S ECXMSG(3)="      Entry not found in file"
 .D MES^XPDUTL(.ECXMSG)
 K ECXFDA,ECXERR
 S ECXFDA(727.1,ECXDA_",",13)=1
 D FILE^DIE("","ECXFDA","ECXERR")
 Q:'$D(ECXERR)
 D BMES^XPDUTL("   ** ERROR INACTIVING NUT **")
 K ECXMSG D MSG^DIALOG("AE",.ECXMSG,65,6,"ECXERR")
 D MES^XPDUTL(.ECXERR)
 D BMES^XPDUTL("- Done -")
 Q
HDRS1 ;List of headers to be updated
 ;;LBB
 ;;
 Q

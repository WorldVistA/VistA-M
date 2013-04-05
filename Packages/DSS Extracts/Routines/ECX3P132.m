ECX3P132 ;ALB/MRY - DSS FY2012 Conversion, Post-init ;4/12/11  13:37
 ;;3.0;DSS EXTRACTS;**132**;Dec 22, 1997;Build 18
 ;
 ;****************************************
 ;Every year: Populate FY Year's version
 ; TESTON^ECXTREX(XPDNM,"FY2012")
 ;****************************************
 ;
POST ;post-init
 D TEST,MENU,INACT,BCM
 Q
 ;
TEST ;turn-on fld #73 in file #728 for Field Test Site;
 ;allows use of option ECX FISCAL YEAR EXTRACT by test sites;
 D MES^XPDUTL(" ")
 D MES^XPDUTL("Providing special menu option access for DSS FY Conversion test sites.")
 D TESTON^ECXTREX(XPDNM,"FY2012")
 ;D MES^XPDUTL(" ")
 ;D MES^XPDUTL("Remember to assign the ECX DSS TEST key to qualified users.")
 D MES^XPDUTL(" ")
 ;if this is the national released version, then fld #73 will be turned-off
 ;the first time any user attempts to use ECX FISCAL YEAR EXTRACT option
 Q
 ;
MENU ;Remove options from menu and place out of order
 N MENU,OPTION,CHECK,IEN
 S OPTION="ECXNURS",MENU="ECXMENU"
 S CHECK=$$DELETE^XPDMENU(MENU,OPTION)
 D BMES^XPDUTL(">>> "_OPTION_" OPTION "_$S(CHECK:"REMOVED FROM ",1:"DOES NOT EXIST IN ")_MENU_" <<<")
 D OUT^XPDMENU(OPTION,"OUT OF ORDER, DO NOT USE THIS OPTION!!!")
 D BMES^XPDUTL(">>> "_OPTION_" OPTION PLACED OUT ORDER <<<")
 S OPTION="ECX NUR SOURCE AUDIT",MENU="ECX SOURCE AUDITS"
 S CHECK=$$DELETE^XPDMENU(MENU,OPTION)
 D BMES^XPDUTL(">>> "_OPTION_" OPTION "_$S(CHECK:"REMOVED FROM ",1:"DOES NOT EXIST IN ")_MENU_" <<<")
 D OUT^XPDMENU(OPTION,"OUT OF ORDER, DO NOT USE THIS OPTION!!!")
 D BMES^XPDUTL(">>> "_OPTION_" OPTION PLACED OUT ORDER <<<")
 Q
 ;
INACT ;inactivate NUR in EXTRACT DEFINITION file (#727.1)
 N ECXFDA,ECXERR,ECXMSG,ECXDA,ECXHDR,ECXOFF
 D MES^XPDUTL("   Inactivating NUR entry ...")
 F ECXOFF=1:1 S ECXHDR=$P($T(HDRS+ECXOFF),";;",2) Q:ECXHDR=""  D
 .S ECXDA=+$O(^ECX(727.1,"C",ECXHDR,0))
 .I 'ECXDA D  Q
 ..K ECXMSG
 ..S ECXMSG(1)=" "
 ..S ECXMSG(2)="   ** ERROR INACTIVATING "_ECXHDR_" **"
 ..S ECXMSG(3)="      Entry not found in file"
 ..D MES^XPDUTL(.ECXMSG)
 .K ECXFDA,ECXERR
 .S ECXFDA(727.1,ECXDA_",",13)=1
 .D FILE^DIE("","ECXFDA","ECXERR")
 .Q:'$D(ECXERR)
 .D BMES^XPDUTL("   ** ERROR INACTIVING "_ECXHDR_" **")
 .K ECXMSG D MSG^DIALOG("AE",.ECXMSG,65,6,"ECXERR")
 .D MES^XPDUTL(.ECXERR)
 D BMES^XPDUTL("- Done -")
 Q
 ;
BCM ;change RUNNING PIECE from 27 to 29
 N DIE,DIC,DA,DR,X,Y
 D BMES^XPDUTL("Changing BCM Extract's RUNNING PIECE value from 27 to 29")
 S DIC="^ECX(727.1,",DIC(0)="X"
 S X="BAR CODE MEDICATION ADMINISTRATION"
 D ^DIC
 I (Y<0) D  Q
 . D BMES^XPDUTL("   BAR CODE MEDICATION ADMINISTRATION Extract not found.")
 S DIE=DIC
 S DA=+Y
 S DR="11///29"
 D ^DIE
 D MES^XPDUTL("   BCM Extract's RUNNING PIECE value successfully changed to 29.")
 Q
 ;
HDRS ;List of headers to be inactivated
 ;;NUR
 ;;
 Q

ECX3049 ;BPFO/JRP - PRE/PORT INIT FOR ECX*3.0*49;7/11/2003 ; 10/17/03 6:55am
 ;;3.0;DSS EXTRACTS;**49**;Dec 22, 1997
 ;
 Q
POST ;Main entry point for post init
 D MENUS
 D LOG
 D DEFINE
 D EXTRACT
 Q
 ;
MENUS ;Remove erroneous entry from'ECX MAINTENANCE MENU'
 ;Set variables
 N MENU,SMENU,PTR
 S (MENU,SMENU,PTR)=""
 S ECXMSG(1)=" "
 S ECXMSG(2)="** Looking for ECX PHA VOL menu under ECX MAINTENANCE **"
 S ECXMSG(3)="     If found, the submenu item will be deleted  "
 D MES^XPDUTL(.ECXMSG)
 ;Order thru option file and find ECX MAINTENANCE and retrieve IEN
 S MENU=$O(^DIC(19,"B","ECX MAINTENANCE",MENU))
 I 'MENU D BMES^XPDUTL("** ECX MAINTENANCE MENU item not found **") Q
 ;Order thru option file and find ECX PHA VOL and retrieve IEN
 S SMENU=$O(^DIC(19,"B","ECX PHA VOL",SMENU))
 I 'SMENU D BMES^XPDUTL("** ECX PHA VOL menu item not found **") Q
 ;Order thru ECX MAINTENANCE menu subfile check for ECX PHA VOL
 S PTR=($O(^DIC(19,MENU,10,"B",SMENU,PTR)))
 I 'PTR D BMES^XPDUTL("** ECX PHA VOL was not found as a submenu, nothing deleted **") Q
 D BMES^XPDUTL("** ECX PHA VOL menu found under ECX MAINTENANCE menu **")
 S DA(1)=MENU,DIK="^DIC(19,"_DA(1)_","_10_",",DA=PTR
 D ^DIK
 N ECXMSG
 S ECXMSG(1)=" "
 S ECXMSG(2)="** ECX PHA VOL menu deleted from ECX MAINTENANCE menu **"
 D MES^XPDUTL(.ECXMSG)
 Q
LOG ;Seed new field in DSS EXTRACT LOG file (#727)
 N ECXFDA,ECXERR,ECXMSG,ECXDA,ECXSD
 S ECXMSG(1)=" "
 S ECXMSG(2)="Seeding newly created EXTRACT LOGIC field"
 S ECXMSG(3)="(#14) of the DSS EXTRACT LOG file (#727)"
 D MES^XPDUTL(.ECXMSG)
 S ECXDA=0 F  S ECXDA=+$O(^ECX(727,ECXDA)) Q:'ECXDA  D
 .S ECXSD=$P($G(^ECX(727,ECXDA,0)),"^",4)
 .S ECXSD=$$FISCAL^ECXUTL1(ECXSD)
 .K ECXFDA,ECXERR
 .S ECXFDA(727,ECXDA_",",14)=ECXSD
 .D FILE^DIE("","ECXFDA","ECXERR")
 .Q:'$D(ECXERR)
 .D BMES^XPDUTL("   ** ERROR SEEDING FIELD FOR ENTRY ENTRY #"_ECXDA_" **")
 .K ECXMSG D MSG^DIALOG("AE",.ECXMSG,65,6,"ECXERR")
 .D MES^XPDUTL(.ECXERR)
 D BMES^XPDUTL("- Done -")
 Q
 ;
DEFINE ;Seed new field in EXTRACT DEFINITION file (#727.1)
 N ECXFDA,ECXERR,ECXMSG,ECXDA,ECXHDR,ECXOFF
 S ECXMSG(1)=" "
 S ECXMSG(2)="Seeding newly created INACTIVE field (#13)"
 S ECXMSG(3)="of the EXTRACT DEFINITIONS file (#727.1)"
 D MES^XPDUTL(.ECXMSG)
 D BMES^XPDUTL("   Inactivating all entries ...")
 S ECXDA=0 F  S ECXDA=+$O(^ECX(727.1,ECXDA)) Q:'ECXDA  D
 .K ECXFDA,ECXERR
 .S ECXFDA(727.1,ECXDA_",",13)=1
 .D FILE^DIE("","ECXFDA","ECXERR")
 .Q:'$D(ECXERR)
 .D BMES^XPDUTL("   ** ERROR INACTIVING ENTRY #"_ECXDA_" **")
 .K ECXMSG D MSG^DIALOG("AE",.ECXMSG,65,6,"ECXERR")
 .D MES^XPDUTL(.ECXERR)
 D MES^XPDUTL("   Activating all nationally supported entries ...")
 F ECXOFF=1:1 S ECXHDR=$P($T(NTLHDR+ECXOFF),";;",2) Q:ECXHDR=""  D
 .S ECXDA=+$O(^ECX(727.1,"C",ECXHDR,0))
 .I 'ECXDA D  Q
 ..K ECXMSG
 ..S ECXMSG(1)=" "
 ..S ECXMSG(2)="   ** ERROR ACTIVATING "_ECXHDR_" **"
 ..S ECXMSG(3)="      Entry not found in file"
 ..D MES^XPDUTL(.ECXMSG)
 .K ECXFDA,ECXERR
 .S ECXFDA(727.1,ECXDA_",",13)=0
 .D FILE^DIE("","ECXFDA","ECXERR")
 .Q:'$D(ECXERR)
 .D BMES^XPDUTL("   ** ERROR ACTIVING "_ECXHDR_" **")
 .K ECXMSG D MSG^DIALOG("AE",.ECXMSG,65,6,"ECXERR")
 .D MES^XPDUTL(.ECXERR)
 D BMES^XPDUTL("- Done -")
 Q
 ;
EXTRACT ;Seed new field in DSS EXTRACTS file (#728)
 N ECXFDA,ECXERR,ECXMSG
 S ECXMSG(1)=" "
 S ECXMSG(2)="Seeding newly created AUSTIN TEST QUEUE NAME"
 S ECXMSG(3)="field (#67) of the DSS EXTRACTS file (#728)"
 D MES^XPDUTL(.ECXMSG)
 I '$D(^ECX(728,1)) D  Q
 .D BMES^XPDUTL("**  FILE DOES NOT HAVE AN ENTRY #1.  SEEDING OF FIELD NOT DONE.  **")
 S ECXFDA(728,"1,",67)="DMT"
 D FILE^DIE("","ECXFDA","ECXERR")
 I $D(ECXERR) D
 .D BMES^XPDUTL("** ERROR OCCURRED WHILE SEEDING FIELD **")
 .K ECXMSG D MSG^DIALOG("AE",.ECXMSG,70,5,"ECXERR")
 .D MES^XPDUTL(.ECXERR)
 D BMES^XPDUTL("- Done -")
 Q
 ;
NTLHDR ;List of nationally supported headers
 ;;ADM
 ;;CLI
 ;;DEN
 ;;ECQ
 ;;ECS
 ;;IVP
 ;;LAB
 ;;LAR
 ;;MTL
 ;;MOV
 ;;NUR
 ;;PAS
 ;;PRE
 ;;PRO
 ;;RAD
 ;;SUR
 ;;TRT
 ;;UDP
 ;;

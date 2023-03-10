PXRMP42I ;SLC/PKR - Inits for PXRM*2.0*42. ;04/04/2019
 ;;2.0;CLINICAL REMINDERS;**42**;Feb 04, 2005;Build 245
 Q
 ;==========================================
PRE ;Pre-init
 ;Disable options and protocols
 D OPTIONS^PXRMUTIL("DISABLE","Install of PXRM*2.0*42")
 D PROTCOLS^PXRMUTIL("DISABLE","Install of PXRM*2.0*42")
 D RMOLDDDS^PXRMP42I
 Q
 ;
 ;==========================================
POST ;Post-init
 N RES
 D RBLDAPDS^PXRMP42I
 D RBLDD^PXRMP42I
 D RMQUERIX^PXRMP42I
 D UPCSPON^PXRMP42I
 ;Remove PXRM GEC REFERRAL REPORT from the Manager's Menu.
 S RES=$$DELETE^XPDMENU("PXRM MANAGERS MENU","PXRM GEC REFERRAL REPORT")
 I RES=1 D BMES^XPDUTL("PXRM GEC REFERRAL REPORT was removed from the PXRM MANAGERS MENU.")
 D SETPVER^PXRMUTIL("2.0P42")
 ;Enable options and protocols
 D OPTIONS^PXRMUTIL("ENABLE","Install of PXRM*2.0*42")
 D PROTCOLS^PXRMUTIL("ENABLE","Install of PXRM*2.0*42")
 D SENDIM^PXRMMSG("PXRM*2.0*42")
 Q
 ;
 ;==========================================
RBLDAPDS ;Rebuild the "APDS" index for all taxonomies, to include
 ;V Standard Codes.
 N IEN,NAME,PDS
 D BMES^XPDUTL("Rebuilding the 'APDS' index for all taxonomies.")
 S NAME=""
 F  S NAME=$O(^PXD(811.2,"B",NAME)) Q:NAME=""  D
 . S IEN=$O(^PXD(811.2,"B",NAME,""))
 . S PDS=$P(^PXD(811.2,IEN,0),U,4)
 . D SPDS^PXRMPDS(IEN,PDS)
 Q
 ;
 ;==========================================
RBLDD ;Rebuild the "D" index for 811.9.
 N DIK
 D BMES^XPDUTL("Rebuilding the 'D' index for Reminder Definition Print Names.")
 K ^PXD(811.9,"D")
 S DIK="^PXD(811.9,",DIK(1)="1.2^D"
 D ENALL^DIK
 Q
 ;
 ;==========================================
RMOLDDDS ;Remove old data dictionaries.
 N DIU,TEXT
 D BMES^XPDUTL("Removing old data dictionaries.")
 S DIU(0)=""
 F DIU=811.6 D
 . S TEXT=" Deleting data dictionary for file # "_DIU
 . D MES^XPDUTL(TEXT)
 . D EN^DIU2
 Q
 ;
 ;==========================================
RMQUERIX ;Remove the QUERI extracts.
 N IEN,IENS,KFDA,MSG,NAME,NAMES,NUM
 ;Deletion from file #19.2 covered by ICR #3732.
 ;Delete the Option Scheduling file entries.
 D BMES^XPDUTL("Deleting the QUERI extracts.")
 F NAME="PXRM EXTRACT VA-IHD QUERI","PXRM EXTRACT VA-MH QUERI" D
 . S IEN=+$$FIND1^DIC(19.2,"","BX",NAME,"","","MSG")
 . I IEN=0 Q
 . D BMES^XPDUTL("Deleting scheduled option "_NAME)
 . S IENS=IEN_","
 . S KFDA(19.2,IENS,.01)="@"
 . D FILE^DIE("","KFDA","MSG")
 . I $D(MSG) D AWRITE^PXRMUTIL("MSG")
 ;Delete all the QUERI patient lists.
 D BMES^XPDUTL("Deleting QUERI patient lists.")
 F NAMESTART="VA-*IHD QUERI","VA-*MH QUERI" D
 . S NAME=NAMESTART
 . S NUM=0
 . D BMES^XPDUTL("Deleting "_NAMESTART_" lists.")
 . F  S NAME=$O(^PXRMXP(810.5,"B",NAME)) Q:NAME'[NAMESTART  D
 .. S IEN=+$$FIND1^DIC(810.5,"","BX",NAME,"","","MSG")
 .. I IEN=0 Q
 .. D MES^XPDUTL("Deleting Patient List "_NAME)
 .. S IENS=IEN_","
 .. S KFDA(810.5,IENS,.01)="@"
 .. D FILE^DIE("","KFDA","MSG")
 .. I $D(MSG) D AWRITE^PXRMUTIL("MSG")
 .. S NUM=NUM+1
 . D BMES^XPDUTL("Deleted "_NUM_" "_NAMESTART_" lists.")
 Q
 ;
 ;==========================================
UPCSPON ;Make all the .01s in the Sponsor file uppercase.
 N FDA,NEWIEN,NEWNAME,MSG,OLDIEN,OLDNAME,RPL
 D BMES^XPDUTL("Checking for Sponsor Names that need to be changed to all uppercase.")
 S OLDNAME=""
 F  S OLDNAME=$O(^PXRMD(811.6,"B",OLDNAME)) Q:OLDNAME=""  D
 . I OLDNAME'?.E1.L.E Q
 . S NEWNAME=$$UP^XLFSTR(OLDNAME)
 .;If the uppercase name already exists repoint the lowercase one
 .;to it.
 . S NEWIEN=+$$FIND1^DIC(811.6,"","BXU",NEWNAME) I NEWIEN>0 D  Q
 .. K RPL
 .. D BMES^XPDUTL("The uppercase version of "_OLDNAME_" already exists at IEN="_NEWIEN)
 .. D MES^XPDUTL("repointing to it.")
 .. S OLDIEN=$O(^PXRMD(811.6,"B",OLDNAME,""))
 .. S RPL(1)=OLDIEN_U_NEWIEN
 .. D EN^DITP(811.6,.RPL)
 ..;Remove the lowercase entry.
 .. S FDA(811.6,OLDIEN_",",.01)="@"
 .. D FILE^DIE("","FDA","MSG")
 . D BMES^XPDUTL("Renaming: "_OLDNAME)
 . D MES^XPDUTL("To:       "_NEWNAME)
 . D RENAME^PXRMUTIL(811.6,OLDNAME,NEWNAME)
 ;
 ;Remove the old 'B' and 'BN' indexes and build the new 'B'.
 K ^PXRMD(811.6,"B"),^PXRMD(811.6,"BN")
 D BMES^XPDUTL("Rebuilding Sponsor B index.")
 N DIK
 S DIK="^PXRMD(811.6,",DIK(1)=".01^B"
 D ENALL^DIK
 Q
 ;

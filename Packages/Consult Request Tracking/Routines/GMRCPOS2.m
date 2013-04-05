GMRCPOS2 ; SLC/DLT - Consult postinit file maintenance ;2/18/99 15:04
 ;;3.0;CONSULT/REQUEST TRACKING;**2**;DEC 27, 1997
EN ; -- postinit
 N GMRCEND
 D FIX101
 Q
FIX101 ; Move the GMRCR prefixed protocols "File Link" values from the
 ; CONSULTS PARAMETERS FILE 123.9 to the GMRCR protocol entry
 ;
 N DA,DIE,DR,FILELINK,SITE,NAME,SERVICE
 S SITE=$O(^GMR(123.9,0)) I 'SITE D BMES^XPDUTL("CONSULTS PARAMETERS FILE not defined. Stopped PROTOCOL FILE cleanup!") S GMRCEND=1 Q
 ;
 I '$D(^GMR(123.9,SITE,99,0)) D  Q:GMRCEND
 .D BMES^XPDUTL("No GMRCR protocols saved before CONSULT/REQUEST TRACKING V 3.0 installation")
 .D BMES^XPDUTL("Need to MANUALLY correct the GMRCR-prefixed PROTOCOL FILE, FILE LINK field")
 .S GMRCEND=1 Q
 ;
 S DA=0 F  S DA=$O(^GMR(123.9,SITE,99,DA)) Q:'DA  D
 . S FILELINK=$P($G(^GMR(123.9,SITE,99,DA,0)),"^",2)
 . S NAME=$P($G(^ORD(101,DA,0)),U,1) I '$L(NAME) D  Q
 .. D BMES^XPDUTL("No FILE LINK update for PROTOCOL: PROTOCOL "_DA_" no longer defined")
 . S SERVICE=$P($G(^GMR(123.5,+FILELINK,0)),"^",1)
 . Q:FILELINK=$P($G(^ORD(101,DA,5)),"^",1)  ;no update needed
 . S DIE="^ORD(101,",DR="6////^S X=FILELINK"
 . D ^DIE
 . D BMES^XPDUTL("Changed PROTOCOL: "_NAME_", FILE LINK field to: "_SERVICE)
 . Q
 Q

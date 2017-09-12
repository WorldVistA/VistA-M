DG53546P ; BAY/KAM- Patch DG*5.3*546 Install Utility Routine ; 9/29/03 4:46pm
 ;;5.3;Registration;**546**;AUG 13, 1993
 ;
ENV ;Main entry point for Environment check point.
 ;
 S XPDABORT=""
 D PROGCHK(.XPDABORT) ;checks programmer variables
 I XPDABORT="" K XPDABORT
 Q
PRE ;Main entry point for Pre-install items.
 Q
 ;
 ;
POST ;Main entry point for Post-install items.
 ;
 D POST1
 Q
POST1 ; Update DIC(8  Eligibility Code for TRICARE/CHAMPUS
 ; NOIS CALLS CHY-0703-52232, PHI-0600-21416, MAC-1101-61117,
 ;            MAC-0201-61637, EKH-0600-41137
 N ELGIEN,NATIEN,DA,DR,DIE
 S ELGIEN=0
 F  S ELGIEN=$O(^DIC(8,ELGIEN)) Q:ELGIEN=""!(ELGIEN'?1.N)  D
 . S NATIEN=$P(^DIC(8,ELGIEN,0),"^",9)
 . I $P(^DIC(8.1,NATIEN,0),"^")="TRICARE/CHAMPUS" D 
 .. S DIE="^DIC(8,",DA=ELGIEN,DR="9///VA STANDARD"
 .. D ^DIE
 Q
PROGCHK(XPDABORT)       ;checks for necessary programmer variables
 ;
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") D
 . D BMES^XPDUTL("*****")
 . D MES^XPDUTL("Your programming variables are not set up properly.")
 . D MES^XPDUTL("Installation aborted.")
 . D MES^XPDUTL("*****")
 . S XPDABORT=2
 Q

PSDP345 ; BAY/KAM - Patch PSD*3*45 Install Utility Routine ; 4/21/04 9:04am
 ;;3.0;CONTROLLED SUBSTANCES;**45**;AUG 13, 1993
 ;
ENV ;Main Entry point for Environment Check
 S XPDABORT=""
 D PROGCHK(.XPDABORT) ;checks programmer variables
 I XPDABORT="" K XPDABORT
 Q
PROGCHK(XPDABORT) ; checks for necessary programmer variables
 ;
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^")  D
 . D BMES^XPDUTL("****")
 . D MES^XPDUTL("Your programming variables are not set up properly.")
 . D MES^XPDUTL("Installation aborted.")
 . D MES^XPDUTL("*****")
 . S XPDABORT=2
 Q

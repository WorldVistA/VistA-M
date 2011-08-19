DG53P555 ; BAY/JAT- Patch DG*5.3*555 Install Utility Routine ; 11/7/03 11:25am
 ;;5.3;Registration;**555**;AUG 13, 1993
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
POST1 ;remove references to field #1 in Race file (it is a
 ; partial duplicate of field #2) data dictionary
 ;
 K ^DD(10,1)
 K ^DD(10,"B","ABBREVIATION",1)
 K ^DD(10,"GL",0,2,1)
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

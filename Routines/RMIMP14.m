RMIMP14 ;BAY/KAM-Patch RMIM*1*4 Install Utility Routine ;12/8/04 11:58am
 ;;1.0;FUNCTIONAL INDEPENDENCE;**4**;AUG 13, 1993
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

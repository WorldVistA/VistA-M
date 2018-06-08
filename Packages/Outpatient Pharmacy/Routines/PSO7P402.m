PSO7P402 ;BP/CMF - PATCH PSO*7*402 Pre/Post-Init Rtn ;04/20/2010
 ;;7.0;OUTPATIENT PHARMACY;**402**;DEC 1997;Build 8
 ;
ENV ;environment check
 S XPDABORT=""
 ;D PRODCHK(.XPDABORT) I XPDABORT=2 Q  ;comment this line out after sprint 3
 D PROGCHK(.XPDABORT) ;checks programmer variables
 I XPDABORT="" K XPDABORT
 Q
 ;
PRODCHK(XPDABORT) ;checks for test/production account
 I $$PROD^XUPROD DO
 . D BMES^XPDUTL("******")
 . D MES^XPDUTL("PSO*7*402 is not yet ready for production accounts.")
 . D MES^XPDUTL("Installation aborted.")
 . D MES^XPDUTL("******")
 . S XPDABORT=2
 Q
 ;
PROGCHK(XPDABORT) ;checks for necessary programmer variables
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") DO
 . D BMES^XPDUTL("******")
 . D MES^XPDUTL("Your programming variables are not set up properly.")
 . D MES^XPDUTL("Installation aborted.")
 . D MES^XPDUTL("******")
 . S XPDABORT=2
 Q
 ;
PRE ;; hook for pre install actions
 Q
POST ;; hook for post install actions
 Q

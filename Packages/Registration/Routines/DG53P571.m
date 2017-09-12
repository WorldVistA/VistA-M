DG53P571 ;ALB/RPM - PATCH DG*5.3*571 INSTALL UTILITIES ; 12/15/03 4:52pm
 ;;5.3;Registration;**571**;Aug 13, 1993
 ;
ENV ;Main entry point for Environment check point.
 ;
 S XPDABORT=""
 D PROGCHK(.XPDABORT) ;checks programmer variables
 I XPDABORT="" K XPDABORT
 Q
 ;
 ;
PRE ;Main entry point for Pre-init items.
 ;
 Q
 ;
 ;
POST ;Main entry point for Post-init items.
 ;
 ;set expiration package parameter to 90 days
 D SETPARM("DGQE VIC REQUEST EXPIRATION",90)
 ;
 ;set purge package parameter to 7 days
 D SETPARM("DGQE VIC REQUEST PURGE",7)
 Q
 ;
SETPARM(DGPARM,DGDAYS) ;set PACKAGE entity parameters
 ;
 ;  DBIA: #2263 SUPPORTED PARAMETER TOOL ENTRY POINTS
 ;
 ;  Input:
 ;    DGPARM - PARAMETER DEFINITION name
 ;    DGDAYS - parameter value
 ;
 ;  Output:
 ;    None
 ;
 N DGERR
 ;
 D EN^XPAR("PKG",DGPARM,1,DGDAYS,.DGERR)
 D BMES^XPDUTL("*****")
 I '$G(DGERR) D
 . D MES^XPDUTL(DGPARM_" parameter set to "_DGDAYS_" days SUCCESSFULLY")
 E  D
 . D MES^XPDUTL(DGPARM_" parameter set FAILED")
 D MES^XPDUTL("*****")
 Q
 ;
 ;
PROGCHK(XPDABORT) ;checks for necessary programmer variables
 ;
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") DO
 .D BMES^XPDUTL("*****")
 .D MES^XPDUTL("Your programming variables are not set up properly.")
 .D MES^XPDUTL("Installation aborted.")
 .D MES^XPDUTL("*****")
 .S XPDABORT=2
 Q
 ;

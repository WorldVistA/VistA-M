PSSP254P ;BIRM/SA - PATCH PSS*1*254 Envir. Check Rtn ; Nov 05, 2021@1600
 ;;1.0;PHARMACY DATA MANAGEMENT;**254**;9/30/97;Build 109
 ;
ENV ;environment check
 S XPDABORT=""
 D CHK(.XPDABORT)
 I XPDABORT="" K XPDABORT
 Q
 ;
CHK(XPDABORT) ;checks for necessary programmer variables
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") DO
 . D BMES^XPDUTL("******")
 . D MES^XPDUTL("Your programming variables are not set up properly.")
 . D MES^XPDUTL("Installation aborted.")
 . D MES^XPDUTL("******")
 . S XPDABORT=2
 Q
 ;
HELP ; Help for ?? on Installation Question POS1 (use direct writes in env check routine)
 W !,"Enter 1 if patch is being installed in a Pre-Production (Mirror) system."
 W !,"Enter 2 if patch is being installed in a Software Quality Assurance system."
 W !,"Enter 3 if patch is being installed in a Staging system."
 W !,"Enter 4 if patch is being installed in a Development system."
 W !,"Enter 5 if patch is being installed in a Production system."
 ;

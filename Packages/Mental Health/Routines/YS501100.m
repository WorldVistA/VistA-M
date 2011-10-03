YS501100 ;BP/TMD,Post-init Routine for YS*5.01*100 ; 2/18/04 9:29am
 ;;5.01;MENTAL HEALTH;**100**;Dec 30, 1994;Build 2
 ;
ENV ;Main entry point for Environment check point.
 ;
 S XPDABORT=""
 D PROGCHK(.XPDABORT) ;checks programmer variables
 I XPDABORT="" K XPDABORT
 Q
 ;
POST ;Main entry point for Post-init items.
 ;
 ;Remove left over x-reference nodes from file restructuring
 K ^DD(604,"B","PROGRESS NOTE POINTER",.53)
 K ^DD(604,"GL",.5,3,.53)
 Q
 ;
PROGCHK(XPDABORT) ;checks for necessary programmer variables
 ;
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") D
 .D BMES^XPDUTL("*****")
 .D MES^XPDUTL("Your programming variables are not set up properly.")
 .D MES^XPDUTL("Installation aborted.")
 .D MES^XPDUTL("*****")
 .S XPDABORT=2
 Q

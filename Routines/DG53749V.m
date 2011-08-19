DG53749V ;ALB/MRY - ENVIRONMENT CHECK; 10/2/03 3:32pm
  ;;5.3;Registration;**749**;Aug 13, 1993;Build 10
 ;;
EN ;
 S XPDABORT=""
 D PROGCHK(.XPDABORT)
 I XPDABORT="" K XPDABORT
 ;
 Q
 ;
PROGCHK(XPDABORT) ;
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") DO
 .D BMES^XPDUTL("*****")
 .D MES^XPDUTL("Your programming variables are not set up properly.")
 .D MES^XPDUTL("Installation aborted.")
 .D MES^XPDUTL("*****")
 .S XPDABORT=2
 .Q
 Q

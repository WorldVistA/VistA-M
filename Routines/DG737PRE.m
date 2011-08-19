DG737PRE ;BAY/JAT;restore the audit on the INTEGRATION CONTROL NUMBER
 ;;5.3;Registration;**737**;Aug 13,1993;Build 8
 ; This is an environment check and a pre-init routine for DG*5.3*737
 ; The purpose is to turn on the audit on the INTEGRATION CONTROL NUMBER (ICN)
 ; (field 991.01 on the Patient file) which was inadvertently turned off 
 ; by patch DG*5.3*650
 ;
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
EN ;
  N FLDNUM
  S FLDNUM=991.01
  D TURNON^DIAUTL(2,FLDNUM)
  W !,"Adding AUDIT to field #",FLDNUM
  Q

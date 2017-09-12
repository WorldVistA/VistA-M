SD53P284 ; ALB/MRY - ENVIRONMENT CHECK & POST INSTALL; 2/11/03 12:49pm
 ;;5.3;Scheduling;**284**;AUG 13, 1993
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
 ;
POST ;
 ; Add/edit PCMM HL7 ERROR CODE '370M'
 N DIC,DIE,DA,DLAYGO,DR,X,Y,SDARRY,SDIENS
 S DIC="^SCPT(404.472,",DIC(0)="L",DLAYGO=404.472
 S X="370M"
 D ^DIC I Y<0 D  Q
 . D BMES^XPDUTL("*****")
 . D MES^XPDUTL("Unsuccessful entry!  ** INSTALLATION ABORTED. **")
 . D MES^XPDUTL("*****")
 . S XPDABORT=2
 S DA=+Y,DR=".02///ZPC;.03///Provider SSN;.04///Provider SSN invalid"
 S SDIENS=+Y_","
 S DIE=DIC D ^DIE
 S SDARRY(1)="Provider SSN not numeric or all zeros."
 D WP^DIE(404.472,SDIENS,10,"","SDARRY")
 D BMES^XPDUTL("*****")
 D MES^XPDUTL("   The PCMM HL7 ERROR CODE (#404.472) File has been updated")
 D MES^XPDUTL("   with the '370M' Error Code.")
 D MES^XPDUTL("*****")
 Q

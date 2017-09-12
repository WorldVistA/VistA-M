SD53P224 ;ALB/RPM - Patch SD*5.3*224 Install Utility Routine ; 8/16/00 11:04am
 ;;5.3;Scheduling;**224**;AUG 13, 1993
 ;
 ;
ENV ;Main entry point for Environment check point.
 ;
 S XPDABORT=""
 D PROGCHK(.XPDABORT) ;checks programmer variables
 D PARMCHK(.XPDABORT) ;checks param file ien exists
 I XPDABORT="" K XPDABORT
 ;
 Q
 ;
 ;
PRE ;Main entry point for Pre-init items.
 Q
 ;
 ;
POST ;Main entry point for Post-init items.
 ;
 D POST1 ;Update Client/Server files
 D POST2 ;Set HL7 Auto Retransmit Period
 ;
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
 .Q
 Q
 ;
 ;
PARMCHK(XPDABORT) ;checks for proper param file ien
 ;
 I '$D(^SCTM(404.44,1)) D
 .D BMES^XPDUTL("*****")
 .D MES^XPDUTL("Parameter file (#404.44) does not have proper IEN (1).")
 .D MES^XPDUTL("Installation aborted.")
 .D MES^XPDUTL("*****")
 .S XPDABORT=2
 .Q
 Q
 ;
 ;
POST1 ;Update client/server files.
 ;
 I $$UPCLNLST^SCMCUT("SD*5.3*224^NullClient^1^0^0") D  Q
 . D MES^XPDUTL("Client/Server files updated.")
 . Q
 D MES^XPDUTL("Client/Server files NOT updated.")
 Q
 ;
 ;
POST2 ;Set HL7 AUTO RETRANSMIT PERIOD=14 in PCMM PARAMETER file #404.44, field #16
 ;
 N DIC,DIE,DIQ,DA,DR,SCLIM
 D BMES^XPDUTL("Setting HL7 AUTO RETRANSMIT PERIOD to 14 days.")
 S DIC="^SCTM(404.44,"   ;PCMM PARAMETER file
 S DA=1                  ;should only be 1 entry
 S DR=16                 ;HL7 Auto Retransmit Period field
 S DIQ="SCLIM"           ;return array name
 D EN^DIQ1
 I '$D(SCLIM(404.44,DA,DR)) D  Q
 .D MES^XPDUTL("   HL7 AUTO RETRANSMIT PERIOD field missing")
 S SCLIM=SCLIM(404.44,DA,DR)
 S DIE=DIC
 S DR="16///14"
 D ^DIE
 D MES^XPDUTL("   HL7 AUTO RETRANSMIT LIMIT successfully changed from "_SCLIM_" to 14 days.")
 Q

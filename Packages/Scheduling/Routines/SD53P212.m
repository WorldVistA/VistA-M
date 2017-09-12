SD53P212 ;ALB/KCL - Patch SD*5.3*212 Install Utility Routine ; 04/1/2000
 ;;5.3;Scheduling;**212**;AUG 13, 1993
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
 D POST1 ;Update c/s files
 D POST2 ;Change HL7 Application Name
 D POST3 ;Set HL7 Transmit Limit
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
 I $$UPCLNLST^SCMCUT("SD*5.3*212^NullClient^1^0^0") D  Q
 . D MES^XPDUTL("Client/Server files updated.")
 . Q
 D MES^XPDUTL("Client/Server files NOT updated.")
 Q
 ;
 ;
POST2 ;Change HL7 application name from 'PCMM-210' to 'PCMM-212' in
 ;HL7 APPLICATION PARAMETER file.
 ;
 N DIE,DIC,DA,DR,X,Y
 D BMES^XPDUTL("Changing HL7 Application name from PCMM-210 to PCMM-212")
 S DIC="^HL(771,"
 S DIC(0)="X"
 S X="PCMM-210"
 D ^DIC
 I (Y<0) D  Q
 .D BMES^XPDUTL("   PCMM application not found.")
 S DIE=DIC
 S DA=+Y
 S DR=".01///PCMM-212"
 D ^DIE
 D MES^XPDUTL("   HL7 application name successfully changed to PCMM-212.")
 Q
 ;
POST3 ;Set HL7 TRANSMIT LIMIT = 2500 in PCMM PARAMETER file #404.44, field #15
 ;
 N DIC,DIE,DIQ,DA,DR,SCLIM
 D BMES^XPDUTL("Setting HL7 TRANSMIT LIMIT to 2500.")
 S DIC="^SCTM(404.44,"   ;PCMM PARAMETER file
 S DA=1                  ;should only be 1 entry
 S DR=15                 ;HL7 Transmit Limit field
 S DIQ="SCLIM"           ;return array name
 D EN^DIQ1
 I '$D(SCLIM(404.44,DA,DR)) D  Q
 .D MES^XPDUTL("   HL7 TRANSMIT LIMIT field missing")
 S SCLIM=SCLIM(404.44,DA,DR)
 S DIE=DIC
 S DR="15///2500"
 D ^DIE
 D MES^XPDUTL("   HL7 TRANSMIT LIMIT successfully changed from "_SCLIM_" to 2500.")
 Q

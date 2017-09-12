SD53P210 ;BP/CMF - Patch SD*5.3*210 utility routine; 02/17/2000
 ;;5.3;Scheduling;**210**;AUG 13, 1993
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
PRE ;Main entry point for Pre-init
 ;
 D PRE1 ;Delete PCMM HL7 ID file
 D PRE2 ;Set HL7 Application name to PCMM
 ;
 Q
 ;
 ;
POST ;Main entry point for Post-init
 ;
 D POST1 ;Update c/s files
 D POST2 ;Stuff 7 days into HL7 AUTO RETRANSMIT PERIOD field of the
 ;        PCMM PARAMETER file
 D POST3 ;Change HL7 Application Name
 ;
 Q
 ;
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
PRE1 ;Delete PCMM HL7 ID (#404.49) file, including data.
 ;rpm/alb - Added check for application version.  If 210 has been loaded
 ;          once then we don't want to initialize 404.49 with each TEST
 ;          version install.
 NEW DIU
 I $$PATCH^XPDUTL("SD*5.3*210") D  Q
 . D BMES^XPDUTL("SD*5.3*210 previously installed.  PCMM HL7 ID file not re-initialized.")
 S DIU="^SCPT(404.49,"
 S DIU(0)="DT"
 D EN^DIU2
 Q
 ;
PRE2 ;Set HL7 application name to PCMM
 ;rpm/alb A re-install of SD*5.3*210 resulted in the HL7 application name
 ;        being blank in the PCMM SEND SERVER Protocol if the HL7
 ;        application name was previously PCMM-210.
 NEW DIC,DIE,DA,DR,X,Y
 S DIC="^HL(771,"
 S X="PCMM"
 D ^DIC
 I (Y<0) D  Q
 . D BMES^XPDUTL("   PCMM application not found")
 I $$PATCH^XPDUTL("SD*5.3*210") D  Q
 . D BMES^XPDUTL("SD*5.3*210 previously installed.  Setting HL7 application name to PCMM")
 . S DIE=DIC
 . S DA=+Y
 . S DR=".01///PCMM"
 . D ^DIE
 . D MES^XPDUTL("   HL7 application name successfully changed to PCMM.")
 Q
 ;
POST1 I $$UPCLNLST^SCMCUT("SD*5.3*210^NullClient^1^0^0") D  Q
 . D MES^XPDUTL("Client/Server files updated.")
 . Q
 D MES^XPDUTL("Client/Server files NOT updated.")
 Q
 ;
POST2 ;Stuff 7 days into HL7 AUTO RETRANSMIT PERIOD field of the
 ;PCMM PARAMETER file
 NEW SCERR,SCFDA
 S SCFDA(404.44,"1,",16)=7
 D FILE^DIE(,"SCFDA","SCERR")
 Q
 ;
POST3 ;Change HL7 application name from PCMM to PCMM-210 in HL7 APPLICATION PARAMETER file.  DBIA #3068: Approval from HL7 Package for this change.
 ;rpm/alb - removed eXact match since test sites may overlap 210 and 212.
 ;          Application name needs to match the version installed.
 N DIE,DIC,DA,DR,X,Y
 D BMES^XPDUTL("Changing HL7 Application name from PCMM to PCMM-210")
 S DIC="^HL(771,"
 S X="PCMM"
 D ^DIC
 I (Y<0) D  Q
 .D BMES^XPDUTL("   PCMM application not found.")
 I $P(Y,"^",2)="PCMM-210" D  Q
 .D MES^XPDUTL("   HL7 application name is PCMM-210.  No change needed.")
 S DIE=DIC
 S DA=+Y
 S DR=".01///PCMM-210"
 D ^DIE
 D MES^XPDUTL("   HL7 application name successfully changed to PCMM-210.")
 Q

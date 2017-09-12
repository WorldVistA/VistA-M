DG53484P ; ALB/MRY - ENVIRONMENT CHECK & POST INSTALL; 4/10/03 12:49pm
 ;;5.3;Registration;**484**;AUG 13, 1993
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
 ; Change HL7 Application name
 D HLAPP("NPTF","NPTF-484")
 Q
 ;
HLAPP(OLDNAME,NEWNAME) ;Change HL7 application name
 ;Input  : OLDNAME - Name of HL7 application to change
 ;         NEWNAME - New name for HL7 application
 ;Output : None
 ;Notes  : Call designed to be used as a KIDS pre/post init
 S OLDNAME=$G(OLDNAME) Q:OLDNAME=""
 S NEWNAME=$G(NEWNAME) Q:NEWNAME=""
 N DIE,DIC,DA,DR,X,Y
 D BMES^XPDUTL("Changing HL7 Application name from "_OLDNAME_" to "_NEWNAME)
 S DIC="^HL(771,"
 S DIC(0)="X"
 S X=OLDNAME
 D ^DIC
 I (Y<0) D  Q
 .D BMES^XPDUTL("   *** "_OLDNAME_" application not found ***")
 S DIE=DIC
 S DA=+Y
 S DR=".01///^S X=NEWNAME"
 D ^DIE
 D MES^XPDUTL("HL7 application name successfully changed to "_NEWNAME)
 Q

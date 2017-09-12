DG53508 ;BPFO/JRP - POST-INIT ROUTINE;6/11/2003
 ;;5.3;Registration;**508**;Aug 13, 1993
 ;
 ; - This was copied from SD*5.3*239
 ;
POST ;Main entry point for post init
 ;Change HL7 application name
 D HLAPP("NPTF-484","NPTF-508")
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

ORAMP559 ;SLC/PKR - Post Installation. ;05/26/2021
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**559**;Dec 17, 1997;Build 9
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This routine uses the following ICR:
 ; #2058 - Add Additional Prefix to Package file.
 ;
 Q
 ;
ADDPREFIX ;Add ORAM as an additional prefix.
 N FDA,IEN,IENS,MSG
 S IEN=+$$FIND1^DIC(9.4,"","M","ORDER ENTRY/RESULTS REPORTING","","","MSG")
 I IEN=0 D  Q
 . D MES^XPDUTL("Could not find ORDER ENTRY/RESULTS REPORTING Package file entry, please enter a SNOW ticket")
 ;Check to see if ORAM has already been added as an Additional Prefix.
 S IENS=","_IEN_","
 I +$$FIND1^DIC(9.4014,IENS,"M","ORAM","","","MSG")>0 D  Q
 . D MES^XPDUTL("ORAM has already been added as an Additional Prefix.")
 S IENS="+1,"_IEN_","
 S FDA(9.4014,IENS,.01)="ORAM"
 D UPDATE^DIE("E","FDA","","MSG")
 I $D(DIERR) D
 . D MES^XPDUTL("There was a problem adding ORAM as an Additional Prefix, the error was:")
 . D MES^XPDUTL(MSG("DIERR",1,"TEXT",1))
 E  D MES^XPDUTL("ORAM was added as an Additional Prefix.")
 Q
 ;

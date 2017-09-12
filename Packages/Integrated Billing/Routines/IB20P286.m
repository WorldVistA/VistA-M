IB20P286 ;OAK/ELZ - POST INSTALL FOR IB*2*313 ;19-SEP-2005
 ;;2.0;INTEGRATED BILLING;**286**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This is the post install routine for IB*2*286.  This routine will
 ; add IBB PFSS CHARGE ERRORS mail group to file #372;
 ; this mail group receives any error message generated in IBB 
 ; after a call to CHARGE^IBBAPI.
 ;
POST ;
 N X,GROUP,FDA,IENS,ERR,IBB,IBBERROR
 S GROUP="IBB PFSS CHARGE ERRORS"
 D BMES^XPDUTL("Updating MAIL GROUP FOR CHARGE field in PFSS Site Parameter file...")
 S IENS="1,"
 S ERR="IBB(""DIERR"")"
 S FDA(372,IENS,.06)=GROUP
 D FILE^DIE("E","FDA",ERR)
 I $D(IBB("DIERR")) S IBBERROR=IBB("DIERR","DIERR",1,"TEXT",1)
 I $G(IBBERROR)'="" D
 .D BMES^XPDUTL("Update failed.")
 .D BMES^XPDUTL(IBBERROR)
 I $G(IBBERROR)="" D
 .D BMES^XPDUTL("Successfully updated.")
 .D BMES^XPDUTL("Add members to group "_GROUP_" as recommended by your VISN.")
 D BMES^XPDUTL(" ")
 Q

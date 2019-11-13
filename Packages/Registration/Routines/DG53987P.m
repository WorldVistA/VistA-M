DG53987P ;ALB/JAM - DG*5.3*987 PRE INSTALL TO UPDATE HEALTH BENEFIT PLANS ;05/10/19 9:18pm
 ;;5.3;Registration;**987**;Aug 13, 1993;Build 22
 ;
 ;  Integration Agreements:
 ;        10141 : BMES^XPDUTL
 ;              : MES^XPDUTL
 ;        10018 : UPDATE^DIE
 Q
 ;Pre-install routine to perform the following tasks:
 ; Update the NAME (.01) field values for all HBP's in the HEALTH BENEFIT PLAN (#25.11) file to UPPERCASE.
 ;
PRE ; Entry point for pre-install
 ;
 L +^DGHBP(25.11,0):10 I '$T D BMES^XPDUTL("     Health Benefit Plan (#25.11) File is locked by another user.  Please log YOUR IT Services ticket.") Q
 ;
 ; Convert the NAME (.01) field values for all HBP's in the HEALTH BENEFIT PLAN (#25.11) file to UPPERCASE.
 D BMES^XPDUTL("NAME (#.01) field conversion Health Benefit Plan (#25.11) file is started.")
 D UPDPLN
 D BMES^XPDUTL("NAME (#.01) field conversion in Health Benefit Plan (#25.11) file is completed.")
 ;
 L -^DGHBP(25.11,0)
 Q
 ;
UPDPLN ; Update existing plan names to UPPERCASE
 ;
 N DGIEN,DGPLAN,DGFIELDS,DGERR,DGPNAME,DGUNAME
 S DGERR="",DGIEN=0
 F  S DGIEN=$O(^DGHBP(25.11,DGIEN)) Q:'DGIEN  D
 . S DGPLAN=^DGHBP(25.11,DGIEN,0)
 . S DGPNAME=$P(DGPLAN,"^",1)
 . ; convert to UPPERCASE
 . S DGUNAME=$TR(DGPNAME,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 . S DGFIELDS("NAME")=DGUNAME
 . D UPDPLN1(DGIEN,.DGFIELDS,.DGERR)
 . I DGERR'="" D
 . . D BMES^XPDUTL("    *** An Error occurred during converting ")
 . . D MES^XPDUTL("    "_DGPNAME)
 . . D MES^XPDUTL("     *** "_DGERR_" ***")
 . . D MES^XPDUTL("     Please log YOUR IT Services ticket.")
 Q
 ;
UPDPLN1(DGIEN,DGFIELDS,DGERR) ; Update entries in the HEALTH BENEFIT PLAN File (25.11)
 ;
 ;  Input: DGIEN - IEN of Plan,
 ;         DGFIELDS - Array of Field Values
 ;
 ;  Output:   DGERR - Error Text
 ;
 N DGNAME,DGFDA
 K DGERR
 S DGERR=""
 S DGNAME=$G(DGFIELDS("NAME"))
 I DGNAME="" S DGERR="Missing Health Benefit Plan Name" Q
 I 'DGIEN S DGERR="IEN is not found" Q
 S DGIEN=DGIEN_","
 S DGFDA(25.11,DGIEN,.01)=DGNAME
 D UPDATE^DIE("E","DGFDA","","DGERR")
 I $D(DGERR("DIERR")) S DGERR=$G(DGERR("DIERR",1,"TEXT",1)) Q
 Q
 ;

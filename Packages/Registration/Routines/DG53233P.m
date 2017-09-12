DG53233P ;PB  - ENROLLMENT/ELIGIBILITY QUERY FUNCTIONALITY; 04/19/1999
 ;;5.3;REGISTRATION;**233**;04/20/99
 ;
 ;
 ; The Enrollment Query Functionality allows sites to query
 ; HEC for enrollment and eligibility data during patient registration.
 ;
 ; Inorder to activate the Enrollment/Eligibility Query Functionality
 ; the ENROLLMENT QUERY ACTIVE field (#15) in the IVM SITE PARAMETER 
 ; file (#301.9) should be set to '1' for Active.  This field serves 
 ; as a switch to turn on and off transmission of Enrollment queries 
 ; sent to HEC from VistA.
 ;
 ; This routine does not serve to turn transmission on or off. It only
 ; turns it on.
 ;
 ;
BEGIN N DIR,DIC,DA,DR,DIQ,DGDIQ,ACTIVE
 ;
 ; check that IVM SITE PARAMETER FILE exists
 I '$D(^IVM(301.9)) D  Q
 .D BMES^XPDUTL(">>> Missing IVM SITE PARAMTER FILE.")
 .D MES^XPDUTL("Please contact the PIMS National VISTA Support Team for assistance")
 .Q
 ;
 ; get value of ENROLLMENT QUERY ACTIVE field
 S DIQ(0)="I",DIC="^IVM(301.9,",DA=1,DR="15",DIQ="DGDIQ"
 D EN^DIQ1
 I $G(DGDIQ(301.9,DA,DR,"I"))=0 S ACTIVE=0
 E  S ACTIVE=1
 I 'ACTIVE D
 .; This field is uneditable so use a direct set to change
 .S ^IVM(301.9,1,15)=1
 .D BMES^XPDUTL(">>> ENROLLMENT QUERY ACTIVE field (#15) set to ACTIVE.")
 .Q
 I ACTIVE D
 .D BMES^XPDUTL(">>> ENROLLMENT QUERY ACTIVE field (#15) already set to ACTIVE.")
 .Q
 D BMES^XPDUTL(">>> Done.")
 QUIT

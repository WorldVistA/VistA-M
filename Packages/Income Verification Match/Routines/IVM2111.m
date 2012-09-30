IVM2111 ;ALB/TMK - POST INSTALL FOR PATCH IVM*2*111 ; 10-FEB-2006
 ;;2.0;INCOME VERIFICATION MATCH;**111**; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ;
 D BMES^XPDUTL("Deleting IVM PARAMETER field #.04 SUPPRESS INSURANCE MESSAGE")
 S DIE="^IVM(301.9,",DR=".04///@",DA=1 D ^DIE ; Delete data
 S DIK="^DD(301.9,",DA=.04,DA(1)=301.9 D ^DIK ; Delete field
 D BMES^XPDUTL("Step complete")
 ;
 D BMES^XPDUTL("Queueing job to auto-upload existing HL7 Z04 messages to the buffer file")
 S ZTIO="",ZTDESC="Uploads existing insurance messages to buffer file"
 S ZTRTN="AUTO^IVMLINS3",ZTDTH=$$NOW^XLFDT()
 D ^%ZTLOAD
 D BMES^XPDUTL($S($D(ZTSK):"This job has been queued.  The task number is "_ZTSK,1:"This job could not be queued"))
 D BMES^XPDUTL("To restart this job, use 'D AUTO^IVMLINS3'")
 D BMES^XPDUTL("Step complete")
 D BMES^XPDUTL("End of post-install")
 Q
 ;

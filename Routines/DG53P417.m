DG53P417 ;ALB/GPM - Patch DG*5.3*417 Install Utility Routine ; 10/25/01 10:09am
 ;;5.3;Registration;**417**;AUG 13, 1993
 ;
 ;
 ;
EN D STATUS ;Add new entry to ENROLLMENT STATUS file (#27.15)
 Q
 ;
 ;
STATUS ; Add new entry to ENROLLMENT STATUS file (#27.15)
 N FDA,ERR
 D BMES^XPDUTL("Add New Rejected Enrollment Status.")
 I $$FIND1^DIC(27.15,"","X","REJECTED; BELOW ENROLLMENT GROUP THRESHOLD") D BMES^XPDUTL("*** New Rejected Status entry already exists!") Q
 S FDA(27.15,"+1,",.01)="REJECTED; BELOW ENROLLMENT GROUP THRESHOLD"
 S FDA(27.15,"+1,",.02)="N"
 D UPDATE^DIE("","FDA","","ERR")
 I $D(ERR) D BMES^XPDUTL("ERROR! New Rejected Status not added!"),MES^XPDUTL(ERR("DIERR",1)_": "_ERR("DIERR",1,"TEXT",1)) Q
 D MES^XPDUTL("New Rejected Status successfully added.")
 Q

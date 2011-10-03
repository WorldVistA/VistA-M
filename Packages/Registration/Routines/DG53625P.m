DG53625P ;TDM - Patch DG*5.3*625 Install Utility Routine ; 10/19/04 10:40am
 ;;5.3;Registration;**625**; Aug 13,1993
 ;
 Q
ADDMGRP ;Check for IB MEANS TEST mail group and add if not already there.
 N MGRP,WPARY,FDA,ERR
 S MGRP="IB MEANS TEST"
 ;
 D BMES^XPDUTL("Add '"_MGRP_"' mail group.")
 K FDA,ERR
 I $$FIND1^DIC(3.8,"","X",MGRP) D BMES^XPDUTL("'"_MGRP_"' entry already exists!") Q
 S WPARY(1,0)="This mail group will receive Means Test error messages from integrated billing."
 S WPARY(2,0)="errors and the editing/deletion of records which are associated with"
 S WPARY(3,0)="Means Test/Category C billing."
 ;
 S FDA(3.8,"+1,",.01)=MGRP
 S FDA(3.8,"+1,",3)="WPARY"
 S FDA(3.8,"+1,",4)="PU"
 S FDA(3.8,"+1,",5)=.5
 ;
 D UPDATE^DIE("","FDA","","ERR")
 I $D(ERR) D BMES^XPDUTL(MGRP_" not added!  ERROR:"),MES^XPDUTL(ERR("DIERR",1)_": "_ERR("DIERR",1,"TEXT",1)) Q
 D MES^XPDUTL("'"_MGRP_"' successfully added.")
 Q

DGBT1P3 ;ALB/MRY - Patch #3 Environment Check ; 7/15/03 10:04 AM
 ;;1.0;Beneficiary Travel;**3**;Septembr 25, 2001
EN ;
 S XPDABORT=""
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") D  G ABRT
 . D BMES^XPDUTL("*****")
 . D MES^XPDUTL("Your programming variables are not set up properly.")
 . D MES^XPDUTL("Installation aborted.")
 ; Verify that Bene Travel v1.0 exists, else Quit.
 I $$VERSION^XPDUTL("DGBT")'="1.0" D  G ABRT
 . D BMES^XPDUTL("*****")
 . D MES^XPDUTL("VERSION 1.0 OF BENEFICIARY TRAVEL HAS NOT BEEN LOADED.")
 . D MES^XPDUTL("Installation aborted.")
 W !!,">> Environment check complete and okay."
 Q
 ;
POST ;Post-init. kill off bad cross reference, re-index.
 N DIK
 D BMES^XPDUTL("*****")
 D MES^XPDUTL("Re-indexing 'BB' cross-reference.")
 K ^DGBT(392.31,"BB") S DIK="^DGBT(392.31," D IXALL^DIK
 Q
 ;
ABRT ; Abort transport, but leave in ^XTMP.
 S ^XPDABORT=2 Q

DGJ1P1 ;ALB/MRY - Patch #1 Environment Check ; 12/9/02 10:04 AM
 ;;1.0;Incomplete Records Tracking;**1**;Jun 25, 2001
EN ;
 S XPDABORT=""
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") D  G ABRT
 . D BMES^XPDUTL("*****")
 . D MES^XPDUTL("Your programming variables are not set up properly.")
 . D MES^XPDUTL("Installation aborted.")
 ; Verify that Incomplete Records Tracking v1.0 exists, else Quit.
 I $$VERSION^XPDUTL("DGJ")'="1.0" D  G ABRT
 . D BMES^XPDUTL("*****")
 . D MES^XPDUTL("VERSION 1.0 OF INCOMPLETE RECORDS TRACKING HAS NOT BEEN LOADED.")
 . D MES^XPDUTL("Installation aborted.")
 W !!,">> Environment check complete and okay."
 Q
 ;
ABRT ; Abort transport, but leave in ^XTMP.
 S ^XPDABORT=2 Q
 ;

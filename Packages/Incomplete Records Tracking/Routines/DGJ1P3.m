DGJ1P3 ;ALB/MRY - Patch #3 Environment Check ; 8/23/04 10:04 AM
 ;;1.0;Incomplete Records Tracking;**3**;Jun 25, 2001
 ;
EN ;
 S XPDABORT=""
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") D  G ABRT
 . D BMES^XPDUTL("*****")
 . D MES^XPDUTL("Your programming variables are not set up properly.")
 . D MES^XPDUTL("Installation aborted.")
 W !!,">> Environment check complete and okay."
 Q
 ;
ABRT ; Abort transport, but leave in ^XTMP.
 S ^XPDABORT=2 Q
 ;
PRE ; Kill DD field (#10.04) of file (#393).  Rebuild in Build.
 S DIK="^DD(393,",DA=10.04,DA(1)=393
 D ^DIK
 Q
 ;
POST ;Post init - Disable Corefls option.
 N DIC,TEXT
 S DIC="^DIC(19,",DIC(0)="X"
 S X="DGJ LOCAL VENDOR ADD" D
 . D ^DIC Q:Y<0  D
 .. D BMES^XPDUTL("*****")
 .. D MES^XPDUTL("Putting ["_X_"] option - 'out of order'")
 .. S TEXT="CoreFLS Disabled (DGJ*1*3)"
 .. D OUT^XPDMENU(X,TEXT)
 Q

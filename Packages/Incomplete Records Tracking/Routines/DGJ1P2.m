DGJ1P2 ;ALB/MRY - Patch #2 Environment Check ; 3/9/04 10:04 AM
 ;;1.0;Incomplete Records Tracking;**2**;Jun 25, 2001
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
POST ; DBIA #4376
 I $D(^DD(393,10.04,"V","B",440,2)),$D(^DD(393,10.04,"V","B",392.31,2)) D
 . K ^DD(393,10.04,"V","B",440,2)
 I $D(^DD(393,10.04,"V","M","VENDOR",2)),$D(^DD(393,10.04,"V","M","LOCAL VENDOR",2)) D
 . K ^DD(393,10.04,"V","M","VENDOR",2)
 I $D(^DD(393,10.04,"V","P","V",2)),$D(^DD(393,10.04,"V","P","L",2)) D
 . K ^DD(393,10.04,"V","P","V",2)
 Q
 ;

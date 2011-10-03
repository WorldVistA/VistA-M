SD53P478 ;ALB/MRY - POST INIT ;3/14/06
 ;;5.3;Scheduling;**478**;Aug 13, 1993
 ;
EN ;
 S XPDABORT=""
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") D  G ABRT
 . D BMES^XPDUTL("*****")
 . D MES^XPDUTL("Your programming variables are not set up properly.")
 . D MES^XPDUTL("Installation aborted.")
 W !!,">> Environment check complete and okay."
 I XPDABORT="" K XPDABORT
 Q
 ;
ABRT ; Abort transport, but leave in ^XTMP.
 S XPDABORT=2 Q

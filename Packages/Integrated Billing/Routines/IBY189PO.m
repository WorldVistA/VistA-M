IBY189PO ;ALB/TMK - IB*2*189 POST-INSTALL ;06-AUG-2002
 ;;2.0;INTEGRATED BILLING;**189**;21-MAR-94
 ;
POST ;Set up check points for post-init
 S %=$$NEWCP^XPDUTL("U36","U36^IBY189PO")
 Q
 ;
U36 N %,Z,IBDA,IBCT,IBCTX,DA,DIE,X,Y,DR
 D BMES^XPDUTL("Deleting bad EDI IDs from Insurance Company file")
 S IBDA=+$$PARCP^XPDUTL("U36"),IBCT=0,IBCTX=0
 F  S IBDA=$O(^DIC(36,IBDA)) Q:'IBDA  S Z=$G(^(IBDA,3)),IBCT=IBCT+1 D
 . S DR=""
 . I $P(Z,U,2)=36330!($P(Z,U,2)="PAYID") S DR="3.02///@",IBCTX=IBCTX+1
 . I $P(Z,U,4)=36330!($P(Z,U,4)="PAYID") S DR=DR_$S(DR="":"",1:";")_"3.04///@",IBCTX=IBCTX+1
 . I DR'="" S DIE="^DIC(36,",DA=IBDA D ^DIE
 . I IBCT=20 S %=$$UPCP^XPDUTL("U36",IBDA),IBCT=0
 D BMES^XPDUTL("Post install complete - "_IBCTX_" ID(s) deleted.")
 Q
 ;

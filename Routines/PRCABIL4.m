PRCABIL4 ;WIRMFO/RWT-DELETE BILL LEAVING AUDIT TRAIL
V ;;4.5;Accounts Receivable;**67**;March 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
DELETE ;Deletes a Bill leaving an audit trail
 ;REQUIRES PRCABN=Bill IEN to delete
 ;         PRCACOMM=Reason why this bill is being deleted
 N PRCACAT,PRCASTAT,PRCAID,B0,DIK,DIE,DA,DR
 I '$D(^PRCA(430,PRCABN,0)) Q
 S B0=$G(^PRCA(430,PRCABN,0))
 S PRCAID=$P(B0,U,1),PRCACAT=$P(B0,U,2),PRCASTAT=$P(B0,U,8)
 S DIK="^PRCA(430,",DA=PRCABN D ^DIK K DIK
 ;
 ; Now Add it back in w/ audit trails
 S X=PRCAID,DINUM=PRCABN,DIC="^PRCA(430,",DIC(0)="L",DLAYGO=430
 K DD,DO D FILE^DICN K DIC,DLAYGO,DO
 ;
 ; Ensure that the last entry number counter is correct
 S $P(^PRCA(430,0),U,3)=$O(^PRCA(430,"A"),-1)
 ;
 S DIE="^PRCA(430,",DR="[PRCA CREATE BILL STUB]",DA=PRCABN D ^DIE
 Q

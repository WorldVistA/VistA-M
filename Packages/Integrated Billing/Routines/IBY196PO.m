IBY196PO ;ALB/TMK - IB*2*196 POST-INSTALL ;06-AUG-2002
 ;;2.0;INTEGRATED BILLING;**196**;21-MAR-94
 ;
POST ;Set up check points for post-install
 S %=$$NEWCP^XPDUTL("BATCH","BATCH^IBY196PO")
 Q
 ;
BATCH N %,Z,IBCT,IBDA,IBSAVE,IBBILL,IB,IB0,IBACC,DA,DIE,X,Y,DR,Z
 D BMES^XPDUTL("Updating batches with Austin Confirmation status")
 ; Logic: Read through all the batches in file 364.1
 ;  If the batch is not in RECEIVED IN AUSTIN status (A0), check if any
 ;  of the bills in that batch have an A0, A1 or A2 status.  This
 ;  will indicate the batch was received in Austin and the status
 ;  of the batch is wrong.  If this is the case, update the batch
 ;  status to A0 and update the status of any of the bills in the
 ;  batch that still have a 'P' status to A0.
 S (IBCT,IBDA)=0
 F  S IBDA=$O(^IBA(364.1,IBDA)) Q:'IBDA  I $P($G(^IBA(364.1,IBDA,0)),U,2)="P" D
 . ; Find bills in the batch
 . K IBSAVE S IBACC=0
 . S IBBILL=0 F  S IBBILL=$O(^IBA(364,"C",IBDA,IBBILL)) Q:'IBBILL  S IB0=$G(^IBA(364,IBBILL,0)) I IB0'="" D
 .. S IB=$P(IB0,U,3) ; Bill status
 .. I IB["A" S IBACC=1 Q  ; Accepted by Austin, non-payer or payer
 .. I IB="P" S IBSAVE(IBBILL)="" ; Still pending confirmation
 . I IBACC D
 .. S IBCT=IBCT+1
 .. S DR=".02////A0",DIE="^IBA(364.1,",DA=IBDA D ^DIE
 .. S Z=0 F  S Z=$O(IBSAVE(Z)) Q:'Z  I $P($G(^IBA(364,Z,0)),U,3)="P" S DR=".03////A0",DIE="^IBA(364,",DA=Z D ^DIE
 D BMES^XPDUTL("Post install complete - "_IBCT_" batches updated")
 Q
 ;

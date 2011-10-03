IBCRBF ;ALB/ARH - RATES: BILL FILE CHARGES ;22-MAY-1996
 ;;2.0;INTEGRATED BILLING;**52,106,51**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ADDRC(IBIFN,IBRVCD,IBBS,IBCHG,IBUNITS,IBCPT,IBDIV,IBAA,IBITYP,IBIPTR,IBCMPNT) ; add a revenue code charge entry to a bill (399,42)
 ; returns DA of new entry or -1
 N X,Y,DA,DLAYGO,DIC,DIE,DR,IBDA,DGXRF1,Z,Z1 S IBDA=-1
 ;
 I ($G(IBCHG)'>0)!('$G(IBUNITS)) G ADDRCQ
 I $G(^DGCR(399,+$G(IBIFN),0))="" G ADDRCQ
 I '$P($G(^DGCR(399.2,+$G(IBRVCD),0)),U,3) G ADDRCQ
 I '$P($G(^DGCR(399.1,+$G(IBBS),0)),U,5) G ADDRCQ
 S IBCPT=$G(IBCPT) I +IBCPT,$$CPT^ICPTCOD(+IBCPT,DT)<1 G ADDRCQ
 S IBDIV=$G(IBDIV) I +IBDIV,'$D(^DG(40.8,+IBDIV,0)) G ADDRCQ
 S IBCHG=+$FN(IBCHG,"",2)
 ;
 K DD,DO S DIC("P")=$P(^DD(399,42,0),U,2)
 S DLAYGO=399,DA(1)=IBIFN,DIC="^DGCR(399,"_DA(1)_",""RC"",",DIC(0)="L",X=IBRVCD D FILE^DICN G:Y<1 ADDRCQ
 ;
 S DR=".02////"_IBCHG_";.03////"_IBUNITS_";.05////"_IBBS
 I +IBCPT S DR=DR_";.06////"_IBCPT I +IBDIV S DR=DR_";.07////"_IBDIV
 I +$G(IBAA) S DR=DR_";.08////1"
 I +$G(IBITYP)>0,IBITYP<10 S DR=DR_";.1////"_IBITYP I +$G(IBIPTR) S DR=DR_";.11////"_IBIPTR
 I +$G(IBCMPNT)>0,IBCMPNT<3 S DR=DR_";.12////"_IBCMPNT
 I IBITYP=3,IBIPTR D
 . N Z
 . S Z=+$O(^TMP("IBCRRX",$J,IBIPTR,0))
 . I Z S DR=DR_";.15////"_Z K ^TMP("IBCRRX",$J,IBIPTR,Z)
 S (DA,IBDA)=+Y,DIE=DIC D ^DIE
 ;
ADDRCQ Q IBDA
 ;
DELALLRC(IBIFN) ; delete all charges on the bill that were automatically calculated and added
 ;
 N IBI,DA,DIK,X,Y,DGXRF1,Z,Z1
 K ^TMP("IBCRRX",$J)
 I +$G(IBIFN) S IBI=0 F  S IBI=$O(^DGCR(399,+IBIFN,"RC",IBI)) Q:'IBI  D
 . N Z0
 . S Z0=$G(^DGCR(399,+IBIFN,"RC",IBI,0))
 . I '$P(Z0,U,8) Q
 . ; Capture revenue codes and their relation to prescriptions
 . I $P(Z0,U,15) S ^TMP("IBCRRX",$J,+$P(Z0,U,11),$P(Z0,U,15))=""
 . ; Be careful changing the name of this array - this is used in index
 . ; ADPR - file 399.042, fields .01 and .03 to determine if the RX
 . ; procedures should be deleted when the revenue codes are
 . S DA(1)=+IBIFN,DA=IBI,DIK="^DGCR(399,"_DA(1)_",""RC""," D ^DIK K DIK
 Q
 ;

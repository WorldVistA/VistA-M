IBCRBF ;ALB/ARH - RATES: BILL FILE CHARGES ;22-MAY-1996
 ;;2.0;INTEGRATED BILLING;**52,106,51,447**;21-MAR-94;Build 80
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ADDRC(IBIFN,IBRVCD,IBBS,IBCHG,IBUNITS,IBCPT,IBDIV,IBAA,IBITYP,IBIPTR,IBCMPNT) ; add a revenue code charge entry to a bill (399,42)
 ; returns DA of new entry or -1
 N X,Y,DA,DLAYGO,DIC,DIE,DR,IBDA,DGXRF1,Z,Z1 S IBDA=-1
 ;
 ; START IB*2.0*447 BI ZERO DOLLAR CHANGES
 ;I ($G(IBCHG)'>0)!('$G(IBUNITS)) G ADDRCQ
 I '$G(IBUNITS) G ADDRCQ
 ; END IB*2.0*447 BI ZERO DOLLAR CHANGES
 I $G(^DGCR(399,+$G(IBIFN),0))="" G ADDRCQ
 I '$P($G(^DGCR(399.2,+$G(IBRVCD),0)),U,3) G ADDRCQ
 I '$P($G(^DGCR(399.1,+$G(IBBS),0)),U,5) G ADDRCQ
 S IBCPT=$G(IBCPT) I +IBCPT,$$CPT^ICPTCOD(+IBCPT,DT)<1 G ADDRCQ
 S IBDIV=$G(IBDIV) I +IBDIV,'$D(^DG(40.8,+IBDIV,0)) G ADDRCQ
 S IBCHG=+$FN(IBCHG,"",2)
 ;
 I $$NOIPINST(IBIFN),$$RCDUP(IBIFN,IBRVCD,IBITYP,IBIPTR,.IBCHG) S IBCHG=+$FN(IBCHG,"",2) G ADDRCQ  ; ADDED TO PREVENT DUPLICATE REVENUE CODES IB*2.0*447 BI
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
 . I $$NOIPINST(IBIFN),+$P(Z0,U,16) Q  ; Don't delete if MANUALLY EDITED, IB*2.0*447 BI
 . ; Capture revenue codes and their relation to prescriptions
 . I $P(Z0,U,15) S ^TMP("IBCRRX",$J,+$P(Z0,U,11),$P(Z0,U,15))=""
 . ; Be careful changing the name of this array - this is used in index
 . ; ADPR - file 399.042, fields .01 and .03 to determine if the RX
 . ; procedures should be deleted when the revenue codes are
 . S DA(1)=+IBIFN,DA=IBI,DIK="^DGCR(399,"_DA(1)_",""RC""," D ^DIK K DIK
 Q
 ;
RCDUP(IBIFN,IBRVCD,IBITYP,IBIPTR,IBCHG) ; Check for duplicate Revenue Codes for the same Charge Code
 ; IB*2.0*447 BI
 ; Inputs: IBIFN  - Bill/Claim IEN
 ;         IBIPTR - Charge Code Multiple IEN
 ; Output: RCDUP  - 0=No Duplicate, 1=Duplicate Exists
 ;
 N RCLOOP,RC0
 N RCDUP S RCDUP=0
 I $G(IBIFN)="" Q RCDUP
 S RCLOOP=0 F  S RCLOOP=$O(^DGCR(399,IBIFN,"RC",RCLOOP)) Q:+RCLOOP=0!(RCDUP=1)  D
 . S RC0=$G(^DGCR(399,IBIFN,"RC",RCLOOP,0)) Q:RC0=""  Q:'$P(RC0,U,16)
 . I $P(RC0,U,1)=IBRVCD,$P(RC0,U,10)=IBITYP,$P(RC0,U,11)=IBIPTR S IBCHG=$P(RC0,U,2),RCDUP=1
 Q RCDUP
 ;
NOIPINST(IBIFN) ; Test for Not Inpatient Institutional.
 ; Returns a 1 if the claim is not an Inpatient Institutional claim.
 Q '($$INPAT^IBCEF(IBIFN)&($P($G(^DGCR(399,+$G(IBIFN),0)),U,27)=1))

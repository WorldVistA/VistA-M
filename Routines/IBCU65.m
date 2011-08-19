IBCU65 ;ALB/ARH - BILL CHARGE UTILITY: COMBINE E&M ; 12/01/04
 ;;2.0;INTEGRATED BILLING;**287**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Combine (E&M) Charges on one bill: 
 ; 90801-90815, 90845-90899, 99201-99215, 99241-99245, 99271-99288, 99385-99387, 99395-99429, 99499
 ; For each of the procedures update the first line item to include both the professional and facility charge
 ; If there is another line item for the procedure then delete it (no bill CT)
 ;
ASKCMB(IBIFN) ; if the user requests, combine (E&M) charges on the bill
 N DIR,DIRUT,DTOUT,DUOUT,X,Y S IBIFN=+$G(IBIFN) Q:'IBIFN
 ;
 I '$$CHKBILL(IBIFN) Q  ; provider based bill with combinable procedures
 ;
 W !! S DIR("?")="Enter Yes to add both Institutional and Professional charge for E&M codes"
 S DIR("?",1)="The Professional and Facility charges of certain E&M codes may be combined onto"
 S DIR("?",2)="one line item on this bill.",DIR("?",3)=" "
 S DIR("B")="NO",DIR("A")="Combine Institutional and Professional Charges for E&M Procedures"
 S DIR(0)="Y" D ^DIR Q:$D(DIRUT)  Q:'Y
 ;
 I Y=1 D CHGCMB(IBIFN)
 Q
 ;
CHGCMB(IBIFN) ; combine certain E&M codes on the bill
 N IBRC,IBRC0,IBCPT,IBRCCT,IBMATCH,IBCHGS,IBTCHG,IBDONE,IBX K ^TMP($J,"IBCU65 CMB") Q:'$G(IBIFN)
 ;
 D BILLCHG(IBIFN) I '$D(^TMP($J,"IBCU65 CMB")) Q
 ;
 S IBRC=0 F  S IBRC=$O(^DGCR(399,IBIFN,"RC",IBRC)) Q:'IBRC  D
 . S IBRC0=$G(^DGCR(399,IBIFN,"RC",IBRC,0))
 . ;
 . S IBCPT=$P(IBRC0,U,6) Q:'IBCPT  I '$$CHKCODE(IBCPT) Q  ; charge must be for a combinable cpt
 . S IBRCCT=$P(IBRC0,U,12) I IBRCCT'=1,IBRCCT'=2 Q  ; must be a component charge
 . I '$P(IBRC0,U,8) Q  ; charge must be auto created
 . ;
 . S IBMATCH=$P(IBRC0,U,3)_U_IBCPT_U_$P(IBRC0,U,7)_U_$P(IBRC0,U,10)_U_$P(IBRC0,U,11)
 . ;
 . S IBCHGS=$G(^TMP($J,"IBCU65 CMB",IBMATCH)) Q:IBCHGS=""  ; find match
 . ;
 . I +$G(IBDONE(IBMATCH)) I $$RVDEL(IBIFN,IBRC) D  Q  ; if already combined delete line item
 .. S IBX(IBCPT_" "_IBRC)=$S(IBRCCT=1:"Facility",1:"Professional")_" Charge for "_IBCPT_" deleted "_$P(IBRC0,U,2)
 . ;
 . S IBTCHG=$P(IBCHGS,U,3) Q:'IBTCHG
 . ;
 . I $$RVCHG(IBIFN,IBRC,IBTCHG) S IBDONE(IBMATCH)=1 D  ; match found, combine charges
 .. S IBX(IBCPT_" "_IBRC)="Charge for "_IBCPT_" combined: "_$P(IBCHGS,U,1)_"+"_$P(IBCHGS,U,2)_"="_IBTCHG
 ;
 I '$D(ZTQUEUED),'$G(IBAUTO) S IBX="" F  S IBX=$O(IBX(IBX)) Q:IBX=""  W !,IBX(IBX)
 K ^TMP($J,"IBCU65 CMB")
 Q
 ;
 ;
 ;
RVDEL(IBIFN,RCIFN) ; delete charge line item, Output: 0/1
 ; Input:  IBIFN = Bill Number, RCIFN = Charge Line Item in RC multiple
 N IBX,DIK,DIC,X,Y,Z,Z1,DA,D0,D1,DG,DICR,DIG,DIH,DIW,DGXRF1 S IBX=0
 I $D(^DGCR(399,+$G(IBIFN),"RC",+$G(RCIFN),0)) D  S IBX=1
 . S DA(1)=+IBIFN,DA=+RCIFN,DIK="^DGCR(399,"_DA(1)_",""RC""," D ^DIK K DIK
 Q IBX
 ;
RVCHG(IBIFN,RCIFN,CHG) ; update line item charge and remove component, Output: 0/1
 ; Input:  IBIFN = Bill Number, RCIFN = Charge Line Item in RC multiple, CHG = New Charge Amount
 N IBX,DA,DIE,DIC,DR,X,Y,Z,Z1,D,D0,D1,DI,DQ,DGXRF1 S IBX=0
 I $D(^DGCR(399,+$G(IBIFN),"RC",+$G(RCIFN),0)) D  S IBX=1
 . S DA(1)=+IBIFN,DIE="^DGCR(399,"_DA(1)_",""RC"",",DR=".12///@;.02////"_+$G(CHG),DA=+RCIFN D ^DIE
 Q IBX
 ;
 ;
CHKCODE(CPT) ; return true if CPT code combinable
 N IBOUT S CPT=+$G(CPT) S IBOUT=0
 I (CPT<90800)!(CPT>99500) S IBOUT=0 G CHKCODQ
 ;
 I CPT>90800,CPT<90816 S IBOUT=1 G CHKCODQ
 I CPT>90844,CPT<90900 S IBOUT=1 G CHKCODQ
 I CPT>99200,CPT<99216 S IBOUT=1 G CHKCODQ
 I CPT>99240,CPT<99246 S IBOUT=1 G CHKCODQ
 I CPT>99270,CPT<99289 S IBOUT=1 G CHKCODQ
 I CPT>99384,CPT<99388 S IBOUT=1 G CHKCODQ
 I CPT>99394,CPT<99430 S IBOUT=1 G CHKCODQ
 I CPT=99499 S IBOUT=1
 ;
CHKCODQ Q IBOUT
 ;
CHKBILL(IBIFN) ; return true if combining charges is applicable or available for bill
 ; bill must be Provider Based and have at least one combinable procedure
 N IBOUT,IBX,IBY S IBOUT=0 S IBIFN=+$G(IBIFN) I 'IBIFN G CHKBILQ
 ;
 S IBX=$P($G(^DGCR(399,+IBIFN,0)),U,22) S IBY=$P($$RCDV^IBCRU8(IBX),U,3) I IBY'=1,IBY'=2 S IBOUT=0 G CHKBILQ
 ;
 S IBX="90800;" F  S IBX=$O(^DGCR(399,IBIFN,"CP","B",IBX)) Q:('IBX)!(+IBX>99499)  I +$$CHKCODE(+IBX) S IBOUT=1 Q
 ;
CHKBILQ Q IBOUT
 ;
 ;
BILLCHG(IBIFN) ; get all possible charges for bill with discounts applied
 ; output array of charges for combinable procedures
 ; Output: ^TMP($J,"IBCU65 CMB", "units ^ cpt ^ div ^ itm type ^ itm ptr") = inst chg ^ prof chg ^ total chg
 ;
 N IBX,IB0,IBU,IBBRT,IBBTYPE,IBCBARR,IBLN,IBCPT,IBCMP,IBSBCR,IBCHGI,IBCHGP
 K ^TMP($J,"IBCRCC"),^TMP($J,"IBCRCSX"),^TMP($J,"IBCRCSXR"),^TMP($J,"IBCRCSXN")
 K ^TMP($J,"IBCU65 TMP"),^TMP($J,"IBCU65 CMB") Q:'$G(IBIFN)
 I '$O(^DGCR(399,+IBIFN,"RC",0)) Q
 ;
 S IB0=$G(^DGCR(399,+IBIFN,0)) Q:IB0=""  S IBU=$G(^DGCR(399,+IBIFN,"U")) Q:'IBU
 S IBBRT=+$P(IB0,U,7),IBBTYPE=$S($P(IB0,U,5)<3:1,1:3)
 ;
 ; get standard set of charge sets available for bill, including all Instutional and Professional charge sets
 D RT^IBCRU3(IBBRT,IBBTYPE,$P(IBU,U,1,2),.IBCBARR,"PROCEDURE") I 'IBCBARR  Q
 ;
 ; get all possible charges and sort as they would be added to the bill, including all discounts applied
 D BILL^IBCRBH1(IBIFN,1,.IBCBARR),SORTCI^IBCRBH1(IBIFN)
 ;
 ;
 ; compile like charges for procedures that are combinable
 S IBX=0 F  S IBX=$O(^TMP($J,"IBCRCSX",IBX)) Q:'IBX  D
 . S IBLN=$G(^TMP($J,"IBCRCSX",IBX))
 . ;
 . S IBCPT=$P(IBLN,U,5) Q:'IBCPT  I '$$CHKCODE(IBCPT) Q  ; CPT must be defined and combinable
 . S IBCMP=+$P(IBLN,U,9) Q:'IBCMP  ; must be a component charge
 . I '$P(IBLN,U,8) Q  ; item pointer must be defined
 . I $P(IBLN,U,7)'=4 Q  ; item type must be cpt
 . ;
 . S IBSBCR=$P(IBLN,U,4,8)
 . S ^TMP($J,"IBCU65 TMP",IBSBCR)=+$G(^TMP($J,"IBCU65 TMP",IBSBCR))+1
 . S ^TMP($J,"IBCU65 TMP",IBSBCR,IBCMP)=IBLN
 ;
 ;
 ; compile array of combinable charges by procedure, must be combinable cpt and have both charges available
 S IBSBCR="" F  S IBSBCR=$O(^TMP($J,"IBCU65 TMP",IBSBCR)) Q:IBSBCR=""  D
 . I +$G(^TMP($J,"IBCU65 TMP",IBSBCR))'=2 Q
 . ;
 . S IBCHGI=$P($G(^TMP($J,"IBCU65 TMP",IBSBCR,1)),U,3) Q:'IBCHGI
 . S IBCHGP=$P($G(^TMP($J,"IBCU65 TMP",IBSBCR,2)),U,3) Q:'IBCHGP
 . ;
 . S ^TMP($J,"IBCU65 CMB",IBSBCR)=IBCHGI_U_IBCHGP_U_(IBCHGI+IBCHGP)
 ;
 ;
 K ^TMP($J,"IBCRCC"),^TMP($J,"IBCRCSX"),^TMP($J,"IBCRCSXR"),^TMP($J,"IBCRCSXN"),^TMP($J,"IBCU65 TMP")
 Q

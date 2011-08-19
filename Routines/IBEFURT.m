IBEFURT ;ALB/ARH - UTILITY: FIND RELATED THIRD PARTY BILLS ; 3/7/00
 ;;2.0;INTEGRATED BILLING;**130**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; the following procedures search for Third Party bills with specific data defined, matchs are returned in ^TMP
 ;
 ; ^TMP("IBRBT", $J, XRF, matching bill ifn) = 
 ;                                        BILL FROM ^ BILL TO ^ CANCELLED (0/1) ^ AR BILL NUMBER ^ 
 ;                                        PAYER SEQUENCE ^ PAYER IS MEDICARE SUPPLEMENTAL (0/1) ^ PAYER NAME
 ;
TPEVDT(DFN,EVDT,XRF) ; find all bills for a patient with a specific Event Date (399,.03)
 N IBIFN,IBDT
 I +$G(DFN),+$G(EVDT) S IBDT=(EVDT\1)-.001 F  S IBDT=$O(^DGCR(399,"D",IBDT)) Q:'IBDT!((IBDT\1)>(EVDT\1))  D
 . S IBIFN=0 F  S IBIFN=$O(^DGCR(399,"D",IBDT,IBIFN)) Q:'IBIFN  D
 .. ;
 .. I DFN=$P($G(^DGCR(399,IBIFN,0)),U,2) D SAVELN2(IBIFN,$G(XRF))
 Q
 ;
TPPTF(PTF,XRF) ; find all bills for a specific PTF number (399,.08)
 N IBIFN
 I +$G(PTF) S IBIFN=0 F  S IBIFN=$O(^DGCR(399,"APTF",PTF,IBIFN)) Q:'IBIFN  D SAVELN2(IBIFN,$G(XRF))
 Q
 ;
TPOPV(DFN,DT1,DT2,XRF) ; find all bills for a patient with any Opt Visit Dates within a range (399,43)
 N IBIFN,IBOPV I '$G(DT2) S DT2=+$G(DT1)
 I +$G(DFN),+$G(DT1) S IBOPV=DT1-1 F  S IBOPV=$O(^DGCR(399,"AOPV",DFN,IBOPV)) Q:'IBOPV!(IBOPV>DT2)  D
 . ;
 . S IBIFN=0 F  S IBIFN=$O(^DGCR(399,"AOPV",DFN,IBOPV,IBIFN)) Q:'IBIFN  D SAVELN2(IBIFN,$G(XRF))
 Q
 ;
TPRX(DFN,RXN,RXDT,XRF) ; find all bills for a patient with a specific Rx fill (Rx number and fill date) (362.4,.01,.03)
 N IBX,IBX0,IBIFN,IBRXDT S RXDT=$G(RXDT) ; if either fill date not set then take all fills for rx
 I +$G(DFN),$G(RXN)'="" S IBX="" F  S IBX=$O(^IBA(362.4,"B",RXN,IBX)) Q:'IBX  D
 . S IBX0=$G(^IBA(362.4,IBX,0)),IBIFN=$P(IBX0,U,2),IBRXDT=$P(IBX0,U,3)
 . ;
 . I +RXDT,+IBRXDT,RXDT'=IBRXDT Q
 . I DFN=$P($G(^DGCR(399,+IBIFN,0)),U,2) D SAVELN2(IBIFN,$G(XRF))
 Q
 ;
 ; ==============================================================================================================
 ;
SAVELN1(XRF,DATA) ; set bill into array: ^TMP("IBRBT",$J,XRF) = DATA (from $$LN1)
 S XRF=$S($G(XRF)="":"TP",1:XRF) S ^TMP("IBRBT",$J,XRF)=$G(DATA)
 Q
 ;
SAVELN2(IBIFN,XRF) ; set bills found into array: ^TMP("IBRBT",$J,XRF,IBIFN)= BILL FROM ^ BILL TO ^ CANCELLED (0/1) ^ AR BILL NUMBER ^ PAYER SEQUENCE ^ PAYER IS MEDICARE SUPPLEMENTAL (0/1) ^ PAYER NAME
 I +$G(IBIFN),$D(^DGCR(399,IBIFN,0)) S XRF=$S($G(XRF)="":"TP",1:XRF),^TMP("IBRBT",$J,XRF,IBIFN)=$$LN2(IBIFN)
 Q
 ;
LN1(IBIFN) ; based on the bill passed in returns:  PATIENT HAS ANY RX COVERAGE ON FROM DATE OF BILL (0/1)
 N IBX,IBY,IB0,DFN S IBX="",IB0=$G(^DGCR(399,+$G(IBIFN),0)) I IB0="" G LN1Q
 S DFN=$P(IB0,U,2),IBY=+$G(^DGCR(399,+IBIFN,"U")) S IBX=$$PTCOV^IBCNSU3(+DFN,+IBY,"PHARMACY")
LN1Q Q IBX
 ;
LN2(IBIFN) ; based on the bill passed in returns: 
 ; BILL FROM ^ BILL TO ^ CANCELLED (0/1) ^ AR BILL NUMBER ^ PAYER SEQUENCE ^ PAYER IS MEDICARE SUPPLEMENTAL (0/1) ^ PAYER NAME
 N IBX,IBY,IB0,IBU,IBMP S IBX="",IB0=$G(^DGCR(399,+$G(IBIFN),0)) I IB0="" G LN2Q
 S IBU=$G(^DGCR(399,+IBIFN,"U")),IBMP=$G(^DGCR(399,+IBIFN,"MP"))
 S $P(IBX,U,1)=$P(IBU,U,1)
 S $P(IBX,U,2)=$P(IBU,U,2)
 S $P(IBX,U,3)=$S($P(IB0,U,13)=7:1,1:"")
 S $P(IBX,U,4)=$$BN1^PRCAFN(IBIFN)
 S $P(IBX,U,5)=$P(IB0,U,21)
 S $P(IBX,U,6)=$$TPLAN(IBIFN)
 S $P(IBX,U,7)=$P($G(^DIC(36,+IBMP,0)),U,1)
LN2Q Q IBX
 ;
 ; ==============================================================================================================
 ;
 ; the following procedures return Third Party bill specific data and status
 ;
TPLAN(IBIFN) ; check if bills payer policy is a Med Supp or whatever type requires Third Party reimbursment to be applied to First Party charges on a 1-1 basis
 ; returns true if Bill Payer Policy's Type of Plan is Med Supp (399,136 > 2.312,18 > 355.3,.09 > 355.1,.03)
 N IBX,IBY,DFN,PLAN S IBX="" I '$G(IBIFN) G TPLANQ
 S DFN=+$P($G(^DGCR(399,+IBIFN,0)),U,2),PLAN=+$P($G(^DGCR(399,+IBIFN,"MP")),U,2) I 'PLAN G TPLANQ
 S IBY=+$P($G(^DPT(DFN,.312,PLAN,0)),U,18) I 'IBY G TPLANQ
 S IBY=+$P($G(^IBA(355.3,IBY,0)),U,9),IBY=$G(^IBE(355.1,+IBY,0)) I $P(IBY,U,3)=11 S IBX=1
TPLANQ Q IBX
 ;
RXTP(DFN,RXN,RXDT,SAVE) ; check if a particular Prescription fill has been billed on a Third Party bill, Rx # and fill date
 ; if SAVE is passed in then the list of bills for the Rx is returned in ^TMP("IBRBT",$J,SAVE,IBIFN)=data
 N IBX,XRF,XRF1 S IBX="",XRF="IBRBT",XRF1=$G(SAVE) I XRF1="" S XRF1="TEMP"_$J
 I +$G(DFN),$G(RXN)'="",+$G(RXDT) K ^TMP(XRF,$J,XRF1) D TPRX(DFN,RXN,RXDT,XRF1) I $D(^TMP(XRF,$J,XRF1)) S IBX=1
 I $G(SAVE)="" K ^TMP(XRF,$J,XRF1)
 Q IBX

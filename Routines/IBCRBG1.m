IBCRBG1 ;ALB/ARH - RATES: BILL SOURCE EVENTS (OPT,CPT) ; 5/21/96
 ;;2.0;INTEGRATED BILLING;**52,106,148,245**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
OPTVD(IBIFN,ARR) ; outpatient visit dates on a bill
 ; returns       ARR = cnt of visit dates found
 ;               ARR(DA of visit) = date
 ;
 N IBI,IBX K ARR S ARR=0,IBIFN=+$G(IBIFN)
 S IBI=0 F  S IBI=$O(^DGCR(399,IBIFN,"OP",IBI))  Q:'IBI  D
 . S IBX=+$G(^DGCR(399,IBIFN,"OP",IBI,0))
 . I +IBX S ARR=ARR+1,ARR(+IBI)=IBX
 Q
 ;
CPT(IBIFN,ARR) ; find all CPT codes for a bill (excludes ICD9)
 ; returns ARR = cnt of CPT's found
 ; ARR(CPT,DA of CPT) = date ^ modifiers ^ division ^ provider ^ clinic ^ ptr to 409.68 ^ minutes ^ miles ^ hours
 ;
 N IBI,IBX K ARR S ARR=0,IBIFN=+$G(IBIFN)
 S IBI=0 F  S IBI=$O(^DGCR(399,IBIFN,"CP",IBI)) Q:'IBI  D
 . S IBX=$G(^DGCR(399,IBIFN,"CP",IBI,0))
 . I +IBX,IBX[";ICPT(" S ARR=ARR+1,ARR(+IBX,IBI)=$P(IBX,U,2)_U_$$GETMOD^IBEFUNC(IBIFN,IBI)_U_$P(IBX,U,6)_U_$P(IBX,U,18)_U_$P(IBX,U,7)_U_$P(IBX,U,20)_U_$P(IBX,U,16)_U_$P(IBX,U,21)_U_$P(IBX,U,22)
 Q

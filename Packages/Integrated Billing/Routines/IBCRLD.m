IBCRLD ;ALB/ARH - RATES: DISPLAY INTRO ; 16-MAY-1996
 ;;2.0;INTEGRATED BILLING;**52,106**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; -- main entry point for IBCR INTRODUCTION
 D EN^VALM("IBCR INTRODUCTION")
 K VALMBCK
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="Only authorized persons may edit this data: IB SUPERVISOR key required to edit."
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("IBCRLD",$J)
 D BLD
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBCRLD",$J),IBFASTXT
 D CLEAR^VALM1,CLEAN^VALM10
 Q
 ;
BLD ; build array for display of introduction screen
 N IBI,IBJ,IBLN,IBLN1,IBT,IBIARR K IBIARR
 ;
 S VALMCNT=0
 D TXT
 ;
 ; create LM display array
 S IBI=0 F  S IBI=$O(IBIARR(IBI)) Q:'IBI  D
 . S IBLN=IBIARR(IBI),IBLN1=""
 . S IBT=IBLN
 . S IBJ=0 F  S IBJ=$O(IBIARR(IBI,IBJ)) Q:'IBJ  D
 .. S IBLN1=IBIARR(IBI,IBJ)
 .. D SET(IBT,IBLN1) S IBT="",IBLN1=""
 . I IBT'="" D SET(IBT,IBLN1)
 ;
 Q
 ;
SET(IBT,IBL) ;
 N IBX
 S VALMCNT=VALMCNT+1
 S IBX=$E(IBT,U,20)
 S IBX=IBX_$J("",(25-$L(IBX)))_IBL
 S ^TMP("IBCRLD",$J,VALMCNT,0)=IBX
 I IBT'="" D CNTRL^VALM10(VALMCNT,1,20,IOINHI,IOINORM)
 Q
 ;
TXT ; set up array with text
 ;
 N IBC,IBC1
 S (IBC,IBC1)=0
 S IBC=IBC+1,IBC1=0,IBIARR(IBC)="Rate Type:"
 S IBC1=IBC1+1,IBIARR(IBC,IBC1)="Type of Payer."
 ;
 S IBC=IBC+1,IBC1=0,IBIARR(IBC)="Billing Rate:"
 S IBC1=IBC1+1,IBIARR(IBC,IBC1)="Type of Charge."
 ;
 S IBC=IBC+1,IBC1=0,IBIARR(IBC)="Charge Set:"
 S IBC1=IBC1+1,IBIARR(IBC,IBC1)="Charges for a specific Billing Rate, broken down by"
 S IBC1=IBC1+1,IBIARR(IBC,IBC1)="type of event to be billed/charged."
 S IBC1=IBC1+1,IBIARR(IBC,IBC1)="   Charge Item:       The individual items for a Set"
 S IBC1=IBC1+1,IBIARR(IBC,IBC1)="                      and their charge amounts."
 S IBC1=IBC1+1,IBIARR(IBC,IBC1)="   Billing Region:    The region or divisions the"
 S IBC1=IBC1+1,IBIARR(IBC,IBC1)="                      charges apply to."
 ;
 S IBC=IBC+1,IBC1=0,IBIARR(IBC)="Rate Schedule:"
 S IBC1=IBC1+1,IBIARR(IBC,IBC1)="Definition of charges billable to specific payers."
 S IBC1=IBC1+1,IBIARR(IBC,IBC1)="Link between Charge Sets and Rate Types."
 S IBC1=IBC1+1,IBIARR(IBC,IBC1)="Once the Rate Type is set for a bill, the"
 S IBC1=IBC1+1,IBIARR(IBC,IBC1)="Rate Schedule will be used to find all charges to"
 S IBC1=IBC1+1,IBIARR(IBC,IBC1)="add to the bill."
 ;
 S IBC=IBC+1,IBC1=0,IBIARR(IBC)="Special Groups:"
 S IBC1=IBC1+1,IBIARR(IBC,IBC1)="Special requirements that are applied when charges are"
 S IBC1=IBC1+1,IBIARR(IBC,IBC1)="calculated for a bill: "
 S IBC1=IBC1+1,IBIARR(IBC,IBC1)="   Revenue Code links to care provided"
 S IBC1=IBC1+1,IBIARR(IBC,IBC1)="   Provider discounts"
 Q

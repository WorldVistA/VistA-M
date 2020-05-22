IBJPM ;ALB/MAF,ARH - IBSP MCCR PARAMETERS SCREEN ;14-DEC-1995
 ;;2.0;INTEGRATED BILLING;**39,137,184,271,316,416,438,517,659**;21-MAR-94;Build 16
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; -- main entry point for JOINT INQUIRY PARAMETERS option
 D EN^VALM("IBJP MCCR PARAMETERS")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="Display/Edit MCCR Site Parameters."
 S VALMHDR(2)="Only authorized persons may edit this data."
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("IBJPM",$J)
 D BLD
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBJPM",$J),IBFASTXT,VALMBCK
 D CLEAR^VALM1
 Q
 ;
BLD ; -- build screen array, no variables required for input
 N IBNC,IBTC,IBTW,IBSW,IBLN,IBGRPB,IBGRPE,IBLR
 S IBNC(1)=1,IBTW(1)=0,IBTC(1)=5,IBSW(1)=30,IBNC(2)=43,IBTW(2)=0,IBTC(2)=47,IBSW(2)=30
 ;
 S (VALMCNT,IBLN)=1,IBLR=1,IBLN=$$SET("","",IBLN,IBLR),IBGRPB=IBLN
 ;
 ; - IB Site Parameters
 S IBLN=$$SETN("IB Site Parameters",IBLN,IBLR,1)
 S IBLN=$$SET("","Facility Definition",IBLN,IBLR)
 S IBLN=$$SET("","Mail Groups",IBLN,IBLR)
 S IBLN=$$SET("","Patient Billing",IBLN,IBLR)
 S IBLN=$$SET("","Third Party Billing",IBLN,IBLR)
 S IBLN=$$SET("","Provider Id",IBLN,IBLR)
 S IBLN=$$SET("","EDI Transmission",IBLN,IBLR)
 ;
 S IBLR=2,IBGRPE=IBLN,IBLN=IBGRPB
 ;
 ; - Claim Tracking Parameters
 S IBLN=$$SETN("Claims Tracking Parameters",IBLN,IBLR,1)
 S IBLN=$$SET("","General Parameters",IBLN,IBLR)
 S IBLN=$$SET("","Tracking Parameters",IBLN,IBLR)
 S IBLN=$$SET("","Random Sampling",IBLN,IBLR)
 S IBLN=$$SET("","HCSR Parameters",IBLN,IBLR)
 ;
 S IBLN=$S(IBLN>IBGRPE:IBLN,1:IBGRPE),IBLR=1,IBLN=$$SET("","",IBLN,IBLR),IBGRPB=IBLN
 ;
 ; - Automated Billing Parameters
 S IBLN=$$SETN("Third Party Auto Billing Parameters",IBLN,IBLR,1)
 S IBLN=$$SET("","General Parameters",IBLN,IBLR)
 S IBLN=$$SET("","Inpatient Admission",IBLN,IBLR)
 S IBLN=$$SET("","Outpatient Visit",IBLN,IBLR)
 S IBLN=$$SET("","Prescription Refill",IBLN,IBLR)
 ;
 ; DAOU/BHS - Added 13-JUN-2002
 S IBLR=2,IBLN=IBGRPB
 ;
 ; DAOU/BHS - Added 13-JUN-2002
 ; - eIV Parameters
 S IBLN=$$SETN("Insurance Verification",IBLN,IBLR,1)
 S IBLN=$$SET("","General Parameters",IBLN,IBLR)
 S IBLN=$$SET("","Batch Extracts Parameters",IBLN,IBLR)
 ;/vd-IB*2*659 - Removed the following heading for maintenance purposes per
 ;               a request by the ebiz group.
 ;S IBLN=$$SET("","Service Type Codes",IBLN,IBLR)
 ;
 S (IBLN,VALMCNT)=$S(IBLN>IBGRPE:IBLN,1:IBGRPE)-1
 Q
 ;
SET(TTL,DATA,LN,LR) ;
 N IBY
 S IBY=$J(TTL,IBTW(LR))_DATA D SET1(IBY,LN,IBTC(LR),(IBTW(LR)+IBSW(LR)))
 S LN=LN+1
 Q LN
 ;
SETN(TTL,LN,LR,RV) ;
 N IBY
 S IBY=" "_TTL_" " D SET1(IBY,LN,IBNC(LR),$L(IBY),$G(RV))
 S LN=LN+1
 Q LN
 ;
SET1(STR,LN,COL,WD,RV) ; set up TMP array with screen data
 N IBX S IBX=$G(^TMP("IBJPM",$J,LN,0))
 S IBX=$$SETSTR^VALM1(STR,IBX,COL,WD)
 D SET^VALM10(LN,IBX) I $G(RV)'="" D CNTRL^VALM10(LN,COL,WD,IOINHI,IOINORM)
 Q

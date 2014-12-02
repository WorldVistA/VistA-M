IBTRR ;ALB/ARH - CLAIMS TRACKING - ROI SPECIAL CONSENT SCREEN ; 08-JAN-2013
 ;;2.0;INTEGRATED BILLING;**458**;21-MAR-94;Build 4
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ; -- main entry point for IBT ROI SPECIAL CONSENT
 D EN^VALM("IBT ROI SPECIAL CONSENT")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="ROI Special Consent Entries for: "_$P($G(^DPT(+$G(DFN),0)),"^")
 S VALMHDR(2)=" "
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("IBTRR",$J),^TMP("IBTRRX",$J),^TMP($J,"IBTRR")
 I '$G(DFN) D PAT^IBCNSM I $D(VALMQUIT) Q
 D BLD
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBTRR",$J),^TMP("IBTRRX",$J),^TMP($J,"IBTRR")
 D CLEAR^VALM1,CLEAN^VALM10
 Q
 ;
 ;
BLD ; build list of ROI Special Concents for a Patient by Active, Effective Date and Condition
 N IBCNT,IBRFN,IBR0,IBACT,IBS1,IBS2,IBS3 K ^TMP("IBTRR",$J),^TMP("IBTRRX",$J),^TMP($J,"IBTRR")
 S VALMCNT=0,IBCNT=0
 ;
 ; get patient records in reverse effective date then condition order
 S IBRFN=0 F  S IBRFN=$O(^IBT(356.26,"C",DFN,IBRFN)) Q:'IBRFN  D
 . S IBR0=$G(^IBT(356.26,IBRFN,0)) S IBACT=$$ACTIVE(IBRFN,DT) I 'IBACT S IBACT=9
 . S ^TMP($J,"IBTRR",IBACT,-$P(IBR0,U,4),+$P(IBR0,U,3),IBRFN)=""
 ;
 ; set up array for list manager display
 S IBS1="" F  S IBS1=$O(^TMP($J,"IBTRR",IBS1)) Q:IBS1=""  D
 . S IBS2="" F  S IBS2=$O(^TMP($J,"IBTRR",IBS1,IBS2)) Q:IBS2=""  D
 .. S IBS3="" F  S IBS3=$O(^TMP($J,"IBTRR",IBS1,IBS2,IBS3)) Q:IBS3=""  D
 ... S IBRFN=0 F  S IBRFN=$O(^TMP($J,"IBTRR",IBS1,IBS2,IBS3,IBRFN)) Q:'IBRFN  D
 .... D LINE(IBRFN)
 ;
 I '$D(^TMP($J,"IBTRR")) D SET(" ",0),SET("No ROI Special Consents for this Patient",0)
 Q
 ;
LINE(IBRFN) ; add one ROI entry to screen list
 N IBR0,IBX,IBY S IBX="" Q:'$G(IBRFN)
 S IBCNT=IBCNT+1 S IBR0=$G(^IBT(356.26,IBRFN,0))
 ;
 S IBY=IBCNT,IBX=$$SETFLD^VALM1(IBY,IBX,"NUMBER")
 S IBY=$$DATE($P(IBR0,U,4)),IBX=$$SETFLD^VALM1(IBY,IBX,"EFFECTIVE")
 S IBY=$$DATE($P(IBR0,U,5)),IBX=$$SETFLD^VALM1(IBY,IBX,"EXPIRE")
 S IBY=$$EXPAND^IBTRE(356.26,.03,$P(IBR0,U,3)),IBX=$$SETFLD^VALM1(IBY,IBX,"CONDITION")
 S IBY=$$STATUS(IBRFN,DT),IBX=$$SETFLD^VALM1(IBY,IBX,"STATUS")
 S IBY=$G(^IBT(356.26,IBRFN,2)),IBX=$$SETFLD^VALM1(IBY,IBX,"COMMENTS")
 D SET(IBX,IBCNT)
 Q
 ;
SET(X,CNT) ; set list manager screen array lines
 S VALMCNT=VALMCNT+1
 S ^TMP("IBTRR",$J,VALMCNT,0)=X Q:'CNT
 S ^TMP("IBTRR",$J,"IDX",VALMCNT,+CNT)=""
 S ^TMP("IBTRRX",$J,CNT)=VALMCNT_U_IBRFN
 Q
 ;
DATE(X) ; date in external format
 N Y S Y="" I $G(X)?7N.E S Y=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 Q Y
 ;
STATUS(IBRFN,DATE) ; return entries status: active or inactive/revoked on date
 N X,Y S X=""
 I +$G(IBRFN) S X="INACTIVE"
 I +$P($G(^IBT(356.26,+$G(IBRFN),0)),U,6) S X="REVOKED"
 I +$$ACTIVE(+$G(IBRFN),$G(DATE)) S X="ACTIVE"
 Q X
 ;
ACTIVE(IBRFN,DATE) ; return True if ROI entry is Active on date
 N X,IBR0 S X=0 S DATE=$G(DATE)\1 I DATE'?7N S DATE=DT
 S IBR0=$G(^IBT(356.26,+$G(IBRFN),0))
 I IBR0'="",DATE'<$P(IBR0,U,4),DATE'>$P(IBR0,U,5) S X=1
 Q X

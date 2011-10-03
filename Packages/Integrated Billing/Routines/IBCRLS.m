IBCRLS ;ALB/ARH - RATES: DISPLAY SCHEDULES ; 16-MAY-1996
 ;;Version 2.0 ; INTEGRATED BILLING ;**52**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; -- main entry point for IBCR RATE SCHEDULE
 D EN^VALM("IBCR RATE SCHEDULE")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="Link types of payers and charges"
 S VALMSG="~ charges not auto added to bills"
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("IBCRLS",$J),^TMP("IBCRLSX1",$J)
 D BLD
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBCRLS",$J),^TMP("IBCRLSX1",$J)
 D CLEAR^VALM1,CLEAN^VALM10
 Q
 ;
BLD ; build LM array for rate schedule display
 N IBRT,IBBT,IBCNT,IBCNT1,IBRTBT,IBRSFN,IBCGS,IBLN,IBLN1,IBX,IBY,IBRS10,X S (VALMCNT,IBCNT)=0 K ^TMP($J,"IBCRRS")
 ;
 D SORTRS
 ;
 ; create LM display array
 S IBRT="" F  S IBRT=$O(^TMP($J,"IBCRRS",IBRT)) Q:IBRT=""  D
 . S IBBT="" F  S IBBT=$O(^TMP($J,"IBCRRS",IBRT,IBBT)) Q:IBBT=""  D
 .. ;
 .. S IBRTBT=$G(^TMP($J,"IBCRRS",IBRT,IBBT))
 .. D SET("",IBRTBT) S IBY="    "_IBRT_": "_$$BTYPE(IBBT)
 .. D SET(IBY) D CNTRL^VALM10(VALMCNT,1,80,IOINHI,IOINORM)
 .. ;
 .. S IBRSFN=0 F  S IBRSFN=$O(^TMP($J,"IBCRRS",IBRT,IBBT,IBRSFN)) Q:'IBRSFN  D
 ... S IBLN=$G(^IBE(363,IBRSFN,0)) Q:IBLN=""
 ... S IBCNT=IBCNT+1,IBY=""
 ... S IBX=$P(IBLN,U,1),IBY=$$SETFLD^VALM1(IBX,IBY,"RSCHD")
 ... S IBX=$$EMUTL^IBCRU1(+$P(IBLN,U,4),2),IBY=$$SETFLD^VALM1(IBX,IBY,"BSVS")
 ... S IBX=$$DATE(+$P(IBLN,U,5)),IBY=$$SETFLD^VALM1(IBX,IBY,"EFFDT")
 ... S IBX=$$DATE(+$P(IBLN,U,6)),IBY=$$SETFLD^VALM1(IBX,IBY,"INADT")
 ... ;
 ... S IBRS10=$G(^IBE(363,IBRSFN,10)) I IBRS10'="" D
 .... S IBY=$$SETFLD^VALM1(" Y",IBY,"ADJ") S X=100 X IBRS10
 .... S IBX="(if base $=100, adjusted $="_$J(X,0,2)_") "_IBRS10,IBY=$$SETFLD^VALM1(IBX,IBY,"ADJMC")
 ... ;
 ... S IBCGS=0,IBCNT1=IBCNT F  S IBCGS=$O(^IBE(363,IBRSFN,11,IBCGS)) Q:'IBCGS  D
 .... S IBLN1=$G(^IBE(363,IBRSFN,11,IBCGS,0)) Q:'IBLN1
 .... S IBX=$P(IBLN1,U,2) I 'IBX S IBX="~",IBY=$$SETFLD^VALM1(IBX,IBY,"AA")
 .... S IBX=$P($G(^IBE(363.1,+IBLN1,0)),U,1),IBY=$$SETFLD^VALM1(IBX,IBY,"CGSET")
 .... D SET(IBY) S IBCNT1=0,IBY=""
 ... I +IBCNT1 D SET(IBY)
 ;
 I VALMCNT=0 D SET(" "),SET("No Rate Schedules defined")
 ;
 K ^TMP($J,"IBCRRS")
 Q
 ;
SET(X,RTBTLN) ; set up list manager screen array (if RTBTLN, the line is the first line of the rate tpe-bill type section)
 S VALMCNT=VALMCNT+1
 S ^TMP("IBCRLS",$J,VALMCNT,0)=X
 I +$G(RTBTLN) S ^TMP("IBCRLSX1",$J,+RTBTLN,+$P(RTBTLN,U,2))=VALMCNT
 Q
 ;
SORTRS ; sort rate schedules by rate type name, bill type
 ; ^TMP($J,"IBCRRS", rate type, bill type)= rate type ifn ^ bill type
 ; ^TMP($J,"IBCRRS", rate type, bill type, rate schedule IFN)=""
 N IBRSFN,IBLN,IBRT,IBBT
 S IBRSFN=0 F  S IBRSFN=$O(^IBE(363,IBRSFN)) Q:'IBRSFN  D
 . S IBLN=$G(^IBE(363,IBRSFN,0)) Q:IBLN=""
 . S IBRT=$P($G(^DGCR(399.3,+$P(IBLN,U,2),0)),U,1),IBBT=$P(IBLN,U,3)
 . S ^TMP($J,"IBCRRS",IBRT,IBBT)=+$P(IBLN,U,2)_U_+$P(IBLN,U,3)
 . S ^TMP($J,"IBCRRS",IBRT,IBBT,IBRSFN)=""
 Q
 ;
DATE(X) ; date in external format
 N Y S Y="" I $G(X)?7N.E S Y=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 Q Y
 ;
BTYPE(X) ; return abbreviated form of Bill Type
 Q $S($G(X)>2:"Outpatient",$G(X)>0:"Inpatient",1:"")

IBCRLT ;ALB/ARH - RATES: DISPLAY RATE TYPES ; 16-MAY-1996
 ;;Version 2.0 ; INTEGRATED BILLING ;**52**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; -- main entry point for IBCR RATE TYPE
 D EN^VALM("IBCR RATE TYPE")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="This is a Standard file with entries released nationally."
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("IBCRLT",$J),^TMP("IBCRLTX1",$J)
 D BLD
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBCRLT",$J),^TMP("IBCRLTX1",$J)
 D CLEAR^VALM1,CLEAN^VALM10
 Q
 ;
BLD ; build array for rate type display
 N IBRT,IBRTFN,IBCNT,IBTC,IBTW,IBSW,IBLR,IBLN,IBT,IBD,IBGRPB,IBGRPE S VALMCNT=0,IBCNT=0
 ;
 S (IBCNT,VALMCNT)=1
 S IBTC(1)=2,IBTC(2)=39,IBTW(1)=15,IBTW(2)=16,IBSW(1)=21,IBSW(2)=25
 ;
 ; create LM display array
 S IBRT="" F  S IBRT=$O(^DGCR(399.3,"B",IBRT)) Q:IBRT=""  D
 . S IBRTFN=0 F  S IBRTFN=$O(^DGCR(399.3,"B",IBRT,IBRTFN)) Q:'IBRTFN  D
 .. ;
 .. S IBLN=$G(^DGCR(399.3,IBRTFN,0)) Q:IBLN=""  D SETO(IBRTFN,IBCNT)
 .. ;
 .. S IBT="",IBD="" S IBCNT=$$SET(IBT,IBD,IBCNT,1)
 .. S IBT="Rate Type: ",IBD=$P(IBLN,U,1) S IBCNT=$$SET(IBT,IBD,IBCNT,1)
 .. D CNTRL^VALM10((IBCNT-1),(IBTC(1)+IBTW(1)),IBSW(1),IOINHI,IOINORM)
 .. S IBGRPB=IBCNT,IBLR=1
 .. ;
 .. S IBT="Bill Name: ",IBD=$P(IBLN,U,2) S IBCNT=$$SET(IBT,IBD,IBCNT,IBLR)
 .. S IBT="Abbreviation: ",IBD=$P(IBLN,U,4) S IBCNT=$$SET(IBT,IBD,IBCNT,IBLR)
 .. S IBT="Third Party?: ",IBD=$S(+$P(IBLN,U,5):"YES",1:"") S IBCNT=$$SET(IBT,IBD,IBCNT,IBLR)
 .. S IBT="Inactive: ",IBD=$S(+$P(IBLN,U,3):"YES",1:"") S IBCNT=$$SET(IBT,IBD,IBCNT,IBLR)
 .. ;
 .. S IBGRPE=IBCNT,IBCNT=IBGRPB,IBLR=2
 .. ;
 .. S IBT="AR Category: ",IBD=$$EXPAND^IBCRU1(399.3,.06,$P(IBLN,U,6)) S IBCNT=$$SET(IBT,IBD,IBCNT,IBLR)
 .. S IBT="Who's Respns: ",IBD=$$EXPAND^IBCRU1(399.3,.07,$P(IBLN,U,7)) S IBCNT=$$SET(IBT,IBD,IBCNT,IBLR)
 .. S IBT="RI Statement?: ",IBD=$S(+$P(IBLN,U,8):"YES",1:"") S IBCNT=$$SET(IBT,IBD,IBCNT,IBLR)
 .. S IBT="NSC Statement?: ",IBD=$S(+$P(IBLN,U,9):"YES",1:"") S IBCNT=$$SET(IBT,IBD,IBCNT,IBLR)
 .. S (IBCNT,VALMCNT)=$S(IBCNT>IBGRPE:IBCNT,1:IBGRPE)
 ;
 S (IBCNT,VALMCNT)=IBCNT-1
 ;
 I VALMCNT=0 S IBCNT=$$SET(" ","",1,1),IBCNT=$$SET("No Rate Types defined","",2,1)
 ;
 Q
 ;
SETO(RT,LN) ; set line number of beginning line of a rate type
 ; (so when redisplay after edit it begins redisplay on the rate that was edited)
 S ^TMP("IBCRLTX1",$J,+$G(RT))=+$G(LN)
 Q
 ;
SET(TTL,DATA,LN,LR) ;
 N IBY
 S IBY=$J(TTL,IBTW(LR))_DATA D SET1(IBY,LN,IBTC(LR),(IBTW(LR)+IBSW(LR)))
 S LN=LN+1
 Q LN
 ;
SET1(STR,LN,COL,WD,RV) ; set up TMP array with screen data
 N IBX S IBX=$G(^TMP("IBCRLT",$J,LN,0))
 S IBX=$$SETSTR^VALM1(STR,IBX,COL,WD)
 D SET^VALM10(LN,IBX) I $G(RV)'="" D CNTRL^VALM10(LN,COL,WD,IORVON,IORVOFF)
 Q

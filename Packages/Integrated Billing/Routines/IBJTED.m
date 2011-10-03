IBJTED ;ALB/CXW - TPJI EDI STATUS SCREEN ;09-APR-1999
 ;;2.0;INTEGRATED BILLING;**137**;21-MAR-1994
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; -- main entry point for IBJ TP EDI STATUS
 D EN^VALM("IBJT EDI STATUS")
 Q
 ;
HDR ; -- header code
 D HDR^IBJTU1(+IBIFN,+DFN,1)
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("IBJTED",$J)
 I '$G(DFN)!'$G(IBIFN) S VALMQUIT="" G INITQ
 D BLD
INITQ Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBJTED",$J)
 D CLEAR^VALM1,CLEAN^VALM10
 Q
 ;
BLD ;display EDI status information
 N IBY,IBZ,CNT,COL,WD,IBD,IBX,IBDT,IBCNT,IBCH,IBT,IBCH6,IBMS,IBRD,IBSO,IBY,X,IBGS,IBNDT,IBCN2
 S (IBCNT,VALMCNT)=0
 ; only display the latest transmit record and status message
 S IBY=$O(^IBM(361,"B",IBIFN,""))
 S IBZ=$$LAST364^IBCEF4(IBIFN)
 I 'IBY,'IBZ D BLDQ Q
 D E364(IBZ),E361(IBY)
 Q
 ;
E361(IBY) ; Bill Status Message
 ; IBY = ien of entry in file 361
 N IBZ,IBX,IBDT,IBT
 K ^TMP($J,"RET-MSG")
 S IBCH=0
 S IBT="EDI Bill Status Messages"
 D SET($J("",(80-$L(IBT))\2)_IBT)
 D CNTRL^VALM10(VALMCNT,((80-$L(IBT))\2)+1,$L(IBT),IORVON,IORVOFF)
 I IBY S IBCH=1 D  ; Find all messages rec'd for the bill
 . N IBCH
 . S IBDT="",IBCNT=0
 . F  S IBDT=+$O(^IBM(361,"ADR",IBIFN,IBDT),-1) Q:'IBDT  S IBY=0 F  S IBY=+$O(^IBM(361,"ADR",IBIFN,IBDT,IBY)) Q:'IBY  S IBX=$G(^IBM(361,IBY,0)) I IBX'="" D
 .. N IBT1
 .. S IBCNT=IBCNT+1
 .. I IBCNT>1 D SET(" ")
 .. S IBT1="---Message "_IBCNT_"---"
 .. S IBT=$J("",32-($L(IBCNT)+1\2))_IBT1
 .. S IBD=$$SET1(IBT,"",1,80) D SET(IBD)
 .. D CNTRL^VALM10(VALMCNT,(33-(($L(IBCNT)+1)\2)),$L(IBT1),IOINHI,IOINORM)
 .. S IBT=$J("",8)_"Date Received: "_$$FMTE^XLFDT(IBDT)
 .. S IBD=$$SET1(IBT,"",1,49)
 .. S IBT="Batch #: "_$$EXPAND^IBTRE(361,.05,+$P($G(^IBA(364,+$P(IBX,U,11),0)),U,2)),IBD=$$SET1(IBT,IBD,50,27)
 .. D SET(IBD)
 .. ;S IBT="Msg Generation Source: "_$$EXPAND^IBTRE(361,.04,$P(IBX,U,4))
 .. ;S IBD=$$SET1(IBT,"",1,40)
 .. S IBT="Return Msg Id: "_$P(IBX,U,6)
 .. S IBD=$$SET1(IBT,"",9,40)
 .. S IBT="Msg Severity: "_$$EXPAND^IBTRE(361,.03,$P(IBX,U,3))
 .. S IBD=$$SET1(IBT,IBD,45,35) D SET(IBD)
 .. ;S IBT="Return Msg Id: "_$P(IBX,U,6)
 .. ;S IBD=$$SET1(IBT,"",9,40) D SET(IBD)
 .. S (IBCH,IBCN)=0
 .. F  S IBCN=$O(^IBM(361,IBY,1,IBCN)) Q:'IBCN  S IBD=$$SET1(^(IBCN,0),"",1,79),IBCH=1 D SET(IBD)
 .. I 'IBCH S IBD=$$SET1("  No message text found","",1,25) D SET(IBD)
 .. S IBT=$J("",31-($L(IBCNT)+1\2))_"---Msg "_IBCNT_" Review---"
 .. S IBD=$$SET1(IBT,"",1,80) D SET(IBD)
 .. S IBCN=0 F  S IBCN=$O(^IBM(361,IBY,2,IBCN)) Q:'IBCN  S IBGS=$G(^(IBCN,0)) D
 ... S IBT="Review Date: "_$$DAT1^IBOUTL($P(IBGS,U),1)
 ... S IBD=$$SET1(IBT,"",1,40)
 ... ;S IBT="Reviewed By: "_$P($G(^VA(200,+$P(IBGS,U,2),0)),U)
 ... ;S IBD=$$SET1(IBT,IBD,49,29)
 ... D SET(IBD)
 ... S IBCH=0
 ... S IBCN2=0 F  S IBCN2=$O(^IBM(361,IBY,2,IBCN,1,IBCN2)) Q:'IBCN2  S IBD=$$SET1($S('IBCH:"Comments: ",1:"")_$G(^(IBCN2,0)),"",1,$S('IBCH:69,1:79)),IBCH=1 D SET(IBD)
 D NONE(IBCH)
 K ^TMP($J,"RET-MSG")
 Q
 ;
E364(IBZ) ; EDI Transmit Bill
 ; IBZ = ien of entry in file 364
 N IBY,IBT,IBX
 S IBX=""
 I IBZ S IBX=$G(^IBA(364,IBZ,0))
 S IBT="Last EDI Transmission"
 D SET($J("",(80-$L(IBT))\2)_IBT)
 D CNTRL^VALM10(VALMCNT,(80-$L(IBT)\2)+1,$L(IBT),IORVON,IORVOFF)
 S IBT="Transmission Status: "_$$EXPAND^IBTRE(364,.03,$P(IBX,U,3))
 S IBD=$$SET1(IBT,"",3,79)
 D SET(IBD)
 S IBT="Status Date: "_$$FMTE^XLFDT($P(IBX,U,4))
 S IBD=$$SET1(IBT,"",11,38)
 S IBT="Batch #: "_$$EXPAND^IBTRE(364,.02,+$P(IBX,U,2))
 S IBD=$$SET1(IBT,IBD,50,29)
 D SET(IBD)
 I $P(IBX,U,6) D
 . S IBT="Resubmit Batch #: "_$$EXPAND^IBTRE(364,.06,+$P(IBX,U,6))
 . S IBD=$$SET1(IBT,"",6,30)
 . D SET(IBD)
 D SET("")
 Q
 ;
BLDQ ;
 D SET(" ",0),SET("No EDI Status Messages Found For This Bill Entry.",0)
 Q
 ;
NONE(IBCH) ;
 I 'IBCH D
 . S IBD=$$SET1("  None","",1,10)
 . D SET(IBD)
 Q
 ;
SET(X,CNT) ;
 S VALMCNT=VALMCNT+1
 S ^TMP("IBJTED",$J,VALMCNT,0)=X
 Q:'$G(CNT)
 S ^TMP("IBJTED",$J,"IDX",VALMCNT,CNT)=""
 Q
 ;
SET1(IBT,IBD,COL,WD) ;
 S IBD=$$SETSTR^VALM1(IBT,IBD,COL,WD)
 Q IBD
 ;

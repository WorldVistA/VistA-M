IBCEF6 ;ALB/TMP - EDI TRANSMISSION RULES DISPLAY ;28-APR-99
 ;;2.0;INTEGRATED BILLING;**137**;21-MAR-94
 ;
EN ; -- main entry point for IBCE RULES
 N IBACTIVE
 S DIR("A")="Press RETURN to continue: ",DIR("A",1)="",$P(DIR("A",1),"*",54)="",DIR("A",1)=$J("",10)_DIR("A",1)
 S DIR("A",2)=$J("",10)_"*  WARNING -  MAKING CHANGES TO THE TRANSMISSION    *",DIR("A",3)=$J("",10)_"*  RULES USING THIS OPTION CAN SERIOUSLY AFFECT THE *"
 S DIR("A",4)=$J("",10)_"*  SITE'S ABILITY TO BILL.  BE EXTREMELY CAUTIOUS   *"
 S DIR("A",5)=$J("",10)_"*  WHEN USING THIS OPTION.                          *"
 S DIR("A",6)=DIR("A",1),DIR("A",7)=" "
 S DIR(0)="EA"
 D ^DIR K DIR
 I 'Y G ENQ
 D EN^VALM("IBCE RULES")
ENQ Q
 ;
HDR ; -- header code
 S VALMHDR(1)=" "
 S VALMHDR(2)="     FORM    TRANSMIT   INSURANCE  RULE"
 S VALMHDR(3)=" #   TYPE      TYPE       OPTION   NUM    SHORT DESCRIPTION"_$J("",30)_"ACTIVE DATE    INACTIVE DATE"
 Q
 ;
INIT ; -- init variables and list array
 N IBI,IBR,IBRT
 S VALMCNT=0,VALMBG=1
 ; -- build list of rules
 D REBLD(0)
 Q
 ;
REBLD(IBACTIVE) ; Set up formatted global
 ;
 N IBI,IBR,IBS,IBRT,IBCNT,X,IB0,IBIN,IBNEXT,TEXT,Z
 D CLEAN^VALM10
 K ^TMP("IBCE-RULE",$J),^TMP("IBCE-RULEDX",$J)
 S (IBI,IBR)=0
 F  S IBI=$O(^IBE(364.4,IBI)) Q:'IBI  S IB0=$G(^(IBI,0)) D
 . S IBRT=+$P(IB0,U,11)
 . ;Extract rules by rule type and keep inactive rules at end
 . S IBIN=$S($P(IB0,U,2)&($P(IB0,U,2)>DT):800,$P(IB0,U,6)&($P(IB0,U,6)'>DT):900,1:0) ; Is rule inactive?
 . Q:IBIN&$G(IBACTIVE)  ; Only active rules displayed
 . S IBNEXT=$O(IBR(IBRT,800),-1)+1
 . I IBIN D
 .. S IBNEXT=$O(IBR(IBRT,IBIN+99),-1)+1
 .. I IBNEXT<IBIN S IBNEXT=IBIN
 . S IBR(IBRT,IBNEXT)=IBI
 ;
 S (VALMCNT,IBCNT)=0,IBRT=""
 F  S IBRT=$O(IBR(IBRT)) Q:IBRT=""  D
 . ; -- add rule type to list
 . ; Add 1 blank line between types
 . I $O(IBR(""))'=IBRT D SET(" ",.VALMCNT,IBCNT)
 . S X="- "_$$EXPAND^IBTRE(364.4,.11,IBRT)_" -"
 . S IBS=(80-$L(X))\2
 . S X=$J("",IBS)_X
 . D SET(X,.VALMCNT,$S(IBCNT:IBCNT,1:1))
 . D CNTRL^VALM10(VALMCNT,IBS+1,$L(X)-IBS,IORVON,IORVOFF)
 . D SET(" ",.VALMCNT,$S(IBCNT:IBCNT,1:1))
 . S IBS=0 F  S IBS=$O(IBR(IBRT,IBS)) Q:'IBS  S IBRULE=+$G(IBR(IBRT,IBS)) I IBRULE D
 .. S IB0=$G(^IBE(364.4,IBRULE,0))
 .. S X=""
 .. S IBCNT=IBCNT+1
 .. S X=$J(IBCNT,3)_"  "_$S($P(IB0,U,5)=1:"INST",$P(IB0,U,5)=2:"PROF",1:"BOTH")_"  "_$E($S($P(IB0,U,3)=1:"EDI ONLY",$P(IB0,U,3)=2:"MRA ONLY",1:"BOTH EDI/MRA")_$J("",14),1,14)
 .. S X=X_$E($S($P(IB0,U,7)=1:"INCLUDES",$P(IB0,U,7)=2:"EXCLUDES",1:"ALL")_$J("",11),1,11)_$E($P(IB0,U)_$S(IBS'<800:"*",1:"")_$J("",6),1,6)
 .. S X=X_$E($P(IB0,U,8)_$J("",47),1,47)_$E($$EXPAND^IBTRE(364.4,.02,$P(IB0,U,2))_$J("",15),1,15)_$$EXPAND^IBTRE(364.4,.06,$P(IB0,U,6))
 .. D SET(X,.VALMCNT,IBCNT,IBRULE)
 . S VALMSG=$S('$G(IBACTIVE):"Rule #'s followed by an * are currently inactive",1:"Only currently active rules are displayed")
 ;
 I '$D(^TMP("IBCE-RULE",$J)) S VALMCNT=2,IBCNT=2,^TMP("IBCE-RULE",$J,1,0)=" ",^TMP("IBCE-RULE",$J,2,0)="    No "_$S('$G(IBACTIVE):"",1:"Active")_" Transmission Rules Found",^TMP("IBCE-RULE",$J,"IDX",1,1)="",^TMP("IBCE-RULE",$J,"IDX",2,2)=""
 Q
 ;
SET(X,VALMCNT,IBCNT,IBRULE) ;
 ; X = Text to set into display global
 ; VALMCNT = returned if passed by ref = the last line set in display
 ; IBCNT = entry number to use if the line is selectable; non-select = 0
 ; IBRULE = ien of rule being displayed
 ;
 S VALMCNT=VALMCNT+1,^TMP("IBCE-RULE",$J,VALMCNT,0)=X
 D SET^VALM10(VALMCNT,X,IBCNT)
 I $G(IBRULE) D
 . S ^TMP("IBCE-RULEDX",$J,IBCNT)=VALMCNT_U_IBRULE
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBCE-RULE",$J),^TMP("IBCE-RULEDX",$J),IBRULE
 D FULL^VALM1
 Q
 ;
EXPND ; -- expand code
 Q
 ;

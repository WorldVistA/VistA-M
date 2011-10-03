IBCEF62 ;ALB/TMP - EDI TRANSMISSION RULES BT RESTRICTIONS DISPLAY ;30-APR-99
 ;;2.0;INTEGRATED BILLING;**137**;21-MAR-94
 ;
EN ; -- main entry point for IBCE RULE BT RESTRICT
 D EN^VALM("IBCE RULE BT RESTRICT")
 Q
 ;
HDR ; -- header code
 N IB0
 Q:'$G(IBRULE)
 S IB0=$G(^IBE(364.4,IBRULE,0))
 S VALMHDR(1)=IORVON_"BILL TYPE RESTRICTIONS FOR RULE #"_$P(IB0,U)_IORVOFF
 S VALMHDR(2)=$J("",4)_"Transmit type: "_$S($P(IB0,U,3)=1:"EDI ",$P(IB0,U,3)=2:"MRA ",1:"BOTH")_$J("",8)_"  Form Type    : "_$S($P(IB0,U,5)=1:"INST",$P(IB0,U,5)=2:"PROF",1:"BOTH")
 S VALMHDR(2)=VALMHDR(2)_"  Ins Co Option: "_$S($P(IB0,U,7)=1:"INCLUDE",$P(IB0,U,7)=2:"EXCLUDE",1:"ALL    ")
 S VALMHDR(3)=$J("",4)_"Active Date  : "_$E($$EXPAND^IBTRE(364.4,.02,$P(IB0,U,2))_$J("",12),1,12)_"  Inactive Date: "_$E($$EXPAND^IBTRE(364.4,.06,$P(IB0,U,6))_$J("",12),1,12)
 S VALMHDR(4)=$J("",4)_$P(IB0,U,8)
 Q
 ;
INIT ; -- init variables and list array
 N IBI,IBR,IBRT
 S VALMCNT=0,VALMBG=1
 ; -- build list of rule's bill type restrictions
 D REBLD
 Q
 ;
REBLD ; Set up formatted global
 ;
 N IBI,IBBT,IBCNT,X,IB0,Z
 D CLEAN^VALM10
 K ^TMP("IBCE-BT",$J),^TMP("IBCE-BTDX",$J)
 I '$G(IBRULE) Q
 S IBBT="",X="",(VALMCNT,IBCNT)=0
 F  S IBBT=$O(^IBE(364.4,IBRULE,"BTYP","B",IBBT),-1) Q:IBBT=""  S IBI=0 F  S IBI=$O(^IBE(364.4,IBRULE,"BTYP","B",IBBT,IBI)) Q:'IBI  S IB0=$G(^IBE(364.4,IBRULE,"BTYP",IBI,0)) D
 . S IBCNT=IBCNT+1
 . S X=$$SETFLD^VALM1(" "_IBCNT,X,"NUMBER")
 . S X=$$SETFLD^VALM1("   "_IBBT,X,"BILL TYPE")
 . S X=$$SETFLD^VALM1($$EXPAND^IBTRE(364.41,.02,$P(IB0,U,2)),X,"ACT")
 . S X=$$SETFLD^VALM1($$EXPAND^IBTRE(364.41,.03,$P(IB0,U,3)),X,"INACT")
 . D SET(X,IBCNT,IBI)
 ;
 I '$D(^TMP("IBCE-BT",$J)) S VALMCNT=2,IBCNT=2,^TMP("IBCE-BT",$J,1,0)=" ",^TMP("IBCE-BT",$J,2,0)="    No Bill Type Restrictions Found",^TMP("IBCE-BT",$J,"IDX",1,1)="",^TMP("IBCE-BT",$J,"IDX",2,2)=""
 Q
 ;
SET(X,IBCNT,IBIEN) ;
 ; X = Text to set into display global
 ; IBCNT = the count of the entries in display
 ; IBIEN = ien of rule's bill type restriction being displayed
 ;
 S VALMCNT=VALMCNT+1,^TMP("IBCE-BT",$J,VALMCNT,0)=X
 D SET^VALM10(VALMCNT,X,IBCNT)
 S ^TMP("IBCE-BTDX",$J,VALMCNT)=IBIEN
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBCE-BT",$J),^TMP("IBCE-BTDX",$J),IBRULE
 D FULL^VALM1
 Q
 ;
EXPND ; -- expand code
 Q
 ;
SUCCBT ; Display success message after bill type restriction delete
 ;
 N DIR,Y,X
 S DIR(0)="EA"
 W !
 S DIR("A",1)="THE BILL TYPE RESTRICTION(S) WAS/WERE DELETED"
 S DIR("A")="PRESS RETURN " D ^DIR K DIR
 S VALMBCK="R"
 Q
 ;
BTDEL(IBRULE) ; Delete bill type restriction
 ; IBRULE = the ien of the rule being processed in file 364.4
 ; 
 ; Function returns 1 if successful, 0 if not
 ;
 N IBOK,DA,DIK,Y,X,IBHT,Z,Z0,VALMY,IBCT,IBX
 ;
 S IBOK=0,IBCT=0
 D SEL^IBCEF61(.VALMY)
 G:'$O(VALMY(0)) BTDQ ; None selected
 ;
 S IBX=0 F  S IBX=$O(VALMY(IBX)) Q:'IBX  S Z0=+$G(^TMP("IBCE-BTDX",$J,IBX)),Z=$P($G(^IBE(364.4,IBRULE,"BTYP",Z0,0)),U) I Z'="" S IBX(Z)=Z0,IBCT=IBCT+1
 ; First check that delete will leave the rest of the restrictions valid
 S Z="" F  S Z=$O(^IBE(364.4,IBRULE,"BTYP","B",Z)) Q:Z=""  F Z0=0:0 S Z0=$O(^IBE(364.4,IBRULE,"BTYP","B",Z,Z0)) Q:'Z0  I '$D(IBX(Z)) S IB0=$G(^IBE(364.4,IBRULE,"BTYP",Z0,0)) I IB0'="" S IBHT($P(IB0,U))=Z0 ;Extract all bill types
 ;
 S Z="",IBOK=1
 F  S Z=$O(IBHT(Z)) Q:Z=""  D  Q:'IBOK
 . N IBB
 . M IBB=IBHT K IBB(Z)
 . S IBOK=$$BTOK^IBCEF51(Z,.IBB,1)
 . I 'IBOK D
 .. S DIR(0)="EA",DIR("A",1)="Bill type"_$S(IBCT=1:"",1:"s")_" not deleted - deleting "_$S(IBCT=1:"this restriction",1:"these restrictions")_" would cause an inconsistency",DIR("A")="Press return: "
 .. D ^DIR K DIR
 ;
 I IBOK D
 . S Z="" F  S Z=$O(IBX(Z)) Q:Z=""  S DA=IBX(Z),DA(1)=IBRULE,DIK="^IBE(364.4,"_DA(1)_",""BTYP""," I DA D ^DIK
 . D REBLD
 ;
BTDQ S VALMBCK="R"
 Q IBOK
 ;

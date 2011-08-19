IBCEM01 ;ALB/TMP - BATCH BILLS LIST TEMPLATE ;11-SEP-96
 ;;2.0;INTEGRATED BILLING;**137,296**;21-MAR-94
 ;
INIT ; -- set up inital variables
 S VALMCNT=0,VALMBG=1
 D BLD
 Q
 ;
BLD ; -- build list of bills for batch entry # IBBDA
 Q:'$G(IBBDA)
 D REBLD
 Q
 ;
REBLD ; Set up formatted global
 ;
 N IB,IBCNT,X,IB0,IB00,IBX,IBIFN,IBSTAT,IBSTAT1,IBZ
 K ^TMP("IBCEM-BABI",$J),^TMP("IBCEM-BABIDX",$J)
 S (VALMCNT,IBCNT)=0,IB=""
 F  S IB=$O(^IBA(364,"ABABI",IBBDA,IB)) Q:IB=""  S IBZ=0 F  S IBZ=$O(^IBA(364,"ABABI",IBBDA,IB,IBZ)) Q:'IBZ  S IB0=$G(^IBA(364,IBZ,0)),IB00=$G(^DGCR(399,+IB0,0)) D
 . S IBIFN=+$P(IB00,U,2),IBSTAT=$P(IB0,U,3),IBSTAT1=$P(IB00,U,13)
 . S IB("S")=$G(^DGCR(399,+IB0,"U"))
 . ; -- add to list
 . S IBCNT=IBCNT+1,X="" W:'(IBCNT#25) "."
 . S X=$$SETFLD^VALM1(IBCNT,X,"NUMBER")
 . S X=$$SETFLD^VALM1($S('$G(IBCEFUNC):"",1:$S($D(^TMP("IBNOT",$J,IBZ)):"*",$G(^TMP("IBEDI_TEST_BATCH",$J)):" ","RD"[IBSTAT!'IBSTAT1!(IBSTAT1=7):"#",1:" "))_$P(IB00,U),X,"BILLNO")
 . S X=$$SETFLD^VALM1($$EXPAND^IBTRE(399,.02,$P(IB00,U,2)),X,"PAT")
 . S X=$$SETFLD^VALM1($P($G(^DPT(+$P(IB00,U,2),0)),U,9),X,"SSN")
 . S X=$$SETFLD^VALM1($$FMTE^XLFDT($P(IB("S"),U),2)_"-"_$$FMTE^XLFDT($P(IB("S"),U,2),2),X,"DATES")
 . S X=$$SETFLD^VALM1($$EXPAND^IBTRE(399,.05,$P(IB00,U,5)),X,"TYPE")
 . S X=$$SETFLD^VALM1($$EXPAND^IBTRE(364,.03,$P(IB0,U,3)),X,"TSTAT")
 . D SET(X)
 ;
 I '$D(^TMP("IBCEM-BABI",$J)) S VALMCNT=2,IBCNT=2,^TMP("IBCEM-BABI",$J,1,0)=" ",^TMP("IBCEM-BABI",$J,2,0)="    No bills found for batch",^TMP("IBCEM-BABI",$J,"IDX",1,1)="",^TMP("IBCEM-BABI",$J,"IDX",2,2)=""
 Q
 ;
EXIT ; -- Clean up list
 K ^TMP("IBCEM-BABIDX",$J),^TMP("IBCEM-BABI",$J),IBCEFUNC
 D CLEAR^VALM1,CLEAN^VALM10
 Q
 ;
HDR ; -- Sets up header
 N Z
 S Z=$G(^IBA(364.1,IBBDA,0))
 S VALMHDR(1)="BATCH #: "_$P(Z,U)_"  "_$P(Z,U,8)
 S VALMHDR(2)=$S(IBCEFUNC:"     * = Bill excluded"_$S(IBCEFUNC=1:"       # = Bill not in correct status for resubmit",1:""),1:"     * = Bill not able to be edited")
 S VALMSG=$G(IBCE("VALMSG"))
 Q
 ;
SET(X) ; -- set arrays for 837 return messages
 S VALMCNT=VALMCNT+1,^TMP("IBCEM-BABI",$J,VALMCNT,0)=X
 S ^TMP("IBCEM-BABI",$J,"IDX",VALMCNT,IBCNT)=""
 S ^TMP("IBCEM-BABIDX",$J,IBCNT)=VALMCNT_U_IB0
 Q
 ;
SEL ; Select batch bill entry(ies) from list
 N IBVAR,IBCT
 K IBDAB
 I $G(IBCEFUNC) D FULL^VALM1
 D EN^VALM2($G(XQORNOD(0)))
 S (IBCT,IBDAB)=0 F  S IBDAB=$O(VALMY(IBDAB)) Q:'IBDAB  S IBVAR=$G(^TMP("IBCEM-BABIDX",$J,IBDAB)),IBDAB(IBDAB)=$P(IBVAR,U,2) I $G(IBCEFUNC) D
 . N Z,Z0,IBSTAT
 . S IBSTAT=$P($G(^DGCR(399,+IBDAB(IBDAB),0)),U,13)
 . S Z=+$O(^IBA(364,"ABABI",IBBDA,IBDAB(IBDAB),"")),Z0=$P($G(^DGCR(399,IBDAB(IBDAB),0)),U)
 . I $G(IBCEFUNC)'=2,"RD"[$P(IBVAR,U,4)!'IBSTAT!(IBSTAT=7) K IBDAB(IBDAB) W !,"Bill #: ",Z0," already excluded (not in correct status for resubmit)" Q
 . I $D(^TMP("IBNOT",$J,Z)) W !,"Bill #: ",Z0," has been included again" K ^TMP("IBNOT",$J,Z) S IBCT=IBCT-1 Q
 . S ^TMP("IBNOT",$J,Z)=IBDAB(IBDAB),IBCT=IBCT+1 W !,"Bill #: ",Z0," will be excluded"
 I $G(IBCEFUNC) D PAUSE^VALM1
 S VALMBCK=$S('$G(IBCEFUNC):"Q",1:$S($O(VALMY("")):"R",1:"Q"))
 S ^TMP("IBNOT",$J)=IBCT
 I VALMBCK'="Q" D HDR,REBLD
 I VALMBCK="Q" D EXIT
 Q
 ;

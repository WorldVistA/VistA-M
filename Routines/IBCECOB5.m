IBCECOB5 ;ALB/TMP - IB COB MANAGEMENT SCREEN ;31-JAN-01
 ;;2.0;INTEGRATED BILLING;**137,155,349,417**;21-MAR-94;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
INIT ;
 S IBDA=+$O(IBDA(0))
 Q:'IBDA
 D BLD(IBDA)
 S VALMBG=1
 Q
 ;
BLD(IBDA) ; Build list entrypoint
 N IB,IBIFN,IBVCNT,X,Z,IBCNT,CNT,IBREC,IBIFN1,IBPTRESP
 K ^TMP("IBCECOB-X",$J)
 S VALMCNT=0
 S IB=$G(^TMP("IBCECOB1",$J,IBDA)),IBCNT=$P(IB,"^",10)
 S IBVCNT=$G(^TMP("IBCECOB",$J,IBDA)),IBIFN=$P(IBVCNT,U,2),IBVCNT=+IBVCNT
 Q:'IBVCNT
 S Z=IBVCNT-1
 F  S Z=$O(^TMP("IBCECOB",$J,"IDX",Z)) Q:'Z!('$D(^TMP("IBCECOB",$J,"IDX",+Z,IBDA)))  D SET($G(^TMP("IBCECOB",$J,Z,0)))
 D SET("")
 S X=$E(" Original Billed Amt: $"_$$A10^IBCECSA5(+$P(IB,U,2))_$J("",40),1,40)
 S X=X_$S($G(IBSRC):"   Total A/R Payments: $"_$$A10^IBCECSA5($P(IB,U,3)),1:"Unreimburse Medicare Exp: $"_$$A10^IBCECSA5(+$G(^IBM(361.1,IBCNT,1))))
 D SET(X)
 ;
 S IBIFN1=$P($G(^IBM(361.1,IBCNT,0)),U,1)      ; bill#
 ; filing error
 S IBPTRESP=$P($G(^IBM(361.1,IBCNT,1)),U,2)    ; Pt Resp Amt 1.02 field
 S:$D(^IBM(361.1,IBCNT,"ERR")) IBPTRESP=0      ; filing error
 ; Override Pt Resp Amt for bills with Form Type UB-04
 I $$FT^IBCEF(IBIFN1)=3 S IBPTRESP=$$PTRESPI^IBCECOB1(IBCNT)
 ;
 S X=$E($S($G(IBSRC):"        Bill Balance: $"_$$A10^IBCECSA5(+$P(IB,U,4)),1:" Pt Resp Amt:         $"_$$A10^IBCECSA5(IBPTRESP))_$J("",40),1,40)
 I '$G(IBSRC) N IBCALC,IBIFN S IBIFN=+$G(^IBM(361.1,IBCNT,0)) D MRACALC^IBCEMU2(IBCNT,IBIFN,0,.IBCALC)
 S X=X_$S($G(IBSRC):"       Total Amt This EOB: $"_$$A10^IBCECSA5($P(IB,U,17)),1:"   Medicare Contract Adj: $"_$$A10^IBCECSA5($G(IBCALC("MEDCA"))))
 D SET(X)
 D SET("")
 I $G(IBSRC) D
 . S X=" Days Since Last Transmit: "_+$P(IB,U,12)
 . D SET(X)
 . S X="       Authorizing Biller: "_$P(IB,U,8)
 . D SET(X)
 . S X="              COB History: "
 . I $P(IB,U,11)'="" D
 .. F Z=1:1:$L($P(IB,U,11),";") S X=X_$P($P(IB,U,11),";",Z) D SET(X) S X=$J("",27)
 . E  D
 .. S X=X_"NONE FOUND" D SET(X)
 I '$G(IBSRC) S CNT=20,IBREC=$G(^IBM(361.1,IBCNT,0)) K ^TMP("IBCECSD",$J) D MRALLA^IBCECSA5 M ^TMP("IBCECOB-X",$J)=^TMP("IBCECSD",$J) K ^TMP("IBCECSD",$J)
 ;
 Q
 ;
EXIT ; -- exit code --
 K ^TMP("IBCECOB-X",$J),IBDA
 D CLEAN^VALM10
 Q
 ;
HDR1 ; -- header code
 ; Assume IBIFN and IBZIEN are defined
 N IBCOB,IBINS
 K VALMHDR
 S IBINS=$$FINDINS^IBCEF1(IBIFN)
 S VALMHDR(1)=IORVON_" BILL #:"_$$BN^PRCAFN(IBIFN)_IORVOFF
 S VALMHDR(1)=$J("",80-$L(VALMHDR(1))\2)_VALMHDR(1)
 S VALMHDR(2)="  INSURANCE COMPANY: "_$P($G(^DIC(36,+IBINS,0)),U)
 S VALMHDR(3)="  "_IOUON_"Svc Date  Patient Name/Last 4           Care Type/Form  COB/SEQ"_IOUOFF
 S Z=$G(^TMP("IBCECOB",$J,IBZIEN,0))
 S VALMHDR(4)="  "_$E(Z,17,$L(Z))
 Q
 ;
EXIT1 ; -- exit code --
 K ^TMP("IBCECSD",$J)
 D CLEAN^VALM10
 Q
 ;
VEOB ;View an EOB from EOB Management
 N IBDA,IBCNT,IBIFN,Z,VALMCNT,IBZIEN,IBONE
 ;
 D FULL^VALM1
 D SEL^IBCECOB2(.IBDA,1)
 S IBDA=+$O(IBDA(0))
 I IBDA D EN^VALM("IBCEM EOB VIEW EOB")
 S VALMBCK="R"
 Q
 ;
INIT1 ;
 S IBCNT=+$P($G(IBDA(IBDA)),U,3)
 S IBIFN=+$G(IBDA(IBDA)),IBZIEN=+$G(^TMP("IBCECOB",$J,IBDA)),IBONE=1
 Q:'IBCNT!'IBIFN!'IBZIEN
 D HDR1
 D BLD^IBCECSA6
 Q
 ;
SET(X) ;set up list manager screen array
 S VALMCNT=VALMCNT+1
 S ^TMP("IBCECOB-X",$J,VALMCNT,0)=X
 Q
 ;

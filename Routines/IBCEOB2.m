IBCEOB2 ;ALB/TMP - EOB LIST FOR MANUAL MAINTENANCE ;18-FEB-99
 ;;2.0;INTEGRATED BILLING;**137,155**;21-MAR-94
 Q
 ;
EN ; Enter/edit an EOB manually for a bill
 ; MRA's cannot be manually entered
 N VALMCNT,VALMBG,VALMHDR
 S VALMCNT=0,VALMBG=1
 D EN^VALM("IBCE EOB LIST")
 Q
 ;
HDR ; -- header code
 N IBCOB,IBINS,IBINSNM
 K VALMHDR
 S IBINS=$$CURR^IBCEF2(IBIFN),IBINSNM=$P($G(^DIC(36,+IBINS,0)),U)
 S IBCOB=$P("^PRIMARY^SECONDARY^TERTIARY",U,$$COBN^IBCEF(IBIFN)+1)
 S VALMHDR(1)=IORVON_" BILL #:"_$$BN^PRCAFN(IBIFN)_IORVOFF
 S VALMHDR(1)=$J("",80-$L(VALMHDR(1))\2)_VALMHDR(1)
 S VALMHDR(2)=" CURRENT INSURANCE COMPANY ("_IBCOB_"): "_IBINSNM
 I $D(^IBM(361.1,"B",IBIFN)) D
 . S VALMHDR(3)=" "
 . S VALMHDR(4)=" #  SEQ PAYER"_$J("",15)_"EOB PAID DATE     TYPE  STATUS"
 Q
 ;
INIT ; -- init variables and list array
 ; Select bill
 K VALMQUIT
 S IBIFN=$$BILL(.VALMQUIT)
INITQ Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBCEOB",$J),IBIFN,IBEOB
 D CLEAR^VALM1
 Q
 ;
BLD ; Build list template display - IBIFN must equal ien of bill in file 399
 ;
 N IB0,X,Y,IBCOB,IBCOBN,IB,IBCNT,IBEOB,IBSEQ,IBPDDT
 S VALMCNT=0
 K ^TMP("IBCEOB",$J)
 S IB0=$G(^DGCR(399,+$G(IBIFN),0)),VALMCNT=0
 S IBCOB=$P($$EXTERNAL^DILFD(399,.21,,$P(IB0,U,21))," "),IBCOBN=$$COBN^IBCEF(IBIFN)
 ;
 S IBCNT=0
 I $D(^IBM(361.1,"B",IBIFN)) D  ; Display existing EOB's for bill, if any
 . K ^TMP("IB",$J)
 . S IBEOB=0 F  S IBEOB=$O(^IBM(361.1,"B",IBIFN,IBEOB)) Q:'IBEOB  D
 .. S IB0=$G(^IBM(361.1,IBEOB,0))
 .. S ^TMP("IB",$J,+$P(IB0,U,6),IBEOB)=IB0 ; Sort by EOB paid date
 . ;
 . S IBPDDT="" F  S IBPDDT=$O(^TMP("IB",$J,IBPDDT)) Q:IBPDDT=""  S IBEOB=0 F  S IBEOB=$O(^TMP("IB",$J,IBPDDT,IBEOB)) Q:'IBEOB  S IB0=$G(^(IBEOB)) I IB0'="" D
 .. ;
 .. S IBCNT=IBCNT+1
 .. S IBSEQ=+$P(IB0,U,15)
 .. S IB=" "_$E(IBCNT_"   ",1,3)_$S(IBSEQ:"("_$P("P^S^T",U,IBSEQ)_") ",1:$J("",4))_$E($$EXTERNAL^DILFD(361.1,.02,"",$P(IB0,U,2))_$J("",18),1,18)_"  "
 .. S IB=IB_$E($$FMTE^XLFDT($P(IB0,U,6),"2")_$J("",18),1,18)_" "_$E($P("EOB^MRA",U,$P(IB0,U,4)+1)_$J("",5),1,5)_$$EXTERNAL^DILFD(361.1,.13,"",$P(IB0,U,13))
 .. ;
 .. D SET(IB,IBCNT,IBEOB)
 . ;
 . K ^TMP("IB",$J)
 I 'IBCNT S IBCNT=IBCNT D SET(" NO EOB's FOUND FOR BILL #"_$$BN^PRCAFN(IBIFN))
 ;
 Q
 ;
SET(X,CNT,IBEOB) ;set list manager screen arrays
 S VALMCNT=VALMCNT+1
 S ^TMP("IBCEOB",$J,VALMCNT,0)=X
 I $G(IBEOB) D
 . S ^TMP("IBCEOB",$J,"IDX",VALMCNT,CNT)=""
 . S ^TMP("IBCEOB",$J,CNT)=VALMCNT_U_IBEOB
 Q
 ;
BILL(VALMQUIT,IBX) ; Select bill
 ; VALMQUIT = pass by reference to determine if protocol should quit
 ; IBX = pass by reference to return 1 if timeout or ^ entered
 ;
 ; Must be printed/txmt or closed status, have a current insurance and
 ; not having MEDICARE WNR as its primary insurance with the COB sequence
 ;  of the bill being primary
 ;
 N DIC,DA,X,Y,IBIFN
 K VALMQUIT
 S IBX=0
 S DIC="^DGCR(399,",DIC(0)="AEMQ",DIC("S")="N IBY S IBY=Y I $P(^(0),U,13)'="""",""04""[$P(^(0),U,13),$D(^(""I1"")),$S($$MCRWNR^IBEFUNC(+$$CURR^IBCEF2(+IBY)):+$$COBN^IBCEF(+IBY)'=1,1:1)" D ^DIC K DIC
 S IBIFN=+Y,IBX=($G(DTOUT)!($G(DUOUT)))
 I IBIFN'>0 S VALMQUIT=1 G BILLQ
 I IBIFN>0 D BLD,HDR
BILLQ Q IBIFN
 ;

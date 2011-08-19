IBJTU1 ;ALB/ARH - TPI UTILITIES ;2/14/95
 ;;2.0;INTEGRATED BILLING;**39,80,276**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
PRVSCR(SCRNARR) ; called as part of a screen ACTION PROTOCOL'S ENTRY ACTION to determine if screen has already been displayed
 ; returns true if screen array already exists (ie. already displayed), 
 ; setting IBFASTXT causes LM to back out of current screens,
 ; setting IBPRVSCR causes LM to stop exiting screens when the chosen screen is reached
 ; if user tries to execute a screen already displayed it will quit out of existing screens until the asked for screen is found
 N X S X=0,IBPRVSCR="" I $G(SCRNARR)'="",$D(^TMP(SCRNARR,$J)) S X=1,IBPRVSCR=SCRNARR,IBFASTXT=3
 Q X
 ;
HDR(IBIFN,DFN,LNS) ; called by a screens's LIST TEMPLATE HEADER to get lines for header, used for all TP screens
 ;input:  LNS=header lines to add  ---  defined on exit: VALMHDR array
 ;
 N X,Y,Z,IBD0,IBPD0,IBDI1,IBCNT S IBIFN=+$G(IBIFN),DFN=+$G(DFN),LNS=+$G(LNS) K VALMHDR
 S IBCNT=0,IBD0=$G(^DGCR(399,+IBIFN,0)),IBPD0=$G(^DPT(+DFN,0))
 S IBDI1=$P(IBD0,U,21),IBDI1=$S(IBDI1="S":"I2",IBDI1="T":"I3",1:"I1"),IBDI1=$G(^DGCR(399,+IBIFN,IBDI1))
 ;
1 I LNS'[1 G 2
 ; -- first line of screens: BILL NUMBER, PAT NAME, PAT ID, DOB, SUBSCRIBER ID
 N IBBILL,IBPAT,IBPATID,IBDOB,IBSUB,IBPNWDTH S IBCNT=IBCNT+1,(IBSUB,IBPATID)=""
 S IBBILL=$P(IBD0,U,1)_$$ECME^IBTRE(IBIFN)
 S X=$$PT^IBEFUNC(DFN),IBPAT=$P(X,U,1) I $P(X,U,3)'="" S IBPATID=$E(X)_$P(X,U,3)
 S IBDOB="DOB: "_$$DATE^IBJU1($P(IBPD0,U,3))
 I +IBIFN S X=$P(IBDI1,U,2),X=X_$J("",(13-$L(X))),IBSUB="Subsc ID: "_X
 ;
 S IBPNWDTH=80-($L(IBBILL)+3+2+$L(IBPATID)+3+$L(IBDOB)+3+$L(IBSUB)),IBPAT=$E(IBPAT,1,IBPNWDTH),Z="   "
 S VALMHDR(IBCNT)=IBBILL_Z_IBPAT_"  "_IBPATID_$J("",(IBPNWDTH-$L(IBPAT)))_Z_IBDOB_Z_IBSUB
 ;
2 I LNS'[2 G 3
 ; -- bill screens line 2: STATEMENT DATES, TIMEFRAME, ORIG AMT (AR)
 N IBDU S IBCNT=IBCNT+1,IBDU=$G(^DGCR(399,+IBIFN,"U"))
 S X=" "_$$DATE^IBJU1(+IBDU)_" - "_$$DATE^IBJU1(+$P(IBDU,U,2)),VALMHDR(IBCNT)=X_$J("",(28-$L(X)))
 S X=$$EXSET^IBJU1(+$P(IBD0,U,6),399,.06),VALMHDR(IBCNT)=VALMHDR(IBCNT)_X_$J("",(29-$L(X)))
 S X=$$BILL^RCJIBFN2(IBIFN),X="Orig Amt: "_$FN($P(X,U,1),",",2),VALMHDR(IBCNT)=VALMHDR(IBCNT)_X
 ;
3 I LNS'[3 G HDRQ
 ; -- AR screens line 2: CURRENT STATUS (AR), ORIGINAL AMT (AR), CURRENT AMT (AR)
 N IBST,IBOC,IBBD,IBY S IBCNT=IBCNT+1,IBY=$$BILL^RCJIBFN2(+IBIFN)
 S IBST="AR Status: "_$P($$ARSTATA^IBJTU4(+IBIFN),U,1)
 S IBOC="Orig Amt: "_$FN($P(IBY,U,1),",",2)
 S IBBD="Balance Due: "_$FN($P(IBY,U,3),",",2)
 ;
 S X="  "_IBOC_$J("",(20-$L(IBOC)))_" "_IBBD_$J("",(23-$L(IBBD))),Y=80-$L(X),IBST=$E(IBST,1,Y)
 S VALMHDR(IBCNT)=IBST_$J("",(Y-$L(IBST)))_X
 ;
HDRQ Q

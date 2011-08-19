IBCB1 ;ALB/AAS - Process bill after enter/edited ;2-NOV-89
 ;;2.0;INTEGRATED BILLING;**70,106,51,137,161,182,155,327**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;MAP TO DGCRB1
 ;
 ;IBQUIT = Flag to stop processing
 ;IBVIEW = Flag for Bill has been viewed
 ;IBDISP = Flag for Bill entering display been viewed.
 ;
 K ^UTILITY($J) I $D(IBAC),IBAC>1 G @IBAC
1 ;complete bill
 D END,EDITS^IBCB2 G:IBQUIT END
 ;
 I '$$IICM^IBCB2(IBIFN) G END ; Ingenix ClaimsManager
 I '$$IIQMED^IBCB2(IBIFN) G END ; DSS QuadraMed Claims Scrubber
 ;
3 ;authorize bill/request MRA
 I '$D(^XUSEC("IB AUTHORIZE",DUZ))!('$D(IBIFN)) W !!,"You do not hold the Authorize Key.",! G END
 I '$P($G(^IBE(350.9,1,1)),"^",23),DUZ=$P(^DGCR(399,IBIFN,"S"),"^",2) W !!,"Entering user can not authorize.",! G END
 I $P(^DGCR(399,IBIFN,"S"),"^",9) W !,"Already Approved, Can't change" G END
 D:'$G(IBAC)!($G(IBAC)>1) EDITS^IBCB2 G:IBQUIT END
 ;
 I $G(IBAC)'=1,'$$IICM^IBCB2(IBIFN) G END ; Ingenix ClaimsManager
 I $G(IBAC)'=1,'$$IIQMED^IBCB2(IBIFN) G END ; DSS QuadraMed Claims Scrubber
 ;
AUTH S IBMRA=$$REQMRA^IBEFUNC(IBIFN)
 S IBEND=0
 I IBMRA["R" D AUTH^IBCB11 G:IBEND END ;MRA normally required, but MEDIGAP ins co
 ;                         doesn't want/need it or MRA parameter off
 ;
 W !!,"THIS BILL WILL "_$P("NOT ^",U,$$TXMT^IBCEF4(IBIFN)+1)_"BE TRANSMITTED ELECTRONICALLY"
 W !!,"WANT TO ",$S('IBMRA:"AUTHORIZE BILL",1:"REQUEST AN MRA")," AT THIS TIME" S %=2 D YN^DICN G:%=-1!(%=2) END
 I '% W !?4,"YES - If finished entering bill information and to allow bill to be printed or transmitted",!?4,"No - To take no action" G AUTH
 S (DIC,DIE)=399,IBYY=$S('IBMRA:"@90",1:"@901"),DA=IBIFN,DR="[IB STATUS]" D ^DIE K DIC,DIE,IBYY D:$D(IBX3) DISAP^IBCBULL
 I $S('IBMRA:'$P(^DGCR(399,IBIFN,"S"),"^",9),1:'$P($G(^DGCR(399,IBIFN,"TX")),U,6)) G END
 ;
 ; Update the review status for all EOB's on file
 D STAT^IBCEMU2(IBIFN,3)     ; Accepted - Complete EOB
 ;
 D AUTOCK^IBCEU2(IBIFN) ; Checks for need to add any codes to bill based on information already on bill, specifically for EDI purposes
 S IBTXSTAT=$$TXMT^IBCEF4(IBIFN,,1)  ;Determine transmit, whether live/test
 I IBTXSTAT D  I IBMRA D CTCOPY^IBCCCB(IBIFN,1) G END
 .W !,"  Adding "
 .W:+IBTXSTAT=2 "test " W "bill to BILL TRANSMISSION File"_$S('IBMRA:"",1:" for MRA submission")_".",!
 .W:+IBTXSTAT=1&IBMRA "  Bill is no longer editable unless returned in error from Medicare."
 .S Y=$$ADDTBILL(IBIFN,+IBTXSTAT)
 .W ! W:'$P(Y,U,3) *7 W $S($P(Y,U,3):"  Bill will be submitted electronically",1:"  Error loading into transmit file - bill can not be transmitted.")
 .;
 ;
 W !,"Passing completed Bill to Accounts Receivable.  Bill is no longer editable."
 D ARPASS(IBIFN,1)
 G:'$G(PRCASV("OKAY")) END
 W !,"Completed Bill Successfully sent to Accounts Receivable." D FIND^IBOHCK(DFN,IBIFN)
 ;
 ; Check to see if any unreviewed status messages or EOBs on file and
 ; what to do about them
 N IBTXBARR
 S IBRESUB=$$RESUB^IBCECSA4($S($G(IBCNCOPY):$P($G(^DGCR(399,IBIFN,0)),U,15),1:IBIFN),+IBTXSTAT,"E",.IBTXBARR)
 I IBRESUB=2 D         ; update review statuses to be 'review complete'
 . N IBDA S IBDA=0
 . F  S IBDA=$O(IBTXBARR(IBDA)) Q:'IBDA  D UPDEDI^IBCEM(IBDA,$S($G(IBCNCOPY):"R",1:"E"))
 . Q
 ;
 K IBTXPRT
 ;
4 ;generate/print bill
 G:'$D(IBIFN) END
 S:'$D(IBMRA) IBMRA=+$$NEEDMRA^IBEFUNC(IBIFN)
 I 'IBMRA,'$P(^DGCR(399,IBIFN,"S"),"^",9) W !!,*7,"Not Authorized, Can Not Print!" G END
 I IBMRA,'$P(^DGCR(399,IBIFN,"TX"),"^",6) W !!,*7,"Not Ready For MRA Submission, Can Not Print!" G END
 S IBTXSTAT=$$TXMT^IBCEF4(IBIFN)
 I IBMRA,$$NEEDMRA^IBEFUNC(IBIFN)'["R" W !!,*7,"MRA Submission not yet confirmed by Austin, Can Not Print!" Q:$S('IBTXSTAT:1,1:"XP"'[$P($G(^IBA(364,+$$LAST364^IBCEF4(IBIFN),0)),U,3))
 I +IBTXSTAT,$D(^IBA(364,"ABDT",IBIFN)) S IBTXOK="" D  I 'IBTXOK S %=2 G GENTX
 . N IBX,IBTST
 . S IBX=+$$LAST364^IBCEF4(IBIFN),IBTST=""
 . I $$TEST^IBCEF4(IBIFN) S (IBTXOK,IBTST)=1
 . I "XP"[$P($G(^IBA(364,IBX,0)),U,3) D:'IBTST  Q
 .. W !!,*7,"This Bill Can Not Be Printed Until Transmit Confirmed" W:IBMRA " (to request an MRA)" D:'$D(IBVIEW) VIEW^IBCB2
 . W !!,"This Bill Has Already Been Transmitted" W:IBMRA " (to request an MRA)"
 . S DIR("B")="Y",DIR("A")="WANT TO PRINT IT ANYWAY",DIR(0)="Y" D ^DIR K DIR Q:$D(DTOUT)!$D(DUOUT)!'Y  S IBTXOK=1
 D DISP^IBCB2
 S:'$D(IBQUIT) IBQUIT=0
 D:'$D(IBVIEW) VIEW^IBCB2 G:IBQUIT END
 S IBPNT=$P(^DGCR(399,IBIFN,"S"),"^",12)
GEN I $$TEST^IBCEF4(IBIFN) W !!,"THIS BILL IS BEING USED AS A TRANSMISSION TEST BILL"
 W !!,"WANT TO ",$S(IBPNT]"":"RE-",1:""),"PRINT BILL AT THIS TIME" S %=2 D YN^DICN I %=-1 D:+$G(IBAC)=1 END,CTCOPY^IBCCCB(IBIFN) G END
 I '% W !?4,"YES - to print the bill now",!?4,"NO - To take no action" G GEN
GENTX I %'=1 D:+$G(IBAC)=1 END,CTCOPY^IBCCCB(IBIFN) G END
 ;
 ; Bill has never been printed.  First time print.
 I 'IBPNT D  G END
 . I $D(IBTXPRT) D TXPRTS
 . D EN1^IBCF
 . I $D(IBTXPRT) D TXPRT
 . D MRA^IBCEMU1(IBIFN)       ; Printing the MRA
 . I +$G(IBAC)=1 D END,CTCOPY^IBCCCB(IBIFN)
 . Q
 ;
 ; Below section is for re-prints
RPNT G:$$NEEDMRA^IBEFUNC(IBIFN) END
 R !!,"(2)nd Notice, (3)rd Notice, (C)opy or (O)riginal: C// ",IBPNT:DTIME S:IBPNT="" IBPNT="C" G:IBPNT["^" END
 S IBPNT=$E(IBPNT,1) I "23oOcC"'[IBPNT W !?5,"Enter 'O' to reprint the original bill or",!?5,"Enter 'C' to reprint the bill as a duplicate copy or",!?5,"Enter '2' or '3' to print 2nd or 3rd follow-up notices." S IBPNT=1 G RPNT
 W "  (",$S("cC"[IBPNT:"COPY","oO"[IBPNT:"ORIGINAL",IBPNT=2:"2nd NOTICE",IBPNT=3:"3rd NOTICE",1:""),")"
 I $D(IBTXPRT) D
 . D TXPRTS
 . I "oOcC"[IBPNT S IBRESUB=$$RESUB^IBCECSA4(IBIFN,1,"P")
 S IBPNT=$S("oO"[IBPNT:1,"cC"[IBPNT:0,1:IBPNT)
 D EN1X^IBCF D:$D(IBTXPRT) TXPRT
 D MRA^IBCEMU1(IBIFN)       ; Printing the MRA
 ;
 ;
END K IBER,IBEND D END^IBCBB1 K IBQUIT,IBVIEW,IBDISP,IBST,IB,PRCAERCD,PRCAERR,PRCASVC,PRCAT,DGRA2,IBBT,IBCH,IBNDS,IBOA,IBREV,IBX,DGXRF1,PRCAORA,IBX3,DGBILLBS,DGII,DGVISCNT,DGFIL,DGTE,IBTXOK,IBTXSTAT,IBMRA,IBNOFIX
 K %DT,DIC,DIE,I,J,X,Y,Y1,Y2,IBER,IBDFN,IBDSDT,IBJ,IBNDI1,IBZZ,VA,IBMA,IBXDT,DI,PRCAPAYR,DGBS,DGCNT,DGDA,DGPAG,DGREVC,DGRV,DGTEXT,DGTOTPAG,IBOPV,DGLCNT,DGTEXT1,DGRSPAC,DGSM,IBPNT,DGINPT,DGLL,IBCPTN,IBFL
 K IBRESUB,IBOPV1,IBOPV2,IBCHG,DGBIL1,DGU,DDH,IBA1,IBINS,IBPROC,PRCARI K:'$D(PRCASV("NOTICE")) PRCASV
 K ^TMP("IBXDATA",$J),^TMP("IBXEDIT",$J)
 K IBCISNT,IBCISTAT,IBCIERR   ; remove ClaimsManager variables
 Q
 ;
TX1(IBX,RESUB) ; Transmit a single bill from file 364 entry # IBX
 ; RESUB = flag (1 = resubmitting a bill, 0 = submitting bill 1st time)
 ; Returns 1 if successfully extracted to mailman queue for transmission,
 ;         0 if extract not successful
 N IBTXOK,IBVVSAVE
 K ^TMP("IBRESUBMIT",$J),^TMP("IBONE",$J)
 S IBVVSAVE("IBX")=IBX,^TMP("IBONE",$J)=+$G(RESUB),^($J,IBX)=""
 D ONE^IBCE837
 S IBX=IBVVSAVE("IBX")
 I $P($G(^IBA(364,IBX,0)),U,3)="P" S IBTXOK=1
 K ^TMP("IBONE",$J)
 Q $G(IBTXOK)
 ;
ARONLY(IBIFN) ; Pass bill to A/R, but that's all
 D ARPASS(IBIFN,0)
 Q
 ;
ARPASS(IBIFN,UPDOK) ;Pass bill to A/R as NEW BILL
 ;IBIFN = bill entry #
 ;UPDOK = flag 1: if error going to A/R, allow interactive edit
 ;             0: send bulletin to IB EDI for error going to A/R
 Q:+$$STA^PRCAFN(+IBIFN)'=201  ;Must not have been sent previously
 D GVAR^IBCBB
 ;Can't be an ins co that won't reimburse
 Q:$S($P($G(^DGCR(399,IBIFN,0)),U,11)="i":'IBNDMP,1:0)
 D ARRAY^IBCBB1,^PRCASVC6
 D REL^PRCASVC:$G(PRCASV("OKAY"))
 I '$G(PRCASV("OKAY")) D
 . N IBQUIT,IBQUIT1
 . S IBQUIT=0
 . I $G(UPDOK) D  Q
 .. F  D  Q:IBQUIT
 ... D DSPARERR^IBCB2("")
 ... Q:IBQUIT
 ... I $$ASKEDIT^IBCB2($G(IBAC)) D VIEW1^IBCB2 Q
 ... S IBQUIT=1
 . N XMSUB,XMY,XMTEXT,XMDUZ,IBT
 . S XMSUB="ERROR PASSING BILL TO A/R ON CONFIRMATION",XMTEXT="IBT(",XMY="G.IB EDI",XMDUZ=.5
 . S IBT(1)="A problem has been detected while trying to pass bill "_$P($G(^DGCR(399,IBIFN,0)),U)_" to"
 . S IBT(2)="Accounts Receivable when updating the bill's electronic confirmation."
 . S IBT(3)="Please use the option PASS BILL TO A/R to complete this process."
 . D ^XMD
 Q
 ;
ADDTBILL(IBIFN,TXST) ; Add new transmit bill rec to file 364 for bill IBIFN
 ; TXST = test flag 1=live, 2=test
 N COB,DD,DO,DIC,DLAYGO,X
 S TXST=($G(TXST)/2\1),COB=$$COB^IBCEF(IBIFN)
 S DIC(0)="L",DIC="^IBA(364,",DLAYGO=364,X=IBIFN,DIC("DR")=".03///X;.04///NOW;.07////"_TXST_";.08////"_COB D FILE^DICN
 Q Y
 ;
TXPRTS ; Save off last print date to see if bill was reprinted without queueing
 I '$$NEEDMRA^IBEFUNC(IBIFN) S IBTXPRT("PRT")=$P($G(^DGCR(399,IBIFN,"S")),U,14)
 Q
 ;
TXPRT ; Set variable if print was tasked or bill was printed (last print date changed)
 I '$$NEEDMRA^IBEFUNC(IBIFN),$S($G(ZTSK):1,1:IBTXPRT("PRT")'=$P($G(^DGCR(399,IBIFN,"S")),U,14)) S IBTXPRT=1
 Q
 ;

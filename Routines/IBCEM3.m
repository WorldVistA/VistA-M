IBCEM3 ;ALB/TMP - IB ELECTRONIC MESSAGE MGMNT ACTIONS ;18-AUG-1999
 ;;2.0;INTEGRATED BILLING;**137,155,320**;21-MAR-1994
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
CANCEL(IBDA,IBIFN,IB364) ; Generic cancel bill action
 ; IBDA = entry selected from list (pass by reference-value is returned)
 ; IBIFN = ien of bill entry in file 399
 ; IB364 = ien of transmitted bill entry in file 364
 ;
 N Y,IBCAN,IBCE,IBTDA,IB0
 I 'IBDA!'IBIFN S IBDA="" G CANCELQ
 I '$$CANCKS("C",IBIFN) S IBDA="" G CANCELQ
 ;
 S (IBCAN,IBCE("EDI"))=1,Y=IBIFN
 I $G(IBCEAUTO) S IBCAN=2
 N IBQUIT
 D NOPTF^IBCC S:$P($G(^DGCR(399,IBIFN,0)),U,13)'=7 IBDA=""
 I '$G(IBCEAUTO) D PAUSE^VALM1
CANCELQ Q
 ;
CANCKS(FUNC,IBIFN)      ; Check validity of cancel or cancel/clone function
 ;FUNC = "C" for cancel "CC" for cancel/clone
 ;IBIFN = bill internal entry #
 N ERR
 S ERR=""
 I '$$DISP(IBIFN,"cancel"_$S(FUNC="C":"",1:"/clone")) S ERR="<No action taken>"
 I ERR'="" W !,*7,ERR D PAUSE^VALM1
 Q (ERR="")
 ;
EBILL(IBDA,IBIFN,IB364) ;Generic edit bill action
 N IBAC,IBBDA,IBTDA,IB0,IBV,DFN,IBDA1,IBELOOP,IB399,IBDAB,IBHOLD,IB399TX,IBNEED,IBPOPOUT,IBTXPRT
 S IB399=$G(^DGCR(399,+IBIFN,0))
 S IB399TX=$G(^DGCR(399,+IBIFN,"TX")),IBNEED=$$NEEDMRA^IBEFUNC(IBIFN)
 I $P($G(^DGCR(399,IBIFN,0)),U,13)'<3 D  G EBILLQ
 . N DIR
 . S DIR(0)="EA",DIR("A",1)="You cannot edit a bill with a status of "_$$EXPAND^IBTRE(399,.13,$P($G(^DGCR(399,IBIFN,0)),U,13))
 . S DIR("A")="Enter RETURN to continue or '^' to exit:"
 . D ^DIR
 . S IBDA=""
 I '$$DISP(IBIFN,"edit") S IBDA="" G EBILLQ
 S IBAC=1,DFN=$P($G(^DGCR(399,IBIFN,0)),U,2),IBV=0
 S IBHOLD("IBIFN")=IBIFN,IBHOLD("IBDA")=$G(IBDA)
 ; Warning - do not use IBH variable when calling the following routine
 D ST^IBCB,ENS^%ZISS
 D:$D(IBIFN) PAUSE^VALM1
 S IBIFN=IBHOLD("IBIFN"),IBDA=IBHOLD("IBDA")
 I $S(IBNEED:$P($G(^DGCR(399,IBIFN,0)),U,13)'=2,1:$P($G(^DGCR(399,IBIFN,0)),U,13)'=3) S IBDA=""
 I IBDA D
 . S $P(^DGCR(399,IBIFN,"S"),U,10,11)=(DT_U_DUZ)
 . S DIK="^DGCR(399,",DA=IBIFN F DIK(1)=10,11 D EN1^DIK
 . D UPDEDI^IBCEM(IB364,"E")
EBILLQ Q
 ;
DISP(IBIFN,FUNC,DISP,IBDEF,DIRUT)   ;Display bill detail
 ;  Returns 1 if function should continue, 0 if function should not
 ; IBIFN = Bill #
 ; FUNC = Text (lower case) to describe function to perform
 ; DISP = flag = 1 for return data, no display
 ;               format:  1^BILL #^PATIENT^BILL TYPE^DATES
 ; IBDEF = Default answer for Yes/No question here (1=Yes)
 ; DIRUT = output parameter is defined if passed by reference,
 ;       = this will be defined if the user enters a leading up-arrow
 ;       = or times out or enters a null response
 ;
 ; Function returns Y and DIRUT - used by IBCEMCA2 - DO NOT NEW THESE
 ;
 N IBB0,IBBU,IBNO,STAT,DIR,DTOUT,DUOUT,IBV
 S IBB0=$G(^DGCR(399,IBIFN,0)),IBBU=$G(^("U")),IBNO=$P(IBB0,U)
 S IBV(1)=$P($G(^DPT(+$P(IBB0,U,2),0)),U)_$S($P($G(^(0)),U,9)'="":" ("_$P(^(0),U,9)_")",1:"")
 S IBV(2)=$$EXPAND^IBTRE(399,.05,$P(IBB0,U,5))
 S IBV(3)=$$EXPAND^IBTRE(399,151,$P(IBBU,U))_" - "_$$EXPAND^IBTRE(399,151,$P(IBBU,U,2))
 ;
 I '$G(DISP) D  G DISPQ
 . S (DIR("A",1),DIR("A",6))=" ",STAT=1
 . S DIR("A",2)="    Bill #: "_IBNO
 . S DIR("A",3)="   Patient: "_IBV(1)
 . S DIR("A",4)=" Bill Type: "_IBV(2)
 . S DIR("A",5)="Bill Dates: "_IBV(3)
 . S DIR("A")="Are you sure this is the bill you want to "_FUNC_"? "
 . S DIR("B")="NO"
 . I $G(IBDEF) S DIR("B")="Yes"
 . S DIR(0)="YA" D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT)!'Y S STAT=0
 S STAT="1^"_IBNO_U_IBV(1)_U_IBV(2)_U_IBV(3)
DISPQ ;
 Q STAT
 ;

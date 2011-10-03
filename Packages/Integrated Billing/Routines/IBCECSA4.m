IBCECSA4 ;ALB/CXW - IB CLAIMS STATUS AWAITING RESOLUTION SCREEN ;5-AUG-1999
 ;;2.0;INTEGRATED BILLING;**137,155,320,371,433**;21-MAR-1994;Build 36
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
SMSG ;select message
 N IBCOM,IBX,IBDAX,IBA
 D SEL(.IBDAX,1)
 I $O(IBDAX(""))="" G SMSGQ
 S IBDAX=+$O(IBDAX(0)),IBA=$G(IBDAX(IBDAX))
 S IBX=$G(^TMP("IBCECSB",$J,$P(IBA,U,3),$P(IBA,U,4),$P(IBA,U,6),$P(IBA,U,2)))
 I IBX'="" D
 . Q:'$$LOCK^IBCEU0(361,$P(IBA,U,2))
 . D EN^VALM("IBCEM CSA MSG")
 . D UNLOCK^IBCEU0(361,$P(IBA,U,2))
SMSGQ S VALMBCK="R"
 I $G(IBFASTXT) S VALMBCK="Q" K IBDAX
 D:$O(IBDAX(0)) BLD^IBCECSA1
 Q
 ;
COB ; COB management link from CSA
 N IBA,IBX
 ;IBX,IBA are killed during cancel execution
 D FULL^VALM1
 D EN^IBCECOB
 I $D(IBFASTXT) K IBFASTXT
 S VALMBCK="R"
 Q
 ;
EDI ;History detail display
 N IBIFN,IBX,IBA
 D FULL^VALM1
 S IBDAX=$O(IBDAX(0)),IBIFN=+$G(IBDAX(IBDAX))
 D EDI2^IBCECOB2(IBIFN)
 S VALMBCK="R"
 Q
EOB ;View an EOB
 N IBIFN,IBA,IBX
 D FULL^VALM1
 S IBDAX=$O(IBDAX(0)),IBIFN=+$G(IBDAX(IBDAX))
 D EN^VALM("IBCEM VIEW EOB")
 Q
 ;
TPJI ;Third Party joint Inquiry
 N IBIFN,IBX,IBA
 D FULL^VALM1
 S IBDAX=$O(IBDAX(0)),IBIFN=+$G(IBDAX(IBDAX))
 D TPJI1^IBCECOB2(IBIFN)
 S VALMBCK="R"
 Q
 ;
PBILL ;Print bill - not for resubmit
 ; IB*320 - allow action for MRA request claims
 N IBIFN,IBX,IBA,IBRESUB
 D FULL^VALM1
 S IBDAX=$O(IBDAX(0)),IBIFN=+$G(IBDAX(+IBDAX))
 I "234"'[$P($G(^DGCR(399,IBIFN,0)),U,13) W !!,"Bill status must be REQUEST MRA, AUTHORIZED or PRNT/TX to print the bill." D PAUSE^VALM1 G PB1
 ;
 ; don't update review status for MRA's
 I $P($G(^DGCR(399,IBIFN,0)),U,13)=2 S IBRESUB=1
 E  S IBRESUB=$$RESUB(IBIFN,1,"PX")
 I IBRESUB'>0 W !,*7,"This is not a transmittable bill or review not needed" D PAUSE^VALM1 G PB1
 I IBRESUB=2 D  G PB1
 . N IB364
 . S IB364=+$P($G(IBDAX(IBDAX)),U,5)
 . D PRINT1^IBCEM03(IBIFN,.IBDAX,IB364)
 D PBILL1^IBCECOB2(IBIFN)
PB1 ;
 S VALMBCK="R"
 Q
 ;
CANCEL ;Cancel bill
 N IBIFN,IB364,IBX,IBA,MRACHK
 ; IBX,IBA will be killed during execution - need to protect them
 D FULL^VALM1
 S IBDAX=$O(IBDAX(0)),IBIFN=+$G(IBDAX(+IBDAX))
 ; Check for security key
 I '$$KCHK^XUSRB("IB AUTHORIZE") D  G CANCELQ
 . W !!?5,"You don't hold the proper security key to access this function."
 . W !?5,"The necessary key is IB AUTHORIZE.  Please see your manager."
 . D PAUSE^VALM1
 . Q
 D MRACHK I MRACHK G CANCELQ
 S IB364=+$P($G(IBDAX(IBDAX)),U,5)
 D CANCEL^IBCEM3(.IBDAX,IBIFN,IB364)
CANCELQ S VALMBCK="R"
 Q
 ;
CRD ; enter here if correcting a bill
 N IBCNCRD
 S IBCNCRD=1
CLONE ;'Copy/cancel bill' protocol action
 N IBX,IBA,IB364,MRACHK,IBIFN,IBKEY
 ; IBX,IBA will be killed during execution - need to protect them
 D FULL^VALM1
 S IBDAX=$O(IBDAX("")),IBIFN=+$P($G(IBDAX(IBDAX)),U)
 I IBDAX="" G CLONEQ
 ; Check for security key
 S IBKEY=$S($G(IBCNCRD)=1:"IB AUTHORIZE",1:"IB CLON")
 ;I '$$KCHK^XUSRB("IB AUTHORIZE") D  G CLONEQ
 I '$$KCHK^XUSRB(IBKEY) D  G CLONEQ
 . ;W !!?5,"You don't hold the proper security key to access this function."
 . ;W !?5,"The necessary key is IB AUTHORIZE.  Please see your manager."
 . W !!?5,"You must hold the "_IBKEY_" security key to access this function."
 . W !?5,"Please see your manager."
 . D PAUSE^VALM1
 . Q
 D MRACHK I MRACHK G CLONEQ
 S IB364=+$P($G(IBDAX(IBDAX)),U,5)
 D COPYCLON^IBCECOB2(+$G(IBDAX(IBDAX)),IB364,.IBDAX)
CLONEQ S VALMBCK="R"
 Q
 ;
PRO ; Copy for secondary/tertiary bill
 N IBIFNH,IBIFN,IB364,IBX,IBA,Z,IBCBASK,IBCBCOPY,IBCAN
 D FULL^VALM1
 ;IBDAX - array from selection of message
 S IBA=$G(IBDAX(+$G(IBDAX)))
 G:'IBA PROQ
 S IBX=$G(^TMP("IBCECSB",$J,$P(IBA,U,3),$P(IBA,U,4),$P(IBA,U,6),$P(IBA,U,2))),IBIFN=$P(IBA,U)
 S IB364=+$P(IBA,U,5)
 G:'IBIFN PROQ
 ;
 I $P($G(^DGCR(399,IBIFN,0)),U,13)=2 D  G PROQ
 . W !!?4,"This bill is in a status of REQUEST MRA."
 . I $$CHK^IBCEMU1(IBIFN) W !?4,"MRA EOBs must be processed from the MRA management worklist."
 . E  W !?4,"There are no MRA EOBs on file."
 . D PAUSE^VALM1
 . Q
 ;
 D COBCOPY^IBCECOB2(IBIFN,IB364,1,$P(IBA,U,2),"INIT^IBCECSA2")
PROQ S VALMBCK="R"
 Q
 ;
RES ;Resubmit bill by print
 N IBTMP,IB364,IBIFN,IBX,IBA
 D FULL^VALM1
 S (IBTMP,IBDAX)=$O(IBDAX(0)),IBTMP(IBTMP)=IBDAX(IBDAX)
 S IBIFN=$P($G(IBDAX(+IBDAX)),U)
 S IB364=+$P($G(IBDAX(IBDAX)),U,5)
 I IBIFN D PRINT1^IBCEM03(IBIFN,.IBDAX,IB364),PAUSE^VALM1,INIT^IBCECSA2
 S IBDAX(IBTMP)=IBTMP(IBTMP)
 S VALMBCK="R"
 Q
 ;
EBI ;Edit bill
 N IBFLG,IBIFN,IB364,IBX,IBA
 K ^TMP($J,"IBBILL")
 D FULL^VALM1
 S IBDAX=$O(IBDAX(""))
 I IBDAX="" G EDITQ
 S IBIFN=$P(IBDAX(IBDAX),U)
 S IBFLG=1 D  I IBFLG S IBDAX="" D PAUSE^VALM1 G EDITQ
 . I $P($G(^DGCR(399,IBIFN,0)),U,13)>2 W !,*7,"An authorized bill can not be edited." Q
 . I '$D(^XUSEC("IB EDIT",DUZ)) W !,*7,"You are not authorized to edit a bill" Q
 . S IBFLG=0
 S IBIFN=+$G(IBDAX(IBDAX))
 S IB364=+$P($G(IBDAX(IBDAX)),U,5)
 D EBILL^IBCEM3(.IBDAX,IBIFN,IB364)
EDITQ S VALMBCK="R"
 Q
 ;
SEL(IBDA,ONE) ; Select entry(s) from list
 ; IBDA = array returned if selections made
 ;    IBDAX(n)=ien of bill selected (file 399)
 ; ONE = if set to 1, only one selection can be made at a time
 N IB
 K IBDA
 D EN^VALM2($G(XQORNOD(0)),$S('$G(ONE):"",1:"S"))
 S IBDA=0 F  S IBDA=$O(VALMY(IBDA)) Q:'IBDA  D
 . S IBDA(IBDA)=$P($G(^TMP("IBCECSA",$J,IBDA)),U,2,7)
 Q
 ;
RESUB(IBIFN,TXMT,IBFUNC,IBTBA) ; Function asks if resubmit as resolution to a
 ;   message is the intention
 ; IBIFN = ien of bill in file 399
 ; TXMT = flag if = 1, assume it's transmittable, don't have to check
 ; IBFUNC = code to say where the code is called from
 ;  'E'=edit/authorize  'P'=print 'PX'= print/not to resubmit  'C'=cancel
 ; IBTBA = transmit bill array returned to calling routine.  Optional
 ;    parameter to be passed by reference.
 ;    IBTBA(364ptr)=""
 ;
 ; Returns:
 ; -1 = ^ or timeout at prompt
 ;  0 = not a transmittable bill or review not needed
 ;  1 = don't update the review status (user choice)
 ;  2 = Yes, update the review status (user choice), or resubmit by print
 ;
 NEW DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,STAT
 KILL IBTBA
 I '$G(TXMT),'$$TXMT^IBCEF4(IBIFN) S Y=0 G RESUB1   ; not transmittable
 ;
 ; Check for any messages or EOB's needing review
 S STAT=$$STATUS^IBCEF4(IBIFN)
 I '$TR(STAT,U) S Y=0 G RESUB1                ; no unreviewed items
 I $P(STAT,U,1) S IBTBA($P(STAT,U,1))=""      ; 364 ien for 361 data
 I $P(STAT,U,2) S IBTBA($P(STAT,U,2))=""      ; 364 ien for 361.1 data
 ;
 I IBFUNC'="P" D
 . S DIR(0)="YA",DIR("A",1)="",DIR("A",2)="This bill is in need of review due to receipt of a status msg or EOB",DIR("A")="OK to update the review status to 'REVIEW COMPLETE' based on this action?: ",DIR("B")="NO"
 . S DIR("?",1)="You have just "_$S(IBFUNC="E":"requested re-transmission of",IBFUNC="C":"cancelled",1:"")_" the bill"
 . S DIR("?",2)="You can update the review status of the unreviewed message to ",DIR("?",3)=" 'REVIEW COMPLETE' if you say YES here"
 . S DIR("?")="Press ENTER to continue "
 . D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT) S Y=-1 Q
 . S Y=Y+1
 E  D
 . W !,"The review status of this message will be updated to 'REVIEW COMPLETE'",!,"  based on this action"
 . S Y=2
 ;
RESUB1 Q +Y
 ;
RETXMT ;
 N IB364,IBIFN
 D FULL^VALM1
 S IBDAX=$O(IBDAX(0)),IB364=+$P($G(IBDAX(IBDAX)),U,5),IBIFN=+$P($G(IBDAX(IBDAX)),U)
 I 'IB364!('IBIFN) G RETXMTQ
 D MRACHK I MRACHK G RETXMTQ
 D RESUB^IBCE(IB364)
RETXMTQ S VALMBCK="R"
 Q
 ;
MRACHK ; Restrict access to process REQUEST MRA claims
 S MRACHK=0
 ; At least one MRA EOB appears on the MRA management worklist
 I $P($G(^DGCR(399,IBIFN,0)),U,13)=2,$$MRAWL^IBCEMU2(IBIFN) S MRACHK=1 D  D PAUSE^VALM1
 . W !,?4,"This bill is in a status of REQUEST MRA and it does appear on"
 . W !,?4,"the MRA Management Worklist.  Please use the MRA Management Menu"
 . W !,?4,"options for all processing related to this bill."
 Q

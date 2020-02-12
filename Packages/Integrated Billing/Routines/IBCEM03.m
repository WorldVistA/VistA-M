IBCEM03 ;ALB/TMP - 837 EDI RESUBMIT INDIVIDUAL BILL PROCESSING ;17-SEP-96
 ;;2.0;INTEGRATED BILLING;**137,199,296,348,349,592,623**;21-MAR-94;Build 70
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
BILL2 ; Resubmit a transmitted bill with a new batch #
 N DIC,DIR,DIE,DA,DR,IB,IB0,IBDA,IBDA1,IBE,IBSTAT,IBBDA,IBOK,IBNEW,Y,ZTSK,IBTEST
 K ^TMP("IBEDI_TEST_BATCH",$J)
 ;
 S DIR("A")="ARE YOU RESUBMITTING CLAIMS FOR TESTING?: ",DIR("B")="NO",DIR(0)="YA" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) Q
 I +Y S ^TMP("IBEDI_TEST_BATCH",$J)=1
ASK N DPTNOFZY S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 S IBTEST=+$G(^TMP("IBEDI_TEST_BATCH",$J))
 ; Only auth or printed transmittable bill valid for non-test
 ; All previously transmitted valid for test
 S DIC="^DGCR(399,",DIC(0)="AEMQ",DIC("S")=$S('IBTEST:"I $P($G(^(""TX"")),U,2),$P($G(^(0)),U,13)'="""",""234""[$P($G(^(0)),U,13)",1:"I $O(^IBA(364,""B"",+Y,0))")
 I IBTEST S DIC("A")="Select BILL/CLAIMS BILL NUMBER (FOR RESUBMIT AS TEST): "
 D ^DIC K DIC
 I Y<0 D  Q
 . Q:'IBTEST
 . I $O(^TMP("IBEDI_TEST_BATCH",$J,0)) D
 .. M ^TMP("IBRESUBMIT",$J)=^TMP("IBEDI_TEST_BATCH",$J)
 .. D ONE^IBCE837
 . ;
 . K ^TMP("IBEDI_TEST_BATCH",$J),^TMP("IBRESUBMIT",$J)
 ;
 S IBIFN=+Y,IBDA=+$$LAST364^IBCEF4(IBIFN),IB0=$G(^IBA(364,IBDA,0)),IBSTAT=$P(IB0,U,3)
 ;
 I IB0="" W !,"Bill does not exist in BILL TRANSMISSION file" G ASK
 I IBTEST,$D(^TMP("IBEDI_TEST_BATCH",$J,IBDA)) W !,"Bill already selected for test transmission" G ASK
 I $$COBN^IBCEF(IBIFN)=1,IBTEST S IBOK=1 D  G:'IBOK ASK
 . S DIR("A")="BILL IS A PRIMARY BILL, ARE YOU SURE YOU WANT TO SEND IT AS A TEST CLAIM?: "
 . S DIR("B")="NO",DIR(0)="YA" W ! D ^DIR K DIR
 . I Y'=1 S IBOK=0
 ;
 I 'IBTEST,IBSTAT="X" W !,"Bill is currently awaiting extract - will be submitted with next batch run" G ASK
 S IBBDA=+$P(IB0,U,2),IB=$P($G(^IBA(364.1,IBBDA,0)),U,9)
 ;
 I IB,'IBTEST D  G:'IBOK ASK
 . S IBOK=1,ZTSK=IB D STAT^%ZTLOAD
 . I ZTSK(0)=0 S DIE="^IBA(364.1,",DA=IBBDA,DR=".09///@" D ^DIE Q  ;Task not scheduled - delete task #
 . I "125"[ZTSK(1) W *7,!,"Cannot resubmit this bill.",!,"This bill's current batch is already ",$S("2"[ZTSK(1):"being resubmitted",1:"scheduled for resubmission")," - Task # is: ",IB,! S IBOK=0
 ;
 W !
 S DIR("A",1)="   Previously In Batch #: "_$$EXPAND^IBTRE(364,.02,$P(IB0,U,2))
 S DIR("A",2)="Bill Transmission Status: "_$$EXPAND^IBTRE(364,.03,IBSTAT)
 S DIR("A",3)="             Status Date: "_$$FMTE^XLFDT($P(IB0,U,4),2)
 S DIR("A",5)=" "
 S DIR("A",4)="     Current Bill Status: "_$$EXPAND^IBTRE(399,.13,$P($G(^DGCR(399,+IBIFN,0)),U,13))
 I 'IBTEST,IBSTAT'="P" S DIR("A",11)="WARNING - BILL TRANSMITTED PREVIOUSLY" S:IBSTAT?1"A".E DIR("A",11)=DIR("A",11)_" & CONFIRMED AS RECEIVED BY "_$P("AUSTIN^GENTRAN^INTERMEDIARY^CARRIER",U,$TR(IBSTAT,"A")+1)
 S DIR("A")="ARE YOU SURE YOU WANT TO RESUBMIT THIS BILL"_$S('IBTEST:"",1:" AS A TEST CLAIM")_"?: "
 S DIR(0)="YA",DIR("B")="NO"
 D ^DIR K DIR
 ;
 W ! G:'Y ASK
 ;
 I IBTEST S ^TMP("IBEDI_TEST_BATCH",$J,IBDA)="" G ASK
 ;
 S IBDA1=+$$ADDTBILL^IBCB1(IBIFN) ;Add a new transmit bill record
 ;
 S Y=$$TX1^IBCB1(IBDA1,1)
 ;
 I 'Y D  G ASK
 . W !,*7,"An error has occurred ... bill NOT re-submitted!!"
 . S DIK="^IBA(364,",DA=IBDA1 D:DA ^DIK
 . L -^IBA(364,IBDA)
 ;
 S IBNEW=$P($G(^IBA(364,+IBDA1,0)),U,2)
 ;
 ;Update the old transmit bill record
 D UPDEDI^IBCEM(IBDA,"R")
 ;
 W !,"Bill # ",$P($G(^DGCR(399,+IB0,0)),U)," was re-submitted in batch # ",$P($G(^IBA(364.1,+IBNEW,0)),U)
 ;
 L -^IBA(364,IBDA)
 G ASK
 ;
PRINT1(IBIFN,IBDA,IB364,IBRESUB) ; Print bill, submit manually as resolution
 ; for a returned message
 ; IBIFN = ien of bill in file 399
 ; IBDA = array returned from selection of message
 ; IB364 = ien of transmit bill entry in file 364
 ; IBRESUB = flag to indicate if bill is being resubmitted via print
 ;
 N IBAC,IBV,IB399,DFN,ZTSK,PRCASV,IBHOLD,IBTXPRT
 W !
 I IBIFN="" S IBDA="" G PRINT1Q
 S IB399=$G(^DGCR(399,IBIFN,0))
 I "34"'[$P(IB399,U,13) W !,*7,"Bill status must be AUTHORIZED or PRNT/TX to print the bill" S IBDA="" G PRINT1Q
 ;
 I $P($G(^DGCR(399,IBIFN,"S")),U,14)=DT W !,*7,"This bill was last printed today.  You must wait at least 1 day from the last",!,"print date to print this bill using this function." S IBDA="" D PAUSE^VALM1 G PRINT1Q
 ;
 S IBV=1,IBAC=4,DFN=$P(IB399,U,2),IBTXPRT=0
 M IBHOLD("IBDA")=IBDA
 D 4^IBCB1,ENS^%ZISS
 M IBDA=IBHOLD("IBDA")
 ;
 I 'IBTXPRT W !,"Bill was not printed" S IBDA="" G PRINT1Q
 ;
 D UPDEDI^IBCEM(IB364,"P")
 ;
PRINT1Q Q
 ;
SUB1 ; Select bills in ready for extract status to transmit individually
 N IB0,IB399,IBDA,IBIFN,IBSEL,IBU,X,Y,DA,DIC,Z,DIR
 K ^TMP("IBSELX",$J)
 ;
 S IBSEL=""
 F  D  Q:'IBSEL
 . S DIR("S")="I $P(^(0),U,3)=""X"""
 . S DIR(0)="PAO^364:AEMQ",DIR("A")="SELECT "_$S($D(^TMP("IBSELX",$J)):"NEXT ",1:"")_"BILL TO TRANSMIT: "
 . S DIR("?")="ONLY BILLS IN 'READY FOR EXTRACT' STATUS CAN BE TRANSMITTED WITH THIS OPTION"
 . D ^DIR K DIR
 . I Y'>0 K:Y=U ^TMP("IBSELX",$J) S IBSEL="" Q
 . S IBSEL=+Y
 . S IBDA=+Y,IB0=$G(^IBA(364,IBDA,0)),IBIFN=+IB0,IBU=$G(^DGCR(399,IBIFN,"U")),IB399=$G(^(0))
 . S Z=+$$NEEDMRA^IBEFUNC(IBIFN)
 . I '$$TXMT^IBCEF4(IBIFN,.IBNOTX),IBNOTX=2 D  Q
 .. W !,$S(Z:"MRA",1:"EDI")_" TRANSMISSION PARAMETER HAS BEEN TURNED OFF",!!,"BILL CANNOT BE SELECTED"
 . ;
 . W !
 . ;JWS;IB*2.0*592; added form #7 J430D to display
 . S DIR("A",1)="      YOU HAVE SELECTED BILL #: "_$P(IB399,U)_"  ("_$S($$INPAT^IBCEF(IBIFN):"INPATIENT",1:"OUTPATIENT")_"/"_$S($$FT^IBCEF(IBIFN)=3:"UB-04",$$FT^IBCEF(IBIFN)=7:"J430D",1:"CMS-1500")_" FORMAT)"
 . S DIR("A",2)="                  PATIENT NAME: "_$E($P($G(^DPT(+$P(IB399,U,2),0)),U)_$J("",28),1,28)_"  SSN: "_$P($G(^DPT(+$P(IB399,U,2),0)),U,9)
 . S DIR("A",3)="                  CARE DATE(S): "_$$EXPAND^IBTRE(399,151,$P(IBU,U))_" - "_$$EXPAND^IBTRE(399,152,$P(IBU,U,2))
 . S DIR("A",4)="'READY TO EXTRACT' STATUS DATE: "_$$EXPAND^IBTRE(364,.04,$P(IB0,U,4))
 . S DIR("?",1)=" "
 . S DIR("A",5)=" ",DIR("?")="IF THIS IS THE BILL YOU WANT TO TRANSMIT, RESPOND YES, OTHERWISE, RESPOND NO"
 . S DIR("A")="ARE YOU SURE THIS IS THE CORRECT BILL TO TRANSMIT?: "
 . S DIR(0)="YAO",DIR("B")="NO" D ^DIR K DIR W !
 . I Y'=1 W !,"BILL NOT SELECTED" Q
 . ;
 . S ^TMP("IBSELX",$J,IBDA)=""
 ;
 I '$O(^TMP("IBSELX",$J,0)) G SUB1Q
 ;
 W !,"Bills to be transmitted: "
 S Z=0 F  S Z=$O(^TMP("IBSELX",$J,Z)) Q:'Z  W !,?8,$P($G(^DGCR(399,+$G(^IBA(364,Z,0)),0)),U)
 W !
 S DIR("A")="OK TO TRANSMIT NOW?: ",DIR(0)="YA0",DIR("B")="NO" D ^DIR K DIR
 G:Y'=1 SUB1Q
 W !
 S ^TMP("IBSELX",$J)=0
 D ONE^IBCE837
 ;JWS;IB*2.0*623;if 837 FHIR enabled, display appropriate message
 I $$GET1^DIQ(350.9,"1,",8.21,"I") D  G SUB1Q
 . W !,"BILL(s) placed onto 837 FHIR Transaction list. They will be submitted shortly..."
 W !,"BILL(s) TRANSMITTED ... BATCH #(s): "
 S Z=0 F  S Z=$O(^TMP("IBCE-BATCH",$J,Z)) Q:'Z  W Z,$S($O(^(Z)):", ",1:"")
 I '$O(^TMP("IBCE-BATCH",$J,0)) W !,"NO BILL(S) TRANSMITTED - CHECK ALERTS/MAIL FOR DETAILS"
 ;
SUB1Q D PAUSE^VALM1
 K ^TMP("IBSELX",$J),^TMP("IBCE-BATCH",$J)
 Q
 ;

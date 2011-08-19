IBCEPTC3 ;ALB/ESG - EDI PREVIOUSLY TRANSMITTED CLAIMS ACTIONS ;12/19/05
 ;;2.0;INTEGRATED BILLING;**320**;21-MAR-94
 ;
 Q
 ;
SELECT ; Select claims to resubmit
 N IBIFN,IBZ,IBI,IBQ,DIR,VALMY,X,Y
 D FULL^VALM1
 D EN^VALM2($G(XQORNOD(0)))
 S IBZ=0 F  S IBZ=$O(VALMY(IBZ)) Q:'IBZ  D
 . S IBQ=$G(^TMP("IB_PREV_CLAIM_LIST_DX",$J,IBZ)),IBI=+$P(IBQ,U,2),IBQ=+IBQ
 . S IBIFN=+$G(^IBA(364,IBI,0))
 . Q:'IBIFN
 . D MARK(IBIFN,IBZ,IBQ,IBI,1,.VALMHDR)
 S VALMBCK="R"
 Q
 ;
SELBATCH ; Select a batch to resubmit
 ; Assumes IBSORT is defined
 N DIC,DIR,X,Y,Z,IBQ,IBZ,IBI,IBDX,IBASK,IBOK,IBY,DTOUT,DUOUT
 D FULL^VALM1
 I IBSORT'=1 D  G SELBQ
 . S DIR(0)="EA",DIR("A",1)="This action is not available unless you chose to sort by batch",DIR("A")="Press return to continue: "
 . W ! D ^DIR K DIR
 S DIC="^IBA(364.1,",DIC(0)="AEMQ",DIC("S")="I $D(^TMP(""IB_PREV_CLAIM_BATCH"",$J,+Y))"
 D ^DIC K DIC
 I Y'>0 G SELBQ
 S IBY=+Y,VALMBG=+$G(^TMP("IB_PREV_CLAIM_BATCH",$J,IBY))
 ;
 S (IBOK,IBASK)=1
 I $G(^TMP("IB_PREV_CLAIM_BATCH",$J,IBY,"SEL")) D  G:'IBOK SELBQ
 . S DIR(0)="YA",DIR("A",1)="This batch was previously selected.",DIR("A")="Do you want to de-select all claims in this batch?: ",DIR("B")="No"
 . W ! D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT) S IBOK=0 Q
 . I Y S IBASK=0 K ^TMP("IB_PREV_CLAIM_BATCH",$J,IBY,"SEL")
 ;
 S IBQ=0      ; last screen row# for claim
 F  S IBQ=$O(^TMP("IB_PREV_CLAIM_BATCH",$J,IBY,IBQ)) Q:'IBQ  D
 . S IBZ=$G(^(IBQ))      ; IBIFN^selection#
 . S Z=$P(IBZ,U,2)       ; selection#
 . S IBDX=$G(^TMP("IB_PREV_CLAIM_LIST_DX",$J,+Z))   ; 1st screen row# for claim^364 ien
 . S IBI=$P(IBDX,U,2)    ; 364 ien
 . D MARK(+IBZ,Z,+IBDX,IBI,IBASK,.VALMHDR)
 ;
 I IBASK S ^TMP("IB_PREV_CLAIM_BATCH",$J,IBY,"SEL")=1
 ;
SELBQ S VALMBCK="R"
 Q
 ;
MARK(IBIFN,IBZ,IBQ,IBI,IBASK,VALMHDR) ; Mark claim as selected for resubmit
 ; Returns VALMHDR killed if any selections/de-selections made
 N DIR,X,Y
 I $D(^TMP("IB_PREV_CLAIM_SELECT",$J,IBIFN)) D  Q
 . S Y=1
 . I IBASK D
 .. S DIR(0)="YA",DIR("B")="No",DIR("A",1)="Claim "_$P($G(^DGCR(399,IBIFN,0)),U)_" for entry # "_IBZ_" has already been selected",DIR("A")="Do you want to de-select it?: " W ! D ^DIR K DIR
 . I Y=1 K ^TMP("IB_PREV_CLAIM_SELECT",$J,IBIFN) S $E(^TMP("IB_PREV_CLAIM_LIST",$J,IBQ,0),6)=" ",^TMP("IB_PREV_CLAIM_SELECT",$J)=^TMP("IB_PREV_CLAIM_SELECT",$J)-1 K VALMHDR
 ;
 S ^TMP("IB_PREV_CLAIM_SELECT",$J,IBIFN)=IBQ,^TMP("IB_PREV_CLAIM_SELECT",$J,IBIFN,0)=IBI,^TMP("IB_PREV_CLAIM_SELECT",$J)=$G(^TMP("IB_PREV_CLAIM_SELECT",$J))+1
 S $E(^TMP("IB_PREV_CLAIM_LIST",$J,IBQ,0),6)="*" K VALMHDR
 Q
 ;
VIEW ; View claims selected
 N IBCT,IBQUIT,DIR,X,Y,Z,Z0
 D FULL^VALM1
 I '$O(^TMP("IB_PREV_CLAIM_SELECT",$J,0)) D  G VIEWQ
 . S DIR(0)="EA",DIR("A")="No claims have been selected - Press return to continue " D ^DIR K DIR
 W @IOF
 S (IBQUIT,IBCT)=0
 W !,+^TMP("IB_PREV_CLAIM_SELECT",$J)," claims selected:"
 S Z="" F  S Z=$O(^TMP("IB_PREV_CLAIM_SELECT",$J,Z)) Q:'Z  S Z0=+$G(^(Z)) D
 . Q:'$D(^TMP("IB_PREV_CLAIM_LIST",$J,Z0,0))
 . S IBCT=IBCT+1
 . I '(IBCT#15) S IBQUIT=0 D  Q:IBQUIT
 .. S DIR(0)="E" D ^DIR K DIR
 .. I 'Y S IBQUIT=1
 . W !,"  ",$E(^TMP("IB_PREV_CLAIM_LIST",$J,Z0,0),7,47)
 ;
 G:IBQUIT VIEWQ
 S DIR(0)="E" D ^DIR K DIR
 ;
VIEWQ S VALMBCK="R"
 Q
 ;
RESUB ; Resubmit selected claims
 N DIR,X,Y,IBIFN,IB364,Z1,IBTYPPTC,DIRUT,DIROUT,DTOUT,DUOUT,IBFSKIP,IBABORT
 D FULL^VALM1
 I '$O(^TMP("IB_PREV_CLAIM_SELECT",$J,0)) D  G RESUBQ
 . N DIR,X,Y
 . S DIR(0)="EA",DIR("A")="No claims have been selected - Press return to continue " D ^DIR K DIR
 ;
 ; Ask user if resubmit as production or as test
 S DIR(0)="SA^P:Production;T:Test Only"
 S DIR("A")="Resubmit Claims: "
 S DIR("B")="Production"
 S DIR("?",1)="  Select Production to resubmit the claims to the payer for payment."
 S DIR("?")="  Select Test to resubmit the claims as Test claims only."
 W ! D ^DIR K DIR
 I $D(DIRUT) G RESUBQ
 S IBTYPPTC="TEST"
 I Y="P" S IBTYPPTC="PRODUCTION"
 ;
 S DIR(0)="YA",DIR("B")="No"
 S DIR("A",1)="You are about to resubmit "_+^TMP("IB_PREV_CLAIM_SELECT",$J)_" claims as "_IBTYPPTC_" claims."
 S DIR("A")="Are you sure you want to continue?: "
 W ! D ^DIR K DIR
 I Y'=1 G RESUBQ
 ;
 ; OK to proceed and resubmit
 W !!,"Resubmission in process ... "
 ;
 ; loop thru selected claims and set into scratch globals
 S IBFSKIP=0
 KILL ^TMP("IBRCBOLD",$J)
 S IBIFN=0 F  S IBIFN=$O(^TMP("IB_PREV_CLAIM_SELECT",$J,IBIFN)) Q:'IBIFN  S Z1=+$G(^(IBIFN)),IB364=+$G(^(IBIFN,0)) I IB364 D
 . ;
 . I IBTYPPTC="TEST" D
 .. S ^TMP("IBEDI_TEST_BATCH",$J,IB364)=""
 .. S ^TMP("IBRESUBMIT",$J,IB364)=""
 .. I Z1 D MARK(IBIFN,"",Z1,IB364,0,.VALMHDR)
 .. Q
 . ;
 . I IBTYPPTC="PRODUCTION" D
 .. I '$$TXOK(IBIFN) S IBFSKIP=IBFSKIP+1 Q    ; transmission not allowed
 .. N Y S Y=$$ADDTBILL^IBCB1(IBIFN)  ; new entry in file 364 - "X" status
 .. I '$P(Y,U,3) Q                   ; quit if new entry didn't get added
 .. S ^TMP("IBSELX",$J,+Y)=""
 .. S ^TMP("IBRCBOLD",$J,IB364)=""   ; save list of old transmit bills
 .. I Z1 D MARK(IBIFN,"",Z1,IB364,0,.VALMHDR)
 .. Q
 . ;
 . Q
 ;
 ; set top level of scratch globals based on test or production
 I IBTYPPTC="TEST" S ^TMP("IBRESUBMIT",$J)="^^0^1",^TMP("IBEDI_TEST_BATCH",$J)=1
 E  KILL ^TMP("IBRESUBMIT",$J),^TMP("IBEDI_TEST_BATCH",$J),^TMP("IBONE",$J) S ^TMP("IBSELX",$J)=0
 ;
 ; resubmit call
 D EN1^IBCE837B("","","",.IBABORT)
 ;
 ; if user aborted at the last minute, then get rid of the new entries
 ; in file 364 that were added for production claim sending
 I IBABORT D
 . N IB,DIK,DA
 . S IB=0 F  S IB=$O(^TMP("IBSELX",$J,IB)) Q:'IB  S DIK="^IBA(364,",DA=IB D ^DIK
 . Q
 ;
 ; update EDI files for the old transmit bills
 I 'IBABORT D
 . N IB
 . S IB=0 F  S IB=$O(^TMP("IBRCBOLD",$J,IB)) Q:'IB  D UPDEDI^IBCEM(IB,"R")
 . Q
 ;
 ; cleanup
 K ^TMP("IBEDI_TEST_BATCH",$J),^TMP("IBRESUBMIT",$J),^TMP("IBSELX",$J),^TMP("IBRCBOLD",$J)
 I '$O(^TMP("IB_PREV_CLAIM_SELECT",$J,0)) K ^TMP("IB_PREV_CLAIM_SELECT",$J)
 S DIR(0)="EA"
 S DIR("A",1)="Selected claims have been resubmitted as "_IBTYPPTC_"."
 I IBFSKIP D
 . S DIR("A",2)="Please note: Some claims were not eligible to be resubmitted as live claims."
 . S DIR("A",3)="             These claims are still indicated as being selected."
 . Q
 I IBABORT K DIR("A") S DIR("A",1)="No claims were resubmitted."
 S DIR("A")="Press return to continue "
 W ! D ^DIR K DIR
 K VALMHDR
 ;
RESUBQ ;
 S VALMBCK="R"
 Q
 ;
REPORT ; Print report
 ; Assumes IBSORT, IBDT1, IBDT2 defined
 N IBACT,Z
 D FULL^VALM1
 F  S IBACT=0 D DEVSEL^IBCEPTC(.IBACT) Q:IBACT 
 I IBACT'=99 D
 . N IBREP
 . S IBREP="R" D RPT^IBCEPTC1(IBSORT,IBDT1,IBDT2)
 ;
 D HOME^%ZIS
 S VALMBCK="R"
 Q
 ;
CKSENT(VALMBCK) ; Make sure selected entries are transmitted
 ;
 N IBOK,DIR,X,Y
 S IBOK=1
 I $O(^TMP("IB_PREV_CLAIM_SELECT",$J,0)) D
 . D FULL^VALM1
 . S DIR(0)="YA",DIR("A",1)="You have selected "_+$G(^TMP("IB_PREV_CLAIM_SELECT",$J))_" claims, but have not resubmitted them",DIR("A")="Are you sure you want to quit before you resubmit them?: ",DIR("B")="No"
 . W ! D ^DIR K DIR
 . I Y'=1 S VALMBCK="R",IBOK=0
 I IBOK S VALMBCK="Q"
 Q
 ;
TXOK(IBIFN) ; Function determines if claim is OK for live resubmission
 NEW OK,IB364,IBD,IBSTAT
 S OK=0
 I '$P($G(^DGCR(399,+$G(IBIFN),"TX")),U,2) G TXOKX                  ; last electronic extract date
 I '$F(".2.3.4.","."_$P($G(^DGCR(399,IBIFN,0)),U,13)_".") G TXOKX   ; claim status
 S IB364=+$$LAST364^IBCEF4(+$G(IBIFN)) I 'IB364 G TXOKX             ; transmit bill exists
 S IBD=$G(^IBA(364,IB364,0)) I IBD="" G TXOKX
 S IBSTAT=$P(IBD,U,3) I IBSTAT="X" G TXOKX                          ; already awaiting extract
 S OK=1
TXOKX ;
 Q OK
 ;

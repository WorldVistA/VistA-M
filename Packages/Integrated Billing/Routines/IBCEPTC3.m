IBCEPTC3 ;ALB/ESG - EDI PREVIOUSLY TRANSMITTED CLAIMS ACTIONS ;12/19/05
 ;;2.0;INTEGRATED BILLING;**320,547,608,641,650,665**;21-MAR-94;Build 28
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; IB*2.0*547 Variable IBLOC is pre-defined (in IBCEPTC)
 ; IB*2.0*608 (vd) provided the ability to identify those claims that are resubmitted
 ;                 and those that are skipped. (US2486)
 ; IB*2.0*665 added SELALL and removed the protocol that calls SELBATCH rendering it toothless
 Q
 ;
SELECT ; Select claims to resubmit
 N IBIFN,IBZ,IBI,IBQ,DIR,VALMY,X,Y
 D FULL^VALM1
 D EN^VALM2($G(XQORNOD(0)))
 S IBZ=0 F  S IBZ=$O(VALMY(IBZ)) Q:'IBZ  D
 . S IBQ=$G(^TMP("IB_PREV_CLAIM_LIST_DX",$J,IBZ)),IBI=+$P(IBQ,U,2),IBQ=+IBQ
 . S IBIFN=$S(IBLOC:IBI,1:+$G(^IBA(364,IBI,0)))
 . Q:'IBIFN
 . D MARK(IBIFN,IBZ,IBQ,IBI,1,.VALMHDR)
 S VALMBCK="R"
 Q
 ;
 ;WCJ;IB665;no changes to the tag but no longer call it - removed the protocol from the worklist since each claim is in its only batch
SELBATCH ; Select a batch to resubmit 
 ; Assumes IBSORT is defined
 N DIC,DIR,X,Y,Z,IBQ,IBZ,IBI,IBDX,IBASK,IBOK,IBY,DTOUT,DUOUT
 D FULL^VALM1
 ; IB*2.0*547 Do not allow batch resubmit of locally printed claims
 I IBLOC=1 D  G SELBQ
 . S DIR(0)="EA",DIR("A",1)="This action is not available for Locally Printed Claims",DIR("A")="Press return to continue: "
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
 ;WCJ;IB*2.0*665; new PROTOCOL and new tag to SELECT/DE SELECT ALL
SELALL ;
 N IBIFN,IBZ,IBI,IBQ,DIR,VALMY,X,Y,IBCNT,IBSTOP,IBSUCCESS
 ;
 ; check if any were already selected.  if so, allow to deselect all.
 S IBSTOP=0
 I $G(^TMP("IB_PREV_CLAIM_SELECT",$J)) D  Q:IBSTOP
 . S IBCNT=^TMP("IB_PREV_CLAIM_SELECT",$J)
 . S DIR(0)="YA",DIR("B")="Yes"
 . S DIR("A",1)=IBCNT_" claims were previously selected."
 . S DIR("A")="Deselect those "_IBCNT_"? "
 . I IBCNT=1 S DIR("A",1)=IBCNT_" claim was previously selected.",DIR("A")="Deselect the "_IBCNT_"? "
 . W ! D ^DIR K DIR
 . I Y'=1 Q  ; stop since they don't want to deselect all
 . S VALMBCK="R",IBSTOP=1
 . S IBZ=0 F IBCNT=0:1 S IBZ=$O(^TMP("IB_PREV_CLAIM_SELECT",$J,IBZ)) Q:'IBZ  D
 .. S IBQ=$G(^TMP("IB_PREV_CLAIM_SELECT",$J,IBZ))
 .. S IBI=$G(^TMP("IB_PREV_CLAIM_SELECT",$J,IBZ,0))
 .. S IBIFN=$S(IBLOC:IBI,1:+$G(^IBA(364,IBI,0)))
 .. I 'IBIFN S IBCNT=IBCNT-1 Q
 .. D MARK(IBIFN,IBZ,IBQ,IBI,0,.VALMHDR,2)
 .. Q
 . S DIR(0)="EA"
 . S DIR("A",1)=IBCNT_" claims were de-selected."
 . I IBCNT=1 S DIR("A",1)=IBCNT_" claim was de-selected."
 . S DIR("A")="Press return to continue "
 . W ! D ^DIR K DIR
 ;
 ; select all
 S IBZ=0 F IBCNT=0:1 S IBZ=$O(^TMP("IB_PREV_CLAIM_LIST_DX",$J,IBZ)) Q:'IBZ  D
 . S IBQ=$G(^TMP("IB_PREV_CLAIM_LIST_DX",$J,IBZ)),IBI=+$P(IBQ,U,2),IBQ=+IBQ
 . S IBIFN=$S(IBLOC:IBI,1:+$G(^IBA(364,IBI,0)))
 . I 'IBIFN S IBCNT=IBCNT-1 Q
 . Q:'IBIFN
 . D MARK(IBIFN,IBZ,IBQ,IBI,1,.VALMHDR,1,.IBSUCCESS)
 . I '$G(IBSUCCESS) S IBCNT=IBCNT-1 Q
 ;
 ; display how may were just selected
 S DIR(0)="EA"
 S DIR("A",1)=IBCNT_" claims were selected."
 I IBCNT=1 S DIR("A",1)=IBCNT_" claim was selected."
 S DIR("A")="Press return to continue "
 W ! D ^DIR K DIR
 S VALMBCK="R"
 Q
 ;
 ;WCJ;IB665;Added parameters IBSELALL and IBSUCCESS to be used by SELALL tag added above.
MARK(IBIFN,IBZ,IBQ,IBI,IBASK,VALMHDR,IBSELALL,IBSUCCESS) ; Mark claim as selected for resubmit
 ; IBSELALL 1=MARK 2=UNMARK - This parameter is set when calling from SELALL tag 
 ; IBSUCCESS return 1 if successfully marked/unmarked an individual record.  The calling tag needed to keep track of how many it marked or unmarked.
 ; Returns VALMHDR killed if any selections/de-selections made
 S IBSUCCESS=0
 N DIR,X,Y
 I $G(IBSELALL)'=1,$D(^TMP("IB_PREV_CLAIM_SELECT",$J,IBIFN)) D  Q
 . S Y=1
 . I IBASK D
 .. S DIR(0)="YA",DIR("B")="No"
 .. S DIR("A",1)="Claim "_$P($G(^DGCR(399,IBIFN,0)),U)_" for entry # "_IBZ_" has already been selected",DIR("A")="Do you want to de-select it?: "
 .. W ! D ^DIR K DIR
 . I Y=1 D
 .. K ^TMP("IB_PREV_CLAIM_SELECT",$J,IBIFN)
 .. S $E(^TMP("IB_PREV_CLAIM_LIST",$J,IBQ,0),6)=" ",^TMP("IB_PREV_CLAIM_SELECT",$J)=^TMP("IB_PREV_CLAIM_SELECT",$J)-1
 .. K VALMHDR S IBSUCCESS=1
 ;
 Q:$D(^TMP("IB_PREV_CLAIM_SELECT",$J,IBIFN))
 S ^TMP("IB_PREV_CLAIM_SELECT",$J,IBIFN)=IBQ,^TMP("IB_PREV_CLAIM_SELECT",$J,IBIFN,0)=IBI,^TMP("IB_PREV_CLAIM_SELECT",$J)=$G(^TMP("IB_PREV_CLAIM_SELECT",$J))+1
 S $E(^TMP("IB_PREV_CLAIM_LIST",$J,IBQ,0),6)="*" K VALMHDR
 S IBSUCCESS=1
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
 S Z="" F  S Z=$O(^TMP("IB_PREV_CLAIM_SELECT",$J,Z)) Q:'Z  S Z0=+$G(^(Z)) D  Q:IBQUIT
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
 N DIR,DIRCTR,DIRLN,DIROUT,DIRUT,DTOUT,DUOUT
 N IB364,IBABORT,IBCLMNO,IBIFN,IBSKCTR,IBFSKIP,IBRSBTST,IBTYPPTC
 N X,Y,Z1,IBC364
 ;/IB*2*608 - vd (US2486) - instituted the following variable to identify a claim as being resubmitted.
 S IBRSBTST=0
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
 ; IB*2.0*547  Only allow locally printed claims to resubmit as Test
 W ! I IBLOC'=1 D ^DIR K DIR
 I $D(DIRUT) G RESUBQ
 S IBTYPPTC="TEST"
 I IBLOC'=1,Y="P" S IBTYPPTC="PRODUCTION"
 ;/IB*2*608 (vd) - The following line indicates the claim is being resubmitted as a "TEST" Claim and should be handled
 ; special concerning the COB, OFFSET, PRIOR PAYMENTS calculations by the Output Formatter.  (US2486)
 I IBTYPPTC="TEST" S IBRSBTST=1
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
 K ^TMP("IBRCBOLD",$J)
 K ^TMP("IBSKIPPED",$J)   ;/IB*2*608 - vd
 S IBIFN=0 F  S IBIFN=$O(^TMP("IB_PREV_CLAIM_SELECT",$J,IBIFN)) Q:'IBIFN  S Z1=+$G(^(IBIFN)),IB364=+$G(^(IBIFN,0)) I IB364 D
 . ;
 . I IBTYPPTC="TEST" D
 .. ;JWS;IB*2.0*650v4;attempt to prevent duplicate - also for test claims
 .. S IBC364=$$LAST364^IBCEF4(IBIFN)
 .. I IB364'=IBC364,$P($G(^IBA(364,IBC364,0)),U,3)="X"!$D(^IBA(364,"AC",1,IBC364)) D  Q
 ... S IBCLMNO=$$GET1^DIQ(399,IBIFN,.01)
 ... S IBFSKIP=IBFSKIP+1
 ... S ^TMP("IBSKIPPED",$J,IBCLMNO)=IBIFN
 .. I $P($G(^IBA(364,IB364,0)),U,3)="X"!$D(^IBA(364,"AC",1,IB364)) D  Q
 ... S IBCLMNO=$$GET1^DIQ(399,IBIFN,.01)
 ... S IBFSKIP=IBFSKIP+1
 ... S ^TMP("IBSKIPPED",$J,IBCLMNO)=IBIFN
 .. S ^TMP("IBEDI_TEST_BATCH",$J,IB364)=""
 .. S ^TMP("IBRESUBMIT",$J,IB364)=""
 .. I Z1 D MARK(IBIFN,"",Z1,IB364,0,.VALMHDR)
 .. Q
 . ;
 . I IBTYPPTC="PRODUCTION" D
 .. ;/IB*2*680 (vd) - modified the following line for US2486 as shown below.
 .. ; I '$$TXOK(IBIFN) S IBFSKIP=IBFSKIP+1 Q    ; transmission not allowed
 .. I '$$TXOK(IBIFN) D  Q   ;transmission not allowed
 ... S IBCLMNO=$$GET1^DIQ(399,IBIFN,.01)
 ... S IBFSKIP=IBFSKIP+1
 ... S ^TMP("IBSKIPPED",$J,IBCLMNO)=IBIFN  ; /IB*2*608 (vd) - Added to identify those claims that are Skipped
 .. ;JWS;IB*2.0*641v7;add resubmission parameter to $$ADDTBILL call, 3rd parameter
 .. N Y S Y=$$ADDTBILL^IBCB1(IBIFN,"",1)  ; new entry in file 364 - "X" status
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
 D EN1^IBCE837B("","","",.IBABORT,$G(IBRSBTST)) ;/IB*2*608 (vd) - added the IBRSBTST parameter for US2486.
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
 . ;JWS;IB*2.0*650v4;changed message to be a little more generic
 . S DIR("A",2)="Please note: Some claims were not eligible to be resubmitted."  ;; as live claims."
 . S DIR("A",3)="The following are the claims that were skipped:"
 . ;;S DIR("A",2)="Please note: Some claims were not eligible to be resubmitted as live claims."
 . ;;S DIR("A",3)=" These claims are still indicated as being selected."
 . ;;S DIR("A",4)="The following are the claims that were skipped:"
 . S (DIRLN,IBCLMNO)="",IBSKCTR=0,DIRCTR=4
 . F  S IBCLMNO=$O(^TMP("IBSKIPPED",$J,IBCLMNO)) Q:IBCLMNO=""  D
 . . S IBSKCTR=IBSKCTR+1 ; Increment # of claims on the display line.
 . . I IBSKCTR>6 D     ; Want no more than 6 claim numbers displayed per display line.
 . . . S DIRCTR=DIRCTR+1,DIR("A",DIRCTR)=DIRLN   ; increment the DIR("A",...) display line and set the line.
 . . . S IBSKCTR=1,DIRLN=""   ; reset the line segment ctr and clear the display line.
 . . ;
 . . S DIRLN=DIRLN_" "_IBCLMNO   ; Append the claim # to the existing display line.
 . I +IBSKCTR S DIRCTR=DIRCTR+1,DIR("A",DIRCTR)=DIRLN
 . ;
 . Q
 K ^TMP("IBSKIPPED",$J) ;/IB*2*608 (vd) - delete the temporary list of skipped claims after reporting them.
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
 ;/IB*2*608 (vd) - added the following line for US2486.
 I $D(^IBM(361.1,"ABS",+$G(IBIFN),$$COBN^IBCEF(IBIFN))) G TXOKX  ; Not okay for claim w/EOB for this payer sequence
 ;
 I '$P($G(^DGCR(399,+$G(IBIFN),"TX")),U,2) G TXOKX                  ; last electronic extract date
 I '$F(".2.3.4.","."_$P($G(^DGCR(399,IBIFN,0)),U,13)_".") G TXOKX   ; claim status
 S IB364=+$$LAST364^IBCEF4(+$G(IBIFN)) I 'IB364 G TXOKX             ; transmit bill exists
 S IBD=$G(^IBA(364,IB364,0)) I IBD="" G TXOKX
 S IBSTAT=$P(IBD,U,3) I IBSTAT="X" G TXOKX                          ; already awaiting extract
 ;JWS;IB*2.0*650v4;attempt to prevent duplicates; if there is already a FHIR submission in process (attempt to eliminate duplicates)
 I $D(^IBA(364,"AC",1,IB364)) G TXOKX
 S OK=1
TXOKX ;
 Q OK
 ;

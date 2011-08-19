IBCEPTC0 ;ALB/ESG - EDI PREVIOUSLY TRANSMITTED CLAIMS CONT ; 12/19/05
 ;;2.0;INTEGRATED BILLING;**320,348**;21-MAR-94;Build 5
 ;
 Q
 ;
LIST ; Queued report format entrypoint
 ; variables pre-defined: IBREP,IBSORT,IBFORM,IBDT1,IBDT2,
 ;                        IBCRIT,IBPTCCAN,IBRCBFPC
 ;  ^TMP("IB_PREV_CLAIM_INS,$J) global
 K ^TMP("IB_PREV_CLAIM",$J)
 N IBBDA,IBBDA0,IBCURI,IBDA,IBDT,IBFT,IBIFN,IBS1,IBS2,IBDTX
 N INCLUDE,EDI,PROF,INST,IB0,IBZ1,DATA,IB364,CURSEQ,IBZ,IBZDAT
 I IBREP="R" N IBPAGE,IBSTOP,IBHDRDT S (IBPAGE,IBSTOP)=0
 ;
 ; evaluate claim transmission data from files 364.1 and 364
 S IBDT=IBDT1-.1
 F  S IBDT=$O(^IBA(364.1,"ALT",IBDT)) Q:'IBDT!((IBDT\1)>IBDT2)  S IBBDA=0 F  S IBBDA=$O(^IBA(364.1,"ALT",IBDT,IBBDA)) Q:'IBBDA  D
 . S IBDTX=IBDT\1
 . S IBDA=0 F  S IBDA=$O(^IBA(364,"C",IBBDA,IBDA)) Q:'IBDA  D
 .. D STORE(IBDA,IBBDA,IBDTX,$P($G(^IBA(364,IBDA,0)),U,7)+1)
 .. Q
 . Q
 ;
 ; evaluate the test transmissions from file 361.4 (SRS 3.2.10.3)
 S IBDT=IBDT1-.1
 F  S IBDT=$O(^IBM(361.4,"ALT",IBDT)) Q:'IBDT!(IBDT>IBDT2)  S IBIFN=0 F  S IBIFN=$O(^IBM(361.4,"ALT",IBDT,IBIFN)) Q:'IBIFN  S IBZ1=0 F  S IBZ1=$O(^IBM(361.4,IBIFN,1,IBZ1)) Q:'IBZ1  D
 . S DATA=$G(^IBM(361.4,IBIFN,1,IBZ1,0)) Q:DATA=""
 . S IBDTX=$P(DATA,U,1)\1    ; transmit date
 . Q:IBDTX<IBDT1             ;  too early
 . Q:IBDTX>IBDT2             ;  too late
 . S IBBDA=+$P(DATA,U,2)     ; batch ien
 . Q:'IBBDA
 . ;
 . ; attempt to find the corresponding entry in file 364 for this one
 . S IB364="",CURSEQ=$TR(+$P(DATA,U,4),"123","PST")
 . S IBZ=" " F  S IBZ=$O(^IBA(364,"B",IBIFN,IBZ),-1) Q:'IBZ  D  Q:IB364
 .. S IBZDAT=$G(^IBA(364,IBZ,0))
 .. I $P(IBZDAT,U,8)'=CURSEQ Q      ; no match on payer sequence
 .. I $F(".X.P.","."_$P(IBZDAT,U,3)_".") Q    ; transmission status must be farther than this
 .. S IB364=IBZ Q
 .. Q
 . ;
 . I 'IB364 Q      ; need to have an entry in file 364 to proceed
 . ;
 . D STORE(IB364,IBBDA,IBDTX,3)
 . Q
 ;
 I IBREP="R" D RPT^IBCEPTC1(IBSORT,IBDT1,IBDT2) G END  ; Output report
 ;
 D EN^VALM("IBCE VIEW PREV TRANS"_IBSORT) ; List Manager
 ;
END K ^TMP("IB_PREV_CLAIM",$J),^TMP("IB_PREV_CLAIM_INS",$J)
 Q
 ;
STORE(IB364,IBBDA,IBDTX,IBTYP) ; Check and store transmission data
 ; Parameters
 ; IB364 - ien to file 364 (claim transmission ien)
 ; IBBDA - ien to file 364.1 (batch ien)
 ; IBDTX - fm transmit date (no time) (either from 364.1 or 361.41)
 ; IBTYP - 1 = transmission data from file 364 (field .07 is live)
 ;         2 = transmission data from file 364 (field .07 is test)
 ;         3 = transmission data from file 361.41 (test always)
 ; Note:
 ; Variables IBFORM, IBCRIT, IBPTCCAN, IBRCBFPC, and IBSORT are
 ;     assumed to exist here in this procedure.
 ;
 NEW IBIFN,IB0,IBFT,IBCURI,INCLUDE,EDI,PROF,INST,IBBDA0,IBS1,IBS2
 ;
 S IBIFN=+$G(^IBA(364,IB364,0))
 S IB0=$G(^DGCR(399,IBIFN,0))
 S IBFT=$$FT^IBCEF(IBIFN)   ; form type of claim
 I IBFORM'="B",$S(IBFT=3:IBFORM="C",IBFT=2:IBFORM="U",1:1) G STOREX
 S IBCURI=$$CURR^IBCEF2(IBIFN) I 'IBCURI G STOREX   ; current ins ien
 S EDI=$$UP^XLFSTR($G(^DIC(36,IBCURI,3)))           ; 3 node EDI data
 S PROF=$P(EDI,U,2),INST=$P(EDI,U,4)                ; payer IDs
 ;
 ; screen for user selected insurance companies/payers
 I +$G(^TMP("IB_PREV_CLAIM_INS",$J)) D  I 'INCLUDE G STOREX
 . S INCLUDE=0
 . I $D(^TMP("IB_PREV_CLAIM_INS",$J,1,IBCURI)) S INCLUDE=1 Q
 . I '$D(^TMP("IB_PREV_CLAIM_INS",$J,2)) Q
 . I PROF'="",$D(^TMP("IB_PREV_CLAIM_INS",$J,2,PROF)) S INCLUDE=1 Q
 . I INST'="",$D(^TMP("IB_PREV_CLAIM_INS",$J,2,INST)) S INCLUDE=1 Q
 . Q
 ;
 I IBCRIT=1,'$$MRASEC^IBCEF4(IBIFN) G STOREX
 I IBCRIT=2,($$COBN^IBCEF(IBIFN)>1) G STOREX
 I IBCRIT=3,($$COBN^IBCEF(IBIFN)=1) G STOREX
 I IBCRIT=4,'$P($G(^DGCR(399,IBIFN,"TX")),U,7) G STOREX
 ;
 ; skip cancelled claims conditionally
 I $P(IB0,U,13)=7,'IBPTCCAN G STOREX
 ;
 ; skip claims forced to print at clearinghouse (claim check)
 I $P($G(^DGCR(399,IBIFN,"TX")),U,8)=2,'IBRCBFPC G STOREX
 ;
 ; skip claims forced to print at clearinghouse (payer check)
 I IBFT=2,PROF["PRNT",'IBRCBFPC G STOREX    ; 1500, prof payer ID
 I IBFT=3,INST["PRNT",'IBRCBFPC G STOREX    ;   ub, inst payer ID
 ;
 S IBBDA0=$G(^IBA(364.1,+IBBDA,0))             ; 0 node of batch
 ;
 S IBS1=$S(IBSORT=1:(99999999-IBDTX)_U_$P(IBBDA0,U)_U_$P(IBBDA0,U,14)_U_+$P(IBBDA0,U,5),1:$P($G(^DIC(36,+IBCURI,0)),U)_U_+IBCURI)
 S IBS2=$S(IBSORT=1:$P(IB0,U,1),1:99999999-IBDTX)
 ;
 ; Meets all selection criteria - extract to sort global
 S:IBS1="" IBS1=" " S:IBS2="" IBS2=" "
 I '$D(^TMP("IB_PREV_CLAIM",$J,IBS1)) S ^TMP("IB_PREV_CLAIM",$J,IBS1)=$S(IBSORT=1:$$FMTE^XLFDT(IBDTX,"1"),1:IBIFN)
 S ^TMP("IB_PREV_CLAIM",$J,IBS1,IBS2,IB364)=IBTYP
 ;
STOREX ;
 Q
 ;

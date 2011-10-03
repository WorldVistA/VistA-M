IBCEMSR ;WOIFO/AAT - MRA STATISTICS REPORT ;09/03/04
 ;;2.0;INTEGRATED BILLING;**155,288,294,349**;21-MAR-94;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ;
 N IBQ,IBDIV,IBBDT,IBEDT,IBSUM,IBSCR
 W !!,"Report requires 132 Columns"
 S IBQ=0 ; quit flag
 ; Prompts to the user:
 D DIV Q:IBQ  ; Division(s)
 D SUM Q:IBQ  ; Summary only?
 W !!,"Normal processing time for a MRA is 10-12 days.  If you select a date range of"
 W !,"less than 2 weeks, do not expect to have received many MRAs."
 D DTR Q:IBQ  ; From-To date range
 D DEVICE Q:IBQ
 D RUN
 Q
 ;
DIV N DIC,DIR,DIRUT,Y
 W ! S DIR("B")="ALL",DIR("A")="Run this report for All divisions or Selected Divisions: "
 S DIR(0)="SA^ALL:All divisions;S:Selected divisions" D ^DIR
 I $D(DIRUT) S IBQ=1 Q
 S IBDIV=Y Q:Y="ALL"
 ; Collect divisions
 F  D  Q:Y'>0
 . W ! S DIC("A")="Division: ",DIC=40.8,DIC(0)="AEQM" D ^DIC
 . I $D(DIRUT) S IBQ=1 Q
 . I Y'>0 Q
 . S IBDIV(+Y)=""
 I $O(IBDIV(""))=""  S IBQ=1 Q  ; None selected
 Q
 ;
DTR ;date range
 N %DT,Y
 S (IBBDT,IBEDT)=DT
 S %DT="AEX"
 S %DT("A")="Start with MRA Request Transmission Date: " ; No default,%DT("B")="TODAY"
 W ! D ^%DT K %DT
 I Y<0 S IBQ=1 Q
 S IBBDT=+Y
 S %DT="AEX"
 S %DT("A")="Go to MRA Request Transmission Date: ",%DT("B")="TODAY"
 D ^%DT K %DT
 I Y<0 S IBQ=1 Q
 S IBEDT=+Y
 Q
 ;
SUM N DIR,DIRUT,Y
 W ! S DIR("B")="YES",DIR("A")="Do you want to print a summary only? "
 S DIR(0)="YA" D ^DIR
 I $D(DIRUT) S IBQ=1 Q
 S IBSUM=+Y
 Q
 ;
DEVICE N %ZIS,IOP,ZTSK,ZTRTN,ZTIO,ZTDESC,ZTSAVE,POP
 K IO("Q")
 S %ZIS="QM"
 W ! D ^%ZIS
 I POP S IBQ=1 Q
 S IBSCR=$S($E($G(IOST),1,2)="C-":1,1:0)
 ;
 I $D(IO("Q")) D  S IBQ=1
 . S ZTRTN="RUN^IBCEMSR"
 . S ZTIO=ION
 . S ZTSAVE("IB*")=""
 . S ZTDESC="IB MRA STATISTICS REPORT"
 . D ^%ZTLOAD
 . W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 . D HOME^%ZIS
 U IO
 Q
 ;
 ;
RUN N REF
 S REF=$NA(^TMP($J,"IBCEMSR"))
 K @REF
 D COLLECT  ; Collect the data in ^TMP
 U IO
 D REPORT^IBCEMSR1
 I 'IBSCR W !,@IOF
 D ^%ZISC
 K @REF
 Q
 ;
COLLECT ; Collect Information
 ; Input: IBDIV, IBBDT,IBEDT
 N IBDT,IBBAT,IBTRAN,IBZ,MRAUSR,NUMDIV,IBDV,ALLDIV
 S IBDV=0 F NUMDIV=0:1 S IBDV=$O(IBDIV(IBDV)) Q:'IBDV
 S ALLDIV=" "
 I IBDIV="ALL" S ALLDIV="  *** ALL DIVISIONS ***"
 I NUMDIV>1 S ALLDIV="  *** ALL SELECTED DIVISIONS ***"
 ;
 S MRAUSR=$$MRAUSR^IBCEMU1() ;Auto-authorizer
 S IBDT=IBBDT-.000001
 F  S IBDT=$O(^IBA(364.1,"ALT",IBDT)) Q:'IBDT  Q:IBDT\1>IBEDT  D
 . S IBBAT=0 F  S IBBAT=$O(^IBA(364.1,"ALT",IBDT,IBBAT)) Q:'IBBAT  D
 .. S IBTRAN=0 F  S IBTRAN=$O(^IBA(364,"C",IBBAT,IBTRAN)) Q:'IBTRAN  D
 ... S IBZ=$G(^IBA(364,IBTRAN,0)) Q:IBZ=""
 ... N IBIFN,IBSTAT,IBSEQ,IBBILZ,IBBILST,IBFORM,IBCLERK,IBDV,IBDVN,REFX,REFS,REFT,REFTX,MRACNT,IBREJECT
 ... S IBIFN=+IBZ
 ... I '$P($G(^DGCR(399,IBIFN,"S")),U,7) Q  ; no MRA request
 ... S IBSTAT=$P(IBZ,U,3)
 ... S IBSEQ=$P(IBZ,U,8) Q:"T"[IBSEQ
 ... I '$$WNRBILL^IBEFUNC(IBIFN,IBSEQ) Q   ; payer sequence must be Medicare for this transmission
 ... S IBBILZ=$G(^DGCR(399,IBIFN,0))
 ... S IBBILST=$P(IBBILZ,U,13)
 ... S IBFORM=+$P(IBBILZ,U,19)
 ... I IBFORM'=2,IBFORM'=3 Q  ; not 1500 or UB
 ... S IBCLERK=+$P($G(^DGCR(399,IBIFN,"S")),U,8) ; Who requested MRA?
 ... S IBCLERK=$P($G(^VA(200,IBCLERK,0)),U)
 ... S:IBCLERK="" IBCLERK="UNKNOWN"
 ... S IBDV=+$P(IBBILZ,U,22) ; Default division
 ... S IBDVN=$P($G(^DG(40.8,IBDV,0)),U) ; Div name
 ... S:IBDVN="" IBDVN="UNKNOWN"
 ... I IBDIV'="ALL",'$D(IBDIV(IBDV)) Q  ;Division filter
 ... I 'IBSUM S REFX=$NA(@REF@(IBDVN,IBCLERK,IBFORM)) I NUMDIV'=1 S REFTX=$NA(@REF@(ALLDIV,IBCLERK,IBFORM))  ; all divisions detail
 ... S REFS=$NA(@REF@(IBDVN,0,IBFORM)) ; Summary by division
 ... I NUMDIV'=1 S REFT=$NA(@REF@(ALLDIV,0,IBFORM))  ; all divisions
 ... D TXSTS^IBCEMU2(IBIFN,IBTRAN,.IBREJECT) ; rejected?
 ... S MRACNT=$$MRACNT^IBCEMU1(IBIFN) ; how many MRAs?
 ... D INC("ALL") ; total no of requests
 ... I IBSTAT="C" D INC("ALLC") ;cancelled
 ... I IBSTAT="R" D INC("ALLR") ;resubmitted
 ... I '$D(@REFS@("TOT",IBIFN)) S ^(IBIFN)="" D INC("TOT") ;unique requests
 ... ;no response?
 ... I 'IBREJECT,'MRACNT,'$D(@REFS@("NON",IBIFN)) S ^(IBIFN)="" D INC("NON")
 ... ;final reject?
 ... I 'MRACNT,IBREJECT,'$D(@REFS@("REJF",IBIFN)),IBTRAN=$$LAST364^IBCEF4(IBIFN) D
 .... S @REFS@("REJF",IBIFN)="" D INC("REJF")
 .... ; MRA?
 ... I MRACNT,'$D(@REFS@("MRA",IBIFN)) S ^(IBIFN)="" D
 .... D INC("MRA")
 .... I $$DENIED(IBIFN) D INC("MRAD")
 ... ;any secondary claims?
 ... D SECOND
 Q
 ;
INC(NODE,VALUE) ;Increase the respective value in ^TMP
 I 'IBSUM D
 . S @REFX@(NODE)=$G(@REFX@(NODE))+$G(VALUE,1)
 . I $D(REFTX) S @REFTX@(NODE)=$G(@REFTX@(NODE))+$G(VALUE,1)
 . Q
 S @REFS@(NODE)=$G(@REFS@(NODE))+$G(VALUE,1)
 I $D(REFT) S @REFT@(NODE)=$G(@REFT@(NODE))+$G(VALUE,1)
 Q
 ;
DENIED(IBIFN) ;MRA requests denied?
 ; 361.1 for this bill#
 ; if at least one request is 'processed' - MRA is NOT DENIED
 N IBDEN,IEN,IBZ
 S IBDEN=1
 S IEN=0 F  S IEN=$O(^IBM(361.1,"B",+$G(IBIFN),IEN)) Q:'IEN  D  Q:'IBDEN
 . S IBZ=$G(^IBM(361.1,IEN,0))
 . I $P(IBZ,U,4)'=1 Q  ; only MEDICARE
 . I $P(IBZ,U,13)=1 S IBDEN=0
 Q IBDEN
 ;
SECOND ;Secondary claims
 N IBAUT,IBTX,IBCBPS,IBNEXT,IBBILS,IBTOT,IBUNR,IB2ND,IBNODE
 I $D(@REFS@("SEC",IBIFN)) Q  ; Already included
 S IBCBPS=$P(IBBILZ,U,21) ; current bill sequence
 S IBNEXT=$S(IBSEQ="S":"T",1:"S") ;Next (after MRA) sequence
 I IBCBPS'=IBNEXT Q
 ; Number of unique sec claims
 S @REFS@("SEC",IBIFN)=""
 D INC("SEC")
 S IBBILS=$G(^DGCR(399,IBIFN,"S")) Q:'$P(IBBILS,U,10)  ; Not even authorized
 ; Authorized but not yet printed?
 I $P(IBBILS,U,10),'$P(IBBILS,U,13) D  Q
 . I +$$TXMT^IBCEF4(IBIFN)'=1 D INC("AUT") ; Exclude transmittable
 ; Check the field 'AUTHORIZER'
 S IBAUT=($P(IBBILS,U,11)=MRAUSR) ; Auto-authorized?
 S IBTX=$$TRANSM(IBIFN,IBNEXT) ; Transmitted? (present in 364?)
 I IBAUT,IBTX S IBNODE="AT"   ; Auto-gen Tx
 I 'IBAUT,IBTX S IBNODE="MT"  ; Manually Tx
 I IBAUT,'IBTX S IBNODE="AP"  ; Auto-gen Prn
 I 'IBAUT,'IBTX S IBNODE="MP" ; Manually Prn
 ;
 ;Calculate amounts
 S IBTOT=+$G(^DGCR(399,IBIFN,"U1"))
 S IBUNR=$P($G(^PRCA(430,IBIFN,13)),U,2) ; Medicare Unreimbursable
 S IB2ND=$$PREOBTOT^IBCEU0(IBIFN)
 D INC(IBNODE)
 D INC(IBNODE_"1",IBTOT)
 D INC(IBNODE_"2",IBUNR)
 D INC(IBNODE_"3",IB2ND)
 Q
 ;
TRANSM(IBIFN,IBSEQ) ;was the claim ever transmitted?
 ; Does the claim present in 364?
 N RES,IBI
 S RES=0
 S IBI="" F  S IBI=$O(^IBA(364,"B",IBIFN,IBI),-1) Q:IBI=""  D  Q:RES
 . I $P($G(^IBA(364,IBI,0)),U,8)=IBSEQ S RES=1
 Q RES
 ;

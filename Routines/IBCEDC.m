IBCEDC ;ALB/ESG - EDI CLAIM STATUS REPORT COMPILE ;13-DEC-2007
 ;;2.0;INTEGRATED BILLING;**377**;21-MAR-94;Build 23
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
EN ; Compile entry point - Queued Job Entry Point
 NEW BCHIEN,COUNT,DT1,DT2,IBIFN,IBLTRDT,IEN
 K ^TMP($J,"IBCEDC")
 I '$D(ZTQUEUED) W !!,"Compiling EDI Claim Status Report.  Please wait "
 ;
 I IBMETHOD="C" G EN1     ; specific claims selected
 ;
 ; get dates and loop thru ALT area
 S DT1=$G(^TMP($J,"IBCEDS","ALTDT"))
 S DT2=$P(DT1,U,2),DT1=$P(DT1,U,1)
 S IBLTRDT=$O(^IBA(364.1,"ALT",DT1),-1)  ; get starting point
 F  S IBLTRDT=$O(^IBA(364.1,"ALT",IBLTRDT)) Q:'IBLTRDT!(IBLTRDT\1>DT2)!$G(ZTSTOP)  D
 . S BCHIEN=0
 . F  S BCHIEN=$O(^IBA(364.1,"ALT",IBLTRDT,BCHIEN)) Q:'BCHIEN!$G(ZTSTOP)  D
 .. S IEN=0
 .. F  S IEN=$O(^IBA(364,"C",BCHIEN,IEN)) Q:'IEN!$G(ZTSTOP)  D COMPILE(IEN)
 .. Q
 . Q
 G RPT
 ;
 ;
EN1 ; specific claims selected so loop thru all EDI claims in file 364
 ; for these claims
 ;
 S IBIFN=0
 F  S IBIFN=$O(^TMP($J,"IBCEDS","CLAIM",IBIFN)) Q:'IBIFN!$G(ZTSTOP)  D
 . S IEN=0
 . F  S IEN=$O(^IBA(364,"B",IBIFN,IEN)) Q:'IEN!$G(ZTSTOP)  D
 .. S BCHIEN=+$P($G(^IBA(364,IEN,0)),U,2)         ; batch ien
 .. S IBLTRDT=$P($G(^IBA(364.1,BCHIEN,1)),U,3)    ; date/time last transmitted
 .. D COMPILE(IEN)
 .. Q
 . Q
 G RPT
 ;
 ;
RPT ; print the report and close things down
 D PRINT^IBCEDP                          ; print report
 D ^%ZISC                                ; close the device
 K ^TMP($J,"IBCEDS"),^TMP($J,"IBCEDC")   ; clean up scratch globals
 I $D(ZTQUEUED) S ZTREQ="@"              ; purge the task record
 ;
EX ; routine exit point
 ;
 Q
 ;
COMPILE(IEN) ; gather and compile EDI claim data for one EDI claim
 ; IEN - 364 ien
 NEW AR,DIV,IB0,IBAGE,IBAGEDT,IBARSTAT,IBCURBAL,IBDIV,IBDIVID,IBEDIST
 NEW IBEXTCLM,IBIFN,IBPAY,IBS,IBSGD,IBSTAT,IBZ,INS,STAT,SV1,SV2,SV3
 S COUNT=$G(COUNT)+1
 I COUNT#1000=0 D  I $G(ZTSTOP) G COMPX
 . I $D(ZTQUEUED),$$S^%ZTLOAD() S ZTSTOP=1 Q   ; check for TM stop request
 . I '$D(ZTQUEUED) W "."                       ; display progress indicator
 . Q
 S IBZ=$G(^IBA(364,IEN,0)) I IBZ="" G COMPX
 S IBIFN=+IBZ
 S IB0=$G(^DGCR(399,IBIFN,0)) I IB0="" G COMPX
 S DIV=+$P(IB0,U,22)                           ; division ien
 S INS=+$$FINDINS^IBCEF1(IBIFN,$P(IBZ,U,8))    ; insurance company ien for this EDI transmission
 S STAT=$P(IBZ,U,3)                            ; edi status code
 S AR=$P($$BILL^RCJIBFN2(IBIFN),U,2)           ; current AR status ien
 S IBARSTAT=$P($G(^PRCA(430.3,AR,0)),U,2)      ; current AR status abbr/sort value
 ;
 I IBMETHOD="R",'$$CHECK(IB0,DIV,INS,STAT,IBARSTAT) G COMPX   ; failed selection criteria checks
 ;
 S IBPAY=$P($G(^DIC(36,INS,0)),U,1)_U_INS  ; payer name^insurance company ien
 S IBDIVID=$P($G(^DG(40.8,DIV,0)),U,2)     ; division id#
 S IBDIV=IBDIVID                           ; division sort value
 S IBEXTCLM=$P(IB0,U,1)                    ; claim#
 S IBEDIST=STAT                            ; edi status sort value
 S IBCURBAL=$G(^DGCR(399,IBIFN,"U1"))
 S IBCURBAL=$P(IBCURBAL,U,1)-$P(IBCURBAL,U,2)   ; current balance (total charges - offset)
 ;
 ; calculate age
 S IBS=$G(^DGCR(399,IBIFN,"S"))
 ; if the payer is Medicare and an MRA request date exists then use that date
 I $$MCRWNR^IBEFUNC(INS),$P(IBS,U,7) S IBAGEDT=$P(IBS,U,7)
 E  S IBAGEDT=$P(IBS,U,10)     ; otherwise use the Authorization Date
 I 'IBAGEDT S IBAGEDT=$P(IBS,U,1)   ; if error, use date entered
 I 'IBAGEDT S IBAGEDT=$P($G(^DGCR(399,IBIFN,"U")),U,1)    ; if error again, use from date on claim
 S IBAGE=$$FMDIFF^XLFDT(DT,IBAGEDT)
 ;
 ; capture IB status abbr
 S IBSTAT=$P(IB0,U,13)
 S IBSTAT=$S(IBSTAT=2:"REQ MRA",IBSTAT=4:"PRNT/TX",IBSTAT=7:"CANCEL",1:$$EXTERNAL^DILFD(399,.13,,IBSTAT))
 ;
 ; Build the scratch global
 S IBSGD=IBEXTCLM_U_$$FT^IBCEF(IBIFN)_U_$$INPAT^IBCEF(IBIFN)_U_$P(IBZ,U,8)_U_STAT_U_IBLTRDT_U_IBAGE_U_+$P(IBZ,U,2)
 S IBSGD=IBSGD_U_IBCURBAL_U_DIV_U_IBARSTAT_U_INS_U_IBSTAT
 S SV1=$$SV^IBCEDS1($G(IBSORT1),IEN)
 S SV2=$$SV^IBCEDS1($G(IBSORT2),IEN)
 S SV3=$$SV^IBCEDS1($G(IBSORT3),IEN)
 S ^TMP($J,"IBCEDC",SV1,SV2,SV3,IEN)=IBSGD
 ;
COMPX ;
 Q
 ;
CHECK(IB0,DIV,INS,STAT,IBARSTAT) ; check to see if EDI claim passes the selection criteria
 ; function value =1 if passed checks
 ; function value =0 if failed checks
 NEW OK,EDI,PROFID,INSTID S OK=0
 I STAT="" S STAT="~~~~"
 I $D(^TMP($J,"IBCEDS","DIV")),'$D(^TMP($J,"IBCEDS","DIV",DIV)) S OK=0 G CHECKX    ; division check
 I $D(^TMP($J,"IBCEDS","EDI")),'$D(^TMP($J,"IBCEDS","EDI",STAT)) S OK=0 G CHECKX   ; EDI status check
 ;
 ; IB cancelled claim check
 I $P(IB0,U,13)=7,'$G(^TMP($J,"IBCEDS","CANCEL")) S OK=0 G CHECKX
 ;
 ; AR cancelled claim check
 I $F(".CB.CN.","."_IBARSTAT_"."),'$G(^TMP($J,"IBCEDS","CANCEL")) S OK=0 G CHECKX
 ;
 ; payer check
 I $D(^TMP($J,"IBCEDS","INS")) D  I 'OK G CHECKX
 . S OK=0
 . I 'INS Q   ; don't include if the payer isn't valid
 . I $D(^TMP($J,"IBCEDS","INS",1,INS)) S OK=1 Q
 . I '$D(^TMP($J,"IBCEDS","INS",2)) Q
 . S EDI=$$UP^XLFSTR($G(^DIC(36,INS,3)))
 . S PROFID=$P(EDI,U,2),INSTID=$P(EDI,U,4)
 . I PROFID'="",$D(^TMP($J,"IBCEDS","INS",2,PROFID)) S OK=1 Q
 . I INSTID'="",$D(^TMP($J,"IBCEDS","INS",2,INSTID)) S OK=1 Q
 . Q
 ;
 ; all checks passed OK
 S OK=1
 ;
CHECKX ;
 Q OK
 ;

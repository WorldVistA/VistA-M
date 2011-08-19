IBCEPTR ;ALB/ESG - Test Claim Messages Report ;28-JAN-2005
 ;;2.0;INTEGRATED BILLING;**296,320,348,349**;21-MAR-94;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; eClaims Plus
 ; Report on Test Claim Transmissions and Status Messages
 ;
EN ; Entry Point
 NEW STOP,IBRMETH,IBRDATA
 D SELECT I STOP G EXIT
 D DEVICE
EXIT ; Exit Point
 Q
 ;
SELECT ; Determine which claim#'s or batch#'s to report on
 NEW DIC,DIR,X,Y,DIRUT,DTOUT,DUOUT,DIROUT,D
 S STOP=0
 W @IOF
 W !!?23,"Test Claim EDI Transmission Report"
 W !!?7,"This report will display EDI transmission data and returned status"
 W !?7,"message data for selected test claims.  You may select test claims"
 W !?7,"by claim number or by batch number or you may search for claims that"
 W !?7,"were transmitted within a date range.",!
 S DIR(0)="SO^C:Claim;B:Batch;D:Date Range (Date Transmitted)"
 S DIR("A")="Selection Method",DIR("B")="D"
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G SELECTX
 S IBRMETH=Y
 I IBRMETH'="C",IBRMETH'="B",IBRMETH'="D" S STOP=1 G SELECTX
 ;
 K IBRDATA
 I IBRMETH="C" D
 . F  D  Q:Y'>0
 .. W !
 .. S DIC("A")="Test Claim: "
 .. I $O(IBRDATA("")) S DIC("A")="Another Test Claim: "
 .. S DIC("W")="D CLMLST^IBCEPTR(Y)"
 .. S DIC=361.4,DIC(0)="AEMQ",D="B" D MIX^DIC1
 .. Q:Y'>0
 .. S IBRDATA(+Y)=""
 .. Q
 . Q
 ;
 I IBRMETH="B" D
 . F  D  Q:Y'>0
 .. W !
 .. S DIC("A")="Test Batch: "
 .. I $O(IBRDATA("")) S DIC("A")="Another Test Batch: "
 .. S DIC("S")="I $P(^(0),U,14),$O(^IBM(361.4,""C"",+Y,0))"
 .. S DIC=364.1,DIC(0)="AEMQ",D="B^C" D MIX^DIC1
 .. Q:Y'>0
 .. S IBRDATA(+Y)=""
 .. Q
 . Q
 ;
 I IBRMETH="D" D
 . W !
 . S DIR(0)="DAO^:"_DT_":AEX",DIR("A")="  Earliest Date Claims Transmitted: "
 . D ^DIR K DIR
 . I $D(DIRUT)!'Y Q
 . S IBRDATA(1)=Y
 . W !
 . S DIR(0)="DAO^"_Y_":"_DT_":AEX",DIR("A")="    Latest Date Claims Transmitted: ",DIR("B")="Today"
 . D ^DIR K DIR
 . I $D(DIRUT)!'Y Q
 . S IBRDATA(2)=Y
 . Q
 ;
 I '$O(IBRDATA("")) S STOP=1 G SELECTX
 I IBRMETH="D",'$G(IBRDATA(1)) S STOP=1 G SELECTX
 I IBRMETH="D",'$G(IBRDATA(2)) S STOP=1 G SELECTX
 ;
SELECTX ;
 Q
 ;
DEVICE ; standard device selection
 NEW ZTRTN,ZTDESC,ZTSAVE,POP
 W !!!,"This report is 80 characters wide.",!
 S ZTRTN="COMPILE^IBCEPTR"
 S ZTDESC="Test Claim EDI Transmission Report"
 S ZTSAVE("IBRMETH")=""
 S ZTSAVE("IBRDATA")=""
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE,"QM")
DEVX ;
 Q
 ;
COMPILE ; compile the data into a scratch global
 NEW RTN,EXTBCH,IBIFN,BCHIEN,TXDATM
 S RTN="IBCEPTR"
 KILL ^TMP($J,RTN)  ; init scratch global
 ;
 I IBRMETH="C" D    ; claim search
 . S EXTBCH=0
 . S IBIFN=0
 . F  S IBIFN=$O(IBRDATA(IBIFN)) Q:'IBIFN  D STORE(IBIFN)
 . Q
 ;
 I IBRMETH="B" D    ; batch search
 . S BCHIEN=0
 . F  S BCHIEN=$O(IBRDATA(BCHIEN)) Q:'BCHIEN  D
 .. S EXTBCH=$P($G(^IBA(364.1,BCHIEN,0)),U,1)
 .. I EXTBCH="" S EXTBCH="~unknown"
 .. S IBIFN=0
 .. F  S IBIFN=$O(^IBM(361.4,"C",BCHIEN,IBIFN)) Q:'IBIFN  D STORE(IBIFN)
 .. Q
 . Q
 ;
 I IBRMETH="D" D    ; date range search
 . S EXTBCH=0
 . S TXDATM=$O(^IBM(361.4,"ATD",IBRDATA(1)),-1)
 . F  S TXDATM=$O(^IBM(361.4,"ATD",TXDATM)) Q:'TXDATM  Q:(TXDATM\1)>IBRDATA(2)  D
 .. S IBIFN=0
 .. F  S IBIFN=$O(^IBM(361.4,"ATD",TXDATM,IBIFN)) Q:'IBIFN  D STORE(IBIFN)
 .. Q
 . Q
 ;
 D PRINT                           ; print the report
 D ^%ZISC                          ; close the device
 KILL ^TMP($J,RTN)                 ; clean up scratch global
 I $D(ZTQUEUED) S ZTREQ="@"        ; purge the task record
COMPX ;
 Q
 ;
STORE(IBIFN) ; Input = internal bill#; continue compilation
 NEW IB0,CLAIM,IBRTXD0,TXIEN,SMIEN,DATA,TXDTM
 S IB0=$G(^DGCR(399,IBIFN,0))
 S CLAIM=$P(IB0,U,1)  ; external claim#
 I CLAIM="" S CLAIM="~unknown"
 S IBRTXD0=99999999   ; initial value for earliest transmission date
 ;
 I IBRMETH="C" D   ; claim search for transmission data (all)
 . S TXIEN=0
 . F  S TXIEN=$O(^IBM(361.4,IBIFN,1,TXIEN)) Q:'TXIEN  D STORETX(IBIFN,TXIEN)
 . Q
 ;
 I IBRMETH="B" D   ; batch search for transmission data ("C" x-ref)
 . S TXIEN=0
 . F  S TXIEN=$O(^IBM(361.4,"C",BCHIEN,IBIFN,TXIEN)) Q:'TXIEN  D STORETX(IBIFN,TXIEN)
 . Q
 ;
 I IBRMETH="D" D   ; date range search for transmission data ("ATD" xref)
 . S TXIEN=0
 . F  S TXIEN=$O(^IBM(361.4,"ATD",TXDATM,IBIFN,TXIEN)) Q:'TXIEN  D STORETX(IBIFN,TXIEN)
 . Q
 ;
 ; loop thru all returned messages for claim
 S SMIEN=0
 F  S SMIEN=$O(^IBM(361.4,IBIFN,2,SMIEN)) Q:'SMIEN  D
 . S DATA=$G(^IBM(361.4,IBIFN,2,SMIEN,0)) Q:DATA=""   ; received msg data
 . S TXDTM=$P(DATA,U,1) Q:'TXDTM    ; msg rec'd date/time
 . ;
 . ; Batch only: if this status message was received before the
 . ; earliest transmission for this batch, then don't include it
 . I IBRMETH="B",TXDTM'>IBRTXD0 Q
 . ;
 . ; Date range search only:  make sure the date/time the status message
 . ; was received is inside the user specified date range for this report
 . I IBRMETH="D",(TXDTM\1)<IBRDATA(1) Q    ; rec'd too early
 . I IBRMETH="D",(TXDTM\1)>IBRDATA(2) Q    ; rec'd too late
 . ;
 . ; store it
 . M ^TMP($J,RTN,EXTBCH,CLAIM,TXDTM,2,SMIEN)=^IBM(361.4,IBIFN,2,SMIEN)
 . Q
STOREX ;
 Q
 ;
STORETX(IBIFN,TXIEN) ; store transmission info
 NEW DATA,TXDTM
 S DATA=$G(^IBM(361.4,IBIFN,1,TXIEN,0))
 I DATA="" G STTXXX
 S TXDTM=$P(DATA,U,1)   ; transmit date/time
 I 'TXDTM G STTXXX
 I TXDTM<IBRTXD0 S IBRTXD0=TXDTM
 ;
 ; store it
 M ^TMP($J,RTN,EXTBCH,CLAIM,TXDTM,1,TXIEN)=^IBM(361.4,IBIFN,1,TXIEN)
STTXXX ;
 Q
 ;
PRINT ; print the report to the specified device
 NEW MAXCNT,CRT,PAGECNT,STOP,DIR,X,Y,DIRUT,DUOUT,DTOUT,DIROUT
 NEW BATCH,CLAIM,IBIFN,CLMD,TXD,TYPE,IEN
 I IOST["C-" S MAXCNT=IOSL-3,CRT=1
 E  S MAXCNT=IOSL-6,CRT=0
 S PAGECNT=0,STOP=0
 ;
 I '$D(^TMP($J,RTN)) D HEADER W !!!?5,"No Data Found"
 ;
 S BATCH=""
 F  S BATCH=$O(^TMP($J,RTN,BATCH)) Q:BATCH=""  D  Q:STOP
 . D HEADER Q:STOP
 . I BATCH'=0 W !!,"Batch#:  ",BATCH
 . S CLAIM=""
 . F  S CLAIM=$O(^TMP($J,RTN,BATCH,CLAIM)) Q:CLAIM=""  D  Q:STOP
 .. I $Y+2>MAXCNT!'PAGECNT D HEADER Q:STOP
 .. I BATCH=0 W !
 .. W !,"Claim#:  ",CLAIM
 .. S IBIFN=+$O(^DGCR(399,"B",CLAIM,""))
 .. I IBIFN S CLMD=$$BT(IBIFN) W ?18,$E($P(CLMD,U,3),1,20),?40,"(",$P(CLMD,U,1),")"
 .. W !,$$RJ^XLFSTR("",80,"-")
 .. ;
 .. S TXD=0
 .. F  S TXD=$O(^TMP($J,RTN,BATCH,CLAIM,TXD)) Q:'TXD!STOP  S TYPE=0 F  S TYPE=$O(^TMP($J,RTN,BATCH,CLAIM,TXD,TYPE)) Q:'TYPE!STOP  S IEN=0 F  S IEN=$O(^TMP($J,RTN,BATCH,CLAIM,TXD,TYPE,IEN)) Q:'IEN!STOP  D  Q:STOP
 ... I TYPE=1 D TXPRT
 ... I TYPE=2 D SMPRT
 ... Q
 .. Q
 . Q
 ;
 I STOP G PRINTX
 I $Y+2>MAXCNT!'PAGECNT D HEADER I STOP G PRINTX
 W !!?5,"*** End of Report ***"
 I CRT,'$D(ZTQUEUED) S DIR(0)="E" D ^DIR K DIR
PRINTX ;
 Q
 ;
TXPRT ; print transmission information
 NEW DATA,TXDTM,EXTBCH,TXBY,INSIEN,PAYER,PSEQ,INZ
 S DATA=$G(^TMP($J,RTN,BATCH,CLAIM,TXD,TYPE,IEN,0)) I DATA="" G TXPRTX
 S TXDTM=$$FMTE^XLFDT($P(DATA,U,1),"5Z")
 S EXTBCH=$$EXTERNAL^DILFD(361.41,.02,,$P(DATA,U,2))  ; batch
 S TXBY=$$EXTERNAL^DILFD(361.41,.03,,$P(DATA,U,3))    ; who tx
 S INSIEN=+$$FINDINS^IBCEF1(IBIFN,$P(DATA,U,4))       ; insurance
 S INZ=$$INSADD^IBCNSC02(INSIEN)                      ; ins name/addr
 S PAYER=$P(INZ,U,1)                                  ; ins name
 S PSEQ=$TR($P(DATA,U,4),"123","PST")                 ; payer seq
 ;
 I $Y+2>MAXCNT!'PAGECNT D HEADER I STOP G TXPRTX
 W !,"Transmission Information"
 W !?1,TXDTM,?22,"Bch#",+$E(EXTBCH,4,99),?33,$E(TXBY,1,15),?50,$E(PAYER,1,20),"  (",PSEQ,")"
 ; display address info if not Medicare
 I '$$MCRWNR^IBEFUNC(INSIEN) W !?50,$E($P(INZ,U,2),1,15),",",$E($P(INZ,U,3),1,11),",",$E($P(INZ,U,4),1,2)
 W !
TXPRTX ;
 Q
 ;
SMPRT ; print returned status message information
 NEW DATA,TXDTM,SEVERITY,Z
 S DATA=$G(^TMP($J,RTN,BATCH,CLAIM,TXD,TYPE,IEN,0)) I DATA="" G SMPRTX
 S TXDTM=$$FMTE^XLFDT($P(DATA,U,1),"5Z")
 S SEVERITY=$$EXTERNAL^DILFD(361.42,.02,,$P(DATA,U,2))  ; msg severity
 ;
 I $Y+2>MAXCNT!'PAGECNT D HEADER I STOP G SMPRTX
 W !,"Status Message Information"
 W !?1,TXDTM,?22,SEVERITY,?65,"Msg#",$P(DATA,U,3)
 S Z=0
 F  S Z=$O(^TMP($J,RTN,BATCH,CLAIM,TXD,TYPE,IEN,1,Z)) Q:'Z  D  Q:STOP
 . I $Y+1>MAXCNT!'PAGECNT D HEADER Q:STOP
 . W !?2,$G(^TMP($J,RTN,BATCH,CLAIM,TXD,TYPE,IEN,1,Z,0))
 . Q
 W !
SMPRTX ;
 Q
 ;
HEADER ; page break and header
 NEW LIN,HDR,TAB
 S STOP=0
 I CRT,PAGECNT>0,'$D(ZTQUEUED) D  I STOP G HEADX
 . I MAXCNT<51 F LIN=1:1:(MAXCNT-$Y) W !
 . S DIR(0)="E" D ^DIR K DIR
 . I 'Y S STOP=1 Q
 . Q
 ;
 S PAGECNT=PAGECNT+1
 W @IOF,!
 ;
 W "Test Claim EDI Transmission Report"
 S HDR="Page: "_PAGECNT,TAB=80-$L(HDR)-1
 W ?TAB,HDR
 W !,"Selected ",$S(IBRMETH="B":"Batches",IBRMETH="C":"Claims",1:"Date Range")
 S HDR=$$FMTE^XLFDT($$NOW^XLFDT,"1Z"),TAB=80-$L(HDR)-1
 W ?TAB,HDR
 W !,$$RJ^XLFSTR("",80,"=")
 ;
 ; check for a stop request
 I $D(ZTQUEUED),$$S^%ZTLOAD() D  G HEADX
 . S (ZTSTOP,STOP)=1
 . W !!!?5,"*** Report Halted by TaskManager Request ***"
 . Q
 ;
HEADX ;
 Q
 ;
BT(IBIFN) ; bill type and info
 ; [1] TYPE (form type, charge type, inp/outp)
 ; [2] claim#
 ; [3] patient name
 NEW TYPE,IB0,F,C,S S TYPE=""
 S IB0=$G(^DGCR(399,+$G(IBIFN),0)) I IB0="" Q ""
 S F=$P(IB0,U,19),F=$S(F=2:"1500",1:"UB04")
 S C=$P(IB0,U,27),C=$S(C=1:"Inst",1:"Prof")
 S S=$$INPAT^IBCEF(IBIFN),S=$S(S=1:"Inpat",1:"Outpat")
 S TYPE=F_", "_C_", "_S
 Q TYPE_U_$P(IB0,U,1)_U_$P($G(^DPT(+$P(IB0,U,2),0)),U,1)
 ;
CLMLST(IBIFN) ; DIC lister
 NEW TYPE,LTD,N1,N2
 S TYPE=$P($$BT(IBIFN),U,1)
 S LTD=$$FMTE^XLFDT($P($G(^IBM(361.4,IBIFN,0)),U,2),"2Z")
 S N1=+$P($G(^IBM(361.4,IBIFN,1,0)),U,4)  ; # transmissions
 S N2=+$P($G(^IBM(361.4,IBIFN,2,0)),U,4)  ; # return messages
 W " ",TYPE,?34," ",LTD,?45," ",N1," Transmission",$S(N1'=1:"s",1:"")
 W ?63," ",N2," Message",$S(N2'=1:"s",1:"")
CLMLSTX ;
 Q
 ;

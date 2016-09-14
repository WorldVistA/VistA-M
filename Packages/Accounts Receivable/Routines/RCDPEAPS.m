RCDPEAPS ;ALB/DMB - ERA STATUS CHANGE AUDIT REPORT ;Nov 25, 2015
 ;;4.5;Accounts Receivable;**304**;Mar 20, 1995;Build 104
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;
EN ;
 ; Entry point for ERA Status Change Report [RCDPE ERA STATUS CHNG AUD REP]
 ;
 ; Prompt for report type
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,RCTYPE,RCERA,RCRANGE
 S DIR(0)="SA^S:SINGLE ERA;A:ALL"
 S DIR("A")="SELECT (S)ingle ERA or (A)LL: ",DIR("B")="ALL"
 D ^DIR
 I Y'="S",Y'="A" Q
 S RCTYPE=Y
 ;
 ; If Single ERA, select the ERA
 S RCERA=""
 I RCTYPE="S" S RCERA=$$SELERA() I 'RCERA Q
 ;
 ; If ALL ERAs, select Date Range for Report
 S RCRANGE=""
 S RCRANGE=$$DTRNG() I 'RCRANGE Q
 ;
 ; Prompt for device
 N %ZIS,ZTSK,ZTRTN,ZTIO,ZTDESC,ZTSAVE,POP
 S %ZIS="QM"
 D ^%ZIS
 I POP G ENQ
 I $D(IO("Q")) D  G ENQ
 . S ZTRTN="RUN^RCDPEAPS(RCERA,RCRANGE)"
 . S ZTIO=ION
 . S ZTSAVE("*")=""
 . S ZTDESC="ERA STATUS CHANGE AUDIT REPORT"
 . D ^%ZTLOAD
 . W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 . D HOME^%ZIS
 U IO
 ;
 D RUN(RCERA,RCRANGE)
 ;
ENQ ;
 Q
 ;
RUN(RCERA,RCRANGE) ;
 ;
 K ^TMP("RCDPEAPS",$J)
 ;
 ; Compile Data
 D COMPILE(RCERA,RCRANGE)
 ;
 ; Generate Report
 D REPORT(RCRANGE)
 ;
 K ^TMP("RCDPEAPS",$J)
 Q
 ;
COMPILE(RCERA,RCRANGE) ;
 ; Compile the data
 ;
 N CNT,BDATE,EDATE,AUDDATE,IEN,CNT,DATA
 S CNT=0,BDATE=$P(RCRANGE,U,1)-.000001,EDATE=$P(RCRANGE,U,2)+.999999
 ;
 ; If RCERA is non-zero, then we are doing a single ERA
 I RCERA D  Q
 . S IEN="" F  S IEN=$O(^RCY(344.72,"E",RCERA,IEN)) Q:'IEN  D
 .. S DATA=$G(^RCY(344.72,IEN,0))
 .. S AUDDATE=$P(DATA,U,1)
 .. I AUDDATE="" Q
 .. I AUDDATE<BDATE!(AUDDATE>EDATE) Q
 .. S CNT=CNT+1
 .. S ^TMP("RCDPEAPS",$J,RCERA,AUDDATE,CNT)=$P(DATA,U,4)_U_$P(DATA,U,5)_U_$P(DATA,U,2)_U_$P(DATA,U,6)
 ;
 ; If RCERA is zero, then we are gathering data by date
 I 'RCERA D  Q
 . S AUDDATE=BDATE F  S AUDDATE=$O(^RCY(344.72,"B",AUDDATE)) Q:'AUDDATE!(AUDDATE>EDATE)  D
 .. S IEN="" F  S IEN=$O(^RCY(344.72,"B",AUDDATE,IEN)) Q:'IEN  D
 ... S DATA=$G(^RCY(344.72,IEN,0))
 ... I $P(DATA,U,3)="" Q
 ... S CNT=CNT+1
 ... S ^TMP("RCDPEAPS",$J,$P(DATA,U,3),AUDDATE,CNT)=$P(DATA,U,4)_U_$P(DATA,U,5)_U_$P(DATA,U,2)_U_$P(DATA,U,6)
 Q
 ;
REPORT(RCRANGE) ;
 ; Display output
 ;
 ; Initialize Report Date, Page Number and Sting of underscores
 N RCSCR,RCNOW,RCPG,RCHR,ERA,DATE,CNT,DATA,LINES
 S RCSCR=$S($E($G(IOST),1,2)="C-":1,1:0)
 S RCNOW=$$UP^XLFSTR($$NOW^RCDPRU()),RCPG=0,RCHR="",$P(RCHR,"-",IOM+1)=""
 ;
 U IO
 D HEADER(RCNOW,.RCPG,RCHR,RCRANGE)
 I '$D(^TMP("RCDPEAPS",$J)) W !,"No data found"
 ;
 ; Display the detail
 S ERA="" F  S ERA=$O(^TMP("RCDPEAPS",$J,ERA)) Q:'ERA  D  I RCPG=0 Q
 . S DATE="" F  S DATE=$O(^TMP("RCDPEAPS",$J,ERA,DATE)) Q:'DATE  D  I RCPG=0 Q
 .. S CNT=0 F  S CNT=$O(^TMP("RCDPEAPS",$J,ERA,DATE,CNT)) Q:'CNT  D  I RCPG=0 Q
 ... S DATA=^TMP("RCDPEAPS",$J,ERA,DATE,CNT)
 ... S LINES=2
 ... I $P(DATA,U,4)]"" S LINES=3
 ... I RCSCR S LINES=LINES+1
 ... D CHKP(RCNOW,.RCPG,RCHR,RCRANGE,RCSCR,LINES) I RCPG=0 Q
 ... W !,ERA,?15,$$FMTE^XLFDT(DATE,"2Z"),?38,$$STATUS($P(DATA,U,1)),?49,$$STATUS($P(DATA,U,2))
 ... W ?63,$E($$GET1^DIQ(200,+$P(DATA,U,3)_",",.01),1,IOM-63)
 ... I $P(DATA,U,4)]"" W !,?3,$E($P(DATA,U,4),1,IOM-4)
 ... W !
 ;
 I 'RCSCR W !,@IOF
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 ;
 I RCPG,RCSCR D PAUSE
 Q
 ;
HEADER(RCNOW,RCPG,RCHR,RCRANGE) ;
 ; Print Header
 ;
 N LINE
 W @IOF
 S RCPG=RCPG+1
 S LINE="EDI Lockbox ERA Status Change Audit Report"
 W ?(IOM-$L(LINE)\2),LINE
 S LINE="Page: "_RCPG_" "
 W ?(IOM-$L(LINE)),LINE
 S LINE="RUN DATE: "_RCNOW
 W !?(IOM-$L(LINE)\2),LINE
 S LINE="DATE RANGE: "_$$FMTE^XLFDT($P(RCRANGE,U,1),"5DZ")_" - "_$$FMTE^XLFDT($P(RCRANGE,U,2),"5DZ")
 W !?(IOM-$L(LINE)\2),LINE
 ;
 W !!,"ERA#",?15,"Date/Time Edited",?38,"Status (Old/New)",?63,"User"
 W !?3,"Reason Text"
 W !,RCHR
 Q
 ;
PAUSE() ;
 N DIR,X,Y,DTOUT,DUOUT,DIROUT,DIRUT
 S DIR(0)="E"
 D ^DIR
 Q Y
 ;
CHKP(RCNOW,RCPG,RCHR,RCRANGE,RCSCR,LINES) ;
 ; Check if we need to do a page break
 ;
 I $Y'>(IOSL-LINES) Q
 I RCSCR,'$$PAUSE S RCPG=0 Q
 D HEADER(RCNOW,.RCPG,RCHR,RCRANGE)
 Q
 ;
SELERA() ;
 ; Lookup on the Electronic Remittance Advice (#344.4) file
 ;
 N DIC,X,Y,DTOUT,DUOUT
 S DIC="^RCY(344.4,",DIC(0)="QEAMn"
 D ^DIC
 I $G(DTOUT)!$G(DUOUT)!(Y=-1) Q 0
 Q +Y
 ;
DTRNG() ;
 ; Get the date range for the report
 ;
 N DIR,X,Y,DTOUT,DUOUT,DIROUT,DIRUT,BDATE
 S DIR("?")="ENTER THE EARLIEST AUDIT DATE TO INCLUDE ON THE REPORT"
 S DIR(0)="DA^:"_DT_":APE",DIR("A")="START DATE: ",DIR("B")="T" D ^DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S BDATE=-1 Q 0
 S BDATE=Y
 K DIR
 S DIR("?")="ENTER THE LATEST AUDIT DATE TO INCLUDE ON THE REPORT"
 S DIR("B")=Y(0)
 S DIR(0)="DA^"_BDATE_":"_DT_":APE",DIR("A")="END DATE: ",DIR("B")="T" D ^DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") Q 0
 Q BDATE_"^"_Y
 ;
STATUS(STATUS) ;
 ; Convert internal status to external status
 I '$D(STATUS) Q ""
 I STATUS="" Q "NULL"
 Q $$EXTERNAL^DILFD(344.4,4.02,,STATUS)

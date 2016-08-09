RCDPTAR1 ;ALB/DMB - EFT TRANSACTION AUDIT REPORT (Summary) ;08/19/15
 ;;4.5;Accounts Receivable;**303**;Mar 20, 1995;Build 84
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ; PRCA*4.5*303 - EFT TRANSACTION AUDIT REPORT (SUMMARY VERSION)
 ;
SUM ;
 N DIR,X,Y,DUOUT,DTOUT,DIRUT,DIROUT
 N RCDT1,RCDT2,RCEXCEL
 ;
 ; Start Date
 S DIR(0)="DAO^:"_DT_":APE",DIR("A")="Start Date: ",DIR("B")="T"
 S DIR("?")="ENTER THE EARLIEST DATE OF RECEIPT OF DEPOSIT TO INCLUDE ON THE REPORT"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") Q
 S RCDT1=Y
 ;
 ; End Date
 K DIR
 S DIR(0)="DAO^"_RCDT1_":"_DT_":APE",DIR("A")="End Date: ",DIR("B")="T"
 S DIR("?")="ENTER THE LATEST DATE OF RECEIPT OF DEPOSIT TO INCLUDE ON THE REPORT"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") Q
 S RCDT2=Y
 ;
 ; Ask Excel
 S RCEXCEL=$$EXCEL^RCDMCUT2()
 I RCEXCEL="^" Q
 I RCEXCEL D EXMSG
 ;
 ; Prompt for device
 N %ZIS,ZTSK,ZTRTN,ZTIO,ZTDESC,ZTSAVE,POP
 S %ZIS="QM"
 D ^%ZIS
 I POP Q
 I $D(IO("Q")) D  Q
 . S ZTRTN="RUN^RCDPTAR1(RCDT1,RCDT2,RCEXCEL)"
 . S ZTIO=ION
 . S ZTSAVE("*")=""
 . S ZTDESC="EFT TRANSACTION SUMMARY REPORT"
 . D ^%ZTLOAD
 . W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 . D HOME^%ZIS
 U IO
 ;
 D RUN(RCDT1,RCDT2,RCEXCEL)
 Q
 ;
RUN(RCDT1,RCDT2,RCEXCEL) ;
 ;
 D COMPILE(RCDT1,RCDT2)
 ;
 D REPORT(RCDT1,RCDT2,RCEXCEL)
 K ^TMP("RCDPTAR1",$J)
 Q
 ;
COMPILE(RCDT1,RCDT2) ;
 N RCDT,LOCKIEN,LOCKDATA,EFTIEN,EFTDATA,MDATE
 ;
 K ^TMP("RCDPTAR1",$J)
 S RCDT=RCDT1-.0001,RCDT2=RCDT2_".9999"
 F  S RCDT=$O(^RCY(344.3,"ARECDT",RCDT)) Q:'RCDT!(RCDT>RCDT2)  D
 . S LOCKIEN="" F  S LOCKIEN=$O(^RCY(344.3,"ARECDT",RCDT,LOCKIEN)) Q:'LOCKIEN  D
 .. S LOCKDATA=$G(^RCY(344.3,LOCKIEN,0))
 .. ; Deposit-0|3 (P344.1);Date Posted-0|11;
 .. S EFTIEN="" F  S EFTIEN=$O(^RCY(344.31,"B",LOCKIEN,EFTIEN)) Q:'EFTIEN  D
 ... S EFTDATA=$G(^RCY(344.31,EFTIEN,0))
 ... ; Date Received-0|13;Amount-0|7;Match Status-0|8 (hist);Trace-0|4;Payer Name-0|2;Payer ID-0|3
 ... S MDATE=$$MDATE($P(EFTDATA,U,8),EFTIEN)
 ... ; Date Received^Deposit #^EFT Amount^Date Matched^Date Posted^Trace #^Payer Name^Payer ID^Stale/Lock
 ... S ^TMP("RCDPTAR1",$J,EFTIEN)=$$DATE^RCDPRU($P(EFTDATA,U,13),"2ZD")_U_$$GET1^DIQ(344.3,LOCKIEN_",",.03,"E")
 ... S $P(^TMP("RCDPTAR1",$J,EFTIEN),U,3,5)=$P(EFTDATA,U,7)_U_$$DATE^RCDPRU(MDATE,"2ZD")_U_$$DATE^RCDPRU($P(LOCKDATA,U,11),"2ZD")
 ... S $P(^TMP("RCDPTAR1",$J,EFTIEN),U,6,9)=$P(EFTDATA,U,4)_U_$P(EFTDATA,U,2)_U_$P(EFTDATA,U,3)_U_$$AGED^RCDPTAR(EFTIEN)
 ;
 Q
 ;
MDATE(STATUS,EFTIEN) ;
 ; Return the Match Date from the Match History Global
 ; Input:
 ;   STATUS: Internal value from the EFT MATCH STATUS field
 ;   EFTIEN: EDI THIRD PARTY EFT DETAIL (#344.31) IEN
 ; Output:
 ;   Match Date from the MATCH STATUS HISTORY (#344.314) multiple
 ;
 ; Validate Parameters.  If STATUS is equal to UNMATCHED, quit with "" (no match date)
 I $G(STATUS)=0 Q ""
 I $G(EFTIEN)="" Q ""
 ;
 N MIEN,RCDATA,IENS
 ;
 ; Get last record from the Match status history global.  If no history, then quit with "" (no match date)
 S MIEN=$O(^RCY(344.31,EFTIEN,4,999999),-1)
 I 'MIEN Q "<No History>"
 ;
 ; Get data from match history
 S IENS=MIEN_","_EFTIEN_","
 D GETS^DIQ(344.314,IENS,".01;.02","I","RCDATA")
 ;
 ; If the most recent record is UNMATCHED, then it is does not match the EFT status so return "" (no match date)
 I RCDATA(344.314,IENS,.01,"I")=0 Q ""
 Q RCDATA(344.314,IENS,.02,"I")
 ;
REPORT(RCDT1,RCDT2,RCEXCEL) ;
 N RCSCR,RCNOW,RCPG,RCHR
 N EFTIEN,DATA,LINES
 ;
 ; Initialize Report Date, Page Number and Sting of underscores
 S RCSCR=$S($E($G(IOST),1,2)="C-":1,1:0)
 S RCNOW=$$UP^XLFSTR($$NOW^RCDPRU(2)),RCPG=0,RCHR="",$P(RCHR,"-",IOM+1)=""
 ;
 ; Display header for first page
 U IO
 D HEADER(RCNOW,.RCPG,RCHR,RCDT1,RCDT2,RCEXCEL)
 ;
 ; No data, display message and quit
 I '$D(^TMP("RCDPTAR1",$J)) W !,"No data found"
 ;
 ; Display the detail
 S EFTIEN=0 F  S EFTIEN=$O(^TMP("RCDPTAR1",$J,EFTIEN)) Q:'EFTIEN  D  I RCPG=0 Q
 . S DATA=^TMP("RCDPTAR1",$J,EFTIEN)
 . S LINES=$S(RCEXCEL:1,1:3)
 . I RCSCR S LINES=LINES+1
 . D CHKP(RCNOW,.RCPG,RCHR,RCDT1,RCDT2,RCEXCEL,RCSCR,LINES) I RCPG=0 Q
 . ; If Excel, display as delimited and quit
 . I RCEXCEL W !,$P(DATA,U,9),EFTIEN,U,$P(DATA,U,1,8) Q
 . ;
 . ; Display non-Excel output
 . W !,$P(DATA,U,9),EFTIEN,?13,$P(DATA,U,1),?25,$P(DATA,U,2),?37,$J($P(DATA,U,3),13,2),?54,$P(DATA,U,4),?69,$P(DATA,U,5)
 . W !,?4,$P(DATA,U,6)
 . W !,?11,$P(DATA,U,7),"/",$P(DATA,U,8)
 ;
 I 'RCSCR W !,@IOF
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 ;
 I RCPG,RCSCR D PAUSE
 Q
 ;
HEADER(RCNOW,RCPG,RCHR,RCDT1,RCDT2,RCEXCEL) ;
 ; Print Header Section
 ;
 W @IOF
 ;
 ; If Excel, print column headers separated with up-arrows and quit
 I $G(RCEXCEL) D  Q
 . W !,"EFT#^DATE RECEIVED^DEPOSIT#^EFT TOTAL AMT^DATE MATCHED^DATE POSTED^TRACE #^PAYER NAME^PAYER ID"
 . S RCPG=1
 ;
 ; Non-Excel Header
 N LINE
 S RCPG=RCPG+1
 S LINE="EFT TRANSACTION AUDIT REPORT - SUMMARY     Page: "_RCPG
 W !?(IOM-$L(LINE)\2),LINE
 S LINE="RUN DATE: "_RCNOW
 W !?(IOM-$L(LINE)\2),LINE
 S LINE="DATE RANGE: "_$$DATE^RCDPRU(RCDT1,"2D")_" - "_$$DATE^RCDPRU(RCDT2,"2D")_" (DATE DEPOSIT ADDED)"
 W !?(IOM-$L(LINE)\2),LINE
 W !!,"EFT#",?13,"DATE RECVD",?25,"DEPOSIT#",?37,"EFT TOTAL AMT",?54,"DATE MATCHED",?69,"DATE POSTED"
 W !,?4,"TRACE #",!,?11,"PAYER NAME/ID"
 W !,RCHR
 Q
 ;
EXMSG ;
 ;Displays the message about capturing to an Excel file format
 ;
 W !!?5,"To capture as an Excel format, it is recommended that you queue this"
 W !?5,"report to a spool device with margins of 256 and page length of 99999"
 W !?5,"(e.g. spoolname;256;99999). This should help avoid wrapping problems."
 W !!?5,"Another method would be to set up your terminal to capture the detail"
 W !?5,"report data. On some terminals, this can be done by clicking on the"
 W !?5,"'Tools' menu above, then click on 'Capture Incoming Data' to save to"
 W !?5,"Desktop.  To avoid undesired wrapping of the data saved to the file,"
 W !?5,"please enter '0;256;99999' at the 'DEVICE:' prompt.",!
 Q
 ;
PAUSE() ;
 N DIR,X,Y,DTOUT,DUOUT,DIROUT,DIRUT
 S DIR(0)="E"
 D ^DIR
 Q Y
 ;
CHKP(RCNOW,RCPG,RCHR,RCDT1,RCDT2,RCEXCEL,RCSCR,LINES) ;
 ; Check if we need to do a page break
 ;
 I $Y'>(IOSL-LINES) Q
 I RCSCR,'$$PAUSE S RCPG=0 Q
 D HEADER(RCNOW,.RCPG,RCHR,RCDT1,RCDT2,RCEXCEL)
 Q

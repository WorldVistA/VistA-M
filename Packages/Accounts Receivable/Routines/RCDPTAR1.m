RCDPTAR1 ;ALB/DMB - EFT TRANSACTION AUDIT REPORT (Summary) ;08/19/15
 ;;4.5;Accounts Receivable;**303,326,380**;Mar 20, 1995;Build 14
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ; PRCA*4.5*303 - EFT TRANSACTION AUDIT REPORT (SUMMARY VERSION)
 ;
SUM ;EP from RCDPTAR
 ; Display EFT Transaction Audit Report in original summary mode by Deposit Date
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,RCDT1,RCDT2,RCEXCEL,X,Y
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
 S RCEXCEL=$$EXCEL^RCDMCUT2()                   ; Ask Excel output
 I RCEXCEL="^" Q
 I RCEXCEL D EXMSG
 ;
 Q:$$ASKDEV(0)=-1                               ; PRCA*4.5*380 - Prompt for device
 ;
 U IO
 D RUN(RCDT1,RCDT2,RCEXCEL)
 Q
 ;
 ; PRCA*4.5*380 - Added subroutine
SUM2 ;EP from RCDPTAR
 ; Display EFT Transaction Audit Report in summary mode by Deposit Number
 N ARR,CDDT,CTR,DIR,DIROUT,DIRUT,DTOUT,DUOUT,RCDDT,RCDNUM,RCDT1,RCDT2,RCEXCEL,X,XX,Y
 S RCDNUM=$$ASKDNUM()
 Q:RCDNUM=-1
 S CTR=0,RCDDT="",CDDT=""
 W !,"Select Deposit:"
 F  D  Q:RCDDT'=""
 . S CDDT=$O(^RCY(344.3,"ADEP2",RCDNUM,CDDT),-1)
 . I CDDT="" D  Q                               ; No more Deposit Dates to display for Deposit Number
 . . Q:CTR=0
 . . S RCDDT=$$SELDT(CTR,.ARR)                  ; Final selection choice
 . S CTR=CTR+1,ARR(CTR)=CDDT
 . S XX=$$FMTE^XLFDT(CDDT,"5DZ")
 . W !,$J(CTR,3)," ",RCDNUM," on: ",XX
 . I CTR#10=0 D  Q:RCDDT'=""                    ; Ask selection every 10 times
 . . S RCDDT=$$SELDT(CTR,.ARR)
 Q:RCDDT=""                                     ; No Deposit Date selected
 S RCEXCEL=$$EXCEL^RCDMCUT2()                   ; Ask Excel output
 Q:RCEXCEL="^"
 I RCEXCEL D EXMSG
 ;
 Q:$$ASKDEV(0)=-1                               ; Prompt for device
 U IO
 D RUN2(RCDNUM,RCDDT,RCEXCEL)                   ; Output the report
 Q
 ;
 ; PRCA*4.5*380 - Added subroutine
ASKDNUM() ; Ask the user for the deposit number to select
 ; Input:   None
 ; Returns: -1 - User quit or timed out
 ;           Deposit Number
 N DA,DIR,DIRUT,DIROUT,DTOUT,DUOUT,X,Y
DNUM2 ; looping tag
 S DIR(0)="344.3,.06"
 S DIR("A")="Enter Deposit Number"
 S DIR("?")="Enter a valid deposit number"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") Q -1
 I '$D(^RCY(344.3,"ADEP2",X)) D  G DNUM2
 .  W *7,"Deposit Number: ",X," does not exist"
 Q X
 ;
 ; PRCA*4.5*380 - Added subroutine
SELDT(CTR,ARR) ; Ask the user to select a deposit date for the selected Deposit Number
 ; Input:   CTR - Current # of choices displayed
 ;          ARR - Array of available choices ARR(A1)=A2 Where:
 ;                  A1 - Selection #
 ;                  A2 - Deposit Date
 ; Returns: ""  - Nothing selected, Otherwise selected deposit date is returned
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="NA^1:"_CTR_":0",DIR("A")="CHOOSE 1 - "_CTR_": "
 S DIR("?")="Select a number between 1 and "_CTR
 D ^DIR
 Q $S($D(DIRUT):"",1:ARR(Y))
 ; 
 ; PRCA*4.5*380 - Added subroutine
ASKDEV(WHICH) ; Prompt user for device
 ; Input:   WHICH - 0 - Original summary report, 1 - New summary report
 ; Retunrs: -1 - Unable to open device, 1 otherwise
 ; Prompt for device
 N %ZIS,POP,ZTSK,ZTRTN,ZTIO,ZTDESC,ZTSAVE
 S %ZIS="QM"
 D ^%ZIS
 Q:POP -1
 I $D(IO("Q")) D  Q 1
 . S:WHICH=1 ZTRTN="RUN^RCDPTAR1(RCDT1,RCDT2,RCEXCEL)"
 . S:WHICH=2 ZTRTN="RUN2^RCDPTAR1(RCDNUM,RCDDT,RCEXCEL)"
 . S ZTIO=ION
 . S ZTSAVE("*")=""
 . S ZTDESC="EFT TRANSACTION SUMMARY REPORT"
 . D ^%ZTLOAD
 . W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 . D HOME^%ZIS
 Q 1
 ;
RUN(RCDT1,RCDT2,RCEXCEL) ; Compile and run the report (original summary mode)
 ; Input:   RCDT1   - Start Date
 ;          RCDT2   - End Date
 ;          RCEXCEL - 1 - Excel output, 0 otherwise
 ;
 D COMPILE(RCDT1,RCDT2)
 ;
 D REPORT(RCDT1,RCDT2,RCEXCEL)
 K ^TMP("RCDPTAR1",$J)
 Q
 ;
 ; PRCA*4.5*380 - Added subroutine
RUN2(RDNUM,RCDDT,RCEXCEL) ; Compile and run the report (new summary mode)
 ; Input:   RCDNUM  - Deposit Number
 ;          RCDDT   - Deposit Date
 ;          RCEXCEL - 1 - Excel output, 0 otherwise
 ;
 D COMPILE2(RCDNUM,RCDDT)                       ; Compile the report
 ;
 D REPORT2(RCDNUM,RCDDT,RCEXCEL)                ; Display the report
 K ^TMP("RCDPTAR1",$J)
 Q
 ;
COMPILE(RCDT1,RCDT2) ; Compile the report (original summary mode)
 ; Input:   RCDT1   - Start Date
 ;          RCDT2   - End Date
 N EFTDATA,EFTIEN,LOCKDATA,LOCKIEN,MDATE,RCDT,XX
 ;
 K ^TMP("RCDPTAR1",$J)
 S RCDT=RCDT1-.0001,RCDT2=RCDT2_".9999"
 F  D  Q:'RCDT!(RCDT>RCDT2)
 . S RCDT=$O(^RCY(344.3,"ARECDT",RCDT))
 . Q:'RCDT!(RCDT>RCDT2)
 . S LOCKIEN=""
 . F  D  Q:'LOCKIEN
 . . S LOCKIEN=$O(^RCY(344.3,"ARECDT",RCDT,LOCKIEN))
 . . Q:'LOCKIEN
 . . S LOCKDATA=$G(^RCY(344.3,LOCKIEN,0))
 . . ;
 . . ; Deposit-0|3 (P344.1);Date Posted-0|11;
 . . S EFTIEN=""
 . . F  D  Q:'EFTIEN
 . . . S EFTIEN=$O(^RCY(344.31,"B",LOCKIEN,EFTIEN))
 . . . Q:'EFTIEN
 . . . S EFTDATA=$G(^RCY(344.31,EFTIEN,0))
 . . . ;
 . . . ; Date Received-0|13;Amount-0|7;Match Status-0|8 (hist);Trace-0|4;Payer Name-0|2;Payer ID-0|3
 . . . S MDATE=$$MDATE($P(EFTDATA,U,8),EFTIEN)
 . . . ;
 . . . ; Date Received^Deposit #^EFT Amount^Date Matched^Date Posted^Trace #^Payer Name^Payer ID^Stale/Lock
 . . . S ^TMP("RCDPTAR1",$J,EFTIEN)=$$DATE^RCDPRU($P(EFTDATA,U,13),"2ZD")_U_$$GET1^DIQ(344.3,LOCKIEN_",",.03,"E")
 . . . S $P(^TMP("RCDPTAR1",$J,EFTIEN),U,3)=$P(EFTDATA,U,7)
 . . . S $P(^TMP("RCDPTAR1",$J,EFTIEN),U,4)=$$DATE^RCDPRU(MDATE,"2ZD")
 . . . S $P(^TMP("RCDPTAR1",$J,EFTIEN),U,5)=$$DATE^RCDPRU($P(LOCKDATA,U,11),"2ZD")
 . . . S $P(^TMP("RCDPTAR1",$J,EFTIEN),U,6)=$P(EFTDATA,U,4)
 . . . S $P(^TMP("RCDPTAR1",$J,EFTIEN),U,7)=$P(EFTDATA,U,2)
 . . . S $P(^TMP("RCDPTAR1",$J,EFTIEN),U,8)=$P(EFTDATA,U,3)
 . . . S $P(^TMP("RCDPTAR1",$J,EFTIEN),U,9)=$$AGED^RCDPTAR(EFTIEN)
 ;
 Q
 ;
MDATE(STATUS,EFTIEN) ; Finds the Match Date from the Match History Global for the EFT
 ; Input:   STATUS  - Internal value from the EFT MATCH STATUS field
 ;          EFTIEN  - EDI THIRD PARTY EFT DETAIL (#344.31) IEN
 ; Returns: Match Date from the MATCH STATUS HISTORY (#344.314) multiple
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
 ; PRCA*4.5*380 - Added subroutine
COMPILE2(RCDNUM,RCDDT) ; Compile the report (new summary mode)
 ; Input:   RCDNUM  - Deposit Number
 ;          RCDDT   - Deposit Date
 N EFTDATA,EFTIEN,GTOT,RCDIEN,RCDTREC,XX
 K ^TMP("RCDPTAR1",$J)
 S GTOT=0
 S RCDIEN=""
 F  D  Q:RCDIEN=""
 . S RCDIEN=$O(^RCY(344.3,"ADEP2",RCDNUM,RCDDT,RCDIEN))
 . Q:RCDIEN=""
 . S RCDTREC=$$GET1^DIQ(344.3,.13)                    ; Date/Time Added
 . S EFTIEN=""
 . F  D  Q:'EFTIEN
 . . S EFTIEN=$O(^RCY(344.31,"B",RCDIEN,EFTIEN))
 . . Q:'EFTIEN
 . . S EFTDATA=$G(^RCY(344.31,EFTIEN,0))
 . . S $P(^TMP("RCDPTAR1",$J,EFTIEN),"^",1)=RCDNUM    ; Deposit #
 . . S XX=$$DATE^RCDPRU(RCDDT,"2ZD")
 . . S $P(^TMP("RCDPTAR1",$J,EFTIEN),"^",2)=XX        ; Deposit Date
 . . S XX=$$DATE^RCDPRU($P(EFTDATA,"^",13),"2ZD")
 . . S $P(^TMP("RCDPTAR1",$J,EFTIEN),"^",3)=XX        ; Date Received
 . . S XX=$P(EFTDATA,"^",7),GTOT=GTOT+XX
 . . S $P(^TMP("RCDPTAR1",$J,EFTIEN),"^",4)=XX        ; EFT Amount of Payment
 . . S XX=$P(EFTDATA,"^",4)
 . . S $P(^TMP("RCDPTAR1",$J,EFTIEN),"^",5)=XX        ; Trace #
 . . S XX=$P(EFTDATA,"^",2)
 . . S $P(^TMP("RCDPTAR1",$J,EFTIEN),"^",6)=XX        ; Payer Name
 . . S XX=$P(EFTDATA,"^",3)
 . . S $P(^TMP("RCDPTAR1",$J,EFTIEN),"^",7)=XX        ; Payer ID
 S ^TMP("RCDPTAR1",$J)=GTOT
 Q
 ;
REPORT(RCDT1,RCDT2,RCEXCEL) ; Output the report (original summary mode)
 ; Input:   RCDT1   - Start Date
 ;          RCDT2   - End Date
 ;          RCEXCEL - 1 - Excel output, 0 otherwise
 N DATA,EFTIEN,LINES,RCHR,RCNOW,RCPG,RCSCR
 ;
 ; Initialize Report Date, Page Number and Sting of underscores
 S RCSCR=$S($E($G(IOST),1,2)="C-":1,1:0)
 S RCNOW=$$UP^XLFSTR($$NOW^RCDPRU(2)),RCPG=0,RCHR="",$P(RCHR,"-",IOM+1)=""
 ;
 ; Display header for first page
 U IO
 D HEADER(RCNOW,.RCPG,RCHR,RCDT1,RCDT2,RCEXCEL,"","")  ; PRCA*4.5*380 - Added dep. number & date to hearder call
 ;
 ; No data, display message and quit
 I '$D(^TMP("RCDPTAR1",$J)) W !,"No data found"
 ;
 ; Display the detail
 S EFTIEN=0 F  S EFTIEN=$O(^TMP("RCDPTAR1",$J,EFTIEN)) Q:'EFTIEN  D  I RCPG=0 Q
 . S DATA=^TMP("RCDPTAR1",$J,EFTIEN)
 . S LINES=$S(RCEXCEL:1,1:3)
 . I RCSCR S LINES=LINES+1
 . D CHKP(RCNOW,.RCPG,RCHR,RCDT1,RCDT2,RCEXCEL,RCSCR,LINES,"","") ; PRCA*4.5*380 - Added dep. number & date to header call
 . Q:RCPG=0
 . ; If Excel, display as delimited and quit
 . I RCEXCEL W !,$P(DATA,U,9),$$EFT(EFTIEN),U,$P(DATA,U,1,8) Q
 . ;
 . ; Display non-Excel output
 . W !,$P(DATA,U,9),$$EFT(EFTIEN),?13,$P(DATA,U,1),?25,$P(DATA,U,2),?37,$J($P(DATA,U,3),13,2),?54,$P(DATA,U,4),?69,$P(DATA,U,5)
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
 ; PRCA*4.5*380 - Added subroutine
REPORT2(RCDNUM,RCDDT,RCEXCEL) ; Output the report (new summary mode)
 ; Input:   RCDNUM  - Deposit Number
 ;          RCDDT   - Deposit Date
 ;          RCEXCEL - 1 - Excel output, 0 otherwise
 N DATA,EFTIEN,GTOT,LINES,RCHR,RCNOW,RCPG,RCSCR
 ;
 ; Initialize Report Date, Page Number and String of underscores
 S RCSCR=$S($E($G(IOST),1,2)="C-":1,1:0)
 S RCNOW=$$UP^XLFSTR($$NOW^RCDPRU(2)),RCPG=0,RCHR="",$P(RCHR,"-",IOM+1)=""
 ;
 ; Display header for first page
 U IO
 D HEADER(RCNOW,.RCPG,RCHR,"","",RCEXCEL,RCDNUM,RCDDT)
 ;
 ; No data, display message and quit
 I '$D(^TMP("RCDPTAR1",$J)) W !,"No data found"
 ;
 ; Display the detail
 S EFTIEN=0,GTOT=^TMP("RCDPTAR1",$J)
 F  S EFTIEN=$O(^TMP("RCDPTAR1",$J,EFTIEN)) Q:'EFTIEN  D  I RCPG=0 Q
 . S DATA=^TMP("RCDPTAR1",$J,EFTIEN)
 . S LINES=$S(RCEXCEL:1,1:3)
 . I RCSCR S LINES=LINES+1
 . D CHKP(RCNOW,.RCPG,RCHR,"","",RCEXCEL,RCSCR,LINES,RCDNUM,RCDDT)
 . Q:RCPG=0
 . ;
 . ; If Excel, display as delimited and quit
 . I RCEXCEL W !,$$EFT(EFTIEN),"^",DATA Q
 . ;
 . ; Display non-Excel output
 . W !,$$EFT(EFTIEN),?13,$P(DATA,"^",1),?26,$P(DATA,"^",2)
 . W ?40,$P(DATA,"^",3),?55,$J($P(DATA,"^",4),13,2)
 . W !,?4,$P(DATA,"^",5)
 . W !,?11,$P(DATA,"^",6),"/",$P(DATA,"^",7)
 ;
 I 'RCEXCEL,RCPG D
 . W !!,"Total for Deposit #: ",RCDNUM," Deposit Date: ",$$FMTE^XLFDT(RCDDT,"5DZ")
 . W ?51,$J(GTOT,13,2)
 I 'RCSCR W !,@IOF
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 ;
 I RCPG,RCSCR D PAUSE
 Q
 ;
 ; PRCA*4.5*380 - Added deposit number & deposit date
HEADER(RCNOW,RCPG,RCHR,RCDT1,RCDT2,RCEXCEL,RCDNUM,RCDDT) ; Display the report header
 ; Input:   RCNOW   - External Run Date/Time
 ;          RCPG    - Current page number
 ;          RCHR    - Dashed line
 ;          RCDT1   - Start Date or null if new summary report
 ;          RCDT2   - End Date or null if new summary report
 ;          RCEXCEL - 1 - Excel output, 0 otherwise
 ;          RCDNUM  - Deposit Number or null if original summary report
 ;          RCDDT   - Internal Deposit Date or null if original summary report
 ; Output:  RCPG    - Updated page number
 ;
 W @IOF
 ;
 ; If Excel, print column headers separated with up-arrows and quit
 I $G(RCEXCEL) D  Q
 . ; PRCA*4.5*380 - New header for Dep. Num/Date report
 . I RCDT1'="" D
 . . W !,"EFT#^DATE RECEIVED^DEPOSIT#^EFT TOTAL AMT^DATE MATCHED^DATE POSTED^TRACE #^PAYER NAME^PAYER ID"
 . E  D
 . . W !,"EFT#^DEPOSIT#^DEPOSIT DATE^DATE RECEIVED^EFT TOTAL AMT^TRACE #^PAYER NAME^PAYER ID"
 . S RCPG=1
 ;
 ; Non-Excel Header
 N LINE
 S RCPG=RCPG+1
 S LINE="EFT TRANSACTION AUDIT REPORT - SUMMARY     Page: "_RCPG
 W !?(IOM-$L(LINE)\2),LINE
 S LINE="RUN DATE: "_RCNOW
 W !?(IOM-$L(LINE)\2),LINE
 ; PRCA*4.5*380 - New header for Dep. Num/Date report
 I RCDT1'="" D  Q
 . S LINE="DATE RANGE: "_$$DATE^RCDPRU(RCDT1,"2D")_" - "_$$DATE^RCDPRU(RCDT2,"2D")_" (DATE DEPOSIT ADDED)"
 . W !?(IOM-$L(LINE)\2),LINE
 . W !!,"EFT#",?13,"DATE RECVD",?25,"DEPOSIT#",?37,"EFT TOTAL AMT",?54,"DATE MATCHED",?69,"DATE POSTED"
 . W !,?4,"TRACE #",!,?11,"PAYER NAME/ID"
 . W !,RCHR
 ;
 S LINE="DEPOSIT #: "_RCDNUM_"  Deposit Date "_$$DATE^RCDPRU(RCDDT,"2D")
 I RCDNUM'="" D
 . W !?(IOM-$L(LINE)\2),LINE
 . W !!,"EFT#",?13,"DEPOSIT#",?26,"DEPOSIT DATE",?40,"DATE RECEIVED",?55,"EFT TOTAL AMT"
 . W !,?4,"TRACE #",!,?11,"PAYER NAME/ID"
 . W !,RCHR
 ; end PRCA*4.5*380 changes
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
PAUSE() ; Display press return to continue message
 N DIR,X,Y,DTOUT,DUOUT,DIROUT,DIRUT
 S DIR(0)="E"
 D ^DIR
 Q Y
 ;
 ; PRCA*4.5*380 - Add deposit number/date to header
CHKP(RCNOW,RCPG,RCHR,RCDT1,RCDT2,RCEXCEL,RCSCR,LINES,RCDNUM,RCDDT) ; Check if we need to do a page break
 ; Input:   RCNOW   - Run date/time
 ;          RCPG    - Current Page Number
 ;          RCHR    - Dashed line
 ;          RCDT1   - Start Date or null if new summary report
 ;          RCDT2   - End Date or null if new summary report
 ;          RCEXCEL - 1 if output to Excel, 0 otherwise
 ;          RSCR    - 1 output to screen, otherwise output to paper
 ;          LINES   - Current # of lines on the page
 ;          RCDNUM  - Deposit Number or null if original summary report
 ;          RCDDT   - Deposit Date or null if original summary report
 ; Output:  RCPG    - New Page Number or 0 if user quit display
 ;
 I $Y'>(IOSL-LINES) Q
 I RCSCR,'$$PAUSE S RCPG=0 Q
 D HEADER(RCNOW,.RCPG,RCHR,RCDT1,RCDT2,RCEXCEL,RCDNUM,RCDDT)
 Q
 ;
EFT(EFTIEN) ; Format EFT output - EFT.SEQ - PRCA*4.5*326
 ; Input:   EFTIEN  - Internal EFT number
 ; Returns: EFT.Sequence #
 Q $$GET1^DIQ(344.31,EFTIEN_",",.01,"E")

RCDPTAR1 ;ALB/DMB - EFT TRANSACTION AUDIT REPORT (Summary) ;08/19/15
 ;;4.5;Accounts Receivable;**303,326,380,409,424,439,446**;Mar 20, 1995;Build 15
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
 N ARR,CDDT,CTR,DIR,DIROUT,DIRUT,DTOUT,DUOUT
 N RCDBAL,RCDDT,RCDIEN,RCDNUM,RCDT1,RCDT2,RCEXCEL,RCLOOP,RCSTOP,X,XX,Y     ; PRCA*4.5*409 - Added RCSTOP ; PRCA*4.5*439 - Added RCDBAL, RCDIEN
 S RCDNUM=$$ASKDNUM()
 Q:RCDNUM=-1
 S CTR=0,RCDDT="",CDDT="",RCSTOP=0,RCLOOP=0     ; PRCA*4.5*409 - Added RCSTOP=0,RCLOOP=0
 W !,"Select Deposit:"
 F  D  Q:RCDDT'=""  Q:RCSTOP                    ; PRCA*4.5*409 - Added Q:RCSTOP
 . S CDDT=$O(^RCY(344.3,"ADEP2",RCDNUM,CDDT),-1)
 . I CDDT="" D  Q                               ; No more Deposit Dates to display for Deposit Number
  . . Q:CTR=0
 . . S RCDDT=$$SELDT(CTR,.ARR,RCLOOP)  ; Final selection choice ; PRCA*4.5*439 add RCLOOP to call
 . . I RCDDT=-1 S RCSTOP=1
 . S CTR=CTR+1,ARR(CTR)=CDDT
 . S XX=$$FMTE^XLFDT(CDDT,"5DZ")
 . W !,$J(CTR,3)," ",RCDNUM," on: ",XX
 . S RCDIEN="",RCDBAL="1^0^0"
 . F  S RCDIEN=$O(^RCY(344.3,"ADEP2",RCDNUM,CDDT,RCDIEN)) Q:'RCDIEN  D  ; PRCA*4.5*439
 . . S RCDBAL1=$$DEPBAL^RCDPTAR2(RCDIEN)               ; Is deposit out of balance, PRCA*4.5*446
 . . S $P(RCDBAL,U,3)=$P(RCDBAL,U,3)+$P(RCDBAL1,U,3)
 . . S:'$P(RCDBAL1,U,1) $P(RCDBAL,U,1)=0        ; Check for out of balance, PRCA*4.5*446
 . W $J($P(RCDBAL,U,3),19,2)                    ; Deposit total
 . I 'RCDBAL W " **UNBALANCED**"                ; Add UNBALANCED indicator if deposit is not in balance, PRCA*4.5*439
 . I CTR#10=0 D  Q:RCDDT'=""                    ; Ask selection every 10 times
 . . S RCDDT=$$SELDT(CTR,.ARR,RCLOOP)           ; PRCA*4.5*439 add RCLOOP to parameters
 . . I RCDDT=-1 S RCSTOP=1
 Q:RCDDT=""  Q:RCSTOP                           ; No Deposit Date selected
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
SELDT(CTR,ARR,RCLOOP) ; Ask the user to select a deposit date for the selected Deposit Number
 ; Input:   CTR - Current # of choices displayed
 ;          ARR - Array of available choices ARR(A1)=A2 Where:
 ;                  A1 - Selection #
 ;                  A2 - Deposit Date
 ;          RCLOOP - Flag that indicates if selection is being made after displaying a EFT for the first time.
 ;                   Makes selection optional. PRCA*4.5*439
 ; Returns: ""  - Nothing selected, Otherwise selected deposit date is returned
 ;                -1 if user '^' or timed out
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="NA" I $G(RCLOOP) S DIR(0)="NAO"      ; PRCA*4.5*439
 S DIR(0)=DIR(0)_"^1:"_CTR_":0",DIR("A")="CHOOSE 1 - "_CTR_": "
 S DIR("?")="Select a number between 1 and "_CTR
 D ^DIR
 I $G(RCLOOP),Y="" Q -1                             ; PRCA*4.5*439
 I $G(DTOUT)!$G(DUOUT)!(Y=-1) Q -1              ; PRCA*4.5*409 Added line
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
 ;I '$L($G(RCDBAL)) S RCDBAL=1  ; If called from code that doesn't use RCDBAL, set RCDBAL to 1 to default to a balanced deposit. PRCA*4.5*439
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
 . . . S MDATE=$$MDATE^RCDPTAR2($P(EFTDATA,U,8),EFTIEN)
 . . . ;
 . . . ; Date Received^Deposit #^EFT Amount^Date Matched^Date Posted^Trace #^Payer Name^Payer ID^Stale/Lock
 . . . S ^TMP("RCDPTAR1",$J,EFTIEN)=$$DATE^RCDPRU($P(EFTDATA,U,13),"2ZD")_U_$$GET1^DIQ(344.3,LOCKIEN_",",.03,"E")
 . . . S $P(^TMP("RCDPTAR1",$J,EFTIEN),U,3)=$S($P(EFTDATA,U,16)="D":"-",1:"")_$P(EFTDATA,U,7)
 . . . S $P(^TMP("RCDPTAR1",$J,EFTIEN),U,4)=$$DATE^RCDPRU(MDATE,"2ZD")
 . . . S $P(^TMP("RCDPTAR1",$J,EFTIEN),U,5)=$$DATE^RCDPRU($P(LOCKDATA,U,11),"2ZD")
 . . . S $P(^TMP("RCDPTAR1",$J,EFTIEN),U,6)=$P(EFTDATA,U,4)
 . . . S $P(^TMP("RCDPTAR1",$J,EFTIEN),U,7)=$P(EFTDATA,U,2)
 . . . S $P(^TMP("RCDPTAR1",$J,EFTIEN),U,8)=$P(EFTDATA,U,3)
 . . . S $P(^TMP("RCDPTAR1",$J,EFTIEN),U,9)=$$AGED^RCDPTAR(EFTIEN)
 . . . S $P(^TMP("RCDPTAR1",$J,EFTIEN),U,10)=LOCKIEN   ; Save Deposit IEN, #344.3, PRCA*4.5*439
 ;
 Q
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
 . . S XX=$S($P(EFTDATA,U,16)="D":"-",1:"")_$P(EFTDATA,"^",7),GTOT=GTOT+XX
 . . S $P(^TMP("RCDPTAR1",$J,EFTIEN),"^",4)=XX        ; EFT Amount of Payment
 . . S XX=$P(EFTDATA,"^",4)
 . . S $P(^TMP("RCDPTAR1",$J,EFTIEN),"^",5)=XX        ; Trace #
 . . S XX=$P(EFTDATA,"^",2)
 . . S $P(^TMP("RCDPTAR1",$J,EFTIEN),"^",6)=XX        ; Payer Name
 . . S XX=$P(EFTDATA,"^",3)
 . . S $P(^TMP("RCDPTAR1",$J,EFTIEN),"^",7)=XX        ; Payer ID
 . . S $P(^TMP("RCDPTAR1",$J,EFTIEN),"^",10)=RCDIEN   ; Save Deposit IEN, #344.3, PRCA*4.5*439
 S ^TMP("RCDPTAR1",$J)=GTOT
 Q
 ;
REPORT(RCDT1,RCDT2,RCEXCEL) ; Output the report (original summary mode)
 ; Input:   RCDT1   - Start Date
 ;          RCDT2   - End Date
 ;          RCEXCEL - 1 - Excel output, 0 otherwise
 N DATA,EFTIEN,LINES,RCDBAL,RCDIEN,RCHR,RCNOW,RCPG,RCSCR
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
 . S RCDIEN=$P(DATA,U,10),RCDBAL=$$DEPBAL^RCDPTAR2(RCDIEN),RCDBAL=+RCDBAL,RCDBAL=$S('RCDBAL:"UNBALANCED",1:"")
 . ; If Excel, display as delimited and quit
 . I RCEXCEL W !,$P(DATA,U,9),$$EFT(EFTIEN),U,RCDBAL,U,$$DEPBAL^RCDPTAR2(RCDIEN),U,$P(DATA,U,1,8) Q
 . ;
 . ; Display non-Excel output
 . W !,$P(DATA,U,9),$$EFT(EFTIEN),?13,$P(DATA,U,1),?25,$P(DATA,U,2),?37,$J($P(DATA,U,3),13,2),?54,$P(DATA,U,4),?69,$P(DATA,U,5)
 . ;W !,?4,$P(DATA,U,6),"     ",RCDBAL    ; Display unbalanced indicator, PRCA*4.5*439
 . W !,?4,$P(DATA,U,6)                    ; Remove unbalanced indicator at EFT level, PRCA*4.5*439
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
 ;
 N DATA,EFTIEN,GTOT,LINES,RCDBAL,RCDBAL2,RCDIEN,RCHR,RCNOW,RCPG,RCSCR
 ;
 ;I '$L($G(RCDBAL)) S RCDBAL=1  ; If called from code that doesn't use RCDBAL, set RCDBAL to 1 to default to a balanced deposit. PRCA*4.5*439
 ;
 ; Initialize Report Date, Page Number and String of underscores
 S RCSCR=$S($E($G(IOST),1,2)="C-":1,1:0)
 S RCNOW=$$UP^XLFSTR($$NOW^RCDPRU(2)),RCPG=0,RCHR="",$P(RCHR,"-",IOM+1)=""
 ;
 S RCDBAL=$$DEPBAL^RCDPTAR2(RCDNUM)
 ; Display header for first page
 U IO
 D HEADER(RCNOW,.RCPG,RCHR,"","",RCEXCEL,RCDNUM,RCDDT,RCDBAL)  ; Add parameter RCDBAL PRCA*4.5*439
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
 . S RCDIEN=$P(DATA,U,10),RCDBAL=$$DEPBAL^RCDPTAR2(RCDIEN),RCDBAL2=$S('RCDBAL:"UNBALANCED",1:"")
 . ; If Excel, display as delimited and quit
 . I RCEXCEL W !,$P(DATA,U,9),$$EFT(EFTIEN),U,RCDBAL2,U,DATA Q
 . ;
 . ; Display non-Excel output
 . W !,$$EFT(EFTIEN),?13,$P(DATA,U,1),?26,$P(DATA,U,2)
 . W ?40,$P(DATA,U,3),?55,$J($P(DATA,U,4),13,2)
 . ;W !,?4,$P(DATA,U,5),"     ",RCDBAL2
 . W !,?4,$P(DATA,U,5)         ; Remove unbalanced indicator at EFT level, PRCA*4.5*439
 . W !,?11,$P(DATA,U,6),"/",$P(DATA,U,7)
 ;
 I 'RCEXCEL,RCPG D
 . W !!,"Total for Deposit #: ",RCDNUM," Deposit Date: ",$$FMTE^XLFDT(RCDDT,"5DZ")
 . ; Add coding to account for out-of-balance deposits ; PRCA*4.5*439
 . I RCDBAL W ?51,$J(GTOT,13,2) Q
 . W ?55,$J($P(RCDBAL,U,3),13,2)
 I 'RCSCR W !,@IOF
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 ;
 I RCPG,RCSCR D PAUSE
 Q
 ;
 ; PRCA*4.5*380 - Added deposit number & deposit date
HEADER(RCNOW,RCPG,RCHR,RCDT1,RCDT2,RCEXCEL,RCDNUM,RCDDT,RCDBAL) ; Display the report header
 ; Input:   RCNOW   - External Run Date/Time
 ;          RCPG    - Current page number
 ;          RCHR    - Dashed line
 ;          RCDT1   - Start Date or null if new summary report
 ;          RCDT2   - End Date or null if new summary report
 ;          RCEXCEL - 1 - Excel output, 0 otherwise
 ;          RCDNUM  - Deposit Number or null if original summary report
 ;          RCDDT   - Internal Deposit Date or null if original summary report
 ;          RCDBAL  - Piece 1: 1 if deposit is in balance, 0 otherwise   ; Add parameter PRCA*4.5*439
 ;                    Piece 2: Total of EFTs on the deposit
 ;                    Piece 3: Deposit Total
 ;
 ; Output:  RCPG    - Updated page number
 ;
 W @IOF
 ;
 I '$L($G(RCDBAL)) S RCDBAL=1  ; If called from code that doesn't use RCDBAL, set RCDBAL to 1 to default to a balanced deposit. PRCA*4.5*439
 ;
 ; If Excel, print column headers separated with up-arrows and quit
 I $G(RCEXCEL) D  Q
 . ; PRCA*4.5*380 - New header for Dep. Num/Date report
 . ; PRCA*4.5*439 - Add UNBALANCED to Excel header
 . I RCDT1'="" D
 . . W !,"EFT#^UNBALANCED^DATE RECEIVED^DEPOSIT#^EFT TOTAL AMT^DATE MATCHED^DATE POSTED^TRACE #^PAYER NAME^PAYER ID"
 . E  D
 . . W !,"EFT#^UNBALANCED^DEPOSIT#^DEPOSIT DATE^DATE RECEIVED^EFT TOTAL AMT^TRACE #^PAYER NAME^PAYER ID"
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
 S LINE="DEPOSIT #: "_RCDNUM_"  Deposit Date "_$$DATE^RCDPRU(RCDDT,"2D")_$S('RCDBAL:" **UNBALANCED**",1:"")  ;Unbalance indicator PRCA*4.5*439
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
 ;
DEPEFTS(RCDNUM,RCDDT,RCEFTCNT) ; List EFTs for a given deposit number and date. Added for PRCA*4.5*439
 ; Input - RCDNUM - Deposit #
 ;         RCDDT  - Deposit Date
 ; Output - Return value LIST(Y) containing data of selected EFT
 ;          RCEFTCNT - Count of EFTs passed by reference
 ;
 N EFTIEN,CNT,DATA,J,LIST,RCBAL,RCDBAL,RCDBAL1,RCDIEN,Y
 ;
 S (CNT,RCDIEN,RCDBAL)=0
 F  D  Q:RCDIEN=""
 . S RCDIEN=$O(^RCY(344.3,"ADEP2",RCDNUM,RCDDT,RCDIEN))
 . I RCDIEN="" Q
 . S RCDBAL1=$$DEPBAL^RCDPTAR2(RCDIEN)
 . F J=2:1:3 S $P(RCDBAL,U,J)=$P(RCDBAL1,U,J)+$P(RCDBAL,U,J)
 . S EFTIEN=""
 . F  D  Q:'EFTIEN
 . . S EFTIEN=$O(^RCY(344.31,"B",RCDIEN,EFTIEN))
 . . Q:'EFTIEN
 . . S DATA=$$EFTDATA^RCDPTAR(EFTIEN) I DATA]"" S CNT=CNT+1,LIST(CNT)=DATA
 ;
 S RCEFTCNT=CNT
 I CNT=0 W !!,"No EFT detail for this selection" D PAUSE Q ""
 ;
 ; If only one EFT, select it and quit
 I CNT=1 S Y=1 G EFT1
 ;
 ; Display list of EFTs. Manual display and reading so we can put data on two lines. PRCA*4.5*439
 N ROW,TRANS,X
 W !!,"Deposit #: "_$J($$GET1^DIQ(344.3,LOCKIEN_",",.06),10)_"   "
 W "Deposit Date: "_$$DATE^RCDPRU(RCDDT,"2DZ")
 W $J($P(RCDBAL,U,3),19,2)   ; Deposit Total
 ;I '($P(RCDBAL,U,2)=$P(RCDBAL,U,3)) W " **UNBALANCED**"   ; Remove unbalanced indicator at EFT level
 N LCNT,QUIT  ; PRCA*4.5*439
 S LCNT=0,QUIT=0,Y=-1
 F ROW=1:1:CNT D  Q:QUIT
 . S DATA=LIST(ROW),EFTIEN=$P(DATA,U,3)
 . D DISPLAY^RCDPTAR(ROW,EFTIEN)
 . ;I ROW#5=0!(ROW=CNT) D  I Y>0!(Y=-1) S QUIT=1 Q  ;
 S Y=$$READ^RCDPTAR(1,ROW,CNT)
 I Y'>0 Q 0
 ;
EFT1 ;
 Q LIST(Y)

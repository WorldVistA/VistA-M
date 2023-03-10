RCDPEFA3 ;AITC/CJE - 1ST PARTY AUTO DECREASE VS MANUAL DECREASE REPORT;Jun 06, 2014@19:11:19 ; 7/3/19 8:41am
 ;;4.5;Accounts Receivable;**345,349**;Mar 20, 1995;Build 44
 ;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; Entry point for Manual vs Auto-Decrease Adjustment Report [RCDPE FIRST PARTY MANUAL VS AUTO]
 N INPUT,RCVAUTD
 S INPUT=$$STADIV^RCDPEFA2(.RCVAUTD)                ; Division filter
 Q:'INPUT 
 S $P(INPUT,U,2)=$$DETSUM^RCDPEFA2                  ; Display detailed or summary report
 Q:$P(INPUT,U,2)=0                                  ; '^' or timeout
 S $P(INPUT,U,3)="F"
 I $P(INPUT,U,2)="D" D                              ; Select Sort Criteria
 . S $P(INPUT,U,3)=$$SORTORD^RCDPEFA2("C")
 Q:$P(INPUT,U,3)=0                                  ; '^' or timeout
 W !!,"Include first party bills where the latest decrease falls within the following"
 W !,"date range",!
 S $P(INPUT,U,4)=$$DTRNG^RCDPEFA2                   ; Select Date Range for Report
 Q:'$P(INPUT,U,4)                                   ; '^' or timeout
 S $P(INPUT,U,4)=$P($P(INPUT,U,4),"|",2,3)
 S $P(INPUT,U,5)=$$ASKLM^RCDPEARL                   ; Ask to Display in Listman Template
 Q:$P(INPUT,U,5)<0                                  ; '^' or timeout
 I $P(INPUT,U,5)=1 D  Q                             ; Compile data and call listman to display
 . D LMOUT^RCDPEFA4(INPUT,.RCVAUTD,.IO)
 I $P(INPUT,U,2)="D" D  ;
 . S $P(INPUT,U,6)=$$DISPTY^RCDPEFA2                ; Select Display Type
 Q:$P(INPUT,U,6)=-1                                 ; '^' or timeout
 D:$P(INPUT,U,6)=1 INFO^RCDPEM6                     ; Display capture information for Excel
 Q:'$$DEVICE^RCDPEFA2(.IO)                          ; Ask output device
 ;
 ; Compile and Display Report data (queued) - not allowed for EXCEL
 I $P(INPUT,U,5)'=1,$D(IO("Q")) D  Q
 . N ZTDESC,ZTQUEUED,ZTRTN,ZTSAVE,ZTSK
 . S ZTRTN="REPORT^RCDPEFA3(INPUT,.RCVAUTD,.IO)"
 . S ZTDESC="EDI LOCKBOX FIRST PARTY AUTO-DECREASE REPORT"
 . S ZTSAVE("RC*")="",ZTSAVE("INPUT")="",ZTSAVE("IO*")=""
 . D ^%ZTLOAD
 . W !!,$S($G(ZTSK):"Task number "_ZTSK_" has been queued.",1:"Unable to queue this job.")
 . K IO("Q") D HOME^%ZIS
 D REPORT(INPUT,.RCVAUTD,.IO)                       ; Create report
 ;
 K ^TMP("RCDPEFADP3",$J),^TMP("RCDPE_ADP3",$J) ; Clear ^TMP global 
 Q
 ;
REPORT(INPUTS,RCVAUTD,IO) ; Compile and print report
 ; Input:   INPUTS   - A1^A2^A3^...^An Where:
 ;                      A1 - 1 - All divisions selected, 2 - Selected divisions
 ;                      A2 - D - Detail Report, S  - Summary Report
 ;                      A3 - F - sort First to Last, L  - sort Last to First
 ;                      A4 - B1|B2
 ;                           B1 - Decrease Transaction Date Entered Start
 ;                           B2 - Decrease Transaction Date Entered End
 ;                      A5 - 1 - Output to List Manager, else 0
 ;                      A6 - 1 - Output to Excel, else 0
 ;          RCVAUTD - Array of selected Divisions, Only passed if A1=2
 ;          IO      - Output Device
 N RCTOTAL,XX,ZTREQ
 U:$P(INPUTS,"^",5)'=1 IO                   ; PRCA*4.5*349 Added check to skip if in listman mode
 K ^TMP("RCDPEFADP3",$J),^TMP("RCDPE_ADP3",$J)
 D COMPILE(INPUTS,.RCVAUTD)  ; Scan AR TRANSACTION file for entries in date range
 D DISP(INPUTS)              ; Display Report
 D ^%ZISC                    ; Close device
 Q
 ;
COMPILE(INPUTS,RCVAUTD) ; Compile Report Data
 N BEG,DAIEN,END,EXCEL,RC430IEN,RCAMT,RCBILL,RCBILL3,RCCOPAY,RCDT
 N RCSITE,RCSORT,RCTR,RCTRAND,RCUSER,STNAM,STNUM,TRANDA,X,XX
 ;
 S XX=$P(INPUTS,U,4)                        ; Auto-Post Date range
 S BEG=$$FMADD^XLFDT($P(XX,"|",1),-1)
 S END=$P(XX,"|",2)                         ; Auto-Post End Date
 S RCTR=0                                   ; Record counter
 S EXCEL=$P(INPUTS,U,6)                     ; 1 output to Excel, 0 otherwise
 S RCSORT=$P(INPUTS,U,2)                    ; Sort Type
 ;
 ; Scan index for auto-posted claim lines within the ERA
 ; and Save claim line detail to ^TMP global
 ; Get IEN of 'DECREASE ADJUSTMENT' fron #430.3
 S DAIEN=$O(^PRCA(430.3,"B","DECREASE ADJUSTMENT",""))
 ;
 ; Scan AR Transaction date index for days
 S RCTRAND=BEG
 F  S RCTRAND=$O(^PRCA(433,"AT",DAIEN,RCTRAND)) Q:'RCTRAND!(RCTRAND>END)  D
 . ;
 . ; Scan AR transactions
 . S TRANDA=""
 . F  S TRANDA=$O(^PRCA(433,"AT",DAIEN,RCTRAND,TRANDA)) Q:'TRANDA  D
 . . S RC430IEN=$$GET1^DIQ(433,TRANDA_",",.03,"I")  ; Get AR ACCOUNT
 . . Q:'RC430IEN
 . . S RCSITE=$$GET1^DIQ(430,RC430IEN_",",12,"I")   ; Get SITE ien
 . . Q:'RCSITE
 . . ;
 . . ; Ignore transaction if not a selected Division
 . . I $P(INPUTS,U,1)=2,'$D(RCVAUTD(RCSITE)) Q
 . . S RCBILL=$$GET1^DIQ(433,TRANDA_",",.03,"I")    ; Copay Claim #
 . . ; Make sure this is first party - DEBTOR is a patient
 . . Q:$$GET1^DIQ(340,$$GET1^DIQ(430,RC430IEN_",",9,"I")_",",.01,"I")'["DPT"
 . . I $D(^TMP("RCDPEFADP3",$J,"BILL",RCBILL)) Q  ; Bill already stored
 . . ; Check that the last decrease falls in the date range, if so store the results
 . . D CHKBILL(RCBILL,BEG,END,.RCTR)
 ;
 Q
 ;
CHKBILL(RCBILL,BEG,END,RCTR) ; Check date of last decrease transaction, store if inside date range.
 ; Input: RCBILL - Internal entry number to file 430. 
 ;        BEG    - Beginning date range -1 day, FileMan format
 ;        END    - Ending date range, FileMan format
 ;        RCTR   - Record counter passed by reference
 ;
 N RCAMT,RCBILL3,RCCOPAY,RCDTI,RCPROC,RCTLIS,RCTOT,RCUSER,RELEASE,STNUM,STNAME,TRANDA,X,Y
 S (TRANDA,RCDTI)=""
 F X="A","M","T" S RCTOT(X)=0
 F  S TRANDA=$O(^PRCA(433,"C",RCBILL,TRANDA)) Q:'TRANDA  D  ;
 . I $$GET1^DIQ(433,TRANDA_",",12,"E")'="DECREASE ADJUSTMENT" Q  ;
 . S X=$$GET1^DIQ(433,TRANDA_",",11,"I")
 . I X>RCDTI S RCDTI=X
 . S RCTLIS(TRANDA)=""
 ;
 ; Is last decrease inside selected date range? If not quit.
 I RCDTI'>BEG!(RCDTI>END) Q
 ;
 S RCBILL3=" "
 D DIV^RCDPEFA1(RCBILL,.STNUM,.STNAM)        ; Station name/number
 S X=$$GET1^DIQ(430,RCBILL_",",.01,"E")
 S XX=$O(^IB("ABIL",X,0))                    ; IEN in file #350
 I $$GET1^DIQ(350,XX_",",.05,"E")'="BILLED" Q  ; Ignore decrease for charges that were cancelled etc. 
 S RCCOPAY=$$GET1^DIQ(350,XX_",",.07,"E")    ; Copay Amount
 S RCPROC=$$GET1^DIQ(430,RCBILL_",",97,"E")  ; Processed by
 S RELEASE=$S(RCPROC="POSTMASTER":1,1:0)     ; Auto-release from hold if bill processed by postmaster
 ;
 ; Get all decrease transactions for this bill;
 S TRANDA=""
 F  S TRANDA=$O(RCTLIS(TRANDA)) Q:'TRANDA  D  ;
 . S RCUSER=$$GET1^DIQ(433,TRANDA_",",42,"E")     ; Get user
 . S Y=$$GET1^DIQ(433,TRANDA_",",94,"E")
 . I RCBILL3=" ",Y'="" S RCBILL3=Y
 . S X=$S(RCUSER="POSTMASTER"&(Y'=" "):"A",1:"M")
 . S RCAMT=$$GET1^DIQ(433,TRANDA_",",15,"E")      ; Transaction amount
 . S RCTOT(X)=$G(RCTOT(X))+RCAMT                  ; Running total of manual or auto decrease
 . S RCTOT("T")=$G(RCTOT("T"))+RCAMT              ; Running total decrease for this bill
 . ;
 ;
 D SAVE(RCBILL,RCBILL3,RCDTI,RCCOPAY,RELEASE,.RCTOT,.RCTR)
 S ^TMP("RCDPEFADP3",$J,"BILL",RCBILL)=""
 Q
 ;
SAVE(RCBILL,RCBILL3,RCDTI,RCCOPAY,RELEASE,RCTOT,RCTR) ; Put data into ^TMP
 ; Input:   RCBILL              - Copay Claim #
 ;          RCBILL3             - 3rd Party Claim #
 ;          RCDTI               - Auto-decrease date (internal)
 ;          RCCOPAY             - Copay Amount
 ;          RELEASE             - 1 charge was auto-released from hold, 0 otherwise
 ;          RCTOT               - Decrease totals in an array passed by reference
 ;                                   RCTOT("A") - Auto-decrease total
 ;                                   RCTOT("M") - Manual decrease total
 ;                                   RCTOT("T") - Total decrease
 ; Output:  DTOTAL()            - RCTR                - Record Counter passed by reference
 ;          ^TMP("RCDPEFADP3",$J,A1,A2,A3) = B1^B2^B3^...^Bn  Where: 
 ;                        A1 - "EXCEL" if report to excel, fileman date if not
 ;                        A2 - Excel Line Counter if to excel, Claim # if sort by claim,
 ;                        A3 - Record Counter
 ;                        B1 - External Station Name
 ;                        B2 - External Station Number
 ;                        B3 - Copay Bill Number
 ;                        B4 - 3rd Party Bill Number
 ;                        B5 - Auto-Decrease Date
 ;                        B6 - Copay Amount
 ;                        B7 - Auto-Decrease Amount
 ;                        B8 - Manual Decrease Amount
 ;                        B9 - Total decrease Amount
 ;                        B10 - Auto-release from hold flag
 ;
 N A1,A2,XX,CNT,RCDT,RCTOTAL
 S RCTR=RCTR+1
 ;
 S RCDT=$$FMTE^XLFDT(RCDTI,"2SZ")            ; Transaction date External
 ; If EXCEL sorting is done in EXCEL
 I EXCEL=1 D
 . S A1="EXCEL",A2=$G(^TMP("RCDPEFADP3",$J,A1))+1
 . S ^TMP("RCDPEFADP3",$J,A1)=A2
 ;
 ; Otherwise sort by DATE and Bill Number
 I 'EXCEL D
 . S A1=RCDTI
 . S A2=RCBILL
 ; 
 ; Update ^TMP gif claim level adjustments found for this claim
 S XX=STNAM_U_STNUM_U_$$GET1^DIQ(430,RCBILL_",",.01,"E")
 S XX=XX_U_RCBILL3_U_RCDT_U_RCCOPAY_U_RCTOT("A")_U_RCTOT("M")_U_RCTOT("T")_U_RELEASE
 S ^TMP("RCDPEFADP3",$J,"DATA",A1,A2,RCTR)=XX                    ; Claim Information
 ;
 ; Update totals for date
 S RCTOTAL=$G(^TMP("RCDPEFADP3",$J,"TOTALS",RCDTI))
 S ^TMP("RCDPEFADP3",$J,"TOTALS",RCDTI)=$$TOTAL(RCTOTAL,RCCOPAY,RELEASE,.RCTOT)
 ;
 ; Update totals for date range
 S RCTOTAL=$G(^TMP("RCDPEFADP3",$J,"TOTALS"))
 S ^TMP("RCDPEFADP3",$J,"TOTALS")=$$TOTAL(RCTOTAL,RCCOPAY,RELEASE,.RCTOT)
 ;
 Q
 ;
TOTAL(RCTOTAL,RCCOPAY,RELEASE,RCTOT) ; Increment daily or overall totals
 ; Input : RCTOTAL - old total
 ;       : RCCOPAY - COPAY amount
 ;       : RELEASE - Flag 0, 1 if bill was created by auto-releasing a charge from hold
 ;       : RCTOTAL - Array passed by reference of manual, auto and total decreases for this bill
 S $P(RCTOTAL,U,1)=$P(RCTOTAL,U,1)+RCCOPAY
 S $P(RCTOTAL,U,2)=$P(RCTOTAL,U,2)+RCTOT("A")
 S $P(RCTOTAL,U,3)=$P(RCTOTAL,U,3)+RCTOT("M")
 S $P(RCTOTAL,U,4)=$P(RCTOTAL,U,4)+RCTOT("T")
 S $P(RCTOTAL,U,5)=$P(RCTOTAL,U,5)+$S(RELEASE:1,1:0) ; # of bills created by auto-release from hold
 S $P(RCTOTAL,U,6)=$P(RCTOTAL,U,6)+1                 ; Total number of bills
 Q RCTOTAL
 ;
DISP(INPUTS) ; Format the display for screen/printer or MS Excel
 ; Input:   INPUTS  - See REPORT for details
 ;          ^TMP("RCDPEFADP",$J) - See SAVE for description
 N A1,A2,A3,DATA,EXCEL,GTOTAL,HDRINFO,LMAN,LCNT,MODE,PAGE,RCRDNUM,STOP,X,Y,DISP
 U:$P(INPUTS,"^",5)'=1 IO                   ; PRCA*4.5*349 Added check to skip if in listman mode
 S EXCEL=$P(INPUTS,U,6),LMAN=$P(INPUTS,U,5),DISP=$P(INPUTS,U,2)
 ;
 ; Header information
 S XX=$P(INPUTS,U,4)                                    ; Auto-Post Date range
 S HDRINFO("START")=$$FMTE^XLFDT($P(XX,"|",1),"2SZ")
 S HDRINFO("END")=$$FMTE^XLFDT($P(XX,"|",2),"2SZ")
 S HDRINFO("RUNDATE")=$$FMTE^XLFDT($$NOW^XLFDT,"2SZ")
 S HDRINFO("SORT")="Sorted By: Claim"
 S XX=$S($P(INPUTS,U,3)="L":"Last to First",1:"First to Last")
 S HDRINFO("SORT")=HDRINFO("SORT")_" - "_XX
 S HDRINFO("DISP")="Display: "_$S(DISP="S":"Summary",1:"Detail")
 ;
 ; Format Division filter
 S XX=$P(INPUTS,U,1)                                    ; XX=1 - All Divisions, 2- selected
 S HDRINFO("DIVISIONS")=$S(XX=2:$$LINE(.RCVAUTD),1:"ALL")
 ;
 S A1="",PAGE=0,STOP=0,LCNT=1
 I 'LMAN,DISP="S" D HDR(EXCEL,.HDRINFO,.PAGE)
 S MODE=$S($P(INPUTS,U,3)="L":-1,1:1)                   ; Mode for $ORDER
 F  D  Q:(A1="")!STOP
 . S A1=$O(^TMP("RCDPEFADP3",$J,"DATA",A1))
 . Q:A1="" 
 . I 'LMAN,DISP="D" D  Q:STOP                           ; Display Header
 . . I PAGE D ASK^RCDPEFA1(.STOP,0) Q:STOP                     ; Output to screen, quit if user wants to
 . . D HDR(EXCEL,.HDRINFO,.PAGE)
 . S A2=""
 . F  D  Q:(A2="")!STOP
 . . S A2=$O(^TMP("RCDPEFADP3",$J,"DATA",A1,A2),MODE)
 . . I 'EXCEL,A2="" D TOTALD(LMAN,.HDRINFO,.PAGE,.STOP,A1,.LCNT)
 . . Q:A2=""
 . . Q:DISP="S"  ; Skip printing details if summary report
 . . S A3=0
 . . F  D  Q:'A3!STOP
 . . . S A3=$O(^TMP("RCDPEFADP3",$J,"DATA",A1,A2,A3))
 . . . Q:'A3
 . . . S DATA=^TMP("RCDPEFADP3",$J,"DATA",A1,A2,A3)     ; Auto-Decreased Claim
 . . . I EXCEL W !,DATA Q                               ; Output to Excel
 . . . I 'LMAN,$Y>(IOSL-4) D  Q:STOP                          ; End of page
 . . . . D ASK^RCDPEFA1(.STOP,0)
 . . . . Q:STOP
 . . . . D HDR(EXCEL,.HDRINFO,.PAGE)
 . . . S Y=$P(DATA,U,3)                         ; 1st Party Bill
 . . . S $E(Y,13)=$P(DATA,U,4)                  ; 3rd Party Bill
 . . . S $E(Y,26)=$P(DATA,U,5)                  ; Decrease Date
 . . . S $E(Y,34)=$J($P(DATA,U,6),7,2)            ; Copay AMOUNT
 . . . S $E(Y,43)=$J($P(DATA,U,7),7,2)            ; Auto-Decrease Amount
 . . . S $E(Y,54)=$J($P(DATA,U,8),7,2)            ; Manual Decrease Amount
 . . . S $E(Y,66)=$J($P(DATA,U,9),7,2)            ; Total Decrease Amount
 . . . S $E(Y,80)=$S($P(DATA,U,10):"*",1:" ")   ; Auto-release flag
 . . . I LMAN D
 . . . . S ^TMP("RCDPE_ADP3",$J,LCNT)=Y,LCNT=LCNT+1
 . . . E  D
 . . . . W !,Y
 ;
 ; Grand totals
 S GTOTAL=$P($G(^TMP("RCDPEFADP3",$J,"TOTALS")),"^",6)
 I GTOTAL D
 . I 'STOP,'EXCEL D                             ; Print grand total if not Excel
 . . D TOTALG(LMAN,.HDRINFO,.PAGE,.STOP,.LCNT)
 . I 'EXCEL,'LMAN D                             ; Report finished
 . . W !,$$ENDORPRT^RCDPEARL,!
 . . D:'LMAN ASK^RCDPEFA1(.STOP,1)
 ;
 ; Null Report
 I 'GTOTAL,'LMAN D
 . I PAGE=0 D HDR(EXCEL,.HDRINFO,.PAGE)
 . W !!,?26,"*** No Records to Print ***",!
 . W !,$$ENDORPRT^RCDPEARL
 . S:'$D(ZTQUEUED) X=$$ASKSTOP^RCDPELAR
 ;
 ; List manager
 I LMAN D
 . S:LCNT=1 ^TMP("RCDPE_ADP3",$J,LCNT)=$J("",26)_"*** No Records to Print ***",LCNT=LCNT+1
 . S ^TMP("RCDPE_ADP3",$J,LCNT)=" ",LCNT=LCNT+1
 . S ^TMP("RCDPE_ADP3",$J,LCNT)=$$ENDORPRT^RCDPEARL
 ; Close device
 I '$D(ZTQUEUED) D ^%ZISC
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
LINE(DIV) ; List selected stations
 ; Input:   DIV()       - Array of selected divisions
 ; Returns: Comma delimited list of selected divisions
 N LINE,P,SUB
 S LINE="",SUB="",P=0
 F  S SUB=$O(DIV(SUB)) Q:'SUB  S P=P+1,$P(LINE,", ",P)=$G(DIV(SUB))
 Q LINE
 ;
TOTALG(LMAN,HDRINFO,PAGE,STOP,LCNT) ;
 ; Input:   LMAN    - 1 if output to Listman, 0 otherwise
 ;          HDRINFO - Array of header info
 ;          PAGE    - Current Page Number
 ;          LCNT    - Current line count (only passedif LMAN=1)
 ; Output:  PAGE    - Updated Page Number (if new header is displayed)
 ;          LCNT    - Updated line count (only passedif LMAN=1)
 N DATA,LN1,LN2
 S DATA=^TMP("RCDPEFADP3",$J,"TOTALS")
 S LN1=$$TOTALS("**** Totals for Date Range:",DATA)
 S LN2=$$PERCENTS("    Percent for Date Range:",DATA)
 ;
 I LMAN D  Q
 . S ^TMP("RCDPE_ADP3",$J,LCNT)="",LCNT=LCNT+1
 . S ^TMP("RCDPE_ADP3",$J,LCNT)=LN1,LCNT=LCNT+1
 . S ^TMP("RCDPE_ADP3",$J,LCNT)=LN2,LCNT=LCNT+1
 ;
 I $Y>(IOSL-6) D
 . D ASK^RCDPEADP(.STOP,0)
 . Q:STOP
 . D HDR(EXCEL,.HDRINFO,.PAGE)
 Q:STOP
 W !!,LN1
 W !,LN2,!
 Q
 ;
TOTALD(LMAN,HDRINFO,PAGE,STOP,DAY,LCNT) ; Totals for a single day
 ; Input:   LMAN    - 1 if output to List Template, 0 otherwise
 ;          HDRINFO - Array of header information
 ;          PAGE    - Page Number
 ;          DAY     - FileMan date to display totals for
 ;          LCNT    - Current line count (only passedif LMAN=1)
 ; Output:  PAGE    - Updated Page Number (if a new header is displayed)
 ;          STOP    - 1 if user indiacted to stop
 ;          LCNT    - Updated line count (only passedif LMAN=1)
 N DAMT,DCNT,LN1,LN2,RCCOPAY,RCDT,Y
 S RCDT=$$FMTE^XLFDT(DAY,"2Z")
 S DATA=^TMP("RCDPEFADP3",$J,"TOTALS",DAY)
 S LN1=$$TOTALS(" **Totals for Date "_RCDT_":",DATA)
 S LN2=$$PERCENTS("  Percent for Date "_RCDT_":",DATA)
 ;
 I LMAN D  Q
 . S ^TMP("RCDPE_ADP3",$J,LCNT)="",LCNT=LCNT+1
 . S ^TMP("RCDPE_ADP3",$J,LCNT)=LN1,LCNT=LCNT+1
 . S ^TMP("RCDPE_ADP3",$J,LCNT)=LN2,LCNT=LCNT+1
 . S ^TMP("RCDPE_ADP3",$J,LCNT)="",LCNT=LCNT+1
 ;
 I $Y>(IOSL-4) D
 . D ASK^RCDPEADP(.STOP,0)
 . Q:STOP
 . D HDR(EXCEL,.HDRINFO,.PAGE)
 Q:STOP
 W !!,LN1
 W !,LN2
 Q
 ;
TOTALS(LABLE,DATA) ; Build Daily or Grand Total string
 ; Input: LABLE - Text to prepend to totals line
 ;        DATA  - Delimited totals data
 ; Returns: Line of text for output to report
 N Y
 S Y=LABLE
 S $E(Y,34)=$J($P(DATA,U,1),7,2)            ; Copay AMOUNT
 S $E(Y,43)=$J($P(DATA,U,2),7,2)            ; Auto-Decrease Amount
 S $E(Y,54)=$J($P(DATA,U,3),7,2)            ; Manual Decrease Amount
 S $E(Y,66)=$J($P(DATA,U,4),7,2)            ; Total Decrease Amount
 S $E(Y,76)=$J($P(DATA,U,5),5)            ; Auto-release count
 Q Y
 ;
PERCENTS(LABLE,DATA) ; Build Daily or Grand Total percentage line
 ; Input: LABLE - Text to prepend to totals line
 ;        DATA  - Delimited totals data
 ; Returns: Line of text for output to report
 N RCCOPAY,LN,Y
 S LN=LABLE
 S RCCOPAY=$P(DATA,U,1)
 S Y=$S(RCCOPAY>0:$P(DATA,U,2)/RCCOPAY*100,1:"")
 S $E(LN,44)=$$FMT(Y,2)
 S Y=$S(RCCOPAY>0:$P(DATA,U,3)/RCCOPAY*100,1:"")_"%"
 S $E(LN,55)=$$FMT(Y,2)
 S Y=$S(RCCOPAY>0:$P(DATA,U,4)/RCCOPAY*100,1:"")_"%"
 S $E(LN,67)=$$FMT(Y,2)
 S Y=$S($P(DATA,U,6):$P(DATA,U,5)/$P(DATA,U,6)*100,1:"")
 S $E(LN,77)=$$FMT(Y,0,4)
 Q LN
 ;
FMT(VALUE,PLACES,JUST) ; Format a % value for output
 ; Input: VALUE  - Value to be formated
 ;        PLACES - Number of decimal places for number
 ;        JUST   - Length in which to $JUSTIFY (optional defaults to 7)
 ; Returns: Formated value
 N RETURN
 S RETURN=""
 I $G(JUST)="" S JUST=7
 I VALUE'="" D  ;
 . I VALUE=0!(VALUE=100) S RETURN=$FN(VALUE,"",0)
 . E  S RETURN=$FN(VALUE,"",PLACES)
 . S RETURN=RETURN_"%"
 Q $J(RETURN,JUST)
 ;
HDR(EXCEL,HDRINFO,PAGE,NOLINE) ; Print the report header
 ; Input:   EXCEL       - 1 if output to Excel, 0 otherwise
 ;          HDRINFO()   - Array of Header information
 ;          PAGE        - Current Page Number
 ;          NOLINE      - 1 to not display Claim line header
 ;                        Optional, defaults to 0
 ; Output:  PAGE        - Updated Page Number (if EXCEL=0)
 N DIV,MSG,SUB,XX,Y,Z0,Z1
 S:'$D(NOLINE) NOLINE=0
 I EXCEL D  Q
 . W !,"STATION^STATION NUMBER^COPAY BILL #^3RD PARTY BILL #^DATE^COPAY AMOUNT^AUTO-DECREASE AMOUNT^"
 . W "MANUAL DECREASE AMOUNT^TOTAL DECREASE AMOUNT^AUTO RELEASE HOLD"
 ;
 S PAGE=PAGE+1
 W @IOF
 S MSG(1)="First Party COPAY Manual vs Auto-Decrease Report"
 S MSG(1)=$J("",(80-$L(MSG(1))\2))_MSG(1)
 S MSG(1)=MSG(1)_"   Page: "_PAGE
 S MSG(2)="                        Run Date: "_HDRINFO("RUNDATE")
 S Z0="Divisions: "_HDRINFO("DIVISIONS")
 S MSG(3)=$S($L(Z0)<75:$J("",75-$L(Z0)\2),1:"")_Z0
 S XX=" (Date of Latest Decrease)"
 S MSG(4)="               Date Range: "_HDRINFO("START")_" - "_HDRINFO("END")_XX
 S MSG(5)="               "_HDRINFO("SORT")_"  "_HDRINFO("DISP")
 I $G(DISP)="D" S MSG(6)="               3rd Party            Copay   Auto-Decr  Man Decr  Total Decr  Rel"
 E  S MSG(6)="                                    Copay   Auto-Decr  Man Decr  Total Decr  Rel"
 I 'NOLINE D
 . I $G(DISP)="D" S MSG(7)="COPAY Bill #     Bill#      Date     Amt      Amt        Amt         Amt    Hold"
 . E  S MSG(7)="                                     Amt      Amt        Amt         Amt    Hold"
 . S MSG(8)=$TR($J("",80)," ","-")
 D EN^DDIOL(.MSG)
 Q
 ;

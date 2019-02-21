RCDPEADP ;OIFO-BAYPINES/PJH - AUTO-DECREASE REPORT ;Nov 23, 2014@12:48:50
 ;;4.5;Accounts Receivable;**298,318,326**;Mar 20, 1995;Build 26
 ;;Per VA Directive 6402, this routine should not be modified.
 ; Read ^DGCR(399)      via Private IA 3820
 ; Read ^DG(40.8)       via Controlled IA 417
 ; Read ^IBM(361.1)     via Private IA 4051
 ; Use DIVISION^VAUTOMA via Controlled IA 664
 ;
RPT ; entry point for Auto-Decrease Adjustment report [RCDPE AUTO-DECREASE REPORT]
 N INPUT,RCVAUTD
 S INPUT=$$STADIV(.RCVAUTD)                   ; Division filter
 Q:'INPUT                                     ; '^' or timeout
 S $P(INPUT,"^",2)=$$ASKSORT()                ; Select Sort Criteria
 Q:$P(INPUT,"^",2)="0"                        ; '^' or timeout
 S $P(INPUT,"^",3)=$$SORTORD($P(INPUT,"^",2)) ; Select Sort Order
 Q:$P(INPUT,"^",3)="0"                        ; '^' or timeout
 S $P(INPUT,"^",4)=$$DTRNG()                  ; Select Date Range for Report
 Q:'$P(INPUT,"^",4)                           ; '^' or timeout
 S $P(INPUT,"^",4)=$P($P(INPUT,"^",4),"|",2,3)
 ; PRCA*4.5*326 Filter by payer type
 S $P(INPUT,"^",7)=$$RTYPE^RCDPEU1() ; PRCA*4.5*326 Ask for payer types to include
 I $P(INPUT,"^",7)<0 Q
 S $P(INPUT,"^",6)=$$ASKLM^RCDPEARL           ; Ask to Display in Listman Template
 Q:$P(INPUT,"^",6)<0                          ; '^' or timeout
 I $P(INPUT,"^",6)=1 D  Q                     ; Compile data and call listman to display
 . D LMOUT^RCDPEAD1(INPUT,.RCVAUTD,.IO)
 S $P(INPUT,"^",5)=$$DISPTY()                 ; Select Display Type
 Q:$P(INPUT,"^",5)=-1                         ; '^' or timeout
 D:$P(INPUT,"^",5)=1 INFO^RCDPEM6             ; Display capture information for Excel
 Q:'$$DEVICE($P(INPUT,"^",5),.IO)             ; Ask output device
 ;
 ; Compile and Display Report data (queued) - not allowed for EXCEL
 I $P(INPUT,"^",5)'=1,$D(IO("Q")) D  Q
 .N ZTDESC,ZTQUEUED,ZTRTN,ZTSAVE,ZTSK
 .S ZTRTN="REPORT^RCDPEADP(INPUT,.RCVAUTD,.IO)"
 .S ZTDESC="EDI LOCKBOX AUTO-DECREASE REPORT"
 .S ZTSAVE("RC*")="",ZTSAVE("INPUT")="",ZTSAVE("IO*")=""
 .D ^%ZTLOAD
 .I $D(ZTSK) W !!,"Task number "_ZTSK_" has been queued."
 .E  W !!,"Unable to queue this job."
 .K ZTSK,IO("Q")
 .D HOME^%ZIS
 ; Compile and Display Report data (non-queued)
 D REPORT(INPUT,.RCVAUTD,.IO)                     ; Compile and Display Report data
 Q
 ;
STADIV(RCVAUTD) ; Division/Station Filter
 ; Input:   None
 ; Output:  RCVAUTD()   - Array of selected Divisions/Stations if 2 is returned
 ; Returns: 1           - All Divisions/Stations selected
 ;          2           - Specified Divisions/Stations selected
 ;          0           - "^" or timeout
 N DIR,DIROUT,DTOUT,DUOUT,VAUTD,Y
 ;
 ; Division selection - IA 664
 ; RETURNS Y=-1 (quit), VAUTD=1 (for all),VAUTD=0 (selected divisions in VAUTD)
 D DIVISION^VAUTOMA
 Q:Y<0 0
 Q:VAUTD=1 1                                ; All Divisions selected
 M RCVAUTD=VAUTD                            ; Save selected divisions
 Q 2
 ;
ASKSORT() ; Select the sort criteria
 ; Input:   None
 ; Returns: C       - Sort by Claim
 ;          P       - Sort by Payer 
 ;          N       - Sort by Patient Name
 ;          0       - User entered '^' or timed out
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,XX
 S DIR(0)="SA^C:CLAIM;P:PAYER;N:PATIENT NAME;"
 S DIR("A")="Sort by (C)LAIM #, (P)AYER or PATIENT (N)AME?: "
 S DIR("?",1)="Enter 'C' to sort by Claim Number, 'P' to sort by Payer or 'N' to sort"
 S DIR("?")="by Patient Name."
 S DIR("B")="CLAIM"
 D ^DIR
 Q:$D(DTOUT)!$D(DUOUT) 0
 Q Y
 ;
SORTORD(SORT) ; Select the sort order
 ; Input:   SORT    - 'C' - Sort by Claim Number
 ;                    'P' - Sort by Payer
 ;                    'N' - Sort by Patient Name
 ; Returns: F       - First to Last
 ;          L       - Last to First 
 ;          0       - User entered '^' or timed out
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,XX,YY
 S XX=" (F)IRST TO LAST or (L)AST TO FIRST?: "
 S YY=$S(SORT="C":"CLAIM",SORT="P":"PAYER",1:"PATIENT NAME")
 S DIR("A")="Sort "_YY_XX
 S DIR(0)="SA^F:FIRST TO LAST;L:LAST TO FIRST"
 S DIR("B")="FIRST TO LAST"
 D ^DIR
 Q:$D(DTOUT)!$D(DUOUT) 0
 Q Y
 ;
DTRNG() ; Get the date range for the report
 ; Input:   None
 ; Returns: A1|A2|A3    - Where:
 ;                          A1 - 0 - User up-arrowed or timed out, 1 otherwise
 ;                          A2 - Auto-Post Start Date
 ;                          A3 - Auto-Post End Date
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,RCEND,RCSTART,RNGFLG,X,Y
 D DATES(.RCSTART,.RCEND)
 Q:RCSTART=-1 0
 Q:RCSTART "1|"_RCSTART_"|"_RCEND
 Q:'RCSTART "0||"
 Q 0
 ;
DATES(BDATE,EDATE) ; Get a date range.
 ; Input:   None
 ; Output:  BDATE   - Internal Auto-Post Start Date
 ;          EDATE   - Internal Auto-Post End Date
D1 ; looping tag
 S (BDATE,EDATE)=0
 S DIR("?")="Enter the earliest Auto-Posting date to include on the report."
 S DIR(0)="DAO^:"_DT_":APE"
 S DIR("A")="Start Date: "
 D ^DIR
 K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S BDATE=-1 Q
 S BDATE=Y
 S DIR("?")="Enter the latest Auto-Posting date to include on the report."
 S DIR("B")=Y(0)
 S DIR(0)="DAO^"_BDATE_":"_DT_":APE"
 S DIR("A")="End Date: "
 D ^DIR
 K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S BDATE=-1 Q
 S EDATE=Y
 Q
 ;
DISPTY() ; Get display/output type
 ; Input:   None
 ; Returns: 1       - Output to Excel
 ;          0       - Output to paper 
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,Y
 S DIR(0)="Y"
 S DIR("A")="Export the report to Microsoft Excel"
 S DIR("B")="NO"
 D ^DIR
 I $G(DUOUT) Q -1
 Q Y
 ;
DEVICE(EXCEL,IO) ; Select the output device
 ; Input:   EXCEL   - 1 - Output to Excel, 0 otherwise
 ; Output:  
 ;          IO      - Array of selected output info
 ; Returns: 0       - No device selected, 1 Otherwise
 N POP,%ZIS
 S %ZIS="QM"
 D ^%ZIS
 Q:POP 0
 Q 1
 ;
REPORT(INPUTS,RCVAUTD,IO) ; EP Compile and print report
 ; Input:   INPUTS  - A1^A2^A3^...^An Where:
 ;                       A1 -  1  - All divisions selected
 ;                             2  - Selected divisions
 ;                       A2 -  C  - Sort by Claim
 ;                             P  - Sort by Payer 
 ;                             N  - Sort by Patient Name
 ;                       A3 -  F  - First to Last Sort Order
 ;                             L  - Last to First Sort Order
 ;                       A4 -  B1|B2
 ;                             B1 - Auto-Post Start Date
 ;                             B2 - Auto-Post End Date
 ;                       A5 -  1 - Output to Excel
 ;                             0 - Otherwise
 ;                       A6 -  1 - Output to List Manager
 ;                             0 - Otherwise
 ;                       A7 -  M/P/T/A = Medical/Pharmacy/Tricare/All
 ;
 ;          RCVAUTD         -  Array of selected Divisions
 ;                             Only passed if A1=2
 ;          IO      - Output Device
 ; Output:  
 N DTOTAL,GTOTAL,XX,ZTREQ
 U IO
 K ^TMP("RCDPEADP",$J),^TMP("RCDPE_ADP",$J)
 D COMPILE^RCDPEAD1(INPUTS,.RCVAUTD,.DTOTAL,.GTOTAL) ; Scan ERA file for entries in date range
 D DISP(INPUTS,.DTOTAL,.GTOTAL)              ; Display Report
 K ^TMP("RCDPEADP",$J),^TMP("RCSELPAY",$J)  ; Clear TMP global
 D ^%ZISC                                   ; Close device
 Q
 ;
SAVE(ADDATE,ERAIEN,RCRZ,EXCEL,RCSORT,CARCS,RCTR,STNAM,STNUM) ; Put the data into the ^TMP global
 ; Input:   ADDATE              - Current Internal Date being processed
 ;          ERAIEN              - Internal IEN of the ERA record
 ;          RCRZ                - ERA line number
 ;          EXCEL               - 1 output to Excel, 0 otherwise
 ;          RCSORT              - C  - Sort by Claim
 ;                                P  - Sort by Payer 
 ;                                N  - Sort by Patient Name
 ;          CARCS               - ^ delimited string of CARC information found
 ;                                on the EOB record pointed to by the ERA detail record
 ;                                A1;A2;A3;A4^B1;B2;B3;B4^...^N1;N2;N3;N4 Where:
 ;                                  A1 - Auto-Decrease amount of the 1st CARC code
 ;                                  A2 - 1st CARC code
 ;                                  A3 - Quantity of the first CARC code
 ;                                  A4 - Truncated Reason text of the 1st CARC 
 ;          DTOTAL()            - Current Array of totals by Auto-Post Date
 ;          GTOTAL              - Current Grand totals
 ;          RCTR                - Current Record Counter
 ;          STNAM               - Station name
 ;          STNUM               - Station number
 ;          ^TMP("RCDPEADP",$J) - Current report data
 ;                                See DISP for a full description
 ; Output:  DTOTAL()            - Updated Array of totals by Auto-Post Date
 ;          GTOTAL              - Updated Grand totals
 ;          RCTR                - Updated Record Counter
 ;          ^TMP("RCDPEADP",$J,A1,A2,A3) - B1^B2^B3^...^Bn Where:
 ;                          - A1 - "EXCEL" if exporting to excel
 ;                                  Internal fileman date if not exporting to excel
 ;                            A2 - Excel Line Counter if exporting to excel
 ;                                 External Claim number is sorting by claim
 ;                                 External Payer Name if sorting by Payer
 ;                                 External Patient Name if sorting by Patient Name
 ;                            A3 - Record Counter
 ;                            B1 - External Station Name
 ;                            B2 - External Station Number
 ;                            B3 - External Claim Number
 ;                            B4 - External Patient Name
 ;                            B5 - External Payer Name
 ;                            B6 - Auto-Decrease Amount
 ;                            B7 - Auto-Decrease Date
 ;          ^TMP("RCDPEADP",$J,A1,A2,A3,A4) - C1^C2^C3^C4 Where:
 ;                          - A1 - "EXCEL" if exporting to excel
 ;                                  Internal fileman date if not exporting to excel
 ;                            A2 - Excel Line Counter if exporting to excel
 ;                                 External Claim number is sorting by claim
 ;                                 External Payer Name if sorting by Payer
 ;                                 External Patient Name if sorting by Patient Name
 ;                            A3 - Record Counter
 ;                            A4 - CARC Counter
 ;                            C1 - CARC Code (file 361.111, field .01)
 ;                            C2 - Decrease Amount (file 361.111, field .02)
 ;                            C3 - Quantity (file 361.111, field .03)
 ;                            C4 - Reason (file 361.111, field .04)
 N A1,A2,AMOUNT,CARC,CLAIM,DATE,EOBIEN,PAYNAM,PTNAM,XX,Y
 S PAYNAM=$$GET1^DIQ(344.4,ERAIEN,.06,"E")              ; Payer name from ERA record
 S DATE=$$FMTE^XLFDT(ADDATE,"2SZ")                      ; Format Auto-Decrease date
 S AMOUNT=$$GET1^DIQ(344.41,RCRZ_","_ERAIEN_",",8,"I")  ; Auto-Decrease Amount
 Q:+AMOUNT=0
 S EOBIEN=$$GET1^DIQ(344.41,RCRZ_","_ERAIEN_",",.02,"I") ; IEN to file 361.1 - ERA Detail
 S CLAIM=$$CLAIM^RCDPEAD2(EOBIEN)                        ; Claim # 
 S PTNAM=$$PNM4^RCDPEWL1(ERAIEN,RCRZ)                    ; Patient Name from Claim file #399
 S:PTNAM="" PTNAM="(unknown)"
 S RCTR=RCTR+1
 ;
 ; If EXCEL sorting is done in EXCEL
 I EXCEL=1 D
 . S A1="EXCEL",A2=$G(^TMP("RCDPEADP",$J,A1))+1
 . S ^TMP("RCDPEADP",$J,A1)=A2
 ;
 ; Otherwise sort by DATE and selected criteria
 I 'EXCEL D
 . S A1=ADDATE
 . S A2=$S($E(RCSORT)="C":CLAIM,$E(RCSORT)="P":PAYNAM,1:PTNAM)
 ; 
 ; Update ^TMP global if claim level adjustments  are found for this claim
 S XX=STNAM_U_STNUM_U_CLAIM_U_PTNAM_U_PAYNAM_U_AMOUNT_U_DATE
 S ^TMP("RCDPEADP",$J,A1,A2,RCTR)=XX                    ; Claim Information
 D CARCS^RCDPEAD1(A1,A2,RCTR,CARCS)                              ; CARC information
 ;
 ; Update totals for individual date
 S $P(DTOTAL(ADDATE),U)=$P($G(DTOTAL(ADDATE)),U)+1
 S $P(DTOTAL(ADDATE),U,2)=$P($G(DTOTAL(ADDATE)),U,2)+AMOUNT
 ;
 ; Update totals for date range
 S $P(GTOTAL,U)=$P($G(GTOTAL),U)+1,$P(GTOTAL,U,2)=$P($G(GTOTAL),U,2)+AMOUNT
 Q
 ;
DISP(INPUTS,DTOTAL,GTOTAL) ; Format the display for screen/printer or MS Excel
 ; Input:   INPUTS  - A1^A2^A3^...^An Where:
 ;                       A1 -  1  - All divisions selected
 ;                             2  - Selected divisions
 ;                       A2 -  C  - Sort by Claim
 ;                             P  - Sort by Payer 
 ;                             N  - Sort by Patient Name
 ;                       A3 -  F  - First to Last Sort Order
 ;                             L  - Last to First Sort Order
 ;                       A4 -  B1|B2
 ;                             B1 - Auto-Post Start Date
 ;                             B2 - Auto-Post End Date
 ;                       A5 -  1 - Output to Excel
 ;                             0 - Otherwise
 ;                       A6 -  1 - Output to List Manager
 ;                             0 - Otherwise
 ;                       A7 -  M/P/T/A = Medical/Pharmacy/Tricare/All
 ;
 ;          IO      - Output Device
 ;          DTOTAL()- Array of totals by Internal Auto-Post date
 ;          GTOTAL  - Grand Totals for the selected date period
 ;          ^TMP("RCDPEADP",$J) - See SAVE for a complete description
 N A1,A2,A3,DATA,EXCEL,HDRINFO,LMAN,LCNT,MODE,PAGE,RCRDNUM,STOP,Y
 U IO                                       ; Use the selected device
 S EXCEL=$P(INPUTS,"^",5),LMAN=$P(INPUTS,U,6)
 ;
 ; Header information
 S XX=$P(INPUTS,"^",4)                      ; Auto-Post Date range
 S HDRINFO("START")=$$FMTE^XLFDT($P(XX,"|",1),"2SZ")
 S HDRINFO("END")=$$FMTE^XLFDT($P(XX,"|",2),"2SZ")
 S HDRINFO("RUNDATE")=$$FMTE^XLFDT($$NOW^XLFDT,"2SZ")
 s XX=$P(INPUTS,"^",2)                      ; Sort Type
 S HDRINFO("SORT")="Sorted By: "_$S(XX="C":"Claim",XX="P":"Payer",1:"Patient Name")
 S XX=$S($P(INPUTS,"^",3)="L":"Last to First",1:"First to Last")
 S HDRINFO("SORT")=HDRINFO("SORT")_" - "_XX
 ; PRCA*4.5*326 - Add M/P/T filter to report
 S XX=$P(INPUTS,"^",7) ; M/P/T/A = Medical/Pharmacy/Tricare/All
 S HDRINFO("TYPE")="Medical/Pharmacy/Tricare: "
 S HDRINFO("TYPE")=HDRINFO("TYPE")_$S(XX="M":"MEDICAL",XX="P":"PHARMACY",XX="T":"TRICARE",1:"ALL")
 ;
 ; Format Division filter
 S XX=$P(INPUTS,"^",1)                      ; XX=1 - All Divisions, 2- selected
 S HDRINFO("DIVISIONS")=$S(XX=2:$$LINE^RCDPEAD2(.RCVAUTD),1:"ALL")
 ;
 S A1="",PAGE=0,STOP=0,LCNT=1
 S MODE=$S($P(INPUTS,"^",3)="L":-1,1:1)     ; Mode for $ORDER direction
 F  D  Q:(A1="")!STOP
 . S A1=$O(^TMP("RCDPEADP",$J,A1))
 . Q:A1=""
 . I PAGE D ASK(.STOP,0) Q:STOP             ; Output to screen, quit if user wants to
 . D:'LMAN HDR^RCDPEAD1(EXCEL,.HDRINFO,.PAGE)              ; Display Header
 . ;
 . S A2=""
 . F  D  Q:(A2="")!STOP
 . . S A2=$O(^TMP("RCDPEADP",$J,A1,A2),MODE)
 . . I 'EXCEL,A2="",'LMAN D TOTALD^RCDPEAD1(EXCEL,.HDRINFO,.PAGE,.STOP,A1,.DTOTAL)
 . . Q:A2=""
 . . S A3=0
 . . F  D  Q:'A3!STOP
 . . . S A3=$O(^TMP("RCDPEADP",$J,A1,A2,A3))
 . . . Q:'A3
 . . . S DATA=^TMP("RCDPEADP",$J,A1,A2,A3)           ; Auto-Decreased Claim
 . . . I EXCEL D EXCEL^RCDPEAD2(DATA,A1,A2,A3) Q     ; Output to Excel
 . . . I LMAN D LMAN^RCDPEAD1(DATA,A1,A2,A3,.LCNT) Q
 . . . I $Y>(IOSL-4) D  Q:STOP                       ; End of page
 . . . . D ASK(.STOP,0)
 . . . . Q:STOP
 . . . . D HDR^RCDPEAD1(EXCEL,.HDRINFO,.PAGE)
 . . . S Y=$E($P(DATA,U,3),1,12)                     ; Claim #
 . . . S $E(Y,15)=$E($P(DATA,U,4),1,20)              ; Patient Name
 . . . S $E(Y,37)=$E($P(DATA,U,5),1,19)              ; Payer Name
 . . . S $E(Y,55)=$J($P(DATA,U,6),12,2)              ; Auto-Decrease  Amount
 . . . S $E(Y,69)=$P(DATA,U,7)                       ; Auto-Decrease Date
 . . . W !,Y
 . . . D DCARCS(A1,A2,A3,EXCEL,.HDRINFO,.PAGE,.STOP) ; Display CARCs
 . . . W:'EXCEL !
 ;
 ; Grand totals
 I $D(GTOTAL),'LMAN D
 . I 'STOP,'EXCEL D                                 ; Print grand total if not Excel
 . . D TOTALG^RCDPEAD1(EXCEL,.HDRINFO,.PAGE,GTOTAL,.STOP)
 . I 'STOP D                                        ; Report finished
 . . W !,$$ENDORPRT^RCDPEARL,!
 . . D ASK(.STOP,1)
 ;
 ; Null Report
 I '$D(GTOTAL),'LMAN D
 . D HDR^RCDPEAD1(EXCEL,.HDRINFO,.PAGE)
 . W !!,?26,"*** No Records to Print ***",!
 . W !,$$ENDORPRT^RCDPEARL
 . S:'$D(ZTQUEUED) X=$$ASKSTOP^RCDPELAR()
 ;
 ; List manager
 I LMAN D
 .S:LCNT=1 ^TMP("RCDPE_ADP",$J,LCNT)=$J("",26)_"*** No Records to Print ***",LCNT=LCNT+1
 .S ^TMP("RCDPE_ADP",$J,LCNT)=" ",LCNT=LCNT+1
 .S ^TMP("RCDPE_ADP",$J,LCNT)=$$ENDORPRT^RCDPEARL
 ; Close device
 I '$D(ZTQUEUED) D ^%ZISC
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
DCARCS(A1,A2,A3,EXCEL,HDRINFO,PAGE,STOP) ; Display detailes CARC information - added as part of PRCA*4.5*318 re-write 
 ; Input:   A1                  - "EXCEL" if exporting to excel
 ;                                Internal fileman date if not exporting to excel
 ;          A2                  - Excel Line Counter if exporting to excel
 ;                                External Claim number is sorting by claim
 ;                                External Payer Name if sorting by Payer
 ;                                External Patient Name if sorting by Patient Name
 ;          A3                  - Record Counter
 ;          EXCEL               - 1 if exporting to Excel, 0 otherwise
 ;          HDRINFO()           - Array of header information
 ;          PAGE                - Current Page number
 ;          ^TMP("RCDPEADP",$J) - Array of report data. See SAVE for details
 ; Output:  PAGE                - Updated Page number
 ;          STOP                - 1 if user aborts display, 0 otherwise
 N A4,DATA,FIRST,XX
 S A4="",FIRST=1
 F  D  Q:(A4="")!STOP
 . S A4=$O(^TMP("RCDPEADP",$J,A1,A2,A3,A4))
 . Q:A4=""
 . S DATA=^TMP("RCDPEADP",$J,A1,A2,A3,A4)
 . I 'EXCEL,$Y>(IOSL-4) D  Q:STOP           ; End of page
 . . D ASK(.STOP,0)
 . . Q:STOP
 . . S FIRST=1
 . . D HDR^RCDPEAD1(EXCEL,.HDRINFO,.PAGE,1)
 . I FIRST D                                ; CARC header
 . . S FIRST=0
 . . I EXCEL D  Q
 . . . W !!,"CARC^Decrease Amt^Quantity^Reason"
 . . W !!,"    CARC                  Decrease Amt    #    Reason"
 . . W !,"    --------------------  -------------  ----  -----------------------------"
 . S XX="    "_$E($P(DATA,U,1),1,20)        ; CARC
 . S $E(XX,27)=$J($P(DATA,U,2),12,2)        ; Decrease Amount
 . S $E(XX,42)=$J($P(DATA,U,3),4)           ; Quantity
 . S $E(XX,48)=$E($P(DATA,U,4),1,32)        ; Reason
 . W !,XX
 Q
 ;
ASK(STOP,TYP) ; Ask to continue, if TYP=1 then prompt to finish
 ; Input:   TYP     - 1 - Prompt to finish, 0 Otherwise
 ;          IOST    - Device Type
 ; Output:  STOP    - 1 to abort print, 0 otherwise
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 Q:$E(IOST,1,2)'["C-"                               ; Not a terminal
 S:$G(TYP)=1 DIR("A")="Enter RETURN to finish"
 S DIR(0)="E"
 W !
 D ^DIR
 I ($D(DIRUT))!($D(DUOUT)) S STOP=1
 Q

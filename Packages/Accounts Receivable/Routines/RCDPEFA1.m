RCDPEFA1 ;AITC/FA - FIRST PARTY AUTO-DECREASE REPORT ; 6/12/19 7:36am
 ;;4.5;Accounts Receivable;**345,349**;Mar 20, 1995;Build 44
 ;Per VA Directive 6402, this routine should not be modified.
 ; Read ^DG(40.8) - IA 417
 ; DIVISION^VAUTOMA - IA 664
 ;
EN ; entry point for Auto-Decrease Adjustment report [RCDPE FIRST PARTY AUTO-DECREASE]
 N INPUT,RCVAUTD,DISP
 S INPUT=$$STADIV^RCDPEFA2(.RCVAUTD)                 ; Division filter
 Q:'INPUT                                            ; '^' or timeout
 S DISP=$$DETSUM^RCDPEFA2                            ; PRCA*4.5*349 - Display detailed or summary report
 Q:DISP=0
 S $P(INPUT,U,8)=DISP
 S $P(INPUT,U,7)="A"                                 ; '^' or timeout
 I DISP="D" D  ;
 . S $P(INPUT,U,7)=$$ASKPAT^RCDPEFA2                 ; PRCA*4.5*349 - Filter by Patient or 'ALL'
 Q:$P(INPUT,U,7)=0                                   ; '^' or timeout
 S $P(INPUT,U,2)="C"
 I DISP="D" S $P(INPUT,U,2)=$$ASKSORT^RCDPEFA2       ; Select Sort Criteria
 Q:$P(INPUT,U,2)=0                                   ; '^' or timeout
 S $P(INPUT,U,3)="F"
 I DISP="D" D  ;
 . S $P(INPUT,U,3)=$$SORTORD^RCDPEFA2($P(INPUT,U,2)) ; Select Sort Order
 Q:$P(INPUT,U,3)=0                                   ; '^' or timeout
 S $P(INPUT,U,4)=$$DTRNG^RCDPEFA2                    ; Select Date Range for Report
 Q:'$P(INPUT,U,4)                                    ; '^' or timeout
 S $P(INPUT,U,4)=$P($P(INPUT,U,4),"|",2,3)
 S $P(INPUT,U,6)=$$ASKLM^RCDPEARL                    ; Ask to Display in Listman Template
 Q:$P(INPUT,U,6)<0                                   ; '^' or timeout
 I $P(INPUT,U,6)=1 D  Q                              ; Compile data and call listman to display
 . D LMOUT(INPUT,.RCVAUTD,.IO)
 I DISP="D" S $P(INPUT,U,5)=$$DISPTY^RCDPEFA2        ; Select Display Type
 Q:$P(INPUT,U,5)=-1                                  ; '^' or timeout
 I $P(INPUT,U,5)=1 D INFO^RCDPEM6                    ; Display capture information for Excel
 Q:'$$DEVICE^RCDPEFA2(.IO)                           ; Ask output device
 ;
 ; Compile and Display Report data (queued) - not allowed for EXCEL
 I $P(INPUT,U,5)'=1,$D(IO("Q")) D  Q
 . N ZTDESC,ZTQUEUED,ZTRTN,ZTSAVE,ZTSK
 . S ZTRTN="REPORT^RCDPEFAD(INPUT,.RCVAUTD,.IO)"
 . S ZTDESC="EDI LOCKBOX FIRST PARTY AUTO-DECREASE REPORT"
 . S ZTSAVE("RC*")="",ZTSAVE("INPUT")="",ZTSAVE("IO*")=""
 . D ^%ZTLOAD
 . W !!,$S($G(ZTSK):"Task number "_ZTSK_" has been queued.",1:"Unable to queue this job.")
 . K IO("Q") D HOME^%ZIS
 D REPORT(INPUT,.RCVAUTD,.IO)                       ; Create report 
 Q
 ;
REPORT(INPUTS,RCVAUTD,IO) ;EP Compile and print report
 ; Input:   INPUTS   - A1^A2^A3^...^An Where:
 ;                      A1 - 1 - All divisions selected, 2 - Selected divisions
 ;                      A2 - C - Sort by Claim, N  - Sort by Patient Name
 ;                      A3 - F - sort First to Last, L  - sort Last to First
 ;                      A4 - B1|B2
 ;                           B1 - Auto-Post Start Date
 ;                           B2 - Auto-Post End Date
 ;                      A5 - 1 - Output to Excel, else 0
 ;                      A6 - 1 - Output to List Manager, else 0
 ;                      A7 - C1|C2 
 ;                           C1 - P - Filter list by Patient
 ;                                A - Show all 1st Party Auto-Decreases"
 ;                           C2 - IEN into file #2 (if C1=P, null otherwise)
 ;          RCVAUTD - Array of selected Divisions, Only passed if A1=2
 ;          IO      - Output Device
 N DTOTAL,GTOTAL,XX,ZTREQ
 U IO
 K ^TMP("RCDPEFADP",$J),^TMP("RCDPE_ADP",$J)
 D COMPILE(INPUTS,.RCVAUTD,.DTOTAL,.GTOTAL) ; Scan AR TRANSACTION file for entries in date range
 D DISP(INPUTS,.DTOTAL,.GTOTAL)             ; Display Report
 K ^TMP("RCDPEFADP",$J),^TMP("RCSELPAY",$J) ; Clear ^TMP global
 D ^%ZISC                                   ; Close device
 Q
 ;
COMPILE(INPUTS,RCVAUTD,DTOTAL,GTOTAL) ;EP Generate the Auto-Decrease report ^TMP array
 ; Input:   INPUTS              - See REPORT for details
 ;          RCVAUTD             - Array of Divisions
 ;                                Only passed if A1=2
 ; Output:  DTOTAL              - Array of totals by Auto-Post Date
 ;          GTOTAL              - Grand totals
 ;          ^TMP("RCDPEFADP",$J)- Array of report data, See SAVE for a full description
 N AMT,BEG,DAIEN,END,EXCEL,PIEN,RCBILL,RCBILL3,RCCMT,RCCOPAY,RCDT,RCDTI,RCDEBTOR,RCDIEN
 N RCSITE,RCTR,RCTRAND,RCTYPE,RCSORT,RCUSER,RC430IEN,STA,STNAM,STNUM,TRANDA,XX
 ;
 S XX=$P(INPUTS,U,4)                        ; Auto-Post Date range
 S PIEN=$P($P(INPUTS,U,7),"|",2)            ; Patient IEN filter (if any)
 S BEG=$$FMADD^XLFDT($P(XX,"|",1),-1)
 S END=$P(XX,"|",2)                         ; Auto-Post End Date
 S RCTR=0                                   ; Record counter
 S EXCEL=$P(INPUTS,U,5)                     ; 1 output to Excel, 0 otherwise
 S RCSORT=$P(INPUTS,U,2)                    ; Sort Type
 ;
 ; Scan index for auto-posted claim lines within the ERA
 ; and Save claim line detail to ^TMP global
 S ^TMP("RCDPE_FAD",$J,"TCNT")=0,^TMP("RCDPE_FAD",$J,"TAMT")=0
 ;
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
 . . S RCUSER=$$GET1^DIQ(433,TRANDA_",",42,"E")     ; Get user
 . . Q:RCUSER'="POSTMASTER"                         ; Is this auto-decrease?
 . . S RCBILL=$$GET1^DIQ(433,TRANDA_",",.03,"E")    ; Copay Claim #
 . . S RCBILL3=$$GET1^DIQ(433,TRANDA_",",94,"E")    ; 3rd Party #
 . . I RCBILL3="" Q                                 ; Not a 3rd party offset
 . . S XX=$O(^IB("ABIL",RCBILL,0))                  ; IEN in file #350
 . . S RCCOPAY=$$GET1^DIQ(350,XX_",",.07,"E")       ; Copay Amount
 . . ;
 . . ; Make sure this is first party - DEBTOR is a patient
 . . Q:$$GET1^DIQ(340,$$GET1^DIQ(430,RC430IEN_",",9,"I")_",",.01,"I")'["DPT"
 . . S RCDEBTOR=$$GET1^DIQ(430,RC430IEN_",",9,"E")
 . . S RCDIEN=$$GET1^DIQ(430,RC430IEN_",",9,"I")            ; IEN of file #340
 . . S RCDIEN=$P($$GET1^DIQ(340,RCDIEN_",",.01,"I"),";",1)  ; IEN of the PATIENT DEBTOR
 . . I PIEN'="",RCDIEN'=PIEN Q                              ; Not the selected patient
 . . S RCDEBTOR=$E($$GET1^DIQ(2,RCDIEN_",",.01,"E"),1,23)
 . . S RCDEBTOR=RCDEBTOR_"/"_$E($$GET1^DIQ(2,RCDIEN_",",.09,"E"),6,9)
 . . S RCDTI=$$GET1^DIQ(433,TRANDA_",",11,"I")              ; Transaction date
 . . S RCDT=$$FMTE^XLFDT(RCDTI,"2SZ")                       ; Transaction date Externam
 . . S RCAMT=$$GET1^DIQ(433,TRANDA_",",15,"E")              ; Transaction amount
 . . D DIV(RC430IEN,.STNUM,.STNAM)                          ; Station name/number
 . . S RCCMT=$$GET1^DIQ(433,TRANDA_",",41,,"RCCMT")         ; PRCA*4.5*349 - Comments
 . . D SAVE(RCDEBTOR,RCAMT,RCBILL,RCBILL3,RCCOPAY,RCDTI,RCDT,EXCEL,RCSORT,.RCTR,STNAM,STNUM,.RCCMT)
 Q
 ;
SAVE(RCDEBTOR,RCAMT,RCBILL,RCBILL3,RCOPAY,RCDTI,RCDT,EXCEL,RCSORT,RCTR,STNAM,STNUM,RCCMT) ; Put data into ^TMP
 ; Input:   RCDEBTOR            - Patient Name
 ;          RCAMT               - Auto-Decrease amount
 ;          RCBILL              - Copay Claim #
 ;          RCBILL3             - 3rd Party Claim #
 ;          RCCOPAY             - Copay Amount
 ;          RCDTI               - Auto-decrease date (internal)
 ;          RCDT                - Auto-decrease date (external)
 ;          EXCEL               - 1 output to Excel, 0 otherwise
 ;          RCSORT              - C - Sort by Claim, N - Sort by Patient Name
 ;          DTOTAL()            - Current array of totals by Auto-Decrease Date
 ;          GTOTAL              - Current Grand total
 ;          RCTR                - Record Counter
 ;          STNAM               - Station name
 ;          STNUM               - Station number
 ;          RCCMT               - PRCA*4.5*349 - Comments
 ;          ^TMP("RCDPEFADP",$J)- Current report data
 ;                                See below for a full description
 ; Output:  DTOTAL()            - Updated array of totals by Auto-Post Date
 ;          GTOTAL              - Updated Grand totals
 ;          RCTR                - Record Counter
 ;          ^TMP("RCDPEFADP",$J,A1,A2,A3) = B1^B2^B3^...^Bn  Where: 
 ;                        A1 - "EXCEL" if report to excel, fileman date if not
 ;                        A2 - Excel Line Counter if to excel, Claim # if sort by claim,
 ;                             Patient Name if sort by Name
 ;                        A3 - Record Counter
 ;                        B1 - External Station Name
 ;                        B2 - External Station Number
 ;                        B3 - External Patient Name/SSN
 ;                        B4 - Copay Amount
 ;                        B5 - Auto-Decrease Amount
 ;                        B6 - Copay Bill Number
 ;                        B7 - 3rd Party Bill Number
 ;                        B8 - Auto-Decrease Date
 ;          ^TMP("RCDPEFADP",$J,A1,A2,A3,"CMT") = Multi-line comment added for PRCA*4.5*349
 N A1,A2,XX,CNT
 S RCTR=RCTR+1
 ;
 ; If EXCEL sorting is done in EXCEL
 I EXCEL=1 D
 . S A1="EXCEL",A2=$G(^TMP("RCDPEFADP",$J,A1))+1
 . S ^TMP("RCDPEFADP",$J,A1)=A2
 ;
 ; Otherwise sort by DATE and selected criteria
 I 'EXCEL D
 . S A1=RCDTI
 . S A2=$S($E(RCSORT)="C":RCBILL,1:RCDEBTOR)
 ; 
 ; Update ^TMP gif claim level adjustments found for this claim
 S XX=STNAM_U_STNUM_U_RCDEBTOR_U_RCOPAY_U_RCAMT_U_RCBILL_U_RCBILL3_U_RCDT
 S ^TMP("RCDPEFADP",$J,A1,A2,RCTR)=XX                    ; Claim Information
 ; PRCA*4.5*349 Begin modified block - Add comments to ^TMP
 Q:$D(RCCMT)<9
 S XX="",CNT=0 F  S XX=$O(RCCMT(XX)) Q:'XX  D
 . S CNT=CNT+1
 . S ^TMP("RCDPEFADP",$J,A1,A2,RCTR,"CMT",CNT)=RCCMT(XX)
 ; PRCA*4.5*349 End modified block
 ;
 ; Update totals for date
 S $P(DTOTAL(RCDTI),U,1)=$P($G(DTOTAL(RCDTI)),U,1)+1
 S $P(DTOTAL(RCDTI),U,2)=$P($G(DTOTAL(RCDTI)),U,2)+RCAMT
 S $P(DTOTAL(RCDTI),U,3)=$P($G(DTOTAL(RCDTI)),U,3)+RCOPAY ; PRCA*4.5*349
 ;
 ; Update totals for date range
 S $P(GTOTAL,U,1)=$P($G(GTOTAL),U,1)+1
 S $P(GTOTAL,U,2)=$P($G(GTOTAL),U,2)+RCAMT
 S $P(GTOTAL,U,3)=$P($G(GTOTAL),U,3)+RCOPAY ; PRCA*4.5*349
 Q
 ;
DISP(INPUTS,DTOTAL,GTOTAL) ; Format the display for screen/printer or MS Excel
 ; Input:   INPUTS  - See REPORT for details
 ;          DTOTAL()- Array of totals by Internal Auto-Post date
 ;          GTOTAL  - Grand Totals for the selected date period
 ;          ^TMP("RCDPEFADP",$J) - See SAVE for description
 N A1,A2,A3,DATA,EXCEL,HDRINFO,LMAN,LCNT,MODE,PAGE,RCRDNUM,STOP,X,Y,DISP
 U IO
 S EXCEL=$P(INPUTS,U,5)
 S LMAN=$P(INPUTS,U,6)
 S DISP=$P(INPUTS,U,8) ; PRCA*4.5*349
 ;
 ; Header information
 S XX=$P(INPUTS,U,4)                                    ; Auto-Post Date range
 S HDRINFO("START")=$$FMTE^XLFDT($P(XX,"|",1),"2SZ")
 S HDRINFO("END")=$$FMTE^XLFDT($P(XX,"|",2),"2SZ")
 S HDRINFO("RUNDATE")=$$FMTE^XLFDT($$NOW^XLFDT,"2SZ")
 S XX=$P(INPUTS,U,2)                                    ; Sort Type
 S HDRINFO("SORT")="Sorted By: "_$S(XX="C":"Claim",XX="P":"Payer",1:"Patient Name")
 S XX=$S($P(INPUTS,U,3)="L":"Last to First",1:"First to Last")
 S HDRINFO("SORT")=HDRINFO("SORT")_" - "_XX
 S HDRINFO("DISP")="Display: "_$S(DISP="S":"SUMMARY",1:"DETAIL") ; PRCA*4.5*349
 ;
 ; Format Division filter
 S XX=$P(INPUTS,U,1)                                    ; XX=1 - All Divisions, 2- selected
 S HDRINFO("DIVISIONS")=$S(XX=2:$$LINE(.RCVAUTD),1:"ALL")
 ;
 S A1="",PAGE=0,STOP=0,LCNT=1
 I 'LMAN,DISP="S" D HDR(EXCEL,.HDRINFO,.PAGE)
 S MODE=$S($P(INPUTS,U,3)="L":-1,1:1)                   ; Mode for $ORDER
 F  D  Q:(A1="")!STOP
 . S A1=$O(^TMP("RCDPEFADP",$J,A1))
 . Q:A1=""
 . I 'LMAN,DISP="D" D  Q:STOP
 . . I PAGE D ASK(.STOP,0) Q:STOP                         ; Output to screen, quit if user wants to
 . . D HDR(EXCEL,.HDRINFO,.PAGE)                    ; Display Header
 . S A2=""
 . F  D  Q:(A2="")!STOP
 . . S A2=$O(^TMP("RCDPEFADP",$J,A1,A2),MODE)
 . . I 'EXCEL,A2="" D TOTALD^RCDPEFA2(LMAN,.HDRINFO,.PAGE,.STOP,A1,.DTOTAL,.LCNT)
 . . Q:A2=""
 . . Q:DISP="S"  ; PRCA*4.5*349 - Skip printing details if summary report
 . . S A3=0
 . . F  D  Q:'A3!STOP
 . . . S A3=$O(^TMP("RCDPEFADP",$J,A1,A2,A3))
 . . . Q:'A3
 . . . S DATA=^TMP("RCDPEFADP",$J,A1,A2,A3)     ; Auto-Decreased Claim
 . . . I EXCEL W !,DATA Q                       ; Output to Excel
 . . . I LMAN D  Q
 . . . . N RCCMT
 . . . . M RCCMT=^TMP("RCDPEFADP",$J,A1,A2,A3,"CMT")
 . . . . D LMAN^RCDPEFA2(DATA,INPUT,.RCCMT,.LCNT)
 . . . I $Y>(IOSL-4) D  Q:STOP                  ; End of page
 . . . . D ASK(.STOP,0)
 . . . . Q:STOP
 . . . . D HDR(EXCEL,.HDRINFO,.PAGE)
 . . . S Y=$P(DATA,U,3)                         ; Patient Name/SSN last 4
 . . . S $E(Y,31)=$J($P(DATA,U,4),6,2)          ; COPAY Amount
 . . . S $E(Y,39)=$J($P(DATA,U,5),6,2)          ; Auto-Decrease Amount
 . . . S $E(Y,47)=$E($P(DATA,U,6),1,11)         ; Copay Claim #
 . . . S $E(Y,60)=$E($P(DATA,U,7),1,11)         ; Third Party Claim #
 . . . S $E(Y,73)=$P(DATA,U,8)                  ; Auto-Decrease Date
 . . . W !,Y
 . . . ; PRCA*4.5*349 Begin Modified Block
 . . . I $P($P(INPUTS,U,7),"|",3)=1 D         ; Show comment detail?
 . . . . W !,?6,"Comment:  "
 . . . . N CNT
 . . . . S CNT="" F  S CNT=$O(^TMP("RCDPEFADP",$J,A1,A2,A3,"CMT",CNT)) Q:CNT=""  D
 . . . . . W ^TMP("RCDPEFADP",$J,A1,A2,A3,"CMT",CNT),!,?11
 . . . ; PRCA*4.5*349 End Modified Block
 ;
 ; Grand totals
 I $D(GTOTAL) D
 . I 'STOP,'EXCEL D                             ; Print grand total if not Excel
 . . D TOTALG^RCDPEFA2(LMAN,.HDRINFO,.PAGE,GTOTAL,.STOP,.LCNT)
 . I 'EXCEL,'LMAN D                                   ; Report finished
 . . W !,$$ENDORPRT^RCDPEARL,!
 . . D ASK(.STOP,1)
 ;
 ; Null Report
 I '$D(GTOTAL),'LMAN D
 . I PAGE=0 D HDR(EXCEL,.HDRINFO,.PAGE)
 . W !!,?26,"*** No Records to Print ***",!
 . W !,$$ENDORPRT^RCDPEARL
 . S:'$D(ZTQUEUED) X=$$ASKSTOP^RCDPELAR
 ;
 ; List manager
 I LMAN D
 . S:LCNT=1 ^TMP("RCDPE_ADP",$J,LCNT)=$J("",26)_"*** No Records to Print ***",LCNT=LCNT+1
 . S ^TMP("RCDPE_ADP",$J,LCNT)=" ",LCNT=LCNT+1
 . S ^TMP("RCDPE_ADP",$J,LCNT)=$$ENDORPRT^RCDPEARL
 ; Close device
 I '$D(ZTQUEUED) D ^%ZISC
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
ASK(STOP,TYP) ; Ask to continue, if TYP=1 then prompt to finish
 ; Input:   TYP     - 1 - Prompt to finish, 0 Otherwise
 ; Output:  STOP    - 1 abort print, 0 otherwise
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 Q:$E(IOST,1,2)'["C-"                       ; Not a terminal
 S:$G(TYP)=1 DIR("A")="Enter RETURN to finish"
 S DIR(0)="E"
 W !
 D ^DIR
 I ($D(DIRUT))!($D(DUOUT))!($D(DUOUT)) S STOP=1
 Q
 ;
DIV(STAIEN,STNUM,STNAM) ; Get the station for this ERA
 ; Input:   DAIEN   - AR ACCOUNT IEN
 ; Output:  STNUM   - Station Number
 ;          STNAM   - Station Name
 S (STNUM,STNAM)="UNKNOWN"
 Q:'STAIEN
 S STNAM=$$GET1^DIQ(430,STAIEN_",",12,"E")
 S STNUM=$$GET1^DIQ(430,STAIEN_",",12,"I")
 Q
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
 . W !,"STATION^STATION NUMBER^PATIENT^COPAY AMOUNT^DECREASE AMOUNT^"
 . W "COPAY BILL #^3RD PARTY BILL #^AUTO DECREASE DATE"
 ;
 S PAGE=PAGE+1
 W @IOF
 S MSG(1)="             First Party COPAY Auto-Decrease Report "
 S MSG(1)=MSG(1)_"  Page: "_PAGE
 S MSG(2)="                        Run Date: "_HDRINFO("RUNDATE")
 S Z0="Divisions: "_HDRINFO("DIVISIONS")
 S MSG(3)=$S($L(Z0)<75:$J("",75-$L(Z0)\2),1:"")_Z0
 S XX=" (Date Decrease Applied)"
 S MSG(4)="               Date Range: "_HDRINFO("START")_" - "_HDRINFO("END")_XX
 S MSG(5)="               "_HDRINFO("SORT")_"  "_HDRINFO("DISP") ; PRCA*4.5*349
 S MSG(6)="                               Copay  Decrease   Copay     3rd Party"
 I 'NOLINE D
 . S MSG(7)="Patient Name/SSN                Amt     Amt      Bill#       Bill#        Date"
 . S MSG(8)=$TR($J("",80)," ","-")
 D EN^DDIOL(.MSG)
 Q
 ;
HINFO(INPUTS,HDRINFO) ; Get header information
 ; Input:   INPUTS  - See REPORT for description
 ;          HDRINFO - Header array for ListMan, passed by ref.
 N XX
 S XX=$P(INPUTS,U,4)                        ; Auto-Post Date range
 S HDRINFO("START")=$$FMTE^XLFDT($P(XX,"|",1),"2SZ")
 S HDRINFO("END")=$$FMTE^XLFDT($P(XX,"|",2),"2SZ")
 S HDRINFO("RUNDATE")=$$FMTE^XLFDT($$NOW^XLFDT,"2SZ")
 S XX=$P(INPUTS,U,2)                        ; Sort Type
 S HDRINFO("SORT")="SORTED BY: "_$S(XX="C":"CLAIM",1:"PATIENT NAME")
 S XX=$S($P(INPUTS,U,3)="L":"LAST TO FIRST",1:"FIRST TO LAST")
 S HDRINFO("SORT")=HDRINFO("SORT")_" - "_XX
 S HDRINFO("SORT")=HDRINFO("SORT")_"  DISPLAY: "_$S($P(INPUTS,U,8)="S":"SUMMARY",1:"DETAIL")
 ;
 ; Format Division filter
 S XX=$P(INPUTS,U,1)                        ; 1 - All Divisions, 2- selected
 S HDRINFO("DIVISIONS")=$S(XX=2:$$LINE(.RCVAUTD),1:"ALL")
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
LMOUT(INPUT,RCVAUTD,IO) ; Output report to Listman
 ; Input:   INPUT   - see REPORT for description
 ;          RCVAUTD - Array of selected Divisions
 ;          IO      - Device array
 ; Output:  ^TMP("RCDPE_LAR",$J,nn) - Array of display lines (no headers)
 N HDR,HDRINFO,Z0
 D REPORT(INPUT,.RCVAUTD,.IO)           ; Get lines to be displayed
 D HINFO(INPUT,.HDRINFO)
 S HDR("TITLE")="FIRST PARTY AUTO-DECREASE"
 S HDR(1)=$J("RUN DATE: ",34)_HDRINFO("RUNDATE")
 S Z0="DIVISIONS: "_HDRINFO("DIVISIONS")
 S HDR(2)=$S($L(Z0)<75:$J("",75-$L(Z0)\2),1:"")_Z0
 S HDR(3)="               DATE RANGE: "_HDRINFO("START")_" - "_HDRINFO("END")_" (DATE DECREASE APPLIED)"
 S HDR(4)=$J("",(80-$L(HDRINFO("SORT")))\2)_HDRINFO("SORT")
 S HDR(5)=" "
 S HDR(6)="                               Copay  Decrease   Copay     3rd Party"
 S HDR(7)="Patient Name/SSN                Amt     Amt      Bill#       Bill#        Date"
 D LMRPT^RCDPEARL(.HDR,$NA(^TMP("RCDPE_ADP",$J))) ; Generate ListMan display
 K ^TMP("RCDPEFADP",$J),^TMP($J,"RCDPEFADP"),^TMP("RCDPE_ADP",$J)
 Q
 ;
 ; PRCA*4.5*349 - Subroutine added
PCENT(AMNT,COPAY) ; Return percentage of dollars auto-decreased
 Q:COPAY=0 "###"
 Q $FN(AMNT/COPAY*100,"",0)

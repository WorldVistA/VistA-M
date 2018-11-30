RCDPEAD1 ;OIFO-BAYPINES/PJH - AUTO-DECREASE REPORT ;Nov 23, 2014@12:48:50
 ;;4.5;Accounts Receivable;**298,318**;Mar 20, 1995;Build 37
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
CARCS(A1,A2,A3,CARCS) ; Get CARC Auto-Decrease data
 ; Input:   A1              - "EXCEL" if exporting to excel
 ;                            Internal fileman date if not exporting to excel
 ;          A2              - Excel Line Counter if exporting to excel
 ;                            External Claim number is sorting by claim
 ;                            External Payer Name if sorting by Payer
 ;                            External Patient Name if sorting by Patient Name
 ;          A3              - Record Counter
 ;          CARCS           - ^ delimited string of CARC information
 ;                            See SAVE for a complete description
 ; Output:  ^TMP("RCDPEADP",$J,A1,A2,A3,A4) - C1^C2^C3^C4 Where:
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
 N AMT,CARC,CCTR,OCARC,QUANT,REASON,XX
 ;
 ; Loop through all of the valid CARCs found in the EOB record
 F CCTR=1:1:$L(CARCS,"^") D
 . S OCARC=$P(CARCS,"^",CCTR)
 . S CARC=$P(OCARC,";",2)                   ; CARC Code
 . S AMT=$P(OCARC,";",1)                    ; Amount
 . S QUANT=$P(OCARC,";",3)                  ; Quantity
 . S REASON=$P(OCARC,";",4)                 ; Reason Text
 . S XX=CARC_"^"_AMT_"^"_QUANT_"^"_REASON
 . S ^TMP("RCDPEADP",$J,A1,A2,A3,CCTR)=XX
 Q
 ;
COMPILE(INPUTS,RCVAUTD,DTOTAL,GTOTAL) ; EP Generate the Auto-Decrease report ^TMP array
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
 ;                             2 - Otherwise
 ;          RCVAUTD     - Array of selected Divisions
 ;                        Only passed if A1=2
 ; Output:  DTOTAL()            - Array of totals by Auto-Post Date
 ;          GTOTAL              - Grand totals
 ;          ^TMP("RCDPEADP",$J) - Array of report data
 ;                                See SAVE for a full description
 N ADDATE,CARCS,END,ERAIEN,EOBIEN,EXCEL,RCTR,RCRZ,RCSORT,STA,STNAM,STNUM,XX
 ;
 S XX=$P(INPUTS,"^",4)                      ; Auto-Post Date range
 S ADDATE=$$FMADD^XLFDT($P(XX,"|",1),-1)
 S END=$P(XX,"|",2)                         ; Auto-Post End Date
 S RCTR=0                                   ; Record counter
 S EXCEL=$P(INPUTS,"^",5)                   ; 1 output to Excel, 0 otherwise
 S RCSORT=$P(INPUTS,"^",2)                  ; Sort Type
 ;
 ; ^RCY(344.4,0) = "ELECTRONIC REMITTANCE ADVICE^344.4I^"
 ;                 G cross-ref.   REGULAR    WHOLE FILE (#344.4)
 ;                 Field:  AUTO-POST DATE  (344.41,9)
 ; Scan G index for ERA within date range
 F  S ADDATE=$O(^RCY(344.4,"G",ADDATE)) Q:'ADDATE  Q:(ADDATE\1)>END  D
 . S ERAIEN=""
 . F  D  Q:'ERAIEN
 . . S ERAIEN=$O(^RCY(344.4,"G",ADDATE,ERAIEN))
 . . Q:'ERAIEN
 . . D ERASTA(ERAIEN,.STA,.STNUM,.STNAM)        ; Check for valid Division
 . . I $P(INPUTS,"^",1)=2,'$D(RCVAUTD(STA)) Q   ; Not a valid Division
 . . ;
 . . ; Scan index for auto-decreased claim lines within the ERA
 . . ; and Save claim line detail to ^TMP global
 . . S RCRZ=""
 . . F  D  Q:'RCRZ
 . . . S RCRZ=$O(^RCY(344.4,"G",ADDATE,ERAIEN,RCRZ))
 . . . Q:'RCRZ
 . . . S EOBIEN=$$GET1^DIQ(344.41,RCRZ_","_ERAIEN_",",.02,"I")
 . . . ;
 . . . ; Find all Claim level and Claim line level CARCs
 . . . S CARCS=$$CARCLMT^RCDPEAD(EOBIEN,1,ADDATE)
 . . . Q:+CARCS=0                               ; No CARCs found
 . . . D SAVE^RCDPEADP(ADDATE,ERAIEN,RCRZ,EXCEL,RCSORT,CARCS,.RCTR,STNAM,STNUM)
 Q
 ;
ERASTA(ERAIEN,STA,STNUM,STNAM) ; Get the station for this ERA
 ; Input:   ERAIEN  - Internal IEN for file 344.4
 ; Output:  STA     - Internal Station IEN
 ;          STNUM   - Station Number
 ;          STNAM   - Station Name
 N ERAEOB,ERABILL,STAIEN
 S (ERAEOB,ERABILL)=""
 S (STA,STNUM,STNAM)="UNKNOWN"
 S ERAEOB=$$GET1^DIQ(344.41,"1,"_ERAIEN_",",.02,"I")
 Q:'ERAEOB
 S ERABILL=$$GET1^DIQ(361.1,ERAEOB,.01,"I")
 Q:'ERABILL
 S STAIEN=$$GET1^DIQ(399,ERABILL,.22,"I")
 Q:'STAIEN
 S STA=STAIEN
 S STNAM=$$EXTERNAL^DILFD(399,.22,,STA)
 S STNUM=$$GET1^DIQ(40.8,STAIEN,1,"I")
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
 . W !,"STATION^STATION NUMBER^CLAIM #^PATIENT NAME^PAYER^DECREASE AMOUNT^DATE^CARC"
 . W "^DECREASE AMT^#^REASON"
 ;
 S PAGE=PAGE+1
 W @IOF
 S MSG(1)="                     EDI Lockbox Auto-Decrease Adjustment Report "
 S MSG(1)=MSG(1)_"       Page: "_PAGE
 S MSG(2)="                        Run Date: "_HDRINFO("RUNDATE")
 S Z0="Divisions: "_HDRINFO("DIVISIONS")
 S MSG(3)=$S($L(Z0)<75:$J("",75-$L(Z0)\2),1:"")_Z0
 S XX=" (Date Decrease Applied)"
 S MSG(4)="               Date Range: "_HDRINFO("START")_" - "_HDRINFO("END")_XX
 S MSG(5)="                "_HDRINFO("SORT")
 S MSG(6)=""
 I 'NOLINE D
 . S MSG(7)="Claim #       Patient Name          Payer             Decrease Amt  Date    "
 . S MSG(8)="============================================================================"
 D EN^DDIOL(.MSG)
 Q
 ;
HINFO(INPUTS,HDRINFO) ;Get header information
 ; Input:   INPUTS       - See REPORT^RCDPEADP for a complete description
 ;          HDRINFO      - Return array - passed by reference
 ; Output:  HDRINFO      - Formatted header array for ListMan
 N XX
 S XX=$P(INPUTS,"^",4)                      ; Auto-Post Date range
 S HDRINFO("START")=$$FMTE^XLFDT($P(XX,"|",1),"2SZ")
 S HDRINFO("END")=$$FMTE^XLFDT($P(XX,"|",2),"2SZ")
 S HDRINFO("RUNDATE")=$$FMTE^XLFDT($$NOW^XLFDT,"2SZ")
 s XX=$P(INPUTS,"^",2)                      ; Sort Type
 S HDRINFO("SORT")="SORTED BY: "_$S(XX="C":"CLAIM",XX="P":"PAYER",1:"PATIENT NAME")
 S XX=$S($P(INPUTS,"^",3)="L":"LAST TO FIRST",1:"FIRST TO LAST")
 S HDRINFO("SORT")=HDRINFO("SORT")_" - "_XX
 ; Format Division filter
 S XX=$P(INPUTS,"^",1)                      ; XX=1 - All Divisions, 2- selected
 S HDRINFO("DIVISIONS")=$S(XX=2:$$LINE^RCDPEADP(.RCVAUTD),1:"ALL")
 Q
 ;
LMAN(DATA,A1,A2,A3,XX) ; Format and save List Manager line
 ; Input:   DATA - ERA line adjustment total
 ;          A1,A2,A3 - ^TMP("RCDPEAP") subscripts
 ;          XX - List Counter for ^TMP("RCDPE_ADP",$J)
 N CARCAMT,CCTR,DATA1,Y
 S Y=$E($P(DATA,U,3),1,12)                     ; Claim #
 S $E(Y,15)=$E($P(DATA,U,4),1,20)              ; Patient Name
 S $E(Y,37)=$E($P(DATA,U,5),1,19)              ; Payer Name
 S $E(Y,55)=$J($P(DATA,U,6),12,2)              ; Auto-Decrease  Amount
 S $E(Y,69)=$P(DATA,U,7)                       ; Auto-Decrease Date
 S ^TMP("RCDPE_ADP",$J,XX)=Y,XX=XX+1
 S ^TMP("RCDPE_ADP",$J,XX)=" ",XX=XX+1
 S ^TMP("RCDPE_ADP",$J,XX)="    CARC                  Decrease Amt    #    Reason",XX=XX+1
 S ^TMP("RCDPE_ADP",$J,XX)="    --------------------  -------------  ----  -----------------------------",XX=XX+1
 S CCTR=0
 F  S CCTR=$O(^TMP("RCDPEADP",$J,A1,A2,A3,CCTR)) Q:'CCTR  D
 . ;Display a line for each CARC adjustment on the line
 . S DATA1=$G(^TMP("RCDPEADP",$J,A1,A2,A3,CCTR)),CARCAMT=$P(DATA1,U,2)
 . S Y="    "_$E($P(DATA1,U,1),1,20)        ; CARC
 . S $E(Y,27)=$J($P(DATA1,U,2),12,2)        ; Decrease Amount
 . S $E(Y,42)=$J($P(DATA1,U,3),4)           ; Quantity
 . S $E(Y,48)=$E($P(DATA1,U,4),1,32)        ; Reason
 . S ^TMP("RCDPE_ADP",$J,XX)=Y,XX=XX+1
 S ^TMP("RCDPE_ADP",$J,XX)=" ",XX=XX+1
 Q
 ;
LMOUT(INPUT,RCVAUTD,IO) ; EP Output report to Listman
 ; Input:   INPUT       - See REPORT for a complete description
 ;          RCVAUTD     -  Array of selected Divisions
 ;                         Only passed if A1=2
 ;          IO          -  Output device array
 ; Output:  ^TMP("RCDPE_LAR",$J,CTR)=Line - Array of display lines (no headers)
 ;                                           for output to Listman
 ;                                           Only set when A7-1
 N HDR,HDRINFO,XX,Z0
 D REPORT^RCDPEADP(INPUT,.RCVAUTD,.IO)                    ; Get the lines to be displayed
 D HINFO(INPUT,.HDRINFO)
 S HDR("TITLE")="AUTO-DECREASE REPORT"
 S HDR(1)="                        RUN DATE: "_HDRINFO("RUNDATE")
 S Z0="DIVISIONS: "_HDRINFO("DIVISIONS")
 S HDR(2)=$S($L(Z0)<75:$J("",75-$L(Z0)\2),1:"")_Z0
 S XX=" (DATE DECREASE APPLIED)"
 S HDR(3)="               DATE RANGE: "_HDRINFO("START")_" - "_HDRINFO("END")_XX
 S HDR(4)="                "_HDRINFO("SORT")
 S HDR(5)=""
 S HDR(6)=""
 S HDR(7)="CLAIM #       PATIENT NAME          PAYER             DECREASE AMT  DATE    "
 D LMRPT^RCDPEARL(.HDR,$NA(^TMP("RCDPE_ADP",$J))) ; Generate ListMan display
 ;
 K ^TMP("RCDPEADP",$J),^TMP($J,"RCDPEADP"),^TMP("RCDPE_ADP",$J)
 Q
 ;
TOTALD(EXCEL,HDRINFO,PAGE,STOP,DAY,DTOTAL) ; Totals for a single day
 ; Input:   EXCEL       - 1 if output to Excel, 0 otherwise
 ;          HDRINFO()   - Array of header information
 ;          PAGE        - Current Page Number
 ;          DAY         - Internal Fileman date to display totals for
 ;          DTOTAL()    - Array of totals by day
 ;          IOSL        - Page length
 ; Output:  PAGE        - Updated Page Number (if a new header is displayed)
 ;          STOP        - 1 if displaying to screen and user asked to stop
 N DAMT,DCNT,Y
 I 'EXCEL,$Y>(IOSL-4) D
 . D ASK^RCDPEADP(.STOP,0)
 . Q:STOP
 . D HDR(EXCEL,.HDRINFO,.PAGE)
 Q:STOP
 S DCNT=$P(DTOTAL(DAY),U),DAMT=$P(DTOTAL(DAY),U,2)
 S Y="**Totals for Date: "_$$FMTE^XLFDT(DAY,"2Z")
 S $E(Y,35)="    # of Decrease Adjustments: "_DCNT
 W !!,Y
 S Y="",$E(Y,28)="Total Amount of Decrease Adjustments: $"_$J(DAMT,3,2)
 W !,Y
 Q
 ;
 ;TOTALS ; Print totals for EXCEL
 ;N DAY,DAMT,DCNT
 ;S DAY=""
 ;F  S DAY=$O(DTOTAL(DAY)) Q:'DAY  D  Q:STOP
 ;.;Day totals
 ;.D TOTALD(DAY)
 ;;Grand totals
 ;D TOTALG
 ;Q
 ;
TOTALG(EXCEL,HDRINFO,PAGE,GTOTAL,STOP) ; Overall report total
 ; Input:   EXCEL       - 1 if output to Excel, 0 otherwise
 ;          HDRINFO()   - Array of header information
 ;          PAGE        - Current Page Number
 ;          GTOTAL()    - Grand Totals for report
 ;          IOSL        - Page length
 ; Output:  PAGE        - Updated Page Number (if a new header is displayed)
 N Y
 I 'EXCEL,$Y>(IOSL-6) D
 . D ASK^RCDPEADP(.STOP,0)
 . Q:STOP
 . D HDR(EXCEL,.HDRINFO,.PAGE)
 Q:STOP
 W !!,"**** Totals for Date Range:           # of Decrease Adjustments: "_+$P(GTOTAL,U,1)
 S Y="",$E(Y,28)="Total Amount of Decrease Adjustments: $"_$J((+$P(GTOTAL,U,2)),3,2)
 W !,Y,!
 Q
 ;

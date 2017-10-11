RCDPEDA2 ;EDE/DW - ACTIVITY REPORT ;Feb 17, 2017@10:37:00
 ;;4.5;Accounts Receivable;**318**;Mar 20, 1995;Build 37
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
RPT2(INPUT) ; Entry point from RCDPEDAR
 ; Loop through EDI LOCKBOX DEPOSIT entries
 ; Input:   INPUT                           - A1^A2^A3^...^An Where:
 ;                                             A1 - 1 - Called by nightly job, 0 otherwise
 ;                                             A2 - 1 - Display to list manager, 0 otherwise
 ;                                             A3 - 1 - Detail report, 0 - Summary report
 ;                                             A4 - Current Page Number
 ;                                             A5 - Stop Flag
 ;                                             A6 - Start of Date Range
 ;                                             A7 - End of Date Range
 ;                                             A8 - Current Line Number
 ;                                             A9 - Internal Date being processed
 ;          ^TMP(B1,$J,B2,B3)               = ""
 ;          ^TMP(B1,$J,B2,B3,"EFT",B4)      = "" Where:
 ;                                            B1 - "RCDAILYACT"
 ;                                            B2 - Internal Date from DATE/TIME ADDED
 ;                                                 (344.3, .13)
 ;                                            B3 - Internal IEN for 344.3
 ;                                            B4 - Internal IEN for file 344.31
 ; Output:  INPUT                           - A1^A2^A3^...^An - The following pieces 
 ;                                                              may be updated
 ;                                             A4 - Updated Page Number
 ;                                             A5 - Stop Flag
 ;                                             A6 - Updated Line number
 ;          ^TMP($J,"TOTALS","DEP",C1)      - Total # of deposits by Internal date (C1)
 ;          ^TMP($J,"TOTALS","DEPA",C1)     - Total Deposit Amount by Internal date (C1)
 ;          ^TMP($J,"TOTALS","EFT","D")     - Total Deposit Amount by EFTs for date
 ;          ^TMP($J,"TOTALS","FMS")         - FMS Document Status or "NO FMS DOC"
 ;          ^TMP($J,"TOTALS","FMS","D",-1)  - Total Deposit Amount by FMS Document
 ;          ^TMP($J,"TOTALS","FMS","D",0)   - Total Amount for Error/Rejected documents
 ;          ^TMP($J,"TOTALS","FMS","D",1")  - Total Amount for 'A','M',"F' or 'T' docs
 ;          ^TMP($J,"TOTALS","FMS","D",2")  - Total Amount for queued docs
 ;          ^TMP($J,"TOTALS","FMSTOT")      - Updated Total Deposit Amount for date range
 ;          ^TMP($J,"TOTALS","MATCH","D")   - Current Total matched EFTs for date
 N CRDOC,DETL,DTADD,IEN344,IEN3443,IEN34431,TOTDEP,Q,X,XX,YY
 S DETL=$P(INPUT,"^",3),DTADD=$P(INPUT,"^",9)
 ;
 ; Clear the following daily totals
 K ^TMP($J,"TOTALS","EFT","D")
 K ^TMP($J,"TOTALS","FMS","D")
 K ^TMP($J,"TOTALS","MATCH","D")
 S IEN3443=""
 F  D  Q:IEN3443=""  Q:$P(INPUT,"^",5)=1
 . S IEN3443=$O(^TMP("RCDAILYACT",$J,DTADD,IEN3443))
 . Q:IEN3443=""
 . S XX=$$GET1^DIQ(344.3,IEN3443,.03,"I")       ; IEN for 344.1
 . S IEN344=+$O(^RCY(344,"AD",+XX,0))           ; IEN for 344
 . S XX=$G(^TMP($J,"TOTALS","DEP",DTADD))
 . S ^TMP($J,"TOTALS","DEP",DTADD)=XX+1         ; # of deposits for day
 . S TOTDEP=$$GET1^DIQ(344.3,IEN3443,.08,"I")   ; Total Deposit Amount
 . S XX=$G(^TMP($J,"TOTALS","DEPA",DTADD))
 . S ^TMP($J,"TOTALS","DEPA",DTADD)=XX+TOTDEP   ; Total Deposit Amount for day
 . S CRDOC=$$GET1^DIQ(344,IEN344,200,"I")       ; FMS Document Number
 . S ^TMP($J,"TOTALS","CRDOC",IEN3443)=CRDOC
 . I CRDOC="" D                                 ; No FMS Document Number
 . . S YY=$G(^TMP($J,"TOTALS","FMS","D",-1))
 . . S ^TMP($J,"TOTALS","FMS","D",-1)=YY+TOTDEP
 . . S ^TMP($J,"TOTALS","FMS")="NO FMS DOC"
 . I CRDOC'="" D                                ; FMS Document Number found
 . . S YY=$$STATUS^GECSSGET(CRDOC)              ; Get the status of the doc
 . . I YY=-1 D  Q                               ; Document wasn't found
 . . . S XX=$G(^TMP($J,"TOTALS","FMS","D",-1))
 . . . S ^TMP($J,"TOTALS","FMS","D",-1)=XX+TOTDEP
 . . . S ^TMP($J,"TOTALS","FMS")="STATUS MISSING"
 . . S XX=$E($P(YY," "),1,10)                   ; First Word of the status
 . . S ^TMP($J,"TOTALS","FMS")=XX               ; First Word of the status
 . . S Q=$E(YY,1)                               ; First Character of the status
 . . S Q=$S(Q="E"!(Q="R"):0,Q="Q":2,1:1)        ; Q=0 - Reject or Error, 2 - Queued, 1 - good
 . . S XX=$G(^TMP($J,"TOTALS","FMS","D",Q))
 . . S ^TMP($J,"TOTALS","FMS","D",Q)=XX+TOTDEP  ; Rej/Err, Queued OR good Amount for day
 . ;
 . I DETL D   Q:$P(INPUT,"^",5)=1               ; Display Detail Line
 . . D DETLN(.INPUT,IEN3443,TOTDEP)
 . S ^TMP($J,"TOTALS","FMSTOT")=0               ; Initialize FMS total for range
 . D ERRMSGS(.INPUT,IEN3443)                    ; Display any error messages
 . Q:$P(INPUT,"^",5)=1
 . D PROCEFT(.INPUT,IEN3443)                    ; Process EFT records
 Q
 ;
DETLN(INPUT,IEN3443,TOTDEP) ; Display detail line
 ; Input:   INPUT                           - A1^A2^A3^...^An Where:
 ;                                              A1 - 1 if called from Nightly Process
 ;                                                   0 otherwise
 ;                                              A2 - 1 if displaying to Listman
 ;                                                   0 otherwise
 ;                                              A3 - 1 if Detail report
 ;                                                   0 if summary report
 ;                                              A4 - Current Page Number
 ;                                              A5 - Stop Flag
 ;                                              A6 - Start of Date Range
 ;                                              A7 - End of Date Range
 ;                                              A8 - Current Line Counter
 ;                                              A9 - Internal Date being processed
 ;          IEN3443                         - Internal IEN for file 344.3
 ;          TOTDEP                          - Total Deposit Amount (344.3, .08)
 ;          ^TMP($J,"TOTALS","FMS")         - FMS Document # or "NO FMS DOC"
 ; Output:  INPUT                           - A1^A2^A3^...^An - The following pieces
 ;                                            may be updated
 ;                                              A5 - Updated Page Number
 ;                                              A6 - Stop Flag
 ;                                              A8 - Updated Line Counter
 ;
 N DTADD,DETL,LSTMAN,NJ,X,XX,YY
 S LSTMAN=$P(INPUT,"^",2),NJ=$P(INPUT,"^",1)
 S DETL=$P(INPUT,"^",3)
 S XX=$$GET1^DIQ(344.3,IEN3443,.06,"I")         ; Deposit Number
 ;
 ; PRCA*4.5*283 - change length of DEP # from 6 to 9 to allow for 9 digit DEP #'s
 S X=$$SETSTR^VALM1(XX,"",1,9)
 ;
 ; Change DEPOSIT DT's starting position from 9 to 12
 S YY=$$GET1^DIQ(344.3,IEN3443,.07,"I")         ; Deposit Date
 S X=$$SETSTR^VALM1($$FMTE^XLFDT(YY\1,"2Z"),X,12,10)
 ;
 ; Change starting position from 21 to 23 & reduce length of spaces from 10 to 8.
 S X=$$SETSTR^VALM1("",X,23,8)
 S X=$$SETSTR^VALM1("",X,32,10)
 S XX=^TMP($J,"TOTALS","FMS")
 S X=$$SETSTR^VALM1($E($J(TOTDEP,"",2)_$J("",20),1,20)_XX,X,43,37)
 D SL^RCDPEDA3(.INPUT,X)
 Q
 ;
PROCEFT(INPUT,IEN3443) ; Entry Point from RCDPEDAR
 ;                       Process EFT records
 ; Input:   INPUT                           - A1^A2^A3^...^An Where:
 ;                                              A1 - 1 if called from Nightly Process
 ;                                                   0 otherwise
 ;                                              A2 - 1 if displaying to Listman
 ;                                                   0 otherwise
 ;                                              A3 - 1 if Detail report
 ;                                                   0 if summary report
 ;                                              A4 - Current Page Number
 ;                                              A5 - Stop Flag
 ;                                              A6 - Start of Date Range
 ;                                              A7 - End of Date Range
 ;                                              A8 - Current Line Counter
 ;                                              A9 - Internal Date being processed
 ;          IEN3443                         - Internal IEN for file 344.3
 ;          ^TMP($J,"TOTALS","EFT","D")     - Current Total Deposit Amount by EFTs for date
 ;          ^TMP($J,"TOTALS","MATCH","D")   - Current Total matched EFTs for date
 ;          ^TMP($J,"TOTALS","FMSTOT")      - Current Total Deposit Amount for date range
 ; Output:  INPUT                           - A1^A2^A3^...^An - The following pieces
 ;                                                              may be updated
 ;                                              A5 - Updated Page Number
 ;                                              A6 - Stop Flag
 ;                                              A8 - Updated Line Counter
 ;          ^TMP($J,"TOTALS","FMSTOT")      - Updated Total Deposit Amount for date range
 ;          ^TMP($J,"TOTALS","EFT","D")     - Updated Total Deposit Amount by EFTs for date
 ;          ^TMP($J,"TOTALS","MATCH","D")   - Updated Total matched EFTs for date
 N DETL,DTADD,IEN34431,RCFMS1,TRDOC,X,XX,YY
 S ^TMP($J,"TOTALS","FMSTOT")=0
 S DTADD=$P(INPUT,"^",9)
 S RCFMS1="NO FMS DOC"
 S DETL=$P(INPUT,"^",3)
 S IEN34431=""
 F  D  Q:IEN34431=""  Q:$P(INPUT,"^",5)=1
 . S IEN34431=$O(^TMP("RCDAILYACT",$J,DTADD,IEN3443,"EFT",IEN34431))
 . Q:IEN34431=""
 . S XX=$G(^TMP($J,"TOTALS","EFT","D"))+1
 . S ^TMP($J,"TOTALS","EFT","D")=XX                ; Total # EFTs for date
 . S XX=+$$GET1^DIQ(344.31,IEN34431,.09,"I")       ; Receipt # from 344.31
 . S TRDOC=$$GET1^DIQ(344,XX,200,"I")              ; FMS Document #
 . S X=$S(TRDOC'="":$$STATUS^GECSSGET(TRDOC),1:"")
 . I X'="",X'=-1,$E(X,1)'="R",$E(X,1)'="E" D
 . . S XX=$G(^TMP($J,"TOTALS","FMSTOT"))
 . . S YY=$$GET1^DIQ(344.31,IEN34431,.07,"I")      ; Amount of Payment
 . . S ^TMP($J,"TOTALS","FMSTOT")=XX+YY
 . . S RCFMS1=$S($E(X,1)="Q":"QUEUED TO POST",1:"POSTED")
 . S XX=$S(X="":"",X=-1:"NO FMS DOC",1:$E($P(X," ",1),1,10))
 . S RCFMS1(IEN34431)=XX                           ; FMS Document Status for EFT
 . S XX=$$GET1^DIQ(344.31,IEN34431,.08,"I")        ; Match Status
 . I XX D
 . . S XX=$G(^TMP($J,"TOTALS","MATCH","D"))
 . . S ^TMP($J,"TOTALS","MATCH","D")=XX+1          ; Total Matched EFTS by date
 . D:DETL EFTDTL(.INPUT,IEN3443,IEN34431,.RCFMS1)
 . Q:$P(INPUT,"^",5)=1
 . D:DETL SL^RCDPEDA3(.INPUT," ")
 Q
 ;
EFTDTL(INPUT,IEN3443,IEN34431,RCFMS1) ; Display EFT Detail
 ; Input:   INPUT                           - A1^A2^A3^...^An Where:
 ;                                              A1 - 1 if called from Nightly Process
 ;                                                   0 otherwise
 ;                                              A2 - 1 if displaying to Listman
 ;                                                   0 otherwise
 ;                                              A3 - 1 if Detail report
 ;                                                   0 if summary report
 ;                                              A4 - Current Page Number
 ;                                              A5 - Stop Flag
 ;                                              A6 - Start of Date Range
 ;                                              A7 - End of Date Range
 ;                                              A8 - Current Line Counter
 ;                                              A9 - Internal Date being processed
 ;          IEN3443                         - Internal IEN for file 344.3
 ;          IEN34431                        - Internal IEN for file 344.31
 ;          RCFMS1(IEN34431)                - FMS Document Status for EFT IEN
 ; Output:  INPUT                           - A1^A2^A3^...^An - The following pieces
 ;                                                              may be updated
 ;                                              A5 - Updated Page Number
 ;                                              A6 - Stop Flag
 ;                                              A8 - Updated Line Counter
 N PAY,PAYER,PAYID,X,XX,YY,ZZ
 S XX=$$GET1^DIQ(344.31,IEN34431,.01,"I")       ; EFT Transaction IEN
 S X=$$SETSTR^VALM1(XX,"",3,6)
 S XX=$$GET1^DIQ(344.31,IEN34431,.12,"I")       ; Date Claims Paid
 S X=$$SETSTR^VALM1($$FMTE^XLFDT(XX\1,"2Z"),X,31,8)
 S XX=$$GET1^DIQ(344.31,IEN34431,.07,"I")       ; Amount of Payment
 S X=$$SETSTR^VALM1($J(XX,"",2),X,41,18)
 ;
 ; PRCA*4.5*284, Move to left 3 space (61 to 58) to allow for 10 digit ERA #'s
 S XX=$$GET1^DIQ(344.31,IEN34431,.08,"I")       ; Match Status
 S YY=$$GET1^DIQ(344.31,IEN34431,.1,"I")        ; ERA IEN
 S X=$$SETSTR^VALM1($$EXTERNAL^DILFD(344.31,.08,"",+XX)_$S(XX=1:"/ERA #"_YY,1:""),X,57,20)
 Q:$P(INPUT,"^",5)=1
 D SL^RCDPEDA3(.INPUT,X)
 S XX=$$GET1^DIQ(344.31,IEN34431,.04,"I")       ; Trace Number
 S X=$$SETSTR^VALM1(XX,"",5,$L(XX))
 S XX=$G(^TMP($J,"TOTALS","CRDOC",IEN3443))
 ; PRCA*4.5*318 add CR # to detail rpt
 S X=$$SETSTR^VALM1(XX,X,54,$L(XX))             ; CR Document Number
 D SL^RCDPEDA3(.INPUT,X)
 S PAYER=$$GET1^DIQ(344.31,IEN34431,.02,"I")    ; Payer Name
 S:PAYER="" PAYER="NO PAYER NAME RECEIVED"      ; PRCA*4.5*298
 S PAYID=$$GET1^DIQ(344.31,IEN34431,.03,"I")    ; Payer ID
 S PAY=PAYER_"/"_PAYID
 I $L(PAY)>74 D                                 ; PRCA*4.5*318 added if statement
 . S ZZ=$L(PAY,"/"),XX=$P(PAY,"/",1,ZZ-1),YY=$P(PAY,"/",ZZ)
 . S XX=$E(XX,1,$L(XX)-($L(PAY)-74)),PAY=XX_"/"_YY
 S XX=$$SETSTR^VALM1(PAY,"",7,74)
 D SL^RCDPEDA3(.INPUT,XX)
 ; PRCA*4.5*318 add TR #s to detail rpt
 D GETTR(IEN34431,.INPUT)    ; Gather & display all TR Doc #s for EFT detail record           
 S X=""
 ;
 ; PRCA*4.5*304 - lengthen receipt number display to 12
 S XX=$$GET1^DIQ(344.31,IEN34431,.09,"I")       ; Receipt IEN
 I XX'="" D
 . S YY=$$GET1^DIQ(344,XX,.01,"I")              ; Receipt Number
 . S X=$$SETSTR^VALM1(YY,X,46,12)
 S X=$$SETSTR^VALM1($G(RCFMS1(IEN34431)),X,61,19)
 D SL^RCDPEDA3(.INPUT,X)
 Q:$P(INPUT,"^",5)=1
 D EFTERRS^RCDPEDA3(.INPUT,IEN34431)            ; Display any EFT Errors
 D DUP(.INPUT,IEN34431)                         ; Check if this was a duplicate EFT
 Q
 ;
GETTR(IEN34431,INPUT) ;Gathers and Displays all TR Doc #s for a specified EFT
 ; detail record
 ; PRCA*4.5*318 add TR #s to detail rpt
 ; Input: IEN34431 - Internal IEN for file #344.31
 ;        INPUT                           - A1^A2^A3^...^An Where:
 ;                                              A1 - 1 if called from Nightly Process
 ;                                                   0 otherwise
 ;                                              A2 - 1 if displaying to Listman
 ;                                                   0 otherwise
 ;                                              A3 - 1 if Detail report
 ;                                                   0 if summary report
 ;                                              A4 - Current Page Number
 ;                                              A5 - Stop Flag
 ;                                              A6 - Start of Date Range
 ;                                              A7 - End of Date Range
 ;                                              A8 - Current Line Counter
 ;                                              A9 - Internal Date being processed;
 ;
 N CTR,IEN3444,IENS,RECEIPT,TRDOC,TRDOCS,XX
 ; First gather up all the TR Document numbers into as many lines as needed
 S CTR=1
 S IEN3444=$$GET1^DIQ(344.31,IEN34431,.1,"I") ; Internal IEN for for 344.4
 S RECEIPT=$$GET1^DIQ(344.4,IEN3444,.08,"I")  ; Receipt # from 344.4
 I RECEIPT'="" D
 . S TRDOC=$TR($$GET1^DIQ(344,RECEIPT,200,"I")," ")    ; FMS Document #
 . I TRDOC="" Q
 . S TRDOCS(CTR)=TRDOC
 . S XX=""
 . F  D  Q:XX=""
 .. S XX=$O(^RCY(344.4,IEN3444,8,XX))
 .. Q:XX=""
 .. S IENS=XX_","_IEN3444_","
 .. S RECEIPT=$$GET1^DIQ(344.48,IENS,.01,"I")  ; Other receipt numbers
 .. I RECEIPT="" Q
 .. S TRDOC=$TR($$GET1^DIQ(344,RECEIPT,200,"I")," ")   ; FMS Document #
 .. Q:TRDOC=""
 .. I $L(TRDOC)+$L($G(TRDOCS(CTR)))+1>73 D  Q
 .. . S CTR=CTR+1,TRDOCS(CTR)=TRDOC
 .. S TRDOCS(CTR)=TRDOCS(CTR)_", "_TRDOC
 ;
 ; Now display the TR Document numbers
 I '$D(TRDOCS) D SL^RCDPEDA3(.INPUT," ") Q    ; blank line for TR#s
 S XX=""
 F  D  Q:XX=""
 . S XX=$O(TRDOCS(XX))
 . Q:XX=""
 . D SL^RCDPEDA3(.INPUT,$J("",3)_TRDOCS(XX))
 Q
 ;
DUP(INPUT,IEN34431) ; Check to see if the EFT was a duplicate
 ; Input:   INPUT       - A1^A2^A3^...^An Where:
 ;                          A1 - 1 if called from Nightly Process, 0 otherwise
 ;                          A2 - 1 if displaying to Listman, 0 otherwise
 ;                          A3 - Current Page Number
 ;                          A1 - 1 if Detail report, 0 if summary report
 ;                          A5 - Stop Flag
 ;                          A6 - Start of Date Range
 ;                          A7 - End of Date Range
 ;                          A8 - Current Line Counter
 ;                          A9 - Internal Date being processed
 ;          IEN34431    - Internal IEN for file 344.31
 ; Output:  INPUT       - A1^A2^A3^...^An - The following pieces may be updated
 ;                          A5 - Updated Page Number
 ;                          A6 - Stop Flag
 ;                          A8 - Updated Line Counter
 N XX,YY
 Q:'$D(^RCY(344.31,IEN34431,3))                 ; Not a duplicate
 S XX=$$GET1^DIQ(344.31,IEN34431,.18,"I")       ; Date/Time Removed
 S YY=$$GET1^DIQ(344.31,IEN34431,.17,"I")       ; User who removed it
 S X="   MARKED AS DUPLICATE: "_$$FMTE^XLFDT(XX)_" "_$$EXTERNAL^DILFD(344.31,.17,,YY)
 D SL^RCDPEDA3(.INPUT,X)
 D SL^RCDPEDA3(.INPUT," ")
 Q
 ;
ERRMSGS(INPUT,IEN3443) ; Display any EFT error messages
 ; Input:   INPUT       - A1^A2^A3^...^An Where:
 ;                         A1 - 1 if called from Nightly Process, 0 otherwise
 ;                         A2 - 1 if displaying to Listman, 0 otherwise
 ;                         A3 - 1 if Detail report, 0 if summary report
 ;                         A4 - Current Page Number
 ;                         A5 - Stop Flag
 ;                         A6 - Start of Date Range
 ;                         A7 - End of Date Range
 ;                         A8 - Current Line Counter
 ;                         A9 - Internal Date being processed
 ;          IEN3443     - Internal IEN for file 344.3
 ; Output:  INPUT       - A1^A2^A3^...^An - The following pieces may be updated
 ;                         A5 - Updated Page Number
 ;                         A6 - Stop Flag
 ;                         A8 - Updated Line Counter
 ;
 N DETL,ERRS,XX
 S DETL=$P(INPUT,"^",3)
 S XX=$$GET1^DIQ(344.3,IEN3443,2,"I","ERRS")    ; Error Message WP field
 Q:'$D(ERRS)                                    ; No errors
 Q:$P(INPUT,"^",5)=1
 D SL^RCDPEDA3(.INPUT,$J("",10)_"ERROR MESSAGES FOR EFT:")
 S XX=""
 F  D  Q:XX=""  Q:$P(INPUT,"^",5)=1
 . S XX=$O(ERRS(XX))
 . Q:XX=""
 . Q:$P(INPUT,"^",5)=1
 . D SL^RCDPEDA3(.INPUT,$J("",12)_ERRS(XX))
 Q
 ; 

RCDPEDA2 ;AITC/DW - ACTIVITY REPORT ;Feb 17, 2017@10:37:00
 ;;4.5;Accounts Receivable;**318,321,326,380**;Mar 20, 1995;Build 14
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
RPT2(INPUT) ;EP from RCDPEDAR
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
 ;                                             A10- 1 - Only Display EFTs with a debit flag of 'D'
 ;                                                  0 - Display all EFTs
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
 ;          ^TMP($J,"TOTALS","DEBIT")       - Current Total # of debits for date range
 ;          ^TMP($J,"TOTALS","DEBIT","D")   - Total # of debits for Internal date (C1)
 ;          ^TMP($J,"TOTALS","DEBITA")      - Current Total Debit Amount for date range
 ;          ^TMP($J,"TOTALS","DEBITA","D")  - Total Debit Amount for Internal date (C1)
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
 N CRDOC,DETL,DLNCT,DTADD,IEN344,IEN3443,IEN34431,TOTDEP,Q,X,XX,YY
 S DETL=$P(INPUT,"^",3),DTADD=$P(INPUT,"^",9)
 ;
 ; Clear the following daily totals
 K ^TMP($J,"TOTALS","EFT","D")
 K ^TMP($J,"TOTALS","FMS","D")
 K ^TMP($J,"TOTALS","MATCH","D")
 K ^TMP($J,"TOTALS","DEBIT","D")            ;PRCA*4.5*321 Add Debit flag logic
 K ^TMP($J,"TOTALS","DEBITA","D")
 K ^TMP($J,"ONEDEP"),^TMP($J,"DEPERRS")     ;PRCA*4.5*321
 S IEN3443="",DLNCT=0                       ;PRCA*4.5*321 Add DLNCT
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
 . . I $$GET1^DIQ(344,IEN344,201,"I") S YY="ACCEPTED" ; Default ON-LINE entry to accepted - PRCA*4.5*326
 . . E  S YY=$$STATUS^GECSSGET(CRDOC)              ; Get the status of the doc - PRCA*4.5*326
 . . I YY=-1 D  Q                               ; Document wasn't found
 . . . S XX=$G(^TMP($J,"TOTALS","FMS","D",-1))
 . . . S ^TMP($J,"TOTALS","FMS","D",-1)=XX+TOTDEP
 . . . S ^TMP($J,"TOTALS","FMS")="STATUS MISSING"
 . . S XX=$E($P(YY," "),1,10)
 . . S ^TMP($J,"TOTALS","FMS")=XX               ; First Word of the status
 . . S Q=$E(YY,1)                               ; First Character of the status
 . . S Q=$S(Q="E"!(Q="R"):0,Q="Q":2,1:1)        ; Q=0 - Reject or Error, 2 - Queued, 1 - good
 . . S XX=$G(^TMP($J,"TOTALS","FMS","D",Q))
 . . S ^TMP($J,"TOTALS","FMS","D",Q)=XX+TOTDEP  ; Rej/Err, Queued OR good Amount for day
 . ;
 . D ONEDEP(.INPUT,IEN3443,TOTDEP,.DLNCT)       ;PRCA*4.5*321 Gather and display one deposit
 Q
 ;
ONEDEP(INPUT,IEN3443,TOTDEP,DLNCT) ; Gather and display lines for one Deposit
 ; PRCA*4.5*321 new method to first gather all the lines before displaying them
 ; Input:   INPUT                       - See RPT2 for details
 ;          ^TMP(B1,$J,B2,B3)           - See RPT2 for details
 ;          IEN3443                     - Internal IEN for file 344.3
 ;          TOTDEP                      - Total Deposit Amount (344.3, .08)
 ;          DLNCT                       - Current # of deposit lines displayed
 ;          ^TMP($J,"DEPERRS")          - Current Line Count
 ;                                        Note: Only passed if not in detail mode
 ;          ^TMP($J,"DEPERRS,X) - Error line(s)
 ; Output:  INPUT                       - See RPT2 for details
 ;          DLNCT                       - Updated # of deposit lines displayed
 ;          ^TMP(B1,$J,B2,B3,"EFT",B4)  - See RPT2 for details
 ;          ^TMP($J,"TOTALS","DEP",C1)  - See RPT2 for details
 ;          ^TMP($J,"DEPERRS")          - Updated Line Count
 ;                                        Note: Only passed if not in detail mode
 N CURLNS,DEPLNS,DETL,DTADD,EFTCTR,EFTLN,EFTLNS,LSTMAN,XX,YY,ZZ
 S DETL=$P(INPUT,"^",3)
 S DTADD=$P(INPUT,"^",9)
 K:DETL ^TMP($J,"ONEDEP"),^TMP($J,"DEPERRS")
 S LSTMAN=$P(INPUT,"^",2)
 I DETL D                                   ; Gather Detail Line
 . D DETLN(.INPUT,IEN3443,TOTDEP)
 S ^TMP($J,"TOTALS","FMSTOT")=0             ; Initialize FMS total for range
 D ERRMSGS^RCDPEDA4(.INPUT,IEN3443)         ; Gather any error message lines
 D PROCEFT(.INPUT,IEN3443)                  ; Gather lines for EFT records
 Q:'DETL
 ;
 ; Determine overall line count for deposit
 S ZZ=1                          ; deposit line (1st line per record)                 
 S ZZ=ZZ+$G(^TMP($J,"DEPERRS"))  ; deposit errors line cnt
 S XX=0 F XX=$O(^TMP($J,"ONEDEP",XX)) D  Q:XX=""
 . S ZZ=ZZ+$G(^TMP($J,"ONEDEP",XX))
 S DEPLNS=ZZ
 ;
 ; If not outputting to listman and at least 1 deposit is already displayed
 ; on the page, check to see if we have don't have room to display the 
 ; deposit detail line
 I 'LSTMAN,DLNCT,(DLNCT+DEPLNS+2)>IOSL D  Q:$P(INPUT,"^",5)=1
 . S DLNCT=0
 . D NEWDHDR(.INPUT,DTADD)
 . Q:$P(INPUT,"^",5)=1
 ; Display first deposit line
 S DLNCT=DLNCT+1
 S XX=^TMP($J,"ONEDEP",0,1)
 D SL^RCDPEDA3(.INPUT,XX)
 ;
 ; If not outputting to listman, check to see if we have don't have room to
 ; display any deposit error info
 S XX=$G(^TMP($J,"DEPERRS"))
 I 'LSTMAN,XX,XX<IOSL,(DLNCT+XX)>IOSL D  Q:$P(INPUT,"^",5)=1
 . S DLNCT=0
 . D NEWDHDR(.INPUT,DTADD)
 . Q:$P(INPUT,"^",5)=1 
 S DLNCT=DLNCT+XX
 ;
 ; Display Deposit Error (if any)
 S XX=""
 F  D  Q:XX=""
 . S XX=$O(^TMP($J,"DEPERRS",XX))
 . Q:XX=""
 . S YY=^TMP($J,"DEPERRS",XX)
 . D SL^RCDPEDA3(.INPUT,YY)
 ;
 ; Display Remaining Deposit lines one EFT at a time
 S EFTCTR=0
 F  D  Q:EFTCTR=""  Q:$P(INPUT,"^",5)=1
 . S EFTCTR=$O(^TMP($J,"ONEDEP",EFTCTR))
 . Q:EFTCTR=""
 . ;
 . ; If not outputting to listman, check to see if we have don't have room to
 . ; display any EFT
 . S EFTLNS=$G(^TMP($J,"ONEDEP",EFTCTR))
 . I 'LSTMAN,EFTLNS<IOSL,(DLNCT+EFTLNS)>IOSL D  Q:$P(INPUT,"^",5)=1
 . . D NEWDHDR(.INPUT,DTADD)
 . . Q:$P(INPUT,"^",5)=1
 . . S XX=^TMP($J,"ONEDEP",0,1)
 . . D SL^RCDPEDA3(.INPUT,XX)
 . . S DLNCT=1
 . S EFTLN=""
 . F  D  Q:EFTLN=""
 . . S EFTLN=$O(^TMP($J,"ONEDEP",EFTCTR,EFTLN))
 . . Q:EFTLN=""
 . . S ZZ=^TMP($J,"ONEDEP",EFTCTR,EFTLN)
 . . D SL^RCDPEDA3(.INPUT,ZZ)
 . . S DLNCT=DLNCT+1
 Q
 ;
NEWDHDR(INPUT,DTADD) ; display a new deposit header for the specified date
 ; Input:   INPUT   - See RPT2 for details
 ;          DTADD   - Internal Date deposit are being displayed for
 N XX
 D HDR^RCDPEDA3(.INPUT)
 Q:$P(INPUT,"^",5)=1   ; user quit or timed out
 S XX="DATE EFT DEPOSIT RECEIVED: "_$$FMTE^XLFDT(DTADD,"2Z")
 S XX=$J("",80-$L(XX)\2)_XX              ; Center it
 D SL^RCDPEDA3(.INPUT,XX)
 D SL^RCDPEDA3(.INPUT," ")
 Q
 ;
DETLN(INPUT,IEN3443,TOTDEP) ; Display detail line
 ; Input:   INPUT                   - See RPT2 for details
 ;          IEN3443                 - Internal IEN for file 344.3
 ;          TOTDEP                  - Total Deposit Amount (344.3, .08)
 ;          ^TMP($J,"TOTALS","FMS") - FMS Document # or "NO FMS DOC"
 ; Output:  INPUT                   - A1^A2^A3^...^An - The following pieces may be updated
 ;                                      A5 - Updated Page Number
 ;                                      A6 - Stop Flag
 ;                                      A8 - Updated Line Counter
 ;
 N DEPDT,DEPNUM,DETL,DTADD,LSTMAN,MULT,NJ,X,XX,YY
 S LSTMAN=$P(INPUT,"^",2),NJ=$P(INPUT,"^",1)
 S DETL=$P(INPUT,"^",3)
 ;PRCA*4.5*380 - Check for multiple mail messages on this deposit
 S:$O(^RCY(344.3,IEN3443,3,0))'="" MULT="*"
 ;PRCA*4.5*380 - Check if prior deposits exist
 S DEPNUM=$$GET1^DIQ(344.3,IEN3443,.06,"I"),DEPDT=$$GET1^DIQ(344.3,IEN3443,.07,"I")
 S XX=$O(^RCY(344.3,"ADEP2",DEPNUM,DEPDT,0)),XX=$O(^RCY(344.3,"ADEP2",DEPNUM,DEPDT,XX))
 S:XX'="" MULT=$G(MULT)_"+"
 S XX=DEPNUM ; Deposit Number
 ;
 S X=$$SETSTR^VALM1(XX,"",1,9)
 ;
 S YY=DEPDT ; Deposit Date
 ;PRCA*4.5*380 - Include multi-mail message indicator with date
 ;S X=$$SETSTR^VALM1($$FMTE^XLFDT(YY\1,"2Z")_$G(MULT),X,12,10)
 S X=$$SETSTR^VALM1($$FMTE^XLFDT(YY\1,"2Z"),X,12,10)
 ;
 S X=$$SETSTR^VALM1("",X,23,8)
 S X=$$SETSTR^VALM1("",X,32,10)
 S XX=^TMP($J,"TOTALS","FMS")
 S X=$$SETSTR^VALM1($E($J(TOTDEP,"",2)_$J("",20),1,20)_XX,X,43,37)
 S ^TMP($J,"ONEDEP",0,1)=X    ; PRCA*4.5*321
 Q
 ;
PROCEFT(INPUT,IEN3443)  ; Process EFT records
 ; Input:   INPUT                           - See RPT2 for details
 ;          IEN3443                         - Internal IEN for file 344.3
 ;          ^TMP($J,"ONEDEP",0,1)           - Deposit Detail line
 ;          ^TMP($J,"TOTALS","DEBIT","D")   - Current Total # of Debit EFTs for date
 ;          ^TMP($J,"TOTALS","DEBITA","D")  - Current Total Amount of Debit EFTs for date
 ;          ^TMP($J,"TOTALS","EFT","D")     - Current Total Deposit Amount by EFTs for date
 ;          ^TMP($J,"TOTALS","MATCH","D")   - Current Total matched EFTs for date
 ;          ^TMP($J,"TOTALS","FMSTOT")      - Current Total Deposit Amount for date range
 ; Output:  INPUT                           - A1^A2^A3^...^An - The following pieces
 ;                                                              may be updated
 ;                                              A5 - Updated Page Number
 ;                                              A6 - Stop Flag
 ;                                              A8 - Updated Line Counter
 ;       ^TMP($J,"ONEDEP",0,1)               - Deposit Detail line
 ;       ^TMP($J,"ONEDEP","EFTCTR")          - # of lines for This EFT
 ;       ^TMP($J,"ONEDEP","EFTCTR",xx)=LINE  - EFT Lines
 ;       ^TMP($J,"TOTALS","DEBIT","D")   - Updated Total # of Debit EFTs for date
 ;       ^TMP($J,"TOTALS","DEBITA","D")  - Updated Total Amount of Debit EFTs for date
 ;       ^TMP($J,"TOTALS","DEBIT")       - Updated Total # of Debit EFTs for date range
 ;       ^TMP($J,"TOTALS","DEBITA")      - Updated Total Amount of Debit EFTs for date range
 ;       ^TMP($J,"TOTALS","FMSTOT")      - Updated Total Deposit Amount for date range
 ;       ^TMP($J,"TOTALS","EFT","D")     - Updated Total Deposit Amount by EFTs for date
 ;       ^TMP($J,"TOTALS","MATCH","D")   - Updated Total matched EFTs for date
 N DETL,DFLG,DTADD,EFTCTR,IEN34431,PAMT,RCFMS1,TRDOC,X,XX,YY    ; PRCA*4.5*321 Added DFLG
 ; PRCA*4.5*321 capture display and line cnt to ^TMP($J,"ONEDEP")
 S ^TMP($J,"TOTALS","FMSTOT")=0,EFTCTR=0
 S DTADD=$P(INPUT,"^",9)
 S RCFMS1="NO FMS DOC"
 S DETL=$P(INPUT,"^",3)
 S IEN34431=""
 F  D  Q:IEN34431=""  Q:$P(INPUT,"^",5)=1
 . S IEN34431=$O(^TMP("RCDAILYACT",$J,DTADD,IEN3443,"EFT",IEN34431))
 . Q:IEN34431=""
 . S XX=$G(^TMP($J,"TOTALS","EFT","D"))+1
 . S ^TMP($J,"TOTALS","EFT","D")=XX                ; Total # EFTs for date
 . ;
 . S YY=$$GET1^DIQ(344.31,IEN34431,3,"E")          ; Debit/Credit flag ; PRCA*4.5*321 added line
 . S DFLG=$S(YY="D":1,1:0)                         ; PRCA*4.5*321 added line
 . S PAMT=$$GET1^DIQ(344.31,IEN34431,.07,"I")      ; Amount of Payment
 . I DFLG D                                        ; PRCA*4.5*321 added if Statement
 . . S XX=$G(^TMP($J,"TOTALS","DEBIT","D"))+1
 . . S ^TMP($J,"TOTALS","DEBIT","D")=XX            ; Total # Debit EFTs for date
 . . S XX=$G(^TMP($J,"TOTALS","DEBITA","D"))       ; Total Debit Amounts for date
 . . S ^TMP($J,"TOTALS","DEBITA","D")=XX+PAMT
 . ;
 . S XX=+$$GET1^DIQ(344.31,IEN34431,.09,"I")       ; Receipt # from 344.31
 . S TRDOC=$$GET1^DIQ(344,XX,200,"I")              ; FMS Document #
 . I $$GET1^DIQ(344,XX,201,"I") S X="ACCEPTED" ; Default ON-LINE ENTRY status to accepted - PRCA*4.5*326
 . E  S X=$S(TRDOC'="":$$STATUS^GECSSGET(TRDOC),1:"") ; PRCA*4.5*326
 . I X'="",X'=-1,$E(X,1)'="R",$E(X,1)'="E" D
 . . S XX=$G(^TMP($J,"TOTALS","FMSTOT"))
 . . S ^TMP($J,"TOTALS","FMSTOT")=XX+PAMT          ; Total Amount of Payment
 . . S RCFMS1=$S($E(X,1)="Q":"QUEUED TO POST",1:"POSTED")
 . S XX=$S(X="":"",X=-1:"NO FMS DOC",1:$E($P(X," ",1),1,10))
 . S RCFMS1(IEN34431)=XX                           ; FMS Document Status for EFT
 . S XX=$$GET1^DIQ(344.31,IEN34431,.08,"I")        ; Match Status
 . I XX D
 . . S XX=$G(^TMP($J,"TOTALS","MATCH","D"))
 . . S ^TMP($J,"TOTALS","MATCH","D")=XX+1          ; Total Matched EFTS by date
 . I DETL D                            ;PRCA*4.5*321
 . . S EFTCTR=EFTCTR+1
 . . D EFTDTL(.INPUT,IEN3443,IEN34431,.RCFMS1,EFTCTR)
 . . S YY=$G(^TMP($J,"ONEDEP",EFTCTR))+1
 . . S ^TMP($J,"ONEDEP",EFTCTR)=YY
 . . S ^TMP($J,"ONEDEP",EFTCTR,YY)=" "
 Q
 ;
EFTDTL(INPUT,IEN3443,IEN34431,RCFMS1,EFTCTR)   ; Display EFT Detail
 ; Input:   INPUT                   - See RPT2 for details
 ;          IEN3443                 - Internal IEN for file 344.3
 ;          IEN34431                - Internal IEN for file 344.31
 ;          RCFMS1(IEN34431)        - FMS Document Status for EFT IEN
 ;          EFTCTR                  - Used to store lines for an EFT
 ;          ^TMP($J,ONEDEP,0,1)     - Deposit Detail line
 ; Output:  INPUT                   - See RPT2 for details
 ;          ^TMP($J,ONEDEP,0,1)     - Deposit Detail line
 ;          ^TMP($J,ONEDEP,EFTCTR)  - # of lines for EFT
 ;          ^TMP($J,ONEDEP,EFTCTR,xx)- EFT Deposit Lines
 N EFTLN,MDT,PAY,PAYER,PAYID,X,XX,YY,ZZ
 S XX=$$GET1^DIQ(344.31,IEN34431,.01,"E")       ; EFT Transaction detail - PRCA*4.5*326
 S X=$$SETSTR^VALM1(XX,"",3,9)
 S XX=$$GET1^DIQ(344.31,IEN34431,.12,"I")       ; Date Claims Paid
 S X=$$SETSTR^VALM1($$FMTE^XLFDT(XX\1,"2Z"),X,23,8) ; PRCA*4.5*326 - move 8 back for MATCH DATE
 S XX=$$GET1^DIQ(344.31,IEN34431,.07,"I")       ; Amount of Payment
 S X=$$SETSTR^VALM1($J(XX,"",2),X,33,18)        ; PRCA*4.5*326 - move 8 back for MATCH DATE
 ;
 ; PRCA*4.5*284, Move to left 3 space (61 to 58) to allow for 10 digit ERA #'s
 S XX=$$GET1^DIQ(344.31,IEN34431,.08,"I")       ; Match Status
 S YY=$$GET1^DIQ(344.31,IEN34431,.1,"I")        ; ERA IEN
 S MDT=""
 I XX=1 S MDT=$$MATCHDT^RCDPEWL7(IEN34431) ; PRCA*4.5*326 - Date matched to ERA
 ; PRCA*4.5*326 - next line, move 8 back and add MATCH DATE
 S X=$$SETSTR^VALM1($$EXTERNAL^DILFD(344.31,.08,"",+XX)_$S(XX=1:"/ERA #"_YY,1:"")_" "_MDT,X,49,30)
 S ^TMP($J,"ONEDEP",EFTCTR,1)=X
 ;
 S XX=$$GET1^DIQ(344.31,IEN34431,.04,"I")       ; Trace Number
 S X=$$SETSTR^VALM1(XX,"",5,$L(XX))
 S XX=$G(^TMP($J,"TOTALS","CRDOC",IEN3443))
 S X=$$SETSTR^VALM1(XX,X,59,$L(XX))             ; CR Doc
 S ^TMP($J,"ONEDEP",EFTCTR,2)=X
 ;
 S PAYER=$$GET1^DIQ(344.31,IEN34431,.02,"I")    ; Payer Name
 S:PAYER="" PAYER="NO PAYER NAME RECEIVED"
 S PAYID=$$GET1^DIQ(344.31,IEN34431,.03,"I")    ; Payer ID
 S PAY=PAYER_"/"_PAYID
 I $L(PAY)>74 D
 . S ZZ=$L(PAY,"/"),XX=$P(PAY,"/",1,ZZ-1),YY=$P(PAY,"/",ZZ)
 . S XX=$E(XX,1,$L(XX)-($L(PAY)-74)),PAY=XX_"/"_YY
 S X=$$SETSTR^VALM1(PAY,"",7,74)
 S ^TMP($J,"ONEDEP",EFTCTR,3)=X
 S ^TMP($J,"ONEDEP",EFTCTR)=3
 ;
 ; PRCA*4.5*318 add TR #s to detail rpt
 ; Gather & display all TR Doc #s for EFT detail record           
 D GETTR^RCDPEDA4(IEN34431,.INPUT)              ; PRCA*4.5*321 moved for routine size
 S X=""
 S XX=$$GET1^DIQ(344.31,IEN34431,3,"E")         ; Debit Flag ; PRCA 4.5*321 Added line
 S XX=$S(XX="D":"DEBIT",1:"     ")              ; PRCA*4.5*321 Added line
 S X=$$SETSTR^VALM1(XX,X,37,5)
 ;
 S XX=$$GET1^DIQ(344.31,IEN34431,.09,"I")       ; Receipt IEN
 I XX'="" D
 . S YY=$$GET1^DIQ(344,XX,.01,"I")              ; Receipt Number
 . S X=$$SETSTR^VALM1(YY,X,45,12)               ; PRCA*4.5*321 changed 46 to 45
 S X=$$SETSTR^VALM1($G(RCFMS1(IEN34431)),X,61,19)
 S EFTLN=$G(^TMP($J,"ONEDEP",EFTCTR))+1
 S ^TMP($J,"ONEDEP",EFTCTR)=EFTLN
 S ^TMP($J,"ONEDEP",EFTCTR,EFTLN)=X
 D EFTERRS^RCDPEDA4(.INPUT,IEN34431,EFTCTR)     ; Display any EFT Errors
 D DUP(.INPUT,IEN34431,EFTCTR)                  ; Display any Duplicate Errors
 Q
 ;
DUP(INPUT,IEN34431,EFTCTR) ; Check to see if the EFT was a duplicate
 ; Input:   IEN34431                - Internal IEN for file 344.31
 ;          INPUT                   - See RPT2 for details
 ;          EFTCTR                  - Used to store lines for EFT
 ;          ^TMP($J,ONEDEP,EFTCTE)  - Current # of lines for EFT
 ;          ^TMP($J,ONEDEP,EFTCTR,xx)- Current Deposit Lines
 ; Output:  ^TMP($J,ONEDEP,EFTCTR)  - Updated # of lines for EFT
 ;          ^TMP($J,ONEDEP,EFTCTR,xx)- Updated EFT Lines
 ;
 ;PRCA*4.5*321 capture display to ^TMP($J,"ONEDEP",EFTRCR) including line cnt
 N EFTLN,XX,YY
 Q:'$D(^RCY(344.31,IEN34431,3))                 ; Not a duplicate
 S XX=$$GET1^DIQ(344.31,IEN34431,.18,"I")       ; Date/Time Removed
 S YY=$$GET1^DIQ(344.31,IEN34431,.17,"I")       ; User who removed it
 S X="   MARKED AS DUPLICATE: "_$$FMTE^XLFDT(XX)_" "_$$EXTERNAL^DILFD(344.31,.17,,YY)
 S EFTLN=$G(^TMP($J,"ONEDEP",EFTCTR))+1
 S ^TMP($J,"ONEDEP",EFTCTR)=EFTLN
 S ^TMP($J,"ONEDEP",EFTCTR,EFTLN)=X
 S EFTLN=EFTLN+1
 S ^TMP($J,"ONEDEP",EFTCTR)=EFTLN
 S ^TMP($J,"ONEDEP",EFTCTR,EFTLN)=" "
 Q
 ;

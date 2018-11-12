RCDPELA1 ;EDE/FA - LIST ALL AUTO-POSTED RECEIPTS REPORT ;Nov 17, 2016
 ;;4.5;Accounts Receivable;**318**;Mar 20, 1995;Build 37
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q   ; no direct entry
 ;
RPTOUT(INPUT) ; Output the report to paper/screen, listman or excel
 ; Input:   INPUT   - See REPORT for a complete description
 ;          ^TMP($J,A1,"SEL",A2,A3,A4,A5)="" - if record passed filters Where:
 ;                                 A1 - "RCDPE_LAR"
 ;                                 A2 - Uppercased Payer Name (primary sort)
 ;                                 A3 - Secondary Sort Value
 ;                                 A4 - Internal IEN for file 344.4
 ;                                 A5 - Internal IEN for file 344.41
 ; Output:  ^TMP("RCDPE_LAR",$J,CTR)=Line - Array of display lines (no headers)
 ;                                          for output to Listman
 ;                                          Only set when A7-1
 ;
 ;         ^TMP($J,A1,"ZERO",A3,A4)="" - List of EEOBs with zero balance  Where:
 ;                                 A1 - "RCDPE_LAR"
 ;                                 A3 - IEN of #344.4 (ERA #)
 ;                                 A4 - IEN of #344.41 (original sequence #)
 ;
 N A1,DATA,EXCEL,FIRST,IEN3444,LNCNT,LSTMAN
 N ONEERA,OUTTYP,PAGE,PAYER,STOP,SVAL
 S (LNCNT,PAGE)=0                           ; Initialize Line/Page counters
 S $P(INPUT,"^",9)=0                        ; Line Counter for Listman output
 S EXCEL=$P(INPUT,"^",8)
 S LSTMAN=$P(INPUT,"^",7)
 S DATA=0
 S OUTYPE=$S(EXCEL:2,LSTMAN:1,1:0)
 I OUTYPE=2 D                               ; Excel Ouput
 . S XX="Payer^ERA^Date Received^Date Posted^Receipt^Trace #"
 . S XX=XX_"^Receipt Total^ERA Total^Missing Receipts^User^Amount^FMS Doc #"
 . W !,XX
 . ;
 S A1="RCDPE_LAR",PAYER="",STOP=0
 S FIRST=$O(^TMP($J,A1,"SEL",""))           ; First payer on the report
 F  D  Q:PAYER=""  Q:STOP
 . S PAYER=$O(^TMP($J,A1,"SEL",PAYER))
 . Q:PAYER=""
 . S DATA=1                                 ; found data
 . ;
 . I OUTYPE=1 D                             ; Listman Output
 . . S XX=$P(INPUT,"^",9)+1
 . . S $P(INPUT,"^",9)=XX
 . . S ^TMP(A1,$J,XX)=PAYER
 . ;
 . I OUTYPE=0 D  Q:STOP                     ; Paper/Screen output
 . . S:PAGE>1!(PAYER'=FIRST) STOP=$$ASKSTOP^RCDPELAR()
 . . Q:STOP
 . . S LNCNT=0
 . . D HEADER(INPUT,.LNCNT,.PAGE)
 . . D:'EXCEL ERAHDR(PAYER,.LNCNT,PAGE)
 . S SVAL=""
 . F  D  Q:SVAL=""  Q:STOP
 . . S SVAL=$O(^TMP($J,A1,"SEL",PAYER,SVAL))
 . . Q:SVAL=""
 . . S IEN3444=""
 . . F  D  Q:IEN3444=""  Q:STOP
 . . . S IEN3444=$O(^TMP($J,A1,"SEL",PAYER,SVAL,IEN3444))
 . . . Q:IEN3444=""
 . . . D ZEROBAL(IEN3444)  ; determine which IEN34441 lines are zero balance
 . . . K ONEERA
 . . . S XX=$$GET1^DIQ(344.4,IEN3444,.05,"I") ; Total Amount Paid
 . . . S XX=$J(XX,12,2)
 . . . S ONEERA="0^"_XX_"^0^0"                ; Initial ERA values
 . . . S IEN34441=""
 . . . F  D  Q:IEN34441=""  Q:STOP
 . . . . S IEN34441=$O(^TMP($J,A1,"SEL",PAYER,SVAL,IEN3444,IEN34441))
 . . . . Q:IEN34441=""
 . . . . ;
 . . . . Q:$D(^TMP($J,A1,"ZERO",IEN3444,IEN34441))  ; eliminates reversals
 . . . . ;
 . . . . ; Get all the detail lines needed to output one ERA record
 . . . . D ONEDLN(OUTYPE,IEN3444,IEN34441,.ONEERA)
 . . . D ADDERAH(OUTYPE,.ONEERA,IEN3444)      ; Add the ERA Header lines
 . . . ;
 . . . ; Output all the lines for one ERA
 . . . S STOP=$$OUTERA(.INPUT,OUTYPE,PAYER,.ONEERA,.LNCNT,.PAGE)
 I 'DATA,'EXCEL,'LSTMAN D
 . D HEADER(INPUT,.LNCNT,.PAGE)
 . D ERAHDR(PAYER,.LNCNT,PAGE)
 I 'EXCEL D
 . S XX=$$ENDORPRT^RCDPEARL
 . I OUTYPE=1 D  Q
 . . S YY=$P(INPUT,"^",9)+1
 . . S $P(INPUT,"^",9)=YY
 . . S ^TMP(A1,$J,YY)=XX
 . W !,XX
 . I 'STOP S STOP=$$ASKSTOP^RCDPELAR()
 . Q:STOP
 Q
 ;
ZEROBAL(IEN3444)    ; Is it a zero value EEOB
 ; Those EEOB with reversals will have a zero value.  This builds
 ; an array of them.
 ; Input:   IEN3444     - Internal IEN for file 344.4
 ; Output:
 ;         ^TMP($J,A1,"ZERO",A3,A4)="" - List of EEOBs with zero balance  Where:
 ;                                 A1 - "RCDPE_LAR"
 ;                                 A3 - IEN of #344.4 (ERA #)
 ;                                 A4 - IEN of #344.41 (original sequence #)
 ;
 N A1,A2,AMTPOST,IENS,ORIGSEQ,RCSEQ,RCDA1,XX
 K ^TMP($J,"RCDPE_LAR","ZERO",IEN3444)
 ;
 S A1="RCDPE_LAR",A2="ZERO"
 S RCSEQ=0
 F  S RCSEQ=$O(^RCY(344.49,IEN3444,1,"B",RCSEQ)) Q:'RCSEQ  D
 . Q:RCSEQ#1'=0 
 . S RCDA1=+$O(^RCY(344.49,IEN3444,1,"B",RCSEQ,0))
 . Q:'RCDA1
 . S IENS=RCDA1_","_IEN3444_","
 . S AMTPOST=$$GET1^DIQ(344.491,IENS,.03,"I")  ; Amount to post on receipt
 . I AMTPOST>0 Q                               ; Not zero value line
 . S ORIGSEQ=$$GET1^DIQ(344.491,IENS,.09,"I")  ; list of original seq #s with zero balance
 . S XX=0
 . F XX=1:1 Q:$P(ORIGSEQ,",",XX)=""  S ^TMP($J,A1,A2,IEN3444,($P(ORIGSEQ,",",XX)))=""
 Q
 ;
ONEDLN(OUTYPE,IEN3444,IEN34441,ONEERA) ; Gather all of the ERA Detail lines to display
 ; one ERA record
 ; Input:   OUTYPE      - O - Output to Screen or paper
 ;                        1 - Output to Listman
 ;                        2 - Output to Excel
 ;          IEN3444     - Internal IEN for file 344.4
 ;          IEN34441    - Internal IEN for sub file 344.41 of the ERA detail
 ;                        line being processed
 ;          ONEERA      - A1^A2^A3^A4 Where:
 ;                         A1 - Current Number of lines in the ERA display
 ;                         A2 - ERA Total for the ERA (formatted)
 ;                         A3 - Current Receipt Total for the ERA (formatted)
 ;                         A4 - 1 if ERA contains at least one detail record 
 ;                                with a missing receipt.
 ;                              0 otherwise
 ;          ONEERA(LN)=A4- Where
 ;                         LN - Line number for ERA Display
 ;                         A4 - Actual display line
 ; Ouput:   ONEERA     - A1^A2^A3^A4 Where:
 ;                         A1 - Updated Number of lines in the ERA display
 ;                         A2 - ERA Total for the ERA (formatted)
 ;                         A3 - Updated Receipt Total for the ERA (formatted)
 ;                         A4 - 1 if ERA contains at least one detail record 
 ;                                with a missing receipt.
 ;                              0 otherwise
 ;          ONEERA(LN)=A4- Where
 ;                         LN - Line number for ERA Display
 ;                         A4 - Actual display line
 N AMT,DTPOST,DTREC,LCNT,IENS,LN,PAYER,RECEIPT,TRDOC,USER,XX,YY
 S IENS=IEN34441_","_IEN3444_","
 S LCNT=$P(ONEERA,"^",1)+1
 S $P(ONEERA,"^",1)=LCNT                    ; ERA Line counter
 ;
 ; Build detail line for ERA Detail record being process
 S XX=$$GET1^DIQ(344.4,IEN3444,.07,"I")     ; ERA Date Received
 S DTREC=$$FMTE^XLFDT(XX,"2DZ")
 S XX=$$GET1^DIQ(344.41,IENS,9,"I")         ; Auto-Post Date
 S DTPOST=$$FMTE^XLFDT(XX,"2DZ")
 S XX=$$GET1^DIQ(344.41,IENS,.25,"I")       ; Receipt Pointer
 S RECEIPT=$$GET1^DIQ(344,XX,.01,"I")       ; Receipt Number
 S TRDOC=$$GET1^DIQ(344,XX,200,"I")         ; FMS Document #
 I RECEIPT="" D
 . S $P(ONEERA,"^",4)=1
 . S RECEIPT="* Missing *"
 S XX=$O(^RCY(344.72,"E",IEN3444,""))       ; IEN of the Auto-Post Audit File entry
 S USER=$$GET1^DIQ(344.72,XX,.02,"I")       ; User IEN who marked for Auto-Post
 S USER=$$GET1^DIQ(200,USER,1,"I")          ; Initials of User who marked for Auto-Post
 S AMT=$$GET1^DIQ(344.41,IENS,.03,"I")      ; Amount Paid
 I RECEIPT'="* Missing *" D
 . S YY=$P(ONEERA,"^",3)                    ; Current Receipt Total
 . S $P(ONEERA,"^",3)=AMT+YY                ; Updated Receipt Total
 S AMT=$J(AMT,12,2)                         ; Formatted Paid
 I OUTYPE=2 D  Q                            ; Output to Excel
 . S LN=$$GET1^DIQ(344.4,IEN3444,.06,"I")   ; Payment From
 . S LN=LN_"^"_IEN3444_"^"_DTREC_"^"_DTPOST_"^"_RECEIPT
 . S $P(LN,"^",10)=USER
 . S $P(LN,"^",11)=AMT
 . S $P(LN,"^",12)=TRDOC
 . S ONEERA(LCNT)=LN
 ;
 S LN="       "
 S LN=$$SETSTR^VALM1(DTREC,LN,9,10)
 S LN=$$SETSTR^VALM1(DTPOST,LN,19,10)
 S LN=$$SETSTR^VALM1(RECEIPT,LN,30,$L(RECEIPT))
 S LN=$$SETSTR^VALM1(USER,LN,43,$L(USER))
 S LN=$$SETSTR^VALM1(AMT,LN,50,$L(AMT))
 S LN=$$SETSTR^VALM1(TRDOC,LN,65,$L(TRDOC))
 S ONEERA(LCNT)=LN
 Q
 ;
ADDERAH(OUTYPE,ONEERA,IEN3444) ; Add the header lines to ERA output array
 ; Input:   OUTYPE      - O - Output to Screen or paper
 ;                        1 - Output to Listman
 ;                        2 - Output to Excel
 ;          ONEERA      - A1^A2^A3^A4 Where:
 ;                        A1 - Number of lines in the ERA display
 ;                        A2 - Total Receipt amount for the ERA (formatted)
 ;                        A3 - Total Amount paid for the ERA (formatted)
 ;                        A4 - 1 if ERA contains at least one detail record 
 ;                               with a missing receipt.
 ;                             0 otherwise
 ;          ONEERA(LN)=A4- Where
 ;                        LN - Line number for ERA Display
 ;                        A4 - Actual display line
 ;          IEN3444     - Internal IEN for file 344.4
 ; Ouput:   ONEERA      - Receipt Total Formatted, ERA Lines 1-4 added
 N LN,MISSINGR,TOTERA,TOTREC,TRACE,XX
 S XX=$P(ONEERA,"^",3)                      ; Final Receipt Total
 S TOTREC=$J(XX,12,2)                       ; Formatted total
 S TOTERA=$P(ONEERA,"^",2)                  ; Formatted ERA Total
 S XX=$$COMPLETE^RCDPELAR(IEN3444)
 S MISSINGR=$S(XX=0:"* Missing Receipts *",1:"")
 S TRACE=$$GET1^DIQ(344.4,IEN3444,.02,"I")  ; Trace Number
 I OUTYPE=2 D  Q                            ; Excel output
 . S XX=""
 . F  D  Q:XX=""
 . . S XX=$O(ONEERA(XX))
 . . Q:XX=""
 . . S $P(ONEERA(XX),"^",6)=TRACE            ; Formatted Receipt Total
 . . S $P(ONEERA(XX),"^",7)=TOTREC           ; Formatted Receipt Total
 . . S $P(ONEERA(XX),"^",8)=$P(ONEERA,"^",2) ; Formatted ERA Total
 . . S $P(ONEERA(XX),"^",9)=MISSINGR
 ;
 ; 1st Main ERA display line
 S LN="ERA: "
 S LN=$$SETSTR^VALM1(IEN3444,LN,6,$L(IEN3444))
 S LN=$$SETSTR^VALM1("ERA Total: ",LN,20,11)
 S LN=$$SETSTR^VALM1(TOTERA,LN,32,$L(TOTERA))
 S LN=$$SETSTR^VALM1(MISSINGR,LN,53,$L(MISSINGR))
 S XX=$P(ONEERA,"^",1)+1
 S $P(ONEERA,"^",1)=XX                       ; Update Line counter
 S ONEERA(.1)=LN
 ;
 ; 2nd Main ERA display line
 S LN="                Receipt Total:"
 S LN=$$SETSTR^VALM1(TOTREC,LN,32,$L(TOTREC))
 S XX=$P(ONEERA,"^",1)+1
 S $P(ONEERA,"^",1)=XX                       ; Update Line counter
 S ONEERA(.2)=LN
 ;
 ; 3rd Main ERA display line
 S LN="                      Trace #:"
 S XX=$$GET1^DIQ(344.4,IEN3444,.02,"I")     ; Trace Number
 S LN=$$SETSTR^VALM1(XX,LN,32,$L(XX))
 S XX=$P(ONEERA,"^",1)+1
 S $P(ONEERA,"^",1)=XX                      ; Update Line counter
 S ONEERA(.3)=LN
 Q
 ;
OUTERA(INPUT,OUTYPE,PAYER,ONEERA,LNCNT,PAGE) ; Output the display lines for one ERA
 ; Input:   INPUT   - See REPORT for a complete description
 ;          OUTYPE      - O - Output to Screen or paper
 ;                        1 - Output to Listman
 ;                        2 - Output to Excel
 ;          PAYER       - Payer Name
 ;          ONEERA      - Array of lines to display for one ERA
 ;          LNCNT       - Current Line Count
 ;          PAGE        - Current Page Count
 ; Output:  LNCNT       - Updated Line Count
 ;          PAGE        - Updated Page Count
 ;          A9          - Part of Input above
 ;                        Updated Line counter for Listman Output
 ;          ^TMP("RCDPE_LAR",$J,CTR)=Line - Array of display lines (no headers)
 ;                                          for output to Listman
 ;                                          Only set when A7-1
 ; Returns: 1 if user quit, 0 otherwise
 N LN,STOP,XX
 S STOP=0
 S XX=LNCNT-4+$P(ONEERA,"^",1)                ; LNCNT + # of lines to display
 I 'OUTYPE,(XX>(IOSL-3)) D  Q:STOP 1
 . S STOP=$$ASKSTOP^RCDPELAR()
 . Q:STOP
 . S LNCNT=0
 . D HEADER(INPUT,.LNCNT,.PAGE)
 . D ERAHDR(PAYER,.LNCNT,.PAGE)
 S LN=""
 F  D  Q:LN=""  Q:STOP
 . S LN=$O(ONEERA(LN))
 . Q:LN=""
 . S LNCNT=LNCNT+1
 . I OUTYPE=1 D  Q
 . . S XX=$P(INPUT,"^",9)+1
 . . S $P(INPUT,"^",9)=XX
 . . S ^TMP("RCDPE_LAR",$J,XX)=ONEERA(LN)
 . W !,ONEERA(LN)
 S LNCNT=LNCNT+1
 W:OUTYPE=0 !
 I OUTYPE=1 D
 . S XX=$P(INPUT,"^",9)+1
 . S $P(INPUT,"^",9)=XX
 . S ^TMP("RCDPE_LAR",$J,XX)=" "
 Q STOP
 ;
HEADER(INPUT,LNCNT,PAGE) ; Display a Page Header
 ; Input:   INPUT   - See REPORT for a complete description
 ;          LNCNT   - Current Line Count
 ;          PAGE    - Current Page Count
 ; Output:  LNCNT   - Updated Line Count
 ;          PAGE    - Updated Page Count
 N XX,YY,ZZ
 S YY="AUTO-POSTED RECEIPT REPORT",PAGE=PAGE+1
 S XX=$$NOW^XLFDT(),XX=$$FMTE^XLFDT(XX)
 S XX=$$SETSTR^VALM1(XX,YY,40,21)
 S YY="Page: "_$J(PAGE,3)
 S XX=$$SETSTR^VALM1(YY,XX,72,$L(YY))
 S LNCNT=LNCNT+1
 W @IOF,XX
 ;
 S LNCNT=LNCNT+1
 S XX=$$HDRLN2(INPUT)
 W !,XX
 ;
 S LNCNT=LNCNT+1
 S XX=$$HDRLN3(INPUT)
 W !,XX
 ;
 S LNCNT=LNCNT+1
 W !                                        ; Blank line
 Q
 ;
HDRLN2(INPUT) ; Build the 2nd header line
 ; Input:   INPUT   - See REPORT for a complete description
 ; Returns: Text for 2nd header line
 N XX,YY,ZZ
 S XX=" FILTERS: "_$S($P(INPUT,"^",1)=1:"All",1:"Selected")_" Divs;"
 S XX=XX_$S($P(INPUT,"^",5)=1:" All",1:" Selected")_" Payers;"
 S XX=XX_$S($P(INPUT,"^",2)=1:" Auto-Post Date",1:" ERA Dt Received")
 S YY=$P($P(INPUT,"^",3),"|",1),YY=$$FMTE^XLFDT(YY,"2Z")
 S ZZ=$P($P(INPUT,"^",3),"|",2),ZZ=$$FMTE^XLFDT(ZZ,"2Z")
 S XX=XX_" "_YY_" to "_ZZ
 Q XX
 ;
HDRLN3(INPUT) ; Build the 2nd header line
 ; Input:   INPUT   - A1^A2^A3^...^An Where:
 ;                       A1 - 1 - All divisions selected
 ;                            2 - Selected divisions
 ;                       A2 - 1 - Filter by Auto-Post date range
 ;                            2 - Filter by ERA Date Received date range
 ;                       A3 - B1|B2   - Where:
 ;                             B1 - ERA Date Received Start Date if A2=2
 ;                                  Auto-Post Start Date of A2=1
 ;                             B2 - ERA Date Received End Date if A2=2
 ;                                  Auto-Post End Date of A2=1
 ;                       A4 - 1 - Posted/Completed Receipts
 ;                            2 - Only ERAs with Missing Receipts
 ;                            3 - Both Posted/Completed and Missing Receipts
 ;                       A5 - 1 - All insurance companies selected
 ;                            2 - Selected insurance companies chosen
 ;                       A6 - 1 - Auto-Post Date/ERA Date Received Sort
 ;                            2 - Payer sort
 ;                            3 - Missing Receipts
 ;                       A7 - 0 - Do not display in a listman template
 ;                            1 - Display in a listman template
 ;                       A8 - 0 - Output to paper
 ;                            1 - Output to Excel
 ;                       A9 - Line counter for Listman output  
 ; Returns: Text for 2nd header line
 N XX,YY,ZZ
 S YY=$P(INPUT,"^",4)
 S:YY=1 ZZ="Posted/Completed Receipts"      ; Receipt filter
 S:YY=2 ZZ="Missing Receipts Only"
 S:YY=3 ZZ="All Receipts"
 S XX=" ERA: "_ZZ
 S XX=$$SETSTR^VALM1("SORT: ",XX,40,6)
 S YY=$P(INPUT,"^",6)                       ; Selected Sort
 I YY=1,$P(INPUT,"^",2)=1 S ZZ="Auto-Post Date"
 I YY=1,$P(INPUT,"^",2)=2 S ZZ="ERA Date Received"
 I YY=2 S ZZ="Payer"
 I YY=3 S ZZ="Missing Receipts"
 S XX=$$SETSTR^VALM1(ZZ,XX,46,$L(ZZ))
 Q XX
 ;
ERAHDR(PAYER,LNCNT,PAGE) ; Display ERA Header Lines
 ; Input:   PAYER   - Payer Name
 ;          LNCNT   - Current Line Count
 ;          PAGE    - Current Page Count
 ; Output:  LNCNT   - Updated Line Count
 ;          PAGE    - Updated Page Count
 N XX,YY,ZZ
 S LNCNT=LNCNT+1
 S XX="        DATE      DATE"
 W !,XX
 ;
 S LNCNT=LNCNT+1
 S XX=$$ERAHDR2()
 W !,XX
 ;
 S LNCNT=LNCNT+1
 S XX=$J("",80),XX=$TR(XX," ","-")
 W !,XX
 ;
 S LNCNT=LNCNT+1
 W !,"Payer: ",PAYER
 Q
 ;
ERAHDR2() ; Build the 2nd ERA header line
 ; Input:   None
 ; Returns: Text for 2nd ERA header line
 N XX
 S XX="        " ;RECEIVED  POSTED     RECEIPT"
 S XX=$$SETSTR^VALM1("RECEIVED",XX,9,8)
 S XX=$$SETSTR^VALM1("POSTED",XX,19,6)
 S XX=$$SETSTR^VALM1("RECEIPT",XX,30,7)
 S XX=$$SETSTR^VALM1("USER",XX,43,4)
 S XX=$$SETSTR^VALM1("      AMOUNT",XX,50,12)
 S XX=$$SETSTR^VALM1("FMS DOC",XX,65,7)
 Q XX
 ;

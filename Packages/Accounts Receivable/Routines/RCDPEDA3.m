RCDPEDA3 ;AITC/DW - ACTIVITY REPORT ;Feb 17, 2017@10:37:00
 ;;4.5;Accounts Receivable;**318,321,326,432,439**;Mar 20, 1995;Build 29
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
HDR(INPUT) ;EP from RCDPEDAR
 ; Displays report header
 ; Input:   INPUT       - A1^A2^A3^...^An Where:
 ;                         A1 - 1 if called from Nightly Process, 0 otherwise
 ;                         A2 - 1 if displaying to Listman, 0 otherwise
 ;                         A3 - 1 if Detail report, 0 if summary report
 ;                         A4 - Current Page Number
 ;                         A5 - Stop Flag
 ;                         A6 - Start of Date Range
 ;                         A7 - End of Date Range
 ;                         A9 - Current line count
 ;                         A10- 1 - Only Display EFTs with a debit flag of 'D'
 ;                              0 - Display all EFTs
 ;                         A11- A - All, Display all EFTs
 ;                              B - Balanced, Only display EFTs for deposits that are balanced
 ;                              U - Unbalanced, Only display EFTs for deposits that are unbalanced
 ; Output:  INPUT       - A1^A2^A3^...^An - The following pieces may be updated
 ;                         A4 - Current Page Number
 ;                         A5 - Stop Flag
 ;                         A8 - Updated line count
 N CTR,CURPG,DETL,DONLY,DTST,DTEND,NJ,NOJUST,PLN,RCUNBAL,STOP,X,XX,Y,Z,Z0,Z1
 S DETL=$P(INPUT,"^",3)
 S CURPG=$P(INPUT,"^",4)
 S STOP=$P(INPUT,"^",5)
 S DTST=$P(INPUT,"^",6)                     ; Date Range Start
 S DTEND=$P(INPUT,"^",7)                    ; Date Range Ends
 S DONLY=$P(INPUT,"^",10)                   ; EFTs with Debits Only  ;PRCA*4.5*321 add debit logic
 S RCUNBAL=$P(INPUT,"^",11)                 ; (B)Balanced/)U)Unblanced/(A)All filter selection for deposits  ;PRCA*4.5*439 add deposit balance logic
 S NJ=$P(INPUT,"^",1)
 Q:NJ&(CURPG)
 I CURPG!($E(IOST,1,2)="C-") D
 . Q:NJ
 . I CURPG,($E(IOST,1,2)="C-") D  Q:STOP
 . . S STOP=$$ASK()
 . W @IOF ; Write form feed
 I STOP S $P(INPUT,"^",5)=1 Q
 S CURPG=CURPG+1,$P(INPUT,"^",4)=CURPG
 ;
 ; PRCA276 if coming from nightly job need to define payer selection variable
 I NJ N RCPAY,RCTYPE D  ; PRCA*4.5*321
 . S RCPAY="A"
 . S RCTYPE="A"
 ;
 ; PRCA276 if coming from nightly job need to define division selection variable
 I NJ N VAUTD S VAUTD=1
 S Z0="EDI LOCKBOX EFT DAILY ACTIVITY "_$S(DETL:"DETAIL",1:"SUMMARY")_" REPORT"
 S Z=$$SETSTR^VALM1($J("",80-$L(Z0)\2)_Z0,"",1,79)
 S Z=$$SETSTR^VALM1("Page: "_CURPG,Z,70,10)
 D SL(.INPUT,Z)
 S Z="RUN DATE: "_$$FMTE^XLFDT($$NOW^XLFDT(),"2Z"),Z=$J("",80-$L(Z)\2)_Z
 D SL(.INPUT,Z)
 ;
 ; PRCA276 add divisions to header
 S Z1=""
 I 'VAUTD D
 . S Z0=0
 . F  D  Q:'Z0
 .. S Z0=$O(VAUTD(Z0))
 .. Q:'Z0
 .. S XX=$$GET1^DIQ(40.8,Z0,1,"I") ;Facility Number   ;PRCA*4.5*321
 .. ;S Z1=Z1_VAUTD(Z0)_", "
 .. S Z1=Z1_XX_", "
 S Z="DIVISIONS: "_$S(VAUTD:"ALL",1:$E(Z1,1,$L(Z1)-2)),Z=$J("",80-$L(Z)\2)_Z
 D SL(.INPUT,Z)
 ;
 S NOJUST=0
 ; PRCA*4.5*326 - Use RCPAY for payer selection type in header, Add M/P/T filter
 S Z="PAYERS: "_$S(RCPAY="A":"ALL",RCPAY="R":"RANGE",1:"SELECTED")
 S Z=$E(Z_$J("",80),1,38)_"MEDICAL/PHARMACY/TRICARE/CHAMPVA: "  ;PRCA*4.5*432 Add CHAMPVA, 44->38
 S Z=Z_$S(RCTYPE="M":"MEDICAL",RCTYPE="P":"PHARMACY",RCTYPE="T":"TRICARE",RCTYPE="C":"CHAMPVA",1:"ALL")  ;PRCA*4.5*432 Add CHAMPVA
 ; PRCA*4.5*326 End changes.
 D SL(.INPUT,Z)
 S CTR=1
 F  D  Q:CTR=""
 . S CTR=$O(PLN(CTR))
 . Q:CTR=""
 . D SL(.INPUT,PLN(CTR))
 ;
 ; PRCA276  add date filter to header
 S Z="DATE RANGE: "_$$FMTE^XLFDT(DTST,"2Z")_" - "_$$FMTE^XLFDT(DTEND,"2Z")
 S Z=Z_" (DATE DEPOSIT ADDED)        DEBIT ONLY EFTs: "   ; PRCA*4.5*321 debit info
 S Z=Z_$S(DONLY:"YES",1:"NO")
 S Z=$J("",80-$L(Z)\2)_Z
 D SL(.INPUT,Z)
 ;
 ; PRCA*4.5*439 Add Deposit Balance/Unbalance/All filter to header
 S Z="",$P(Z," ",60)=""  ;Add 60 spaces
 S Z=Z_"DEPOSITS: "
 S Z=Z_$S(RCUNBAL="U":"UNBALANCED",RCUNBAL="B":"BALANCED  ",1:"ALL       ")
 S Z=$J("",80-$L(Z)\2)_Z
 D SL(.INPUT,Z)
 ;
 I DETL D
 . ;
 . ; PRCA*4.5*283 - Add 3 more spaces between DEP # and DEPOSIT DT 
 . ; and remove 3 spaces between DEPOSIT DT and DEP AMOUNT to allow for 9 digit DEP #'s
 . D SL(.INPUT,"")
 . S XX="DEP #      DEPOSIT DT  "_$J("",19)_"DEP AMOUNT          FMS DEPOSIT STAT"
 . S Z=$$SETSTR^VALM1(XX,"",1,$L(XX))
 . D SL(.INPUT,Z)
 . ;
 . ; PRCA*4.5*318, Move entire EFT # row to left 1 space to adjust for other rows needing space
 . ; PRCA*4.5*284, Move Match Status to left 3 space to allow for 10 digit ERA #'s
 . ; PRCA*4.5*326 - make room and add match date
 . S XX=$J("",2)_"EFT #"_$J("",15)_"DATE PD   PAYMENT AMOUNT  ERA MATCH STATUS & DATE"
 . S Z=$$SETSTR^VALM1(XX,"",1,$L(XX))
 . D SL(.INPUT,Z)
 . ; PRCA*4.5*318, Move entire EFT Payer Trace # row to left 6 spaces to adjust for other rows needing space
 . S Z=$$SETSTR^VALM1($J("",4)_"EFT PAYER TRACE #","",1,52)
 . S Z=$$SETSTR^VALM1("CR #",Z,59,4)     ;PRCA*4.5*318 add CR #
 . D SL(.INPUT,Z)
 . ; PRCA*4.5*318, Move entire Payment From row to left 8 spaces to adjust 
 . ; a possible 60 character Payer Name and 20 character Payer ID
 . S XX=$J("",6)_"PAYMENT FROM"
 . S Z=$$SETSTR^VALM1(XX,"",1,$L(XX))
 . D SL(.INPUT,Z)
 . S XX=$J("",3)_"TR #"                    ;PRCA*4.5*318 add TR #
 . S Z=$$SETSTR^VALM1(XX,"",1,$L(XX))
 . D SL(.INPUT,Z)                          ; TR DOC header
 . S XX=$J("",44)_"DEP RECEIPT #"  ;PRCA*4.5*321 ; PRCA*4.5*432
 . S Z=$$SETSTR^VALM1(XX,"",1,$L(XX))
 . S Z=$$SETSTR^VALM1("DEP RECEIPT STATUS",Z,61,19)
 . D SL(.INPUT,Z)
 D SL(.INPUT,$TR($J("",IOM-1)," ","="))
 Q
 ;
TOTSDAY(INPUT) ;EP from RCDPEDAR
 ;               Display the totals for the specified date
 ;
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
 ;          ^TMP($J,"TOTALS","DEBIT")       - Current Total # of debits for date range
 ;          ^TMP($J,"TOTALS","DEBIT","D")   - Total # of debits for Internal date (C1)
 ;          ^TMP($J,"TOTALS","DEBITA")      - Current Total Debit Amount for date range
 ;          ^TMP($J,"TOTALS","DEBITA","D")  - Total Debit Amount for Internal date (C1)
 ;          ^TMP($J,"TOTALS","DEP")         - Current Total # of deposits for date range
 ;          ^TMP($J,"TOTALS","DEP",C1)      - Total # of deposits for Internal date (C1)
 ;          ^TMP($J,"TOTALS","DEPA")        - Current Total Deposit Amount for date range
 ;          ^TMP($J,"TOTALS","DEPA",C1)     - Total Deposit Amount for Internal date (C1)
 ;          ^TMP($J,"TOTALS","EFT","D")     - Total Deposit Amount by EFTs for date
 ;          ^TMP($J,"TOTALS","EFT","T")     - Current Total Deposit Amount by EFTs for range
 ;          ^TMP($J,"TOTALS","FMS")         - FMS Document Status or "NO FMS DOC"
 ;          ^TMP($J,"TOTALS","FMS","D",-1)  - Total Deposit Amount by FMS Document
 ;          ^TMP($J,"TOTALS","FMS","D",0)   - Total Amount for Error/Rejected documents
 ;          ^TMP($J,"TOTALS","FMS","D",1")  - Total Amount for 'A','M',"F' or 'T' docs
 ;          ^TMP($J,"TOTALS","FMS","D",2")  - Total Amount for queued docs
 ;          ^TMP($J,"TOTALS","FMS","T",-1)  - Total Deposit Amount by FMS Document for range
 ;          ^TMP($J,"TOTALS","FMS","T",0)   - Total Amount for Error/Rejected docs for range
 ;          ^TMP($J,"TOTALS","FMS","T",1")  - Total Amount for 'A','M',"F' or 'T' docs range
 ;          ^TMP($J,"TOTALS","FMS","T",2")  - Total Amount for queued docs for range
 ;          ^TMP($J,"TOTALS","FMSTOT")      - Updated Total Deposit Amount for date range
 ;          ^TMP($J,"TOTALS","MATCH","D")   - Current Total matched EFTs for date
 ;          ^TMP($J,"TOTALS","MATCH","T")   - Current Total matched EFTs for date range
 ; Output:  INPUT       - A1^A2^A3^...^An - The following pieces may be updated
 ;                         A4 - Updated Page Number
 ;                         A5 - Stop Flag
 ;                         A8 - Updated Line Counter
 ;          ^TMP($J,"TOTALS","DEBIT")       - Updated Total # of debits for date range
 ;          ^TMP($J,"TOTALS","DEBIT","D")   - Updated Total # of debits for Internal date (C1)
 ;          ^TMP($J,"TOTALS","DEBITA")      - Updated Total Debit Amount for date range
 ;          ^TMP($J,"TOTALS","DEBITA","D")  - Updated Total Debit Amount for Internal date (C1)
 ;          ^TMP($J,"TOTALS","DEP")         - Updated Total # of deposits for date range
 ;          ^TMP($J,"TOTALS","DEPA")        - Updated Total Deposit Amount for date range
 ;          ^TMP($J,"TOTALS","EFT","T")     - Updated Total Deposit Amount by EFTs for range
 ;          ^TMP($J,"TOTALS","FMS","T",-1)  - Updated Deposit Amount by FMS Document for range
 ;          ^TMP($J,"TOTALS","FMS","T",0)   - Updated Amount for Error/Rejected docs for range
 ;          ^TMP($J,"TOTALS","FMS","T",1")  - Updated Amount for 'A','M',"F' or 'T' docs range
 ;          ^TMP($J,"TOTALS","FMS","T",2")  - Updated Amount for queued docs for range
 ;          ^TMP($J,"TOTALS","MATCH","T")   - Updated Total Matched EFTs for date range
 N CURPG,DETL,DTADD,LSTMAN,NL,Q,XX,YY
 S LSTMAN=$P(INPUT,"^",2)                   ; Display to Listman flag
 S NJ=$P(INPUT,"^",1)                       ; Called from Nightly Process flag
 S DETL=$P(INPUT,"^",3)                     ; Detail Report flag
 S CURPG=$P(INPUT,"^",4)                    ; Current Page Counter
 S DTADD=$P(INPUT,"^",9)                    ; Date to display totals for
 S XX=$G(^TMP($J,"TOTALS","DEPA"))          ; Current Total Deposit Amount for date range
 S YY=$G(^TMP($J,"TOTALS","DEPA",DTADD))    ; Total Deposit Amount for date
 S ^TMP($J,"TOTALS","DEPA")=XX+YY           ; Updated Total for range
 S XX=$G(^TMP($J,"TOTALS","DEP"))           ; Current Total # of Deposits for date range
 S YY=$G(^TMP($J,"TOTALS","DEP",DTADD))     ; Total # of Deposits for date
 S ^TMP($J,"TOTALS","DEP")=XX+YY            ; Updated Total # for range
 ;
 S XX=$G(^TMP($J,"TOTALS","EFT","T"))       ; Current Total Amount by EFTs for date range
 S YY=$G(^TMP($J,"TOTALS","EFT","D"))       ; Total Amount by EFTs for date
 S ^TMP($J,"TOTALS","EFT","T")=XX+YY        ; Updated Total Amount for range
 ;
 S XX=$G(^TMP($J,"TOTALS","MATCH","T"))     ; Current Total # Matched EFTs for date range
 S YY=$G(^TMP($J,"TOTALS","MATCH","D"))     ; # Matched EFTs for date
 S ^TMP($J,"TOTALS","MATCH","T")=XX+YY      ; Updated Total # Matched EFTs for date range
 ;
 ; Update document status totals for range
 F Q=-1,0,1,2 D
 . S XX=$G(^TMP($J,"TOTALS","FMS","T",Q))   ; Current Total # of Q status for date range
 . S YY=$G(^TMP($J,"TOTALS","FMS","D",Q))   ; # of Q status for date
 . S ^TMP($J,"TOTALS","FMS","T",Q)=XX+YY    ; Updated Total # of Q status for date range
 ;
 ; daily totals
 ;I $S('NJ:($Y+5)>IOSL,1:0)!'CURPG D  Q:$P(INPUT,"^",5)=1  ; PRCA*4.5*321 changed
 I $S('NJ:1,1:0)!'CURPG D  Q:$P(INPUT,"^",5)=1
 . D:'LSTMAN HDR(.INPUT)
 S XX=$E("**TOTALS FOR DATE: "_$$FMTE^XLFDT(DTADD\1,"2Z")_$J("",30),1,30)
 S YY=$G(^TMP($J,"TOTALS","DEP",DTADD))
 S XX=XX_"   # OF DEPOSIT TICKETS RECEIVED: "_+YY_$J("",5)
 D SL(.INPUT,XX)
 S YY=$G(^TMP($J,"TOTALS","DEPA",DTADD))
 S XX=$J("",29)_"TOTAL AMOUNT OF DEPOSITS RECEIVED: $"_$J(YY,"",2)
 D SL(.INPUT,XX)
 Q:$P(INPUT,"^",5)=1
 D SL(.INPUT," ")
 D SL(.INPUT,$J("",20)_"DEPOSIT AMOUNTS SENT TO FMS:")
 Q:$P(INPUT,"^",5)=1
 S YY=+$G(^TMP($J,"TOTALS","FMS","D",1))
 S XX=$J("",39)_"ACCEPTED: $"_$J(YY,"",2)
 D SL(.INPUT,XX)
 Q:$P(INPUT,"^",5)=1
 S YY=+$G(^TMP($J,"TOTALS","FMS","D",2))
 S XX=$J("",41)_"QUEUED: $"_$J(YY,"",2)
 D SL(.INPUT,XX)
 Q:$P(INPUT,"^",5)=1
 S YY=+$G(^TMP($J,"TOTALS","FMS","D",0))
 S XX=$J("",35)_"ERROR/REJECT: $"_$J(YY,"",2)
 D SL(.INPUT,XX)
 Q:$P(INPUT,"^",5)=1
 S YY=+$G(^TMP($J,"TOTALS","FMS","D",-1))
 S XX=$J("",37)_"NOT IN FMS: $"_$J(YY,"",2)
 D SL(.INPUT,XX)
 D SL(.INPUT," ")
 Q:$P(INPUT,"^",5)=1
 ;
 ; PRCA*4.5*321 add all debit logic
 S XX=$G(^TMP($J,"TOTALS","DEBIT"))         ; Current Total # of debit EFTs for date range
 S YY=$G(^TMP($J,"TOTALS","DEBIT","D"))     ; Total # of debit EFTs for date
 S ^TMP($J,"TOTALS","DEBIT")=XX+YY          ; Updated Total # of debit EFTs for range
 S XX=$G(^TMP($J,"TOTALS","DEBITA"))        ; Current Total amount of debit EFTs for date range
 S YY=$G(^TMP($J,"TOTALS","DEBITA","D"))    ; Total amount of debit EFTs for date
 S ^TMP($J,"TOTALS","DEBITA")=XX+YY         ; Updated Total amount of debit EFTs for range
 S YY=+$G(^TMP($J,"TOTALS","DEBIT","D"))
 S XX=$J("",27)_"# EFT DEBIT VOUCHERS: "_YY
 D SL(.INPUT,XX)
 S YY=+$G(^TMP($J,"TOTALS","DEBITA","D"))
 S XX=$J("",33)_"DEBIT VOUCHERS: $"_$J(YY,"",2)
 D SL(.INPUT,XX)
 D SL(.INPUT," ")
 ;
 S YY=+$G(^TMP($J,"TOTALS","EFT","D"))
 S XX=$J("",26)_"# EFT PAYMENT RECORDS: "_YY
 D SL(.INPUT,XX)
 Q:$P(INPUT,"^",5)=1
 S YY=+$G(^TMP($J,"TOTALS","MATCH","D"))
 S XX=$J("",25)_"# EFT PAYMENTS MATCHED: "_YY
 D SL(.INPUT,XX)
 Q:$P(INPUT,"^",5)=1
 ; PRCA*4.5*321 remove Matched payment amt posted
 ;S YY=+$G(^TMP($J,"TOTALS","DEPAP",DTADD))
 ;S XX=$J("",18)_"MATCHED PAYMENT AMOUNT POSTED: $"_$J(YY,"",2)
 ;D SL(.INPUT,XX)
 D SL(.INPUT," ")
 Q
 ;
TOTSF(INPUT) ; EP from RCDPEDAR
 ;             Display Final Totals
 ;
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
 ;          ^TMP($J,"TOTALS","DEP")         - Total # of deposits for date range
 ;          ^TMP($J,"TOTALS","DEPA")        - Total Deposit Amount for date range
 ;          ^TMP($J,"TOTALS","EFT","T")     - Total Deposit Amount by EFTs for range
 ;          ^TMP($J,"TOTALS","FMS","T",-1)  - Total Deposit Amount by FMS Document for range
 ;          ^TMP($J,"TOTALS","FMS","T",0)   - Total Amount for Error/Rejected docs for range
 ;          ^TMP($J,"TOTALS","FMS","T",1")  - Total Amount for 'A','M',"F' or 'T' docs range
 ;          ^TMP($J,"TOTALS","FMS","T",2")  - Total Amount for queued docs for range
 ;          ^TMP($J,"TOTALS","MATCH","T")   - Total Matched EFTs for date range
 ; Output:  INPUT       - A1^A2^A3^...^An - The following pieces may be updated
 ;                         A5 - Updated Page Number
 ;                         A6 - Stop Flag
 ;                         A8 - Updated Line Counter
 N LSTMAN,NJ,XX,YY
 S LSTMAN=$P(INPUT,"^",2),NJ=$P(INPUT,"^",1)
 ;
 ; header if no output was displayed and not being displayed in listman
 ;I '$O(^TMP("RCDAILYACT",$J,0)),'LSTMAN D HDR(.INPUT)  ; PRCA*4.5*321 hdr regardless if no output
 I 'LSTMAN D HDR(.INPUT)
 ;
 ; If user quit or (Nightly process flag AND not display to listman) - end here
 I $P(INPUT,"^",5)=1!(NJ&'LSTMAN) Q
 ;D SL(.INPUT," ")                                        ; PRCA*4.5*321 removed
 S XX=$E("**** TOTALS FOR DATE RANGE:"_$J("",30),1,30)
 S YY=+$G(^TMP($J,"TOTALS","DEP"))
 S XX=XX_"   # OF DEPOSIT TICKETS RECEIVED: "_YY_$J("",5)
 D SL(.INPUT,XX)
 S YY=+$G(^TMP($J,"TOTALS","DEPA"))
 S XX=$J("",29)_"TOTAL AMOUNT OF DEPOSITS RECEIVED: $"_$J(YY,"",2)
 D SL(.INPUT,XX)
 D SL(.INPUT," ")
 D SL(.INPUT,$J("",20)_"DEPOSIT AMOUNTS SENT TO FMS:")
 S YY=+$G(^TMP($J,"TOTALS","FMS","T",1))
 S XX=$J("",39)_"ACCEPTED: $"_$J(YY,"",2)
 D SL(.INPUT,XX)
 S YY=+$G(^TMP($J,"TOTALS","FMS","T",2))
 S XX=$J("",41)_"QUEUED: $"_$J(YY,"",2)
 D SL(.INPUT,XX)
 S YY=+$G(^TMP($J,"TOTALS","FMS","T",0))
 S XX=$J("",35)_"ERROR/REJECT: $"_$J(YY,"",2)
 D SL(.INPUT,XX)
 S YY=+$G(^TMP($J,"TOTALS","FMS","T",-1))
 S XX=$J("",37)_"NOT IN FMS: $"_$J(YY,"",2)
 D SL(.INPUT,XX)
 D SL(.INPUT," ")
 ;
 S YY=+$G(^TMP($J,"TOTALS","DEBIT"))
 S XX=$J("",21)_"TOTAL # EFT DEBIT VOUCHERS: "_YY
 D SL(.INPUT,XX)
 S YY=+$G(^TMP($J,"TOTALS","DEBITA"))
 S XX=$J("",27)_"TOTAL DEBIT VOUCHERS: $"_$J(YY,"",2)
 D SL(.INPUT,XX)
 D SL(.INPUT," ")
 ;
 S YY=+$G(^TMP($J,"TOTALS","EFT","T"))
 S XX=$J("",26)_"# EFT PAYMENT RECORDS: "_YY
 D SL(.INPUT,XX)
 S YY=+$G(^TMP($J,"TOTALS","MATCH","T"))
 S XX=$J("",25)_"# EFT PAYMENTS MATCHED: "_YY
 D SL(.INPUT,XX)
 ; PRCA*4.5*321 remove Matched payment amt posted
 ;S YY=+$G(^TMP($J,"TOTALS","DEPAP"))
 ;S XX=$J("",18)_"MATCHED PAYMENT AMOUNT POSTED: $"_$J(YY,"",2)
 ;D SL(.INPUT,XX)
 D SL(.INPUT," ")
 D SL(.INPUT," ")
 Q
 ;
ASK() ; Ask to continue
 ; PRCA*4.5*321 changed to extrinsic function
 ; Input: None
 ; Returns: 1 if user wants to stop, 0 otherwise
 I $E(IOST,1,2)'["C-" Q 0
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="E" W ! D ^DIR
 I ($D(DIRUT))!($D(DUOUT)) Q 1
 Q 0
 ;
SL(INPUT,Z) ;EP from RCDPEDAR & RCDEPA2
 ;            Writes or stores line
 ;
 ; Input:   INPUT                   - A1^A2^A3^...^An Where:
 ;                                      A1 - 1 if called from Nightly Process, 0 otherwise
 ;                                      A2 - 1 if displaying to Listman, 0 otherwise
 ;                                      A3 - 1 if Detail report, 0 if summary report
 ;                                      A4 - Current Page Number
 ;                                      A5 - Stop Flag
 ;                                      A6 - Start of Date Range
 ;                                      A7 - End of Date Range
 ;                                      A8 - Current Line Number
 ;          Z                       - Data line to write or store
 ;          RCCT                    - Current line counter
 ;          RCNJ                    - 1 to set array, 0 to write line
 ;          ^TMP($J,"RCDPE_DAR")    - Current array of stored lines (if RCNJ=1)
 ; Output:  INPUT                   - A1^A2^A3^...^An - The following pieces may be updated
 ;                                      A11 - Updated Line Number
 ; Output:  
 ;          ^TMP($J,"RCDPE_DAR")    - Updated array of stored lines (if RCNJ=1)
 N XX
 S XX=$P(INPUT,"^",8)+1
 S $P(INPUT,"^",8)=XX
 ;
 ; Called from nightly process
 I $P(INPUT,"^",1) S ^TMP($J,"RCDPE_DAR",XX)=Z Q
 W !,Z
 Q

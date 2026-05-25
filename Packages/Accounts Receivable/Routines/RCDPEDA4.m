RCDPEDA4 ;AITC/DW - ACTIVITY REPORT ;Feb 17, 2017@10:37:00
 ;;4.5;Accounts Receivable;**318,321,326,432,439,446**;Mar 20, 1995;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ; Continuation of RCDPEDAR - Daily activity Report
 Q
 ;
ERRMSGS(INPUT,IEN3443) ;EP from RCDPEDA2
 ; Display any EFT error messages
 ; Input:   INPUT               - See EFTERRS for details
 ;          IEN3443             - Internal IEN for file 344.3
 ;          ^TMP($J,"DEPERRS")  - Current Line Count
 ;                                Note: Only passed if not in detail mode
 ;          ^TMP($J,"DEPERRS,X) - Error line(s)
 ; Output:  ^TMP($J,"DEPERRS")  - Current Line Count
 ;                                Note: Only passed if not in detail mode
 ;
 ; PRCA*4.5*321 capture display and line cnt to ^TMP($J,"DEPERRS")
 N DETL,ERRS,LNCT,XX,ZZ
 S DETL=$P(INPUT,"^",3)
 S XX=$$GET1^DIQ(344.3,IEN3443,2,"I","ERRS")    ; Error Message WP field
 Q:'$D(ERRS)                                    ; No errors
 S XX=$J("",3)_"ERROR MESSAGES FOR EFT:"
 S LNCT=$G(^TMP($J,"DEPERRS"))+1
 S ^TMP($J,"DEPERRS")=LNCT
 S ^TMP($J,"DEPERRS",LNCT)=XX
 S XX=""
 F  D  Q:XX=""
 . S XX=$O(ERRS(XX))
 . Q:XX=""
 . S ZZ=$J("",5)_ERRS(XX)
 . S LNCT=$G(^TMP($J,"DEPERRS"))+1
 . S ^TMP($J,"DEPERRS")=LNCT
 . S ^TMP($J,"DEPERRS",LNCT)=ZZ
 Q
 ; 
EFTERRS(INPUT,IEN34431,EFTCTR) ;EP from RCDPEDA2
 ; Output any EFT Detail errors
 ; Input:   INPUT       - A1^A2^A3^...^An Where:
 ;                          A1 - 1 if called from Nightly Process, 0 otherwise
 ;                          A2 - 1 if displaying to Listman, 0 otherwise
 ;                          A3 - 1 if Detail report, 0 if summary report
 ;                          A4 - Current Page Number
 ;                          A5 - Stop Flag
 ;                          A6 - Start of Date Range
 ;                          A7 - End of Date Range
 ;                          A8 - Current Line Counter
 ;                          A9 - Internal Date being processed
 ;                          A10- 1 - Only Display EFTs with a debit flag of 'D'
 ;                               0 - Display all EFTs
 ;          IEN34431    - Internal IEN for file 344.31
 ;          EFTCTR                  - Used to store lines for EFT
 ;          ^TMP($J,ONEDEP,0,1)     - Deposit Detail line
 ;          ^TMP($J,ONEDEP,EFTCTR)  - Current # of lines for EFT
 ;          ^TMP($J,ONEDEP,EFTCTR,xx)- EFT Deposit Lines
 ; Output   ^TMP($J,ONEDEP,EFTCTR)  - Updated # of lines for EFT
 ;          ^TMP($J,ONEDEP,EFTCTR,xx)- Updated EFT Deposit Lines
 Q:'$O(^RCY(344.31,IEN34431,2,0))           ; No error message
 N EFTLN,ERRS,V,XX,YY
 S XX=$J("",3)_"ERROR MESSAGES FOR EFT DETAIL:"
 S EFTLN=$G(^TMP($J,"ONEDEP",EFTCTR))+1
 S ^TMP($J,"ONEDEP",EFTCTR)=EFTLN
 S ^TMP($J,"ONEDEP",EFTCTR,EFTLN)=XX
 S XX=$$GET1^DIQ(344.31,IEN34431,2,"I","ERRS")
 S V=""
 F  D  Q:V=""
 . S V=$O(ERRS(V))
 . Q:V=""
 . S XX=$J("",5)_ERRS(V)
 . S EFTLN=EFTLN+1
 . S ^TMP($J,"ONEDEP",EFTCTR)=EFTLN
 . S ^TMP($J,"ONEDEP",EFTCTR,EFTLN)=XX
 Q
 ;
LMHDR(RCSTOP,RCDET,RCNJ,RCDT1,RCDT2,RCHDR,DONLY) ;EP from RCDPEDAR      
 ; ListMan report heading
 ; Input:   RCDET       - 1 to display detail, 0 otherwise
 ;          RCNJ        - Set 1, indicates report was called from the nightly
 ;                        process OR displaying to listman.  Used to set lines
 ;                        into a ^TMP array instead of displaying them.
 ;          RCDT1       - Internal Start Date of date range
 ;          RCDT2       - Internal End Date of date range
 ;          DONLY       - 1 - Only EFTs with debits, 0 - display all EFTs
 ;          RCNP        - Payer Selection flag A1^A2^A3 Where:
 ;                         A1 - 1 - Range,2 - All,3 -Specific
 ;                         A2 - From Payer text (only set if A1=1)
 ;                         A3 - Through text (only set if A1=1)
 ;          ^TMP("RCSELPAY",$J,B1) - Selected payers to be displayed
 ; Output:  RCHDR       - Array of listman header lines
 ;          RCSTOP      - 1 if user stopped 
 ;
 N RCCT,X,XX,Y,Z,Z0,Z1
 S RCCT=0
 S XX=$S(RCDET:"DETAIL",1:"SUMMARY")_" REPORT"
 S RCHDR("TITLE")="EDI LOCKBOX EFT DAILY ACTIVITY "_XX
 S Z1=""
 I 'VAUTD D
 . S Z0=0
 . F  D  Q:'Z0
 . . S Z0=$O(VAUTD(Z0))
 . . Q:'Z0
 . . S XX=$$GET1^DIQ(40.8,Z0,1,"I")  ; Facility Number  ;PRCA*4.5*321
 . . ;S Z1=Z1_VAUTD(Z0)_", "
 . . S Z1=Z1_XX_", "
 S Z="DIVISIONS: "_$S(VAUTD:"ALL",1:$E(Z1,1,$L(Z1)-2))
 ; PRCA*4.5*439 Add Deposit Balance/Unbalance/All filter to header
 S Z1=$L(Z),Z1=59-Z1,Z0="",$P(Z0," ",Z1)=""  ;Add spaces
 S Z=Z_Z0_"DEPOSITS: "
 S Z=Z_$S(RCUNBAL="U":"UNBALANCED  ",RCUNBAL="B":"BALANCED    ",1:"ALL         ")
 S Z=$J("",80-$L(Z)\2)_Z
 I 'RCDET D
 . S RCCT=RCCT+1,RCHDR(RCCT)=""
 S RCCT=RCCT+1,RCHDR(RCCT)=Z
 ;
 I 'RCDET D
 . S RCCT=RCCT+1,RCHDR(RCCT)=""
 S Z="DATE RANGE: "_$$FMTE^XLFDT(RCDT1,"2Z")_" - "
 S Z=Z_$$FMTE^XLFDT(RCDT2,"2Z")_" (DATE DEPOSIT ADDED)"
 S Z=Z_"        DEBIT ONLY EFTs: "_$S(DONLY=1:"YES",1:"NO") ; PRCA*4.5*321 Added line
 I 'RCDET D
 . S RCCT=RCCT+1,RCHDR(RCCT)=""
 S RCCT=RCCT+1,RCHDR(RCCT)=Z
 I RCDET D
 . S XX="DEP #      DEPOSIT DT  "_$J("",19)
 . S XX=XX_"DEP AMOUNT          FMS DEPOSIT STAT"
 . S Z=$$SETSTR^VALM1(XX,"",1,80)
 . S RCCT=RCCT+1,RCHDR(RCCT)=Z
 . ; PRCA*4.5*318, Move entire EFT # row to left 1 space to adjust for other rows needing space
 . ; PRCA*4.5*326 - make room and add match date
 . S XX=$J("",2)_"EFT #"_$J("",15)_"DATE PD   PAYMENT AMOUNT  ERA MATCH STATUS & DATE"
 . S Z=$$SETSTR^VALM1(XX,"",1,80)
 . S RCCT=RCCT+1,RCHDR(RCCT)=Z
 . ; PRCA*4.5*318, Move entire EFT Payer Trace # row to left 6 spaces to adjust for other rows needing space
 . S Z=$$SETSTR^VALM1($J("",4)_"EFT PAYER TRACE #","",1,30)
 . ;PRCA*4.5*318 add CR #
 . S Z=$$SETSTR^VALM1("CR #",Z,59,80)
 . S RCCT=RCCT+1,RCHDR(RCCT)=Z
 . ; PRCA*4.5*318, Move entire Payment From row to left 8 spaces to adjust 
 . ; a possible 60 character Payer Name and 20 character Payer ID
 . S Z=$$SETSTR^VALM1($J("",6)_"PAYMENT FROM","",1,30)
 . S Z=$$SETSTR^VALM1("DEP RECEIPT #",Z,45,30)   ; PRCA*4.5*321 used to be 31,30
 . S Z=$$SETSTR^VALM1("DEP RECEIPT STATUS",Z,61,19)
 . S RCCT=RCCT+1,RCHDR(RCCT)=Z
 . ;PRCA*4.5*318 add TR #s
 . S Z=$$SETSTR^VALM1("TR #","",4,30)
 . S RCCT=RCCT+1,RCHDR(RCCT)=Z
 Q
 ;
GETTR(IEN34431,INPUT)   ;EP from RCDPEDA2
 ; Gathers and Displays all TR Doc #s for a specified EFT detail record
 ; PRCA*4.5*318 add TR #s to detail rpt
 ; Input:   IEN34431                - Internal IEN for file #344.31
 ;          INPUT                   - See EFTERRS for details
 ;          EFTCTR                  - Used to store lines for EFT
 ;          ^TMP($J,ONEDEP,0,1)     - Deposit Detail line
 ;          ^TMP($J,ONEDEP,EFTCTR)  - Current # of lines for EFT
 ;          ^TMP($J,ONEDEP,EFTCTR,xx)- EFT Deposit Lines
 ; Output   ^TMP($J,ONEDEP,0,1)     - Updated Detail line
 ;          ^TMP($J,ONEDEP,EFTCTR)  - Updated # of lines for EFT
 ;          ^TMP($J,ONEDEP,EFTCTR,xx)- EFT Deposit Lines
 ;
 ; PRCA*4.5*321 capture display to ^TMP($J,"ONEDEP",EFTRCR) including line cnt
 N CTR,EFTLN,IEN3444,IENS,LNCT,RECEIPT,TRDOC,TRDOCS,XX,ZZ
 ;
 ; First gather up all the TR Document numbers into as many lines as needed
 S CTR=1,LNCT=$G(^TMP($J,"ONEDEP"))
 S EFTLN=$G(^TMP($J,"ONEDEP",EFTCTR))
 S IEN3444=$$GET1^DIQ(344.31,IEN34431,.1,"I") ; Internal IEN for for 344.4
 S RECEIPT=$$GET1^DIQ(344.4,IEN3444,.08,"I")  ; Receipt # from 344.4
 I RECEIPT'="" D
 . S TRDOC=$TR($$GET1^DIQ(344,RECEIPT,200,"I")," ")    ; FMS Document #
 . I TRDOC="" Q
 . S TRDOCS(CTR)=TRDOC
 . S XX=""
 . F  D  Q:XX=""
 . . S XX=$O(^RCY(344.4,IEN3444,8,XX))
 . . Q:XX=""
 . . S IENS=XX_","_IEN3444_","
 . . S RECEIPT=$$GET1^DIQ(344.48,IENS,.01,"I")  ; Other receipt numbers
 . . I RECEIPT="" Q
 . . S TRDOC=$TR($$GET1^DIQ(344,RECEIPT,200,"I")," ")   ; FMS Document #
 . . Q:TRDOC=""
 . . I $L(TRDOC)+$L($G(TRDOCS(CTR)))+1>73 D  Q
 . . . S CTR=CTR+1,TRDOCS(CTR)=TRDOC
 . . S TRDOCS(CTR)=TRDOCS(CTR)_", "_TRDOC
 ;
 ; Now display the TR Document numbers
 I '$D(TRDOCS) D  Q    ; blank line for TR#s
 . S EFTLN=EFTLN+1
 . S ^TMP($J,"ONEDEP",EFTCTR)=EFTLN
 . S ^TMP($J,"ONEDEP",EFTCTR,EFTLN)=" "
 S XX=""
 F  D  Q:XX=""
 . S XX=$O(TRDOCS(XX))
 . Q:XX=""
 . S EFTLN=EFTLN+1
 . S ^TMP($J,"ONEDEP",EFTCTR)=EFTLN
 . S ^TMP($J,"ONEDEP",EFTCTR,EFTLN)=$J("",3)_TRDOCS(XX)
 Q
 ;
DEPBAL(RCDIEN) ;Is the deposit total in balance with EFT amounts ; New subroutine PRCA*4.5*439
 ; If modified, also check DEPBAL^RCDPTAR2
 ; Input:   RCDIEN  - IEN for EDI LOCKBOX DEPOSIT, #344.3
 ;
 ; Output:  RCBALS, returned via function call
 ;          Piece 1 - 1 if in balance, 0 if out of balance
 ;          Piece 2 - null (no longer needed PRCA*4.5*446) Total of EFTs on the deposit
 ;          Piece 3 - Deposit Total
 ;
 ; PRCA*4.5*446, Modify sub-routine to use unbalanced flag in 344.3
 ;
 N DTOT,DEPDATA,EFTDATA,RCBALS
 S RCBALS="0^^0"
 ;
 Q:'$G(RCDIEN) RCBALS                                           ; Error condition, IEN is missing or incorrect
 ;
 S DEPDATA=$G(^RCY(344.3,RCDIEN,0)) Q:'$L($G(DEPDATA)) RCBALS   ; Quit if zero node does not exist or has bad data
 S DTOT=$P(DEPDATA,U,8)                                         ; Get total deposit amount
 ;
 S $P(RCBALS,U,3)=DTOT
 S $P(RCBALS,U,1)='$$GET1^DIQ(344.3,RCDIEN_",",.15,"I")         ; Equal to 1 if inbalance, 0 otherwise
 ;
 Q RCBALS
 ;
UNBALONLY() ; Allows the user to select filter to only show Balanced, Unbalanced or All deposits
 ; PRCA*4.5*439 Added subroutine
 ; Input:   None
 ; Returns: A - All, B - Balanced, U - Unbalanced, (-1) - User '^' or timeout
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,RTNFLG,Y
 ;
 S RTNFLG=0
 ;
 ; Select option required (All, Balanced or Unbalanced)
 S DIR(0)="SA^B:Balanced;U:Unbalanced;A:All"
 S DIR("A")="(B)alanced deposits, (U)nbalanced deposits or (A)LL?: "  ; PRCA*4.5*332
 S DIR("?",2)="Enter 'A' to select all deposits, both balanced and unbalanced."
 S DIR("B")="All"
 S DIR("?",1)="Enter 'U' to select only unbalanced deposits."
 S DIR("?")="Enter 'B' to select only balanced deposits."
 D ^DIR K DIR
 ;
 ; Abort on ^ exit or timeout
 I $D(DTOUT)!$D(DUOUT) S RTNFLG=-1 Q RTNFLG
 ;
 I Y="" S Y="A"
 ;
 Q Y
 ;
RTYPE() ; Allows the user to select the report type (Summary/Detail)
 ; Input:   None
 ; Returns: 0       - Summary Display
 ;          1       - Detail Display
 ;         -1       - User up-arrowed or timed out
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR("A")="(S)UMMARY OR (D)ETAIL?: "
 S DIR(0)="SA^S:SUMMARY TOTALS ONLY;D:DETAIL AND TOTALS"
 S DIR("B")="D"
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") Q -1
 Q Y="D"
 ;
DTRANGE(STDATE,ENDDATE) ; Allows the user to select the date range to by used
 ; Input:   None
 ; Output:  STDATE  = Internal Fileman Date to start at
 ;          ENDDATE - Internal Fileman Date to end at
 ; Returns: 0 - User up-arrowed or timed out, 1 otherwise
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR("?")="Enter the earliest date of receipt of deposit to include on the report."
 S DIR(0)="DAO^:"_DT_":APE"
 S DIR("A")="START DATE: "
 D ^DIR
 Q:$D(DTOUT)!$D(DUOUT)!(Y="") 0
 S STDATE=Y
 K DIR
 S DIR("?")="Enter the latest date of receipt of deposit to include on the report."
 S DIR("B")=Y(0)
 S DIR(0)="DAO^"_RCDT1_":"_DT_":APE",DIR("A")="END DATE: "
 D ^DIR
 Q:$D(DTOUT)!$D(DUOUT)!(Y="") 0
 S ENDDATE=Y
 Q 1
 ;
DBTONLY() ; Allows the user to select filter to only show EFTs with debits
 ; PRCA*4.5*321 Added subroutine
 ; Input:   None
 ; Returns: 0       - All EFTs to display
 ;          1       - Only EFTs with debits to be displayed
 ;         -1       - User up-arrowed or timed out
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR("A")="Show EFTs with debits only? "
 S DIR(0)="SA^Y:YES;N:NO"
 S DIR("B")="NO"
 S DIR("?",1)="Enter 'YES' to only show EFTs with a debit flag of 'D'."
 S DIR("?")="Enter 'NO' to show all EFTs."
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") Q -1
 Q $E(Y,1)="Y"
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
 N EFTLN,X,XX,YY
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
EXCELHDR ;Excel header  ; PRCA*4.5*439 Add EXCELHDR tag
 ;
 W !!,"DEP #^UNBALANCED^DEPOSIT DT^DEP AMOUNT^FMS DEPOSIT STAT^"
 W "EFT #^DATE PD^PAYMENT AMOUNT^ERA MATCH STATUS^ERA^DATE^EFT PAYER TRACE #^CR #^PAYMENT FROM^PAYER TIN^TR #^DEP RECEIPT #^DEP RECEIPT STATUS"
 Q
 ;
 ; Moved tag DUP to RCDPEDA4 from RCDPEDA2 PRCA*4.5*439
 ; Moved tags to RCDPEDA4 from RCDPEDAR: RTYPE, DTRANGE, DBTONLY, EXCELHDR; PRCA*4.5*439

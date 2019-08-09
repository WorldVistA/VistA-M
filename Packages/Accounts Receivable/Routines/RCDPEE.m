RCDPEE ;AITC/FA -Select Partially Matched EFTs ; 29-MAY-2018
 ;;4.5;Accounts Receivable;**332**;Mar 20, 1995;Build 40
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
EN(ERAIEN) ;EP from Manual Match, MATCH1^RCDPEM2
 ; Input:   ERAIEN  - IEN of the ERA to show partial matches for
 ; Returns: IEN of the selected EFT or "" if none selected
 N RCQUIT,XX
 S RCQUIT=0
 K ^TMP("RCPM_PARAMS",$J),^TMP("RCDPEU1",$J)
 S ^TMP("RCPM_PARAMS",$J,"ERAIEN")=ERAIEN
 D FULL^VALM1
 S RCQUIT=$$DTR()                           ; Set date range filter
 Q:RCQUIT
 S RCQUIT=$$CLAIMTYP()                      ; Ask Claim Type
 Q:RCQUIT
 S RCQUIT=$$PAYR()                          ; Ask for selected payers
 Q:RCQUIT
 D EN^VALM("RCDPE EFT PARTIAL MATCH")
 Q
 ;
DTR() ;EP from RCDPEPMR
 ; Date Range Selection
 ; Input:   ^TMP("RCPM_PARAMS",$J,"RCDT") - Current selected Date Range (if any)
 ; Output:  ^TMP("RCPM_PARAMS",$J,"RCDT") - Updated Selected Date Range
 ; Returns: 1 if user quit or timed out, 0 otherwise
 N DIR,DIRUT,DTOUT,DTQUIT,DUOUT,FROM,RCDTRNG,TO,Y
 S ^TMP("RCPM_PARAMS",$J,"RCDT")="0^"_DT
 S DTQUIT=0
 S FROM=$P($G(^TMP("RCPM_PARAMS",$J,"RCDT")),"^",1)
 S TO=$P($G(^TMP("RCPM_PARAMS",$J,"RCDT")),"^",2)
 S RCDTRNG=$$DTRANGE(FROM,TO)
 Q:RCDTRNG="^" 1
 S ^TMP("RCPM_PARAMS",$J,"RCDT")=RCDTRNG
 Q 0
 ;
DTRANGE(DEFFROM,DEFTO) ; Asks for and returns a Date Range
 ; Input:   DEFFROM - Default FROM date
 ;          DEFTO   - Default TO date
 ; Output:  From_Date^To_Date (YYYMMDD^YYYDDMM) or "^" (timeout or ^ entered)
 N DIR,Y,DTOUT,DUOUT,RCDFR,START
 S RCQUIT=0
 S DIR(0)="DAE^:"_DT_":E"
 S DIR("A")="Earliest date: "
 S DIR("?")="Enter the start of the date range."
 S:($G(DEFFROM)) DIR("B")=$$FMTE^XLFDT(DEFFROM,2)
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q "^"
 S RCDFR=Y,START=$$FMTE^XLFDT(RCDFR,"2DZ")
 K DIR
 S DIR(0)="DAE^"_RCDFR_":"_DT_":E"
 S DIR("A")="Latest date: "
 S DIR("?",1)="Enter the end of the date range. The ending date must be greater than "
 S DIR("?")="or equal to "_START_"."
 S:($G(DEFTO)) DIR("B")=$$FMTE^XLFDT(DEFTO,2)
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q "^"
 Q (RCDFR_"^"_Y)
 ;
CLAIMTYP()  ;EP from RCDPEPMR
 ; Claim Type (Medical/Pharmacy/Both) Selection
 ; Input:   ^TMP("RCPM_PARAMS")             - Global array of preferred values (if any)
 ; Output:  ^TMP("RCPM_PARAMS",$J,"RCTYPE") - EFT Claim Type filter
 ; Returns: 1 if user quit or timed out, 0 otherwise
 N RCTYPE
 S RCTYPE=$$RTYPE^RCDPEU1("ALL")
 I RCTYPE<0 Q 1
 S ^TMP("RCPM_PARAMS",$J,"RCTYPE")=RCTYPE
 Q 0
 ;
PAYR() ;EP from RCDPEPMR
 ; Payer Selection
 ; Input:   ^TMP("RCPM_PARAMS",$J,"RCTYPE")     - M/P/T filter selection
 ; Output:  ^TMP("RCPM_PARAMS",$J,"RCPAYR")     - Payer filter selection
 ;          ^TMP("RCDPEU1",$J)                  - If specific payers were selected
 ; Returns: 1 if user quit or timed out, 0 otherwise
 N RCPAR,RCPAY,RCTYPE,XX
 K ^TMP("RCPDEU1",$J)
 S RCTYPE=$G(^TMP("RCPM_PARAMS",$J,"RCTYPE"))
 S RCPAY=$$PAYRNG^RCDPEU1(0,0,0,"SELECT")        ; Selected or Range of Payers
 Q:RCPAY=-1 1
 ;
 I RCPAY'="A" D  Q:XX=-1 1              ; Since we don't want all payers 
 . S RCPAR("SELC")=RCPAY                ; prompt for payers we do want
 . S RCPAR("TYPE")=RCTYPE
 . S RCPAR("FILE")=344.31
 . S RCPAR("DICA")="Select Insurance Company NAME: "
 . S XX=$$SELPAY^RCDPEU1(.RCPAR)
 S ^TMP("RCPM_PARAMS",$J,"RCPAYR")=RCPAY
 Q 0
 ;
HDR ;EP from listman template RCDPE EFT PARTIAL MATCH
 ; Display listman header
 ; Input: ^TMP("RCPM_PARAMS",$J)
 ; Output: VALMHDR
 N ERAIEN,X,XX,XX2,YY
 S X=$G(^TMP("RCPM_PARAMS",$J,"RCDT"))
 S XX="DATE RANGE: "
 S XX=XX_$$FMTE^XLFDT($P(X,"^",1),"2ZD")
 I $P(X,"^",2) S XX=XX_"-"_$$FMTE^XLFDT($P(X,"^",2),"2ZD")
 S X=$G(^TMP("RCPM_PARAMS",$J,"RCTYPE"))
 S XX2="M/P/T: "
 S XX2=XX2_$S(X="M":"MEDICAL ONLY",X="P":"PHARMACY ONLY",X="T":"TRICARE ONLY",1:"ALL")
 S XX=$$SETSTR^VALM1(XX2,XX,35,21)
 ;
 S X=$G(^TMP("RCPM_PARAMS",$J,"RCPAYR"))
 I $P(X,"^",1)="A"!(X="") D
 . S XX2="ALL PAYERS"
 E  S XX2="SELECTED"
 S XX2="PAYERS: "_XX2
 S XX=$$SETSTR^VALM1(XX2,XX,62,18)
 S VALMHDR(1)=XX
 ;
 ; Build 2nd Header Line
 S ERAIEN=$G(^TMP("RCPM_PARAMS",$J,"ERAIEN"))
 S XX="ERA #: "_ERAIEN
 S XX2=$$GET1^DIQ(344.4,ERAIEN_",",.02,"I")         ; ERA Trace #
 S XX2="Trace #: "_XX2
 S XX=$$SETSTR^VALM1(XX2,XX,20,60)
 S VALMHDR(2)=XX
 ;
 ; Build 3rd Header Line
 S YY=$$GET1^DIQ(344.4,ERAIEN_",",.03,"I")          ; ERA Payer TIN
 S XX=$$GET1^DIQ(344.4,ERAIEN_",",.06,"I")          ; ERA Payer Name
 S XX2=XX_"/"_YY
 S:$L(XX2)>63 XX2=$E(XX,1,79-$L(YY))_"/"_YY
 S VALMHDR(3)="Payer Name/TIN: "_XX2
 ;
 ; Build 4TH Header Line
 S YY=$$GET1^DIQ(344.4,ERAIEN_",",.05,"I")          ; ERA Total Amount Paid
 S XX="  Total Amt Pd: "_$J(YY,12,2)
 S VALMHDR(4)=XX
 ;
 S VALMHDR(5)=""
 S VALMHDR(6)=" #   EFT #      Trace Number                                        Total Amt Pd"
 Q
 ;
INIT ;EP from listman template RCDPE EFT PARTIAL MATCH
 ; Display listman body
 ; Build the display of EFTs that are partially matched
 ; Input:   ^TMP("RCPM_PARAMS",#J)  - Selected Parameters
 N EFTAMT,EFTDR,EFTREM,EFTTIN,EFTTR,ERAIEN,ERATIN,ERATOT,ERATR,RCDTFR,RCDTTO,XX
 D CLEAN^VALM10
 K ^TMP("RCPM-WL",$J),^TMP("RCPM-WL_WLDX",$J),^TMP($J,"RCPM_LIST")
 S ERAIEN=$G(^TMP("RCPM_PARAMS",$J,"ERAIEN"))
 S XX=$G(^TMP("RCPM_PARAMS",$J,"RCDT"))
 S RCDTFR=+$P(XX,"^",1)
 S RCDTTO=$S($P(XX,"^",2):$P(XX,"^",2),1:DT)
 S ERATIN=$$GET1^DIQ(344.4,ERAIEN_",",.03,"I")      ; ERA Payer TIN
 S ERATIN=$$UP^XLFSTR(ERATIN)
 S ERATR=$$GET1^DIQ(344.4,ERAIEN_",",.02,"I")       ; ERA Trace #
 S ERATR=$$UP^XLFSTR(ERATR)
 S ERATOT=$$GET1^DIQ(344.4,ERAIEN_",",.05,"I")      ; ERA Total Amount Paid
 S EFTIEN=0
 ;
 ; Search for all unmatched, not removed EFTs that are partially matched for 
 ; the specified date range
 F  D  Q:'EFTIEN
 . S EFTIEN=$O(^RCY(344.31,"AMATCH",0,EFTIEN))
 . Q:'EFTIEN
 . S EFTREM=$$GET1^DIQ(344.31,EFTIEN_",",.17,"I")   ; User who removed EFT
 . Q:EFTREM'=""                                     ; Skip removed EFTs
 . S EFTAMT=$$GET1^DIQ(344.31,EFTIEN_",",.07,"I")   ; Amount of Payment
 . Q:'EFTAMT                                        ; Skip EFTs with no Payment Amount
 . S EFTDR=$$GET1^DIQ(344.31,EFTIEN_",",.13,"I")    ; Date Received
 . Q:$$FMDIFF^XLFDT(RCDTFR,EFTDR,1)>0               ; Date Received before start of range
 . Q:$$FMDIFF^XLFDT(EFTDR,RCDTTO,1)>0               ; Date Received after end of range
 . Q:'$$FILTEFT(EFTIEN)                             ; Didn't pass selected filters
 . D EFTCHK(EFTIEN,ERATIN,ERATOT,ERATR)             ; Check for partial matched EFTs
 ;
 I $D(^TMP($J,"RCPM_LIST")) D BLD Q                 ; Build the list main display
 ;
 ; No EFTs found, display the message below in the list area
 S ^TMP("RCPM-WL",$J,1,0)="THERE ARE NO EFTs MATCHING YOUR SELECTION CRITERIA"
 S VALMCNT=0
 Q
 ;
EFTCHK(EFTIEN,ERATIN,ERATOT,ERATR) ; Check for partially matched EFTs
 ; Input:   EFTIEN  - IEN of the EFT being checked (#344.31)
 ;          ERATIN  - Payer TIN on the ERA record
 ;          ERATOT  - ERA Total Amount Paid
 ;          ERATR   - ERA Trace #
 ; Output:  ^TMP($J,"RCPM_LIST,MATCHW,EFTSEQ)=A1^...^A11 Where
 ;                    MATCHW - Weighted number derived from partial matches
 ;                    EFTSEQ - Unique EFT Sequence #
 ;                    A1 - Number of matches between the ERA and the EFT
 ;                    A2 - Payer TIN # if matched, else ""
 ;                    A3 - Payer Trace # if matched, else ""
 ;                    A4 - Total Amount paid if matched else ""
 ;                    A5 - Matched weighted value
 ;                         10 points for a match on Trace Number
 ;                          5 points for a match on Total Amount
 ;                          1 point for a match on TIN
 ;                         Only matches with a weigted value of 5 or more are displayed
 ;                    A6 - EFT IEN
 ;                    A7 - Deposit #
 ;                    A8 - Internal Deposit Date
 ;                    A9 - Payer Name/TIN (max 58 characters)
 ;                    A10- EFT Trace #
 ;                    A11- EFT Total Amount Paid
 N DEPDT,DEPNUM,EFTSEQ,EFTTOT,EFTTIN,EFTTR,MATCH,MATCHW,PAYNM,XX,YY
 ;
 S (EFTSEQ,XX)=$$GET1^DIQ(344.31,EFTIEN_",",.01,"I") ; IEN for 344.3
 S DEPNUM=$$GET1^DIQ(344.3,XX_",",.06,"I")          ; Deposit #
 S DEPDT=$$GET1^DIQ(344.3,XX_",",.07,"I")           ; Deposit Date
 Q:$E(DEPNUM,1,3)="HAC"
 S MATCHW=0,MATCH=""
 S XX=$$GET1^DIQ(344.31,EFTIEN_",",.14,"I")         ; EFT Transaction #
 S:XX'="" EFTSEQ=EFTSEQ_"."_XX                      ; EFT Sequence number
 S EFTTOT=$$GET1^DIQ(344.31,EFTIEN_",",.07,"I")     ; EFT Total Amount Paid
 S EFTTIN=$$GET1^DIQ(344.31,EFTIEN_",",.03,"I")     ; EFT TIN
 S EFTTIN=$$UP^XLFSTR(EFTTIN)
 S EFTTR=$$GET1^DIQ(344.31,EFTIEN_",",.04,"I")      ; EFT Trace #
 S EFTTR=$$UP^XLFSTR(EFTTR)
 I EFTTIN=ERATIN D                                  ; Payer TIN match
 . S MATCH=1,MATCHW=MATCHW+1
 . S $P(MATCH,"^",2)=EFTTIN
 I EFTTR=ERATR D                                    ; Trace # number match
 . S XX=$P(MATCH,"^",1),MATCHW=MATCHW+10
 . S $P(MATCH,"^",1)=XX+1
 . S $P(MATCH,"^",3)=EFTTR
 I EFTTOT=ERATOT D                                  ; Total Amount Paid match
 . S XX=$P(MATCH,"^",1),MATCHW=MATCHW+5
 . S $P(MATCH,"^",1)=XX+1
 . S $P(MATCH,"^",4)=EFTTOT
 Q:MATCHW<5                                         ; Only TIN match, skip
 S $P(MATCH,"^",6)=EFTIEN                           ; EFT IEN
 S $P(MATCH,"^",7)=DEPNUM                           ; Deposit #
 S $P(MATCH,"^",8)=DEPDT                            ; Deposit Date (internal)
 S PAYNM=$$GET1^DIQ(344.31,EFTIEN_",",.02,"I")      ; EFT Payer Name
 S XX=PAYNM_"/"_EFTTIN
 S:$L(XX)>73 XX=$E(PAYNM,1,79-$L(EFTTIN))_"/"_EFTTIN
 S $P(MATCH,"^",9)=XX
 S $P(MATCH,"^",10)=EFTTR
 S $P(MATCH,"^",11)=EFTTOT
 S ^TMP($J,"RCPM_LIST",MATCHW,EFTSEQ)=MATCH
 Q
 ;
FILTEFT(EFTIEN) ; Check to see if the EFT passes filter checks
 ; Input:   EFTIEN                          - IEN for the EFT (#344.31)
 ;          ^TMP("RCPM_PARAMS",$J,"RCPAYR") - Payer Selection - 'A','S' or 'R'
 ;          ^TMP("RCPM_PARAMS",$J,"RCTYPE") - M/P/T Selection - 'A','M', 'P' or 'T'
 ;          ^TMP("RCDPEU1",$J)              - Selected payers if ALL not selected
 ; Returns: 1 if EFT passes filter checks, 0 otherwise
 N RCFLAG,RCPAY,RCTYPE,XX
 S XX=$G(^TMP("RCPM_PARAMS",$J,"RCPAYR"))
 S RCPAY=$P(XX,"^",1)
 S RCTYPE=$G(^TMP("RCPM_PARAMS",$J,"RCTYPE"))
 ;
 ; Payer filter check
 I RCPAY'="A" D  Q:'XX 0
 . S XX=$$ISSEL^RCDPEU1(344.31,EFTIEN)
 ;
 ; M/P/T filter check
 I RCTYPE'="A" D  Q:'XX 0
 . S XX=$$ISTYPE^RCDPEU1(344.31,EFTIEN,RCTYPE)
 Q 1
 ;
BLD ; Build listman dislay
 ; Input:   ^TMP($J,"RCPM_LIST,MATCHW,EFTSEQ)=A1^...^A11 Where:
 ;                    MATCHW - Weighted number derived from partial matches
 ;                    EFTSEQ - Unique EFT Sequence #
 ;                    A1 - Number of matches between the ERA and the EFT
 ;                    A2 - Payer TIN # if matched, else ""
 ;                    A3 - Payer Trace # if matched, else ""
 ;                    A4 - Total Amount paid if matched else ""
 ;                    A5 - Matched weighted value
 ;                         10 points for a match on Trace Number
 ;                          5 points for a match on Total Amount
 ;                          1 point for a match on TIN
 ;                         Only matches with a weigted value of 5 or more are displayed
 ;                    A6 - EFT IEN
 ;                    A7 - Deposit #
 ;                    A8 - Internal Deposit Date
 ;                    A9 - Payer Name/TIN (max 58 characters)
 ;                    A10- EFT Trace #
 ;                    A11- EFT Total Amount Paid
 N CTR,EFTSEQ,MATCH,MATCHW
 S CTR=1
 S VALMCNT=0
 S MATCHW=""
 F  D  Q:MATCHW=""
 . S MATCHW=$O(^TMP($J,"RCPM_LIST",MATCHW),-1)
 . Q:MATCHW=""
 . S EFTSEQ=""
 . F  D  Q:EFTSEQ=""
 . . S EFTSEQ=$O(^TMP($J,"RCPM_LIST",MATCHW,EFTSEQ))
 . . Q:EFTSEQ=""
 . . S MATCH=^TMP($J,"RCPM_LIST",MATCHW,EFTSEQ)
 . . D DISPEFT(MATCH,EFTSEQ,.CTR,.VALMCNT)
 ;
 K ^TMP($J,"RCPM_LIST")
 S VALMSG="Enter ?? for more actions and help"
 Q
 ;
DISPEFT(MATCH,EFTSEQ,CTR,VALMCNT) ; Build the display for one EFT
 ; Input:   MATCH       - A1^...^A11 Where:
 ;                         A1 - Number of matches between the ERA and the EFT
 ;                         A2 - Payer TIN # if matched, else ""
 ;                         A3 - Payer Trace # if matched, else ""
 ;                         A4 - Total Amount paid if matched else ""
 ;                         A5 - Matched weighted value
 ;                              10 points for a match on Trace Number
 ;                              5 points for a match on Total Amount
 ;                              1 point for a match on TIN
 ;                              Only matches with a weigted value of 5 or more are displayed
 ;                         A6 - EFT IEN
 ;                         A7 - Deposit #
 ;                         A8 - Internal Deposit Date
 ;                         A9 - Payer Name/TIN (max 58 characters)
 ;                         A10- EFT Trace #
 ;                         A11- EFT Total Amount Paid
 ;          EFTSEQ      - Unique EFT sequence #
 ;          CTR         - Current EFT counter
 ;          VALMCNT     - Current Listman body line counter
 ; Output:  CTR         - Updated EFT counter
 ;          VALMCNT     - Updated Listman body line counter
 N EFTIEN,X,XX,TT
 S EFTIEN=$P(MATCH,"^",6)                   ; EFT IEN
 ;
 ; Build first display line of the EFT
 S YY=$P(MATCH,"^",10) ; Trace Number
 S X=$E(CTR_$J("",4),1,4)_" "_$E(EFTSEQ_$J("",10),1,10)_" "_$E(YY_$J("",50),1,50)
 S X=X_" "_$J($P(MATCH,"^",11),12,2) ; Total Amount Paid
 D SET(X,CTR,EFTIEN,.VALMCNT)
 ;
 ; Build second display line of the EFT
 S XX=$P(MATCH,"^",9)
 S X="     "_$E(XX_$J("",73),1,73) ; Payer Name/TIN
 D SET(X,CTR,EFTIEN,.VALMCNT)
 D SET(" ",CTR,"",.VALMCNT) ; Display blank line
 S CTR=CTR+1
 S VALMSG="Enter ?? for more actions and help"
 Q
 ;
SET(X,RCSEQ,EFTIEN,VALMCNT) ; Set listman body and selection arrays
 ; Input:   X                               - Data to set into the display line
 ;          RCSEQ                           - Selectable line #
 ;          EFTIEN                          - IEN of the EFT record (#344.31)
 ;          VALMCNT                         - Current Display line counter
 ;          ^TMP("RCPM-WL",$J)              - Current global array of body display lines
 ;          ^TMP("RCPM-WL_WLDX",$J,RCSEQ)   -VALMCNT_"^"_EFTIEN
 ; Output:  VALMCNT                         - Updated Display line counter
 ;          ^TMP("RCPM--WL",$J,VALMCNT,0)   - Updated display lines with new line
 ;          ^TMP("RCPM-WL_WLDX",$J,RCSEQ)   -VALMCNT_"^"_ERAIEN
 S VALMCNT=VALMCNT+1,^TMP("RCPM-WL",$J,VALMCNT,0)=X
 S:$G(RCSEQ) ^TMP("RCPM-WL",$J,"IDX",VALMCNT,RCSEQ)=$G(EFTIEN)
 S:$G(EFTIEN) ^TMP("RCPM-WL_WLDX",$J,RCSEQ)=VALMCNT_"^"_EFTIEN
 Q
 ;
HELP ;EP from listman template RCDPE EFT PARTIAL MATCH
 ; help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ;EP from listman template RCDPE EFT PARTIAL MATCH
 ; Exit code
 K ^TMP("RCPM_PARAMS",$J),^TMP("RCDPEU1",$J)
 K ^TMP("RCPM-WL",$J),^TMP("RCPM-WL_WLDX",$J),^TMP($J,"RCPM_LIST")
 Q
 ;
SELEFT ;EP from RCDPE EFT PARTIAL MATCH SELECT
 ; Input: None
 ; Output: ^TMP($J,"SELEFT")-EFTIEN if an EFT was selected
 N PCNT,PROMPT,RCEFT,SEL
 D FULL^VALM1
 S VALM("ENTITY")="#"
 D EN^VALM2($G(XQORNOD(0)),"S")
 S PCNT=$O(VALMY(0))
 Q:'PCNT
 S RCEFT=$P(^TMP("RCPM-WL_WLDX",$J,PCNT),"^",2)
 Q:RCEFT=""
 S VALMBCK="R"
 S RCQUIT=$$SHOWM(RCEFT)
 I RCQUIT S VALMBCK="Q"
 Q
 ;
SHOWM(RCEFT) ; Show EFT details and ask user if this is the correct one
 ; Input : RCEFT - IEN of EFT from file 344.31
 ; Returns : 1 - If match was made, 0 - to refresh patial match list, -1 to exit
 ;
 N DEPDT,DEPNUM,RCQUIT
 D GETDINFO^RCDPEM2(RCEFT,.DEPNUM,.DEPDT)
 W !
 S DIC="^RCY(344.31,",DR="0",DA=RCEFT D EN^DIQ
 W "  DEPOSIT NUMBER: ",DEPNUM,?40,"DEPOSIT DATE: ",DEPDT
 W !
 S DIR("A")="ARE YOU SURE THIS IS THE EFT YOU WANT TO MATCH?: ",DIR(0)="YA",DIR("B")="YES" D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) S RCQUIT=1 Q -1
 I Y'=1 Q 0 ; G ML1  CJE*4.5*332
 ; Go to the Manual match, we have the ERA and EFT
 S RCQUIT=0
 D M12A^RCDPEM2
 I RCQUIT Q -1
 Q 1

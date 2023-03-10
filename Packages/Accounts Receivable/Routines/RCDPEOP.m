RCDPEOP ;AITC/FA - EFT Overrride Report ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**349**;Mar 20, 1995;Build 44
 ;Per VA Directive 6402, this routine should not be modified.
 ;
EN ;EP for EFT Override Report [RCDPE EFT OVERRIDE REPORT]
 N %ZIS,RCDISPTY,RCDTRNG,RCHDR,RCLSTMGR,RCRPLST,RCTYPE
 ; RCDISPTY - display type for Excel
 ; RCDTRNG  - Range of dates
 ; RCLSTMGR - ListMan flag
 ; RCRPLST  - Node for report list in ^TMP
 ; RCTYPE   - Payer type filter M - MEDICAL, P-PHARMACY, T-TRICARE, A-ALL
 ;
 S RCRPLST="RCDPEOP"                        ; Storage for list of entries
 S RCTYPE=$$RTYPE^RCDPEU1("A")
 Q:RCTYPE=-1
 S RCDTRNG=$$DTRNG^RCDPEM4()
 Q:+RCDTRNG<1
 S RCDISPTY=$$DISPTY^RCDPEM3()              ; Ask if export to excel
 Q:RCDISPTY<0
 S RCLSTMGR=""                              ; Initialize
 I RCDISPTY D                               ; Excel, set ListMan flag to prevent question
 . S RCLSTMGR="^"
 . D INFO^RCDPEM6
 I RCLSTMGR="" D  Q:RCLSTMGR<0
 . S RCLSTMGR=$$ASKLM^RCDPEARL
 I RCLSTMGR D  Q                            ; Send output to ListMan
 . D LMOUT(RCRPLST,RCDTRNG,RCTYPE)
 ;
 ; Ask device
 S %ZIS="QM"
 D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . N ZTRTN,ZTSAVE,ZTDESC,POP,ZTSK
 . S ZTRTN="COMPILE^RCDPEOP"
 . S ZTDESC="AR - EFT Unlock Lockout Overrides"
 . S ZTSAVE("RC*")=""
 . D ^%ZTLOAD
 . W !!,$S($G(ZTSK):"Task number "_ZTSK_" was queued.",1:"Unable to queue this task.")
 . K ZTSK,IO("Q")
 . D HOME^%ZIS
 ;
 U IO
 D COMPILE
 D HDRBLD(RCDISPTY,RCDTRNG,RCTYPE,.RCHDR)   ; Build header lines
 D RPT(RCDISPTY,.RCHDR)                     ; Display the report
 K ^TMP($J,"RCRPLST")
 D ^%ZISC                                   ; Close device
 Q
 ;
LMOUT(RCRPLST,RCDTRNG,RCTYPE) ; Output report to Listman
 ; Input:   RCRPLST             - "RCDPEOP"
 ; Input:   RCDTRNG             - ^Start Date^End Date
 ;          RCTYPE              - 'M', 'P', 'T' or 'A'
 ;          RCRPLST             - "RCDPEOP"
 ;          ^TMP($J,RCRPLST)    - Array of data lines to be displayes
 ; Output:  Report is displayed in Listman
 N HDR
 D COMPILE
 S HDR("TITLE")="EFT Unlock Override Tracking"
 S HDR(1)=$$HDRLN1(RCDTRNG)
 S HDR(2)=$$HDRLN2(RCTYPE)
 S HDR(3)=""
 S HDR(4)=""
 S HDR(5)=""
 S HDR(6)=""
 S HDR(7)=$$HDRLN3()
 D LMRPT^RCDPEARL(.HDR,$NA(^TMP($J,RCRPLST)))   ; Generate ListMan display
 ;
 D ^%ZISC                                       ; Close the device
 K ^TMP(RCRPLST,$J),^TMP($J,RCRPLST)
 Q
 ;
COMPILE ; Entry point for queued job
 ; Input:   RCDISPTY            - 1 - Display to Excel, 0 otherwise
 ;          RCDTRNG             - ^Start Date^End Date
 ;          RCLSTMGR            - ListMan flag
 ;          RCTYPE              - 'M', 'P' , 'T' or 'A'
 ;          RCRPLST             - "RCDPEOP"
 ; Output:  ^TMP($J,RCRPLST,CT) - Array of report lines to be displayed
 N CT,D1,RCCTYPE,RCHDR,RCHDT,RCHDTE,RCPGNUM,RCSTOP,RCTOT,RCRPLSTS,XX,YY,ZZ
 S RCRPLSTS="RCDPEOP_SORT"
 K ^TMP(RCRPLST,$J),^TMP($J,RCRPLST)
 ;
 S (RCSTOP,RCTOT,RCTOT("M"),RCTOT("P"),RCTOT("T"),CT)=0
 S RCHDT=$P(RCDTRNG,"^",2)-1,RCHDTE=$P(RCDTRNG,"^",3)+.999999
 F  D  Q:RCSTOP
 . S RCHDT=$O(^RCY(344.61,1,3,"B",RCHDT))
 . I +RCHDT=0 S RCSTOP=1 Q
 . I RCHDT>RCHDTE S RCSTOP=1 Q
 . S D1="" F  S D1=$O(^RCY(344.61,1,3,"B",RCHDT,D1)) Q:D1=""  D
 . . S RCCTYPE=$$GET1^DIQ(344.612,D1_",1,",.04,"I")           ; Type of Override in history file
 . . I RCTYPE'="A",RCTYPE'=RCCTYPE Q                          ; Filter out
 . . D OUTLN(D1,RCDISPTY,RCHDT,RCCTYPE,RCRPLST,.CT,.RCTOT)    ; Store one line in Ouput Arrays
 ;
 ; Reformat array sorted by date and counter to one sorted by line #
 S RCHDT="",XX=0
 F  D  Q:RCHDT=""
 . S RCHDT=$O(^TMP(RCRPLST,$J,RCHDT))
 . Q:RCHDT=""
 . S CT=""
 . F  D  Q:CT=""
 . . S CT=$O(^TMP(RCRPLST,$J,RCHDT,CT))
 . . Q:CT=""
 . . S ZZ=^TMP(RCRPLST,$J,RCHDT,CT),XX=XX+1
 . . S ^TMP($J,RCRPLST,XX)=ZZ
 K ^TMP(RCRPLST,$J)
 Q:RCDISPTY
 ;
 ; Add the totals at the bottom
 S XX=XX+1,^TMP($J,RCRPLST,XX)=""
 I RCTYPE="A"!(RCTYPE="M") D
 . S YY="Total # of Medical Overrides: "_$J(RCTOT("M"),6)
 . S ZZ=$$SETSTR^VALM1(YY,"",45,$L(YY))
 . S XX=XX+1,^TMP($J,RCRPLST,XX)=ZZ
 I RCTYPE="A"!(RCTYPE="P") D
 . S YY="Total # of Pharmacy Overrides: "_$J(RCTOT("P"),5)
 . S ZZ=$$SETSTR^VALM1(YY,"",45,$L(YY))
 . S XX=XX+1,^TMP($J,RCRPLST,XX)=ZZ
 I RCTYPE="A"!(RCTYPE="T") D
 . S YY="Total # of TRICARE Overrides: "_$J(RCTOT("T"),6)
 . S ZZ=$$SETSTR^VALM1(YY,"",45,$L(YY))
 . S XX=XX+1,^TMP($J,RCRPLST,XX)=ZZ
 I RCTYPE="A" D
 . S YY="Total # of EFT Overrides: "_$J(RCTOT,10)
 . S ZZ=$$SETSTR^VALM1(YY,"",45,$L(YY))
 . S XX=XX+1,^TMP($J,RCRPLST,XX)=ZZ
 Q
 ;
OUTLN(D1,RCDISPTY,RCHDT,RCCTYPE,RCRPLST,CT,TOT) ; Store one line of output into arrays
 ; Input:   D1                          - DE of sub-file 344.612 being processed
 ;          RCDISPTY                    - 1 - Display to Excel, 0 otherwise
 ;          RCHDT                       - Internal Date/Time of current entry being processed
 ;          RCCTYPE                     - Current Override Type
 ;          RCRPLST                     - "RCDPEOP"
 ;          CT                          - Current line Count
 ;          TOT                         - Current total # of EFT Lockout Overrides for date range
 ;          TOT("M")                    - Current total # of Medical EFT LO Overrides for range
 ;          TOT("P")                    - Current total # of Rx EFT LO Overrides for range
 ;          TOT("T")                    - Current total # of TRICARE EFT LO Overrides for range
 ;          ^TMP(RCRPLST,$J,RCHDT,CT)   - Current Array of output display lines
 ; Output:  CT                          - Updated line Count
 ;          TOT                         - Updated total # of EFT Lockout Overrides for date range
 ;          TOT("M")                    - Updated total # of Medical EFT LO Overrides for range
 ;          TOT("P")                    - Updated total # of Rx EFT LO Overrides for range
 ;          TOT("T")                    - Updated total # of TRICARE EFT LO Overrides for range
 ;          ^TMP(RCRPLST,$J,RCHDT,CT)   - Updated Array of output display lines
 N LN,RCCOM,RCDYS,RCUSER,XX
 S XX=$$GET1^DIQ(344.612,D1_",1,",.02,"E")      ; User who performed the lockout
 S RCUSER=$E($P(XX,",",1),1,4)
 S RCUSER=RCUSER_","_$E($P(XX,",",2),1)
 S RCCOM=$$GET1^DIQ(344.612,D1_",1,",.03)       ; Lock-out Comment
 S RCDYS=$$GET1^DIQ(344.612,D1_",1,",.05)       ; # of lock-out days when overriden
 S CT=CT+1,TOT=TOT+1
 S XX=$$FMTE^XLFDT(RCHDT,"2ZD")
 I RCDISPTY D  Q                                ; Excel output
 . S ^TMP(RCRPLST,$J,RCHDT,CT)=XX_"^"_RCUSER_"^"_RCCOM_"^"_RCCTYPE_"^"_RCDYS
 S TOT(RCCTYPE)=TOT(RCCTYPE)+1
 S LN=""
 S LN=$$SETSTR^VALM1(XX,LN,1,8)
 S LN=$$SETSTR^VALM1(RCUSER,LN,12,6)
 S LN=$$SETSTR^VALM1(RCCOM,LN,20,50)
 S LN=$$SETSTR^VALM1(RCCTYPE,LN,69,1)
 S LN=$$SETSTR^VALM1($J(RCDYS,4),LN,76,4)
 S ^TMP(RCRPLST,$J,RCHDT,CT)=LN
 Q
 ;
HDRBLD(RCDISPTY,RCDTRNG,RCTYPE,RCHDR) ; Create the report header
 ; Input:   RCDISPTY    - 1 - Output to Excel, 0 otherwise
 ;          RCDTRNG     - User selected date range - ^Start Date End Date
 ;          RCTYPE      - User selected M/P/T filter - 'M', 'P' , 'T' or 'A'
 ; Output:  RCHDR       - Array of header lines to be displayed
 N DIV,HCNT,HNM,XX
 K RCHDR
 I RCDISPTY D  Q                            ; Excel format
 . S RCHDR(1)="Date^User^Comment^Type^# Days"
 ;
 S RCHDR="                       EFT Unlock Override Tracking Report              Page: "
 S RCHDR(1)=$$HDRLN1(RCDTRNG)
 S RCHDR(2)=$$HDRLN2(RCTYPE)
 S RCHDR(3)=$$HDRLN3()
 S RCHDR(4)=$TR($J("",80)," ","-")
 Q
 ;
HDRLN1(RCDTRNG) ; Format the second header display line
 ; Input:   RCDTRNG     - User selected date range - ^Start Date End Date
 ; Returns: text for the first header line after the title line
 N LN,XX,YY,ZZ
 S YY=$$FMTE^XLFDT($P(RCDTRNG,"^",2),"2ZD") ; Start Date
 S ZZ=$$FMTE^XLFDT($P(RCDTRNG,"^",3),"2ZD") ; End Date
 S LN="     Date Range: "_YY_" - "_ZZ
 S XX=$P($$NOW^RCDPEARL,"@",1)
 S XX="Run Date: "_XX
 S LN=$$SETSTR^VALM1(XX,LN,45,$L(XX))
 Q LN
 ;
HDRLN2(RCTPYE) ; Format the second header display line
 ; Input:   RCTYPE      - User selected M/P/T filter - 'M', 'P' , 'T' or 'A'
 ; Returns: text for the third header line after the title line
 N LN,XX
 S XX=$S(RCTYPE="M":"Medical",RCTYPE="P":"Pharmacy",RCTYPE="T":"TRICARE",1:"All")
 S LN="     Medical/Pharmacy/TRICARE: "_XX
 Q LN
 ;
HDRLN3() ;  Format the second header display line
 Q "Date       User    Comment                                        Type    # Days"
 ;
RPT(RCDISPTY,RCHDR) ; Display/print the report using data populated in temporary global array
 ; Input:   RCDISPTY                - 1 - Output to Excel, 0 otherwise
 ;          RCHDR                   - Array of header lines to be displayed
 ;          ^TMP($J,RCRPLST)        - Array of data lines to be displayed or output to excel
 ;                                    
 N DLINE,LN,LNCNT,PAGE,RCSTOP
 S (PAGE,LNCNT,RCSTOP)=0
 I '$D(^TMP($J,RCRPLST)) D  Q
 . D:'RCDISPTY HDRDSP(.PAGE,.LNCNT,.RCHDR,1)
 . W !,$$ENDORPRT^RCDPEARL
 ;
 D:'RCDISPTY HDRDSP(.PAGE,.LNCNT,.RCHDR)
 W:RCDISPTY !,RCHDR(1)
 ;
 S LN=""
 F  D  Q:LN=""  Q:RCSTOP
 . S LN=$O(^TMP($J,RCRPLST,LN))
 . Q:LN=""
 . S DLINE=^TMP($J,RCRPLST,LN),LNCNT=LNCNT+1
 . W:RCDISPTY !,DLINE
 . Q:RCDISPTY
 . I (LNCNT+2)>IOSL D HDRDSP(.PAGE,.LNCNT,.RCHDR,.RCSTOP) Q:RCSTOP
 . W !,DLINE
 D ASK(RCSTOP,1)
 Q
 ;
HDRDSP(PAGE,LNCNT,RCHDR,RCSTOP)  ; Display the report header
 ; Input:   PAGE    - Current page number
 ;          LNCNT   - Current line count
 ;          RCHDR   - Array of header lines to be displayed
 ;          RCSTOP  - 1 to not ask if they want to stop output
 ;                    0 otherwise
 ; Output:  PAGE    - Updated page number
 ;          LNCNT   - Updated line count
 ;          RCSTOP  - 1 if the want to stop the output
 N I
 I PAGE'=0 D ASK(.RCSTOP) Q:RCSTOP
 W @IOF,RCHDR
 S PAGE=PAGE+1
 W $J(PAGE,2)
 F I=1:1:4 W !,RCHDR(I)
 S LNCNT=5
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

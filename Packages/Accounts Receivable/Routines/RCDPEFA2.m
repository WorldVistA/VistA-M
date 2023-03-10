RCDPEFA2 ;AITC/FA - FIRST PARTY AUTO-DECREASE REPORT, cont. ; 5/29/19 12:31pm
 ;;4.5;Accounts Receivable;**345,349**;Mar 20, 1995;Build 44
 ;Per VA Directive 6402, this routine should not be modified.
 ; Read ^DG(40.8) - IA 417
 ; DIVISION^VAUTOMA - IA 664
 ;
 Q
 ;
STADIV(RCVAUTD) ; EP from RCDPEFA1 - Division/Station selection
 ; Input:   None
 ; Output:  RCVAUTD - Array of selected Divisions/Stations, passed by ref.
 ; Returns: 1       - All selected, 2 - specific Divisions/Stations, 0 - U or timeout
 N DTOUT,DUOUT,VAUTD,Y
 D DIVISION^VAUTOMA ;  RETURNS Y=-1 (quit), VAUTD=1 (for all),VAUTD=0 (selected divisions in VAUTD) - IA 664
 Q:Y<0 0
 Q:VAUTD=1 1        ; All Divisions
 S Y="" F  S Y=$O(VAUTD(Y)) Q:'Y  D  ;
 . I $G(^DG(40.8,"ADV",Y)) S RCVAUTD(^DG(40.8,"ADV",Y))=VAUTD(Y)
 Q 2
 ;
ASKPAT() ; EP from RCDPEFA1 - Filter by Patient or 'ALL'
 ; Input:   None
 ; Returns: P       - Sort by Claim
 ;          A       - Sort by Patient Name
 ;          0       - User entered '^' or timed out
 N C1,C2,C3,DIR,DIROUT,DIRUT,DTOUT,DUOUT,XX
 S DIR(0)="SA^P:PATIENT;A:ALL;"
 S DIR("A")="Select (P)ATIENT or (A)LL?: "
 S DIR("?",1)="Enter 'P' to filter by Patient or 'A' to show all 1st Party"
 S DIR("?")="Auto-Decreases."
 S DIR("B")="ALL"
 D ^DIR
 Q:$D(DTOUT)!$D(DUOUT) 0
 S C1=Y,C2="",C3=""                 ; PRCA*4.5*349 add C3
 S:C1="P" C2=$$ASKPAT2              ; Ask for Patient IEN
 Q:C2=0 0                           ; No patient selected
 Q:C2=0 C1_"|"
 ; PRCA*4.5*349 Begin Modified Block
 S:+C2 C3=$$ASKPAT3
 Q:C3=-1 0
 Q C1_"|"_C2_"|"_C3
 ; PRCA*4.5*349 End Modified Block
 ;
ASKPAT2() ; Select the Patient to filter by
 ; Input:   None
 ; Returns: IEN     - Select Patient IEN file #2
 ;          0       - User entered '^' or timed out or no patient selected
 N DIC,DIROUT,DIRUT,DTOUT,DUOUT
 S DIC="^DPT(",DIC(0)="AEINMQ"
 S DIC("A")="Select Patient: "
 D ^DIC
 Q:$D(DTOUT)!$D(DUOUT) 0
 Q:Y<1 0
 Q:Y="" 0
 Q $P(Y,U,1)
 ;
 ; prca*4.5*349 - Subroutine added
ASKPAT3() ; Ask whether to display comment details for single patient search
 ; Input:   None
 ; Returns: Y = Yes, display comment details
 ;          N = No, do not display comment details
 ;         -1 = User entered '^' or timed out
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,Y
 S DIR(0)="YA"
 S DIR("A")="Display Comment Detail? (Y/N)// "
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q -1
 Q Y
 ;
ASKSORT() ; EP from RCDPEFA1 - Select the sort criteria
 ; Input:   None
 ; Returns: C       - Sort by Claim
 ;          N       - Sort by Patient Name
 ;          0       - User entered '^' or timed out
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,XX
 S DIR(0)="SA^C:CLAIM;N:PATIENT NAME;"
 S DIR("A")="Sort by (C)LAIM # or PATIENT (N)AME?: "
 S DIR("?",1)="Enter 'C' to sort by Claim Number or 'N' to sort"
 S DIR("?")="by Patient Name."
 S DIR("B")="CLAIM"
 D ^DIR
 Q:$D(DTOUT)!$D(DUOUT) 0
 Q Y
 ;
SORTORD(SORT) ; EP from RCDPEFA1 - Select the sort order
 ; Input:   SORT    - 'C' - Sort by Claim Number
 ;                    'N' - Sort by Patient Name
 ; Returns: F       - First to Last
 ;          L       - Last to First 
 ;          0       - User entered '^' or timed out
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,XX,YY
 S XX=" (F)IRST TO LAST or (L)AST TO FIRST?: "
 S YY=$S(SORT="C":"CLAIM",1:"PATIENT NAME")
 S DIR("A")="Sort "_YY_XX
 S DIR(0)="SA^F:FIRST TO LAST;L:LAST TO FIRST"
 S DIR("B")="FIRST TO LAST"
 D ^DIR
 Q:$D(DTOUT)!$D(DUOUT) 0
 Q Y
 ;
DTRNG() ; EP from RCDPEFA1 - Get the date range for the report
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
DISPTY() ; EP from RCDPEFA1 - Get display/output type
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
 ; PRCA*4.5*349 - Subroutine added
DETSUM() ; EP from RCDPEFA1 - Get detail/summary type
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,Y
 S DIR("A")="Display (S)UMMARY or (D)ETAIL Format?: "
 S DIR(0)="SA^S:SUMMARY;D:DETAIL"
 S DIR("B")="DETAIL"
 D ^DIR
 Q:$D(DTOUT)!$D(DUOUT) 0
 Q Y
 ;
DEVICE(IO) ; Select output device
 ; Input:   None
 ; Output:  IO      - Array of selected output info
 ; Returns: 0       - No device selected, 1 Otherwise
 N POP,%ZIS
 S %ZIS="QM"
 D ^%ZIS
 Q:POP 0
 Q 1
 ;
LMAN(DATA,INPUT,RCCMT,XX) ;EP from RCDPEFA1
 ; Format and save List Manager line
 ; Input:   DATA    - ERA line adjustment total
 ;          INPUT   - Input parameters in delimited list
 ;          RCCMT   - Array of free text comments for this decrease
 ;          XX      - List Counter for ^TMP("RCDPE_ADP",$J)
 ;
 N CNT,Y
 S Y=$P(DATA,U,3)                       ; Patient Name/SSN last 4
 S $E(Y,33)=$J($P(DATA,U,4),6,2)        ; COPAY Amount
 S $E(Y,41)=$J($P(DATA,U,5),6,2)        ; Auto-Decrease Amount
 S $E(Y,49)=$E($P(DATA,U,6),1,10)       ; Copay Claim #
 S $E(Y,61)=$E($P(DATA,U,7),1,10)       ; 3rd Party Claim #
 S $E(Y,73)=$P(DATA,U,8)                ; Auto-Decrease Date
 S ^TMP("RCDPE_ADP",$J,XX)=Y,XX=XX+1
 I $P($P(INPUTS,U,7),"|",3)=1 D         ; Show comment detail?
 . S CNT="" F  S CNT=$O(RCCMT(CNT)) Q:CNT=""  D  ;
 . . S Y=$S(CNT=1:"      Comment:  ",1:"           ")
 . . S Y=Y_RCCMT(CNT)
 . . S ^TMP("RCDPE_ADP",$J,XX)=Y,XX=XX+1
 Q
 ;
TOTALD(LMAN,HDRINFO,PAGE,STOP,DAY,DTOTAL,LCNT) ; Totals for a single day
 ; Input:   LMAN    - 1 if output to List Template, 0 otherwise
 ;          HDRINFO - Array of header information
 ;          PAGE    - Page Number
 ;          DAY     - FileMan date to display totals for
 ;          DTOTAL  - Array of totals by day
 ;          LCNT    - Current line count (only passedif LMAN=1)
 ; Output:  PAGE    - Updated Page Number (if a new header is displayed)
 ;          STOP    - 1 if user indiacted to stop
 ;          LCNT    - Updated line count (only passedif LMAN=1)
 N DAMT,DCNT,LN1,LN2,LN3,DCOP
 S DCNT=$P(DTOTAL(DAY),U,1)
 S DAMT=$P(DTOTAL(DAY),U,2)
 S DCOP=$P(DTOTAL(DAY),U,3) ; PRCA*4.5*349
 S LN1="**Totals for Date: "_$$FMTE^XLFDT(DAY,"2Z")
 S $E(LN1,35)="    # of Decrease Adjustments: "_DCNT
 S LN2="",$E(LN2,28)="Total Amount of Decrease Adjustments: $"_$J(DAMT,3,2)
 S LN3="",$E(LN3,22)="% of Dollars Auto-Decreased of Total Copay: "_$$PCENT^RCDPEFA1(DAMT,DCOP)_"%" ; PRCA*4.5*349
 ;
 I LMAN D  Q
 . S ^TMP("RCDPE_ADP",$J,LCNT)="",LCNT=LCNT+1
 . S ^TMP("RCDPE_ADP",$J,LCNT)=LN1,LCNT=LCNT+1
 . S ^TMP("RCDPE_ADP",$J,LCNT)=LN2,LCNT=LCNT+1
 . S ^TMP("RCDPE_ADP",$J,LCNT)=LN3,LCNT=LCNT+1 ; PRCA*4.5*349
 . S ^TMP("RCDPE_ADP",$J,LCNT)="",LCNT=LCNT+1
 ;
 I $Y>(IOSL-7) D
 . D ASK^RCDPEADP(.STOP,0)
 . Q:STOP
 . D HDR^RCDPEFA1(EXCEL,.HDRINFO,.PAGE)
 Q:STOP
 W !!,LN1
 W !,LN2
 W !,LN3 ; PRCA*4.5*349
 Q
 ;
TOTALG(LMAN,HDRINFO,PAGE,GTOTAL,STOP,LCNT) ; Overall report total
 ; Input:   LMAN    - 1 if output to Listman, 0 otherwise
 ;          HDRINFO - Array of header info
 ;          PAGE    - Current Page Number
 ;          GTOTAL  - Grand Totals for report
 ;          LCNT    - Current line count (only passedif LMAN=1)
 ; Output:  PAGE    - Updated Page Number (if new header is displayed)
 ;          LCNT    - Updated line count (only passedif LMAN=1)
 N LN1,LN2,LN3,GAMT,GCOP
 S GAMT=+$P(GTOTAL,U,2),GCOP=+$P(GTOTAL,U,3) ; PRCA*4.5*349
 S LN1="**** Totals for Date Range:           # of Decrease Adjustments: "_+$P(GTOTAL,U,1)
 S LN2="",$E(LN2,28)="Total Amount of Decrease Adjustments: $"_$J((+$P(GTOTAL,U,2)),3,2)
 S LN3="",$E(LN3,22)="% of Dollars Auto-Decreased of Total Copay: "_$$PCENT^RCDPEFA1(GAMT,GCOP)_"%" ; PRCA*4.5*349
 ;
 I LMAN D  Q
 . S ^TMP("RCDPE_ADP",$J,LCNT)="",LCNT=LCNT+1
 . S ^TMP("RCDPE_ADP",$J,LCNT)=LN1,LCNT=LCNT+1
 . S ^TMP("RCDPE_ADP",$J,LCNT)=LN2,LCNT=LCNT+1
 . S ^TMP("RCDPE_ADP",$J,LCNT)=LN3,LCNT=LCNT+1 ; PRCA*4.5*349
 ;
 I $Y>(IOSL-6) D
 . D ASK^RCDPEADP(.STOP,0)
 . Q:STOP
 . D HDR^RCDPEFA1(EXCEL,.HDRINFO,.PAGE)
 Q:STOP
 W !!,"**** Totals for Date Range:           # of Decrease Adjustments: "_+$P(GTOTAL,U,1)
 S Y="",$E(Y,28)="Total Amount of Decrease Adjustments: $"_$J((+$P(GTOTAL,U,2)),3,2)
 W !,Y ; PRCA*4.5*349
 S Y="",$E(Y,22)="% of Dollars Auto-Decreased of Total Copay: "_$$PCENT^RCDPEFA1(GAMT,GCOP)_"%" ; PRCA*4.5*349
 W !,Y,!
 Q

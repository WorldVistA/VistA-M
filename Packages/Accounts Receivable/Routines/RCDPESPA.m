RCDPESPA ;OICO/hrubovcak - ePayment Lockbox Parameter Audit Report ;29 Jan 2019 18:00:14
 ;;4.5;Accounts Receivable;**332,345,349**;Oct 11, 2018;Build 44
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
AUDPARM ;EP from RCDPESP2
 ; EDI Lockbox Parameters Audit Report [RCDPE PARAMETER AUDIT REPORT]
 ; Report logic moved from RCDPESP2, 11 October 2018
 ; Report displays the RCDPE PARAMETER AUDIT file (#344.7)
 ; and changes to the RCDPE PARAMETER file (#344.61)
 ;
 ; ^TMP($T(+0)_"-AUD",$J) - storage for LIST^DIC
 ; ^TMP($J,"RCLABEL") - field labels from $$GET1^DID
 ; RCDIERR - Errors from LIST^DIC
 ; RCDIGET - ^TMP storage for LIST^DIC A1^A2^...^An Where:
 ;           A1 - Field of the parameter that was changed
 ;           A2 - Timestamp when the changed occurred (internal)
 ;           A3 - Old value of the parameter
 ;           A4 - New value of the parameter
 ;           A5 - User who made the change
 ;           A6 - File of the changed parameter
 ;           A7 - IEN of the changed value
 ; RCFLDS - Fields for LIST^DIC
 ; RCPARAM - Changed parameter
 ; RCPARAM("dt&tm") - Date and time parameter changed
 ; RCPARAM("file") - File number
 ; RCPARAM("fld") - Field number
 ; RCPARAM("newVal") - New parameter value
 ; RCPARAM("oldVal")  - Old parameter value
 ; RCPARAM("usr") - User who changed parameter
 ; RCRPRT("begDate") - Report start date
 ; RCRPRT("endDate") - Report end date
 ; RCRPRT("eXcel") - Flag, output to Excel?
 ; RCRPRT("hdrDate") - Date/time report was run
 ; RCRPRT("hdrPg#") - Page counter
 ; RCRPRT("hdrTyp")  - Type to display in header
 ; RCRPRT("pgLns") - Line count for page (or screen)
 ; RCRPRT("typRprt") - Type of report (Medical, Pharmacy, or Both)
 ; RCRPRT("cntr") - Count of records output
 ; RCSCR - Screening logic for LIST^DIC
 ; RCSTOP - Flag, stop displaying report
 ; RCTMP - One line from LIST^DIC
 ; 
 N %ZIS,POP,RCDIERR,RCDIGET,RCFLDS,RCIEN,RCPARAM,RCRPRT,RCSCR,RCSTOP,RCTMP,X,XX,Y
 W !!,"EDI Lockbox Parameters Audit Report",!
 ;
 ; Set up FileMan storage location
 S RCDIGET=$NA(^TMP($T(+0)_"-AUD",$J))
 K @RCDIGET,^TMP($J,"RCLABEL")
 ;
 ; Initialize to zero
 S (RCSTOP,RCRPRT("hdrPg#"),RCRPRT("eXcel"),RCRPRT("cntr"),RCRPRT("pgLns"))=0
 ; Retrieve report type (Medical, Pharmacy, or All)
 S RCRPRT("typRprt")=$$RTYPE("A") ; PRCA*4.5*349
 Q:RCRPRT("typRprt")=-1  ; User '^' or timed out
 ;
 ; Type for header, PRCA*4.5*345
 S XX=RCRPRT("typRprt")             ; PRCA*4.5*349 - Added line
 S RCRPRT("hdrTyp")=$S(XX="M":"Medical",XX="P":"Pharmacy",XX="T":"TRICARE",1:"All")
 S Y("dtRange")=$$DTRNG  ; date range for report
 Q:Y("dtRange")=0  ; No date range selected
 ;
 S RCRPRT("begDate")=$P(Y("dtRange"),U,2)
 S RCRPRT("endDate")=$P(Y("dtRange"),U,3)
 K Y
 S RCRPRT("eXcel")=$$DISPTY^RCDPEM3  ; Export to excel?
 Q:+RCRPRT("eXcel")=-1  ; User '^' or timed out
 I RCRPRT("eXcel") D INFO^RCDPEM6  ; Display capture information for Excel
 S %ZIS="M"
 D ^%ZIS  ; Select output device
 Q:POP
 U IO
 ;
 S RCRPRT("hdrDate")=$$FMTE^XLFDT($$NOW^XLFDT,"5S")
 S RCRPRT("dtRange")=$$FMTE^XLFDT(RCRPRT("begDate"),"5D")_" - "_$$FMTE^XLFDT(RCRPRT("endDate"),"5D")
 S RCRPRT("endDate")=RCRPRT("endDate")+.5
 S RCSCR="I ($P(^(0),U)'<"_RCRPRT("begDate")_")&($P(^(0),U)'>"_RCRPRT("endDate")_")"
 S RCFLDS="@;.04;.01I;.07;.06;.03;.05I;.02"
 D LIST^DIC(344.7,,RCFLDS,"P",,,,,RCSCR,,RCDIGET,"RCDIERR")
 I $D(RCDIERR) D  Q
 . W !!,"FileMan error when collecting report data."
 . D ASK^RCDPEARL
 ;
 ; No changes found for date range
 I '$D(@RCDIGET@("DILIST",1)) D RPTEND Q
 ;
 ; PRCA*4.5*349 - Next 3 lines, get Auto-Decrease paid parameters
 S RCRPRT("medAuto")=$$GET1^DIQ(344.61,"1,",.03,"I") ; (#.03) AUTO-DECREASE MED ENABLED
 S RCRPRT("rxAuto")=$$GET1^DIQ(344.61,"1,",1.02,"I") ; (#1.02) AUTO-DECREASE RX ENABLED
 S RCRPRT("triAuto")=$$GET1^DIQ(344.61,"1,",1.06,"I") ; (#.03) AUTO-DECREASE TRI ENABLED
 ; Loop though changes from #344.7
 S RCIEN=0  F  S RCIEN=$O(@RCDIGET@("DILIST",RCIEN)) Q:RCSTOP!'RCIEN  D
 . I 'RCRPRT("hdrPg#") D  ;
 . . D HDRLPR(.RCRPRT,.RCSTOP)
 . . S RCRPRT("pgLns")=9  ; page header
 . Q:RCSTOP
 . K RCPARAM
 . S RCTMP=$P(@RCDIGET@("DILIST",RCIEN,0),U,2,8)
 . S RCPARAM("file")=$P(RCTMP,U,6)
 . Q:RCPARAM("file")=344.6  ; Excluded payers reported elsewhere
 . S RCPARAM("fld")=$P(RCTMP,U,1)  ; PRCA*4.5*326
 . ; Store Parameter labels in ^TMP to avoid redundant FileMan calls
 . I '$D(^TMP($J,"RCLABEL",RCPARAM("file"),RCPARAM("fld"))) D
 . . S X=$$GET1^DID(RCPARAM("file"),RCPARAM("fld"),,"LABEL")
 . . S ^TMP($J,"RCLABEL",RCPARAM("file"),RCPARAM("fld"))=X
 . ; if not both types, verify field should be printed
 . S RCPARAM=^TMP($J,"RCLABEL",RCPARAM("file"),RCPARAM("fld"))
 . I '(RCRPRT("typRprt")="A") Q:'$$TYPMTCH(.RCRPRT,.RCPARAM)  ; PRCA*4.5*349 change "B" tp "A"
 . S RCRPRT("cntr")=RCRPRT("cntr")+1  ; Count records listed
 . ; next 2 lines PRCA*4.5*326
 . I RCPARAM("file")=344.61,RCPARAM("fld")=.11 S RCPARAM="AUTO-DECREASE MED NOPAY ENABLED"
 . I RCPARAM("file")=344.61,RCPARAM("fld")=.12 S RCPARAM="AUTO-DECREASE MED DAYS (NO-PAY)"
 . S X=$P(RCTMP,U,2)  ; Timestamp
 . S RCPARAM("dt&tm")=$S(RCRPRT("eXcel"):$TR($$FMTE^XLFDT(X),"@"," "),1:$$FMTE^XLFDT(X,"2SZ"))
 . S RCPARAM("usr")=$P(RCTMP,U,5)
 . S RCPARAM("oldVal")=$P(RCTMP,U,3)
 . S RCPARAM("newVal")=$P(RCTMP,U,4)
 . I RCPARAM("file")=344.62 D  ; file 344.62, format CARC code
 . . S Y="" I (RCPARAM("fld")>.01)&(RCPARAM("fld")<2) S Y="MED "
 . . I RCPARAM["PHARM",(RCPARAM("fld")>2)&(RCPARAM("fld")<3) D
 . . . Q:$E(RCPARAM,1,5)="PHARM"
 . . . N F,J S F=$F(RCPARAM,"PHARM "),J=$E(RCPARAM,1,F-7)_$E(RCPARAM,F,$L(RCPARAM))
 . . . S RCPARAM("oldParam")=RCPARAM,RCPARAM=J,Y="PHARM "
 . . S X=" ("_$S($P(RCTMP,U,7)'="":$P($G(^RCY(344.62,$P(RCTMP,U,7),0)),U),1:"ERR")_")"  ; CARC code in parentheses
 . . S RCPARAM=Y_RCPARAM_X
 . ; format Boolean values, only if non-null
 . I RCPARAM("file")=342 D:"^7.05^7.06^7.07^7.08^7.09^"[(U_RCPARAM("fld")_U) YESNO(.RCPARAM,RCTMP)
 . I RCPARAM("file")=344.61 D:"^.02^.03^.11^1.01^1.02^"[(U_RCPARAM("fld")_U) YESNO(.RCPARAM,RCTMP)
 . ; PRCA*4.5*349 - Next line add 3.01 and 3.07 for TRICARE
 . I RCPARAM("file")=344.62 D:"^.02^.08^2.01^3.01^3.07^"[(U_RCPARAM("fld")_U) YESNO(.RCPARAM,RCTMP)
 . ;
 . F Y="oldVal","newVal" S:'$L(RCPARAM(Y)) RCPARAM(Y)="-"  ; if null set to hyphen
 . I RCRPRT("eXcel") D  Q  ; no formatting needed
 . . W !,RCPARAM_U_RCPARAM("dt&tm")_U_RCPARAM("oldVal")_U_RCPARAM("newVal")_U_RCPARAM("usr")
 . ;
 . S Y=$$PAD(RCPARAM,38)_$$PAD(RCPARAM("dt&tm"),19)_$$PAD(RCPARAM("oldVal"),5)_$$PAD(RCPARAM("newVal"),5)_RCPARAM("usr")
 . W !,$E(Y,1,IOM) S RCRPRT("pgLns")=RCRPRT("pgLns")+1
 . I '(RCRPRT("pgLns")<(IOSL-2)) D HDRLPR(.RCRPRT,.RCSTOP) Q:RCSTOP  S RCRPRT("pgLns")=9
 ;
RPTEND ; end of report
 I 'RCSTOP,'RCRPRT("cntr") D
 . D HDRLPR(.RCRPRT,.RCSTOP)
 . W !," * No PARAMETER AUDIT entries to report. *",!
 ;
 I 'RCSTOP W !!,$$ENDORPRT^RCDPEARL,!
 U IO(0) D ^%ZISC
 I 'RCSTOP,'$G(ZTSK),($E(IOST,1,2)="C-") D  ; Must have user
 . N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 . S DIR("A")="Press enter to continue: "
 . S DIR(0)="EA" D ^DIR
 ;
 K @RCDIGET,^TMP($J,"RCLABEL")              ; Clean up
 Q
 ;
HDRLPR(RCRPRT,RCSTOP) ; Report header Lockbox Parameter Report
 ; Input:   RCRPRT("eXcel")     - If true output for Excel
 ;          RCRPRT("hdrPg#")    - Current Page count
 ;          RCSTOP              - Report exit flag
 ;          RCRPRT("dtRange")   - Selected Date Range
 ;          RCRPRT("typRprt")   - Type of report to run
 ; Output:  RCRPRT("hdrPg#")    - Updated Page count
 I RCRPRT("eXcel") D  Q                     ; Excel header for PARAMETER AUDITS
 . Q:RCRPRT("hdrPg#")
 . W !,"PARAMETER^DATE/TIME EDITED^OLD VALUE^NEW VALUE^USER"
 . S RCRPRT("hdrPg#")=1                     ; only print once
 ;
 I 'RCRPRT("eXcel") D
 . I RCRPRT("hdrPg#") D ASK^RCDPEARL(.RCSTOP) Q:RCSTOP
 . W @IOF
 . S RCRPRT("hdrPg#")=RCRPRT("hdrPg#")+1
 . W $$CNTR("EDI Lockbox Parameter Audit Report"),?IOM-8,"Page: "_RCRPRT("hdrPg#")
 . W !,$$CNTR("RUN DATE: "_RCRPRT("hdrDate"))
 . W !,$$CNTR("DATE RANGE: "_RCRPRT("dtRange"))
 . W !,$$CNTR("REPORT TYPE: "_RCRPRT("hdrTyp"))
 . W !!,"LOCKBOX PARAMETER UPDATES"
 . W !,"--------------------------                                Values"
 . W !,"Parameter                             Date/Time Edited   Old  New    User"
 . W !,$TR($J("",IOM-1)," ","=")  ; row of equal signs
 Q
 ;
GETPAYER() ; GET THE PAYER NAME + PAYER ID
 N RCIEN,RCPAYR
 S RCIEN=$P(RCTMP,U,6)
 I '$D(^RCY(344.6,RCIEN)) Q ""
 S RCPAYR=$$GET1^DIQ(344.6,RCIEN_",",.01)_" "_$$GET1^DIQ(344.6,RCIEN_",",.02)
 Q RCPAYR
 ;
 ;
CNTR(TXT) ; center TXT
 Q $J("",IOM-$L(TXT)\2)_TXT
 ;
DTRNG() ; function, returns date range for the report
 N RCEND,RCSTART
 D DATES(.RCSTART,.RCEND)
 Q:RCSTART=-1 0
 Q:RCSTART "1^"_RCSTART_"^"_RCEND
 Q:'RCSTART "0^^"
 Q 0
 ;
DATES(BDATE,EDATE) ; Get a date range, both values passed by ref.
 N DIR,DTOUT,DUOUT,X,Y
 S (BDATE,EDATE)=0
 S DIR("?")="Enter the earliest AUDIT DATE to include on the report"
 S DIR(0)="DAO^:"_DT_":APE",DIR("A")="Report start date: " D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S BDATE=-1 Q
 S BDATE=Y K DIR,X,Y
 S DIR("?")="Enter the latest AUDIT DATE to include on the report"
 S DIR(0)="DAO^"_BDATE_":"_DT_":APE",DIR("A")="Report end date: ",DIR("B")=$$FMTE^XLFDT(DT)
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S BDATE=-1 Q
 S EDATE=Y
 Q
 ;
RTYPE(DEF) ; EP from RCDPESP2, RCDPESP1
 ; Type of information to display
 ; Input:   DEF - default value
 ; Returns:
 ; ; *future build*, add Tricare, change 'Both' to 'All'
 ; M - Medical, P - Pharmacy, T - Tricare, A - All, -1 - ^ or timed out
 N DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR("?")="Enter the type of information to display on the report."
 S DIR(0)="SA^M:Medical;P:Pharmacy;T:TRICARE;A:All"         ; PRCA*4.5*349
 S DIR("A")="(M)edical, (P)harmacy, (T)RICARE or (A)ll: "   ; PRCA*4.5*349
 S DIR("B")=$S($G(DEF)'="":DEF,1:"All")                     ; PRCA*4.5*349
 D ^DIR
 K DIR
 I $D(DTOUT)!$D(DUOUT) Q -1
 S:Y="" Y="A"
 Q $E(Y)
 ; 
TYPMTCH(RCRPRT,RCPARAM) ; function, print changed parameter?
 ; Input passed by ref: 
 ; RCRPRT("typRprt") - Report filter
 ; RCPARAM - values for the changed parameter
 ; Returns: 1 if valid to print, 0 otherwise
 N OK2PRNT S OK2PRNT=0
 I RCRPRT("typRprt")="M" D  ; Medical Parameters
 . I RCPARAM["MED" S OK2PRNT=1 Q
 . I RCPARAM("file")=344.62,(RCPARAM("fld")>.01)&(RCPARAM("fld")<2) S OK2PRNT=1
 ;
 I RCRPRT("typRprt")="P" D  ; Pharmacy parameters
 . I (RCPARAM["RX")!(RCPARAM["PHARM") S OK2PRNT=1 Q
 . I RCPARAM("file")=344.62,(RCPARAM("fld")>2)&(RCPARAM("fld")<3) S OK2PRNT=1
 ;
 I RCRPRT("typRprt")="T",(RCPARAM["TRICARE") S OK2PRNT=1  ; PRCA*4.5*349 - TRICARE Parameters
 Q OK2PRNT
 ;
PAD(A,N) ; pad A with N spaces
 S A=A_" " ; always add 1 space
 Q:'($L(A)<N) A  ; no padding needed
 Q A_$J("",N-$L(A))
 ;
YESNO(RCPARAM,Y) ; Yes/No text, RCPARAM passed by ref., Y=RCTMP
 S:$L(RCPARAM("oldVal")) RCPARAM("oldVal")=$S($P(Y,U,3):"Yes",1:"No")
 S:$L(RCPARAM("newVal")) RCPARAM("newVal")=$S($P(Y,U,4):"Yes",1:"No")
 Q

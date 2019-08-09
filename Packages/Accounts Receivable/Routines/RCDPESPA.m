RCDPESPA ;OICO/hrub - ePayment Lockbox Parameter Audit Report ;12 Oct 2018 09:59:54
 ;;4.5;Accounts Receivable;*332**;Oct 11, 2018;Build 40
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
AUDPARM ; EDI Lockbox Parameters Audit Report [RCDPE PARAMETER AUDIT REPORT]
 ; report logic moved from RCDPESP2, 11 October 2018
 ; report is a listing of the RCDPE PARAMETER AUDIT file (#344.7)
 ; including changes to the RCDPE PARAMETER file (#344.61)
 ;
 ; ^TMP($T(+0)_"-AUD",$J) - storage for LIST^DIC output
 ; ^TMP($J,"RCLABEL") - field labels from $$GET1^DID
 ; RCDIERR - errors from LIST^DIC
 ; RCDIGET - ^TMP storage for LIST^DIC
 ; RCFLDS - fields for LIST^DIC
 ; RCPARAM - changed parameter
 ; RCPARAM("dt&tm")  - date and time parameter changed
 ; RCPARAM("file") - file number
 ; RCPARAM("fld") - field number
 ; RCPARAM("newVal") - new parameter value
 ; RCPARAM("oldVal") - old parameter value
 ; RCPARAM("usr") - user who changed parameter
 ; RCRPRT("begDate")  - report start date
 ; RCRPRT("endDate")  - report end date
 ; RCRPRT("eXcel") - flag, output to Excel?
 ; RCRPRT("hdrDate") - date/time report was run
 ; RCRPRT("hdrPg#")  - page counter
 ; RCRPRT("hdrTyp") - type to display in header
 ; RCRPRT("pgLns") - line count for page (or screen)
 ; RCRPRT("typRprt") - type of report (Medical, Pharmacy, Tricare of All)
 ; RCRPRT("cntr") - count of records output
 ; RCSCR  - screening logic for LIST^DIC
 ; RCSTOP - flag, stop displaying report
 ; RCTMP  - one line from LIST^DIC
 N %ZIS,POP,RCDIERR,RCDIGET,RCFLDS,RCIEN,RCPARAM,RCRPRT,RCSCR,RCSTOP,RCTMP,X,Y
 W !!,"EDI Lockbox Parameters Audit Report",!
 ; set up FileMan storage location
 S RCDIGET=$NA(^TMP($T(+0)_"-AUD",$J)) K @RCDIGET,^TMP($J,"RCLABEL")
 ; initialize to zero
 S (RCSTOP,RCRPRT("hdrPg#"),RCRPRT("eXcel"),RCRPRT("cntr"),RCRPRT("pgLns"))=0
 ; retrieve report type (Medical, Pharmacy, or Both)
 S RCRPRT("typRprt")=$$RTYPE("B")  ; default is Both
 Q:RCRPRT("typRprt")=-1
 ; type for header
 S RCRPRT("hdrTyp")=$S(RCRPRT("typRprt")="M":"Medical",RCRPRT("typRprt")="P":"Pharmacy",1:"Both Medical&Pharmacy")
 ;
 S Y("dtRange")=$$DTRNG() Q:Y("dtRange")=0
 ;
 S RCRPRT("begDate")=$P(Y("dtRange"),U,2),RCRPRT("endDate")=$P(Y("dtRange"),U,3) K Y
 S RCRPRT("eXcel")=$$DISPTY^RCDPEM3() Q:+RCRPRT("eXcel")=-1
 ; Display capture information for Excel
 I RCRPRT("eXcel") D INFO^RCDPEM6
 ;Select output device
 S %ZIS="M" D ^%ZIS Q:POP  U IO
 ;
 S RCRPRT("hdrDate")=$$FMTE^XLFDT($$NOW^XLFDT,"5S")
 S RCRPRT("dtRange")=$$FMTE^XLFDT(RCRPRT("begDate"),"5D")_" - "_$$FMTE^XLFDT(RCRPRT("endDate"),"5D")
 ;
 S RCRPRT("endDate")=RCRPRT("endDate")+.5
 S RCSCR="I ($P(^(0),U)'<"_RCRPRT("begDate")_")&($P(^(0),U)'>"_RCRPRT("endDate")_")"
 S RCFLDS="@;.04;.01I;.07;.06;.03;.05I;.02"
 D LIST^DIC(344.7,,RCFLDS,"P",,,,,RCSCR,,RCDIGET,"RCDIERR")
 I $D(RCDIERR) W !!,"FileMan error when collecting report data." D ASK^RCDPEARL() Q
 ;
 ; No changes found for date range
 I '$D(@RCDIGET@("DILIST",1)) G RPTEND
  ; Get Auto-Decrease parameters
 S RCRPRT("medAuto")=$P($G(^RCY(344.61,1,0)),U,3)  ;(#.03) AUTO-DECREASE MED ENABLED [3S]
 S RCRPRT("rxAuto")=$P($G(^RCY(344.61,1,1)),U,2)  ; (#1.02) AUTO-DECREASE RX ENABLED [2S]
 ; Loop though changes from #344.7
 S RCIEN=0 F  S RCIEN=$O(@RCDIGET@("DILIST",RCIEN)) Q:RCSTOP!'RCIEN  D
 . I 'RCRPRT("hdrPg#") D HDRLPR(.RCRPRT,.RCSTOP) S RCRPRT("pgLns")=9
 . Q:RCSTOP
 . K RCPARAM S RCTMP=$P(@RCDIGET@("DILIST",RCIEN,0),U,2,8)
 . S RCPARAM("file")=$P(RCTMP,U,6)
 . Q:RCPARAM("file")=344.6  ; Excluded payers reported elswhere
 . S RCPARAM("fld")=$P(RCTMP,U) ; PRCA*4.5*326
 . S RCPARAM("oldVal")=$P(RCTMP,U,3)
 . S RCPARAM("newVal")=$P(RCTMP,U,4)
 . ; store labels in ^TMP to avoid redundant FileMan calls
 . D:'$D(^TMP($J,"RCLABEL",RCPARAM("file"),RCPARAM("fld")))
 ..  S ^TMP($J,"RCLABEL",RCPARAM("file"),RCPARAM("fld"))=$$GET1^DID(RCPARAM("file"),RCPARAM("fld"),,"LABEL")
 . S RCPARAM=^TMP($J,"RCLABEL",RCPARAM("file"),RCPARAM("fld"))
 . Q:'$$TYPMTCH(.RCRPRT,RCPARAM)
 . S RCRPRT("cntr")=RCRPRT("cntr")+1  ; count records listed
 . I RCPARAM("file")=344.61,RCPARAM("fld")=.11 S RCPARAM="AUTO-DECREASE MED NOPAY ENABLED"  ; PRCA*4.5*326
 . I RCPARAM("file")=344.61,RCPARAM("fld")=.12 S RCPARAM="AUTO-DECREASE MED DAYS (NO-PAY)"  ; PRCA*4.5*326
 . S X=$P(RCTMP,U,2)  ; date&time
 . S RCPARAM("dt&tm")=$S(RCRPRT("eXcel"):$TR($$FMTE^XLFDT(X),"@"," "),1:$$FMTE^XLFDT(X,"2SZ"))
 . S RCPARAM("usr")=$P(RCTMP,U,5),RCPARAM("oldVal")=$P(RCTMP,U,3),RCPARAM("newVal")=$P(RCTMP,U,4)
 . ; Next line - added EDI claim auto-decrease no-pay parameter field .08 - PRCA*4.5*326
 . I (RCPARAM("fld")=.02)!(RCPARAM("fld")=1.01)!(RCPARAM("fld")=.08) D
 ..  I RCPARAM("file")=344.62 S RCPARAM=RCPARAM_" ("_$S($P(RCTMP,U,7)'="":$P($G(^RCY(RCPARAM("file"),$P(RCTMP,U,7),0)),U,1),1:"ERR")_")"
 ..  S RCPARAM("oldVal")=$S(+$P(RCTMP,U,3)=0:"No",+$P(RCTMP,U,3)=1:"Yes",1:"Err")
 ..  S RCPARAM("newVal")=$S(+$P(RCTMP,U,4)=0:"No",+$P(RCTMP,U,4)=1:"Yes",1:"Err")
 . ; Next line - added EDI claim auto-audit parameter fields - PRCA*4.5*321
 . I (RCPARAM("fld")=.03)!(RCPARAM("fld")=.11)!(RCPARAM("fld")=7.05)!(RCPARAM("fld")=7.06)!(RCPARAM("fld")=7.07)!(RCPARAM("fld")=7.08)!(RCPARAM("fld")=7.09) D
 ..  S RCPARAM("oldVal")=$S($P(RCTMP,U,3):"Yes",1:"No")
 ..  S RCPARAM("newVal")=$S($P(RCTMP,U,4):"Yes",1:"No")
 . ; Next line - added EDI claim auto-decrease no-pay parameter field .12 - PRCA*4.5*326
 . I (RCPARAM("file")=344.62)&((RCPARAM("fld")=.12)!(RCPARAM("fld")=.06)) D
 ..  S RCPARAM=RCPARAM_" ("_$S($P(RCTMP,U,7)'="":$P($G(^RCY(RCPARAM("file"),$P(RCTMP,U,7),0)),U,1),1:"ERR")_")"
 . ; if null set to hyphen
 . F X="oldVal","newVal" S:'$L(RCPARAM(X)) RCPARAM(X)="-"
 . I 'RCRPRT("eXcel") D
 ..  S Y=$$PAD(RCPARAM,33)_$$PAD(RCPARAM("dt&tm"),19)_$$PAD(RCPARAM("oldVal"),5)_$$PAD(RCPARAM("newVal"),5)_RCPARAM("usr")
 ..  W !,$E(Y,1,IOM) S RCRPRT("pgLns")=RCRPRT("pgLns")+1
 ..  I '(RCRPRT("pgLns")<(IOSL-2)) D HDRLPR(.RCRPRT,.RCSTOP) Q:RCSTOP  S RCRPRT("pgLns")=9
 . I RCRPRT("eXcel") W !,RCPARAM_U_RCPARAM("dt&tm")_U_RCPARAM("oldVal")_U_RCPARAM("newVal")_U_RCPARAM("usr")
 ;
RPTEND ; end of report
 I 'RCSTOP,'RCRPRT("cntr") D
 . D HDRLPR(.RCRPRT,.RCSTOP)
 . W !," * No PARAMETER AUDIT entries to report. *",!
 ;
 I 'RCSTOP W !!,$$ENDORPRT^RCDPEARL,!
 U IO(0) D ^%ZISC
 I 'RCSTOP,'$G(ZTSK),($E(IOST,1,2)="C-") D  ; must have user
 . N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 . S DIR("A")="Press enter to continue: "
 . S DIR(0)="EA" D ^DIR
 ;
 K @RCDIGET,^TMP($J,"RCLABEL")  ; clean up
 ;
 Q
 ;
HDRLPR(RCRPRT,RCSTOP) ; Report header Lockbox Parameter Report
 ;   RCRPRT("eXcel") - if true output for Excel
 ;   RCRPRT("hdrPg#") - page count, passed by ref.
 ;   RCSTOP  - report exit flag
 ;   RCRPRT("typRprt")  - Type of report to run
 ;
 I RCRPRT("eXcel") D  Q  ; Excel header for PARAMETER AUDITS
 . Q:RCRPRT("hdrPg#")
 . W !,"PARAMETER^DATE/TIME EDITED^OLD VALUE^NEW VALUE^USER"
 . S RCRPRT("hdrPg#")=1  ; only print once
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
 . W !,"--------------------------                           Values"
 . W !,"Parameter                        Date/Time Edited   Old  New  User"
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
RTYPE(DEF) ; type of information to display
 ; Input:   DEF - default value
 ; Returns:
 ; M - Medical, P - Pharmacy, B - Both, -1  - ^ or timed out
 N DA,DIR,DTOUT,DUOUT,X,Y,DIRUT,DIROUT
 S DIR("?")="Enter the type of information to display on the report."
 S DIR(0)="SA^M:Medical;P:Pharmacy;B:Both"
 S DIR("A")="(M)edical, (P)harmacy, B(oth): "
 S DIR("B")=$S($G(DEF)'="":DEF,1:"Both")
 D ^DIR
 K DIR
 I $D(DTOUT)!$D(DUOUT) Q -1
 S:Y="" Y="A"
 Q $E(Y)
 ; 
TYPMTCH(RCRPRT,RCPARAM) ; Boolean function, does value match report type?
 ; Return 1 if valid to print, else zero
 Q:RCRPRT("typRprt")="B" 1  ; both types
 Q:RCPARAM["TRIC" 1  ; Tricare change, on both reports
 ;
 Q:(RCRPRT("typRprt")="M")&(RCPARAM["MED") 1  ; Medical Parameters
 Q:(RCRPRT("typRprt")="P")&((RCPARAM["RX")!(RCPARAM["PHARM")) 1  ; Pharmacy parameters
 ; evaluate if auto-decrease on
 ; RCRPRT("medAuto") and RCRPRT("rxAuto") carried in symbol table
 Q:(RCRPRT("typRprt")="M")&($G(RCRPRT("medAuto")))&(RCPARAM["DECREASE") 1  ; Auto-decrease for med is on
 Q:(RCRPRT("typRprt")="P")&($G(RCRPRT("rxAuto")))&(RCPARAM["DECREASE") 1   ; Auto-decrease for pharmacy
 Q 0
 ;
PAD(A,N) ; pad A with N spaces
 S A=A_" " ; always add 1 space
 Q:'($L(A)<N) A  ; no padding needed
 Q A_$J("",N-$L(A))
 ;

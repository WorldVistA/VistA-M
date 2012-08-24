RCDPEM4 ;OIFO-BAYPINES/PJH - EPAYMENTS AUDIT REPORTS ;9/8/11 3:33pm
 ;;4.5;Accounts Receivable;**276,284**;Mar 20, 1995;Build 35
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EOB ; Main entry point for EOB Move/Copy Report
 N RTYPE
 S RTYPE="EOB"
 D EN1
 Q
 ;
POST ; Main entry point for ERA Posted with Paper EOB Report
 N RTYPE
 S RTYPE="ERA"
 D EN1
 Q
 ;
EN1 ;collect filter and device options
 N RCDTRNG,RCRANGE,RCDIV,RCSTA,RCDISP,RCPAGE,STANUM,STANAM,X,Y
 N %ZIS,ZTSK,ZTDESC,ZTSAVE,ZTQUEUED,ZTRTN,POP,RCPROG,VAUTD
 ;Initialize page and start point
 S (RCDTRNG,RCPAGE)=0,RCPROG="RCDPEM4"
 ;Select Date Range for Report
 S RCRANGE=$$DTRNG() Q:RCRANGE=0
 ;Select Filter/Sort by Division
 D STADIV Q:RCDIV=0
 ;Select Display Type
 S RCDISP=$$DISPTY() Q:RCDISP=-1
 ;Display capture information for Excel
 I RCDISP D INFO^RCDPEM6
 ;Select output device
 S %ZIS="QM" D ^%ZIS Q:POP
 ;Option to queue
 I 'RCDISP,$D(IO("Q")) D  Q
 .S ZTRTN="REPORT^RCDPEM4"
 .S ZTDESC="EDI LOCKBOX PAPER EOB AUDIT REPORT"
 .S ZTSAVE("RC*")="",ZTSAVE("RTYPE")="",ZTSAVE("VAUTD")=""
 .D ^%ZTLOAD
 .I $D(ZTSK) W !!,"Your task number "_ZTSK_" has been queued."
 .E  W !!,"Unable to queue this job."
 .K ZTSK,IO("Q") D HOME^%ZIS
 ;
 ;Compile and Print Report
 D REPORT
 Q
 ;
REPORT ;Compile and print report
 K ^TMP(RCPROG,$J)
 ;Scan ERA file for entries in date range
 I RTYPE="ERA" D COMPILE
 ;Scan EOB file for entries in date range
 I RTYPE="EOB" D COMPILE1
 ;Display Report
 D DISP
 ;Clear workfile
 K ^TMP(RCPROG,$J)
 Q
 ;
COMPILE ;Generate the ERA posted with paper EOB report ^TMP array
 N START,END,ERAIEN,STA,STNAM,STNUM
 ;Date Range
 S START=0,END="9999999",SUB=0
 S:$P(RCRANGE,U) START=$P(RCRANGE,U,2),END=$P(RCRANGE,U,3)
 ;Selected division or All
 ;Scan AFL index for ERA within date range
 F  S START=$O(^RCY(344.4,"AFL",START)) Q:'START  Q:(START\1)>END  D
 .S ERAIEN=""
 .F  S ERAIEN=$O(^RCY(344.4,"AFL",START,ERAIEN)) Q:'ERAIEN  D
 ..;Ignore if not posted with paper EOB
 ..Q:'$D(^RCY(344.4,ERAIEN,7))
 ..;Check division
 ..D ERASTA(ERAIEN,.STA,.STNUM,.STNAM)
 ..I RCDIV=2,'$D(VAUTD(STA)) Q
 ..;Save to workfile
 ..D SAVE(ERAIEN,STA,STNUM,STNAM)
 ;
 Q
 ;
SAVE(ERAIEN,STA,STNUM,STNAM) ;Put the data into the ^TMP global
 ; INPUTS: ERAIEN = ien of the ERA
 ;         STNUM= station IEN
 ; RETURNS  : Builds each entry in the ^TMP global
 ;
 N SUB,GLOB,CNT,USER,DATE,Y,DEPO,ERA,REC0,REC7,MATCH,POST
 S REC0=$G(^RCY(344.4,ERAIEN,0))
 S REC7=$G(^RCY(344.4,ERAIEN,7))
 ;User marked ERA as posted to paper EOB
 S USER=$P(REC7,U,2)
 S USER=$$NAME^XUSER(USER,"F")
 ;Date/Time ERA was marked posted 
 S DATE=$$FMTE^XLFDT($P(REC7,U),"2S")
 ;ERA number
 S ERA=$P(REC0,U)
 ;Deposit
 S DEPO=$P(REC0,U,8),DEPO=$$EXTERNAL^DILFD(344.4,.08,,DEPO)
 ;EFT Match Status
 S MATCH=$P(REC0,U,9),MATCH=$$EXTERNAL^DILFD(344.4,.09,,MATCH)
 ;Detail Post Status
 S POST=$P(REC0,U,14),POST=$$EXTERNAL^DILFD(344.4,.14,,POST)
 ;Update workfile
 S SUB=$S(RCDIV=2:"DIV",1:"ALL"),GLOB=$NA(^TMP(RCPROG,$J))
 ;sorting is done in EXCEL - else use STA as subscript
 S CNT=$G(@GLOB@(SUB))+1,@GLOB@(SUB)=CNT
 S @GLOB@(SUB,CNT)=STNAM_U_STNUM_U_DATE_U_USER_U_ERA_U_DEPO_U_MATCH_U_POST
 Q
 ;
COMPILE1 ;Generate the EOB Moved/Copy report ^TMP array
 N DTSUB,START,END,EOBIEN,IEN101,STA,STNAM,STNUM
 ;Date Range
 S START=0,END="9999999"
 S:$P(RCRANGE,U) START=$P(RCRANGE,U,2),END=$P(RCRANGE,U,3)
 ;Selected division or All
 ;Scan AEOB index for EOB within date range
 F  S START=$O(^IBM(361.1,"AEOB",START)) Q:'START  Q:(START\1)>END  D
 .S EOBIEN=""
 .F  S EOBIEN=$O(^IBM(361.1,"AEOB",START,EOBIEN)) Q:'EOBIEN  D
 ..;Ignore if not MOVED/COPIED
 ..S IEN101=$O(^IBM(361.1,"AEOB",START,EOBIEN,"")) Q:'IEN101
 ..;Check division
 ..D EOBSTA(EOBIEN,.STA,.STNUM,.STNAM)
 ..I RCDIV=2,'$D(VAUTD(STA)) Q
 ..;Save to workfile
 ..D SAVE1(EOBIEN,IEN101,STA,STNUM,STNAM)
 Q
 ;
 ;
SAVE1(EOBIEN,IEN101,STA,STNUM,STNAM) ;Put the data into the ^TMP global
 ; INPUTS: EOBIEN = ien of the EOB
 ;         STNUM= station ien
 ; RETURNS  : Builds each entry in the ^TMP global
 ;
 N GLOB,CNT,SUB
 N USER,DATE,Y,DEPO,REC101,JUST,ORIG,TRACE,ERA,PAYAMT,OTHER,NBILL,X,ACTION
 S REC101=$G(^IBM(361.1,EOBIEN,101,IEN101,0))
 ;User who did MOVE/COPY
 S USER=$P(REC101,U,2)
 S USER=$$NAME^XUSER(USER,"F")
 ;Date/Time ERA was marked posted 
 S DATE=$$FMTE^XLFDT($P(REC101,U),"2S")
 ;Justification comment
 S JUST=$P(REC101,U,3)
 ;Moved or Copied
 S ACTION=$S($P(REC101,U,5)="C":"COPIED",$P(REC101,U,5)="M":"MOVED",1:"")
 ;Original bill pointer
 S ORIG=$P(REC101,U,4)
 ;Ignore if original bill is null (this is EOB copied from)
 Q:'ORIG
 ;Get claim number from pointer
 S ORIG=$$EXTERNAL^DILFD(361.1,.01,,ORIG)
 S X=$O(^PRCA(430,"D",ORIG,""))
 I $G(X) S X=$P($G(^PRCA(430,X,0)),U) I X'="" S ORIG=$TR(X,"-","")
 ;New Bill (only displayed for a move)
 S NBILL=$$EXTERNAL^DILFD(361.1,.01,,$P($G(^IBM(361.1,EOBIEN,0)),U))
 ;Paid Amount
 S PAYAMT=$P($G(^IBM(361.1,EOBIEN,1)),U)
 ;Trace Number
 S TRACE=$P($G(^IBM(361.1,EOBIEN,0)),U,7),ERA=""
 ;ERA number
 S:TRACE]"" ERA=$O(^RCY(344.4,"D",TRACE,""))
 ;Other bill numbers
 S OTHER=$$OTHER(EOBIEN,IEN101)
 ;
 ;Update workfile
 S SUB=$S(RCDIV=2:"DIV",1:"ALL"),GLOB=$NA(^TMP(RCPROG,$J))
 ;sorting is done in EXCEL - else use STA as subscript
 S CNT=$G(@GLOB@(SUB))+1,@GLOB@(SUB)=CNT
 S @GLOB@(SUB,CNT)=STNAM_U_STNUM_U_DATE_U_USER_U_ORIG_U_NBILL_U_ERA
 S @GLOB@(SUB,CNT)=@GLOB@(SUB,CNT)_U_TRACE_U_PAYAMT_U_JUST_U_OTHER_U_ACTION
 Q
 ;
OTHER(EOBIEN,IEN101) ;Build list of bill numbers
 N SUB,NBILL,STR,FOUND
 S SUB=0,FOUND=0,STR=""
 F  S SUB=$O(^IBM(361.1,EOBIEN,101,IEN101,1,SUB)) Q:'SUB  D
 .S NBILL=$G(^IBM(361.1,EOBIEN,101,IEN101,1,SUB,0)) Q:'NBILL
 .S NBILL=$$EXTERNAL^DILFD(361.1,.01,,NBILL)
 .I FOUND S STR=STR_", "
 .S STR=STR_NBILL,FOUND=1
 S:'FOUND STR=STR_"NONE"
 Q STR
 ;
DISP ; Format the display for screen/printer or MS Excel
 N FILTER,IEN,RCSTOP,SUB
 ;
 ;Open device
 U IO
 ;
 ;Report by division or 'ALL'
 ;Format Division Filter
 S FILTER=$S(RTYPE="EOB":"ALL STATIONS/DIVISIONS",1:"ALL") I RCDIV=2 S FILTER=$$LINE(.VAUTD)
 S SUB="",RCSTOP=0
 F  S SUB=$O(^TMP(RCPROG,$J,SUB)) Q:SUB=""  D  Q:RCSTOP
 .;Display Header
 .D HDR(RCDISP,RTYPE,.VAUTD)
 .;
 .S IEN=""
 .F  S IEN=$O(^TMP(RCPROG,$J,SUB,IEN)) Q:'IEN  D  Q:RCSTOP
 ..I 'RCDISP D  Q:RCSTOP
 ...;ERA posted with paper EOB
 ...I RTYPE="ERA" D
 ....I $Y>(IOSL-3) D HDR(RCDISP,RTYPE,.VAUTD) Q:RCSTOP
 ....W !,$P(^TMP(RCPROG,$J,SUB,IEN),U,5) ;ERA#
 ....W ?11,$P(^TMP(RCPROG,$J,SUB,IEN),U,6) ;RECEIPT#
 ....W ?23,$P(^TMP(RCPROG,$J,SUB,IEN),U,3) ;DATE/TIME
 ....W ?41,$P(^TMP(RCPROG,$J,SUB,IEN),U,4) ;USER LASTNAME,FIRSTNAME
 ....W ?57,$P(^TMP(RCPROG,$J,SUB,IEN),U,7) ;MATCH STATUS
 ....W !,?61,$P(^TMP(RCPROG,$J,SUB,IEN),U,8) ;POST STATUS
 ...;EOB Moved/Copied
 ...I RTYPE="EOB" D
 ....I $Y>(IOSL-6) D HDR(RCDISP,RTYPE,.VAUTD) Q:RCSTOP
 ....W !,$P(^TMP(RCPROG,$J,SUB,IEN),U,5) ;ORIGINAL BILL
 ....W ?20,$P(^TMP(RCPROG,$J,SUB,IEN),U,8) ;TRACE
 ....W !?6,$P(^TMP(RCPROG,$J,SUB,IEN),U,7) ;ERA
 ....W ?15,$P(^TMP(RCPROG,$J,SUB,IEN),U,3) ;DATE/TIME
 ....W ?35,$P(^TMP(RCPROG,$J,SUB,IEN),U,12) ;MOVED/COPIED
 ....W ?50,$P(^TMP(RCPROG,$J,SUB,IEN),U,9) ;PAYMENT AMOUNT
 ....W ?61,$P(^TMP(RCPROG,$J,SUB,IEN),U,4) ; USER LASTNAME,FIRSTNAME
 ....W !,"New Bill: ",$P(^TMP(RCPROG,$J,SUB,IEN),U,6) ;NEW BILL
 ....W ?25,"Other Bill Number(s): "
 ....W $P(^TMP(RCPROG,$J,SUB,IEN),U,11) ;OTHER BILLS
 ....N JUST,DIWL,DIWR,DIWF,X
 ....K ^UTILITY($J,"W")
 ....S JUST=$P(^TMP(RCPROG,$J,SUB,IEN),U,10)
 ....W !,"Justification Comments:  "
 ....I $L(JUST)<54 W JUST,!
 ....E  D
 .....S X=JUST,DIWL=26,DIWR=78,DIWF="W"
 .....D ^DIWP,^DIWW
 ..I RCDISP D
 ...W !,^TMP(RCPROG,$J,SUB,IEN)
 .;
 .I 'RCSTOP W !,"******** END OF REPORT ********",!
 ;
 I '$D(^TMP(RCPROG,$J))&(RTYPE="EOB")&('RCDISP) D
 .D HDR(0,RTYPE,.VAUTD)
 .W !!!!,?26,"*** NO RECORDS TO PRINT ***"
 ;
 I '$D(^TMP(RCPROG,$J))&(RTYPE="ERA")&('RCDISP) D
 .D HDR(0,RTYPE,.VAUTD)
 .W !!!!,?26,"*** NO RECORDS TO PRINT ***"
 ;Close device
 I '$D(ZTQUEUED) D ^%ZISC
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
LINE(VAUTD) ;List selected stations
 N LINE,SUB
 S LINE="",SUB=""
 F  S SUB=$O(VAUTD(SUB)) Q:'SUB  D
 .S LINE=LINE_$G(VAUTD(SUB))_", "
 Q $E(LINE,1,$L(LINE)-2)
 ;
SELDIV(VAUTD,Z) ;Devisions are orginized as Z(1)="DIV1,DIV2,..., Z(2)="DIVN,DIVN+1,... etc.
 ; Input:
 ;   VAUTD (required/pass-by-ref) - Division(s) array; result of call to DIVISION^VAUTOMA
 ; Output:
 ;   Z (required/pass-by-ref) - reformatted array of divisions
 ;
 N SUB,CNT
 S CNT=1,Z(CNT)="DIVISIONS: "
 I $D(VAUTD)=1 D  Q
 . S Z(CNT)=Z(CNT)_"ALL"
 . S Z(CNT)=$J("",80-$L(Z(CNT))\2)_Z(CNT)
 I $D(VAUTD)>1,'VAUTD D
 . S SUB=VAUTD
 . F  S SUB=$O(VAUTD(SUB)) Q:'SUB  D
 . . I Z(CNT)="DIVISIONS: " S Z(CNT)=Z(CNT)_VAUTD(SUB) Q
 . . S Z(CNT)=Z(CNT)_$S(Z(CNT)]"":",",1:"")_VAUTD(SUB)
 . . I $L(Z(CNT))>50 D
 . . . S Z(CNT)=$J("",80-$L(Z(CNT))\2)_Z(CNT)
 . . . S CNT=CNT+1,Z(CNT)=""
 I Z(CNT)]"" D
 . S Z(CNT)=$J("",80-$L(Z(CNT))\2)_Z(CNT)
 I Z(CNT)="" K Z(CNT)
 Q
 ;
HDR(RCDISP,TYPE,VAUTD) ; Print the report header
 ; INPUTS: RCDISP - Display/print/Excel flag
 ;         TYPE - Report Type (EOB or ERA)
 N START,END,MSG,DATE,Y,%,DIV,SUB,Z0
 S START=$$FMTE^XLFDT($P(RCRANGE,U,2),2)
 S END=$$FMTE^XLFDT($P(RCRANGE,U,3),2)
 ;
 I 'RCDISP D
 .I RCPAGE D ASK(.RCSTOP,0) Q:RCSTOP
 .S RCPAGE=RCPAGE+1
 .D NOW^%DTC
 .S DATE=$$FMTE^XLFDT(%,"2S")
 .W @IOF
 .I TYPE="ERA" D
 ..S SUB=1
 ..S MSG(SUB)="ERAs Posted with Paper EOB - Audit Report",MSG(SUB)=$J("",80-$L(MSG(SUB))\2)_MSG(SUB)
 ..S MSG(SUB)=MSG(SUB)_"      Page: "_RCPAGE
 ..S SUB=SUB+1
 ..S MSG(SUB)="Run Date: "_DATE,MSG(SUB)=$J("",80-$L(MSG(SUB))\2)_MSG(SUB)
 ..D SELDIV(.VAUTD,.DIV)
 ..S DIV=0
 ..F  S DIV=$O(DIV(DIV)) Q:'DIV  D
 ...S SUB=SUB+1
 ...S MSG(SUB)=DIV(DIV)
 ..S SUB=SUB+1
 ..S MSG(SUB)="Date Range: "_START_" - "_END_" (DATE ERA UPDATED)",MSG(SUB)=$J("",80-$L(MSG(SUB))\2)_MSG(SUB)
 ..S SUB=SUB+1
 ..S MSG(SUB)=" ",SUB=SUB+1
 ..S MSG(SUB)="                       Date/Time         User Who        EFT Match Status"
 ..S SUB=SUB+1
 ..S MSG(SUB)="ERA #      Receipt #   ERA Updated       Updated             Detail Post Status"
 ..S SUB=SUB+1
 ..S MSG(SUB)="==============================================================================="
 .I TYPE="EOB" D
 ..S MSG(1)="                         EEOB Move/Copy - Audit Report "
 ..S MSG(1)=MSG(1)_"        Page: "_RCPAGE
 ..S MSG(2)="                        Run Date/Time: "_DATE
 ..S Z0=FILTER S:VAUTD=1 Z0="ALL" S Z0="DIVISIONS: "_Z0
 ..S MSG(3)=$S($L(Z0)<75:$J("",75-$L(Z0)\2),1:"")_Z0
 ..S MSG(4)="           Date Range: "_START_" - "_END_" (Date EEOB was Moved/Copied)"
 ..S MSG(5)=" "
 ..S MSG(6)="Orig Bill#          Trace #"
 ..S MSG(7)="                                                  Total Amt  User Who"
 ..S MSG(8)="     ERA #     Date/Time       Moved/Copied       Paid       Moved/Copied"
 ..S MSG(9)="=============================================================================="
 .D EN^DDIOL(.MSG)
 I RCDISP,TYPE="ERA" D
 .W !,"STATION^STATION NUMBER^DATE/TIME^USER^ERA^RECEIPT^MATCH STATUS^POSTED STATUS"
 I RCDISP,TYPE="EOB" D
 .W !,"STATION^STATION NUMBER^DATE/TIME^USER^ORIGINAL BILL^NEW BILL^ERA#^TRACE#^PAYMENT AMOUNT^JUSTIFICATION^OTHER BILLS^MOVED/COPIED"
 Q
 ;
ASK(STOP,MODE) ; Ask to continue
 ; If passed by reference ,RCSTOP is returned as 1 if print is aborted
 I $E(IOST,1,2)'["C-" Q
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S:MODE=1 DIR("A")="Enter RETURN to finish"
 S DIR(0)="E" D ^DIR
 I ($D(DIRUT))!($D(DUOUT)) S STOP=1
 Q
 ;
INFO ;Useful Info for Excel capture
 W !!!,?10
 W "Before continuing, please set up your terminal to capture the"
 W !,?10
 W "detail report data. On some terminals, this can  be  done  by"
 W !,?10
 W "clicking  on the 'Tools' menu above, then click  on  'Capture"
 w !,?10
 W "Incoming  Data' to save to  Desktop. This  report  may take a"
 W !,?10
 W "while to run."
 W !!,?10
 W "Note: To avoid  undesired  wrapping of the data  saved to the"
 W !,?10
 W "      file, please enter '0;256;999' at the 'DEVICE:' prompt."
 W !!,?10
 W "      Also, set the terminal display width to 256 characters."
 W !,?10
 W "      On some terminals, this can be done by  clicking on the"
 W !,?10
 W "      'Setup' menu above, then click on  'Display' to  change"
 W !,?10
 W "      width to 256 characters"
 W !!
 Q
 ;
DTRNG() ; Get the date range for the report
 N DIR,DUOUT,RNGFLG,X,Y,RCSTART,RCEND
 D DATES(.RCSTART,.RCEND)
 Q:RCSTART=-1 0
 Q:RCSTART "1^"_RCSTART_"^"_RCEND
 Q:'RCSTART "0^^"
 Q 0
 ;
DATES(BDATE,EDATE) ;Get a date range.
 S (BDATE,EDATE)=0
 S DIR("?")="ENTER THE EARLIEST DATE OF RECEIPT OF DEPOSIT TO INCLUDE ON THE REPORT"
 S DIR(0)="DAO^:"_DT_":APE",DIR("A")="START DATE: " D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S BDATE=-1 Q
 S BDATE=Y
 S DIR("?")="ENTER THE LATEST DATE OF RECEIPT OF DEPOSIT TO INCLUDE ON THE REPORT"
 S DIR("B")=Y(0)
 S DIR(0)="DAO^"_BDATE_":"_DT_":APE",DIR("A")="END DATE: " D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S BDATE=-1 Q
 S EDATE=Y
 Q
 ;
STADIV ;Division/Station Filter/Sort
 ;
 ;Sort selection
 N DIR,DUOUT,Y
 S RCDIV=0
 ;
 ;Division selection - IA 664
 ;RETURNS Y=-1 (quit), Y=0 (for all),Y=1 (selected divisions in VAUTD)
 D DIVISION^VAUTOMA Q:Y<0
 ;
 ;If ALL selected
 I Y=0 S RCDIV=1 Q
 ;If some DIVISIONS selected
 S RCDIV=2
 Q
 ;
DISPTY() ; Get display/output type
 N DIR,DUOUT,Y
 S DIR(0)="Y"
 S DIR("A")="Export the report to Microsoft Excel"
 S DIR("B")="NO"
 D ^DIR I $G(DUOUT) Q -1
 Q Y
 ;
ERASTA(ERAIEN,STA,STNUM,STNAM) ; Get the station for this ERA
 ;Allowed read on 399 via IA 3820
 N ERAEOB,ERABILL,STAIEN
 S (ERAEOB,ERABILL)=""
 S (STA,STNUM,STNAM)="UNKNOWN"
 D
 .S ERAEOB=$P(^RCY(344.4,ERAIEN,1,1,0),U,2) Q:'ERAEOB
 .S ERABILL=$P(^IBM(361.1,ERAEOB,0),U,1) Q:'ERABILL
 .S STAIEN=$P(^DGCR(399,ERABILL,0),U,22) Q:'STAIEN
 .S STA=STAIEN
 .S STNAM=$$EXTERNAL^DILFD(399,.22,,STA)
 .S STNUM=$P($G(^DG(40.8,STAIEN,0)),U,2) ;IA 417
 Q
 ;
EOBSTA(EOBIEN,STA,STNUM,STNAM) ; Get the station for this EOB
 ;Allowed read on 399 via IA 3820
 N BILL,STAIEN
 S (BILL)=""
 S (STA,STNUM,STNAM)="UNKNOWN"
 D
 .S BILL=$P(^IBM(361.1,EOBIEN,0),U,1) Q:'BILL
 .S STAIEN=$P($G(^DGCR(399,BILL,0)),U,22) Q:'STAIEN
 .S STA=STAIEN
 .S STNAM=$$EXTERNAL^DILFD(399,.22,,STA)
 .S STNUM=$P($G(^DG(40.8,STAIEN,0)),U,2) ;IA 417
 Q
 ;
DTPRB() ; Get the Start Date type
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y
 S DIR(0)="SBO^W:Date Removed from Worklist;R:Date ERA Received;B:Both Dates"
 S DIR("A")="Select Start Date"
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S Y=0
 Q Y

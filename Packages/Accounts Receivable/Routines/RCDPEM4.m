RCDPEM4 ;OIFO-BAYPINES/PJH - EPAYMENTS AUDIT REPORTS ;Nov 17, 2014@17:00:41
 ;;4.5;Accounts Receivable;**276,284,298**;Mar 20, 1995;Build 121
 ;Per VA Directive 6402, this routine should not be modified.
 ;
EOB ; EEOB Move/Copy/Rmove Audit Report [RCDPE EEOB MOVE/COPY/RMOVE RPT]
 N RCRTYP S RCRTYP="EOB"  ; record type
 D ASKUSR
 Q
 ;
POST ; ERAs Posted with Paper EOB Audit Report [RCDPE ERA W/PAPER EOB REPORT]
 N RCRTYP S RCRTYP="ERA"  ; record type
 D ASKUSR
 Q
 ;
ASKUSR ;collect filter and device options
 Q:$G(RCRTYP)=""  ; must have record type
 N %ZIS,POP,RCACT,RCDISPTY,RCDIV,RCDTRNG,RCHDR,RCLSTMGR,RCLNCNT,RCPGNUM,RCPROG,RCSTA,RCSTOP,RCTMPND,RCXCLUDE,VAUTD,X,Y
 ; RCACT - selected actions for EOB
 ; RCDISPTY - display type
 ; RCDIV - selected divs.
 ; RCDTRNG - date range for report
 ; RCHDR - header array
 ; RCLSTMGR - ListMan output flag
 ; RCPGNUM - report page count
 ; RCPROG - ^TMP storage node for entries
 ; RCSTA - station
 ; RCSTOP - flag to stop report
 ; RCTMPND - ListMan storage node
 ; RCXCLUDE("CHAMPVA") - boolean, exclude CHAMPVA
 ; RCXCLUDE("TRICARE") - boolean, exclude TriCare
 ;
 S RCPROG=$T(+0),RCLSTMGR="",RCACT="",(RCLNCNT,RCSTOP)=0,RCTMPND=""
 S (RCXCLUDE("CHAMPVA"),RCXCLUDE("TRICARE"))=0  ; default to false
 ;Select Date Range for Report
 S RCDTRNG=$$DTRNG() G:'RCDTRNG EXIT
 ;Select Filter for Action Type (Move,Copy,Remove or All)
 I RCRTYP="EOB" S RCACT=$$ACTION G:RCACT<0 EXIT
 ;Select Filter/Sort by Division
 D STADIV G:'RCDIV EXIT
 ; CHAMPVA exclusion filter
 S RCXCLUDE("CHAMPVA")=$$INCHMPVA^RCDPEARL  ; user is asked whether to include
 G:RCXCLUDE("CHAMPVA")<0 EXIT
 ; TRICARE exclusion filter
 S RCXCLUDE("TRICARE")=$$INTRICAR^RCDPEARL  ; user is asked whether to include
 G:RCXCLUDE("TRICARE")<0 EXIT
 ; Select Display Type , exit if indicated
 S RCDISPTY=$$DISPTY() G:RCDISPTY<0 EXIT
 ;Display capture information for Excel, set RCLSTMGR to prevent question
 I RCDISPTY D INFO^RCDPEM6 S RCLSTMGR="^"
 I RCLSTMGR="" S RCLSTMGR=$$ASKLM^RCDPEARL G:RCLSTMGR<0 EXIT
 I RCLSTMGR D  G EXIT
 .X "S RCTMPND=$T(+0)_U_$$HDR"_RCRTYP K ^TMP($J,RCTMPND)  ; ^TMP storage node, clean any residue
 .D RPRTCMPL
 .N H,L,HDR S L=0
 .X "S HDR(""TITLE"")=$$HDR"_RCRTYP
 .F H=1:1:7 I $D(RCHDR(H)) S L=H,HDR(H)=RCHDR(H)  ; take first 7 lines of report header
 .I $O(RCHDR(L)) D  ; any remaining header lines at top of report
 ..N N S N=0,H=L F  S H=$O(RCHDR(H)) Q:'H  S N=N+.001,^TMP($J,RCTMPND,N)=RCHDR(H)
 .; invoke ListMan
 .D LMRPT^RCDPEARL(.HDR,$NA(^TMP($J,RCTMPND))) ; generate ListMan display
 ;
 ;Select output device
 S %ZIS="QM" D ^%ZIS Q:POP
 ;Option to queue
 I 'RCDISPTY,$D(IO("Q")) D  Q
 .N ZTSK,ZTDESC,ZTSAVE,ZTQUEUED,ZTRTN
 .S ZTRTN="RPRTCMPL^RCDPEM4"
 .S ZTDESC="EDI LOCKBOX PAPER EOB AUDIT REPORT"
 .S ZTSAVE("RC*")="",ZTSAVE("VAUTD")=""
 .D ^%ZTLOAD
 .W !!,$S($G(ZTSK):"Task number "_ZTSK_" was queued.",1:"Unable to queue this task."),!
 .K ZTSK,IO("Q") D HOME^%ZIS
 ;
 ;Compile and Print Report
 D RPRTCMPL
 Q
 ;
RPRTCMPL ;Compile and print report
 K ^TMP(RCPROG,$J),^TMP($J,"RC TOTAL")
 ;Scan ERA file for entries in date range
 I RCRTYP="ERA" D CMPLERA
 ;Scan EOB file for entries in date range
 I RCRTYP="EOB" D CMPLEOB
 ;Display Report
 D DISP
 ;
EXIT ;
 ;Clear old data
 K ^TMP(RCPROG,$J),^TMP($J,"RC TOTAL")
 Q
 ;
CMPLERA ;Generate the ERA posted with paper EOB report ^TMP array
 ; ^RCY(344.4,0) = ELECTRONIC REMITTANCE ADVICE^344.4I^
 N START,END,ERAIEN,STA,STNAM,STNUM
 ;Date Range
 S START=0,END="9999999",SUB=0
 S:$P(RCDTRNG,U) START=$P(RCDTRNG,U,2),END=$P(RCDTRNG,U,3)
 ;Selected division or All
 ;Scan AFL index for ERA within date range
 F  S START=$O(^RCY(344.4,"AFL",START)) Q:'START  Q:START>END  D
 .S ERAIEN=""
 .F  S ERAIEN=$O(^RCY(344.4,"AFL",START,ERAIEN)) Q:'ERAIEN  D
 ..;Ignore if not posted with paper EOB
 ..Q:'$D(^RCY(344.4,ERAIEN,7))
 ..;Check division
 ..D ERASTA(ERAIEN,.STA,.STNUM,.STNAM)
 ..I RCDIV=2,'$D(VAUTD(STA)) Q
 ..; CHAMPVA check
 ..I $G(RCXCLUDE("CHAMPVA")),$$CLMCHMPV^RCDPEARL("344.4;"_ERAIEN) D  Q  ; count and quit if true
 ...N N S N=$G(^TMP($J,"RC TOTAL","CHAMPVA"))+1,^("CHAMPVA")=N  ; total can be listed
 ..;
 ..; TRICARE check
 ..I $G(RCXCLUDE("TRICARE")),$$CLMTRICR^RCDPEARL("344.4;"_ERAIEN) D  Q  ; count and quit if true
 ...N N S N=$G(^TMP($J,"RC TOTAL","TRICARE"))+1,^("TRICARE")=N  ; total can be listed
 ..;
 ..D SVERA^RCDPEM41(ERAIEN,STA,STNUM,STNAM)
 ;
 Q
 ;
CMPLEOB ;Generate the EOB Moved/Copy/Remove report ^TMP array
 N DTSUB,START,END,EOBIEN,IEN101,STA,STNAM,STNUM
 ;Date Range
 S START=$P(RCDTRNG,U,2),END=$P(RCDTRNG,U,3)
 ;Selected division or All
 ;Scan AEOB index for EOB within date range
 F  S START=$O(^IBM(361.1,"AEOB",START)) Q:'START  Q:(START\1)>END  D
 .S EOBIEN=""
 .F  S EOBIEN=$O(^IBM(361.1,"AEOB",START,EOBIEN)) Q:'EOBIEN  D
 ..; Ignore if not MOVED/COPIED
 ..S IEN101=$O(^IBM(361.1,"AEOB",START,EOBIEN,"")) Q:'IEN101
 ..; Check division
 ..D EOBSTA(EOBIEN,.STA,.STNUM,.STNAM)
 ..I RCDIV=2,'$D(VAUTD(STA)) Q
 ..; CHAMPVA check
 ..I $G(RCXCLUDE("CHAMPVA")),$$CLMCHMPV^RCDPEARL("361.1;"_EOBIEN) D  Q  ; count and quit if true
 ...N N S N=$G(^TMP($J,"RC TOTAL","CHAMPVA"))+1,^("CHAMPVA")=N  ; total can be listed
 ..; TRICARE check
 ..I $G(RCXCLUDE("TRICARE")),$$CLMTRICR^RCDPEARL("361.1;"_EOBIEN) D  Q  ; count and quit if true
 ...N N S N=$G(^TMP($J,"RC TOTAL","TRICARE"))+1,^("TRICARE")=N  ; total can be listed
 ..;
 ..;
 ..D SVEOB^RCDPEM41(EOBIEN,IEN101,STA,STNUM,STNAM)
 ;
 Q
 ;
DISP ; Format the display for screen/printer or MS Excel
 N DVFLTR,IEN,RCNTRY,SUB,Y
 ;Format Division Filter
 S DVFLTR=$S(RCRTYP="EOB":"ALL STATIONS/DIVISIONS",1:"ALL") I RCDIV=2 S DVFLTR=$$LINE(.VAUTD)
 D:'RCLSTMGR HDRBLD  ; Report header
 D:RCLSTMGR HDRLM  ; Listman header
 ; RCNTRY - entry from ^TMP(RCPROG,$J)
 ;
 U IO
 ;
 ; Display Header for first time
 D:'RCLSTMGR HDRLST^RCDPEARL(.RCSTOP,.RCHDR)
 ;Report by division or 'ALL'
 S SUB=0,RCSTOP=0
 F  S SUB=$O(^TMP(RCPROG,$J,SUB)) Q:SUB=""!RCSTOP  D
 .S IEN=0 F  S IEN=$O(^TMP(RCPROG,$J,SUB,IEN)) Q:'IEN!RCSTOP  S RCNTRY=^(IEN) D
 ..I RCDISPTY W !,RCNTRY Q  ; spreadsheet format
 ..I RCRTYP="ERA" D  ; ERA posted with paper EOB
 ...I 'RCLSTMGR,$Y>(IOSL-RCHDR(0)) D HDRLST^RCDPEARL(.RCSTOP,.RCHDR) Q:RCSTOP
 ...S Y=$$PAD^RCDPEARL($P(RCNTRY,U,5),11)  ; ERA#
 ...S Y=Y_$$PAD^RCDPEARL($P(RCNTRY,U,6),12) ;RECEIPT#
 ...S Y=Y_$$PAD^RCDPEARL($P(RCNTRY,U,3),18) ;DATE/TIME
 ...S Y=Y_$$PAD^RCDPEARL($P(RCNTRY,U,4),16) ;USER LASTNAME,FIRSTNAME
 ...S Y=Y_$P(RCNTRY,U,7) ;MATCH STATUS
 ...D SL^RCDPEARL(Y,.RCLNCNT,RCTMPND)
 ...D SL^RCDPEARL($J("",61)_$P(RCNTRY,U,8),.RCLNCNT,RCTMPND) ;POST STATUS
 ..;
 ..I RCRTYP="EOB" D  ; EOB Moved/Copied
 ...I 'RCLSTMGR,$Y>(IOSL-RCHDR(0)) D HDRLST^RCDPEARL(.RCSTOP,.RCHDR) Q:RCSTOP
 ...S Y=$$PAD^RCDPEARL($P(RCNTRY,U,5),20) ; ORIGINAL BILL
 ...S Y=Y_$P(RCNTRY,U,8) ; TRACE #
 ...D SL^RCDPEARL(Y,.RCLNCNT,RCTMPND)
 ...S Y=$$PAD^RCDPEARL($J("",6)_$P(RCNTRY,U,7),15) ;ERA
 ...S Y=Y_$$PAD^RCDPEARL($P(RCNTRY,U,3),20) ;DATE/TIME
 ...S Y=Y_$$PAD^RCDPEARL($P(RCNTRY,U,12),15) ;MOVED/COPIED/REMOVED
 ...S Y=Y_$$PAD^RCDPEARL("$"_$P(RCNTRY,U,9),11) ;PAYMENT AMOUNT
 ...S Y=Y_$P(RCNTRY,U,4) ; USER LASTNAME,FIRSTNAME
 ...D SL^RCDPEARL(Y,.RCLNCNT,RCTMPND)
 ...D:$P(RCNTRY,U,12)'="REMOVED"
 ....S Y=$$PAD^RCDPEARL("New Bill: "_$P(RCNTRY,U,6),25) ;NEW BILL
 ....S Y=Y_"Other Bill Number(s): "_$P(RCNTRY,U,11) ;OTHER BILLS
 ....D SL^RCDPEARL(Y,.RCLNCNT,RCTMPND)
 ...;
 ...D WP($P(RCNTRY,U,10))  ; Justification comments
 ...D SL^RCDPEARL("",.RCLNCNT,RCTMPND)  ; skip a line
 .;
 .; end of report
 .I 'RCSTOP D SL^RCDPEARL(" ",.RCLNCNT,RCTMPND),SL^RCDPEARL($$ENDORPRT^RCDPEARL,.RCLNCNT,RCTMPND)
 ;
 D:'$D(^TMP(RCPROG,$J))
 .D SL^RCDPEARL(" ",.RCLNCNT,RCTMPND)  ; skip line
 .D SL^RCDPEARL("     *** NO RECORDS TO PRINT ***",.RCLNCNT,RCTMPND)
 ;
 ;Close device
 I '$D(ZTQUEUED),'RCLSTMGR D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
LINE(VAUTD) ;List selected stations
 N LINE,SUB
 S LINE="",SUB=""
 F  S SUB=$O(VAUTD(SUB)) Q:'SUB  D
 .S LINE=LINE_$G(VAUTD(SUB))_", "
 Q $E(LINE,1,$L(LINE)-2)
 ;
SELDIV(VAUTD,Z) ;Devisions are organized as Z(1)="DIV1,DIV2,..., Z(2)="DIVN,DIVN+1,... etc.
 ; Input:
 ;   VAUTD (required/pass-by-ref) - Division(s) array; result of call to DIVISION^VAUTOMA
 ; Output:
 ;   Z (required/pass-by-ref) - reformatted array of divisions
 ;
 N SUB,CNT
 S CNT=1,Z(CNT)="DIVISIONS: "
 I $D(VAUTD)=1 D  Q
 . S Z(CNT)=Z(CNT)_"ALL"
 .S Z(CNT)=$J("",80-$L(Z(CNT))\2)_Z(CNT)
 I $D(VAUTD)>1,'VAUTD D
 .S SUB=VAUTD
 .F  S SUB=$O(VAUTD(SUB)) Q:'SUB  D
 ..I Z(CNT)="DIVISIONS: " S Z(CNT)=Z(CNT)_VAUTD(SUB) Q
 ..S Z(CNT)=Z(CNT)_$S(Z(CNT)]"":",",1:"")_VAUTD(SUB)
 ..I $L(Z(CNT))>50 S Z(CNT)=$J("",80-$L(Z(CNT))\2)_Z(CNT),CNT=CNT+1,Z(CNT)=""
 ;
 I Z(CNT)]"" S Z(CNT)=$J("",80-$L(Z(CNT))\2)_Z(CNT)
 I Z(CNT)="" K Z(CNT)
 Q
 ;
HDRBLD ; create the report header
 ; returns RCHDR, RCPGNUM, RCSTOP
 ;   RCHDR(0) = header text line count
 ;   RCHDR("XECUTE") = M code for page number
 ;   RCHDR("RUNDATE") = date/time report generated, external format
 ;   RCPGNUM - page counter
 ;   RCSTOP - flag to exit
 ; INPUT: 
 ;   RCDISPTY - Display/print/Excel flag
 ;   RCDTRNG - date range
 ;   RCRTYP - Report Type (EOB or ERA)
 ;   VAUTD
 K RCHDR S RCHDR("RUNDATE")=$$NOW^RCDPEARL,RCPGNUM=0,RCSTOP=0
 ;
 I RCDISPTY D  Q  ; Excel format, xecute code is QUIT, null page number
 .S RCHDR(0)=1,RCHDR(1)="^^^",RCHDR("XECUTE")="Q",RCPGNUM=""
 .S:RCRTYP="ERA" RCHDR(1)="STATION^STATION NUMBER^DATE/TIME^USER^ERA^RECEIPT^MATCH STATUS^POSTED STATUS"
 .S:RCRTYP="EOB" RCHDR(1)="STATION^STATION NUMBER^DATE/TIME^USER^ORIGINAL BILL^NEW BILL^ERA#^TRACE#^PAYMENT AMOUNT^JUSTIFICATION^OTHER BILLS^MOVED/COPIED"
 ;
 N START,END,MSG,DATE,Y,DIV,HCNT,J
 S START=$$FMTE^XLFDT($P(RCDTRNG,U,2),"2Z"),END=$$FMTE^XLFDT($P(RCDTRNG,U,3),"2Z"),HCNT=0
 ;
 S RCHDR(0)=0  ; header line count
 X "S Y=$$HDR"_RCRTYP S HCNT=1
 ;
 I RCRTYP="ERA" D
 .D HDRXEC(RCRTYP)  ; xecute code for line 1
 .S Y="Run Date/Time: "_RCHDR("RUNDATE")
 .S HCNT=HCNT+1,RCHDR(HCNT)=$J("",80-$L(Y)\2)_Y
 .S Y="DIVISIONS: "_$S(VAUTD=1:"ALL",1:DVFLTR)
 .S HCNT=HCNT+1,RCHDR(HCNT)=$J("",80-$L(Y)\2)_Y
 .S Y="Date Range: "_START_" - "_END_" (DATE ERA UPDATED)"
 .S HCNT=HCNT+1,RCHDR(HCNT)=$J("",80-$L(Y)\2)_Y
 .S Y="" F J="CHAMPVA","TRICARE" S Y=Y_" "_J_": "_$S($G(RCXCLUDE(J)):"NO",1:"YES")_"    "
 .S HCNT=HCNT+1,RCHDR(HCNT)=$J("",80-$L(Y)\2)_Y
 .S HCNT=HCNT+1,RCHDR(HCNT)=""
 .S HCNT=HCNT+1,RCHDR(HCNT)="                       Date/Time         User Who        EFT Match Status"
 .S HCNT=HCNT+1,RCHDR(HCNT)="ERA #      Receipt #   ERA Updated       Updated             Detail Post Status"
 .S RCHDR(0)=HCNT  ; header line count
 ;
 I RCRTYP="EOB" D
 .D HDRXEC(RCRTYP)  ; xecute code for line 1
 .S Y="Run Date/Time: "_RCHDR("RUNDATE")
 .S HCNT=HCNT+1,RCHDR(HCNT)=$J("",80-$L(Y)\2)_Y
 .S Y="Divisions: "_$S(VAUTD=1:"ALL",1:DVFLTR)
 .S HCNT=HCNT+1,RCHDR(HCNT)=$J("",80-$L(Y)\2)_Y
 .S Y="Date Range: "_START_" - "_END_" (Date EEOB was Moved/Copied/Removed)"
 .S HCNT=HCNT+1,RCHDR(HCNT)=$J("",80-$L(Y)\2)_Y
 .S Y="" F J="CHAMPVA","TRICARE" S Y=Y_"    "_J_": "_$S($G(RCXCLUDE(J)):"NO",1:"YES")_"    "
 .S HCNT=HCNT+1,RCHDR(HCNT)=$J("",80-$L(Y)\2)_Y
 .S Y=" Action(s) Selected: "_$S(RCACT="M":"MOVE",RCACT="C":"COPY",RCACT="R":"REMOVE",1:"ALL")
 .S HCNT=HCNT+1,RCHDR(HCNT)=$J("",80-$L(Y)\2)_Y
 .S HCNT=HCNT+1,RCHDR(HCNT)=""
 .S HCNT=HCNT+1,RCHDR(HCNT)="Orig Bill#          Trace #"
 .S HCNT=HCNT+1,RCHDR(HCNT)="                                  Moved/Copied/   Total Amt  User Who Moved/"
 .S HCNT=HCNT+1,RCHDR(HCNT)="     ERA #     Date/Time          Removed         Paid       Copied/Removed"
 .S RCHDR(0)=HCNT  ; header line count
 ;
 ; add row of equal signs, not for ListMan
 S Y=RCHDR(0)+1,RCHDR(0)=Y,RCHDR(Y)=$TR($J("",80)," ","=")
 Q
 ;
HDRLM ; create the Listman header
 ; returns RCHDR
 ;   RCHDR(0) = header text line count
 ; INPUT: 
 ;   RCDTRNG - date range
 ;   VAUTD - Division  filter value(s)
 N START,END,MSG,DATE,Y,DIV,HCNT,J
 S START=$$FMTE^XLFDT($P(RCDTRNG,U,2),"2Z"),END=$$FMTE^XLFDT($P(RCDTRNG,U,3),"2Z"),HCNT=0
 ;
 S RCHDR(0)=0  ; header line count
 X "S Y=$$HDR"_RCRTYP
 I RCRTYP="ERA" D
 .D HDRXEC(RCRTYP)  ; xecute code for line 1
 .S HCNT=1,RCHDR(HCNT)=""
 .S Y="Divisions: "_$S(VAUTD=1:"ALL",1:DVFLTR)
 .F J="CHAMPVA","TRICARE" S Y=Y_"     "_J_": "_$S($G(RCXCLUDE(J)):"NO",1:"YES")_"     "
 .S HCNT=HCNT+1,RCHDR(HCNT)=Y
 .S HCNT=HCNT+1,RCHDR(HCNT)=""
 .S Y="Date Range: "_START_" - "_END_" (DATE ERA UPDATED)"
 .S HCNT=HCNT+1,RCHDR(HCNT)=Y
 .S HCNT=HCNT+1,RCHDR(HCNT)=""
 .S HCNT=HCNT+1,RCHDR(HCNT)="                       Date/Time         User Who        EFT Match Status"
 .S HCNT=HCNT+1,RCHDR(HCNT)="ERA #      Receipt #   ERA Updated       Updated             Detail Post Status"
 .S RCHDR(0)=HCNT  ; header line count
 ;
 I RCRTYP="EOB" D
 .D HDRXEC(RCRTYP)  ; xecute code for line 1
 .S Y="Divisions: "_$S(VAUTD=1:"ALL",1:DVFLTR)_"     "
 .F J="CHAMPVA","TRICARE" S Y=Y_"     "_J_": "_$S($G(RCXCLUDE(J)):"NO",1:"YES")_"     "
 .S HCNT=1,RCHDR(HCNT)=Y
 .S Y="Date Range: "_START_" - "_END_" (Date EEOB was Moved/Copied/Removed)"
 .S HCNT=2,RCHDR(HCNT)=Y
 .S Y="Action(s) Selected: "_$S(RCACT="M":"MOVE",RCACT="C":"COPY",RCACT="R":"REMOVE",1:"ALL")
 .S HCNT=3,RCHDR(HCNT)=Y
 .S HCNT=4,RCHDR(HCNT)=""
 .S HCNT=5,RCHDR(HCNT)="Orig Bill#          Trace #"
 .S HCNT=6,RCHDR(HCNT)="                                  Moved/Copied/   Total Amt  User Who Moved/"
 .S HCNT=7,RCHDR(HCNT)="     ERA #     Date/Time          Removed         Paid       Copied/Removed"
 .S RCHDR(0)=HCNT  ; header line count
 ;
 ; add row of equal signs, not for ListMan
 S:'RCLSTMGR Y=RCHDR(0)+1,RCHDR(0)=Y,RCHDR(Y)=" "_$TR($J("",78)," ","=")
 Q
 ;
HDREOB() ; extrinsic variable, header for EOB report
 Q "EEOB Move/Copy/Remove - Audit Report"
 ;
HDRERA() ; extrinsic variable, header for ERA report
 Q "ERAs Posted with Paper EOB - Audit Report"
 ;
HDRXEC(TYP) ; create xecute code for header
 S RCHDR("XECUTE")="N Y S RCPGNUM=RCPGNUM+1,Y=$$HDR"_TYP_"^"_$T(+0)_",RCHDR(1)=$J("" "",80-$L(Y)\2)_Y"_"_""          Page: ""_RCPGNUM"
 Q
 ;
DTRNG() ; function, return date range for a report
 N DIR,DUOUT,X,Y,RCSTART,RCEND
 D DATES(.RCSTART,.RCEND)
 Q:RCSTART=-1 0
 Q:RCSTART "1^"_RCSTART_"^"_RCEND
 Q:'RCSTART "0^^"
 Q 0
 ;
DATES(BDATE,EDATE) ;Get a date range.
 S (BDATE,EDATE)=0
 S DIR("?")="Enter the latest date of receipt of deposit to include on the report."
 S DIR(0)="DAO^:"_DT_":APE",DIR("A")="Start date: " D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S BDATE=-1 Q
 S BDATE=Y
 S DIR("?")="Enter the latest date of receipt of deposit to include on the report."
 S DIR("B")=Y(0)
 S DIR(0)="DAO^"_BDATE_":"_DT_":APE",DIR("A")="  End date: " D ^DIR K DIR
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
 ;RETURNS Y=-1 (quit), VAUTD=1 (for all),VAUTD=0 (selected divisions in VAUTD)
 D DIVISION^VAUTOMA Q:Y<0
 ;
 ;If ALL selected
 I VAUTD=1 S RCDIV=1 Q
 ;If some DIVISIONS selected
 S RCDIV=2
 Q
 ;
ACTION() ; Get action type
 N DIR,X,Y,DIROUT,DUOUT
 S DIR("A")="Move/Copy/Remove or All (M/C/R/A): "
 S DIR("B")="All"  ; default to ALL
 S DIR(0)="SAB^M:Move;C:Copy;R:Remove;A:All"
 D ^DIR Q:$G(DIROUT)!$G(DUOUT) -1
 ;
 Q Y
 ;
DISPTY() ; Get display/output type
 N DIR,DTOUT,DUOUT,X,Y
 S DIR(0)="YA"
 S DIR("A")="Export the report to Microsoft Excel? "
 S DIR("B")="NO"
 D ^DIR I $G(DUOUT) Q -1
 Q Y
 ;
ERASTA(ERAIEN,STA,STNUM,STNAM) ; Get the station for this ERA
 ; read allowed on BILL/CLAIMS file (#399) via IA 3820
 ; returns STA: station IEN, STNAM: station name, STNUM: station number
 N ERAEOB,ERABILL,STAIEN
 S (ERAEOB,ERABILL)=""
 S (STA,STNUM,STNAM)="UNKNOWN"
 D
 .S ERAEOB=$P($G(^RCY(344.4,ERAIEN,1,1,0)),U,2) Q:'ERAEOB  ; if EOB pointer not on first sub-file entry then stop
 .S ERABILL=$P($G(^IBM(361.1,ERAEOB,0)),U,1) Q:'ERABILL  ; EXPLANATION OF BENEFITS file (#361.1)
 .S STAIEN=$P($G(^DGCR(399,ERABILL,0)),U,22) Q:'STAIEN  ;(#.22) DEFAULT DIVISION [22P:40.8]
 .S STA=STAIEN
 .S STNAM=$$EXTERNAL^DILFD(399,.22,,STA)
 .S STNUM=$P($G(^DG(40.8,STAIEN,0)),U,2) ;IA 417
 ;
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
 S DIR(0)="SABO^W:Date Removed from Worklist;R:Date ERA Received;B:Both Dates"
 S DIR("A")="Select Start Date Type: "
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S Y=0
 Q Y
 ;
WP(JC) ; format justification comments
 ; JC - Justification Comment
 I JC="" Q
 N PCS,I,CNTR,CMNT,Y
 ; PCS - Number of " " $pieces in the comment
 ; CNTR - CMNT line counter
 ; CMNT - comment text to be displayed
 S PCS=$L(JC," "),CNTR=1,CMNT(CNTR)=" Justification Comments: "
 F I=1:1:PCS D
 .S Y=$P(JC," ",I)
 .S:$L(CMNT(CNTR))+$L(Y)>72 CNTR=CNTR+1,CMNT(CNTR)=$J(" ",25)
 .S CMNT(CNTR)=CMNT(CNTR)_" "_Y
 ;
 F I=1:1:CNTR D SL^RCDPEARL(CMNT(I),.RCLNCNT,RCTMPND)
 Q
 ;

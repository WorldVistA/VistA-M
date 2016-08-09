RCDPEAPP ;OIFO-BAYPINES/PJH - AUTO POST REPORT ;Dec 20, 2014@18:42
 ;;4.5;Accounts Receivable;**298,304**;Mar 20, 1995;Build 104
 ;Per VA Directive 6402, this routine should not be modified.
 ;Read ^DGCR(399) via Private IA 3820
 ;Read ^DG(40.8) via Controlled IA 417
 ;Read ^IBM(361.1) via Private IA 4051
 ;Use DIVISION^VAUTOMA via Controlled IA 664
 ;
RPT ; entry point for Auto-Post Report [RCDPE AUTO-POST REPORT]
 N POP,RCDISP,RCDIV,RCDTRNG,RCJOB,RCPAGE,RCPARRAY,RCPAY,RCPROG,RCRANGE,RCTYPE,RCLAIM,STANAM,STANUM,VAUTD,X,Y
 ;Initialize page and start point
 S (RCDTRNG,RCPAGE)=0,RCPROG="RCDPEAPP",RCJOB=$J
 ;Select Filter/Sort by Division
 D STADIV Q:'RCDIV
 ;Select report type
 S DIR(0)="SA^S:SUMMARY;D:DETAIL;",DIR("A")="DISPLAY (S)UMMARY OR (D)ETAIL FORMAT?: ",DIR("B")="DETAIL" D ^DIR K DIR Q:$D(DTOUT)!$D(DUOUT)
 S RCTYPE=Y
 ;PRCA*4.5*304 - Select Filter for Claim Type ((M)edical, (P)harmacy, or (B)oth)
 S RCLAIM=$$RTYPE^RCDPESP2() Q:RCLAIM=-1
 ;Select Filter for Payer - returns array ^TMP("RCSELPAY",$J
 S RCPAY=$$GETPAY^RCDPEM9(344.4) Q:RCPAY<0
 ;Move ^TMP("RCSELPAY",RCJOB) into RCPARRAY for lookup, note that payer names for 344.4 are UPPER CASE
 I $P(RCPAY,U)'=2 D
 .N PSUB,PAYER S PSUB=0
 .F  S PSUB=$O(^TMP("RCSELPAY",RCJOB,PSUB)) Q:'PSUB  D
 ..S PAYER=$G(^TMP("RCSELPAY",RCJOB,PSUB))
 ..S:PAYER'="" RCPARRAY(PAYER)=""
 ;
 ;Select Date Range for Report
 S RCRANGE=$$DTRNG() Q:RCRANGE=0
 ;Select Display Type
 S RCDISP=$$DISPTY() Q:RCDISP=-1
 ;Display capture information for Excel
 I RCDISP D INFO^RCDPEM6
 ;PRCA*4.5*304 - If not Excel, inform user to make sure printer/screen will display 132 columns
 I 'RCDISP W !,"This report requires 132 column display."
 ;Select output device
 S %ZIS="QM" D ^%ZIS Q:POP
 ;Option to queue
 I 'RCDISP,$D(IO("Q")) D  Q
 .N ZTDESC,ZTQUEUED,ZTRTN,ZTSAVE,ZTSK
 .S ZTRTN="REPORT^RCDPEAPP"
 .S ZTDESC="EDI LOCKBOX AUTO POST REPORT"
 .S ZTSAVE("RC*")="",ZTSAVE("VAUTD")=""
 .D ^%ZTLOAD
 .I $D(ZTSK) W !!,"Task number "_ZTSK_" was queued."
 .E  W !!,"Unable to queue this job."
 .K IO("Q") D HOME^%ZIS
 ;
 ;Compile and Print Report
 D REPORT
 Q
 ;
REPORT ;Compile and print report
 N GLOB,GTOTAL,ZTREQ
 K ^TMP(RCPROG,$J),^TMP("RCDPEAPP2",$J)
 S GLOB=$NA(^TMP(RCPROG,$J))
 ;Scan ERA file for entries in date range
 D COMPILE
 ;Display Report
 D DISP
 ;Clear ^TMP global
 K ^TMP(RCPROG,$J),^TMP("RCSELPAY",RCJOB),^TMP("RCDPEAPP2",$J)
 Q
 ;
COMPILE ;Generate the Auto Posting report ^TMP array
 N APDATE,END,IEN,RCRZ,RCECME,STA,STNAM,STNUM,CNT
 ;
 ;Date Range
 S APDATE=$$FMADD^XLFDT($P(RCRANGE,U,2),-1),END=$P(RCRANGE,U,3),CNT=0
 ;Scan F index for ERA within date range
 F  S APDATE=$O(^RCY(344.4,"F",APDATE)) Q:'APDATE  Q:(APDATE\1)>END  D
 .S ERAIEN=""
 .F  S ERAIEN=$O(^RCY(344.4,"F",APDATE,ERAIEN)) Q:'ERAIEN  D
 ..;Check division - Note return values are set to UNKNOWN if not available
 ..D ERASTA(ERAIEN,.STA,.STNUM,.STNAM)
 ..I RCDIV=2,'$D(VAUTD(STA)) Q
 .. ; PRCA*4.5*304 - Check if we include this ERA in report
 .. I RCLAIM'="B" N OKAY S OKAY=1 D  Q:'OKAY  ; If both not specified check for inclusion
 ... S RCECME=$$PHARM^RCDPEAP1(ERAIEN) ; See if ECME # exists for this ERA
 ... I RCECME=1,RCLAIM="M" S OKAY=0 ; If ECME # and only want Medical skip this ERA
 ... I RCECME=0,RCLAIM="P" S OKAY=0 ; If no ECME # and only want Pharmacy skip this ERA
 ..;Check Payer, payer names come from 344.4,06 "C" cross-reference which is UPPER CASE
 ..I $P(RCPAY,U)'=2 N ERAPAY,MATCH D  Q:'MATCH
 ...S ERAPAY=$P($G(^RCY(344.4,ERAIEN,0)),U,6),MATCH=0 Q:ERAPAY=""
 ...S:$D(RCPARRAY($$UP^XLFSTR(ERAPAY))) MATCH=1  ; payer names for 344.4 are UPPER CASE
 ..;If it does not already exist for this ERA, build X-ref of ERA detail lines to the lines in the worklist
 ..I '$D(^TMP("RCDPEAPP2",$J,ERAIEN)) D BUILD(ERAIEN)
 ..;Scan index for auto posted claim lines within the ERA
 ..S RCRZ=""
 ..F  S RCRZ=$O(^RCY(344.4,"F",APDATE,ERAIEN,RCRZ)) Q:'RCRZ  D
 ...;Save claim line detail to ^TMP global
 ...D SAVE
 ;
 Q
 ;
SAVE ;Save to ^TMP global
 N REC0,REC41,BILL,BAMT,BALANCE,CLAIMIEN,COLLECT,ERANUM,ERADATE,EFTNUM,EOBIEN,PAMT,PAYNAM,PTNAM,RECEIPT,TRACE,DATE
 N SEQ,SEQ1,SEQ2,REC49,TOTBAMT,TOTBAL,TOTPAMT
 ;
 ;Get ERA header and detail data
 S REC0=$G(^RCY(344.4,ERAIEN,0)),REC41=$G(^RCY(344.4,ERAIEN,1,RCRZ,0))
 ;
 ;Payer name from ERA record
 S PAYNAM=$P(REC0,U,6)
 I PAYNAM="" S PAYNAM="UNKNOWN"
 S (TOTBAMT,TOTBAL,TOTPAMT)=0
 ;
 ;If they want detail, get these extra fields
 I RCTYPE="D" D
 . ;Trace #
 . S TRACE=$P(REC0,U,2)
 . ;Patient name from claim file #399
 . S PTNAM=$$PNM4^RCDPEWL1(ERAIEN,RCRZ)
 . ;ERA# from header
 . S ERANUM=$P(REC0,U)
 . ;Date received (file date/time)
 . S ERADATE=$$FMTE^XLFDT($P(REC0,U,7),"2D")
 . ;Format Auto Post Date
 . S DATE=$$FMTE^XLFDT(APDATE,"2D")
 . ;EFT#
 . S EFTNUM=$O(^RCY(344.31,"AERA",ERANUM,"")) S:EFTNUM EFTNUM=$P($G(^RCY(344.31,EFTNUM,0)),U)
 . ;Receipt
 . S RECEIPT=$$EXTERNAL^DILFD(344.41,.25,,$P($G(^RCY(344.4,ERAIEN,1,RCRZ,4)),U,3))
 ;
 ; Get link to the scratchpad detail line
 ; If the worklist detail records exist, loop through the ones with the same prefix to get the data (this will have split-edits)
 S SEQ=$G(^TMP("RCDPEAPP2",$J,ERAIEN,RCRZ))
 I SEQ D
 . S SEQ1=SEQ F  S SEQ1=$O(^RCY(344.49,ERAIEN,1,"B",SEQ1)) Q:'SEQ1!(SEQ1\1'=SEQ)  D
 .. S SEQ2=$O(^RCY(344.49,ERAIEN,1,"B",SEQ1,""))
 .. I SEQ2="" Q
 .. S REC49=$G(^RCY(344.49,ERAIEN,1,SEQ2,0))
 .. S (BAMT,BALANCE,COLLECT)=""
 .. S CLAIMIEN=$P(REC49,U,7)
 .. S BILL=$P(REC49,U,2)
 .. I BILL="" S BILL="<blank>"
 .. ;Amount Paid on Claim
 .. S PAMT=$P(REC49,U,6)
 .. ;If there is a claim, get billed amount and balance from the claim
 .. I CLAIMIEN S BAMT=$J(+$P($G(^PRCA(430,CLAIMIEN,0)),U,3),0,2),BALANCE=$J(+$P($G(^PRCA(430,CLAIMIEN,7)),U),0,2)
 .. ;Update total amounts
 .. S TOTBAMT=TOTBAMT+BAMT,TOTBAL=TOTBAL+BALANCE,TOTPAMT=TOTPAMT+PAMT
 .. ;If they want detail, get extra data and then update the detail global
 .. I RCTYPE="D" D
 ... S PTNAM=$S('CLAIMIEN:"",1:$$PNM4^RCDPEWL1(ERAIEN,RCRZ))
 ... S:BAMT COLLECT=$J(PAMT/BAMT*100,0,2)_"%"
 ... ;Update ^TMP global for detail report
 ... S CNT=CNT+1
 ... S @GLOB@(STNAM,PAYNAM,CNT)=STNAM_U_STNUM_U_PAYNAM_U_PTNAM_U_ERANUM_U_ERADATE_U_DATE_U_EFTNUM_U_RECEIPT_U_BILL_U_BAMT_U_PAMT_U_BALANCE_U_COLLECT_U_TRACE
 .. ; Update totals
 ;
 ; If the worlist detail record does not exist, get data from ERA detail
 I 'SEQ D
 . S (TOTBAMT,TOTBAL,COLLECT,CLAIMIEN)=0
 . ;Get pointer to EOB file #361.1 from ERA DETAIL
 . S EOBIEN=$P($G(^RCY(344.4,ERAIEN,1,RCRZ,0)),U,2)
 . ;Get ^DGCR(399 pointer (DINUM for #430 file)
 . S:EOBIEN CLAIMIEN=$P($G(^IBM(361.1,EOBIEN,0)),U)
 . ;Bill number
 . S BILL=$$EXTERNAL^DILFD(344.41,.02,,EOBIEN)
 . ;Billed Amount from AR (Original Balance)
 . S:CLAIMIEN TOTBAMT=$J(+$P($G(^PRCA(430,CLAIMIEN,0)),U,3),0,2)
 . ;Amount Paid on Claim
 . S TOTPAMT=$P(REC41,U,3)
 . ;Balance from AR (Principal Balance)
 . S:CLAIMIEN TOTBAL=$J(+$P($G(^PRCA(430,CLAIMIEN,7)),U),0,2)
 . ;If they want detail, get extra data and then update the detail global
 . I RCTYPE="D" D
 .. S PTNAM=$S('CLAIMIEN:"",1:$$PNM4^RCDPEWL1(ERAIEN,RCRZ))
 .. S:TOTBAMT COLLECT=$J(TOTPAMT/TOTBAMT*100,0,2)_"%"
 .. ;Update ^TMP global for detail report
 .. S CNT=CNT+1
 .. S @GLOB@(STNAM,PAYNAM,CNT)=STNAM_U_STNUM_U_PAYNAM_U_PTNAM_U_ERANUM_U_ERADATE_U_DATE_U_EFTNUM_U_RECEIPT_U_BILL_U_TOTBAMT_U_TOTPAMT_U_TOTBAL_U_COLLECT_U_TRACE
 ;
 ;Update totals for individual division
 S $P(@GLOB@(STNAM),U)=$P($G(@GLOB@(STNAM)),U)+1,$P(@GLOB@(STNAM),U,2)=$P($G(@GLOB@(STNAM)),U,2)+TOTBAMT
 S $P(@GLOB@(STNAM),U,3)=$P($G(@GLOB@(STNAM)),U,3)+TOTPAMT,$P(@GLOB@(STNAM),U,4)=$P($G(@GLOB@(STNAM)),U,4)+TOTBAL
 ;
 ;Update totals for individual division/payer
 S $P(@GLOB@(STNAM,PAYNAM),U,1)=$P($G(@GLOB@(STNAM,PAYNAM)),U,1)+1
 S $P(@GLOB@(STNAM,PAYNAM),U,2)=$P($G(@GLOB@(STNAM,PAYNAM)),U,2)+TOTBAMT
 S $P(@GLOB@(STNAM,PAYNAM),U,3)=$P($G(@GLOB@(STNAM,PAYNAM)),U,3)+TOTPAMT
 S $P(@GLOB@(STNAM,PAYNAM),U,4)=$P($G(@GLOB@(STNAM,PAYNAM)),U,4)+TOTBAL
 ;
 ;Update grand totals
 S $P(GTOTAL,U)=$P($G(GTOTAL),U)+1,$P(GTOTAL,U,2)=$P($G(GTOTAL),U,2)+TOTBAMT
 S $P(GTOTAL,U,3)=$P($G(GTOTAL),U,3)+TOTPAMT,$P(GTOTAL,U,4)=$P($G(GTOTAL),U,4)+TOTBAL
 Q
 ;
DISP ; Format the display for screen/printer or MS Excel
 N FILTERD,FILTERP,LINE1,LINE2,RCDATA,RCHDRDT,RCSTOP,SUB,SUB1,SUB2
 S RCHDRDT=$$FMTE^XLFDT($$NOW^XLFDT,"2S")  ; date/time for header
 S LINE1=$TR($J("",131)," ","-"),LINE2=$TR(LINE1,"-","=")
 ;
 U IO
 ;
 ;Report by division or 'ALL'
 ;Format Division filter
 S FILTERD=$S(RCDIV=2:$$LINE(.VAUTD),1:"ALL")
 ;Format Payer filter
 S FILTERP=$S($P(RCPAY,U)'=2:$$LINE1(),1:"ALL")
 S SUB="",RCSTOP=0
 F  S SUB=$O(@GLOB@(SUB)) Q:SUB=""  D  Q:RCSTOP
 .;Display Header
 .D HDR
 .I 'RCDISP W !,"DIVISION: ",SUB W:RCTYPE="S" !,LINE1
 .S SUB1=""
 .F  S SUB1=$O(@GLOB@(SUB,SUB1)) Q:SUB1=""  D  Q:RCSTOP
 ..;Display payer sub-header for detail report only
 ..I 'RCDISP,RCTYPE="D" D HDRP(SUB1)
 ..S SUB2=""
 ..F  S SUB2=$O(@GLOB@(SUB,SUB1,SUB2)) Q:SUB2=""  D  Q:RCSTOP
 ...S RCDATA=@GLOB@(SUB,SUB1,SUB2)
 ...I 'RCDISP D  Q:RCSTOP
 ....;Auto Posted ERA
 ....I $Y>(IOSL-6) D HDR Q:RCSTOP
 ....W !,$P(RCDATA,U,4) ;Patient Name
 ....W ?31,$P(RCDATA,U,5) ;ERA#
 ....W ?38,$P(RCDATA,U,6) ;DATE RECEIVED
 ....W ?49,$P(RCDATA,U,7) ;DATE AUTOPOSTED
 ....W ?60,$P(RCDATA,U,8) ;EFT#
 ....W ?67,$P(RCDATA,U,9) ;"TR" RECEIPT
 ....W ?79,$E($P(RCDATA,U,10),1,12) ;BILL#
 ....W ?91,$J($P(RCDATA,U,11),8) ;ORIGINAL BILLED AMOUNT
 ....W ?103,$J($P(RCDATA,U,12),8) ;PAYED AMOUNT
 ....W ?113,$J($P(RCDATA,U,13),8) ;BALANCE
 ....W ?123,$P(RCDATA,U,14) ;% COLLECTED
 ....W !,?8,"TRACE#:",$P(RCDATA,U,15)
 ....;Subtotals for Payer on detail report
 ....I 'RCDISP,$O(@GLOB@(SUB,SUB1,SUB2))="" D TOTALDP(SUB,SUB1)
 ...I RCDISP D
 ....W !,RCDATA
 ..;Subtotals for Division on detail report
 ..I 'RCDISP,RCTYPE="D",$O(@GLOB@(SUB,SUB1))="" D TOTALD(SUB)
 .;
 ;Grand totals
 I $D(GTOTAL),'RCSTOP D
 .;Print grand only total if detail report
 .I 'RCDISP,RCTYPE="D" D TOTALG
 .;Print all totals if summary report
 .I 'RCDISP,RCTYPE="S" D TOTALS
 .;Report finished
 .W !,$$ENDORPRT^RCDPEARL D:'$G(ZTSK) ASK(.RCSTOP)
 ;
 ;Null Report
 I '$D(GTOTAL) D
 .D HDR
 .W !!,?26,"*** NO RECORDS TO PRINT ***",!
 ;
 ;Close device
 I '$D(ZTQUEUED) D ^%ZISC
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
ASK(STOP) ; Ask to continue
 ; If passed by reference ,RCSTOP is returned as 1 if print is aborted
 I $E(IOST,1,2)'["C-" Q
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR("A")="Press ENTER to continue: "
 S DIR(0)="EA" D ^DIR
 I ($D(DIRUT))!($D(DUOUT)) S STOP=1
 Q
 ;
DATES(BDATE,EDATE) ;Get a date range.
 S (BDATE,EDATE)=0
 S DIR("?")="ENTER THE EARLIEST AUTO POSTING DATE TO INCLUDE ON THE REPORT"
 S DIR(0)="DAO^:"_DT_":APE",DIR("A")="START DATE: " D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S BDATE=-1 Q
 S BDATE=Y
 S DIR("?")="ENTER THE LATEST AUTO POSTING DATE TO INCLUDE ON THE REPORT"
 S DIR("B")=Y(0)
 S DIR(0)="DAO^"_BDATE_":"_DT_":APE",DIR("A")="END DATE: " D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S BDATE=-1 Q
 S EDATE=Y
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
DTRNG() ; Get the date range for the report
 N DIR,DUOUT,RNGFLG,X,Y,RCSTART,RCEND
 D DATES(.RCSTART,.RCEND)
 Q:RCSTART=-1 0
 Q:RCSTART "1^"_RCSTART_"^"_RCEND
 Q:'RCSTART "0^^"
 Q 0
 ;
ERASTA(ERAIEN,STA,STNUM,STNAM) ; Get the station for this ERA
 N ERAEOB,ERABILL,FOUND,STAIEN
 S (ERAEOB,ERABILL,FOUND)=""
 S (STA,STNUM,STNAM)="UNKNOWN"
 D
 .S ERAEOB=$P($G(^RCY(344.4,ERAIEN,1,1,0)),U,2) Q:'ERAEOB
 .S ERABILL=$P($G(^IBM(361.1,ERAEOB,0)),U,1) Q:'ERABILL
 .S STAIEN=$P($G(^DGCR(399,ERABILL,0)),U,22) Q:'STAIEN
 .S STA=STAIEN
 .S STNAM=$$EXTERNAL^DILFD(399,.22,,STA)
 .S STNUM=$P($G(^DG(40.8,STAIEN,0)),U,2)
 Q
 ;
HDR ; Print the report header
 N START,END,MSG,Y
 S START=$$FMTE^XLFDT($P(RCRANGE,U,2),2)
 S END=$$FMTE^XLFDT($P(RCRANGE,U,3),2)
 ;
 I 'RCDISP,'RCSTOP D
 .I RCPAGE D ASK(.RCSTOP) Q:RCSTOP
 .S RCPAGE=RCPAGE+1
 .W @IOF
 .S MSG(1)="EDI LOCKBOX AUTO-POST REPORT - "_$S(RCTYPE="D":"DETAIL ",1:"SUMMARY")_$J("",47)_"Print Date: "_RCHDRDT_"    Page: "_RCPAGE
 .S MSG(2)="DIVISIONS: "_$E(FILTERD,1,72)_$J("",74-$L(FILTERD))_"CLAIM TYPE: "_$S(RCLAIM="P":"PHARMACY",RCLAIM="M":"MEDICAL",1:"MEDICAL & PHARMACY")
 .S MSG(3)="PAYERS: "_FILTERP
 .S MSG(4)="AUTOPOST POSTING RESULTS FOR DATE RANGE: "_START_" - "_END
 .S MSG(5)=LINE2
 .S MSG(6)="PATIENT NAME/SSN               ERA#   DT REC'D   DT POST    EFT#   RECEIPT#    BILL#       AMT BILLED  AMT PAID   BALANCE  %COLL"
 .S MSG(7)=LINE2
 .D EN^DDIOL(.MSG)
 I RCDISP D
 .W !,"STATION^STATION NUMBER^PAYER^PATIENT NAME/SSN^ERA#^DT REC'D^DT POST^EFT#^RECEIPT#^BILL#^AMT BILLED^AMT PAID^BALANCE^%COLL^TRACE#"
 Q
 ;
HDRP(PAYNAM) ; Print Payer Sub-header
 W !,LINE1,!,"PAYER: ",PAYNAM,!,LINE1
 Q
 ;
LINE(VAUTD) ;List selected stations
 N LINE,SUB
 S LINE="",SUB=""
 F  S SUB=$O(VAUTD(SUB)) Q:'SUB  D
 .S LINE=LINE_$G(VAUTD(SUB))_", "
 Q $E(LINE,1,$L(LINE)-2)
 ;
LINE1() ;List selected payers
 N PAYR,LINE
 S PAYR="",LINE=""
 F  S PAYR=$O(RCPARRAY(PAYR)) Q:PAYR=""  D
 .S LINE=LINE_PAYR_", "
 Q $E(LINE,1,$L(LINE)-2)
 ;
SELDIV(VAUTD,Z) ;Divisions are organized as Z(1)="DIV1,DIV2,..., Z(2)="DIVN,DIVN+1,... etc.
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
TOTALS ;Print totals for summary report
 N DIV,DBAL,DBAMT,DCNT,DPAMT,PAYNAM
 S DIV=""
 F  S DIV=$O(@GLOB@(DIV)) Q:DIV=""  D  Q:RCSTOP
 .;Get payer totals within division first
 .S PAYNAM=""
 .F  S PAYNAM=$O(@GLOB@(DIV,PAYNAM)) Q:PAYNAM=""  D TOTALDP(DIV,PAYNAM)
 .;Division totals
 .D TOTALD(DIV)
 ;Grand Totals
 D TOTALG
 Q
 ;
TOTALD(DIV) ;Total for a division
 N DCNT,DBAMT,DPAMT,DBAL
 S DCNT=$P(@GLOB@(DIV),U),DBAMT=$P(@GLOB@(DIV),U,2),DPAMT=$P(@GLOB@(DIV),U,3),DBAL=$P(@GLOB@(DIV),U,4)
 I 'RCDISP,$Y>(IOSL-6) D HDR Q:RCSTOP
 W !,"DIVISION TOTALS FOR ",DIV,?90,$J(DBAMT,10,2),$J(DPAMT,10,2),$J(DBAL,10,2),$J(DPAMT/DBAMT*100,7,2),"%"
 W !,?8,"COUNT",?90,$J(DCNT,10,0),$J(DCNT,10,0),$J(DCNT,10,0)
 W !,?8,"MEAN",?90,$J(DBAMT/DCNT,10,2),$J(DPAMT/DCNT,10,2),$J(DBAL/DCNT,10,2)
 W !,LINE1
 Q
 ;
TOTALDP(DIV,PAYNAM) ;Total for a payer within a division
 N DCNT,DBAL,DBAMT,DCNT,DPAMT
 I 'RCDISP,$Y>(IOSL-6) D HDR Q:RCSTOP
 S DCNT=$P(@GLOB@(DIV,PAYNAM),U),DBAMT=$P(@GLOB@(DIV),U,2),DPAMT=$P(@GLOB@(DIV),U,3),DBAL=$P(@GLOB@(DIV),U,4)
 W:RCTYPE="D" !,?92,"------------------------------------"
 W !,"SUBTOTALS FOR PAYER: ",PAYNAM,?90,$J(DBAMT,10,2),$J(DPAMT,10,2),$J(DBAL,10,2),$J(DPAMT/DBAMT*100,7,2),"%"
 W !,?8,"COUNT",?90,$J(DCNT,10,0),$J(DCNT,10,0),$J(DCNT,10,0)
 W !,?8,"MEAN",?90,$J(DBAMT/DCNT,10,2),$J(DPAMT/DCNT,10,2),$J(DBAL/DCNT,10,2)
 W !,LINE1
 Q
 ;
TOTALG ;Overall report total
 I 'RCDISP,$Y>(IOSL-6) D HDR Q:RCSTOP
 W !,"GRAND TOTALS FOR ALL DIVISIONS",?90,$J(+$P(GTOTAL,U,2),10,2),$J(+$P(GTOTAL,U,3),10,2),$J(+$P(GTOTAL,U,4),10,2),$J($P(GTOTAL,U,3)/$P(GTOTAL,U,2)*100,7,2),"%"
 W !,?8,"COUNT",?90,$J(+$P(GTOTAL,U),10,0),$J(+$P(GTOTAL,U),10,0),$J(+$P(GTOTAL,U),10,0)
 W !,?8,"MEAN",?90,$J($P(GTOTAL,U,2)/$P(GTOTAL,U),10,2),$J($P(GTOTAL,U,3)/$P(GTOTAL,U),10,2),$J($P(GTOTAL,U,4)/$P(GTOTAL,U),10,2)
 W !,LINE1
 Q
 ;
BUILD(RCSCR) ;
 ; Build cross-reference of ERA detail lines to ERA scratch-pad lines
 ; Input
 ;   RCSCR = ien of file 344.4/344.49
 ;
 ; Check parameters
 I '$G(RCSCR) Q
 ; Check that scratchpad entry exists for this ERA
 I '$D(^RCY(344.49,RCSCR)) Q
 ;
 N SUB,SUB1,ERALINE,CNT,ERADET
 S SUB=0 F  S SUB=$O(^RCY(344.49,RCSCR,1,"B",SUB)) Q:SUB=""  I SUB'["." D
 . ; Get scratchpad ^RCY(344.49,RCSCR,1) node
 . S SUB1=$O(^RCY(344.49,RCSCR,1,"B",SUB,""))
 . I 'SUB1 Q
 . ; Get pointer back to ERA detail line(s) - This can be a set of comma pieces
 . S ERALINE=$P($G(^RCY(344.49,RCSCR,1,SUB1,0)),U,9)
 . F CNT=1:1:$L(ERALINE,",") S ERADET=$P(ERALINE,",",CNT) I ERADET S ^TMP("RCDPEAPP2",$J,RCSCR,ERADET)=+$G(^RCY(344.49,RCSCR,1,SUB1,0))
 Q

FBAAIARA ;ALB/ESG - Fee IPAC Vendor DoD Invoice (Summary) Report Print ;1/16/2014
 ;;3.5;FEE BASIS;**123**;JAN 30, 1995;Build 51
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Scratch global built by FBAAIAR.
 ; ^TMP("FBAAIAR",$J,VENDOR NAME, DOD INVOICE#) = 
 ;         [1] vendor ien
 ;         [2] vendor external ID#
 ;         [3] date finalized (date that made this record eligible for report)
 ;         [4] total amount claimed
 ;         [5] total amount paid
 ;         [6] total adjustment amount
 ;         [7] Fee Invoice#
 ;         [8] Fee Invoice# "+" flag if additional values exist
 ;         [9] Batch#
 ;        [10] Batch# "+" flag if additional values exist
 ;        [11] Obligation#
 ;        [12] Obligation# "+" flag if additional values exist
 ;        [13] date paid
 ;        [14] date paid "+" flag if additional values exist
 ;        [15] date paid "*" flag is not all lines have a date paid value
 ;        [16] check number
 ;        [17] check number "+" flag if additional values exist
 ;        [18] check number "*" flag if not all lines have a check#
 ;        [19] total disbursed amount
 ;
 ; ^TMP("FBAAIAR",$J,VENDOR NAME) = 
 ;         [1] total number of DoD invoices for vendor
 ;         [4] total amount claimed for vendor
 ;         [5] total amount paid for vendor
 ;         [6] total adjustment amount for vendor
 ;        [19] total disbursed amount for vendor
 ;
 Q
 ;
PRINT ; entry point for printing the report
 ; Variables assumed to exist from FBAAIAR:  FBIAVEN, FBIABEG, FBIAEND, FBIATYPE, FBIAEXCEL
 ;
 N CRT,DIR,DIROUT,DIRUT,DTOUT,DUOUT,FBDODINV,FBIASTOP,FBVENAME,ITSTR,PAGE,RPTG,RPTT,SEPLINE,X,Y
 S CRT=$S(IOST["C-":1,1:0)
 I FBIAEXCEL S IOSL=999999    ; long screen length for Excel output
 S PAGE=0,FBIASTOP=0,$P(SEPLINE,"-",131)="",ITSTR=$$ITSTR(.FBIATYPE)
 I '$D(^TMP("FBAAIAR",$J)) D HDR W !!?5,"No data found for this report." G PX
 I $G(ZTSTOP) D HDR W !!?5,"This report was halted during compilation by TaskManager Request." G PX
 ;
 I FBIAEXCEL D HDR I FBIASTOP G PRINTX   ; for Excel CSV, display the header line first before looping
 ;
 S FBVENAME="" F  S FBVENAME=$O(^TMP("FBAAIAR",$J,FBVENAME)) Q:FBVENAME=""!FBIASTOP  D
 . K RPTG
 . I 'FBIAEXCEL D HDR Q:FBIASTOP       ; page break with each new vendor (not for Excel output)
 . S FBDODINV="" F  S FBDODINV=$O(^TMP("FBAAIAR",$J,FBVENAME,FBDODINV)) Q:FBDODINV=""!FBIASTOP  D
 .. S RPTG=$G(^TMP("FBAAIAR",$J,FBVENAME,FBDODINV))
 .. ;
 .. I FBIAEXCEL D EXCELN(FBVENAME,FBDODINV,RPTG) Q   ; for Excel output, print a CSV format record
 .. ;
 .. I $Y+4>IOSL D HDR Q:FBIASTOP      ; check for page break
 .. W !,$$LJ^XLFSTR(FBDODINV,22)                                    ; DoD invoice#
 .. W $$RJ^XLFSTR("$"_$FN($P(RPTG,U,4),"",2),13)                    ; total amount claimed
 .. W $$RJ^XLFSTR("$"_$FN($P(RPTG,U,5),"",2),13)                    ; total amount paid
 .. W $$RJ^XLFSTR("$"_$FN($P(RPTG,U,6),"",2),13)                    ; total adjustment amount
 .. W ?64,$$LJ^XLFSTR($P(RPTG,U,7)_$S($P(RPTG,U,8):"+",1:""),10)    ; VA fee invoice#
 .. W ?76,$$LJ^XLFSTR($P(RPTG,U,9)_$S($P(RPTG,U,10):"+",1:""),6)    ; batch#
 .. W ?84,$$LJ^XLFSTR($P(RPTG,U,11)_$S($P(RPTG,U,12):"+",1:""),7)   ; obligation#
 .. W ?93,$$LJ^XLFSTR($$FMTE^XLFDT($P(RPTG,U,13),"2DZ")_$S($P(RPTG,U,14):"+",1:"")_$S($P(RPTG,U,15):"*",1:""),10) ; dt paid
 .. W ?105,$$LJ^XLFSTR($P(RPTG,U,16)_$S($P(RPTG,U,17):"+",1:"")_$S($P(RPTG,U,18):"*",1:""),10)   ; check#
 .. W $$RJ^XLFSTR("$"_$FN($P(RPTG,U,19),"",2),13)                   ; total amount disbursed
 .. Q
 . ;
 . Q:FBIASTOP!FBIAEXCEL
 . ;
 . S RPTT=$G(^TMP("FBAAIAR",$J,FBVENAME))    ; totals for vendor
 . ;
 . ; display dollar totals for vendor
 . I $Y+5>IOSL D HDR Q:FBIASTOP      ; check for page break
 . W !?24,"-----------  -----------  -----------",?117,"-----------"
 . W !?1,"$Totals for Vendor   "
 . W $$RJ^XLFSTR("$"_$FN($P(RPTT,U,4),"",2),13)                    ; total amount claimed
 . W $$RJ^XLFSTR("$"_$FN($P(RPTT,U,5),"",2),13)                    ; total amount paid
 . W $$RJ^XLFSTR("$"_$FN($P(RPTT,U,6),"",2),13)                    ; total adjustment amount
 . W ?115,$$RJ^XLFSTR("$"_$FN($P(RPTT,U,19),"",2),13)              ; total amount disbursed
 . ;
 . ; display total number of DoD invoices for vendor
 . I $Y+5>IOSL D HDR Q:FBIASTOP      ; check for page break
 . W !!,"Total Number of DoD Invoices for Vendor: ",$P(RPTT,U,1)
 . Q
 ;
 I FBIASTOP G PRINTX    ; get out right away if stop flag is set
 ;
 I $Y+5>IOSL D HDR I FBIASTOP G PRINTX
 W !!?5,"*** End of Report ***"
 ;
PX ;
 I CRT,'$D(ZTQUEUED) S DIR(0)="E" D ^DIR K DIR
PRINTX ;
 Q
 ;
EXCELN(FBVENAME,FBDODINV,RPTG) ; output one Excel line
 ; FBVENAME - vendor name
 ; FBDODINV - DoD invoice#
 ;     RPTG - scratch global data string
 N FBZ
 S FBZ=$$CSV("",FBVENAME)                        ; vendor name
 S FBZ=$$CSV(FBZ,$P(RPTG,U,2))                   ; vendor ID#
 S FBZ=$$CSV(FBZ,FBDODINV)                       ; DoD invoice#
 S FBZ=$$CSV(FBZ,$FN($P(RPTG,U,4),"",2))         ; total amount claimed
 S FBZ=$$CSV(FBZ,$FN($P(RPTG,U,5),"",2))         ; total amount paid
 S FBZ=$$CSV(FBZ,$FN($P(RPTG,U,6),"",2))         ; total adjustment amount
 S FBZ=$$CSV(FBZ,$P(RPTG,U,7)_$S($P(RPTG,U,8):"+",1:""))     ; VA fee invoice#
 S FBZ=$$CSV(FBZ,$P(RPTG,U,9)_$S($P(RPTG,U,10):"+",1:""))    ; batch#
 S FBZ=$$CSV(FBZ,$P(RPTG,U,11)_$S($P(RPTG,U,12):"+",1:""))   ; obligation#
 S FBZ=$$CSV(FBZ,$$FMTE^XLFDT($P(RPTG,U,13),"2DZ")_$S($P(RPTG,U,14):"+",1:"")_$S($P(RPTG,U,15):"*",1:""))   ; date paid
 S FBZ=$$CSV(FBZ,$P(RPTG,U,16)_$S($P(RPTG,U,17):"+",1:"")_$S($P(RPTG,U,18):"*",1:""))   ; check#
 S FBZ=$$CSV(FBZ,$FN($P(RPTG,U,19),"",2))        ; total amount disbursed
 W !,FBZ
 Q
 ;
HDR ; report header
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,VENID,X,Y,Z
 ;
 ; Do an end of page reader call if page# exists and device is the screen
 I PAGE,CRT S DIR(0)="E" D ^DIR K DIR I 'Y S FBIASTOP=1 G HDRX
 ;
 ; If screen output or page# exists, do a form feed
 I PAGE!CRT W @IOF
 ;
 ; First printer/file page - do a left margin reset
 I 'PAGE,'CRT W $C(13)
 ;
 S PAGE=PAGE+1    ; increment page#
 ;
 ; For Excel CSV format, display the column headers only
 I FBIAEXCEL D EXCELHD G HDRX
 ;
 ; Display the report headers
 W "IPAC Vendor DoD Invoice Report"
 W ?44,"For Date Range ",$$FMTE^XLFDT(FBIABEG,"5DZ")," - ",$$FMTE^XLFDT(FBIAEND,"5DZ")
 W ?96,$$FMTE^XLFDT($$NOW^XLFDT),?120,"Page: ",PAGE
 W !?3,"Selected Invoice Types: ",ITSTR
 ;
 ; display vendor name and ID if these things are known
 I $G(FBVENAME)'="" D
 . W !?14,"Vendor Name: ",FBVENAME
 . S VENID=$P($G(RPTG),U,2)
 . I VENID="" S Z=$O(^TMP("FBAAIAR",$J,FBVENAME,"")) I Z'="" S VENID=$P($G(^TMP("FBAAIAR",$J,FBVENAME,Z)),U,2)
 . I VENID'="" W "  (ID# ",VENID,")"
 . Q
 ;
 ; now display the column headers
 W !?26,"Total Amt",?39,"Total Amt",?52,"Total Amt",?64,"Fee Basis",?119,"Total Amt"
 W !,"DoD Invoice Number",?28,"Claimed",?44,"Paid",?53,"Adjusted",?64,"Invoice#",?76,"Batch#",?84,"Oblig#",?93,"Date Paid",?105,"Check#",?119,"Disbursed"
 W !,SEPLINE
 ;
 ; check for a TaskManager stop request
 I $D(ZTQUEUED),$$S^%ZTLOAD() D  G HDRX
 . S (ZTSTOP,FBIASTOP)=1
 . W !!!?5,"*** Report Halted by TaskManager Request ***"
 . Q
HDRX ;
 Q
 ;
EXCELHD ; print an Excel CSV header record (only 1 Excel CSV header should print for the whole report)
 N FBH
 S FBH=$$CSV("","Vendor Name")
 S FBH=$$CSV(FBH,"Vendor ID")
 S FBH=$$CSV(FBH,"DoD Invoice#")
 S FBH=$$CSV(FBH,"Total Amount Claimed")
 S FBH=$$CSV(FBH,"Total Amount Paid")
 S FBH=$$CSV(FBH,"Total Adjustment Amount")
 S FBH=$$CSV(FBH,"Fee Basis Invoice#")
 S FBH=$$CSV(FBH,"Batch Number")
 S FBH=$$CSV(FBH,"Obligation Number")
 S FBH=$$CSV(FBH,"Date Paid")
 S FBH=$$CSV(FBH,"Check Number")
 S FBH=$$CSV(FBH,"Total Amount Disbursed")
 W FBH
 Q
 ;
CSV(STRING,DATA) ; build the Excel data string for CSV format
 S DATA=$C(34)_$TR(DATA,$C(34),$C(39))_$C(34)
 S STRING=$S(STRING="":DATA,1:STRING_","_DATA)
 Q STRING
 ;
ITSTR(FBIATYPE) ; convert array of selected invoice types into a string for the report header
 ;
 N ITSTR,ITX,TXT
 S ITSTR=""
 I $D(FBIATYPE("OUT")),$D(FBIATYPE("RX")),$D(FBIATYPE("INP")),$D(FBIATYPE("ANC")) S ITSTR="ALL" G ITSTRX
 ;
 F ITX="OUT","RX","INP","ANC" I $D(FBIATYPE(ITX)) D
 . S TXT=$S(ITX="OUT":"Outpatient",ITX="RX":"Pharmacy",ITX="INP":"Civil Hospital",ITX="ANC":"Civil Hospital Ancillary",1:"")
 . S ITSTR=$S(ITSTR="":TXT,1:ITSTR_", "_TXT)
 . Q
ITSTRX ;
 Q ITSTR
 ;
COMPRX ; compile Pharmacy data (moved to this routine for space reasons)
 ;
 N BCH,DATA,FBDODINV,FBDT,FBIA,FBINVN,FBJ,FBK,FBRXINV,FBVEN,FBVENAME,FBVENID,FBY0,FBY2,FBY6,FBYREJ
 ; loop thru batch file by date finalized for specified date range
 S FBDT=$O(^FBAA(161.7,"AF",FBIABEG),-1)
 F  S FBDT=$O(^FBAA(161.7,"AF",FBDT)) Q:'FBDT!(FBDT>FBIAEND)  D
 . S BCH=0 F  S BCH=$O(^FBAA(161.7,"AF",FBDT,BCH)) Q:'BCH  D
 .. ;
 .. ; loop thru the pharmacy (B5) payments for a batch
 .. S FBJ=0 F  S FBJ=$O(^FBAA(162.1,"AE",BCH,FBJ)) Q:'FBJ  D
 ... S FBRXINV=$G(^FBAA(162.1,FBJ,0))   ; rx invoice level data
 ... S FBVEN=+$P(FBRXINV,U,4)   ; vendor ien
 ... I '$D(FBIAVEN(FBVEN)) Q    ; vendor is not among the selected vendors for report
 ... S FBIA=+$P(FBRXINV,U,23)   ; ipac ptr
 ... I 'FBIA Q                  ; ipac ptr must exist to be included on this report
 ... S FBINVN=$P(FBRXINV,U,1)   ; Rx invoice#
 ... S FBVENAME=$P($G(^FBAAV(FBVEN,0)),U,1)     ; vendor name
 ... S FBVENID=$P($G(^FBAAV(FBVEN,0)),U,2)      ; vendor external ID
 ... ;
 ... S FBK=0 F  S FBK=$O(^FBAA(162.1,"AE",BCH,FBJ,FBK)) Q:'FBK  D
 .... S FBY0=$G(^FBAA(162.1,FBJ,"RX",FBK,0))
 .... S FBY2=$G(^FBAA(162.1,FBJ,"RX",FBK,2))
 .... S FBY6=$G(^FBAA(162.1,FBJ,"RX",FBK,6))
 .... S FBYREJ=$G(^FBAA(162.1,FBJ,"RX",FBK,"FBREJ"))
 .... S FBDODINV=$P(FBY6,U,1) I FBDODINV="" Q          ; DoD invoice# must be present
 .... I $D(^TMP("FBAAIAR",$J,FBVENAME,FBDODINV)) Q     ; DoD invoice# data already exists
 .... I $P(FBY2,U,11) Q                                ; cancelled
 .... I $P(FBY2,U,3)'="" Q                             ; voided
 .... I $P(FBYREJ,U,1)'="" Q                           ; rejected
 .... ;
 .... S DATA=FBVEN_U_FBVENID_U_FBDT
 .... S $P(DATA,U,7)=FBINVN                            ; fee invoice number
 .... S $P(DATA,U,9)=$P($G(^FBAA(161.7,BCH,0)),U,1)    ; external batch#
 .... S $P(DATA,U,11)=$P($G(^FBAA(161.7,BCH,0)),U,2)   ; obligation# from the batch file
 .... S $P(DATA,U,13)=$P(FBY2,U,8)                     ; Date Paid
 .... S $P(DATA,U,16)=$P(FBY2,U,10)                    ; check number
 .... S ^TMP("FBAAIAR",$J,FBVENAME,FBDODINV)=DATA      ; store new data for this DoD invoice#
 .... D GET^FBAAIAR(FBVENAME,FBDODINV)                 ; gather totals for DoD invoice#
 .... Q
 ... Q
 .. Q
 . Q
COMPRXX ;
 Q
 ;

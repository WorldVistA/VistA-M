FBAAIAR2 ;ALB/FA - Fee IPAC Vendor DoD Invoice Inquiry Report Print ;1/16/2014
 ;;3.5;FEE BASIS;**123**;JAN 30, 1995;Build 51
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Scratch global built by FBAAIAR.
 ; Type  - 'O'utpatient,'I'npatient,Inpatient 'A'ncillary, 'P'harmacy
 ; XX    - Unique identifier to allow for multiple Outpatient/Ancillary payments on the
 ;         same invoice. 0 for Inpatient or Pharmacy
 ; ^TMP("FBAAIAR1",$J, Vendor Name,Type,VistA Invoice#) = A1^A2^A3^...^A5 Where:
 ;         A1 - Type of Record (Cancelled, Void, Reject, Purge, "", or some combination)
 ;         A2 - Date Paid  (Fileman format)
 ;         A3 - Total amount claimed
 ;         A4 - Total amount paid
 ;         A5 - Total adjustment amount
 ; ^TMP("FBAAIAR1",$J,Vendor Name) = A1^A2^...^A4 Where:
 ;         A1 - Total amount claimed for DoD Invoice Vendor
 ;         A2 - Total amount paid for DoD Invoice Vendor
 ;         A3 - Total adjustment amount DoD Invoice Vendor
 ;         A4 - Total number of invoices for the DoD Invoice Vendor
 ; ^TMP("FBAAIAR1",$J,Vendor Name, Type) = A1^A2^...^A4 Where:
 ;         A1 - Total amount claimed for DoD Invoice Vendor by type
 ;         A2 - Total amount paid for DoD Invoice Vendor by type
 ;         A3 - Total adjustment amount DoD Invoice Vendor by type
 ;         A4 - Total number of invoices for the DoD Invoice Vendor by type
 ;
 ;-----------------------------------------------------------------------------
 ;                           Entry Points
 ; PRINT  - DoD Invoice Inquiry Report - PRINT report
 ;-----------------------------------------------------------------------------
 ;
 Q
 ;
PRINT(FBDODINV,FBFORMAT)    ;EP
 ; Entry point for printing the report
 ; Input:       FBDODINV            - Selected DoD Invoice number
 ;              FBFORMAT            - 1 - CSV format, 0 otherwise
 ;              ZTQUEUE             - Defined if report was queued
 ;                                    undefined otherwise
 ;              ZSTOP               - Defined and 1 if compilation was stopped
 ;                                    0 or undefined otherwise
 ;              ^TMP("FBAAIAR1",$J) - Described in full above
 ; Output:      Report is printed
 ; Called From: COMPILE@FBAAIAR1
 ;
 N CRT,DIR,DIROUT,DIRUT,DTOUT,DUOUT,INVDOD,FBIASTOP,IDATA,ITYPE,INVNUM
 N LVNAME,PAGE,SEPLINE,VNAME,X,XX,Y
 S LVNAME="",VNAME=""
 S CRT=$S(IOST["C-":1,1:0)                      ; 1 - Print to Screen, 0 - Otherwise
 S:FBFORMAT IOSL=999999                         ; Long screen length for Excel output
 S PAGE=0,FBIASTOP=0,$P(SEPLINE,"-",81)=""
 I '$D(^TMP("FBAAIAR1",$J)) D  Q                ; No data was compiled
 . D HDR(FBDODINV,VNAME,CRT,.PAGE,.FBIASTOP)
 . W !!?5,"No data found for this report."
 . I CRT,'$D(ZTQUEUED) D
 . . S DIR(0)="E"
 . . D ^DIR
 ;
 I $G(ZTSTOP) D  Q                              ; Compilation was halted
 . D HDR(FBDODINV,VNAME,CRT,.PAGE,.FBIASTOP)
 . W !!?5,"This report was halted during compilation by TaskManager Request."
 . I CRT,'$D(ZTQUEUED) D
 . . S DIR(0)="E"
 . . D ^DIR
 ;
 ; Gather headers for excel spreadsheet
 D:FBFORMAT HDR(FBDODINV,"",CRT,.PAGE,.FBIASTOP)
 Q:FBIASTOP
 ;
 S VNAME=""
 F  D  Q:(VNAME="")!(FBIASTOP)
 . S VNAME=$O(^TMP("FBAAIAR1",$J,VNAME))
 . Q:VNAME=""
 . S LVNAME=VNAME
 . ;
 . ; Display header if not in CSV format
 . D:'FBFORMAT HDR(FBDODINV,VNAME,CRT,.PAGE,.FBIASTOP)
 . S ITYPE=""
 . F  D  Q:(ITYPE="")!(FBIASTOP)
 . . S ITYPE=$O(^TMP("FBAAIAR1",$J,VNAME,ITYPE))
 . . Q:(ITYPE="")!FBIASTOP
 . . S INVNUM=""
 . . F  D  Q:(INVNUM="")!(FBIASTOP)
 . . . S INVNUM=$O(^TMP("FBAAIAR1",$J,VNAME,ITYPE,INVNUM))
 . . . Q:(INVNUM="")!FBIASTOP
 . . . S XX=""
 . . . F  D  Q:(XX="")!(FBIASTOP)
 . . . . S XX=$O(^TMP("FBAAIAR1",$J,VNAME,ITYPE,INVNUM,XX))
 . . . . Q:XX=""
 . . . . S IDATA=$G(^TMP("FBAAIAR1",$J,VNAME,ITYPE,INVNUM,XX))
 . . . . ;
 . . . . ; Excel output - Print a CSV format record
 . . . . I FBFORMAT D EXCELN(ITYPE,INVNUM,IDATA) Q
 . . . . ;
 . . . . I $Y+4>IOSL,'FBFORMAT D  Q:FBIASTOP                      ; Page break check
 . . . . . D HDR(FBDODINV,VNAME,CRT,.PAGE,.FBIASTOP)
 . . . . W !,$$LJ^XLFSTR(INVNUM,22)                               ; VistA Invoice#
 . . . . W ?25,$$RJ^XLFSTR(ITYPE,4)                               ; Record Type
 . . . . W ?32,$P(IDATA,U,1)                                      ; C/V/R
 . . . . W ?40,$$LJ^XLFSTR($$FMTE^XLFDT($P(IDATA,U,2),"2DZ"),10)  ; Paid Date
 . . . . W ?50,$$RJ^XLFSTR("$"_$FN($P(IDATA,U,3),"",0),8)         ; Amount Claimed
 . . . . W ?60,$$RJ^XLFSTR("$"_$FN($P(IDATA,U,4),"",0),8)         ; Amount Paid
 . . . . W ?70,$$RJ^XLFSTR("$"_$FN($P(IDATA,U,5),"",0),8)         ; Adjustment Amount
 . . ;
 . . Q:FBIASTOP
 . . D:'FBFORMAT TYPETOT(FBDODINV,VNAME,FBFORMAT,ITYPE,.PAGE,.FBIASTOP) ; Totals by record type
 . ;
 . Q:FBIASTOP
 . D:'FBFORMAT VTOT(FBDODINV,VNAME,FBFORMAT,.PAGE,.FBIASTOP)    ; Totals by DoD Invoice
 Q:FBIASTOP
 ;
 I $Y+1>IOSL,'FBFORMAT D  Q:FBIASTOP                            ; Page break check
 . D HDR(FBDODINV,LVNAME,CRT,.PAGE,.FBIASTOP)
 W !!?5,"*** End of Report ***"
 ;
 I CRT,'$D(ZTQUEUED) D
 . S DIR(0)="E"
 . D ^DIR
 Q
 ;
VTOT(FBDODINV,VNAME,FBFORMAT,PAGE,FBIASTOP) ; Print the totals by Dod Invoice Vendor
 ; Input:       FBDODINV            - DoD Invoice report was compiled for
 ;              VNAME               - Name of the 
 ;              FBFORMAT            - 0 - CSV format (for Excel), 0 otherwise
 ;              PAGE                - Current page number
 ;              FBIASTOP            - Stop flag
 ;              ^TMP("FBAAIAR1",$J) - Compiled report data
 ; Output:      FBIASTOP            - 1 - user stopped printing, 0 otherwise
 ;              DoD Invoice Type Totals are printed
 ; Called From: PRINT
 N IDATA
 I $Y+5>IOSL,'FBFORMAT D  Q:FBIASTOP                ; Page break check
 . D HDR(FBDODINV,VNAME,CRT,.PAGE,.FBIASTOP)
 S IDATA=^TMP("FBAAIAR1",$J,VNAME)                  ; DoD Invoice Type Totals
 W !?1,"$Totals for Vendor: ",VNAME
 W !,"---------",?50,"--------  --------  --------"
 W !,"# ",$$RJ^XLFSTR($P(IDATA,U,4),7)              ; Total Number of Invoices
 W ?50,$$RJ^XLFSTR("$"_$FN($P(IDATA,U,1),"",0),8)   ; Total Amount Claimed
 W ?60,$$RJ^XLFSTR("$"_$FN($P(IDATA,U,2),"",0),8)   ; Total Amount Paid
 W ?70,$$RJ^XLFSTR("$"_$FN($P(IDATA,U,3),"",0),8)   ; Total Adjustment Amount
 Q
 ;
TYPETOT(FBDODINV,VNAME,FBFORMAT,ITYPE,PAGE,FBIASTOP) ; Print the totals by Invoice type
 ; Input:       FBDODINV            - DoD Invoice report was compiled for
 ;              VNAME               - Name of the 
 ;              FBFORMAT            - 0 - CSV format (for Excel), 0 otherwise
 ;              ITYPE               - Invoice Type to print totals for
 ;              PAGE                - Current page number
 ;              IASTOP              - Stop flag
 ;              ^TMP($J,"FBAAIAR1") - Compiled report data
 ; Output:      IASTOP              - 1 - user stopped printing, 0 otherwise
 ;              Invoice Type Totals are printed
 ; Called From: PRINT
 N ETYPE,IDATA
 I $Y+5>IOSL,'FBFORMAT D  Q:FBIASTOP                ; Page break check
 . D HDR(FBDODINV,CRT,.PAGE,.FBIASTOP)
 S ETYPE=$S(ITYPE="ANC":"Inpatient Ancillary",ITYPE="INP":"Inpatient",ITYPE="OUT":"Outpatient",1:"Pharmacy")
 S IDATA=^TMP("FBAAIAR1",$J,VNAME,ITYPE)            ; Invoice Type Totals
 W !?1,"$Totals for DoD Invoice # by Type: ",ETYPE
 W !?25,"----  ",?50,"--------  --------  --------"
 W !?20,"Tot# ",$$RJ^XLFSTR($P(IDATA,U,4),4)        ; Total Number of Invoices by Type
 W ?50,$$RJ^XLFSTR("$"_$FN($P(IDATA,U,1),"",0),8)   ; Total Amount Claimed
 W ?60,$$RJ^XLFSTR("$"_$FN($P(IDATA,U,2),"",0),8)   ; Total Amount Paid
 W ?70,$$RJ^XLFSTR("$"_$FN($P(IDATA,U,3),"",0),8)   ; Total Adjustment Amount
 W !
 Q
 ;
EXCELN(ITYPE,INVNUM,DATA) ; Output one Excel line
 ; Input:       ITYPE       - Invoice record type
 ;              INVNUM      - VistA Invoice number
 ;              DATA        - Invoice data
 ; Output:      One line of invoice data is output in excel format
 ; Called From: PRINT
 N FBZ
 S FBZ=$$CSV("",INVNUM)                             ; VistA Invoice Number
 S FBZ=$$CSV(FBZ,ITYPE)                             ; Invoice Record Type
 S FBZ=$$CSV(FBZ,$P(DATA,U,1))                      ; C/V/R
 S FBZ=$$CSV(FBZ,$$FMTE^XLFDT($P(DATA,U,2),"2DZ"))  ; Date Paid
 S FBZ=$$CSV(FBZ,$FN($P(DATA,U,3),"",0))            ; Amount Claimed
 S FBZ=$$CSV(FBZ,$FN($P(DATA,U,4),"",0))            ; Amount Paid
 S FBZ=$$CSV(FBZ,$FN($P(DATA,U,5),"",0))            ; Adjustment Amount
 W !,FBZ
 Q
 ;
HDR(FBDODINV,VNAME,CRT,PAGE,IASTOP)  ; Print the Report Header
 ; Input:       FBDODINV    - DoD Invoice Number
 ;              VNAME       - Name of the Vendor associated with the DoD Invoice
 ;              CRT         - 1 - Print to screen, 0 otherwise
 ;              PAGE        - Current page count
 ;              IASTOP      - Stop flag
 ;              ZTQUEUED    - Defined if report was queued
 ;                            undefined otherwise
 ; Output:      PAGE        - Updated page count
 ;              IASTOP      - 1 - user stopped printing, 0 otherwise
 ;              ZSTOP       - Defined and 1 if a task manager stop was received
 ;                            0 or undefined otherwise
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,VENID,X,Y,Z
 ;
 ; Do an end of page reader call if page# exists and device is the screen
 I PAGE,CRT D  Q:FBIASTOP
 . S DIR(0)="E"
 . D ^DIR K DIR
 . S:'Y FBIASTOP=1
 ;
 ; If screen output or page# exists, do a form feed and left margin reset
 I PAGE!CRT D
 . W @IOF,$C(13)
 ;
 S PAGE=PAGE+1                                  ; Increment Page #
 ;
 ; For Excel CSV format, display the column headers only
 I FBFORMAT D EXCELHD Q
 ;
 ; Display the report headers
 W ?20,"IPAC Vendor DoD Invoice Inquiry Report"
 W !,?1,"For DoD Invoice # ",FBDODINV
 W ?48,$$FMTE^XLFDT($$NOW^XLFDT),?71,"Page: ",PAGE
 W !,?1,"For Vendor:       ",VNAME
 ;
 ; Display the column headers
 W !?42,"Date",?52,"Amount",?63,"Amount",?72,"Amount"
 W !,"Invoice #",?25,"Type",?31,"C/V/R",?42,"Paid",?52,"Claimed",?63,"Paid",?72,"Adjusted"
 W !,SEPLINE
 ;
 ; Check for a TaskManager stop request
 I $D(ZTQUEUED),$$S^%ZTLOAD() D  Q
 . S (ZTSTOP,FBIASTOP)=1
 . W !!!?5,"*** Report Halted by TaskManager Request ***"
 Q
 ;
EXCELHD ; Print an Excel CSV header record 
 ; (only 1 Excel CSV header should print for the entire report)
 ; Input:       None
 ; Output:      Header line printed for CSV format (excel)
 ; Called From:
 N FBH
 S FBH=$$CSV("","VistA Invoice#")
 S FBH=$$CSV(FBH,"Type")
 S FBH=$$CSV(FBH,"C/V/R")
 S FBH=$$CSV(FBH,"Date Paid")
 S FBH=$$CSV(FBH,"Amount Claimed")
 S FBH=$$CSV(FBH,"Amount Paid")
 S FBH=$$CSV(FBH,"Adjustment Amount")
 W FBH
 Q
 ;
CSV(STRING,DATA) ; Build the Excel data string for CSV format
 ; Input:       STRING      - Current string being built or ""
 ;              DATA        - New data to be added to the string
 ; Returns:     STRING      - Updated string with DATA added
 ; Called From: EXCELHD,EXCELN
 S DATA=$C(34)_$TR(DATA,$C(34),$C(39))_$C(34)
 S STRING=$S(STRING="":DATA,1:STRING_","_DATA)
 Q STRING
 ;

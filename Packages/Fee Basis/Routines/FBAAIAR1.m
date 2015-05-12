FBAAIAR1  ;ALB/FA - FEE IPAC Vendor DoD Invoice Number Inquiry Report ;1/16/2014
 ;;3.5;FEE BASIS;**123**;JAN 30, 1995;Build 51
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;
 ;-----------------------------------------------------------------------------
 ;                           Entry Points
 ; EN  - DoD Invoice Inquiry Report - Run report
 ;-----------------------------------------------------------------------------
 ;
 Q
 ;
EN ;EP
 ; Main report entry point
 N FBDODINV,FBFORMAT
 Q:'$$DODISEL(.FBDODINV)                        ; Select DoD Invoice number
 Q:'$$FORMAT(.FBFORMAT)                         ; Select Report Format
 Q:$$DEVICE(FBDODINV,FBFORMAT)                  ; Select Device and compile report
 Q
 ;
DODISEL(FBDODINV) ; Ask for the DoD Invoice
 ; Input:       None
 ; Output:      FBDODINV    - Selected DoD Invoice Number
 ; Returns:     1 - User quit out, 0 otherwise
 ; Called From: EN
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,RET,X,Y
 S RET=1                                        ; Assume DoD Invoice Selection
 W @IOF,!,"IPAC Vendor DoD Invoice Number Inquiry Report"
 W !!,"This report will display all of the VistA invoices for the "
 W !,"selected DoD Invoice Number."
 W !
 S DIR(0)="F^3:22"
 S DIR("A")="DoD Invoice Number"
 S DIR("?",1)="All of the associated VistA invoices will be displayed for the"
 S DIR("?",2)="selected DoD invoice number"
 W ! D ^DIR K DIR
 I $D(DIRUT)!(Y="") D
 . S RET=0                                      ; User wants to exit
 . W *7
 S FBDODINV=Y                                   ; Selected DoD Invoice number
 Q RET
 ;
FORMAT(FBFORMAT) ; Capture the report format from the user (normal or CSV output)
 ; Input:       None
 ; Output:      FBFORMAT        - 1 - CSV Format, 0 otherwise
 ; Returns:     0 - User quit out, 1 otherwise
 ; Called From: EN
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,RET,X,Y
 S RET=1
 S DIR(0)="Y"
 S DIR("A")="Do you want to capture the output in a CSV format"
 S DIR("B")="NO"
 S DIR("?",1)="If you want to capture the output from this report in a comma-separated"
 S DIR("?",2)="values (CSV) format, then answer YES here.  A CSV format is something that"
 S DIR("?",3)="could be easily imported into a spreadsheet program like Excel."
 S DIR("?",4)=" "
 S DIR("?")="If you just want a normal report output, then answer NO here."
 W ! D ^DIR K DIR
 I $D(DIRUT) D
 . S RET=0                                      ; User wants to exit
 . W *7
 S FBFORMAT=Y
 Q RET
 ;
DEVICE(FBDODINV,FBFORMAT) ; Device Selection and Report compilation
 ; Input:       FBDODINV    - DoD invoice number to compile VistA invoices for
 ;              FBFORMAT    - 1 - CSV Format, 0 otherwise
 ; Output:      Report is compiled if a device is selected
 ; Returns:     1 - User quit out, 0 otherwise
 ; Called From: EN
 N DIR,POP,RET,X,Y,ZTDESC,ZTRTN,ZTSAVE,ZTSK
 S RET=1
 I 'FBFORMAT D
 . W !!,"This report is 80 characters wide.  Please choose an appropriate device.",!
 E  D
 . W !!,"For CSV output, turn logging or capture on now."
 . W !,"To avoid undesired wrapping of the data saved to the file,"
 . W !,"please enter ""0;256;99999"" at the ""DEVICE:"" prompt.",!
 ;
 S ZTRTN="COMPILE^FBAAIAR1"
 S ZTDESC="Fee Basis IPAC Vendor DoD Invoice Inquiry Report"
 S ZTSAVE("FBDODINV")=""
 S ZTSAVE("FBFORMAT")=""
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE,"QM",1)
 S:POP RET=0
 I $G(ZTSK) D
 . W !!,"Report compilation has started with task# ",ZTSK,".",!
 . S DIR(0)="E"
 . D ^DIR
 Q RET
 ;
COMPILE ; Entry point for the compile to build the scratch global
 ; may be background task if job queued
 ; Input:       FBDODINV    - DoD Invoice number to use for selection
 ;              FBFORMAT    - 1 - CSV format, 0 otherwise
 ; Output:      Report is compiled and output
 ; Called From: Report processing
 ;
 K ^TMP("FBAAIAR1",$J)
 I '$D(ZTQUEUED) W !!,"Compiling IPAC Vendor DoD Invoice Inquiry Report.  Please wait ... "
 D COMPOUT(FBDODINV)                            ; Compile Outpatient invoices       
 D COMPIN(FBDODINV)                             ; Compile Inpatient invoices
 D COMPRX(FBDODINV)                             ; Compile Pharmacy invoices
 ;
 D PRINT^FBAAIAR2(FBDODINV,FBFORMAT)            ; Print report
 D ^%ZISC                                       ; Close the device
 K ^TMP("FBAAIAR1",$J)                          ; Kill scratch global
 S:$D(ZTQUEUED) ZTREQ="@"                       ; Purge the task
 Q
 ;
COMPOUT(FBDODINV)  ; Compile Outpatient and Inpatient Ancillary Invoice data
 ; Input:       FBDODINV    - DoD Invoice number to use for selection
 ; Output:      VistA invoices for the selected DoD invoice number are
 ;              added to the temporary global
 ; Called From: COMPILE
 ;
 N DATA,IDTIEN,PATIEN,SVCIEN,VENIEN,VNAME
 S PATIEN=""
 F  D  Q:PATIEN=""                              ; Patient IEN
 . S PATIEN=$O(^FBAAC("DODI",FBDODINV,PATIEN))
 . Q:PATIEN=""
 . S VENIEN=""
 . F  D  Q:VENIEN=""                            ; Vendor IEN
 . . S VENIEN=$O(^FBAAC("DODI",FBDODINV,PATIEN,VENIEN))
 . . Q:VENIEN=""
 . . S VNAME=$P($G(^FBAAV(VENIEN,0)),U,1)       ; Vendor Name
 . . S IDTIEN=""
 . . F  D  Q:IDTIEN=""                          ; Initial Service Date IEN
 . . . S IDTIEN=$O(^FBAAC("DODI",FBDODINV,PATIEN,VENIEN,IDTIEN))
 . . . Q:IDTIEN=""
 . . . S SVCIEN=""
 . . . F  D  Q:SVCIEN=""                        ; Service Provided IEN
 . . . . S SVCIEN=$O(^FBAAC("DODI",FBDODINV,PATIEN,VENIEN,IDTIEN,SVCIEN))
 . . . . Q:SVCIEN=""
 . . . . ;
 . . . . ; Store the row data for the invoice into the temporary global
 . . . . D ROWDATAO(VNAME,PATIEN,VENIEN,IDTIEN,SVCIEN)
 Q
 ;
ROWDATAO(VNAME,PATIEN,VENIEN,IDTIEN,SVCIEN)   ;
 ; Retrieves the information needed to display the VistA invoice row for an
 ; outpatient invoice or an Inpatient Ancillary invoice.
 ; Input:       VNAME                   - Vendor Name of the Invoice
 ;              PATIEN                  - Patient IEN
 ;              VENIEN                  - Vendor IEN of the invoice
 ;              IDTIEN                  - Internal Initial Treatment Date IEN
 ;              SVCIEN                  - Invoice IEN        
 ;              ^TMP("FAAIAR1",$J)      - Current temporary file
 ; Output:      ^TMP("FAAIAR1",$J)      - Updated with VistA Invoice data
 ; Called From: COMPOUT
 ;
 N DATA,INV0,INV2,INV3,INVNUM,TYPE,XX
 S INV0=$G(^FBAAC(PATIEN,1,VENIEN,1,IDTIEN,1,SVCIEN,0)) ; Outpatient Invoice 0 Node
 S INV2=$G(^FBAAC(PATIEN,1,VENIEN,1,IDTIEN,1,SVCIEN,2)) ; Outpatient Invoice 2 Node
 S INV3=$G(^FBAAC(PATIEN,1,VENIEN,1,IDTIEN,1,SVCIEN,3)) ; Outpatient Invoice 3 Node
 S INVNUM=$P(INV0,U,16)                                 ; VistA Invoice #
 S ITYPE=+$P(INV0,U,9)                                  ; Fee Program ptr
 S ITYPE=$S(ITYPE=2:0,1:1)                              ; 0 - Outpatient, 1: Inpatient Ancillary
 S TYPE=$S('ITYPE:"OUT",1:"ANC")
 S DATA=$$GETTYPEO(PATIEN,VENIEN,IDTIEN,SVCIEN,INV0,INV2) ; Void/Purge/Cancel flags
 S $P(DATA,U,2)=$P(INV0,U,14)                           ; Date Paid
 S $P(DATA,U,3)=$P(INV0,U,2)                            ; Amount Claimed
 S $P(DATA,U,4)=$P(INV0,U,3)                            ; Amount Paid
 S $P(DATA,U,5)=$P(INV0,U,4)                            ; Amount Adjusted
 S XX=IDTIEN_"-"_SVCIEN
 S ^TMP("FBAAIAR1",$J,VNAME,TYPE,INVNUM,XX)=DATA         ; VistA invoice data for the invoice
 D TOTS(VNAME,TYPE,INVNUM,DATA)                         ; Gather totals for invoice
 Q
 ;
GETTYPEO(PATIEN,VENIEN,IDTIEN,SVCIEN,INV0,INV2) ; Determines if the invoice has been
 ; cancelled, rejected, purged or voided or some combination
 ; Input:       PATIEN  - Patient IEN
 ;              VENIEN  - Vendor IEN
 ;              IDTIEN  - Initial Treatment Date IEN
 ;              SVCIEN  - Service Provided IEN
 ;              INV0    - 0 node of the outpatient invoice
 ;              INV2    - 2 node of the outpatient invoice
 ; Returns:     V       - Voided
 ;              C       - Cancelled
 ;              R       - Rejected
 ;              P       - Purged
 ;              ""      - Otherwise
 ;              or any combination of C/V/R/P
 ; Called From: ROWDATAO
 N VAL
 S VAL=""
 S:$D(^FBAAC(PATIEN,1,VENIEN,1,IDTIEN,1,SVCIEN,"FBREJC")) VAL="R"    ; Rejected
 S:$D(^FBAAC(PATIEN,"PURGE",VENIEN,0)) VAL=VAL_"P"      ; Purged
 S:$P(INV2,U,4)'="" VAL=VAL_"C"                         ; Cancelled
 S:$P(INV0,U,21)'="" VAL=VAL_"V"                        ; Voided
 Q VAL
 ;
COMPIN(FBDODINV)    ; Compile Inpatient Invoice data
 ; Input:       FBDODINV                - DoD Invoice number to use for selection
 ;              ^TMP("FAAIAR1",$J)      - Current temporary file
 ; Output:      ^TMP("FAAIAR1",$J)      - Updated with VistA Invoice data
 ; Called From: COMPILE
 ;
 N DATA,INIEN,INVNUM,INV0,INV2,INV5,ITYPE,VNAME,XX
 S INIEN=""
 F  D  Q:INIEN=""                                       ; Inpatient Invoice by DoD Invoice #
 . S INIEN=$O(^FBAAI("DODI",FBDODINV,INIEN))
 . Q:INIEN=""
 . S INV0=$G(^FBAAI(INIEN,0))
 . S INV2=$G(^FBAAI(INIEN,2))
 . S INV5=$G(^FBAAI(INIEN,5))
 . S XX=+$P(INV0,U,3)                                   ; Vendor IEN
 . S VNAME=$P($G(^FBAAV(XX,0)),U,1)                     ; Vendor Name
 . S INVNUM=$P(INV0,U,1)                                ; VistA Invoice #
 . S DATA=$$GETTYPEI(INIEN,INV0,INV2)                   ; Type of Record
 . S $P(DATA,U,2)=$P(INV2,U,1)                          ; Date Paid
 . S $P(DATA,U,3)=$P(INV0,U,8)                          ; Amount Claimed
 . S $P(DATA,U,4)=$P(INV0,U,9)                          ; Amount Paid
 . S $P(DATA,U,5)=$P(INV0,U,10)                         ; Amount Adjusted
 . S ^TMP("FBAAIAR1",$J,VNAME,"INP",INVNUM,0)=DATA      ; VistA invoice data for invoice
 . D TOTS(VNAME,"INP",INVNUM,DATA)                      ; Gather totals for invoice
 Q
 ;
GETTYPEI(INVIEN,INV0,INV2) ; Determines if the inpatient invoice has been
 ; cancelled, rejected or voided or some combination
 ; Input:       INVIEN  - IEN of the inpatient invoice
 ;              INV0    - 0 node of the inpatient invoice
 ;              INV2    - 2 node of the inpatient invoice
 ;              INV5    - 5 node of the inpatient invoice
 ; Returns:     V       - Voided
 ;              C       - Cancelled
 ;              R       - Rejected
 ;              ""      - Otherwise
 ;              or any combination of C/V/R
 ; Called From: COMPIN
 N VAL
 S VAL=""
 S:$D(^FBAAI(INVIEN,"FBREJ")) VAL="R"                   ; Rejected
 S:$P(INV2,U,5)'="" VAL=VAL_"C"                         ; Cancelled
 S:$P(INV0,U,14)'="" VAL=VAL_"V"                        ; Voided
 Q VAL
 ;
COMPRX(FBDODINV)    ; Compile Pharmacy invoice data
 ; Input:       FBDODINV                - DoD Invoice number to use for selection
 ;              ^TMP("FAAIAR1",$J)      - Current temporary file
 ; Output:      ^TMP("FAAIAR1",$J)      - Updated with VistA Invoice data
 ; Called From: COMPILE
 ;
 N AMTA,AMTC,AMTP,DATA,DATEP,INVNUM,INV0,INV2,ITYPE,ITYPE2
 N PHIEN,RXIEN,RXINV,VNAME,XX
 S PHIEN="",DATEP="",ITYPE2=""
 F  D  Q:PHIEN=""                                       ; Pharmacy Invoice by DoD Invoice #
 . S PHIEN=$O(^FBAA(162.1,"DODI",FBDODINV,PHIEN))
 . Q:PHIEN=""
 . S (AMTA,AMTC,AMTP)=0                                 ; Init amount tots for invoice
 . S RXINV=$G(^FBAA(162.1,PHIEN,0))                     ; Invoice level data
 . S XX=+$P(RXINV,U,4)                                  ; Vendor IEN
 . S VNAME=$P($G(^FBAAV(XX,0)),U,1)                     ; Vendor name
 . S INVNUM=$P(RXINV,U,1)                               ; VistA Invoice #
 . S RXIEN=""
 . F  D  Q:RXIEN=""                                     ; Prescription level
 . . S RXIEN=$O(^FBAA(162.1,"DODI",FBDODINV,PHIEN,RXIEN))
 . . Q:RXIEN=""
 . . S INV0=$G(^FBAA(162.1,PHIEN,"RX",RXIEN,0))         ; Prescription 0 Node
 . . S INV2=$G(^FBAA(162.1,PHIEN,"RX",RXIEN,2))         ; Prescription 2 Node
 . . D GETTYPEP(PHIEN,RXIEN,INV2,.ITYPE2)               ; Type of Pharmacy Record
 . . S XX=$P(INV2,U,8)                                  ; Date Paid
 . . S DATEP=$S(DATEP="":XX,XX<DATEP:XX,1:DATEP)        ; Find the lowest date paid
 . . S AMTC=AMTC+$P(INV0,U,4)                           ; Amount Claimed
 . . S AMTP=AMTP+$P(INV0,U,16)                          ; Amount Paid
 . . S AMTA=AMTA+$P(INV0,U,7)                           ; Amount Adjusted
 . S DATA=ITYPE2                                        ; Pharmacy Invoice Void/Cancel/Reject
 . S $P(DATA,U,2)=DATEP                                 ; Lowest date paid
 . S $P(DATA,U,3)=AMTC                                  ; Total Amount claimed for Invoice
 . S $P(DATA,U,4)=AMTP                                  ; Total Amount paid for Invoice
 . S $P(DATA,U,5)=AMTA                                  ; Total Amount adjusted for Invoice
 . S ^TMP("FBAAIAR1",$J,VNAME,"RX",INVNUM,0)=DATA       ; VistA invoice data for invoice
 . D TOTS(VNAME,"RX",INVNUM,DATA)                       ; Gather totals for DoD invoice#
 Q
 ;
GETTYPEP(PHIEN,RXIEN,INV2,ITYPE) ; Determines if the pharmacy invoice has any
 ; cancelled, rejected or voided prescriptions.
 ; Input:       PHIEN   - IEN of the pharmacy invoice
 ;              RXIEN   - Prescription IEN
 ;              INV2    - 2 node of the pharmacy prescription invoice
 ;              ITYPE   - Current value for the pharmacy invoice
 ; Output:      ITYPE   - Updated value for the pharmacy invoice
 ; Called From: COMPRX
 I $D(^FBAA(162.1,PHIEN,"RX",RXIEN,"FBREJ")) D          ; Rejected
 . S ITYPE=$S(ITYPE'["R":ITYPE_"R",1:ITYPE)
 I $P(INV2,U,11)'="" D  Q                               ; Cancelled
 . S ITYPE=$S(ITYPE'["C":ITYPE_"C",1:ITYPE)
 I $P(INV2,U,3)'="" D  Q                                ; Voided
 . S ITYPE=$S(ITYPE'["V":ITYPE_"V",1:ITYPE)
 Q
 ;
TOTS(VNAME,TYPE,INVNUM,DATA) ; Gather totals and other data for all invoices for
 ; the specified DoD invoice#. Update the scratch global with information
 ; Input:       VNAME                               - Vendor Name
 ;              TYPE                                - "OUT" - Outpatient Invoice
 ;                                                    "ANC" - Inpatient Ancillary Invoice
 ;                                                    "INP" - Inpatient Invoice
 ;                                                    "RX"  - Pharmacy Invoice
 ;              INVNUM                              - VistA Invoice Number
 ;              DATA                                - ^TMP("FBAAIAR1",$J,VNAME,TYPE,INVNUM)
 ;              ^TMP("FBAAIAR1",$J,VNAME)           - Current DoD Invoice Vendor totals
 ;              ^TMP("FBAAIAR1",$J,VNAME,TYPE)      - Current Type totals
 ; Output:      ^TMP("FBAAIAR1",$J,VNAME)           - Updated DoD Invoice Vendor totals
 ;              ^TMP("FBAAIAR1",$J,VNAME,TYPE)      - Updated Type totals
 ; Called From: COMPIN, COMPOUT, COMPRX
 ;
 N CURTOT
 S CURTOT=$G(^TMP("FBAAIAR1",$J,VNAME))                 ; Current DoD Invoice Vendor totals
 S $P(CURTOT,U,1)=$P(DATA,U,3)+$P(CURTOT,U,1)           ; New Claimed Total
 S $P(CURTOT,U,2)=$P(DATA,U,4)+$P(CURTOT,U,2)           ; New Paid Total
 S $P(CURTOT,U,3)=$P(DATA,U,5)+$P(CURTOT,U,3)           ; New Adjustment Total
 S $P(CURTOT,U,4)=$P(CURTOT,U,4)+1                      ; New Invoice count
 S ^TMP("FBAAIAR1",$J,VNAME)=CURTOT
 S CURTOT=$G(^TMP("FBAAIAR1",$J,VNAME,TYPE))            ; Current DoD Invoice Vendor totals by type
 S $P(CURTOT,U,1)=$P(DATA,U,3)+$P(CURTOT,U,1)           ; New Claimed Total
 S $P(CURTOT,U,2)=$P(DATA,U,4)+$P(CURTOT,U,2)           ; New Paid Total
 S $P(CURTOT,U,3)=$P(DATA,U,5)+$P(CURTOT,U,3)           ; New Adjustment Total
 S $P(CURTOT,U,4)=$P(CURTOT,U,4)+1                      ; New Invoice count by type
 S ^TMP("FBAAIAR1",$J,VNAME,TYPE)=CURTOT
 Q
 ;

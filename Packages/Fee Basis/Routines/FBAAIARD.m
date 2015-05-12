FBAAIARD ;ALB/ESG - Fee IPAC Vendor Payment Report (Detail) Print ;2/17/2014
 ;;3.5;FEE BASIS;**123**;JAN 30, 1995;Build 51
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Scratch global built by FBAAIARB (Detail report)
 ;  ^TMP("FBAAIARB",$J,Vendor_Name,Payment_Type,DoD_Invoice#,Date_Of_Service,Pt_Name,IENS) = DATA
 ;
 Q
 ;
PRINT ; entry point for printing the report
 ; Variables assumed to exist from FBAAIARB:  FBIAVEN, FBIABEG, FBIAEND, FBIATYPE, FBIAEXCEL, FBIAADJ, FBIAIGNORE
 ;
 N CRT,DIR,DIROUT,DIRUT,DTOUT,DUOUT,FBDODINV,FBIASTOP,FBVENAME,FBZDOS,FBZIENS,FBZPTNM,FBZTYPE,ITSTR,PAGE,RPTG,SEPLINE,X,Y
 S CRT=$S(IOST["C-":1,1:0)
 I FBIAEXCEL S IOSL=999999     ; long screen length for Excel output
 S PAGE=0,FBIASTOP=0,$P(SEPLINE,"-",133)="",ITSTR=$$ITSTR^FBAAIARA(.FBIATYPE)
 ;
 I '$D(^TMP("FBAAIARB",$J)) D HDR W !!?5,"No data found for this report." G PX
 I $G(ZTSTOP) D HDR W !!?5,"This report was halted during compilation by TaskManager Request." G PX
 ;
 I FBIAEXCEL D HDR I FBIASTOP G PRINTX    ; for Excel CSV output, print the Header row first of all
 ;
 S FBVENAME="" F  S FBVENAME=$O(^TMP("FBAAIARB",$J,FBVENAME)) Q:FBVENAME=""!FBIASTOP  D
 . S FBZTYPE="" F  S FBZTYPE=$O(^TMP("FBAAIARB",$J,FBVENAME,FBZTYPE)) Q:FBZTYPE=""!FBIASTOP  D
 .. K RPTG
 .. I 'FBIAEXCEL D HDR Q:FBIASTOP   ; page break on type since the column headings change (n/a for Excel)
 .. ;
 .. S FBDODINV="" F  S FBDODINV=$O(^TMP("FBAAIARB",$J,FBVENAME,FBZTYPE,FBDODINV)) Q:FBDODINV=""!FBIASTOP  D
 ... S FBZDOS=0 F  S FBZDOS=$O(^TMP("FBAAIARB",$J,FBVENAME,FBZTYPE,FBDODINV,FBZDOS)) Q:'FBZDOS!FBIASTOP  D
 .... S FBZPTNM="" F  S FBZPTNM=$O(^TMP("FBAAIARB",$J,FBVENAME,FBZTYPE,FBDODINV,FBZDOS,FBZPTNM)) Q:FBZPTNM=""!FBIASTOP  D
 ..... S FBZIENS="" F  S FBZIENS=$O(^TMP("FBAAIARB",$J,FBVENAME,FBZTYPE,FBDODINV,FBZDOS,FBZPTNM,FBZIENS)) Q:FBZIENS=""!FBIASTOP  D
 ...... D RPTLN
 ...... Q
 ..... Q
 .... Q
 ... Q
 .. Q
 . Q
 ;
 I FBIASTOP G PRINTX      ; get out right away if stop flag is set
 ;
 I $Y+5>IOSL D HDR I FBIASTOP G PRINTX
 W !!?5,"*** End of Report ***"
 ;
PX ;
 I CRT,'$D(ZTQUEUED) S DIR(0)="E" D ^DIR K DIR
PRINTX ;
 Q
 ;
RPTLN ; display one payment line item detail
 S RPTG=$G(^TMP("FBAAIARB",$J,FBVENAME,FBZTYPE,FBDODINV,FBZDOS,FBZPTNM,FBZIENS))
 ;
 ; for Excel output, print a CSV line and get out
 I FBIAEXCEL D EXCELN(RPTG) Q
 ;
 I $Y+5>IOSL D HDR Q:FBIASTOP                                    ; check for page break
 W !,$$LJ^XLFSTR(FBDODINV,20)                                    ; DoD invoice#
 W ?21,$$LJ^XLFSTR(FBZPTNM,"16T")                                ; patient name
 W ?38,$E($P(RPTG,U,4),6,10)                                     ; patient ID - last4 (10th digit for "P"seudo SSN)
 W ?44,$$FMTE^XLFDT(FBZDOS,"2Z")                                 ; date of service
 ;
 I +FBZTYPE=1!(+FBZTYPE=4) W ?54,$P(RPTG,U,5),?61,$P(RPTG,U,7)   ; outpat/ancil procedure code/revenue code
 I +FBZTYPE=2,$P(RPTG,U,8) W ?54,$$FMTE^XLFDT($P(RPTG,U,8),"2Z") ; inpatient discharge date
 I +FBZTYPE=3 W ?54,$P(RPTG,U,12)                                ; pharmacy prescription number
 ;
 W ?64,$$RJ^XLFSTR($FN($P(RPTG,U,14),"",2),10)                   ; amount claimed
 W $$RJ^XLFSTR($FN($P(RPTG,U,15),"",2),10)                       ; amount paid
 W $$RJ^XLFSTR($FN($P(RPTG,U,16),"",2),10)                       ; amount adjusted #1
 W ?95,$E($P(RPTG,U,17),1,6)                                     ; adjustment group code-reason code #1
 W ?103,$$FMTE^XLFDT($P(RPTG,U,23),"2Z")                         ; date paid
 W ?113,$E($P(RPTG,U,24),1,8)                                    ; check number
 W ?122,$$RJ^XLFSTR($FN($P(RPTG,U,25),"",2),"10T")               ; disbursed amount
 ;
 ; line 2 data
 W !?3,$P(RPTG,U,20)                                             ; Fee invoice#
 W ?14,$P(RPTG,U,21)                                             ; batch#
 W ?21,$P(RPTG,U,22)                                             ; obligation#
 W ?29,$S($P(RPTG,U,27):"**VOIDED**",1:"")                       ; voided payment indicator
 ;
 I +FBZTYPE'=2,$P(RPTG,U,28)'="" W ?40,"**REJECTED**"            ; rejected payment indicator (not inpat)
 I +FBZTYPE=2 W ?46,$P(RPTG,U,10)                                ; inpatient admitting diagnosis code
 I +FBZTYPE=1!(+FBZTYPE=4) W ?54,$P(RPTG,U,6)                    ; outpat/ancil list of proc modifiers
 I +FBZTYPE=3 W ?54,$E($P(RPTG,U,13),1,29)                       ; pharmacy drug name
 I +FBZTYPE=2,$P(RPTG,U,28)'="" W ?61,"**REJECTED**"             ; rejected payment indicator (inpat)
 ;
 I $P(RPTG,U,18) W ?84,$$RJ^XLFSTR($FN($P(RPTG,U,18),"",2),10)   ; amount adjusted #2
 W ?95,$E($P(RPTG,U,19),1,6)                                     ; adjustment group code-reason code #2
 ;
 I $P(RPTG,U,26) W ?106,"**CANCELLED ",$$FMTE^XLFDT($P(RPTG,U,26),"2Z"),"**"
 ;
 I +FBZTYPE'=2 Q    ; no more data for anything except inpatient
 ;
 ; Inpatient display of up to 25 diagnosis/poa and 25 procedure codes
 I $P(RPTG,U,9)'="" D DIAGDISP($P(RPTG,U,9)) Q:FBIASTOP
 I $P(RPTG,U,11)'="" D PROCDISP($P(RPTG,U,11)) Q:FBIASTOP
 ;
RPTLNX ;
 Q
 ;
DIAGDISP(Z) ; For inpatient, display diagnosis codes and POA codes
 N DELIM,P,DXP
 I $Y+4>IOSL D HDR Q:FBIASTOP     ; check for page break
 S DELIM=", "
 W !?3,"DX(POA): "
 F P=1:1:$L(Z,DELIM) D
 . S DXP=$P(Z,DELIM,P) Q:DXP=""
 . I $X+$L(DXP)+4>IOM W !?12
 . W DXP
 . I $P(Z,DELIM,P+1)'="" W DELIM
 . Q
 Q
 ;
PROCDISP(Z) ; For inpatient, display procedure codes
 N DELIM,P,PRC
 I $Y+4>IOSL D HDR Q:FBIASTOP     ; check for page break
 S DELIM=", "
 W !?6,"PROC: "
 F P=1:1:$L(Z,DELIM) D
 . S PRC=$P(Z,DELIM,P) Q:PRC=""
 . I $X+$L(PRC)+4>IOM W !?12
 . W PRC
 . I $P(Z,DELIM,P+1)'="" W DELIM
 . Q
 Q
 ;
HDR ; report header
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,HTYP,VENID,X,Y
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
 S HTYP=$G(FBZTYPE)   ; current type being displayed on this page (may not exist)
 ;
 ; Display the report headers
 W "IPAC Vendor Payment Report"
 W ?44,"For Date Range ",$$FMTE^XLFDT(FBIABEG,"5DZ")," - ",$$FMTE^XLFDT(FBIAEND,"5DZ")
 W ?96,$$FMTE^XLFDT($$NOW^XLFDT),?120,"Page: ",PAGE
 W !?3,"Selected Invoice Types: ",ITSTR
 I FBIAADJ W ?102,"**Suspended Payments Only**"
 ;
 I $G(FBVENAME)'="" D
 . W !?3,"Vendor Name: ",FBVENAME
 . S VENID=$P($G(RPTG),U,2)
 . I VENID="" S VENID=$P($G(^TMP("FBAAIARB",$J,FBVENAME)),U,1)
 . I VENID'="" W "  (ID# ",VENID,")"
 . I HTYP="" Q
 . W ?81,"Invoice Type: "
 . I +HTYP=1!(+HTYP=4) W "Outpatient/Civil Hospital Ancillary"
 . I +HTYP=2 W "Civil Hospital Inpatient"
 . I +HTYP=3 W "Pharmacy"
 . Q
 ;
 ; now display the column headers
 W !,"DoD Invoice Number",?21,"Patient Name",?38,"SSN"
 I +HTYP=1!(+HTYP=4) W ?44,"Svc Dt    Proc   Rev"
 I +HTYP=2 W ?44,"Admit Dt  Disch Dt"
 I +HTYP=3 W ?44,"Fill Dt   Rx#"
 W ?66,"Claimed",?79,"Paid",?90,"Adj  Reason",?103,"Dt Paid",?113,"Check#",?123,"Disbursed"
 W !?3,"Fee Inv#",?14,"Bch#",?21,"Oblig#"
 I +HTYP=1!(+HTYP=4) W ?54,"Modifiers"
 I +HTYP=2 W ?46,"Adm Dx"
 I +HTYP=3 W ?54,"Drug Name"
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
 S FBH=$$CSV(FBH,"Payment Type")
 S FBH=$$CSV(FBH,"DoD Invoice#")
 S FBH=$$CSV(FBH,"Date of Service/Fill Date/Admit Date")
 S FBH=$$CSV(FBH,"Patient Name")
 S FBH=$$CSV(FBH,"Date Finalized")
 S FBH=$$CSV(FBH,"Patient SSN")
 S FBH=$$CSV(FBH,"CPT Procedure Code")
 S FBH=$$CSV(FBH,"CPT Procedure Modifiers")
 S FBH=$$CSV(FBH,"Revenue Code")
 S FBH=$$CSV(FBH,"Discharge Date")
 S FBH=$$CSV(FBH,"Diagnosis/POA Codes")
 S FBH=$$CSV(FBH,"Admitting Diagnosis")
 S FBH=$$CSV(FBH,"Procedure Codes Inpatient")
 S FBH=$$CSV(FBH,"Prescription#")
 S FBH=$$CSV(FBH,"Drug Name")
 S FBH=$$CSV(FBH,"Amount Claimed")
 S FBH=$$CSV(FBH,"Amount Paid")
 S FBH=$$CSV(FBH,"Adjustment Amount #1")
 S FBH=$$CSV(FBH,"Adjustment Reason #1")
 S FBH=$$CSV(FBH,"Adjustment Amount #2")
 S FBH=$$CSV(FBH,"Adjustment Reason #2")
 S FBH=$$CSV(FBH,"Fee Invoice#")
 S FBH=$$CSV(FBH,"Batch#")
 S FBH=$$CSV(FBH,"Obligation#")
 S FBH=$$CSV(FBH,"Date Paid")
 S FBH=$$CSV(FBH,"Check#")
 S FBH=$$CSV(FBH,"Disbursed Amount")
 S FBH=$$CSV(FBH,"Cancellation Date")
 S FBH=$$CSV(FBH,"Voided Payment Flag")
 S FBH=$$CSV(FBH,"Reject Status")
 W FBH
 Q
 ;
EXCELN(RPTG) ; write a line of CSV data
 N FBZ,X,Y
 S X=FBZTYPE
 S Y=$S(+X=1:"Outpatient",+X=2:"Inpatient",+X=3:"Pharmacy",1:"Ancillary")
 ;
 S FBZ=$$CSV("",FBVENAME)                           ; vendor name
 S FBZ=$$CSV(FBZ,$P(RPTG,U,2))                      ; vendor ID
 S FBZ=$$CSV(FBZ,Y)                                 ; invoice/payment type
 S FBZ=$$CSV(FBZ,FBDODINV)                          ; DoD invoice#
 S FBZ=$$CSV(FBZ,$$FMTE^XLFDT(FBZDOS,"2Z"))         ; date of service/fill date/admit date
 S FBZ=$$CSV(FBZ,FBZPTNM)                           ; pt name
 S FBZ=$$CSV(FBZ,$$FMTE^XLFDT($P(RPTG,U,3),"2Z"))   ; Date line item finalized within the date range of this report
 S FBZ=$$CSV(FBZ,$E($P(RPTG,U,4),6,10))             ; pt ssn last 4
 S FBZ=$$CSV(FBZ,$P(RPTG,U,5))                      ; cpt procedure code
 S FBZ=$$CSV(FBZ,$P(RPTG,U,6))                      ; CPT modifiers
 S FBZ=$$CSV(FBZ,$P(RPTG,U,7))                      ; revenue code
 S FBZ=$$CSV(FBZ,$$FMTE^XLFDT($P(RPTG,U,8),"2Z"))   ; discharge date
 S FBZ=$$CSV(FBZ,$P(RPTG,U,9))                      ; list of Diag/poa codes
 S FBZ=$$CSV(FBZ,$P(RPTG,U,10))                     ; admitting dx
 S FBZ=$$CSV(FBZ,$P(RPTG,U,11))                     ; list of inpatient procedure codes
 S FBZ=$$CSV(FBZ,$P(RPTG,U,12))                     ; prescription#
 S FBZ=$$CSV(FBZ,$P(RPTG,U,13))                     ; drug name
 S FBZ=$$CSV(FBZ,$P(RPTG,U,14))                     ; amt claimed
 S FBZ=$$CSV(FBZ,$P(RPTG,U,15))                     ; amt paid
 S FBZ=$$CSV(FBZ,$P(RPTG,U,16))                     ; adjustment amt#1
 S FBZ=$$CSV(FBZ,$P(RPTG,U,17))                     ; adjustment reason#1
 S FBZ=$$CSV(FBZ,$P(RPTG,U,18))                     ; adjustment amt#2
 S FBZ=$$CSV(FBZ,$P(RPTG,U,19))                     ; adjustment reason#2
 S FBZ=$$CSV(FBZ,$P(RPTG,U,20))                     ; fee basis invoice#
 S FBZ=$$CSV(FBZ,$P(RPTG,U,21))                     ; batch#
 S FBZ=$$CSV(FBZ,$P(RPTG,U,22))                     ; obligation#
 S FBZ=$$CSV(FBZ,$$FMTE^XLFDT($P(RPTG,U,23),"2Z"))  ; date paid
 S FBZ=$$CSV(FBZ,$P(RPTG,U,24))                     ; check#
 S FBZ=$$CSV(FBZ,$P(RPTG,U,25))                     ; disbursed amt
 S FBZ=$$CSV(FBZ,$$FMTE^XLFDT($P(RPTG,U,26),"2Z"))  ; cancellation date
 S FBZ=$$CSV(FBZ,$S($P(RPTG,U,27):"VOID",1:""))     ; voided payment flag
 S FBZ=$$CSV(FBZ,$P(RPTG,U,28))                     ; reject status
 W !,FBZ
 Q
 ;
CSV(STRING,DATA) ; build the Excel data string for CSV format
 S DATA=$C(34)_$TR(DATA,$C(34),$C(39))_$C(34)
 S STRING=$S(STRING="":DATA,1:STRING_","_DATA)
 Q STRING
 ;

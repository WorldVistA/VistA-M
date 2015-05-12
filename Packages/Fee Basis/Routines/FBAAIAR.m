FBAAIAR ;ALB/ESG - FEE IPAC Vendor DoD Invoice (Summary) Report ;1/16/2014
 ;;3.5;FEE BASIS;**123**;JAN 30, 1995;Build 51
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ; main report entry point
 ;
 N FBIAVEN,FBIABEG,FBIAEND,FBIATYPE,FBIAEXCEL
P1 I '$$VENDSEL(.FBIAVEN) G EX
P2 I '$$DATES(.FBIABEG,.FBIAEND) G EX:$$STOP,P1
P3 I '$$TYPESEL(.FBIATYPE) G EX:$$STOP,P2
P4 I '$$FORMAT(.FBIAEXCEL) G EX:$$STOP,P3
P5 I '$$DEVICE() G EX:$$STOP,P4
 ;
EX ; main report exit point
 Q
 ;
STOP() ; Determine if user wants to exit out of the option entirely
 ; 1=yes, get out entirely
 ; 0=no, just go back to the previous question
 ;
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 ;
 S DIR(0)="Y"
 S DIR("A")="Do you want to exit out of this option entirely"
 S DIR("B")="YES"
 S DIR("?",1)="  Enter YES to immediately exit out of this option."
 S DIR("?")="  Enter NO to return to the previous question."
 W ! D ^DIR K DIR
 I $D(DIRUT) S Y=1
 Q Y
 ;
VENDSEL(FBIAVEN) ; user selection function for IPAC vendors
 ; FBIAVEN is an output array, pass by reference
 ; FBIAVEN(vendor ien) = vendor name selected
 ; Function value is 1 if at least 1 vendor was selected, 0 otherwise
 ;
 N DIC,RET,VAUTSTR,VAUTNI,VAUTVB,V,X,Y
 K FBIAVEN
 S RET=1    ; default to 1 indicating all OK
 ;
 W @IOF,!,"IPAC Vendor DoD Invoice Report"
 W !!,"This report will display summary information on all of the DoD invoices"
 W !,"for the selected IPAC vendors, within the selected date range, and for"
 W !,"the selected payment types."
 W !
 ;
 S DIC="^FBAAV("
 S DIC("S")="I +$O(^FBAA(161.95,""V"",Y,0))"
 S VAUTSTR="IPAC Vendor",VAUTNI=2,VAUTVB="FBIAVEN"
 D FIRST^VAUTOMA     ; DBIA# 4398
 I FBIAVEN S V=0 F  S V=$O(^FBAA(161.95,"V",V)) Q:'V  S FBIAVEN(V)=$P($G(^FBAAV(V,0)),U,1)   ; all IPAC vendors selected
 I '$O(FBIAVEN(0)) S RET=0 W $C(7)        ; no vendors found/selected
 Q RET
 ;
DATES(FBIABEG,FBIAEND) ; capture the start date and end date from the user
 ; both are output parameters, pass by reference
 ; function value is 0/1 indicating if valid dates were selected
 ;
 N RET,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S RET=1
 S (FBIABEG,FBIAEND)=""
 ;
 S DIR(0)="D^:DT:EX"
 S DIR("A")="Enter the Start Date"
 S DIR("B")=$$FMTE^XLFDT($$FMADD^XLFDT(DT,-30),"5DZ")   ; default date is T-30
 S DIR("?",1)="The start and end dates for this report refer to the date that the"
 S DIR("?",2)="associated batch and payment line items are finalized (certified)"
 S DIR("?")="in VistA Fee through the ""Finalize a Batch"" menu option."
 W ! D ^DIR K DIR
 I $D(DIRUT)!'Y S RET=0 W $C(7) G DATEX
 S FBIABEG=Y
 ;
 S DIR(0)="D^"_FBIABEG_":DT:EX"
 S DIR("A")="Enter the End Date"
 S DIR("B")=$$FMTE^XLFDT(DT,"5DZ")   ; default date is Today
 S DIR("?",1)="The start and end dates for this report refer to the date that the"
 S DIR("?",2)="associated batch and payment line items are finalized (certified)"
 S DIR("?")="in VistA Fee through the ""Finalize a Batch"" menu option."
 W ! D ^DIR K DIR
 I $D(DIRUT)!'Y S RET=0 W $C(7) G DATEX
 S FBIAEND=Y
DATEX ;
 Q RET
 ;
TYPESEL(FBIATYPE) ; function for user selection of the types of invoices to search
 ; FBIATYPE is an output array, pass by reference
 ; FBIATYPE(type)="" where type can be OUT,RX,INP,ANC
 ; Function value is 1 if at least 1 invoice type was selected, 0 otherwise
 ;
 N RET,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,FD,G
 K FBIATYPE
 S RET=1    ; default to 1 indicating all OK
 ;
 F  D  Q:Y="ALL"!$D(DIRUT)!(Y="")
 . S DIR(0)="SO"
 . S FD="OUT:"_$$LJ^XLFSTR("Outpatient",27)_$S($D(FBIATYPE("OUT")):"SELECTED",1:"")
 . S FD=FD_";RX:"_$$LJ^XLFSTR("Pharmacy",27)_$S($D(FBIATYPE("RX")):"SELECTED",1:"")
 . S FD=FD_";INP:"_$$LJ^XLFSTR("Civil Hospital",27)_$S($D(FBIATYPE("INP")):"SELECTED",1:"")
 . S FD=FD_";ANC:"_$$LJ^XLFSTR("Civil Hospital Ancillary",27)_$S($D(FBIATYPE("ANC")):"SELECTED",1:"")
 . S FD=FD_";ALL:All"
 . S $P(DIR(0),U,2)=FD
 . ;
 . I '$D(FBIATYPE) S DIR("A")="Select an Invoice Type",DIR("B")="ALL"
 . E  S DIR("A")="Select Another Invoice Type" K DIR("B")
 . W ! D ^DIR K DIR
 . ;
 . I Y="ALL" D  Q     ; user selected all types, so set them and get out
 .. F G="OUT","RX","INP","ANC" S FBIATYPE(G)=""
 . ;
 . I $D(DIRUT)!(Y="") Q
 . I $D(FBIATYPE(Y)) K FBIATYPE(Y) Q     ; if already selected, toggle the selection off then quit
 . S FBIATYPE(Y)=""                      ; toggle selection on
 . Q
 ;
 I $D(DUOUT)!$D(DTOUT) S RET=0           ; exit via up-arrow or time-out should get out
 I '$D(FBIATYPE) S RET=0 W $C(7)
 Q RET
 ;
FORMAT(FBIAEXCEL) ; capture the report format from the user (normal or CSV output)
 ; FBIAEXCEL=0 for normal output
 ; FBIAEXCEL=1 for CSV (comma separated values) for Excel output
 ; pass parameter by reference
 ;
 N RET,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S FBIAEXCEL=0,RET=1
 S DIR(0)="Y"
 S DIR("A")="Do you want to capture the output in a CSV format"
 S DIR("B")="NO"
 S DIR("?",1)="If you want to capture the output from this report in a comma-separated"
 S DIR("?",2)="values (CSV) format, then answer YES here.  A CSV format is something that"
 S DIR("?",3)="could be easily imported into a spreadsheet program like Excel."
 S DIR("?",4)=" "
 S DIR("?")="If you just want a normal report output, then answer NO here."
 W ! D ^DIR K DIR
 I $D(DIRUT) S RET=0 W $C(7)
 S FBIAEXCEL=Y
 Q RET
 ;
DEVICE() ; Device Selection
 N ZTRTN,ZTDESC,ZTSAVE,POP,RET,ZTSK,DIR,X,Y
 S RET=1
 I 'FBIAEXCEL W !!,"This report is 132 characters wide.  Please choose an appropriate device.",!
 I FBIAEXCEL D
 . W !!,"For CSV output, turn logging or capture on now."
 . W !,"To avoid undesired wrapping of the data saved to the file,"
 . W !,"please enter ""0;256;99999"" at the ""DEVICE:"" prompt.",!
 ;
 S ZTRTN="COMPILE^FBAAIAR"
 S ZTDESC="Fee Basis IPAC Vendor DoD Invoice Report"
 S ZTSAVE("FBIAVEN(")=""
 S ZTSAVE("FBIABEG")=""
 S ZTSAVE("FBIAEND")=""
 S ZTSAVE("FBIATYPE(")=""
 S ZTSAVE("FBIAEXCEL")=""
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE,"QM",1)
 I POP S RET=0
 I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",! S DIR(0)="E" D ^DIR
 Q RET
 ;
COMPILE ; entry point for the compile to build the scratch global
 ; may be background task if job queued
 ;
 K ^TMP("FBAAIAR",$J)
 I '$D(ZTQUEUED) W !!,"Compiling IPAC Vendor DoD Invoice Report.  Please wait ... "
 I $D(FBIATYPE("OUT"))!$D(FBIATYPE("ANC")) D COMPOUT
 I $D(FBIATYPE("INP")) D COMPIN
 I $D(FBIATYPE("RX")) D COMPRX^FBAAIARA
 ;
 D PRINT^FBAAIARA                 ; print report
 D ^%ZISC                         ; close the device
 K ^TMP("FBAAIAR",$J)             ; kill scratch
 I $D(ZTQUEUED) S ZTREQ="@"       ; purge the task
COMPILX ;
 Q
 ;
COMPOUT ; compile Outpatient and Ancillary data
 ;
 N DATA,FBDODINV,FBDT,FBJ,FBK,FBL,FBM,FBVENAME,FBVENID,FBY0,FBY2,FBY3,FEEPROG,FBYREJ
 S FBDT=$O(^FBAAC("AK",FBIABEG),-1)
 F  S FBDT=$O(^FBAAC("AK",FBDT)) Q:'FBDT!(FBDT>FBIAEND)  D
 . S FBJ=0 F  S FBJ=$O(^FBAAC("AK",FBDT,FBJ)) Q:'FBJ  D
 .. S FBK=0 F  S FBK=$O(^FBAAC("AK",FBDT,FBJ,FBK)) Q:'FBK  D       ; FBK=vendor ien
 ... I '$D(FBIAVEN(FBK)) Q                  ; make sure vendor is among the selected vendors for the report
 ... S FBVENAME=$P($G(^FBAAV(FBK,0)),U,1)   ; vendor name
 ... S FBVENID=$P($G(^FBAAV(FBK,0)),U,2)    ; vendor external ID
 ... S FBL=0 F  S FBL=$O(^FBAAC("AK",FBDT,FBJ,FBK,FBL)) Q:'FBL  D
 .... S FBM=0 F  S FBM=$O(^FBAAC("AK",FBDT,FBJ,FBK,FBL,FBM)) Q:'FBM  D
 ..... S FBY0=$G(^FBAAC(FBJ,1,FBK,1,FBL,1,FBM,0))
 ..... S FEEPROG=+$P(FBY0,U,9)   ; Fee Program ptr
 ..... I FEEPROG=2,'$D(FBIATYPE("OUT")) Q          ; Outpatient not a chosen type for report
 ..... I FEEPROG'=2,'$D(FBIATYPE("ANC")) Q         ; Civil Hosp Ancillary not a chosen type for report
 ..... S FBY2=$G(^FBAAC(FBJ,1,FBK,1,FBL,1,FBM,2))
 ..... S FBY3=$G(^FBAAC(FBJ,1,FBK,1,FBL,1,FBM,3))
 ..... S FBYREJ=$G(^FBAAC(FBJ,1,FBK,1,FBL,1,FBM,"FBREJ"))
 ..... S FBDODINV=$P(FBY3,U,7) I FBDODINV="" Q        ; DoD invoice# must be present
 ..... I $D(^TMP("FBAAIAR",$J,FBVENAME,FBDODINV)) Q   ; DoD invoice# data already exists
 ..... I $P(FBY2,U,4) Q                               ; cancellation date exists
 ..... I $P(FBY0,U,21)'="" Q                          ; line has been voided
 ..... I $P(FBYREJ,U,1)'="" Q                         ; line has been rejected
 ..... ;
 ..... S DATA=FBK_U_FBVENID_U_FBDT
 ..... S $P(DATA,U,7)=$P(FBY0,U,16)                               ; fee invoice number
 ..... S $P(DATA,U,9)=$P($G(^FBAA(161.7,+$P(FBY0,U,8),0)),U,1)    ; external batch#
 ..... S $P(DATA,U,11)=$P($G(^FBAA(161.7,+$P(FBY0,U,8),0)),U,2)   ; obligation# from the batch file
 ..... S $P(DATA,U,13)=$P(FBY0,U,14)                              ; Date Paid
 ..... S $P(DATA,U,16)=$P(FBY2,U,3)                               ; check number
 ..... S ^TMP("FBAAIAR",$J,FBVENAME,FBDODINV)=DATA                ; store new data for this DoD invoice#
 ..... D GET(FBVENAME,FBDODINV)                                   ; gather totals for DoD invoice#
 ..... Q
 .... Q
 ... Q
 .. Q
 . Q
COMPOUTX ;
 Q
 ;
COMPIN ; compile Inpatient data
 ;
 N DATA,FBDODINV,FBDT,FBJ,FBV,FBVENAME,FBVENID,FBY0,FBY2,FBY5,FBYREJ
 S FBDT=$O(^FBAAI("AD",FBIABEG),-1)
 F  S FBDT=$O(^FBAAI("AD",FBDT)) Q:'FBDT!(FBDT>FBIAEND)  S FBJ=0 F  S FBJ=$O(^FBAAI("AD",FBDT,FBJ)) Q:'FBJ  D
 . S FBY0=$G(^FBAAI(FBJ,0))
 . S FBY2=$G(^FBAAI(FBJ,2))
 . S FBY5=$G(^FBAAI(FBJ,5))
 . S FBYREJ=$G(^FBAAI(FBJ,"FBREJ"))
 . S FBDODINV=$P(FBY5,U,7) I FBDODINV="" Q        ; DoD invoice# must be present
 . S FBV=+$P(FBY0,U,3)      ; vendor ien
 . I '$D(FBIAVEN(FBV)) Q    ; vendor is not among the selected vendors for the report
 . S FBVENAME=$P($G(^FBAAV(FBV,0)),U,1)           ; vendor name
 . S FBVENID=$P($G(^FBAAV(FBV,0)),U,2)            ; vendor external ID
 . I $D(^TMP("FBAAIAR",$J,FBVENAME,FBDODINV)) Q   ; DoD invoice# data already exists
 . I $P(FBY2,U,5) Q                               ; cancelled
 . I $P(FBY0,U,14)'="" Q                          ; voided
 . I $P(FBYREJ,U,1)'="" Q                         ; rejected
 . ;
 . S DATA=FBV_U_FBVENID_U_FBDT
 . S $P(DATA,U,7)=$P(FBY0,U,1)                                 ; fee invoice number
 . S $P(DATA,U,9)=$P($G(^FBAA(161.7,+$P(FBY0,U,17),0)),U,1)    ; external batch#
 . S $P(DATA,U,11)=$P($G(^FBAA(161.7,+$P(FBY0,U,17),0)),U,2)   ; obligation# from the batch file
 . S $P(DATA,U,13)=$P(FBY2,U,1)                                ; Date Paid
 . S $P(DATA,U,16)=$P(FBY2,U,4)                                ; check number
 . S ^TMP("FBAAIAR",$J,FBVENAME,FBDODINV)=DATA                 ; store new data for this DoD invoice#
 . D GET(FBVENAME,FBDODINV)                                    ; gather totals for DoD invoice#
 . Q
COMPINX ;
 Q
 ;
GET(FBVENAME,FBDODINV) ; gather totals and other data for all Fee line items for the given vendor and DoD invoice#
 ; update the established scratch global with information
 ;
 N ADJTOT,CLAIMED,DISBURSED,FBDISGD,FBG0,FBG2,FBGREJ,K,L,M,N,P,PAID,FBTT
 ;
 I $G(FBVENAME)="" G GETX
 I $G(FBDODINV)="" G GETX
 ;
 S (CLAIMED,PAID,ADJTOT,DISBURSED)=0                   ; initialize dollar totals to 0
 S FBDISGD=$G(^TMP("FBAAIAR",$J,FBVENAME,FBDODINV))    ; current contents of scratch global data
 S FBTT=$G(^TMP("FBAAIAR",$J,FBVENAME))                ; current vendor totals
 ;
 ; gather outpatient/ancillary totals for this DoD invoice#
 S K=0 F  S K=$O(^FBAAC("DODI",FBDODINV,K)) Q:'K  S L=0 F  S L=$O(^FBAAC("DODI",FBDODINV,K,L)) Q:'L  S M=0 F  S M=$O(^FBAAC("DODI",FBDODINV,K,L,M)) Q:'M  S N=0 F  S N=$O(^FBAAC("DODI",FBDODINV,K,L,M,N)) Q:'N  D
 . S FBG0=$G(^FBAAC(K,1,L,1,M,1,N,0))
 . S FBG2=$G(^FBAAC(K,1,L,1,M,1,N,2))
 . S FBGREJ=$G(^FBAAC(K,1,L,1,M,1,N,"FBREJ"))
 . I $P(FBG2,U,4) Q           ; cancelled
 . I $P(FBG0,U,21)'="" Q      ; voided
 . I $P(FBGREJ,U,1)'="" Q     ; rejected
 . S CLAIMED=CLAIMED+$P(FBG0,U,2)
 . S PAID=PAID+$P(FBG0,U,3)
 . S DISBURSED=DISBURSED+$P(FBG2,U,8)
 . S P=0 F  S P=$O(^FBAAC(K,1,L,1,M,1,N,7,P)) Q:'P  S ADJTOT=ADJTOT+$P($G(^FBAAC(K,1,L,1,M,1,N,7,P,0)),U,3)
 . ;
 . ; check for certain fields that may have multiple values or missing values for the same DoD invoice number
 . ; across all VistA line items for all payment types.
 . D CKMLT($P(FBG0,U,16),7,8)                               ; fee invoice number
 . D CKMLT($P($G(^FBAA(161.7,+$P(FBG0,U,8),0)),U,1),9,10)   ; external batch#
 . D CKMLT($P($G(^FBAA(161.7,+$P(FBG0,U,8),0)),U,2),11,12)  ; obligation# (taken from the batch)
 . D CKMLT($P(FBG0,U,14),13,14,15)                          ; date paid (also check for missing values)
 . D CKMLT($P(FBG2,U,3),16,17,18)                           ; check number (also check for missing values)
 . Q
 ;
 ; gather inpatient totals for this DoD invoice#
 S K=0 F  S K=$O(^FBAAI("DODI",FBDODINV,K)) Q:'K  D
 . S FBG0=$G(^FBAAI(K,0))
 . S FBG2=$G(^FBAAI(K,2))
 . S FBGREJ=$G(^FBAAI(K,"FBREJ"))
 . I $P(FBG2,U,5) Q            ; cancelled
 . I $P(FBG0,U,14)'="" Q       ; voided
 . I $P(FBGREJ,U,1)'="" Q      ; rejected
 . S CLAIMED=CLAIMED+$P(FBG0,U,8)
 . S PAID=PAID+$P(FBG0,U,9)
 . S DISBURSED=DISBURSED+$P(FBG2,U,8)
 . S P=0 F  S P=$O(^FBAAI(K,8,P)) Q:'P  S ADJTOT=ADJTOT+$P($G(^FBAAI(K,8,P,0)),U,3)
 . ;
 . ; check for certain fields that may have multiple values or missing values for the same DoD invoice number
 . ; across all VistA line items for all payment types.
 . D CKMLT($P(FBG0,U,1),7,8)                                ; fee invoice number
 . D CKMLT($P($G(^FBAA(161.7,+$P(FBG0,U,17),0)),U,1),9,10)  ; external batch#
 . D CKMLT($P($G(^FBAA(161.7,+$P(FBG0,U,17),0)),U,2),11,12) ; obligation# (taken from the batch)
 . D CKMLT($P(FBG2,U,1),13,14,15)                           ; date paid (also check for missing values)
 . D CKMLT($P(FBG2,U,4),16,17,18)                           ; check number (also check for missing values)
 . Q
 ;
 ; gather pharmacy totals for this DoD invoice#
 S K=0 F  S K=$O(^FBAA(162.1,"DODI",FBDODINV,K)) Q:'K  S L=0 F  S L=$O(^FBAA(162.1,"DODI",FBDODINV,K,L)) Q:'L  D
 . S FBG0=$G(^FBAA(162.1,K,"RX",L,0))
 . S FBG2=$G(^FBAA(162.1,K,"RX",L,2))
 . S FBGREJ=$G(^FBAA(162.1,K,"RX",L,"FBREJ"))
 . I $P(FBG2,U,11) Q          ; cancelled
 . I $P(FBG2,U,3)'="" Q       ; voided
 . I $P(FBGREJ,U,1)'="" Q     ; rejected
 . S CLAIMED=CLAIMED+$P(FBG0,U,4)
 . S PAID=PAID+$P(FBG0,U,16)
 . S DISBURSED=DISBURSED+$P(FBG2,U,14)
 . S P=0 F  S P=$O(^FBAA(162.1,K,"RX",L,4,P)) Q:'P  S ADJTOT=ADJTOT+$P($G(^FBAA(162.1,K,"RX",L,4,P,0)),U,3)
 . ;
 . ; check for certain fields that may have multiple values or missing values for the same DoD invoice number
 . ; across all VistA line items for all payment types.
 . D CKMLT(K,7,8)                                           ; fee invoice number (K is DINUM'd with the .01 field)
 . D CKMLT($P($G(^FBAA(161.7,+$P(FBG0,U,17),0)),U,1),9,10)  ; external batch#
 . D CKMLT($P($G(^FBAA(161.7,+$P(FBG0,U,17),0)),U,2),11,12) ; obligation# (taken from the batch)
 . D CKMLT($P(FBG2,U,8),13,14,15)                           ; date paid (also check for missing values)
 . D CKMLT($P(FBG2,U,10),16,17,18)                          ; check number (also check for missing values)
 . Q
 ;
 ; update scratch global
 S $P(FBDISGD,U,4)=CLAIMED      ; total amount claimed
 S $P(FBDISGD,U,5)=PAID         ; total amount paid
 S $P(FBDISGD,U,6)=ADJTOT       ; total adjustment amount
 S $P(FBDISGD,U,19)=DISBURSED   ; total disbursed amount
 S ^TMP("FBAAIAR",$J,FBVENAME,FBDODINV)=FBDISGD
 ;
 ; also update vendor totals
 S $P(FBTT,U,1)=$P(FBTT,U,1)+1          ; count
 S $P(FBTT,U,4)=$P(FBTT,U,4)+CLAIMED
 S $P(FBTT,U,5)=$P(FBTT,U,5)+PAID
 S $P(FBTT,U,6)=$P(FBTT,U,6)+ADJTOT
 S $P(FBTT,U,19)=$P(FBTT,U,19)+DISBURSED
 S ^TMP("FBAAIAR",$J,FBVENAME)=FBTT
 ;
GETX ;
 Q
 ;
CKMLT(VAL,VALPCE,MLTPCE,NOVPCE) ; check for multiple/missing data values
 ;    Variable FBDISGD is assumed to contain the contents of the scratch global
 ;    VAL - value from the payment file to check
 ; VALPCE - piece# from the scratch global to check for multiple values
 ; MLTPCE - piece# of the scratch global to set if multiple values found
 ; NOVPCE - piece# of the scratch global to set if no data exists in VAL (optional)
 ;
 I VAL'="",$P(FBDISGD,U,VALPCE)'="",VAL'=$P(FBDISGD,U,VALPCE) S $P(FBDISGD,U,MLTPCE)=1
 I $G(NOVPCE),VAL="" S $P(FBDISGD,U,NOVPCE)=1
 Q
 ;

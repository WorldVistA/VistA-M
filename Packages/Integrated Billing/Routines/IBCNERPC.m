IBCNERPC ;DAOU/RO - PAYER LINK REPORT - Compile & Print;AUG-2003
 ;;2.0;INTEGRATED BILLING;**184,252,271,416,528,668,687,737**;21-MAR-94;Build 19
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to EN^XUTMDEVQ in ICR #1519
 ;
 ; IB*2*687-rewrote/redesigned the report (basically from scratch) which
 ; included combining 3 routines into 2. The changes based on the patches prior
 ; to IB*2*688 were not tracked in the routine in the past; therefore, you will
 ; not find references to them below. The IB*2*668 reference (translating "IIV"
 ; to "EIV") will be overwritten with the rewrite.
 ;
 ; eIV - Electronic Ins. Verification
 ; IIU - Interfacility Ins. Update
 ;
 ; Input parameters: N/A
 ; Variables ZTSAVED for queueing:
 ; IBCNERTN="IBCNERPB" (current routine)
 ; IBCNESPC("PAPP")=Payer APPLICATION selected (1-eIV, 2-IIU, 3-Both)
 ; IBCNESPC("PDEACT")=Included Deactivated Payers? (1-include, 2-exclude)
 ; IBCNESPC("PDET")=Include Ins detail? (1-include list of ins, 2-do not list)
 ; IBCNESPC("POUT")=Output Format ('E'=EXCEL, 'R'=REPORT)
 ; IBCNESPC("PPYR")=Single Payer name or "" for ALL
 ; IBCNESPC("PSORT")=Primary Sort
 ; IBCNESPC("PTYPE")=Payer type (1-no active ins linked, 2-at least 1 ins linked, 3-All Payers)
 Q
 ;
COMPILE(IBCNERTN,IBCNESPC) ; Entry point called from EN^XUTMDEVQ.
 ; IBCNERTN = Routine name for ^TMP($J,...
 ; IBCNESPC = Array of params
 N PAPP,PDEACT,PDET,POUT,PPYR,PSORT,PTYPE
 ; IB*2*687/DTG start print msg in rept if no data for APP
 N IBII,IBIJ,IBAPP
 ; IB*2*687/DTG end print msg in rept if no data for APP
 S PAPP=$G(IBCNESPC("PAPP"))      ; Payer Application (1=eIV, 2=IIU, 3=Both)
 S PDEACT=$G(IBCNESPC("PDEACT"))  ; Deactivated Payers? (1=include, 0=exclude)
 S PDET=$G(IBCNESPC("PDET"))      ; Ins detail? (1=include list of ins, 2=do not list)
 S POUT=$G(IBCNESPC("POUT"))      ; Output Format ('E'=EXCEL, 'R'=Report)
 S PPYR=$G(IBCNESPC("PPYR"))      ; Single Payer name or "" for ALL
 S PSORT=$G(IBCNESPC("PSORT"))    ; Primary Sort
 S PTYPE=$G(IBCNESPC("PTYPE"))    ; Payer Type (1=no active ins linked, 2=at least 1 ins linked, 3=All Payers)
 K ^TMP($J,IBCNERTN)
 D GETDATA
 D PRINT
 ;
COMPILEX ; COMPILE exit
 K ^TMP($J,IBCNERTN)
 D ^%ZISC
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
GETDATA ; Compile the data.
 ;IB*737/TAZ - Removed reference to Most Popular Payer and "~NO PAYER"
 N IBPY,IBPYR
 K ^TMP($J,IBCNERTN)
 ; IB*2*687/DTG start print msg in rept if no data for APP
 ; Create stub for EIV and IIU in TMP file for validation
 I PAPP=""!(PAPP=1)!(PAPP=3) S ^TMP($J,IBCNERTN,"PAYER","EIV")=""
 I PAPP=2!(PAPP=3) S ^TMP($J,IBCNERTN,"PAYER","IIU")=""
 ; IB*2*687/DTG end print msg in rept if no data for APP
 I '$D(ZTQUEUED),$G(IOST)["C-",POUT="R" W !!,"Compiling report data ..."
 ;
 ; SINGLE PAYER
 I PPYR'="" D  Q
 . S IBPY=+PPYR   ; Internal Payer ID number
 . S IBPYR=$P(PPYR,U,2)  ; Payer's Name
 . D GETDATA1     ; Get the current payer's data
 . Q
 ;
 ; ALL PAYERS (Loop thru #365.12)
 S IBPY=0
 F  S IBPY=$O(^IBE(365.12,IBPY)) Q:'IBPY  D  Q:$G(ZTSTOP)
 . I '+PDEACT,+$$PYRDEACT^IBCNINSU(+IBPY) Q  ; Don't want DEACTIVATED Payers
 . S IBPYR=$$GET1^DIQ(365.12,IBPY,.01) ; Payer name from (#365.12)
 . I ($$PYRAPP^IBCNEUT5("EIV",IBPY)="")&($$PYRAPP^IBCNEUT5("IIU",IBPY)="") Q  ; Only accept eIV & IIU Payers
 . D GETDATA1
 Q
 ;
GETDATA1 ; Process the current payer.
 N ALSOEIV,ALSOIIU,APPEIV,APPIIU,AUTUPD,EDIINST,EDIPROF,IBCT,IBEIVIEN,IBIIUIEN,IBINS,IBINSN,INSDATA
 N LOCENB,NATENB,NOLNKCOS,PAPPARY,PEINEIV,PEINIIU,RCVIIU,STATECD,VAID
 S APPEIV=$$FIND1^DIC(365.13,,,"EIV"),APPIIU=$$FIND1^DIC(365.13,,,"IIU")
 D PAYER^IBCNINSU(IBPY,"","**","E",.PAPPARY)  ; Obtain all the Payer and Payer Application data
 S (PEINEIV,PEINIIU)=""
 S IBEIVIEN=$$PYRAPP^IBCNEUT5("EIV",IBPY),IBIIUIEN=$$PYRAPP^IBCNEUT5("IIU",IBPY)
 I IBEIVIEN S PEINEIV="EIV"_U_IBEIVIEN_","_IBPY_"," ; EIV App
 I IBIIUIEN S PEINIIU="IIU"_U_IBIIUIEN_","_IBPY_"," ; IIU App
 ;
 I PAPP=1,PEINEIV="" Q   ; Only want eIV Payers and this Payer doesn't have an eIV app.
 I PAPP=2,PEINIIU="" Q   ; Only want IIU Payers and this Payer doesn't have an IIU app.
 ;
 S VAID=$G(PAPPARY(365.12,IBPY_",",.02,"E"))  ; VA Nat'l Payer ID
 S EDIINST=$G(PAPPARY(365.12,IBPY_",",.06,"E")),EDIPROF=$G(PAPPARY(365.12,IBPY_",",.05,"E"))  ; Inst & Prof EDI #s
 S ALSOEIV="NO" I PEINEIV'="" S ALSOEIV=$S($G(PAPPARY(365.121,$P(PEINEIV,U,2),.01,"E"))="EIV":"YES",1:"NO")   ; eIV Also
 S ALSOIIU="NO" I PEINIIU'="" S ALSOIIU=$S($G(PAPPARY(365.121,$P(PEINIIU,U,2),.01,"E"))="IIU":"YES",1:"NO")   ; IIU Also
 S AUTUPD="" I PEINEIV'="" S AUTUPD=$G(PAPPARY(365.121,$P(PEINEIV,U,2),4.01,"E"))  ; Auto Update field for eIV
 S RCVIIU="" I PEINIIU'="" S RCVIIU=$G(PAPPARY(365.121,$P(PEINIIU,U,2),5.01,"E"))  ; Receive IIU Data field for IIU
 S NATENB("EIV")="NO" I PEINEIV'="" S NATENB("EIV")=$S($G(PAPPARY(365.121,$P(PEINEIV,U,2),.02,"E"))="Enabled":"YES",1:"NO")  ; Nat'l Enabled Status for eIV
 S NATENB("IIU")="NO" I PEINIIU'="" S NATENB("IIU")=$S($G(PAPPARY(365.121,$P(PEINIIU,U,2),.02,"E"))="Enabled":"YES",1:"NO")  ; Nat'l Enabled Status for IIU
 S LOCENB("EIV")="NO" I PEINEIV'="" S LOCENB("EIV")=$S($G(PAPPARY(365.121,$P(PEINEIV,U,2),.03,"E"))="Enabled":"YES",1:"NO")  ; Locally Enabled Status for eIV
 S LOCENB("IIU")="NO" I PEINIIU'="" S LOCENB("IIU")=$S($G(PAPPARY(365.121,$P(PEINIIU,U,2),.03,"E"))="Enabled":"YES",1:"NO")  ; Locally Enabled Status for IIU
 ;
 ; Get # of linked ins carriers for payer
 S IBCT=0,IBINS=""
 I PTYPE=1,$D(^DIC(36,"AC",IBPY)) Q   ; Unlinked report-Only want payers without linked ins cos.
 I PTYPE=2,'$D(^DIC(36,"AC",IBPY)) Q  ; Linked report-Only want payers with linked ins cos.
 F  S IBINS=$O(^DIC(36,"AC",IBPY,IBINS)) Q:IBINS=""  D
 . S IBINSN=$G(^DIC(36,IBINS,0)),IBINSN=$P(IBINSN,U) Q:IBINSN=""
 . S IBCT=IBCT+1
 . ;If ins detail requested, save address & EDI#'s
 . I PDET=1 D
 . . S STATECD=$$GET1^DIQ(36,IBINS,.115,"I")
 . . S INSDATA=$$GET1^DIQ(36,IBINS,.111)_U_$$GET1^DIQ(36,IBINS,.114)_U_$P($G(^DIC(5,+STATECD,0)),U,2)_U_$$GET1^DIQ(36,IBINS,.116,"E")
 . . S INSDATA=INSDATA_U_$$GET1^DIQ(36,IBINS,3.02)_U_$$GET1^DIQ(36,IBINS,3.04)
 . . S ^TMP($J,IBCNERTN,"INSDTL",IBPY,IBINSN,IBINS)=INSDATA
 ;
SORTIT ; Set SORT params...use the negative of IBCT to sort in reverse order.
 I PSORT=1 D    ; SORT by Payer Name
 . S SORT1=IBPYR,SORT2=VAID,SORT5=-IBCT
 . I PEINEIV'="","^1^3^"[(U_PAPP_U) D    ; For eIV or Both report
 . . S SORT3=NATENB("EIV"),SORT4=LOCENB("EIV")
 . . D SAVDATA("EIV")
 . I PEINIIU'="","^2^3^"[(U_PAPP_U) D    ; For IIU or Both report
 . . S SORT3=NATENB("IIU"),SORT4=LOCENB("IIU")
 . . D SAVDATA("IIU")
 ;
 I PSORT=2 D    ; SORT by VAID
 . S SORT1=VAID,SORT2=IBPYR,SORT5=-IBCT
 . I PEINEIV'="","^1^3^"[(U_PAPP_U) D    ; For eIV or Both report
 . . S SORT3=NATENB("EIV"),SORT4=LOCENB("EIV")
 . . D SAVDATA("EIV")
 . I PEINIIU'="","^2^3^"[(U_PAPP_U) D    ; For IIU or Both report
 . . S SORT3=NATENB("IIU"),SORT4=LOCENB("IIU")
 . . D SAVDATA("IIU")
 ;
 I PSORT=3 D    ; SORT by Nat'l Enabled Status
 . S SORT2=IBPYR,SORT3=VAID,SORT5=-IBCT
 . I PEINEIV'="","^1^3^"[(U_PAPP_U) D    ; For eIV or Both report
 . . S SORT1=NATENB("EIV"),SORT4=LOCENB("EIV")
 . . D SAVDATA("EIV")
 . I PEINIIU'="","^2^3^"[(U_PAPP_U) D    ; For IIU or Both report
 . . S SORT1=NATENB("IIU"),SORT4=LOCENB("IIU")
 . . D SAVDATA("IIU")
 ;
 I PSORT=4 D    ; SORT by Locally Enabled Status
 . S SORT2=IBPYR,SORT3=VAID,SORT5=-IBCT
 . I PEINEIV'="","^1^3^"[(U_PAPP_U) D    ; For eIV or Both report
 . . S SORT1=LOCENB("EIV"),SORT4=NATENB("EIV")
 . . D SAVDATA("EIV")
 . I PEINIIU'="","^2^3^"[(U_PAPP_U) D    ; For IIU or Both report
 . . S SORT1=LOCENB("IIU"),SORT4=NATENB("IIU")
 . . D SAVDATA("IIU")
 ;
 I PSORT=5 D   ; SORT by # of ins cos
 . S SORT1=-IBCT,SORT2=IBPYR,SORT3=VAID
 . I PEINEIV'="","^1^3^"[(U_PAPP_U) D    ; For eIV or Both report
 . . S SORT4=NATENB("EIV"),SORT5=LOCENB("EIV")
 . . D SAVDATA("EIV")
 . I PEINIIU'="","^2^3^"[(U_PAPP_U) D    ; For IIU or Both report
 . . S SORT4=NATENB("IIU"),SORT5=LOCENB("IIU")
 . . D SAVDATA("IIU")
 Q
 ;
SAVDATA(APP) ; Save data to print
 I POUT="R" D  Q   ; REPORT format
 . S ^TMP($J,IBCNERTN,"PAYER",APP,SORT1,SORT2,SORT3,SORT4,SORT5)=IBPY_U_IBPYR_U_VAID_U_EDIPROF_U_EDIINST_U_$G(NATENB(APP))_U_$G(LOCENB(APP))_U_$S(APP="IIU":RCVIIU,1:$G(AUTUPD))_U_$S(APP="IIU":ALSOEIV,1:ALSOIIU)_U_IBCT
 ; EXCEL format - only want to report a payer once in EXCEL format.
 I '$D(^TMP($J,IBCNERTN,"PAYER",SORT1)) S ^TMP($J,IBCNERTN,"PAYER",SORT1,SORT2,SORT3,SORT4,SORT5)=IBPY_U_IBPYR_U_VAID_U_EDIPROF_U_EDIINST_U_IBCT_U_$G(NATENB("EIV"))_U_LOCENB("EIV")_U_$G(AUTUPD)_U_NATENB("IIU")_U_LOCENB("IIU")_U_$G(RCVIIU)
 Q
 ;
PRINT ;
 N APP,CRT,DASHES,EORMSG,HDRDATE,HDRNAME,IBPGC,IBPXT,MAXCNT,NONEMSG,PREVAPP,SORT1,SORT2,SORT3,SORT4,SORT5,ZTSTOP,DIS
 S EORMSG="*** END OF REPORT ***"
 S NONEMSG="* * * N O   D A T A   F O U N D * * *"
 S HDRNAME="Payer Link Report",HDRDATE=$$FMTE^XLFDT($$NOW^XLFDT,1)_" Page: "
 S $P(DASHES,"-",131)="",(APP,SORT1,SORT2,SORT3,SORT4,SORT5)=""
 S (IBPXT,IBPGC)=0
 ; IO params
 I "^R^E^"'[(U_$G(POUT)_U) S POUT="R"
 S MAXCNT=IOSL-3,CRT=1
 I IOST'["C-" S MAXCNT=IOSL-6,CRT=0
 D PRINT1 Q:(IBPXT!$G(ZTSTOP))   ; Print report
 I CRT,IBPGC>0,'$D(ZTQUEUED) D
 . I MAXCNT<51 F LIN=1:1:(MAXCNT-$Y) W !
 . S DIR(0)="E" D ^DIR K DIR
 I POUT="E",CRT,'$D(ZTQUEUED) S DIR(0)="E" D ^DIR K DIR   ; End of the EXCEL Report
 Q
 ;
PRINT1 ; Print report
 S (APP,PREVAPP)=""
 ; EXCEL Format
 I POUT="E" D  G PRINT2
 . D EHDR     ; EXCEL Header
 . I '$D(^TMP($J,IBCNERTN)) D  Q
 . . D HEADER(APP,HDRNAME,HDRDATE)
 . . W !,?$$CENTER(NONEMSG,132),NONEMSG,!! Q   ; Nothing to print.
 . ;
 . ; Process through the Sort array
 . S SORT1="" F  S SORT1=$O(^TMP($J,IBCNERTN,"PAYER",SORT1)) Q:SORT1=""  D  Q:(IBPXT!$G(ZTSTOP))
 . . S SORT2="" F  S SORT2=$O(^TMP($J,IBCNERTN,"PAYER",SORT1,SORT2)) Q:SORT2=""  D  Q:(IBPXT!$G(ZTSTOP))
 . . . S SORT3="" F  S SORT3=$O(^TMP($J,IBCNERTN,"PAYER",SORT1,SORT2,SORT3)) Q:SORT3=""  D  Q:(IBPXT!$G(ZTSTOP))
 . . . . S SORT4="" F  S SORT4=$O(^TMP($J,IBCNERTN,"PAYER",SORT1,SORT2,SORT3,SORT4)) Q:SORT4=""  D  Q:(IBPXT!$G(ZTSTOP))
 . . . . . S SORT5="" F  S SORT5=$O(^TMP($J,IBCNERTN,"PAYER",SORT1,SORT2,SORT3,SORT4,SORT5)) Q:SORT5=""  D  Q:(IBPXT!$G(ZTSTOP))
 . . . . . . K DISPDATA  ; Init disp
 . . . . . . D DATA(.DISPDATA),LINE(.DISPDATA) ; build/display data
 ;
 ; REPORT Format
 I '$D(^TMP($J,IBCNERTN)) D  Q
 . ; IB*2*687/DTG start print msg in rept if no data FOUND, make sure all APP's for report are covered
 . S IBII=$S(PAPP=1:1,PAPP=2:2,PAPP=3:2,1:1)
 . F IBIJ=1:1:IBII S IBAPP=$P("EIV,IIU",",",IBIJ) I PAPP=3!(IBIJ=1&(PAPP=1))!(IBIJ=2&(PAPP=2)) D  ;<
 . . D HEADER(IBAPP,HDRNAME,HDRDATE)
 . . W !,?$$CENTER(NONEMSG,132),NONEMSG,!! Q   ; Nothing to print.
 . ; IB*2*687/DTG end print msg in rept if no data for APP
 ;
 ; Process through the Sort array
 F  S APP=$O(^TMP($J,IBCNERTN,"PAYER",APP)) Q:APP=""  D  Q:(IBPXT!$G(ZTSTOP))
 . S PREVAPP=APP
 . ; IB*2*687/DTG start print msg in rept if no data for APP
 . ; added a DO layer in order to check if data for APP
 . I POUT="R" D  ;<
 . . I $D(^TMP($J,IBCNERTN,"PAYER",APP))<10 D  Q
 . . . D HEADER(APP,HDRNAME,HDRDATE)
 . . . W !,?$$CENTER(NONEMSG,132),NONEMSG,!!
 . . ; print no data found if APP does not have data
 . . D HEADER(APP,HDRNAME,HDRDATE) Q:(IBPXT!$G(ZTSTOP))  ; REPORT Header
 . . S SORT1="" F  S SORT1=$O(^TMP($J,IBCNERTN,"PAYER",APP,SORT1)) Q:SORT1=""  D  Q:(IBPXT!$G(ZTSTOP))
 . . . S SORT2="" F  S SORT2=$O(^TMP($J,IBCNERTN,"PAYER",APP,SORT1,SORT2)) Q:SORT2=""  D  Q:(IBPXT!$G(ZTSTOP))
 . . . . S SORT3="" F  S SORT3=$O(^TMP($J,IBCNERTN,"PAYER",APP,SORT1,SORT2,SORT3)) Q:SORT3=""  D  Q:(IBPXT!$G(ZTSTOP))
 . . . . . S SORT4="" F  S SORT4=$O(^TMP($J,IBCNERTN,"PAYER",APP,SORT1,SORT2,SORT3,SORT4)) Q:SORT4=""  D  Q:(IBPXT!$G(ZTSTOP))
 . . . . . . S SORT5="" F  S SORT5=$O(^TMP($J,IBCNERTN,"PAYER",APP,SORT1,SORT2,SORT3,SORT4,SORT5)) Q:SORT5=""  D  Q:(IBPXT!$G(ZTSTOP))
 . . . . . . . K DISPDATA  ; Init disp
 . . . . . . . D DATA(.DISPDATA),LINE(.DISPDATA) ; build/display data
 . ; IB*2*687/DTG end print msg in rept if no data for APP
 ;
PRINT2 ;
 I IBPXT!$G(ZTSTOP) Q
 ;
 I POUT="R" D  Q:(IBPXT!$G(ZTSTOP))
 . I $Y+1>MAXCNT!('IBPGC) D HEADER(PREVAPP,HDRNAME,HDRDATE)
 W !,?$$CENTER(EORMSG,132),EORMSG
 Q
 ;
HEADER(APP,HDRNAME,HDRDATE) ; Report header
 N DIR,DTOUT,DUOUT,HDR,HDRDET,LIN,OFFSET1,OFFSET2,X,Y
 I CRT,IBPGC>0,'$D(ZTQUEUED) D  Q:IBPXT
 . I MAXCNT<51 F LIN=1:1:(MAXCNT-$Y) W !
 . S DIR(0)="E" D ^DIR K DIR
 . I $D(DTOUT)!($D(DUOUT)) S IBPXT=1 Q
 I $D(ZTQUEUED),$$S^%ZTLOAD() S ZTSTOP=1 Q
 S IBPGC=IBPGC+1,HDRDATE=HDRDATE_+IBPGC,HDRDET=""
 I PPYR="" S HDRDET="All "_$S(PTYPE=1:"Unlinked ",PTYPE=2:"Linked ",1:"")_APP_" Payers"
 I PTYPE'=1 D
 . I $L(HDRDET) S HDRDET=HDRDET_", "
 . ; IB*2*687/DTG start change for space
 . S HDRDET=HDRDET_$S(PDET=1:"With",1:"Without")_" Ins. Co. Detail"
 . ; IB*2*687/DTG end change for space
 S OFFSET1=$$CENTER(HDRDET,(132-$L(HDRNAME)))
 S OFFSET2=131-$L(HDRDATE)
 W @IOF,!,HDRNAME,?OFFSET1,HDRDET,?OFFSET2,HDRDATE
 W !
 I PPYR'="" W ?1,APP," Payer: ",$P(PPYR,"^",2)
 W !,?46,"# Linked",?63,"Nationally",?82,"Locally"
 W ?98,$S(APP="IIU":"Receive",1:"Auto")
 W ?113,"Prof/Inst.",?126,"Also"
 ; IB*2*687/DTG start remove ':' from payer name
 W !,"Payer Name"
 W ?32,"VA ID",?46,"Ins. Co.",?63,"Enabled",?82,"Enabled"
 ; IB*2*687/DTG end remove ':' from payer name
 W ?98,$S(APP="IIU":"IIU Data",1:"Update")
 W ?113,"EDI#",?126,$S(APP="EIV":"IIU",1:"EIV")
 W !,DASHES
 Q
 ;
 ; IB*2*687/DTG start change for space DISPDATA - DIS,RPTDATA - RPT,INCODATA - INCO,INSNAME - INSNA,INSREC - INSR
DATA(DIS) ; Build disp lines
 N CITY,CSZ,CT,CT2,ELINE,INCO,INSNA,INSNO,INSR,LCT,PYRNO,RPT,SPACES,STZIP
 ; Merge into local array
 S $P(SPACES," ",100)=" "
 I POUT="E" M RPT=^TMP($J,IBCNERTN,"PAYER",SORT1,SORT2,SORT3,SORT4,SORT5)
 I POUT="R" M RPT=^TMP($J,IBCNERTN,"PAYER",APP,SORT1,SORT2,SORT3,SORT4,SORT5)
 M INCO=^TMP($J,IBCNERTN,"INSDTL",$P(RPT,U,1))   ; Ins Co Detail
 ;
 ; EXCEL format
 I POUT="E" D  Q
 . N IBINSN,IBINS,IBPY,INSR,LCT,XX
 . S IBPY=$P(RPT,U),ELINE=$P(RPT,U,2,12)
 . I (PDET=2!'$D(^TMP($J,IBCNERTN,"INSDTL",IBPY))) S LCT=1,DIS(LCT)=ELINE Q
 . ;Print Ins Co Detail
 . S (IBINSN,IBINS,XX)="",LCT=0
 . I $D(^TMP($J,IBCNERTN,"INSDTL",IBPY)) D  Q
 . . F  S IBINSN=$O(^TMP($J,IBCNERTN,"INSDTL",IBPY,IBINSN)) Q:IBINSN=""  D
 . . . F  S IBINS=$O(^TMP($J,IBCNERTN,"INSDTL",IBPY,IBINSN,IBINS)) Q:IBINS=""  D
 . . . . S INSR=^TMP($J,IBCNERTN,"INSDTL",IBPY,IBINSN,IBINS)
 . . . . S LCT=LCT+1
 . . . . S DIS(LCT)=ELINE_U_IBINSN_U_INSR
 ;
 ; Format 1st line (payer)
 S LCT=1,DIS(LCT)=$$FO^IBCNEUT1($E($P(RPT,U,2),1,30),32,"L")_$$FO^IBCNEUT1($P(RPT,U,3),14,"L")_$$FO^IBCNEUT1($P(RPT,U,10),17,"L")
 S DIS(LCT)=DIS(LCT)_$$FO^IBCNEUT1($P(RPT,U,6),19,"L")_$$FO^IBCNEUT1($P(RPT,U,7),16,"L")_$$FO^IBCNEUT1($P(RPT,U,8),15,"L")
 I $P(RPT,U,4)'=""!($P(RPT,U,5)'="") S DIS(LCT)=DIS(LCT)_$$FO^IBCNEUT1($P(RPT,U,4),5,"R")_"/"_$$FO^IBCNEUT1($P(RPT,U,5),7,"L")
 I $P(RPT,U,4)="",$P(RPT,U,5)="" S DIS(LCT)=DIS(LCT)_$E(SPACES,1,13)   ; If nothing to print, substitute spaces.
 S DIS(LCT)=DIS(LCT)_$$FO^IBCNEUT1($P(RPT,U,9),3,"L")
 ;
 I PDET=1 D  ; Format Ins Co detail
 . I $O(INCO(""))'="" D
 . . S LCT=LCT+1
 . . S DIS(LCT)="  Linked Insurance Companies       Address"_$E(SPACES,1,30)_"City, State, Zip code"
 . . S (INSNA,INSNO,INSDATA)=""
 . . F  S INSNA=$O(INCO(INSNA)) Q:INSNA=""  D
 . . . F  S INSNO=$O(INCO(INSNA,INSNO)) Q:INSNO=""  D
 . . . . S INSDATA=INCO(INSNA,INSNO)
 . . . . S LCT=LCT+1,DIS(LCT)="  "_$$FO^IBCNEUT1(INSNA,33,"L")_$$FO^IBCNEUT1($P(INSDATA,U,1),37,"L")
 . . . . S CITY=$P(INSDATA,U,2)
 . . . . ; don't display ',' if no address/state on file
 . . . . S STZIP=""
 . . . . I $P(INSDATA,U,3)'="" S STZIP=", "_$P(INSDATA,U,3)
 . . . . I $P(INSDATA,U,4)'="" S STZIP=STZIP_" "_$P(INSDATA,U,4)
 . . . . S CSZ=$E(CITY,1,39-$L(STZIP))_STZIP
 . . . . S DIS(LCT)=DIS(LCT)_$$FO^IBCNEUT1(CSZ,41,"L")
 . . . . I $P(INSDATA,U,5)'=""!($P(INSDATA,U,6)'="") S DIS(LCT)=DIS(LCT)_$$FO^IBCNEUT1($P(INSDATA,U,5),5,"R")_"/"_$$FO^IBCNEUT1($P(INSDATA,U,6),7,"L")
 . . . . I $P(RPT,U,5)="",$P(RPT,U,6)="" S DIS(LCT)=DIS(LCT)_$E(SPACES,1,13)   ; If nothing to print, substitute spaces.
 ; IB*2*687/DTG end change for space DISPDATA - DIS,RPTDATA - RPT,INCODATA - INCO,INSNAME - INSNA,INSREC - INSR
 S LCT=LCT+1
 Q
 ;
EHDR ; EXCEL header
 N HDR,X
 S HDR="",X="Payer Link Report^"
 W X
 ; IB*2*687/DTG start change for space
 I PPYR="" S HDR=$S(PTYPE=1:"Unlinked",PTYPE=2:"Linked",1:"All")_" Payers"_"^"
 ; If not "unlinked" check for detail option.
 I PTYPE'=1 S HDR=HDR_$S(PDET=1:"With",1:"Without")_"  Ins. Co. Detail"_"^" W HDR
 ; IB*2*687/DTG end change for space
 W $$FMTE^XLFDT($$NOW^XLFDT,1)
 ;
 I PPYR'="" W !,"For Single Payer:"_"^"_$P(PPYR,"^",2)
 ;
 S X="Payer Name^VA ID^Elig Prof EDI#^Elig Inst EDI#^# Linked Ins. Co.^eIV Natl Enabled^eIV Locally Enabled^eIV Auto Update^IIU Natl Enabled^IIU Locally Enabled^Receive IIU Data"
 I PDET=1 S X=X_"^Company Name^St Address^City^ST^Zip^Claims Prof EDI#^Claims Inst EDI#"
 W !,X
 Q 
 Q 
 ;
 ; IB*2*687/DTG start change for space
LINE(DIS) ; Print data
 N LNCT,LNTOT,NWPG
 S LNTOT=+$O(DIS(""),-1)
 S NWPG=0
 F LNCT=1:1:LNTOT D  Q:(IBPXT!$G(ZTSTOP))
 . I POUT="R" D  Q:(IBPXT!$G(ZTSTOP))
 . . I $Y+1>MAXCNT!('IBPGC) D HEADER(APP,HDRNAME,HDRDATE) S NWPG=1 I $G(ZTSTOP)!IBPXT Q
 . W !,DIS(LNCT)
 ; IB*2*687/DTG end change for space
 Q
LINEX Q
 ;
CENTER(LINE,XWIDTH) ;return centered line OFFSET
 ; IB*2*687/DTG start change for space
 N LE,OF
 S LE=$L(LINE),OF=XWIDTH-$L(LINE)\2
 Q OF
 ; IB*2*687/DTG end change for space
 ;

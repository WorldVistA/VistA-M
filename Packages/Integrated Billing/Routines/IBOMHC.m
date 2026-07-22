IBOMHC ;SAB/EDE -  COMPACT ACT COPAY Review Report ;JUL 12 2021
 ;;2.0;INTEGRATED BILLING;**709,720,736,772,790**;21-MAR-94;Build 20
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to $$CODEC^ICDEX in ICR #5747
 ; Reference to $$RX^PSO52API in ICR #4820
 ; Reference to $$GETCPT^SDOE in ICR #2546
 ; Reference to $$RXSITE^PSOBPSUT in ICR #4701
 ; Reference to FILE #405 in ICR #419
 ; Reference to FILE #40.8 in ICR #417
 ; Reference to $$REQUEST^PXCOMPACTIB in ICR #7472
 ;
 Q
 ;
EN ;
 ;
 N IBSTART,IBEND,IBEXCEL,IBSTOP,IBFLOW
 N POP,ZTDESC,ZTRTN,ZTSAVE,ZTSK,%ZIS
 ;
 ;Initialze Date fields 
 S (IBSTART,IBEND)="",IBSTOP=0
 ;
 ;Get the start and end dates.
 S IBSTART=$$GETSD("Date Copay Billed",1) Q:IBSTART'>0  ; Get the start date  IB*2.0*790
 S IBEND=$$GETSD("Date Copay Billed",2) Q:IBEND'>0  ; Get the end date  IB*2.0*790
 ;
 W !!,"** This report can take a while to run and may be queued to run after hours. **",!
 ;
 ; export to Excel?
 S IBEXCEL=$$GETEXCEL^IBUCMM() Q:IBEXCEL<0  ;  IB*2.0*790
 ;
 ;Display Excel format message
 I IBEXCEL D PRTEXCEL^IBUCMM()
 W:'IBEXCEL !!,"Report requires 132 columns.",!  ; IB*2.0*720
 ;
 ; ask for device
 K IOP,IO("Q")
 S %ZIS="MQ",%ZIS("B")="",POP=0 D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q  ; queued report: ask if print queue should be cleared, then queue task
 .S ZTDESC="COMPACT ACT Copay Review Report"
 .S ZTRTN="MAIN^IBOMHC"
 .S ZTSAVE("IBSTART")=IBSTART,ZTSAVE("IBEXCEL")=IBEXCEL,ZTSAVE("IBEND")=IBEND,ZTSAVE("ZTREQ")="@"
 .D ^%ZTLOAD,HOME^%ZIS
 .I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",!
 .Q
 ;
 D MAIN
 Q
 ;
MAIN ; Main routine to gather and print the report 
 ;
 ;INPUT - (Optional, not a parameter)
 ;
 ;If running in test mode and sending the report to Excel, direct the ATS to the Excel Tests
 I IBEXCEL S ^TMP($J,"IBUATS","REPORT","COMPACT","MODE")="EXCEL"
 ;
 K ^TMP($J,"IBOMHC")
 D CLLCTAPI
 D PRINT(IBSTART,IBEND)
 D ^%ZISC
 K ^TMP($J,"IBOMHC")
 Q
 ;
GETSD(DESCR,TYPE) ;
 ;
 ;INPUT - DESCR = Type of Date to enter
 ;        TYPE  = 1 - Start Date
 ;              = 2 = End Date
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y  ; IB*2.0*790
 N CADT,DT7,TYPESTR
 S TYPESTR=$S(TYPE=1:"Start",1:"End")
 S CADT=$P($G(^IBE(350.9,1,71)),U,2)  ; COMPACT ACT Benefit start date from 350.9/71.02
 S DT7=$$FMADD^XLFDT(DT,-7)  ; today's date - 7 days
 S:TYPE=1 DIR(0)="DA^"_CADT_":"_DT_":EX"
 S:TYPE=2 DIR(0)="DA^"_IBSTART_":"_DT_":EX"
DATESEL1 ;
 S DIR("A")=TYPESTR_" with "_$S($G(DESCR)'="":DESCR_" ",1:"")_": "
 S DIR("B")=$$FMTE^XLFDT($S(DT7<CADT:CADT,1:DT7),"1D")
 S DIR("?",1)="   Please enter a valid "_TYPESTR_" Date."
 S DIR("?",2)="   A date must not be in the future."
 S:TYPE=1 DIR("?")="   A date may not precede COMPACT ACT Benefit "_TYPESTR_" Date ("_$$FMTE^XLFDT(CADT)_")"
 S:TYPE=2 DIR("?")="   The End Date must not precede the start date entered above."
 D ^DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q -1  ; IB*2.0*790
 I TYPE=2,Y<IBSTART W !,"     End Date must not precede the Start Date." G DATESEL1
 Q Y
 ;
ISELIG(DFN) ; check if given patient is COMPACT Act eligible
 ;
 ; DFN - patient's DFN
 ;
 ; returns 1 if patient is COMPACT Act eligible, 0 otherwise
 ;
 N RES,VACOM
 S RES=0 I +$G(DFN)>0 D CAI^VADPT S RES=+$G(VACOM("CAI"))
 Q RES
 ;
PRINT(IBSTRT,IBEND) ; Print the results
 N IBI,IBX,IBPAGE,IBLN,QUIT,IBDOS,IBNM,IBDIV,IBDIVIEN,IBCT,IBLTCT,IBOUTDATA
 U IO  ; IB*2.0*790
 ;
 ; Print Header and Column Headers for Excel Output Version of report
 I IBEXCEL D
 .S IBOUTDATA="COMPACT ACT Copay Review Report from "_$$FMTE^XLFDT(IBSTRT)_" to "_$$FMTE^XLFDT($P(IBEND,"."))_"   Date of Report: "_$$FMTE^XLFDT($$DT^XLFDT())
 .W !,IBOUTDATA
 .S IBOUTDATA="Patient Name"_U_"ID"_U_"Bill Number"_U_"Stat"_U_"Descr."_U_"Dt of Serv."_U_"Amount ($)"
 .W !,IBOUTDATA
 .Q
 ;
 ; Print Header and Column headers for Screen Output Version of report
 I 'IBEXCEL D
 .S IBPAGE=0 D HDR(IBSTRT,IBEND)
 .Q
 ;
 ;Exit if no data found.
 I '$D(^TMP($J,"IBOMHC")) D  Q
 .W !!!,"   There were no copayments within the specified date range that were potentially COMPACT ACT eligible",!!!
 .I $E(IOST,1,2)["C-",'$D(ZTQUEUED) W !,$$CJ^XLFSTR("End of Report.",IOM),! D PAUSE  ;  IB*2.0*790
 ;
 ;Set Line counter for IBTEST Output for excel version of the report.
 S IBLTCT=0
 ;Print the report
 S IBNM="" F  S IBNM=$O(^TMP($J,"IBOMHC","IDX",IBNM)) Q:IBNM=""  D  Q:$G(QUIT)
 .S IBDOS=0 F  S IBDOS=$O(^TMP($J,"IBOMHC","IDX",IBNM,IBDOS)) Q:'IBDOS  D  Q:$G(QUIT)
 ..S IBI=0 F  S IBI=$O(^TMP($J,"IBOMHC","IDX",IBNM,IBDOS,IBI)) Q:'IBI  D  Q:$G(QUIT)
 ...S IBX="" F  S IBX=$O(^TMP($J,"IBOMHC","IDX",IBNM,IBDOS,IBI,IBX)) Q:IBX=""  D  Q:$G(QUIT)
 ....S IBCT=^TMP($J,"IBOMHC","IDX",IBNM,IBDOS,IBI,IBX),IBDATA=$G(^TMP($J,"IBOMHC",IBCT))
 ....I IBEXCEL D  Q
 ..... S IBOUTDATA=$E(IBNM,1,18)_U_$P(IBDATA,U,2,7)
 ..... W !,IBOUTDATA
 ....W !,$E(IBNM,1,18),?20,$P(IBDATA,U,2),?26,$P(IBDATA,U,3),?39,$P(IBDATA,U,4),?44,$P(IBDATA,U,5),?58,$P(IBDATA,U,6)
 ....W ?71,$$RJ^XLFSTR($J($P(IBDATA,U,7),10,2),11)
 ....S IBLN=IBLN+1
 ....I IBLN>(IOSL-3) D HDR(IBSTRT,IBEND)
 ....Q
 ...Q
 ..Q
 .Q
 Q:$G(QUIT)  I $E(IOST,1,2)["C-",'$D(ZTQUEUED) W !,$$CJ^XLFSTR("End of Report.",IOM),! D PAUSE  ;  IB*2.0*790
 Q
 ;
GETPMDX(IBPM,IBDXARY) ;Retrieve Dx's from the PTF file via the Patient Movement file.
 ;
 N IBADPM,IBPTF
 ;
 S IBADPM=$$GET1^DIQ(405,IBPM_",",.14,"I")
 S IBPTF=$$GET1^DIQ(405,$S(IBADPM=IBPM:IBPM,1:IBADPM)_",",.16,"I")
 Q:IBPTF=""
 D GETPTFDX(IBPTF,.IBDXARY)
 Q
 ;
GETPTFDX(IBPTF,IBDXARY) ; Retrieve all of the DX codes assigned during an outpatient visit
 ;
 ;INPUT:   IBPTF   - IEN of PTF record in File 45
 ;OUTPUT:  IBDXARY - Array of Diagnoses for the PTF record passed in
 ;       
 N IBCT,IBLP,IBMVTYP,IBDT,IBDXIEN,IBDX,IBPTFD
 ;
 K ^TMP($J,"IBDX")
 ;
 S IBCT=0
 D PTFDX^IBCSC4F(IBPTF)
 S IBMVTYP=""
 F  S IBMVTYP=$O(^TMP($J,"IBDX",IBMVTYP)) Q:IBMVTYP=""  D
 . S IBDT=0
 . F  S IBDT=$O(^TMP($J,"IBDX",IBMVTYP,IBDT)) Q:'IBDT  D
 . . S IBLP=0
 . . F  S IBLP=$O(^TMP($J,"IBDX",IBMVTYP,IBDT,IBLP)) Q:'IBLP  D
 . . . S IBPTFD=$G(^TMP($J,"IBDX",IBMVTYP,IBDT,IBLP))
 . . . S IBDXIEN=$P(IBPTFD,U),IBDX=$$CODEC^ICDEX(80,IBDXIEN)
 . . . I IBDX'="",'$D(IBDXARY(IBDX)) S IBDXARY(IBDX)=""
 ;
 K ^TMP($J,"IBDX")
 Q
 ;
GETPCEDX(IBPCE,IBDXARY)  ; Retrieve the list of diagnoses associated with an Outpatient Encounter
 ;
 N IBDX,IBDXB,IBDXC,IBI,IBPCD,K,IBDT,IBID,IBIFN
 S (IBDX,IBDXB)=""
 ;
 ;Extract the Diagnosis info from the encounter
 D OEDX^IBCU81(IBPCE,.IBDX,.IBDXB)
 ;Loop through the Billable diagnoses and store in IBDXARY for further review
 S IBI=0
 F  S IBI=$O(IBDXB(IBI)) Q:'IBI  D
 .S IBDXC=$$CODEC^ICDEX(80,IBI)
 .I IBDXC'="",'$D(IBDXARY(IBDXC)) S IBDXARY(IBDXC)=""
 .Q
 ;
 Q
 ;
GETPCECP(IBPCE,IBCPTARY)  ; Retrieve the list of CPT Codes associated with an Outpatient Encounter
 ;
 N IBCPT,IBCPTRET,IBERR,IBLP
 S IBCPT="IBCPTRET"
 ;
 ; Call the PCE software to retrieve the CPT code info for the visit in array IBCPTARR via indirection.
 D GETCPT^SDOE(IBPCE,.IBCPT,.IBERR)
 S IBLP=0 F  S IBLP=$O(IBCPTRET(IBLP)) Q:'IBLP  S IBCPTARY($$GET1^DIQ(81,$P(IBCPTRET(IBLP),U)_",",.01,"E"))=""
 Q
 ;
HDR(IBSTRT,IBEND) ; print header
 ;INPUT - IBSTRT - Start Date for the report
 ;        IBEND  - End Date for the report
 ;
 N IBX,I,IBCT
 I IBPAGE>0,$E(IOST,1,2)["C-",'$D(ZTQUEUED) D PAUSE I $G(QUIT) Q
 W @IOF
 S IBPAGE=IBPAGE+1
 W !,"COMPACT ACT Copay Review Report from ",$$FMTE^XLFDT(IBSTRT)," to ",$$FMTE^XLFDT($P(IBEND,".")),?80,"Date of Report: ",?96,$$FMTE^XLFDT($$DT^XLFDT()),?120,"Page: ",IBPAGE
 W !!,"Patient Name",?22,"ID",?26,"Bill Number",?39,"Stat",?44,"Descr.",?58,"Dt of Serv.",?72,"Amount ($)"    ; IB*2.0*720 IB*2.0*790 
 W ! F IBX=1:1:132 W "-"  ; IB*2.0*720
 S IBLN=6
 Q
 ;
PAUSE    ;Press Return to Continue
 N DIR,DUOUT,DTOUT,DIRUT
 W !
 S DIR(0)="E" D ^DIR
 I $D(DIRUT) S QUIT=1
 W !
 Q
 ;
 ;GETDIV() ; Ask to filter by Division.  If so, select the division.
 ;
 ;N DIROUT,DTOUT,DUOUT,DIRUT,X,Y
 ; Ask to filter by division.
 ;S DIR(0)="Y",DIR("B")="NO"
 ;S DIR("A")="Do you wish to filter this report by division"
 ;S DIR("?")="^S IBOFF=1 D HELP^IBJDF1H"
 ;D ^DIR K DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q -1  ; Escape command given
 ;S IBSD=+Y K DIROUT,DTOUT,DUOUT,DIRUT
 ;
 ;Q:'IBSD 0
 ;
 ;Sort/filter by division selected Ask for division
 ; - Issue prompt for division.
 ;K X,Y N X,Y   ;Clear and reset X and Y for the next prompt
 ;
 ;Prompt for Division to filter on.
 ;I IBSD D PSDR^IBODIV I Y<0 Q -1       ;Escape command given
 ;
 ;Q 1
 ;
CLLCTAPI ; review the copays in the specified period for possible COMPACT Act related copays using the
 ; $$REQUEST^PXCOMPACTIB(FILNUM,IEN) 
 ;
 N IBERROR,IBN,IBDATA,IBLP,IBBLNO,IBCT,VADM,IBVADM,I,IBCPT,IBDIV,IBADM  ; IB*2.0*720
 N DFN,DONE,IBBDSC,IBCHTYPE,IBCHRG,IBDOS,IBNM,IBRF,IBRFFL,IBRFIEN,IBDATA1,IBLPDT,IBSTATNM,IBSTAT,IBSTABR
 S IBCT=0
 S IBLPDT=IBSTART-.001,IBEND=IBEND+.999999
 ;Load list of possible DXs into a TMP array
 F  S IBLPDT=$O(^IB("D",IBLPDT)) Q:'IBLPDT  Q:IBLPDT>IBEND  D
 .S IBLP=0
 .;Loop through file #350 using the Date Billed field within the Start and end Period
 .F  S IBLP=$O(^IB("D",IBLPDT,IBLP)) Q:'IBLP  D
 ..;kill and re-init arrays
 ..K VADM
 ..; Get Copay Data
 ..S IBDATA=$G(^IB(IBLP,0)),IBDATA1=$G(^IB(IBLP,1))
 ..S IBSTATNM=$$GET1^DIQ(350,IBLP_",",.05,"E")
 ..I "^BILLED^HOLD - RATE^HOLD - REVIEW^ON HOLD^"'[(U_IBSTATNM_U) Q
 ..S DFN=$P(IBDATA,U,2) I '$$ISELIG(DFN) Q
 ..;Extract field (.04)[RESULTING FROM]
 ..S IBRF=$P(IBDATA,U,4)
 ..;If no file number or ":" in field, skip and go to the next.
 ..Q:IBRF'[":"
 ..;Extract the file from the 1st ":" piece, IEN from the second.
 ..S IBRFFL=$P(IBRF,":")
 ..S IBRFIEN=$P(IBRF,":",2)
 ..;If the copay is a RX copay, quit.
 ..Q:$$GET1^DIQ(350.1,$P(IBDATA,U,3)_",",.11,"I")=5
 ..;
 ..; If either the file or the IEN are non-numeric (NULL, space, or character), then quit as entry cannot be checked for COMPACT eligibility.
 ..Q:"^405^409.68^45^9000010^"'[(U_IBRFFL_U)  ; IB*2.0*790
 ..Q:IBRFIEN'?1.N
 ..;
 ..; Call COMPACT EoC API to determine if COMPACT Eligible. Quit if not.
 ..Q:$$REQUEST^PXCOMPACTIB(IBRFFL,IBRFIEN)<1  ; IB*2.0*790
 ..;
 ..;Extract date of service
 ..S IBDOS="" S:IBRFFL'=52 IBDOS=$P(IBDATA,U,14)  ; IB*2.0*772
 ..Q:'IBDOS
 ..; Check division  IB*2.0*720
 ..S IBDIV=""
 ..I IBRFFL=405 S IBDIV=$$INP^IBJDF2($P(IBRF,":",2))
 ..I IBRFFL=45 S IBADM=$O(^DGPM("APTF",$P(IBRF,":",2),0)) S:IBADM IBDIV=$$INP^IBJDF2(IBADM)
 ..I IBRFFL=409.68 S IBDIV=$$OPT^IBJDF2(IBDOS,DFN)
 ..;
 ..D DEM^VADPT M IBVADM=VADM  ; IB*2.0*720 moved line from above
 ..S IBNM=IBVADM(1),IBCHTYPE=$P(IBDATA,U,3) Q:IBCHTYPE=""  Q:$D(^TMP($J,"IBOMHC","IDX",IBNM,IBDOS,IBCHTYPE))  ; IB*2.0*720
 ..Q:$$GET1^DIQ(350.1,IBCHTYPE,.05,"E")'="NEW"
 ..; retrieve needed data for report
 ..S IBID=$E(IBVADM(1),1)_$P($P(IBVADM(2),U,2),"-",3)
 ..S IBSTAT=$P(IBDATA,U,5)
 ..I IBSTATNM["HOLD" S IBSTABR="HOLD"
 ..I IBSTATNM'["HOLD" S IBSTABR=$E($$GET1^DIQ(350.21,IBSTAT_",",.03,"E"),1,4)
 ..S IBBDSC=$E($$GET1^DIQ(350.1,IBCHTYPE,.01,"E"),1,12)
 ..S IBCHRG=$P(IBDATA,U,7),IBBLNO=$P(IBDATA,U,11)
 ..S IBCT=IBCT+1
 ..S ^TMP($J,"IBOMHC",IBCT)=IBNM_U_IBID_U_IBBLNO_U_IBSTABR_U_IBBDSC_U_$$FMTE^XLFDT(IBDOS,9)_U_IBCHRG   ; IB*2.0*720 IB*2.0*790 
 ..S ^TMP($J,"IBOMHC","IDX",IBNM,IBDOS,IBCHTYPE,0)=IBCT,^TMP($J,"IBOMHC","IDX1",DFN,IBDOS)=""  ; IB*2.0*720
 ..Q
 .Q
 ;
 Q

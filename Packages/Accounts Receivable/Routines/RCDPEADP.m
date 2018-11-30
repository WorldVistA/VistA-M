RCDPEADP ;OIFO-BAYPINES/PJH - AUTO-DECREASE REPORT ;Nov 23, 2014@12:48:50
 ;;4.5;Accounts Receivable;**298**;Mar 20, 1995;Build 121
 ;Per VA Directive 6402, this routine should not be modified.
 ;Read ^DGCR(399) via Private IA 3820
 ;Read ^DG(40.8) via Controlled IA 417
 ;Read ^IBM(361.1) via Private IA 4051
 ;Use DIVISION^VAUTOMA via Controlled IA 664
 ;
RPT ; entry point for Auto-Decrease Adjustment report [RCDPE AUTO-DECREASE REPORT]
 N %ZIS,RCDISP,RCDIV,RCDTRNG,RCPAGE,RCPAY,RCPROG,RCRANGE,RCSORT,RCVAUTD,STANAM,STANUM,VAUTD,X,Y
 ;Initialize page and start point
 S (RCDTRNG,RCPAGE)=0,RCPROG="RCDPEADP"
 ;Select Filter/Sort by Division
 D STADIV Q:'RCDIV
 ;Select sort criteria 
 S DIR(0)="SA^C:CLAIM;P:PAYER;N:PATIENT NAME;",DIR("A")="SORT BY (C)LAIM #, (P)AYER or PATIENT (N)AME?: ",DIR("B")="CLAIM" D ^DIR K DIR Q:$D(DTOUT)!$D(DUOUT)
 S RCSORT=Y
 ;Select display order within sort
 S DIR("A")="SORT "_$S(RCSORT="C":"CLAIM",RCSORT="P":"PAYER",1:"PATIENT NAME")_" (F)IRST TO LAST OR (L)AST TO FIRST?: "
 S DIR(0)="SA^F:FIRST TO LAST;L:LAST TO FIRST",DIR("B")="FIRST TO LAST" D ^DIR K DIR Q:$D(DTOUT)!$D(DUOUT)
 I Y="L" S RCSORT=RCSORT_";-"
 ;Select Date Range for Report
 S RCRANGE=$$DTRNG() Q:RCRANGE=0
 ;Select Display Type
 S RCDISP=$$DISPTY() Q:RCDISP=-1
 ;Display capture information for Excel
 I RCDISP D INFO^RCDPEM6
 ;Select output device
 S %ZIS="QM" D ^%ZIS Q:POP
 ;Option to queue
 I 'RCDISP,$D(IO("Q")) D  Q
 .N ZTDESC,ZTQUEUED,ZTRTN,ZTSAVE,ZTSK
 .S ZTRTN="REPORT^RCDPEADP"
 .S ZTDESC="EDI LOCKBOX AUTO-DECREASE REPORT"
 .S ZTSAVE("RC*")="",ZTSAVE("VAUTD")=""
 .D ^%ZTLOAD
 .I $D(ZTSK) W !!,"Task number "_ZTSK_" has been queued."
 .E  W !!,"Unable to queue this job."
 .K ZTSK,IO("Q") D HOME^%ZIS
 ;
 ;Compile and Print Report
 D REPORT
 Q
 ;
REPORT ;Compile and print report
 U IO
 N DTOTAL,GLOB,GTOTAL,RCHDR,ZTREQ
 K ^TMP(RCPROG,$J)
 S GLOB=$NA(^TMP(RCPROG,$J))
 ;Scan ERA file for entries in date range
 D COMPILE
 ;
 ; header information
 S RCHDR("START")=$$FMTE^XLFDT($P(RCRANGE,U,2),2)
 S RCHDR("END")=$$FMTE^XLFDT($P(RCRANGE,U,3),2)
 S RCHDR("RUNDATE")=$$FMTE^XLFDT($$NOW^XLFDT,"2S")
 ; Format Division filter
 S RCHDR("DIVISIONS")=$S(RCDIV=2:$$LINE(.RCVAUTD),1:"ALL")
 ;
 ;Display Report
 D DISP
 ;Clear ^TMP global
 K ^TMP(RCPROG,$J),^TMP("RCSELPAY",$J)
 D ^%ZISC  ; close device
 Q
 ;
COMPILE ;Generate the Auto-Decrease report ^TMP array
 N ADDATE,END,ERAIEN,RCNTR,RCRZ,STA,STNAM,STNUM
 ;
 ;Date Range
 S ADDATE=$$FMADD^XLFDT($P(RCRANGE,U,2),-1),END=$P(RCRANGE,U,3)
 S RCNTR=0  ; record counter
 ; ^RCY(344.4,0) = "ELECTRONIC REMITTANCE ADVICE^344.4I^"
 ;  G cross-ref.   REGULAR    WHOLE FILE (#344.4)
 ;  Field:  AUTO-POST DATE  (344.41,9)
 ;Scan G index for ERA within date range
 F  S ADDATE=$O(^RCY(344.4,"G",ADDATE)) Q:'ADDATE  Q:(ADDATE\1)>END  D
 .S ERAIEN=""
 .F  S ERAIEN=$O(^RCY(344.4,"G",ADDATE,ERAIEN)) Q:'ERAIEN  D
 ..;Check division
 ..D ERASTA(ERAIEN,.STA,.STNUM,.STNAM)
 ..I RCDIV=2,'$D(RCVAUTD(STA)) Q
 ..;Scan index for auto-decreased claim lines within the ERA
 ..S RCRZ=""
 ..;Save claim line detail to ^TMP global
 ..F  S RCRZ=$O(^RCY(344.4,"G",ADDATE,ERAIEN,RCRZ)) Q:'RCRZ  D SAVE
 Q
 ;
SAVE ;Put the data into the ^TMP global
 N AMOUNT,CARC,CLAIM,DATE,EOBIEN,PAYNAM,PTNAM,SUB,Y
 ;Payer name from ERA record
 S PAYNAM=$P($G(^RCY(344.4,ERAIEN,0)),U,6)
 ;Format Auto-Decrease date
 S DATE=$$FMTE^XLFDT(ADDATE,"2S")
 ;Auto-Decrease Amount
 S AMOUNT=$P($G(^RCY(344.4,ERAIEN,1,RCRZ,5)),U,4)
 Q:+AMOUNT=0
 ;Get pointer to EOB file #361.1 from ERA DETAIL
 S EOBIEN=+$P($G(^RCY(344.4,ERAIEN,1,RCRZ,0)),U,2)
 ;Claim
 S CLAIM=$$CLAIM(EOBIEN)
 ;Patient name from claim file #399
 S PTNAM=$$PNM4^RCDPEWL1(ERAIEN,RCRZ) S:PTNAM="" PTNAM="(unknown)"
 ;CARC code
 S CARC=$$CARC(EOBIEN)
 S RCNTR=RCNTR+1
 ;If EXCEL sorting is done in EXCEL
 I RCDISP S SUB="EXCEL",SUB("SORT")=$G(@GLOB@(SUB))+1,@GLOB@(SUB)=SUB("SORT")
 ;Otherwise sort by DATE and selected criteria
 E  S SUB=ADDATE,SUB("SORT")=$S($E(RCSORT)="C":CLAIM,$E(RCSORT)="P":PAYNAM,1:PTNAM)
 ;Update ^TMP global
 S @GLOB@(SUB,SUB("SORT"),RCNTR)=STNAM_U_STNUM_U_CLAIM_U_PTNAM_U_PAYNAM_U_AMOUNT_U_DATE_U_CARC
 ;Update totals for individual date
 S $P(DTOTAL(ADDATE),U)=$P($G(DTOTAL(ADDATE)),U)+1,$P(DTOTAL(ADDATE),U,2)=$P($G(DTOTAL(ADDATE)),U,2)+AMOUNT
 ;Update totals for date range
 S $P(GTOTAL,U)=$P($G(GTOTAL),U)+1,$P(GTOTAL,U,2)=$P($G(GTOTAL),U,2)+AMOUNT
 Q
 ;
DISP ; Format the display for screen/printer or MS Excel
 N MODE,SUB,RCDATA,RCRDNUM,RCSTOP,SUB,Y
 ;
 ;use the selected device
 U IO
 ;
 S SUB="",RCSTOP=0,MODE=$S(RCSORT["-":-1,1:1)  ; mode for $ORDER
 F  S SUB=$O(@GLOB@(SUB)) Q:SUB=""  D  Q:RCSTOP
 .;Display Header
 .I RCPAGE D ASK(.RCSTOP,0) Q:RCSTOP
 .D HDR
 .;
 .S SUB("SORT")=""
 .F  S SUB("SORT")=$O(@GLOB@(SUB,SUB("SORT")),MODE) D:SUB("SORT")=""&('RCDISP) TOTALD(SUB) Q:SUB("SORT")=""  D  Q:RCSTOP
 ..S RCRDNUM=0 F  S RCRDNUM=$O(@GLOB@(SUB,SUB("SORT"),RCRDNUM)) Q:'RCRDNUM!RCSTOP  D
 ...S RCDATA=@GLOB@(SUB,SUB("SORT"),RCRDNUM)  ;Auto-Decreased Claim
 ...I RCDISP W !,RCDATA Q  ; Excel spreadsheet
 ...I $Y>(IOSL-6) D ASK(.RCSTOP,0) Q:RCSTOP  D HDR
 ...S Y=$E($P(RCDATA,U,3),1,12) ;CLAIM
 ...S $E(Y,15)=$E($P(RCDATA,U,4),1,20)  ;PATIENT
 ...S $E(Y,35)=$E($P(RCDATA,U,5),1,19) ;PAYER
 ...S $E(Y,55)=$J($P(RCDATA,U,6),7,2) ;AMOUNT
 ...S $E(Y,67)=$J($P(RCDATA,U,7),8) ;DATE
 ...S $E(Y,76)=$P(RCDATA,U,8) ;CARC
 ...W !,Y
 ;
 ;Grand totals
 I $D(GTOTAL) D
 .;Print grand total if not EXCEL
 .I 'RCSTOP,'RCDISP D TOTALG
 .;Report finished
 .I 'RCSTOP W !,$$ENDORPRT^RCDPEARL,! D ASK(.RCSTOP,1)
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
ASK(STOP,TYP) ; Ask to continue, if TYP=1 then prompt to finish
 ; If passed by reference, RCSTOP is returned as 1 if print is aborted
 I $E(IOST,1,2)'["C-" Q
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S:$G(TYP)=1 DIR("A")="Enter RETURN to finish"
 S DIR(0)="E" W ! D ^DIR
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
CARC(EOBIEN) ;Get first adjustment reason code from EOB
 N ADJSUB,ADJSUB1
 S ADJSUB=$O(^IBM(361.1,EOBIEN,10,0)) Q:'ADJSUB ""
 S ADJSUB1=$O(^IBM(361.1,EOBIEN,10,1,0)) Q:'ADJSUB1 ""
 Q $P($G(^IBM(361.1,EOBIEN,10,ADJSUB,1,ADJSUB1,0)),U)
 ;
CLAIM(EOBIEN) ;function, Get claim number from AR
 Q:'$G(EOBIEN)>0 "(no EOB IEN)"
 N CLAIM,CLAIMIEN,REC430
 ;Default to EOB claim
 S CLAIM=$$EXTERNAL^DILFD(344.41,.02,,EOBIEN)
 ;Get ^DGCR(399 pointer
 S CLAIMIEN=$P($G(^IBM(361.1,EOBIEN,0)),U) Q:'CLAIMIEN "(no Claim IEN)"  ;CLAIM
 ;Use DINUM to get AR Claim #430
 S REC430=$G(^PRCA(430,CLAIMIEN,0)) Q:$P(REC430,U)="" "(CLAIM not found)"  ;CLAIM
 ;Return claim (nnn-Knnnnnn)
 Q $P(REC430,U)
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
 N MSG,Y,DIV,SUB,Z0,Z1
 ;
 I 'RCDISP D  Q:RCSTOP
 .S RCPAGE=RCPAGE+1
 .W @IOF
 .S MSG(1)="                     EDI LOCKBOX AUTO-DECREASE ADJUSTMENT REPORT "
 .S MSG(1)=MSG(1)_"       Page: "_RCPAGE
 .S MSG(2)="                        RUN DATE: "_RCHDR("RUNDATE")
 .S Z0="DIVISIONS: "_RCHDR("DIVISIONS")
 .S MSG(3)=$S($L(Z0)<75:$J("",75-$L(Z0)\2),1:"")_Z0
 .S MSG(4)="               DATE RANGE: "_RCHDR("START")_" - "_RCHDR("END")_" (Date Decrease Applied)"
 .S MSG(5)=""
 .S MSG(6)="CLAIM #       PATIENT NAME        PAYER              DECREASE AMT   DATE   CARC"
 .S MSG(7)="==============================================================================="
 .D EN^DDIOL(.MSG)
 I RCDISP D
 .W !,"STATION^STATION NUMBER^CLAIM #^PATIENT NAME^PAYER^DECREASE AMOUNT^DATE^CARC"
 Q
 ;
LINE(DIV) ;List selected stations
 N LINE,P,SUB
 S LINE="",SUB="",P=0
 F  S SUB=$O(DIV(SUB)) Q:'SUB  S P=P+1,$P(LINE,", ",P)=$G(DIV(SUB))
 Q LINE
 ;
STADIV ;Division/Station Filter/Sort
 ;Sort selection
 N DIR,DUOUT,Y
 S RCDIV=0
 ;Division selection - IA 664
 ;RETURNS Y=-1 (quit), VAUTD=1 (for all),VAUTD=0 (selected divisions in VAUTD)
 D DIVISION^VAUTOMA Q:Y<0
 ;If ALL selected
 I VAUTD=1 S RCDIV=1 Q
 ;If some DIVISIONS selected
 S RCDIV=2
 M RCVAUTD=VAUTD  ; save selected divisions
 Q
 ;
TOTALS ;Print totals for EXCEL
 N DAY,DAMT,DCNT
 S DAY=""
 F  S DAY=$O(DTOTAL(DAY)) Q:'DAY  D  Q:RCSTOP
 .;Day totals
 .D TOTALD(DAY)
 ;Grand totals
 D TOTALG
 Q
 ;
TOTALD(DAY) ;Total for a day
 N DCNT,DAMT,Y
 I 'RCDISP,$Y>(IOSL-6) D HDR Q:RCSTOP
 S DCNT=$P(DTOTAL(DAY),U),DAMT=$P(DTOTAL(DAY),U,2)
 S Y="**TOTALS FOR DATE: "_$$FMTE^XLFDT(DAY,2),$E(Y,35)="    # OF DECREASE ADJUSTMENTS: "_DCNT
 W !!,Y
 S Y="",$E(Y,28)="TOTAL AMOUNT OF DECREASE ADJUSTMENTS: $"_$J(DAMT,3,2) W !,Y
 Q
 ;
TOTALG ;Overall report total
 I 'RCDISP,$Y>(IOSL-6) D HDR Q:RCSTOP
 N Y
 W !!,"**** TOTALS FOR DATE RANGE:           # OF DECREASE ADJUSTMENTS: "_+$P(GTOTAL,U)
 S Y="",$E(Y,28)="TOTAL AMOUNT OF DECREASE ADJUSTMENTS: $"_$J((+$P(GTOTAL,U,2)),3,2)
 W !,Y,!
 Q
 ;

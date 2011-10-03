DGPTFRU1 ; ALB/SCK - PTF RECORDS CLOSEOUT RPT FOR MT INDICATOR = U ; 21 JULY 2003
 ;;5.3;Registration;**537**;Aug 13, 1993
 ;
EN ; Main entry point for report
 N DIR,DIRUT,DGBEG,DGEND,RSLT,Y,X
 ;
 S DIR("A")="Please Select Date Range for patient discharges",DIR(0)="SM^A:Previous Fiscal Year;B:Current Fiscal Year;O:Other Date Range"
 S DIR("B")="B"
 S DIR("?")="You may select either the previous fiscal year (A) or the current fiscal year (B) for the date range.  Select (O) if you choose to specify your own date range."
 D ^DIR K DIR
 Q:$D(DIRUT)
 S RSLT=Y
 ;
 I RSLT="A" D 
 . D PASTYR(.DGBEG,.DGEND)
 E  I RSLT="B" D
 . D CURYR(.DGBEG,.DGEND)
 E  D
 . D GETDT(.DGBEG,.DGEND)
 Q:'$G(DGBEG)!('$G(DGEND))
 W !!?3,"Date Range: "_$$FMTE^XLFDT(DGBEG)_" to "_$$FMTE^XLFDT(DGEND)
 ;
 N X,Y,IORVON,IORVOFF
 S X="IORVON;IORVOFF"
 D ENDR^%ZISS
 W:$D(IORVON) IORVON
 W !,"A 132-Column printer is required for this report."
 W !,"This report will NOT print correctly to the screen!"
 W:$D(IORVOFF) IORVOFF
 ;
 N ZTSAVE,ZTRTN,ZTDESC,POP,%ZIS,ZTQUEUED
 S %ZIS="Q" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  Q
 . S ZTSAVE("DGBEG")="",ZTSAVE("DGEND")="",ZTSAVE("DUZ")=""
 . S ZTRTN="RUN^DGPTFRU1"
 . S ZTDESC="PTF CLOSEOUT MT=U RPT"
 . D ^%ZTLOAD D HOME^%ZIS K IO("Q")
 D RUN
 D ^%ZISC
EXIT S:$D(ZTQUEUED) ZTREQ="@" Q
 ;
RUN ; Run report
 U IO
 K ^TMP("DGPTFRU",$J),^TMP("DGPTFRUS",$J)
 ;
 D BLD(DGBEG,DGEND)
 D CHKMT
 D SRTNAME
 D PRINT
 D MAIL
 K ^TMP("DGPTFRU",$J),^TMP("DGPTFRUS",$J)
 Q
 ;
PASTYR(DGBEG,DGEND) ; Set dates for previous fiscal year
 N CURYR,PRVYR,CURMN,%I
 ;
 ; Input/Output - See GETDT
 ;
 D NOW^%DTC
 S CURYR=%I(3),CURMN=%I(1)
 I CURMN>9 D
 . S CURYR=CURYR+1
 S PRVYR=CURYR-1
 S DGEND=$$FMADD^XLFDT(PRVYR_"1001",-1)
 S DGBEG=$$FMADD^XLFDT(PRVYR_"1001",-365)
 Q
 ;
CURYR(DGBEG,DGEND) ; Set dates for current fiscal year
 N CURYR,CURMN,%I
 ;
 ; Input/Output - See GETDT
 ;
 D NOW^%DTC
 S CURYR=%I(3),CURMN=%I(1)
 I CURMN<10 D
 . S CURYR=CURYR-1
 S DGBEG=CURYR_"1001"
 S DGEND=$P($$NOW^XLFDT,".")
 Q
 ;
GETDT(DGBEG,DGEND) ;  Get beginning and ending date for search
 ; Output   DGBEG   Beginning for date range, passed in by reference
 ;          DGEND   End of date range, passed in by reference
 ;          result  1 - If function successful
 ;                  0 - If function NOT successful (User quit)
 ;
 N DIR,DIRUT,Y
 ;
 W !!?3,"You have selected to specify your own date range.  Please note that by"
 W !?3,"doing so you may not generate an accurate picture of the transmitted PTF"
 W !?3,"closeouts where the means test indicator equals 'U'.",!
 ;
 S DIR(0)="DAO^:DT:EX"
 S DIR("A")="Beginning Date: "
 S DIR("?")="^D HELP^%DTC"
 D ^DIR
 I $D(DIRUT) D  Q
 . S DGBEG=0
 S DGBEG=Y
 ;
 S DIR(0)="DAO^:DT:EX"
 S DIR("A")="Ending Date: "
 D ^DIR
 I $D(DIRUT) D  Q
 . S DGEND=0
 S DGEND=Y
 Q
 ;
BLD(DGBEG,DGEND) ;  Build list of PTF records for discharge date range
 N DGX,DGMAX,CNT,DGPIEN,DFN
 ;
 ;  Input/Output - See GETDT
 ;
 S DGX=$$FMADD^XLFDT(DGBEG,0,0,0,-1) ; set inital search DT to beginning date minus one second
 S DGMAX=$$FMADD^XLFDT(DGEND,0,23,59,59) ; set search end date to end date plus one day
 ;
 S ^TMP("DGPTFRU",$J,0,"BEGIN")=$H
 F  S DGX=$O(^DGPT("ADS",DGX)) Q:'DGX  D  Q:DGX>DGMAX  ; Search PTF Discharge Dates
 . S DGPIEN=0
 . F  S DGPIEN=$O(^DGPT("ADS",DGX,DGPIEN)) Q:'DGPIEN  D
 . . S DFN=$P($G(^DGPT(DGPIEN,0)),U,1)
 . . Q:'DFN
 . . S ^TMP("DGPTFRU",$J,DFN,DGPIEN)=DGX_U_$$GET1^DIQ(45,DGPIEN,10,"I")_U_+$P($G(^DGPT(DGPIEN,0)),U,11)
 . . S ^TMP("DGPTFRU",$J,0,"CNT")=$G(^TMP("DGPTFRU",$J,0,"CNT"))+1
 S ^TMP("DGPTFRU",$J,0,"END")=$H
 Q
 ;
CHKMT ; Clean out all PTF records except those meeting the MT=U conditions
 N DFN,DGPIEN,DGIND
 ;
 S DFN=0
 F  S DFN=$O(^TMP("DGPTFRU",$J,DFN)) Q:'DFN  D
 . S DGPIEN=0
 . F  S DGPIEN=$O(^TMP("DGPTFRU",$J,DFN,DGPIEN)) Q:'DGPIEN  D
 . . S DGIND=$P($G(^TMP("DGPTFRU",$J,DFN,DGPIEN)),U,2)
 . . ; If the MT INDICATOR of any of the closeout records for the patient is a value other than 'U', then delete all the entries for the patient
 . . I DGIND'="U" D  Q
 . . . K ^TMP("DGPTFRU",$J,DFN)
 S ^TMP("DGPTFRU",$J,0,"END")=$H
 Q
 ;
SRTNAME ; Sort remaining PTF records by patient name and discharge date
 N DFN,DGNAME,DGPIEN,DGPDT
 ;
 S DFN=0
 F  S DFN=$O(^TMP("DGPTFRU",$J,DFN)) Q:'DFN  D
 . S DGNAME=$$GET1^DIQ(2,DFN,.01)
 . Q:DGNAME']""
 . S ^TMP("DGPTFRU",$J,0,"PATCNT")=$G(^TMP("DGPTFRU",$J,0,"PATCNT"))+1
 . S DGPIEN=0
 . F  S DGPIEN=$O(^TMP("DGPTFRU",$J,DFN,DGPIEN)) Q:'DGPIEN  D
 . . S ^TMP("DGPTFRUS",$J,DGNAME,DGPIEN)=DFN_U_$P($G(^TMP("DGPTFRU",$J,DFN,DGPIEN)),U,3)
 . . S ^TMP("DGPTFRU",$J,0,"FINAL CNT")=$G(^TMP("DGPTFRU",$J,0,"FINAL CNT"))+1
 S ^TMP("DGPTFRU",$J,0,"END")=$H
 Q
 ;
MAIL ; send message with report statistics
 N MSG,XMSUB,XMY,XMTEXT,XMDUZ
 ;
 S MSG(1)="Date Range for Report           "_$$FMTE^XLFDT(DGBEG,2)_" to "_$$FMTE^XLFDT(DGEND,2)
 S MSG(2)=""
 S MSG(3)="Report Started                  "_$$HTE^XLFDT(^TMP("DGPTFRU",$J,0,"BEGIN"),2)
 S MSG(4)="Report Finished                 "_$$HTE^XLFDT(^TMP("DGPTFRU",$J,0,"END"),2)
 S MSG(5)="Total Time for Report           "_$$HDIFF^XLFDT(^TMP("DGPTFRU",$J,0,"END"),^TMP("DGPTFRU",$J,0,"BEGIN"),3)
 S MSG(6)=""
 S MSG(7)="PTF Records Scanned   "_$J($FN(+$G(^TMP("DGPTFRU",$J,0,"CNT")),","),20)
 S MSG(8)="PTF Records Reported  "_$J($FN(+$G(^TMP("DGPTFRU",$J,0,"FINAL CNT")),","),20)
 S MSG(9)="Patient Count         "_$J($FN(+$G(^TMP("DGPTFRU",$J,0,"PATCNT")),","),20)
 ;
 S XMSUB="MEANS TEST = 'U' REPORT STATISTICS"
 S XMTEXT="MSG("
 S XMY(DUZ)=""
 S XMDUZ="DG PTF MT=U STATS"
 D ^XMD
 Q
 ;
PRINT ; Print Report
 N DGNAME,DFN,LAST4,VA,PAGE,DGPIEN,DGDOD,NEWNAME
 ;
 S PAGE=0
 D HDR
 S DGNAME=""
 F  S DGNAME=$O(^TMP("DGPTFRUS",$J,DGNAME)) Q:DGNAME']""  D
 . S DGPIEN=0,NEWNAME=1
 . F  S DGPIEN=$O(^TMP("DGPTFRUS",$J,DGNAME,DGPIEN)) Q:'DGPIEN  D
 . . S DFN=$P($G(^TMP("DGPTFRUS",$J,DGNAME,DGPIEN)),U,1)
 . . S LAST4=$$LAST4(DFN)
 . . S DGDOD=$$DOFD(DFN)
 . . I NEWNAME D
 . . . W !,$E(DGNAME,1,30),LAST4
 . . E  W !
 . . W ?35,DGPIEN
 . . W ?48,$$GET1^DIQ(45,DGPIEN,11)
 . . W ?57,$$GET1^DIQ(45,DGPIEN,6)
 . . W ?80,$$GET1^DIQ(45,DGPIEN,7.4)
 . . W:NEWNAME ?97,DGDOD
 . . S NEWNAME=0
 . . I ($Y+5)>IOSL D HDR  Q
 S ^TMP("DGPTFRU",$J,0,"END")=$H
 Q
 ;
LAST4(DFN) ; Print last four of SSN
 N VA
 ;
 D PID^VADPT6
 Q " ("_VA("BID")_")"
 ;
DOFD(DFN) ; Print Date of Death, if there is one
 N VADM
 ;
 D DEM^VADPT
 Q $P($G(VADM(6)),U,2)
 ;
HDR ; Report Header
 N SPACE,LINE,TAB,PRNTLN
 ;
 W:PAGE>0 @IOF
 S PAGE=PAGE+1
 ;
 S PRNTLN="PTF Records Transmitted with MT Indicator of U Report"
 S TAB=(IOM-$L(PRNTLN))\2
 W !?TAB,PRNTLN
 S PRNTLN="Date Range: "_$$FMTE^XLFDT(DGBEG)_" thru "_$$FMTE^XLFDT(DGEND)
 S TAB=(IOM-$L(PRNTLN))\2
 W !!?TAB,PRNTLN
 S PRNTLN="Print Date: "_$$FMTE^XLFDT($$NOW^XLFDT)
 S TAB=(IOM-$L(PRNTLN))\2
 W !?TAB,PRNTLN
 S PRNTLN="Page: "_PAGE
 S TAB=(IOM-$L(PRNTLN))\2
 W !?TAB,PRNTLN
 W !!?35,"Record",?80,"Transmission",?97,"Date of"
 W !,"Patient Name",?35,"Number",?48,"Type",?57,"Status",?80,"Date",?97,"Death"
 S $P(LINE,"=",IOM)="" W !,LINE
 Q

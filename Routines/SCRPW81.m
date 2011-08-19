SCRPW81 ; ALB/SCK - SCDX AMB CARE CLOSEOUT RPT FOR MT INDICATOR = U ; 9 JULY 2003
 ;;5.3;Scheduling;**302,440,474**;AUG 13, 1993;Build 4
 ;
EN ; Main entry point for report
 N DIR,DIRUT,SDBEG,SDEND,RSLT,Y,X
 ;
 S DIR("A")="Please select fiscal year",DIR(0)="SM^A:Previous Fiscal Year;B:Current Fiscal Year;O:Other Date Range"
 S DIR("B")="B"
 S DIR("?")="You may select either the previous fiscal year (A) or the current fiscal year (B).  Select (O) if you choose to specify your own date range."
 D ^DIR K DIR
 Q:$D(DIRUT)
 S RSLT=Y
 ;
 I RSLT="A" D 
 . D PASTYR(.SDBEG,.SDEND)
 E  I RSLT="B" D
 . D CURYR(.SDBEG,.SDEND)
 E  D
 . D GETDT(.SDBEG,.SDEND)
 Q:'$G(SDBEG)!('$G(SDEND))
 W !!?3,"Date Range: "_$$FMTE^XLFDT(SDBEG)_" to "_$$FMTE^XLFDT(SDEND)
 ;
 N X,Y,IORVON,IORVOFF
 S X="IORVON;IORVOFF"
 D ENDR^%ZISS
 W:$D(IORVON) IORVON
 W !,"A 132-Column printer is required for this report."
 W !,"This report will NOT print correctly to the screen!"
 W:$D(IORVOFF) IORVOFF
 ;
 N ZTSAVE,ZTRTN,ZTDESC,POP,%ZIS
 S %ZIS="Q" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  Q
 . S ZTSAVE("SDBEG")="",ZTSAVE("SDEND")="",ZTSAVE("DUZ")=""
 . S ZTRTN="RUN^SCRPW81"
 . S ZTDESC="XMITED OE MT=U RPT"
 . D ^%ZTLOAD D HOME^%ZIS K IO("Q")
 D RUN
 D ^%ZISC
EXIT S:$D(ZTQUEUED) ZTREQ="@" Q
 ;
RUN ; Run report
 U IO
 K ^TMP("SCDX MTU",$J),^TMP("SCDX ASORT",$J)
 ;
 D BLD(SDBEG,SDEND)
 D CHKMT
 D SRTNAME
 D MAIL
 D PRINT
 K ^TMP("SCDX MTU",$J),^TMP("SCDX ASORT",$J)
 Q
 ;
PASTYR(SDBEG,SDEND) ; Set dates for previous fiscal year
 N CURYR,PRVYR,CURMN,%I
 ;
 D NOW^%DTC
 S CURYR=%I(3),CURMN=%I(1)
 I CURMN>9 D
 . S CURYR=CURYR+1
 S PRVYR=CURYR-1
 S SDEND=$$FMADD^XLFDT(PRVYR_"1001",-1)
 S SDBEG=$$FMADD^XLFDT(PRVYR_"1001",-365)
 Q
 ;
CURYR(SDBEG,SDEND) ; Set dates for current fiscal year
 N CURYR,CURMN,%I
 ;
 D NOW^%DTC
 S CURYR=%I(3),CURMN=%I(1)
 I CURMN<10 D
 . S CURYR=CURYR-1
 S SDBEG=CURYR_"1001"
 S SDEND=$P($$NOW^XLFDT,".")
 Q
 ;
GETDT(SDBEG,SDEND) ;  Get beginning and ending date for search
 ; Output   SDBEG   Beginning for date range
 ;          SDEND   End of date range
 ;          result  1 - If function successful
 ;                  0 - If function NOT successful (User quit)
 ;
 N DIR,DIRUT,Y
 ;
 W !!?3,"You have selected to specify your own date range.  Please note that by"
 W !?3,"doing so you may not generate an accurate picture of the AMB CARE"
 W !?3,"closeouts where the means test indicator equals 'U'.",!
 ;
 S DIR(0)="DAO^:DT:EX"
 S DIR("A")="Beginning Date: "
 S DIR("?")="^D HELP^%DTC"
 D ^DIR
 I $D(DIRUT) D  Q
 . S SDBEG=0
 S SDBEG=Y
 ;
 S DIR(0)="DAO^:DT:EX"
 S DIR("A")="Ending Date: "
 D ^DIR
 I $D(DIRUT) D  Q
 . S SDEND=0
 S SDEND=Y
 Q
 ;
BLD(SDBEG,SDEND) ;  Build list of patient OE's for date range
 ; Input   SDBEG
 ;         SDEND
 ;
 N SDX,SDMAX,SDOEI,CNT,NODE,SDOEX,SDLOC
 ;
 S SDX=$$FMADD^XLFDT(SDBEG,0,0,0,-1) ; set inital search DT to beginning date minus one second
 S SDMAX=$$FMADD^XLFDT(SDEND,0,23,59,59) ; set search end date to end date plus one day
 ;
 S ^TMP("SCDX MTU",$J,0,"BEGIN")=$H
 F  S SDX=$O(^SCE("B",SDX)) Q:'SDX  D  Q:SDX>SDMAX
 . S SDOEI=0
 . F  S SDOEI=$O(^SCE("B",SDX,SDOEI)) Q:'SDOEI  D
 . . S NODE=$G(^SCE(SDOEI,0))
 . . Q:$P(NODE,U,6)>0  ; Quit if not parent encounter
 . . Q:$P(NODE,U,8)>3  ; Quit if Originating process is for credit stop code
 . . S SDLOC=+$P(NODE,U,4)
 . . Q:$$GET1^DIQ(44,SDLOC,2502,"I")="Y"  ; Quit if non-count clinic
 . . S SDOEX=$O(^SD(409.73,"AENC",SDOEI,0))
 . . Q:'$P(NODE,U,2)
 . . S ^TMP("SCDX MTU",$J,$P(NODE,U,2),SDOEI)=$P(NODE,U,1)_U_SDOEX
 . . S ^TMP("SCDX MTU",$J,0,"CNT")=$G(^TMP("SCDX MTU",$J,0,"CNT"))+1
 S ^TMP("SCDX MTU",$J,0,"END")=$H
 Q
 ;
CHKMT ; Clean out all except those meeting the MT=U conditions
 N DFN,SDOEI,SDOEDT,SDMT,SDO,SDR,SDN,SDAT,SDEC,SDMTI,SDMTT
 ;
 S DFN=0
 F  S DFN=$O(^TMP("SCDX MTU",$J,DFN)) Q:'DFN  D
 . I '$D(^DGMT(408.31,"C",DFN)) D  Q  ; No MT Data, bypass patient
 . . K ^TMP("SCDX MTU",$J,DFN)
 . S (SDR,SDO,SDN,SDOEI)=0
 . F  S SDOEI=$O(^TMP("SCDX MTU",$J,DFN,SDOEI)) Q:'SDOEI  D
 . . S SDOEDT=$P($G(^TMP("SCDX MTU",$J,DFN,SDOEI)),U,1)
 . . Q:'SDOEDT
 . . S SDEC=$$GET1^DIQ(409.68,SDOEI,.13,"I")
 . . S SDAT=$$GET1^DIQ(409.68,SDOEI,.1,"I")
 . . S SDMTI=$$MTI^SCDXUTL0(DFN,SDOEDT,SDEC,SDAT,SDOEI)
 . . I SDMTI'="U" D  Q
 . . . K ^TMP("SCDX MTU",$J,DFN)
 . . S SDMTT=$$LST^DGMTU(DFN,SDOEDT,1) I $P(SDMTT,U,4)="N" D  Q
 . . . K ^TMP("SCDX MTU",$J,DFN)
 . . S $P(^TMP("SCDX MTU",$J,DFN,SDOEI),U,4)=SDMTI
 S ^TMP("SCDX MTU",$J,0,"END")=$H K SDMTT
 Q
 ;
SRTNAME ; Sort remaining encounters by patient name and OE date
 N DFN,SDOEI,SDNAME,SDOEDT
 ;
 S DFN=0
 F  S DFN=$O(^TMP("SCDX MTU",$J,DFN)) Q:'DFN  D
 . S SDNAME=$$GET1^DIQ(2,DFN,.01)
 . Q:SDNAME']""
 . S ^TMP("SCDX MTU",$J,0,"PATNUM")=$G(^TMP("SCDX MTU",$J,0,"PATNUM"))+1
 . S SDOEI=0
 . F  S SDOEI=$O(^TMP("SCDX MTU",$J,DFN,SDOEI)) Q:'SDOEI  D
 . . S SDOEDT=$P(^TMP("SCDX MTU",$J,DFN,SDOEI),U,1)
 . . S ^TMP("SCDX ASORT",$J,SDNAME,SDOEDT)=$P(^TMP("SCDX MTU",$J,DFN,SDOEI),U,2)_U_SDOEI_U_DFN_U_$P(^TMP("SCDX MTU",$J,DFN,SDOEI),U,4)
 . . S ^TMP("SCDX MTU",$J,0,"FINAL CNT")=$G(^TMP("SCDX MTU",$J,0,"FINAL CNT"))+1
 S ^TMP("SCDX MTU",$J,0,"END2")=$H
 Q
 ;
MAIL ; send message with report statistics
 N MSG,XMSUB,XMY,XMTEXT,XMDUZ
 ;
 S MSG(1)="Date Range for Report           "_$$FMTE^XLFDT(SDBEG,2)_" to "_$$FMTE^XLFDT(SDEND,2)
 S MSG(2)=""
 S MSG(3)="Report Started                  "_$$HTE^XLFDT(^TMP("SCDX MTU",$J,0,"BEGIN"),2)
 S MSG(4)="Report Finished                 "_$$HTE^XLFDT(^TMP("SCDX MTU",$J,0,"END2"),2)
 S MSG(5)="Total Time for Report           "_$$HDIFF^XLFDT(^TMP("SCDX MTU",$J,0,"END2"),^TMP("SCDX MTU",$J,0,"BEGIN"),3)
 S MSG(6)=""
 S MSG(7)="Outpatient Encounters Scanned   "_$J($FN(+$G(^TMP("SCDX MTU",$J,0,"CNT")),","),20)
 S MSG(8)="Outpatient Encounters Reported  "_$J($FN(+$G(^TMP("SCDX MTU",$J,0,"FINAL CNT")),","),20)
 S MSG(9)="Patient Count                   "_$J($FN(+$G(^TMP("SCDX MTU",$J,0,"PATNUM")),","),20)
 ;
 S XMSUB="MEANS TEST = 'U' REPORT STATISTICS"
 S XMTEXT="MSG("
 S XMY(DUZ)=""
 S XMDUZ="ACRP MT=U STATS"
 D ^XMD
 Q
 ;
PRINT ; Print Report
 ;SD*5.3*474 added SDFLAG and corresponding logic
 N SDNAME,SDNODE,SDXNODE,SDOEI,SDOEX,SDOEDT,DFN,PRNTL4,VA,PAGE,SDFLAG
 ;
 S PAGE=0
 D HDR
 S SDNAME=""
 F  S SDNAME=$O(^TMP("SCDX ASORT",$J,SDNAME)) Q:SDNAME']""  D
 . W !,$E(SDNAME,1,30)
 . S PRNTL4=0,SDFLAG=1
 . S SDOEDT=0
 . F  S SDOEDT=$O(^TMP("SCDX ASORT",$J,SDNAME,SDOEDT)) Q:'SDOEDT  D
 . . S DFN=$P($G(^TMP("SCDX ASORT",$J,SDNAME,SDOEDT)),U,3)
 . . S SDOEX=$P($G(^TMP("SCDX ASORT",$J,SDNAME,SDOEDT)),U,1)
 . . S SDOEI=$P($G(^TMP("SCDX ASORT",$J,SDNAME,SDOEDT)),U,2)
 . . I 'PRNTL4 D  S PRNTL4=1
 . . . D PID^VADPT6
 . . . W ?($L(SDNAME)+1),"(",VA("BID"),")"
 . . I 'SDFLAG D  S SDFLAG=1
 . . . W !,$E(SDNAME,1,30)
 . . . D PID^VADPT6
 . . . W ?($L(SDNAME)+1),"(",VA("BID"),")"
 . . W ?35,$$FMTE^XLFDT(SDOEDT,"D"),$S(SDOEX>0:" *",1:"  ")
 . . W ?56,$P($G(^TMP("SCDX ASORT",$J,SDNAME,SDOEDT)),U,4)
 . . S SDNODE=$G(^SCE(SDOEI,0))
 . . W ?68,$E($$GET1^DIQ(40.8,$P(SDNODE,U,11),.01),1,30)
 . . W ?100,$E($$GET1^DIQ(44,$P(SDNODE,U,4),.01),1,30)
 . . I ($Y+5)>IOSL D HDR S SDFLAG=0 Q
 . . W !
 D FTR1
 Q
 ;
HDR ; Report Header
 N SPACE,LINE,TAB,PRNTLN
 ;
 I PAGE>0 D FTR
 W:PAGE>0 @IOF
 S PAGE=PAGE+1
 ;
 S PRNTLN="Transmitted Outpatient Encounters with Means Test = 'U'"
 S TAB=(IOM-$L(PRNTLN))\2
 W !?TAB,PRNTLN
 S PRNTLN="Date Range: "_$$FMTE^XLFDT(SDBEG)_" thru "_$$FMTE^XLFDT(SDEND)
 S TAB=(IOM-$L(PRNTLN))\2
 W !!?TAB,PRNTLN
 S PRNTLN="Print Date: "_$$FMTE^XLFDT($$NOW^XLFDT)
 S TAB=(IOM-$L(PRNTLN))\2
 W !?TAB,PRNTLN
 S PRNTLN="Page: "_PAGE
 S TAB=(IOM-$L(PRNTLN))\2
 W !?TAB,PRNTLN
 ;
 W !!?35,"Outpatient",?52,"",?68,"Medical Ctr"
 W !,"PATIENT NAME",?35,"Encounter Date",?52,"MT Indicator",?68,"Division",?100,"Clinic"
 ;
 S $P(LINE,"=",IOM)="" W !,LINE
 Q
 ;
FTR ; Report Footer
 N SDX
 ;
 F SDX=$Y:1:IOSL-2 W !
 W ?5,"* - Transmitted Outpatient Encounter"
 Q
 ;
FTR1 ;
 W !?5,"* - Transmitted Outpatient Encounter"
 Q
 ;

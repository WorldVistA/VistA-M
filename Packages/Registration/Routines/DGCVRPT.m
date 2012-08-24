DGCVRPT ;ALB/PJR,LBD - Unsupported CV End Dates Report;  ; 6/16/09 10:53am
 ;;5.3;Registration;**564,731,792,797**; Aug 13,1993;Build 24
 ;
EN ; Called from DG UNSUPPORTED CV END DATES RPT option
 N DGSRT
 S DGSRT=$$SRT I DGSRT="" Q
 D RPTQUE Q
SRT() ; Get sort order
 ; OUPUT: Y - Sort (N=Name; D=DFN)
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="SA^N:Name;D:DFN (Internal ID)"
 S DIR("A")="Sort report by Name or DFN (Internal ID): ",DIR("B")="NAME"
 S DIR("?",1)="Indicate whether the report should be sorted by the"
 S DIR("?")="Veteran's Name or the Internal ID (DFN) of the Veteran"
 D ^DIR I $D(DTOUT)!($D(DUOUT)) Q ""
 Q Y
 ;
RPTQUE ; Get report device. Queue report if requested.
 N POP,ZTRTN,ZTDESC,ZTSAVE,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 K IOP,%ZIS
 S %ZIS="MQ"
 W !
 D ^%ZIS I POP W !!,*7,"Report Cancelled!",! S DIR(0)="E" D ^DIR Q
 I $D(IO("Q")) D  Q
 .S ZTRTN="RPT^DGCVRPT(DGSRT)"
 .S ZTDESC="Print Unsupported CV End Dates Report"
 .S ZTSAVE("DGSRT")=""
 .D ^%ZTLOAD
 .W !!,"Report "_$S($D(ZTSK):"Queued!",1:"Cancelled!")
 .W ! S DIR(0)="E" D ^DIR
 .D HOME^%ZIS
 D RPT(DGSRT)
 D ^%ZISC
 Q
 ;
RPT(DGSRT) ; Entry point to produce report
 D EN1,EN2(DGSRT) Q
EN1 ; Extract
 N RNAME,DFN,RECCOUNT,SELCOUNT,DGXTMP,RES,CEN,CALC,EDITED
 ; Initialize ^XTMP global and set start date
 K ^XTMP("DGCVRPT")
 S RNAME="DG UNSUPPORTED CV END DATE REPORT"
 S ^XTMP("DGCVRPT",0)=$$FMADD^XLFDT(DT,60)_U_DT_U_RNAME
 S $P(^XTMP("DGCVRPT","DATE"),U,1)=$$FMTE^XLFDT($$NOW^XLFDT(),"5P")
 S:$G(ZTSK) ZTREQ="@"
 ; Set variables and initialize array for counts
 S (DFN,RECCOUNT,SELCOUNT,EDITED)=0
 S DGXTMP="^XTMP(""DGCVRPT"",""NOSUP"")"
 ; Loop through cross-reference "E"
 ; If patient meets report criteria, put on list
 F  S EDITED=$O(^DPT("E",EDITED)) Q:'EDITED  S DFN=0 D
 .F  S DFN=$O(^DPT("E",EDITED,DFN)) Q:'DFN  D CHK I CEN,CEN'=CALC D PUT
 S $P(^XTMP("DGCVRPT","DATE"),U,2)=$$FMTE^XLFDT($$NOW^XLFDT(),"5P")
 K ^XTMP("DGCVRPT","RUNNING"),DGXTMP
 Q
 ;
CHK ; Calculate CV End Date, check MSE data is supporting it
 ; INPUT: DFN - Patient file IEN
 ; OUTPUT: CEN  = CV End Date on file
 ;         CALC = Calculated CV End Date
 N DGARRY
 S RECCOUNT=RECCOUNT+1 D CNT
 S CALC="",CEN=$P($G(^DPT(DFN,.52)),U,15) I 'CEN Q
 S CALC=$$CVDATE(DFN,.DGARRY)
 ; If OEF/OIF date's "to date" is used for the CV End date, (not the
 ;   last SSD), include it as an inconsistency on this report
 I $G(DGARRY("OEF/OIF")),DGARRY("OEF/OIF")>$G(DGARRY("SSD")) S CALC=""
 Q
 ;
SCH S CALC=$$CALCCV^DGCV(DFN,SSD) Q
 ;
PUT ; Put record on list
 N NAM,SSN,NZERO
 S SELCOUNT=SELCOUNT+1 D CNT
 S NZERO=$G(^DPT(DFN,0)),NAM=$P(NZERO,U,1),SSN=$P(NZERO,U,9)
 S @DGXTMP@("DFN",DFN,0)=NAM_U_SSN_U_CEN
 I NAM'="" S @DGXTMP@("NAM",NAM,DFN)=""
 Q
 ;
CNT S @DGXTMP@("CNT","VET")=SELCOUNT_U_RECCOUNT Q
 ;
EN2(DGSRT) ; Print
 ; INPUT    DGSRT - Sort order for report (Name or DFN)
 N PG,LINE,RPTDT,CRT,OUT,DSH,CNT,MXLNE,DGXTMP,DGTOT,LOOP
 S:$G(ZTSK) ZTREQ="@"
 D PRTVAR
 U IO D HDR
 ;;
 S LOOP="LOOP"_DGSRT
 D @LOOP Q:OUT
 D TOT Q:OUT
 W ! S OUT=$$PAUSE
 Q
LOOPN ; Sort by name. Loop through ^XTMP("DGCVRPT","NOSUP","NAM", x-ref
 N NM,DFN
 S (NM,DFN)=""
 F  S NM=$O(@DGXTMP@("NAM",NM)) Q:NM=""!OUT  D
 .F  S DFN=$O(@DGXTMP@("NAM",NM,DFN)) Q:DFN=""!OUT  D PRINT
 Q
LOOPD ; Sort by DFN. Loop through ^XTMP("DGCVRPT","NOSUP","DFN", x-ref
 N DFN S DFN=0
 F  S DFN=$O(@DGXTMP@("DFN",DFN)) Q:'DFN!OUT  D PRINT
 Q
PRINT ; Print veteran
 N VET
 Q:'$D(@DGXTMP@("DFN",DFN))
 S VET=$G(@DGXTMP@("DFN",DFN,0))
 I LINE>MXLNE S OUT=$$PAUSE Q:OUT  D HDR
 W !,DFN,?12,$P(VET,U,2),?24,$E($P(VET,U,1),1,39),?64,$$FMTE^XLFDT($P(VET,U,3))
 S LINE=LINE+1 Q
TOT ; Print total records at the end of the report
 I LINE+4>MXLNE S OUT=$$PAUSE Q:OUT  D HDR
 W !!,"Total Records Printed:          ",$$RJ^XLFSTR($P(DGTOT,U,1),7)
 W !!,"Total Records with CV End Dates:",$$RJ^XLFSTR($P(DGTOT,U,2),7)
 Q
PRTVAR ; Set up variables needed to print report
 S CRT=$S($E(IOST,1,2)="C-":1,1:0)
 S DGXTMP="^XTMP(""DGCVRPT"",""NOSUP"")"
 S DGTOT=$G(@DGXTMP@("CNT","VET"))
 S:$G(DGSRT)="" DGSRT="N"
 S (PG,CNT,OUT)=0,RPTDT=$$FMTE^XLFDT(DT),MXLNE=$S(CRT:15,1:52)
 S DSH="",$P(DSH,"=",80)=""
 Q
HDR ; Print report header
 S PG=PG+1,LINE=0
 W @IOF
 W ?0,"Report Date: ",RPTDT,?68,"Page: ",$$RJ^XLFSTR(PG,4)
 W !,"Sorted By: "_$S(DGSRT="N":"Name",1:"DFN")
 W !!,$$CJ^XLFSTR("CV END DATES WITH NO SUPPORTING MS DATA REPORT",80)
 W !!,"DFN",?12,"SSN",?24,"Veteran's Name",?64,"CV End Date"
 W !,DSH
 Q
PAUSE() ; If report is sent to screen, prompt for next page or quit
 N DIR,DIRUT,DUOUT,DTOUT,X,Y
 I 'CRT Q 0
 S DIR(0)="E"
 D ^DIR I 'Y Q 1
 Q 0
CVDATE(DFN,DGARR,DGERR) ; Returns all values for calculating the CV End date
 ; in DGARR (passed by reference)
 ;   AND
 ; any error codes from the DIQ call in DGERR (passed by reference)
 ;   AND
 ; the calculated CV End Date as the result of the function call
 ;
 N N,DATE,X,Y
 S DATE=""
 D GETS^DIQ(2,DFN_",",".327;.322012;.322018;.322021;.5294","I","DGARR","DGERR")
 S DGARR("OEF/OIF")=$P($$LAST^DGENOEIF(DFN),U)
 ; If there's MSE data in new MSE sub-file #2.3216 get last
 ; Service Separation Date (DG*5.3*797)
 I $D(^DPT(DFN,.3216)) S DGARR("SSD")=$P($$LAST^DGMSEUTL(DFN),U,2)
 E  S DGARR("SSD")=$G(DGARR(2,DFN_",",.327,"I"))
 ; If OEF/OIF date later than last serv sep dt, use to date of OEF/OIF
 I $G(DGARR("OEF/OIF")),DGARR("OEF/OIF")>DGARR("SSD") S DATE=DGARR("OEF/OIF") G CVDATEQ
 I DGARR("SSD") D
 . Q:$E(DGARR("SSD"),6,7)="00"!(DGARR("SSD")'>2981111)
 . I $G(DGARR("OEF/OIF")) S DATE=DGARR("SSD") Q
 . ; If conflict dates exist for any of the above listed fields, use SSD 
 . S N=0 F  S N=$O(DGARR(2,DFN_",",N)) Q:'N  I N'=.327,$G(DGARR(2,DFN_",",N,"I"))>2981111 S DATE=DGARR("SSD") Q
 ;
CVDATEQ Q $S(DATE:$$CALCCV^DGCV(DFN,DATE),1:"")
 ;

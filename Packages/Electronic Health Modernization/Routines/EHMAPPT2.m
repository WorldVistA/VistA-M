EHMAPPT2 ;ALB/WTC - EHRM APPOINTMENT MAINTENANCE; Jun 05, 2025@14:51:23
 ;;1.0;ELECTRONIC HEALTH MODERNIZATION;**13**;Apr 19, 2021;Build 27
 ;
 ;
 Q  ;
 ;
SUMMARY ;
 ;
 ;  Output summary of converted appointments.
 ;
 N CONVDATE,POP,%ZIS,QUEUED,CLINFLTR,RPTYPE,CLINICS,NONCOUNT ;
 ;
 S RPTYPE="SUMMARY" D CNVSELCT^EHMAPPT(RPTYPE,.CONVDATE,1,.CLINFLTR,.CLINICS,,.NONCOUNT) Q:CONVDATE=""  Q:CLINFLTR=""  Q:NONCOUNT=""  ;
 ;
 S %ZIS="Q" D ^%ZIS I POP K ^TMP($J) Q  ;
 ;
 ;  If report is queued, add to Taskman
 ;
 S QUEUED=0 I $D(IO("Q")) S QUEUED=1 D  Q  ;
 . N ZTDESC,ZTRTN,ZTSAVE,ZTSK ;
 . S ZTRTN="SUMMARY1^EHMAPPT2",ZTDESC="Appointment Summary" ;
 . S ZTSAVE("*")="" ;
 . D ^%ZTLOAD W $S($D(ZTSK):"...Task queued",1:"...Task cancelled"),! ;
 ;
SUMMARY1 ;  TaskMan entry point
 ;
 ;  Output summary report.
 ;
 N TITLE ;
 ;
 ;  Build list of converted appointments.
 ;
 U IO D CNVTDAPT^EHMAPPT(RPTYPE,CONVDATE,1,CLINFLTR,.CLINICS,,NONCOUNT,QUEUED,,) ;  Build list of converted appointments.
 S TITLE(1)="CONVERTED APPOINTMENT SUMMARY" ;
 D SUMOUT(.TITLE,CONVDATE,QUEUED) ;
 ;
 D ^%ZISC ;
 K ^TMP($J) ;
 Q  ;
 ;
SUMOUT(TITLE,CONVDATE,QUEUED,EXCLENC) ;
 ;
 ;  Scan sorted data in ^TMP($J) and summarize results.
 ;
 ;  TITLE    = Report title (array)
 ;  CONVDATE = Conversion date
 ;  QUEUED   = 1 if report queued
 ;  EXCLENC  = 1 if encounter breakdown excluded
 ;
 N SORT1,SORT2,SORT3,APPTDTTM,CLINNAME,YYYYMM,TOTAL1,TOTAL2,TOTAL3,TOTAL4,TOTAL5,COUNT1,COUNT2,COUNT3,COUNT4,COUNT5,ENCNTR,ENCTRSTS,LINES,QUIT,X ;
 ;
 K ^TMP("EHMAPPT",$J) ;
 S SORT1="" F  S SORT1=$O(^TMP($J,SORT1)) Q:SORT1=""  D  ;
 . S SORT2="" F  S SORT2=$O(^TMP($J,SORT1,SORT2)) Q:SORT2=""  D  ;
 .. S SORT3="" F  S SORT3=$O(^TMP($J,SORT1,SORT2,SORT3)) Q:SORT3=""  D  ;
 ... S APPTDTTM=SORT1,CLINNAME=$P(SORT3,U,1),YYYYMM=($E(APPTDTTM,1,3)+1700)_"/"_$E(APPTDTTM,4,5) ;
 ... S ENCNTR="",ENCTRSTS="" ;
 ... I $D(^TMP($J,SORT1,SORT2,SORT3,2)) D  ;
 .... S ENCNTR=$P(^(2),U,20) ;
 .... I ENCNTR="" S ENCTRSTS="none" Q  ;
 .... S ENCTRSTS=$$ENCTRSTS^EHM13UTIL(ENCNTR) I ENCTRSTS="ACTION REQUIRED",$$MPTYNCTR^EHM13UTIL(ENCNTR)=1 S ENCTRSTS="EMPTY" ;
 .... I ENCNTR'="",ENCTRSTS="" S ENCTRSTS="blank" ;  Encounter present but status is null.
 ... ;
 ... S $P(^(YYYYMM),U,1)=$P($G(^TMP("EHMAPPT",$J,"DATE",YYYYMM)),U,1)+1 ;  total entries
 ... S $P(^(CLINNAME),U,1)=$P($G(^TMP("EHMAPPT",$J,"CLINIC",CLINNAME)),U,1)+1 ;  total entries
 ... ;
 ... I ENCTRSTS="none" S $P(^(YYYYMM),U,2)=$P(^TMP("EHMAPPT",$J,"DATE",YYYYMM),U,2)+1,$P(^(CLINNAME),U,2)=$P(^TMP("EHMAPPT",$J,"CLINIC",CLINNAME),U,2)+1 Q  ;  no encounter
 ... I ENCTRSTS="ACTION REQUIRED" S $P(^(YYYYMM),U,3)=$P(^TMP("EHMAPPT",$J,"DATE",YYYYMM),U,3)+1,$P(^(CLINNAME),U,3)=$P(^TMP("EHMAPPT",$J,"CLINIC",CLINNAME),U,3)+1 Q  ;  action required encounter
 ... I ENCTRSTS="EMPTY" S $P(^(YYYYMM),U,4)=$P(^TMP("EHMAPPT",$J,"DATE",YYYYMM),U,4)+1,$P(^(CLINNAME),U,4)=$P(^TMP("EHMAPPT",$J,"CLINIC",CLINNAME),U,4)+1 Q  ;  empty encounter
 ... S $P(^(YYYYMM),U,5)=$P(^TMP("EHMAPPT",$J,"DATE",YYYYMM),U,5)+1,$P(^(CLINNAME),U,5)=$P(^TMP("EHMAPPT",$J,"CLINIC",CLINNAME),U,5)+1 ;  other status encounter
 ;
 S LINES=0,QUIT=0 ;
 U IO D SUMHDR(.TITLE,$G(CONVDATE),"DATE",10,$G(EXCLENC)) ;
 S (TOTAL1,TOTAL2,TOTAL3,TOTAL4,TOTAL5)=0,YYYYMM=0 ;
 F  S YYYYMM=$O(^TMP("EHMAPPT",$J,"DATE",YYYYMM)) Q:'YYYYMM  S X=^(YYYYMM) D  Q:QUIT  ;
 . S COUNT1=$P(X,U,1),COUNT2=$P(X,U,2),COUNT3=$P(X,U,3),COUNT4=$P(X,U,4),COUNT5=$P(X,U,5) ;
 . ;
 . ;  If report displayed on screen, stop when screen full and prompt user to continue or stop.
 . ;
 . I 'QUEUED D  Q:QUIT  ;
 .. U 0 ;
 .. I IO=$I Q:LINES<(IOSL-7)  S QUIT=$$CONTINUE^EHM13UTIL()=0 Q:QUIT  U IO D SUMHDR(.TITLE,$G(CONVDATE),"DATE",10,$G(EXCLENC)) S LINES=1 Q  ;
 .. ;
 .. ;  New page header for printed report
 .. ;
 .. I LINES'<IOSL U IO D SUMHDR(.TITLE,$G(CONVDATE,$G(EXCLENC)),"DATE",10) S LINES=1 ;
 . ;
 . U IO W $P(YYYYMM,"/",2),"/",$P(YYYYMM,"/",1),?12,$J(COUNT1,8) W:'$G(EXCLENC) ?22,$J(COUNT2,8),?32,$J(COUNT3,8),?42,$J(COUNT4,8),?52,$J(COUNT5,8) W ! S LINES=LINES+1 ;
 . S TOTAL1=TOTAL1+COUNT1,TOTAL2=TOTAL2+COUNT2,TOTAL3=TOTAL3+COUNT3,TOTAL4=TOTAL4+COUNT4,TOTAL5=TOTAL5+COUNT5 ;
 ;
 I QUIT W ! ;
 W $$DASHES^EHM13UTIL(9),?12,$$DASHES^EHM13UTIL(8) W:'$G(EXCLENC) ?22,$$DASHES^EHM13UTIL(8),?32,$$DASHES^EHM13UTIL(8),?42,$$DASHES^EHM13UTIL(8),?52,$$DASHES^EHM13UTIL(8) W ! ;
 W "TOTAL",?12,$J(TOTAL1,8) W:'$G(EXCLENC) ?22,$J(TOTAL2,8),?32,$J(TOTAL3,8),?42,$J(TOTAL4,8),?52,$J(TOTAL5,8) W ! ;
 ;
 I QUIT D  Q  ;
 . U 0 I 'QUEUED,IO=$I R !,"Press [RETURN] to continue",X:$G(DTIME,300) ;
 . K ^TMP($J),^TMP("EHMAPPT",$J) D ^%ZISC ;
 ;
 I 'QUEUED U 0 I IO=$I S QUIT=$$CONTINUE^EHM13UTIL()=0 I QUIT K ^TMP($J),^TMP("EHMAPPT",$J) D ^%ZISC Q  ;
 ; 
 S LINES=0,QUIT=0 ;
 U IO D SUMHDR(.TITLE,$G(CONVDATE),"CLINIC",30,$G(EXCLENC)) ;
 S (TOTAL1,TOTAL2,TOTAL3,TOTAL4,TOTAL5)=0,CLINNAME="" ;
 F  S CLINNAME=$O(^TMP("EHMAPPT",$J,"CLINIC",CLINNAME)) Q:CLINNAME=""  S X=^(CLINNAME) D  Q:QUIT  ;
 . S COUNT1=$P(X,U,1),COUNT2=$P(X,U,2),COUNT3=$P(X,U,3),COUNT4=$P(X,U,4),COUNT5=$P(X,U,5) ;
 . ;
 . ;  If report displayed on screen, stop when screen full and prompt user to continue or stop.
 . ;
 . I 'QUEUED D  Q:QUIT  ;
 .. U 0 ;
 .. I IO=$I Q:LINES<(IOSL-7)  S QUIT=$$CONTINUE^EHM13UTIL()=0 Q:QUIT  U IO D SUMHDR(.TITLE,$G(CONVDATE),"DATE",30,$G(EXCLENC)) S LINES=1 Q  ;
 .. ;
 .. ;  New page header for printed report
 .. ;
 .. I LINES'<IOSL U IO D SUMHDR(.TITLE,$G(CONVDATE),"DATE",30,$G(EXCLENC)) S LINES=1 ;
 . ;
 . U IO W CLINNAME,?32,$J(COUNT1,8) W:'$G(EXCLENC) ?42,$J(COUNT2,8),?52,$J(COUNT3,8),?62,$J(COUNT4,8),?72,$J(COUNT5,8) W ! S LINES=LINES+1 ;
 . S TOTAL1=TOTAL1+COUNT1,TOTAL2=TOTAL2+COUNT2,TOTAL3=TOTAL3+COUNT3,TOTAL4=TOTAL4+COUNT4,TOTAL5=TOTAL5+COUNT5 ;
 ;
 I QUIT W ! ;
 W $$DASHES^EHM13UTIL(30),?32,$$DASHES^EHM13UTIL(8) W:'$G(EXCLENC) ?42,$$DASHES^EHM13UTIL(8),?52,$$DASHES^EHM13UTIL(8),?62,$$DASHES^EHM13UTIL(8),?72,$$DASHES^EHM13UTIL(8) W ! ;
 W "TOTAL",?32,$J(TOTAL1,8) W:'$G(EXCLENC) ?42,$J(TOTAL2,8),?52,$J(TOTAL3,8),?62,$J(TOTAL4,8),?72,$J(TOTAL5,8) W ! ;
 ;
 U 0 I 'QUEUED,IO=$I R !,"Press [RETURN] to continue",X:$G(DTIME,300) ;
 ;
 K ^TMP($J),^TMP("EHMAPPT",$J) D ^%ZISC ;
 Q  ;
 ;
SUMHDR(TITLE,CONVDATE,SUBHDR,WIDTH,EXCLENC) ;
 ;
 W @IOF,$$CENTER^EHM13UTIL(TITLE(1),IOM),! ;
 I $G(TITLE(2))'="" W $$CENTER^EHM13UTIL(TITLE(2),IOM),! ;
 I $G(CONVDATE)'="" W $$CENTER^EHM13UTIL("CONVERSION DATE: "_$$FMTE^XLFDT(CONVDATE),IOM),! ;
 W !,SUBHDR,?WIDTH+2,"COUNT" W:'EXCLENC ?WIDTH+12,"NO ENC",?WIDTH+22,"ACT REQ",?WIDTH+32,"EMPTY",?WIDTH+42,"OTHER" W ! ;
 W $$DASHES^EHM13UTIL(WIDTH),?WIDTH+2,$$DASHES^EHM13UTIL(8) W:'EXCLENC ?WIDTH+12,$$DASHES^EHM13UTIL(8),?WIDTH+22,$$DASHES^EHM13UTIL(8),?WIDTH+32,$$DASHES^EHM13UTIL(8),?WIDTH+42,$$DASHES^EHM13UTIL(8) W ! ;
 Q  ;
 ;
CNVTD ;
 ;
 ;  List action required encounters for converted appointments.
 ;
 N CONVDATE,CLINFLTR,DFN,APPTDTTM,CLINIC,X1,X2,X3,LASTFI,SORT1,SORT2,SORT3,OUTPTFMT,Y,POP,%ZIS,DIRUT,QUEUED,OUTPTFMT,TITLE,CLINICS,NONCOUNT ;
 ;
 D CNVSELCT^EHMAPPT("OTHER",.CONVDATE,1,.CLINFLTR,.CLINICS,,.NONCOUNT) Q:CONVDATE=""  Q:CLINFLTR=""  Q:NONCOUNT=""  ;
 ;
 ;  Output format
 ;
 K DIR S DIR(0)="SO^F:Formatted Report;C:Comma-Delimited",DIR("A")="Output Format",DIR("B")="Formatted Report" D ^DIR Q:$D(DIRUT)  S OUTPTFMT=Y ;
 ;
 S %ZIS="Q" D ^%ZIS I POP K ^TMP($J) Q  ;
 ;
 ;  If report is queued, add to Taskman
 ;
 S QUEUED=0 I $D(IO("Q")) S QUEUED=1 D  Q  ;
 . N ZTDESC,ZTRTN,ZTSAVE,ZTSK ;
 . S ZTRTN="CNVTD1^EHMAPPT2",ZTDESC="Action Required Encounters List" ;
 . S ZTSAVE("*")="" ;
 . D ^%ZTLOAD W $S($D(ZTSK):"...Task queued",1:"...Task cancelled"),! ;
 ;
CNVTD1 ;  TaskMan start point
 ;
 ;  Build list of converted appointments.
 ;
 U IO D CNVTDAPT^EHMAPPT("OTHER",CONVDATE,1,CLINFLTR,,QUEUED,1,1) ;  Build list of converted appointments.
 U IO D CNVTDAPT^EHMAPPT("OTHER",CONVDATE,1,CLINFLTR,.CLINICS,,NONCOUNT,QUEUED,1,1) ;  Build list of converted appointments.
 D ACTREQ("Converted Appointments",OUTPTFMT,CONVDATE,QUEUED) ;
 D ^%ZISC ;
 K ^TMP($J) ;
 Q  ;
 ;
POSTLIVE ;
 ;
 ;  List action required encounters for post-conversion appointments.
 ;
 N CONVDATE,CLINFLTR,CLINICS,DFN,APPTDTTM,CLINIC,X1,X2,X3,LASTFI,SORT1,SORT2,SORT3,OUTPTFMT,Y,POP,%ZIS,DIRUT,QUEUED ;
 ;
 D POSTSLCT^EHMAPPT0("OTHER",.CONVDATE,1,.CLINFLTR,.CLINICS,,.NONCOUNT) Q:$D(DIRUT)  Q:CONVDATE=""  Q:CLINFLTR=""  Q:NONCOUNT=""  ;
 ;
 ;  Output format
 ;
 K DIR S DIR(0)="SO^F:Formatted Report;C:Comma-Delimited",DIR("A")="Output Format",DIR("B")="Formatted Report" D ^DIR Q:$D(DIRUT)  S OUTPTFMT=Y ;
 ;
 S %ZIS="Q" D ^%ZIS I POP K ^TMP($J) Q  ;
 ;
 ;  If report is queued, add to Taskman
 ;
 S QUEUED=0 I $D(IO("Q")) S QUEUED=1 D  Q  ;
 . N ZTDESC,ZTRTN,ZTSAVE,ZTSK ;
 . S ZTRTN="POSTLIV1^EHMAPPT2",ZTDESC="Action Required Encounters List" ;
 . S ZTSAVE("*")="" ;
 . D ^%ZTLOAD W $S($D(ZTSK):"...Task queued",1:"...Task cancelled"),! ;
 ;
POSTLIV1 ;  TaskMan start point
 ;
 ;  Build list of post-conversion appointments.
 ;
 U IO D POSTLIVE^EHMAPPT0("OTHER",CONVDATE,1,CLINFLTR,.CLINICS,,NONCOUNT,QUEUED,1,1) ; Build list of post-conversion appointments.
 D ACTREQ("Post-Conversion Appointments",OUTPTFMT,CONVDATE,QUEUED) ;
 ;
 D ^%ZISC ;
 K ^TMP($J) ;
 Q  ;
 ;
ALLAPPT ;
 ;
 ;  List action required encounters for all appointments.
 ;
 N CONVDATE,CLINFLTR,CLINICS,DFN,APPTDTTM,CLINIC,X1,X2,X3,LASTFI,SORT1,SORT2,SORT3,OUTPTFMT,Y,POP,%ZIS,DIRUT,QUEUED,OUTPTFMT,TITLE ;
 ;
 D ALLSLCT^EHMAPPT0("OTHER",1,.CLINFLTR,.CLINICS,,.NONCOUNT) Q:CLINFLTR=""  Q:NONCOUNT=""  ;
 ;
 ;  Output format
 ;
 K DIR S DIR(0)="SO^F:Formatted Report;C:Comma-Delimited",DIR("A")="Output Format",DIR("B")="Formatted Report" D ^DIR Q:$D(DIRUT)  S OUTPTFMT=Y ;
 ;
 S %ZIS="Q" D ^%ZIS I POP K ^TMP($J) Q  ;
 ;
 ;  If report is queued, add to Taskman
 ;
 S QUEUED=0 I $D(IO("Q")) S QUEUED=1 D  Q  ;
 . N ZTDESC,ZTRTN,ZTSAVE,ZTSK ;
 . S ZTRTN="ALLAPPT1^EHMAPPT2",ZTDESC="Action Required Encounters List" ;
 . S ZTSAVE("*")="" ;
 . D ^%ZTLOAD W $S($D(ZTSK):"...Task queued",1:"...Task cancelled"),! ;
 ;
ALLAPPT1 ;  TaskMan start point
 ;
 ;  Build list of all appointments.
 ;
 U IO D ALLAPPTS^EHMAPPT0("OTHER",1,CLINFLTR,.CLINICS,,NONCOUNT,QUEUED,1,1) ;  Build list of appointments.
 D ACTREQ("All Appointments",OUTPTFMT,,QUEUED) ;
 D ^%ZISC ;
 K ^TMP($J) ;
 Q  ;
 ;
ACTREQ(SOURCE,FORMAT,CONVDATE,QUEUED) ;
 ;
 ;  Lists reason(s) that ACTION REQUIRED encounters are not empty.
 ;
 N SORT1,SORT2,SORT3,APPTDTTM,CLINIC,PTNAME,DFN,ENCNTR,ENCTRSTS,VISIT ;
 ;
 I FORMAT="F" D ACTREQF(SOURCE,$G(CONVDATE),QUEUED) ;
 I FORMAT="C" D ACTREQC(SOURCE) ;
 Q  ;
 ;
ACTREQF(SOURCE,CONVDATE,QUEUED) ;
 ;
 N SORT1,SORT2,SORT3,APPTDTTM,PTNAME,DFN,CLINIC,ENCNTR,ENCTRSTS,LINES,QUIT,VADM,APPTSTS ;
 ;
 D ACTREQHD(SOURCE,CONVDATE) ;
 S SORT1="",LINES=0,QUIT=0 ;
 F  S SORT1=$O(^TMP($J,SORT1)) Q:SORT1=""  D  Q:QUIT  ;
 . S SORT2="" F  S SORT2=$O(^TMP($J,SORT1,SORT2)) Q:SORT2=""  D  Q:QUIT  ;
 .. S SORT3="" F  S SORT3=$O(^TMP($J,SORT1,SORT2,SORT3)) Q:SORT3=""  D  Q:QUIT  ;
 ... S APPTDTTM=SORT1,PTNAME=$P(SORT2,U,1),DFN=$P(SORT2,U,2),CLINIC=$P(SORT3,U,2) ;
 ... S ENCNTR="",ENCTRSTS="",APPTSTS="" ;
 ... I $D(^TMP($J,SORT1,SORT2,SORT3,2)) S APPTSTS=$P(^(2),U,2),ENCNTR=$P(^(2),U,20) I ENCNTR S ENCTRSTS=$$ENCTRSTS^EHM13UTIL(ENCNTR) I ENCTRSTS="ACTION REQUIRED",$$MPTYNCTR^EHM13UTIL(ENCNTR)=1 S ENCTRSTS="EMPTY" ;
 ... ;
 ... Q:ENCTRSTS'="ACTION REQUIRED"  ;
 ... ;
 ... ;  If report displayed on screen, stop when screen full and prompt user to continue or stop.
 ... ;
 ... I 'QUEUED D  Q:QUIT  ;
 .... U 0 ;
 .... I IO=$I Q:LINES<(IOSL-7)  S QUIT=$$CONTINUE^EHM13UTIL()=0 Q:QUIT  U IO D ACTREQHD(SOURCE,CONVDATE) S LINES=1 Q  ;
 .... ;
 .... ;  New page header for printed report
 .... ;
 .... I LINES'<IOSL U IO D ACTREQHD(SOURCE,CONVDATE) S LINES=1 ;
 ... ;
 ... K VADM D DEM^VADPT ;
 ... ;W $$FMTDTTM^EHM13UTIL(APPTDTTM),?16,$$LASTFI^EHM13UTIL(,VADM(1))," (",$P($P(VADM(2),U,2),"-",3),")",?48,$$GET1^DIQ(44,CLINIC,.01) ;
 ... W $$FMTDTTM^EHM13UTIL(APPTDTTM),?16,APPTSTS,?24,$$LASTFI^EHM13UTIL(,VADM(1))," (",$P($P(VADM(2),U,2),"-",3),")",?56,$$GET1^DIQ(44,CLINIC,.01) ;
 ... ;
 ... S VISIT=$P(^SCE(ENCNTR,0),U,5) ;
 ... I $D(^AUPNVPRV("AD",VISIT)) W ?88,"Provider",! S LINES=LINES+1 ;
 ... I $D(^AUPNVPOV("AD",VISIT)) W ?88,"Diagnosis",! S LINES=LINES+1 ;
 ... I $D(^AUPNVCPT("AD",VISIT)) W ?88,"Service/procedure",! S LINES=LINES+1 ;
 ... I $D(^AUPNVIMM("AD",VISIT)) W ?88,"Immunization",! S LINES=LINES+1 ;
 ... I $D(^AUPNVHF("AD",VISIT)) W ?88,"Health factor",! S LINES=LINES+1 ;
 ... I $D(^TIU(8925,"AVSIT",VISIT)) W ?88,"TIU document",! S LINES=LINES+1 ;
 ;
 U 0 I 'QUEUED,IO=$I R !,"Press [RETURN] to continue",X:$G(DTIME,300) ;
 ;
 Q  ;
 ;
ACTREQC(SOURCE) ;
 ;
 N SORT1,SORT2,SORT3,APPTDTTM,PTNAME,DFN,CLINIC,ENCNTR,ENCTRSTS,REASON ;
 ;
 U IO W $$COMMAOUT^EHM13UTIL(5,"Appointment Date/Time","Status","Patient","Clinic","Associated Content"),! ;
 ;
 S SORT1="" F  S SORT1=$O(^TMP($J,SORT1)) Q:SORT1=""  D  ;
 . S SORT2="" F  S SORT2=$O(^TMP($J,SORT1,SORT2)) Q:SORT2=""  D  ;
 .. S SORT3="" F  S SORT3=$O(^TMP($J,SORT1,SORT2,SORT3)) Q:SORT3=""  D  ;
 ... S APPTDTTM=SORT1,PTNAME=$P(SORT2,U,1),DFN=$P(SORT2,U,2),CLINIC=$P(SORT3,U,2) ;
 ... S ENCNTR="",ENCTRSTS="",APPTSTS="" ;
 ... I $D(^TMP($J,SORT1,SORT2,SORT3,2)) S APPTSTS=$P(^(2),U,3),ENCNTR=$P(^(2),U,20) I ENCNTR S ENCTRSTS=$$ENCTRSTS^EHM13UTIL(ENCNTR) I ENCTRSTS="ACTION REQUIRED",$$MPTYNCTR^EHM13UTIL(ENCNTR)=1 S ENCTRSTS="EMPTY" ;
 ... ;
 ... Q:ENCTRSTS'="ACTION REQUIRED"  ;
 ... ;
 ... S VISIT=$P(^SCE(ENCNTR,0),U,5),REASON="" ;
 ... I $D(^AUPNVPRV("AD",VISIT)) S REASON="Provider" ;
 ... I $D(^AUPNVPOV("AD",VISIT)) S REASON=REASON_$S(REASON="":"",1:", ")_"Diagnosis" ;
 ... I $D(^AUPNVCPT("AD",VISIT)) S REASON=REASON_$S(REASON="":"",1:", ")_"Service/procedure" ;
 ... I $D(^AUPNVIMM("AD",VISIT)) S REASON=REASON_$S(REASON="":"",1:", ")_"Immunization" ;
 ... I $D(^AUPNVHF("AD",VISIT)) S REASON=REASON_$S(REASON="":"",1:", ")_"Health factor" ;
 ... I $D(^TIU(8925,"AVSIT",VISIT)) S REASON=REASON_$S(REASON="":"",1:", ")_"TIU document" ;
 ... ;
 ... W $$COMMAOUT^EHM13UTIL(5,$$FMTDTTM^EHM13UTIL(APPTDTTM),APPTSTS,PTNAME,$$GET1^DIQ(44,CLINIC,.01),REASON),! ;
 ... ;
 ;
 Q  ;
 ;
ACTREQHD(SOURCE,CONVDATE) ;
 ;
 ;  Header for ACTION REQUIRED encounter list.
 ;
 W @IOF,$$CENTER^EHM13UTIL("ACTION REQUIRED Encounters for "_SOURCE,IOM),! ;
 I $G(CONVDATE)'="" W $$CENTER^EHM13UTIL("Conversion Date: "_$$FMTE^XLFDT(CONVDATE),IOM),!
 W ! ;
 ;
 W "Appt Date/Time",?16,"Status",?24,"Patient",?56,"Clinic",?88,"Associated Content",! ;
 W $$DASHES^EHM13UTIL(14),?16,$$DASHES^EHM13UTIL(6),?24,$$DASHES^EHM13UTIL(30),?56,$$DASHES^EHM13UTIL(30),?88,$$DASHES^EHM13UTIL(30),! ;
 Q  ;
 ;

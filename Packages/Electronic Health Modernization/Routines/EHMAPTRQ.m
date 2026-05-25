EHMAPTRQ ;ALB/WTC - EHRM APPOINTMENT REQUEST MAINTENANCE; Jun 06, 2025@11:46:51
 ;;1.0;ELECTRONIC HEALTH MODERNIZATION;**13**;Apr 19, 2021;Build 27
 ;
 ;
 Q  ;
 ;
OPENRQST(SORTORDR,PROGRESS,SOURCE) ;
 ;
 ;  SORTORDR = Sort order (1,2,3 - see below).  [OPTIONAL - set by cleanup routines only]
 ;  PROGRESS = Show progress scanning files (1=YES, 0=NO) [OPTIONAL, DEFAULT=1]
 ;  SOURCE   = Request source (ALL, REQ, WAIT, RECALL) [OPTIONAL, DEFAULT=ALL]
 ;
 ;  Open appointment request list.  Select active appointment requests.  Returns list in ^TMP($J).
 ;
 ;  ^TMP($J)=SORT ORDER (1,2,3)
 ;  ^TMP($J,sorted values,409.85)=pointer to #409.85 ^ 0 node from file #409.85
 ;
 ;  sorted values are made up of:  appointment request date/time in FileMan format (e.g., 3230701.1209)
 ;                                 patient as LAST NAME,FIRST NAME ^ DFN (e.g., SMITH,JOHN A^12345)
 ;                                 clinic as NAME ^ IEN in file #44. (e.g., MEDICAL CLINIC^12345)
 ;
 N DIR,DFN,RQSTDATE,CLINIC,CLINNAME,IEN,X,Y,I ;
 K ^TMP($J) S ^TMP($J)=SORTORDR,SOURCE=$G(SOURCE,"ALL") ;
 ;
 S PROGRESS=$S($G(PROGRESS)="":1,1:PROGRESS) ;
 ;
 ;  Scan SDEC Appointment Request file (#409.85)
 ;
 I SOURCE="ALL"!(SOURCE="REQ") D  ;
 . ;
 . I PROGRESS W !,"Scanning ",$P(^DIC(409.85,0),U,1)," file.",! ;
 . ;
 . S IEN=0,I=0 ;
 . F  S IEN=$O(^SDEC(409.85,IEN)) Q:'IEN  S X=$G(^(IEN,0)) I X'="",$P(X,U,17)'="C" S RQSTDATE=$P(X,U,16) I RQSTDATE'="" D  ;
 .. S I=I+1 D:I#100=0&PROGRESS PROGRESS^EHM13UTIL(I) ;
 .. ;
 .. S DFN=$P(X,U,1),CLINIC=$P(X,U,9),CLINNAME=$S(CLINIC'="":$$GET1^DIQ(44,CLINIC,.01),1:"NOT SPECIFIED") ;
 .. ;
 .. ;  Build ^TMP($J) in sort order
 .. ;
 .. I SORTORDR=1 D  Q  ;
 ... S ^TMP($J,RQSTDATE,$$GET1^DIQ(2,DFN,.01)_U_DFN,CLINNAME_U_CLINIC,409.85)=IEN_U_X ;
 .. ;
 .. I SORTORDR=2 D  Q  ;
 ... S ^TMP($J,CLINNAME_U_CLINIC,RQSTDATE,$$GET1^DIQ(2,DFN,.01)_U_DFN,409.85)=IEN_U_X ;
 .. ;
 .. I SORTORDR=3 D  Q  ;
 ... S ^TMP($J,$$GET1^DIQ(2,DFN,.01)_U_DFN,RQSTDATE,CLINNAME_U_CLINIC,409.85)=IEN_U_X ;
 ;
 ;
 ;  Scan SD Wait List file (#409.3)
 ;
 I SOURCE="ALL"!(SOURCE="WAIT") D  ;
 . ;
 . I PROGRESS W !,"Scanning ",$P(^DIC(409.3,0),U,1)," file.",! ;
 . ;
 . S IEN=0,I=0 ;
 . F  S IEN=$O(^SDWL(409.3,IEN)) Q:'IEN  S X=$G(^(IEN,0)) I X'="",$P(X,U,17)'="C" S RQSTDATE=$P(X,U,2) I RQSTDATE'="" D  ;
 .. S I=I+1 D:I#100=0&PROGRESS PROGRESS^EHM13UTIL(I) ;
 .. ;
 .. S DFN=$P(X,U,1),CLINIC=$P(X,U,9),CLINNAME=$S(CLINIC'="":$$GET1^DIQ(44,CLINIC,.01),1:"NOT SPECIFIED") ;
 .. ;
 .. ;  Build ^TMP($J) in sort order
 .. ;
 .. I SORTORDR=1 D  Q  ;
 ... S ^TMP($J,RQSTDATE,$$GET1^DIQ(2,DFN,.01)_U_DFN,CLINNAME_U_CLINIC,409.3)=IEN_U_X ;
 .. ;
 .. I SORTORDR=2 D  Q  ;
 ... S ^TMP($J,CLINNAME_U_CLINIC,RQSTDATE,$$GET1^DIQ(2,DFN,.01)_U_DFN,409.3)=IEN_U_X ;
 .. ;
 .. I SORTORDR=3 D  Q  ;
 ... S ^TMP($J,$$GET1^DIQ(2,DFN,.01)_U_DFN,RQSTDATE,CLINNAME_U_CLINIC,409.3)=IEN_U_X ;
 ;
 ;
 ;  Scan Recall Reminders file (#403.5)
 ;
 I SOURCE="ALL"!(SOURCE="RECALL") D  ;
 . ;
 . I PROGRESS W !,"Scanning ",$P(^DIC(403.5,0),U,1)," file.",! ;
 . ;
 . S IEN=0,I=0 ;
 . F  S IEN=$O(^SD(403.5,IEN)) Q:'IEN  S X=$G(^(IEN,0)) I X'="" S RQSTDATE=$P(X,U,6) I RQSTDATE'="" D  ;
 .. S I=I+1 D:I#100=0&PROGRESS PROGRESS^EHM13UTIL(I) ;
 .. ;
 .. S DFN=$P(X,U,1),CLINIC=$P(X,U,2),CLINNAME=$S(CLINIC'="":$$GET1^DIQ(44,CLINIC,.01),1:"NOT SPECIFIED") ;
 .. ;
 .. ;  Build ^TMP($J) in sort order
 .. ;
 .. I SORTORDR=1 D  Q  ;
 ... S ^TMP($J,RQSTDATE,$$GET1^DIQ(2,DFN,.01)_U_DFN,CLINNAME_U_CLINIC,403.5)=IEN_U_X ;
 .. ;
 .. I SORTORDR=2 D  Q  ;
 ... S ^TMP($J,CLINNAME_U_CLINIC,RQSTDATE,$$GET1^DIQ(2,DFN,.01)_U_DFN,403.5)=IEN_U_X ;
 .. ;
 .. I SORTORDR=3 D  Q  ;
 ... S ^TMP($J,$$GET1^DIQ(2,DFN,.01)_U_DFN,RQSTDATE,CLINNAME_U_CLINIC,403.5)=IEN_U_X ;
 ;
 Q  ;
 ;
RQSTLIST ;
 ;
 ;  List appointment requests.
 ;
 N SORTORDR,DFN,RQSTDATE,CLINIC,CLINNAME,X1,X2,X3,SORT1,SORT2,SORT3,DIR,OUTPTFMT,Y,POP,%ZIS,DIRUT,QUEUED,SOURCE ;
 ;
 ;  Source selection
 ;
 K DIR S DIR(0)="SO^ALL:All Sources;REQ:Appointment Requests;WAIT:Wait List;RECALL:Recall Reminders",DIR("A")="Source",DIR("B")="All Sources" D ^DIR Q:$D(DIRUT)  S SOURCE=Y ;
 ;
 ;  Sort Order
 ;
 I $G(SORTORDR)="" D  Q:$D(DIRUT)  ;
 . S DIR(0)="S^1:Requested Date of Appointment, Patient, Requested Clinic;2:Requested Clinic, Requested Date of Appointment, Patient;3:Patient, Requested Date of Appointment, Requested Clinic",DIR("A")="Sort Order",DIR("B")=1 ;
 . D ^DIR Q:$D(DIRUT)  S SORTORDR=Y ;
 ;
 ;  Output format
 ;
 K DIR S DIR(0)="SO^F:Formatted Report;C:Comma-Delimited",DIR("A")="Output Format",DIR("B")="Formatted Report" D ^DIR Q:$D(DIRUT)  S OUTPTFMT=Y ;
 ;
 S %ZIS="Q" D ^%ZIS I POP K ^TMP($J) Q  ;
 ;
 ;  If report is queued, add to Taskman
 ;
 S QUEUED=0 ;
 I $D(IO("Q")) S QUEUED=1 D  Q  ;
 . N ZTDESC,ZTRTN,ZTSAVE,ZTSK ;
 . S ZTRTN="RQSTLST1^EHMAPTRQ",ZTDESC="Appointment Request List" ;
 . S ZTSAVE("*")="" ;
 . D ^%ZTLOAD W $S($D(ZTSK):"...Task queued",1:"...Task cancelled"),! ;
 ;
RQSTLST1 ;  TaskMan start point
 ;
 ;  Create appointment request list.
 ;
 D OPENRQST(SORTORDR,1,SOURCE) ;
 ;
 ;  List appointment requests
 ;
 I OUTPTFMT="F" D APPTLSTF("Open Appointment Request List",SORTORDR,QUEUED) ;  Formatted report
 I OUTPTFMT="C" D APPTLSTC("Open Appointment Request List",SORTORDR) ;  Comma-delimited file
 ;
 U 0 I 'QUEUED,IO=$I R !,"Press [RETURN] to continue",X:$G(DTIME,300) ;
 ;
 D ^%ZISC ;
 K ^TMP($J) ;
 Q  ;
 ;
HEADER(TITLE,SORTORDR) ;
 ;
 ;  TITLE    = Report title
 ;  SORTORDR = Sort order (1,2,3)
 ;
 W @IOF,$$CENTER^EHM13UTIL(TITLE_" - Station "_$P($$SITE^VASITE(),U,3),IOM),!! ;
 ;
 I SORTORDR=1 D  ;
 . W "CID/Preferred",!,"Date of Appt",?16,"Patient",?48,"Clinic",?80,"Source",?97,"Req IEN",! ;
 . W $$DASHES^EHM13UTIL(14),?16,$$DASHES^EHM13UTIL(30),?48,$$DASHES^EHM13UTIL(30),?80,$$DASHES^EHM13UTIL(15),?97,$$DASHES^EHM13UTIL(9),! ;
 ;
 I SORTORDR=2 D  ;
 . W ?32,"CID/Preferred",!,"Clinic",?32,"Date of Appt",?48,"Patient",?80,"Source",?97,"Req IEN",! ;
 . W $$DASHES^EHM13UTIL(30),?32,$$DASHES^EHM13UTIL(14),?48,$$DASHES^EHM13UTIL(30),?80,$$DASHES^EHM13UTIL(15),?97,$$DASHES^EHM13UTIL(9),! ;
 ;
 I SORTORDR=3 D  ;
 . W ?32,"CID/Preferred",!,"Patient",?32,"Date of Appt",?48,"Clinic",?80,"Source",?97,"Req IEN",! ;
 . W $$DASHES^EHM13UTIL(30),?32,$$DASHES^EHM13UTIL(14),?48,$$DASHES^EHM13UTIL(30),?80,$$DASHES^EHM13UTIL(15),?97,$$DASHES^EHM13UTIL(9),! ;
 ;
 Q  ;
 ;
APPTLSTF(TITLE,SORTORDR,QUEUED) ;  Formatted Report
 ;
 N LINES,QUIT,SORT1,SORT2,SORT3,RQSTDATE,DFN,CLINNAME,RECRDCT,SOURCE,VADM,IEN40985 ;
 ;
 U IO D HEADER(TITLE,SORTORDR) ;
 S LINES=0,QUIT=0,RECRDCT=0 ;
 ;
 ;  Scan sorted data in ^TMP($J)
 ;
 S SORT1="" F  S SORT1=$O(^TMP($J,SORT1)) Q:SORT1=""  D  Q:QUIT  ;
 . S SORT2="" F  S SORT2=$O(^TMP($J,SORT1,SORT2)) Q:SORT2=""  D  Q:QUIT  ;
 .. S SORT3="" F  S SORT3=$O(^TMP($J,SORT1,SORT2,SORT3)) Q:SORT3=""  D  Q:QUIT  ;
 ... I SORTORDR=1 S RQSTDATE=SORT1,DFN=$P(SORT2,U,2),CLINIC=$P(SORT3,U,2) ;
 ... I SORTORDR=2 S CLINIC=$P(SORT1,U,2),RQSTDATE=SORT2,DFN=$P(SORT3,U,2) ;
 ... I SORTORDR=3 S DFN=$P(SORT1,U,2),RQSTDATE=SORT2,CLINIC=$P(SORT3,U,2) ;
 ... K VADM D DEM^VADPT ;
 ... ;
 ... S SOURCE=$S($D(^TMP($J,SORT1,SORT2,SORT3,409.85)):"APPT REQ",$D(^TMP($J,SORT1,SORT2,SORT3,409.3)):"WAIT LIST",$D(^TMP($J,SORT1,SORT2,SORT3,403.5)):"RECALL",1:"") ;
 ... S IEN40985="" ;
 ... I SOURCE="APPT REQ" S REQTYPE=$P(^TMP($J,SORT1,SORT2,SORT3,409.85),U,6),IEN40985=$P(^(409.85),U,1),SOURCE=SOURCE_"-"_$S(REQTYPE="APPT":"APPT",REQTYPE="RTC":"RTC",1:"OTHER") ;
 ... ;
 ... ;  If report displayed on screen, stop when screen full and prompt user to continue or stop.
 ... ;
 ... I 'QUEUED D  Q:QUIT  ;
 .... U 0 ;
 .... I IO=$I Q:LINES<(IOSL-7)  S QUIT=$$CONTINUE^EHM13UTIL()=0 Q:QUIT  U IO D HEADER(TITLE,SORTORDR) S LINES=1 Q  ;
 .... ;
 .... ;  New page header for printed report
 .... ;
 .... I LINES'<IOSL U IO D HEADER(TITLE,SORTORDR) S LINES=1 ;
 ... ;
 ... U IO ;
 ... I SORTORDR=1 D  ;
 .... W $$FMTE^XLFDT(RQSTDATE),?16,$$LASTFI^EHM13UTIL(,VADM(1))," (",$P($P(VADM(2),U,2),"-",3),")",?48,$$GET1^DIQ(44,CLINIC,.01),?80,SOURCE,?97,$J(IEN40985,9),! ;
 ... I SORTORDR=2 D  ;
 .... W $$GET1^DIQ(44,CLINIC,.01),?32,$$FMTE^XLFDT(RQSTDATE),?48,$$LASTFI^EHM13UTIL(,VADM(1))," (",$P($P(VADM(2),U,2),"-",3),")",?80,SOURCE,?97,$J(IEN40985,9),! ;
 ... I SORTORDR=3 D  ;
 .... W $$LASTFI^EHM13UTIL(,VADM(1))," (",$P($P(VADM(2),U,2),"-",3),")",?32,$$FMTE^XLFDT(RQSTDATE),?48,$$GET1^DIQ(44,CLINIC,.01),?80,SOURCE,?97,$J(IEN40985,9),! ;
 ... S LINES=LINES+1,RECRDCT=RECRDCT+1 ;
 W !,"TOTAL RECORDS = ",RECRDCT,! ;
 ;
 Q  ;
 ;
APPTLSTC(TITLE,SORTORDR) ;  Comma-delimited file
 ;
 N SORT1,SORT2,SORT3,RQSTDATE,DFN,CLINIC,SOURCE ;
 ;
 U IO ;
 ;
 ;  Output first row - list of data fields
 ;
 I SORTORDR=1 W $$COMMAOUT^EHM13UTIL(5,"CID/Preferred Date of Appt","Patient","Clinic","Source","Req IEN"),! ;
 I SORTORDR=2 W $$COMMAOUT^EHM13UTIL(5,"Clinic","CID/Preferred Date of Appt","Patient","Source","Req IEN"),! ;
 I SORTORDR=3 W $$COMMAOUT^EHM13UTIL(5,"Patient","CID/Preferred Date of Appt","Clinic","Source","Req IEN"),! ;
 ;
 ;  Scan sorted data in ^TMP($J)
 ;
 S SORT1="" F  S SORT1=$O(^TMP($J,SORT1)) Q:SORT1=""  D  ;
 . S SORT2="" F  S SORT2=$O(^TMP($J,SORT1,SORT2)) Q:SORT2=""  D  ;
 .. S SORT3="" F  S SORT3=$O(^TMP($J,SORT1,SORT2,SORT3)) Q:SORT3=""  D  ;
 ... I SORTORDR=1 S RQSTDATE=SORT1,DFN=$P(SORT2,U,2),CLINIC=$P(SORT3,U,2) ;
 ... I SORTORDR=2 S CLINIC=$P(SORT1,U,2),RQSTDATE=SORT2,DFN=$P(SORT3,U,2) ;
 ... I SORTORDR=3 S DFN=$P(SORT1,U,2),RQSTDATE=SORT2,CLINIC=$P(SORT3,U,2) ;
 ... ;
 ... S SOURCE=$S($D(^TMP($J,SORT1,SORT2,SORT3,409.85)):"APPT REQ",$D(^TMP($J,SORT1,SORT2,SORT3,409.3)):"WAIT LIST",$D(^TMP($J,SORT1,SORT2,SORT3,403.5)):"RECALL",1:"") ;
 ... S IEN40985="" ;
 ... I SOURCE="APPT REQ" S IEN40985=$P(^TMP($J,SORT1,SORT2,SORT3,409.85),U,1) ;
 ... ;
 ... I SORTORDR=1 D  ;
 .... W $$COMMAOUT^EHM13UTIL(5,$$FMTE^XLFDT(RQSTDATE),$$GET1^DIQ(2,DFN,.01),$$GET1^DIQ(44,CLINIC,.01),SOURCE,IEN40985),! ;
 ... I SORTORDR=2 D  ;
 .... W $$COMMAOUT^EHM13UTIL(5,$$GET1^DIQ(44,CLINIC,.01),$$FMTE^XLFDT(RQSTDATE),$$GET1^DIQ(2,DFN,.01),SOURCE,IEN40985),! ;
 ... I SORTORDR=3 D  ;
 .... W $$COMMAOUT^EHM13UTIL(5,$$GET1^DIQ(2,DFN,.01),$$FMTE^XLFDT(RQSTDATE),$$GET1^DIQ(44,CLINIC,.01),SOURCE,IEN40985),! ;
 ;
 Q  ;
 ;
SUMMARY ;
 ;
 ;  Generate summary of appointment requests
 ;
 N RQSTDATE,CLINNAME,SORT1,SORT2,SORT3,YYYYMM,SOURCE,COUNT,TOTAL,QUEUED,SOURCE ;
 ;
 ;  Source selection
 ;
 K DIR S DIR(0)="SO^ALL:All Sources;REQ:Appointment Requests;WAIT:Wait List;RECALL:Recall Reminders",DIR("A")="Source",DIR("B")="ALL Sources" D ^DIR Q:$D(DIRUT)  S SOURCE=Y ;
 ;
 S %ZIS="Q" D ^%ZIS I POP K ^TMP($J) Q  ;
 ;
 ;  If report is queued, add to Taskman
 ;
 S QUEUED=0 I $D(IO("Q")) S QUEUED=1 D  Q  ;
 . N ZTDESC,ZTRTN,ZTSAVE,ZTSK ;
 . S ZTRTN="SUMMARY1^EHMAPTRQ",ZTDESC="Appointment Request Summary" ;
 . S ZTSAVE("*")="" ;
 . D ^%ZTLOAD W $S($D(ZTSK):"...Task queued",1:"...Task cancelled"),! ;
 ;
SUMMARY1 ;  TaskMan entry point
 ;
 ;  Output summary report.
 ;
 N TITLE,LINES,QUIT,REQTYPE ;
 ;
 ;  Create appointment request list.
 ;
 I QUEUED D OPENRQST(1,0,SOURCE) ;
 I 'QUEUED D OPENRQST(1,1,SOURCE) ;
 ;
 ;  Scan sorted data in ^TMP($J) and summarize data.
 ;
 K ^TMP("EHMAPTRQ",$J) ;
 S SORT1="" F  S SORT1=$O(^TMP($J,SORT1)) Q:SORT1=""  D  ;
 . S SORT2="" F  S SORT2=$O(^TMP($J,SORT1,SORT2)) Q:SORT2=""  D  ;
 .. S SORT3="" F  S SORT3=$O(^TMP($J,SORT1,SORT2,SORT3)) Q:SORT3=""  D  ;
 ... S RQSTDATE=SORT1,CLINNAME=$P(SORT3,U,1),YYYYMM=($E(RQSTDATE,1,3)+1700)_"/"_$E(RQSTDATE,4,5) ;
 ... ;
 ... S SOURCE=$S($D(^TMP($J,SORT1,SORT2,SORT3,409.85)):"APPT REQ",$D(^TMP($J,SORT1,SORT2,SORT3,409.3)):"WAIT LIST",$D(^TMP($J,SORT1,SORT2,SORT3,403.5)):"RECALL",1:"") ;
 ... I SOURCE="APPT REQ" S REQTYPE=$P(^TMP($J,SORT1,SORT2,SORT3,409.85),U,6),SOURCE=SOURCE_"-"_$S(REQTYPE="APPT":"APPT",REQTYPE="RTC":"RTC",1:"OTHER") ;
 ... ;
 ... S ^(SOURCE)=$G(^TMP("EHMAPTRQ",$J,"SOURCE",SOURCE))+1 ;
 ... S ^(YYYYMM)=$G(^TMP("EHMAPTRQ",$J,"DATE",YYYYMM))+1 ;
 ... S ^(CLINNAME)=$G(^TMP("EHMAPTRQ",$J,"CLINIC",CLINNAME))+1 ;
 ;
 U IO D SUMHDR("SOURCE",18) ;
 S TOTAL=0,QUIT=0 F SOURCE="APPT REQ-APPT","APPT REQ-RTC","APPT REQ-OTHER","RECALL","WAIT LIST" S COUNT=+$G(^TMP("EHMAPTRQ",$J,"SOURCE",SOURCE)) W SOURCE,?20,$J(COUNT,8),! S TOTAL=TOTAL+COUNT ;
 W $$DASHES^EHM13UTIL(15),?20,$$DASHES^EHM13UTIL(8),!,"TOTAL",?20,$J(TOTAL,8),! ;
 I 'QUEUED S QUIT=$$CONTINUE^EHM13UTIL()=0 I QUIT K ^TMP($J),^TMP("EHMAPTRQ",$J) D ^%ZISC Q  ;
 ;
 D SUMHDR("DATE",10) ;
 S TOTAL=0,YYYYMM=0,LINES=0,QUIT=0 ;
 F  S YYYYMM=$O(^TMP("EHMAPTRQ",$J,"DATE",YYYYMM)) Q:'YYYYMM  S COUNT=^(YYYYMM) D  Q:QUIT  ;
 . ;
 . ;  If report displayed on screen, stop when screen full and prompt user to continue or stop.
 . ;
 . I 'QUEUED D  Q:QUIT  ;
 .. U 0 ;
 .. I IO=$I Q:LINES<(IOSL-7)  S QUIT=$$CONTINUE^EHM13UTIL()=0 Q:QUIT  U IO D SUMHDR("CLINIC",10) S LINES=1 Q  ;
 .. ;
 .. ;  New page header for printed report
 .. ;
 .. I LINES'<IOSL U IO D SUMHDR("CLINIC",10) S LINES=1 ;
 . ;
 . U IO W $P(YYYYMM,"/",2),"/",$P(YYYYMM,"/",1),?12,$J(COUNT,8),! S TOTAL=TOTAL+COUNT,LINES=LINES+1 ;
 I 'QUIT W $$DASHES^EHM13UTIL(9),?12,$$DASHES^EHM13UTIL(8),!,"TOTAL",?12,$J(TOTAL,8),! ;
 I QUIT K ^TMP($J),^TMP("EHMAPTRQ",$J) D ^%ZISC Q  ;
 I 'QUEUED,'QUIT S QUIT=$$CONTINUE^EHM13UTIL()=0 Q:QUIT  ;
 ;
 D SUMHDR("CLINIC",30) ;
 S TOTAL=0,CLINNAME="",LINES=0,QUIT=0 ;
 F  S CLINNAME=$O(^TMP("EHMAPTRQ",$J,"CLINIC",CLINNAME)) Q:CLINNAME=""  S COUNT=^(CLINNAME) D  Q:QUIT  ;
 . ;
 . ;  If report displayed on screen, stop when screen full and prompt user to continue or stop.
 . ;
 . I 'QUEUED D  Q:QUIT  ;
 .. U 0 ;
 .. I IO=$I Q:LINES<(IOSL-7)  S QUIT=$$CONTINUE^EHM13UTIL()=0 Q:QUIT  U IO D SUMHDR("CLINIC",30) S LINES=1 Q  ;
 .. ;
 .. ;  New page header for printed report
 .. ;
 .. I LINES'<IOSL U IO D SUMHDR("CLINIC",30) S LINES=1 ;
 . ;
 . U IO W CLINNAME,?32,$J(COUNT,8),! S TOTAL=TOTAL+COUNT,LINES=LINES+1 ;
 I 'QUIT W $$DASHES^EHM13UTIL(30),?32,$$DASHES^EHM13UTIL(8),!,"TOTAL",?32,$J(TOTAL,8),! ;
 ;
 U 0 I 'QUEUED,IO=$I R !,"Press [RETURN] to continue",X:$G(DTIME,300) ;
 ;
 K ^TMP($J),^TMP("EHMAPTRQ",$J) D ^%ZISC ;
 Q  ;
 ;
SUMHDR(COLUMN1,WIDTH1) ;
 ;
 W @IOF,$$CENTER^EHM13UTIL("Appointment Request Summary",IOM),! ;
 W !,COLUMN1,?WIDTH1+2,"COUNT",!,$$DASHES^EHM13UTIL(WIDTH1),?WIDTH1+2,$$DASHES^EHM13UTIL(8),! ;
 Q  ;
 ;

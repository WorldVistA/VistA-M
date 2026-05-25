EHMAPPTR ; ALB/WTC - ACTIVE APPOINTMENT REPORT ; Jun 05, 2025@14:51:52
 ;;1.0;ELECTRONIC HEALTH MODERNIZATION;**13**;Apr 19, 2021;Build 27
 ;
 ;
 Q  ;
 ;
ACTVSLCT(RPTYPE,CONVDATE,SORTORDR,FILTER,ADDON) ;
 ;
 ;  Select parameters for list or summary.
 ; 
 ;  RPTYPE   = Report type (LIST or SUMMARY) [REQUIRED]
 ;  CONVDATE = Date of conversion [RETURNED]
 ;  SORTORDR = Sort order (1,2,3) [RETURNED]
 ;  FILTER   = Clinic/Stop Code filter (A=All, C^ien of file #40.7 for Stop Code, S^ien of file #44 for clinic) [RETURNED]
 ;  ADDON    = Add-on field (DENTAL) [RETURNED]
 ;
 I $G(RPTYPE)="" Q  ;
 ;
 N DIR,Y,X ;
 ;
 S (CONVDATE,FILTER,ADDON)="" ;
 ;
 ;  Conversion date
 ;
 S CONVDATE=$$CONVDATE^EHM13UTIL() Q:CONVDATE=""  ;
 ;
 ;  Sort Order
 ;
 I $G(SORTORDR)="" S SORTORDR=$$SORTORDR^EHM13UTIL() Q:SORTORDR=""  ;
 ;
 ;  All clinics, single clinic or single stop code?
 ;
 K DIR ;
 S DIR(0)="SO^A:All Clinics;S:Single Clinic;C:Single Stop Code",DIR("A")="Filter",DIR("B")="All" D ^DIR Q:$D(DIRUT) "" S FILTER=Y ;
 ;
 ;  Select clinic to include.
 ;
 I FILTER="S" K DIC S DIC=44,DIC(0)="AEQM" D ^DIC Q:$D(DIRUT) "" Q:Y=-1 "" S FILTER="S"_U_(+Y) ;
 ;
 ;  Select stop code to include.
 ;
 I FILTER="C" K DIC S DIC=40.7,DIC(0)="AEQM" D ^DIC Q:$D(DIRUT) "" Q:Y=-1 "" S FILTER="C"_U_(+Y) ;
 ;
 I RPTYPE="LIST" K DIR S DIR(0)="Y",DIR("A")="Display dental classification",DIR("B")="NO" D ^DIR Q:Y=""  S ADDON=$S(Y:"DENTAL",1:"") ;
 ;
 Q  ;
 ;
ACTVAPPT(RPTYPE,CONVDATE,SORTORDR,FILTER,QUEUED) ;
 ; 
 ;  RPTYPE   = Report type (LIST, SUMMARY or CLEANUP) [REQUIRED]
 ;  CONVDATE = Date of conversion [REQUIRED]
 ;  SORTORDR = Sort order (1,2,3) [REQUIRED]
 ;  FILTER   = Clinic or Stop Code filter  [REQUIRED]
 ;  QUEUED   = 1 if report queued, 0 otherwise 
 ;
 ;  Active appointment list.  Select active appointments after conversion date.
 ;  Returns conversion date and filter (e.g., 20240223^A if all clinics selected, 20240223^S^123 if single clinic selected, 20240223^C^999 if stop code selected).
 ;  List is in ^TMP($J).
 ;
 ;  ^TMP($J)=SORT ORDER (1,2,3)
 ;  ^TMP($J,sorted values,409.84)=pointer to #409.84 ^ 0 node from file #409.84
 ;  ^TMP($J,sorted values,2)=0 node from appointment multiple in file #2
 ;  ^TMP($J,sorted values,44)=ien of appointment multiple in file #44 ^ 0 node from appointment in file #44
 ;
 ;  sorted values are made up of:  appointment date/time in FileMan format (e.g., 3230701.1209)
 ;                                 patient as LAST NAME,FIRST NAME ^ DFN (e.g., SMITH,JOHN A^12345)
 ;                                 clinic as NAME ^ IEN in file #44. (e.g., MEDICAL CLINIC^12345)
 ;
 N IEN,I,APPTDTTM,IEN2,X,DFN,DATENTRD,RESRC,LASTFI,IEN2,PTAPPT,SDECIEN,SDECAPPT ;
 ;
 K ^TMP($J) ;
 U 0 I 'QUEUED W !,"Scanning ",$P(^DIC(44,0),U,1)," file.",! ;
 S IEN=$S($P(FILTER,U,1)="A":0,$P(FILTER,U,1)="C":0,1:$P(FILTER,U,2)-.000001),I=0 ;
 ;
 F  S IEN=$O(^SC(IEN)) Q:'IEN  Q:$P(FILTER,U,1)="S"&(IEN>$P(FILTER,U,2))  I $$GET1^DIQ(44,IEN,2)="CLINIC" D  ;
 . I $P(FILTER,U,1)="C" Q:$P($G(^SC(IEN,0)),U,7)'=$P(FILTER,U,2)  ;  If filtered by stop code,ignore locations that aren't the selected stop code.
 . S APPTDTTM=CONVDATE-.000001 F  S APPTDTTM=$O(^SC(IEN,"S",APPTDTTM)) Q:'APPTDTTM  D  ;
 .. S IEN2=0 F  S IEN2=$O(^SC(IEN,"S",APPTDTTM,1,IEN2)) Q:'IEN2  S X=$G(^(IEN2,0)) I X'="" D  ;
 ... ;
 ... Q:$P(X,U,9)="C"  ;  Skip if cancelled.
 ... S DFN=$P(X,U,1) Q:'DFN  ;  Skip if bad data.
 ... S DATENTRD=$P(X,U,7) ;
 ... S I=I+1 I I#100=0,'QUEUED D PROGRESS^EHM13UTIL(I) ;
 ... ;
 ... ;  Find record in Patient file and in SDEC Appointment file (if present)
 ... ;
 ... S PTAPPT=$G(^DPT(DFN,"S",APPTDTTM,0)) ;
 ... S SDECIEN=0 F  S SDECIEN=$O(^SDEC(409.84,"B",APPTDTTM,SDECIEN)) Q:'SDECIEN  S SDECAPPT=$G(^SDEC(409.84,SDECIEN,0)) I $P(SDECAPPT,U,5)=DFN,$P(SDECAPPT,U,12)="" Q  ;
 ... I 'SDECIEN S SDECAPPT="" ;
 ... ;
 ... I SORTORDR=1 D  Q  ;
 .... S ^TMP($J,APPTDTTM,$$GET1^DIQ(2,DFN,.01)_U_DFN,$$GET1^DIQ(44,IEN,.01)_U_IEN,44)=IEN2_U_X ;
 .... I PTAPPT'="" S ^TMP($J,APPTDTTM,$$GET1^DIQ(2,DFN,.01)_U_DFN,$$GET1^DIQ(44,IEN,.01)_U_IEN,2)=PTAPPT ;
 .... I SDECIEN S ^TMP($J,APPTDTTM,$$GET1^DIQ(2,DFN,.01)_U_DFN,$$GET1^DIQ(44,IEN,.01)_U_IEN,409.84)=SDECIEN_U_SDECAPPT ;
 ... ;
 ... I SORTORDR=2 D  Q  ;
 .... S ^TMP($J,$$GET1^DIQ(44,IEN,.01)_U_IEN,APPTDTTM,$$GET1^DIQ(2,DFN,.01)_U_DFN,44)=IEN2_U_X ;
 .... I PTAPPT'="" S ^TMP($J,$$GET1^DIQ(44,IEN,.01)_U_IEN,APPTDTTM,$$GET1^DIQ(2,DFN,.01)_U_DFN,2)=PTAPPT ;
 .... I SDECIEN S ^TMP($J,$$GET1^DIQ(44,IEN,.01)_U_IEN,APPTDTTM,$$GET1^DIQ(2,DFN,.01)_U_DFN,409.84)=SDECIEN_U_SDECAPPT ;
 ... ;
 ... I SORTORDR=3 D  Q  ;
 .... S ^TMP($J,$$GET1^DIQ(2,DFN,.01)_U_DFN,APPTDTTM,$$GET1^DIQ(44,IEN,.01)_U_IEN,44)=IEN2_U_X ;
 .... I PTAPPT'="" S ^TMP($J,$$GET1^DIQ(2,DFN,.01)_U_DFN,APPTDTTM,$$GET1^DIQ(44,IEN,.01)_U_IEN,2)=PTAPPT ;
 .... I SDECIEN S ^TMP($J,$$GET1^DIQ(2,DFN,.01)_U_DFN,APPTDTTM,$$GET1^DIQ(44,IEN,.01)_U_IEN,409.84)=SDECIEN_U_SDECAPPT ;
 ;
 Q  ;
 ;
ACTVLIST ;
 ;
 ;  List active appointments after conversion.
 ;
 N RPTYPE,CONVDATE,SORTORDR,FILTER,ADDON,OUTPTFMT,X,Y,POP,%ZIS,DIRUT,QUEUED ;
 ;
 S RPTYPE="LIST" D ACTVSLCT(RPTYPE,.CONVDATE,.SORTORDR,.FILTER,.ADDON) Q:$D(DIRUT)  Q:CONVDATE=""  Q:SORTORDR=""  Q:FILTER=""  ;
 ;
 ;  Output format
 ;
 S OUTPTFMT=$$RPTFMT^EHM13UTIL() Q:OUTPTFMT=""  ;
 ;
 S %ZIS="Q" D ^%ZIS I POP K ^TMP($J) Q  ;
 ;
 ;  If report is queued, add to Taskman
 ;
 S QUEUED=0 I $D(IO("Q")) S QUEUED=1 D  Q  ;
 . N ZTDESC,ZTRTN,ZTSAVE,ZTSK ;
 . S ZTRTN="ACTVLST1^EHMAPPTR",ZTDESC="Appointment List" ;
 . S ZTSAVE("*")="" ;
 . D ^%ZTLOAD W $S($D(ZTSK):"...Task queued",1:"...Task cancelled"),! ;
 ;
ACTVLST1 ;  TaskMan start point
 ;
 ;  Build list of converted appointments.
 ;
 U IO D ACTVAPPT(RPTYPE,CONVDATE,SORTORDR,FILTER,QUEUED) ;
 ;
 ;  List appointments
 ;
 I OUTPTFMT="F" D APPTLSTF("Active Appointment List",CONVDATE,SORTORDR,$G(ADDON),FILTER,QUEUED) ;  Formatted report
 I OUTPTFMT="C" D APPTLSTC("Active Appointment List",SORTORDR,$G(ADDON)) ;  Comma-delimited file
 ;
 U 0 I 'QUEUED,IO=$I R !,"Press [RETURN] to continue",X:$G(DTIME,300) ;
 ;
 D ^%ZISC ;
 K ^TMP($J) ;
 Q  ;
 ;
SUMMARY ;
 ;
 ;  Output summary of active appointments.
 ;
 N CONVDATE,POP,%ZIS,DIRUT,QUEUED ;
 ;
 S RPTYPE="SUMMARY" D ACTVSLCT(RPTYPE,.CONVDATE,1,.FILTER,.ADDON) Q:$D(DIRUT)  Q:CONVDATE=""  Q:FILTER=""  ;
 ;
 S %ZIS="Q" D ^%ZIS I POP K ^TMP($J) Q  ;
 ;
 ;  If report is queued, add to Taskman
 ;
 S QUEUED=0 I $D(IO("Q")) S QUEUED=1 D  Q  ;
 . N ZTDESC,ZTRTN,ZTSAVE,ZTSK ;
 . S ZTRTN="SUMMARY1^EHMAPPTR",ZTDESC="Appointment Summary" ;
 . S ZTSAVE("*")="" ;
 . D ^%ZTLOAD W $S($D(ZTSK):"...Task queued",1:"...Task cancelled"),! ;
 ;
SUMMARY1 ;  TaskMan entry point
 ;
 ;  Output summary report.
 ;
 N TITLE ;
 ;
 ;  Build list of appointments.
 ;
 U IO D ACTVAPPT(RPTYPE,CONVDATE,1,FILTER,QUEUED) ;
 ;
 ;  Output summary report.
 ;
 S TITLE(1)="ACTIVE APPOINTMENT SUMMARY" ;
 I $P(FILTER,U,1)="S" S TITLE(2)="CLINIC: "_$$GET1^DIQ(44,$P(FILTER,U,2),.01) ;
 I $P(FILTER,U,1)="C" S TITLE(2)="STOP CODE: "_$$GET1^DIQ(40.7,$P(FILTER,U,2),.01) ;
 D SUMOUT^EHMAPPT2(.TITLE,CONVDATE,QUEUED) ;
 Q  ;
 ;
APPTLSTF(TITLE,CONVDATE,SORTORDR,ADDON,FILTER,QUEUED) ;  Formatted Report
 ;
 N LINES,QUIT,SDECIEN,SDECAPPT,PTAPPT,SCAPPT,SORT1,SORT2,SORT3,APPTDTTM,DFN,CLINIC,RECRDCT ;
 N WIDTH S WIDTH(1)=30,WIDTH(2)=11,WIDTH(3)=30,WIDTH(4)=14,WIDTH(5)=30 ;
 I $G(ADDON)="DENTAL" S WIDTH(6)=50 ;
 ;
 U IO D HEADER(TITLE,CONVDATE,SORTORDR,ADDON,FILTER) ;
 S LINES=0,QUIT=0,RECRDCT=0 ;
 ;
 ;  Scan sorted data in ^TMP($J)
 ;
 S SORT1="" F  S SORT1=$O(^TMP($J,SORT1)) Q:SORT1=""  D  Q:QUIT  ;
 . S SORT2="" F  S SORT2=$O(^TMP($J,SORT1,SORT2)) Q:SORT2=""  D  Q:QUIT  ;
 .. S SORT3="" F  S SORT3=$O(^TMP($J,SORT1,SORT2,SORT3)) Q:SORT3=""  D  Q:QUIT  ;
 ... I SORTORDR=1 S APPTDTTM=SORT1,DFN=$P(SORT2,U,2),CLINIC=$P(SORT3,U,2) ;
 ... I SORTORDR=2 S CLINIC=$P(SORT1,U,2),APPTDTTM=SORT2,DFN=$P(SORT3,U,2) ;
 ... I SORTORDR=3 S DFN=$P(SORT1,U,2),APPTDTTM=SORT2,CLINIC=$P(SORT3,U,2) ;
 ... ;
 ... S SDECAPPT=$G(^TMP($J,SORT1,SORT2,SORT3,409.84)),SDECIEN=$P(SDECAPPT,U,1),SDECAPPT=$P(SDECAPPT,U,2,999) ;
 ... S PTAPPT=$G(^TMP($J,SORT1,SORT2,SORT3,2)) ;
 ... S SCAPPT=$G(^TMP($J,SORT1,SORT2,SORT3,44)) ;
 ... K VADM D DEM^VADPT ;
 ... ;
 ... I 'QUEUED D  Q:QUIT  ;
 .... U 0 ;
 .... I IO=$I Q:LINES<(IOSL-7)  S QUIT=$$CONTINUE^EHM13UTIL()=0 Q:QUIT  U IO D HEADER(TITLE,CONVDATE,SORTORDR,ADDON,FILTER) S LINES=1 Q  ;
 .... ;
 .... ;  New page header for printed report
 .... ;
 .... I LINES'<IOSL U IO D HEADER(TITLE,CONVDATE,SORTORDR,ADDON,FILTER) S LINES=1 ;
 ... ;
 ... U IO ;
 ... I SORTORDR=1 D  ;
 .... S WIDTH=0 W $$FMTDTTM^EHM13UTIL(APPTDTTM) S WIDTH=WIDTH+WIDTH(4)+2 ;
 .... W ?WIDTH,VADM(1) S WIDTH=WIDTH+WIDTH(1)+2 ;
 .... W ?WIDTH,$P(VADM(3),U,2) S WIDTH=WIDTH+WIDTH(2)+2 ;
 .... W ?WIDTH,$$EDIPI(DFN,$P($$SITE^VASITE(),U,3)) S WIDTH=WIDTH+WIDTH(3)+2 ;
 .... W ?WIDTH,$$GET1^DIQ(44,CLINIC,.01) S WIDTH=WIDTH+WIDTH(5)+2 ;
 .... I $G(ADDON)="DENTAL" W ?WIDTH,$$GET1^DIQ(220,DFN,70.01)
 .... W ! ;
 ... ;
 ... I SORTORDR=2 D  ;
 .... S WIDTH=0 W $$GET1^DIQ(44,CLINIC,.01) S WIDTH=WIDTH+WIDTH(5)+2 ;
 .... W ?WIDTH,$$FMTDTTM^EHM13UTIL(APPTDTTM) S WIDTH=WIDTH+WIDTH(4)+2 ;
 .... W ?WIDTH,VADM(1) S WIDTH=WIDTH+WIDTH(1)+2 ;
 .... W ?WIDTH,$P(VADM(3),U,2) S WIDTH=WIDTH+WIDTH(2)+2 ;
 .... W ?WIDTH,$$EDIPI(DFN,$P($$SITE^VASITE(),U,3)) S WIDTH=WIDTH+WIDTH(3)+2 ;
 .... I $G(ADDON)="DENTAL" W ?WIDTH,$$GET1^DIQ(220,DFN,70.01)
 .... W ! ;
 ... ;
 ... I SORTORDR=3 D  ;
 .... S WIDTH=0 W VADM(1) S WIDTH=WIDTH+WIDTH(1)+2 ;
 .... W ?WIDTH,$P(VADM(3),U,2) S WIDTH=WIDTH+WIDTH(2)+2 ;
 .... W ?WIDTH,$$EDIPI(DFN,$P($$SITE^VASITE(),U,3)) S WIDTH=WIDTH+WIDTH(3)+2 ;
 .... W ?WIDTH,$$FMTDTTM^EHM13UTIL(APPTDTTM) S WIDTH=WIDTH+WIDTH(4)+2 ;
 .... W ?WIDTH,$$GET1^DIQ(44,CLINIC,.01) S WIDTH=WIDTH+WIDTH(5)+2 ;
 .... I $G(ADDON)="DENTAL" W ?WIDTH,$$GET1^DIQ(220,DFN,70.01)
 .... W ! ;
 ... ;
 ... S LINES=LINES+1,RECRDCT=RECRDCT+1 ;
 W !,"TOTAL RECORDS = ",RECRDCT,! ;
 ;
 Q  ;
 ;
APPTLSTC(TITLE,SORTORDR,TYPE) ;  Comma-delimited file
 ;
 N SORT1,SORT2,SORT3,APPTDTTM,DFN,CLINIC,SDECIEN,SDECAPPT,PTAPPT,SCAPPT ;
 ;
 U IO ;
 ;
 ;  Output first row - list of data fields
 ; 
 N HDR S HDR(1)="Patient",HDR(2)="DOB",HDR(3)="EDIPI",HDR(4)="Appt Date/Time",HDR(5)="Clinic" ;
 I $G(TYPE)="DENTAL" S HDR(6)="Dental Classification" ;
 ;
 I SORTORDR=1 D  ;
 . I $G(TYPE)="DENTAL" W $$COMMAOUT^EHM13UTIL(6,HDR(4),HDR(1),HDR(2),HDR(3),HDR(5),HDR(6)),! ;
 . E  W $$COMMAOUT^EHM13UTIL(5,HDR(4),HDR(1),HDR(2),HDR(3),HDR(5)),! ;
 I SORTORDR=2 D  ;
 . I $G(TYPE)="DENTAL" W $$COMMAOUT^EHM13UTIL(6,HDR(5),HDR(4),HDR(1),HDR(2),HDR(3),HDR(6)),! ;
 . E  W $$COMMAOUT^EHM13UTIL(5,HDR(5),HDR(4),HDR(1),HDR(2),HDR(3)),! ;
 I SORTORDR=3 D  ;
 . I $G(TYPE)="DENTAL" W $$COMMAOUT^EHM13UTIL(6,HDR(1),HDR(2),HDR(3),HDR(4),HDR(5),HDR(6)),! ;
 . E  W $$COMMAOUT^EHM13UTIL(5,HDR(1),HDR(2),HDR(3),HDR(4),HDR(5)),! ;
 ;
 ;  Scan sorted data in ^TMP($J)
 ;
 S SORT1="" F  S SORT1=$O(^TMP($J,SORT1)) Q:SORT1=""  D  ;
 . S SORT2="" F  S SORT2=$O(^TMP($J,SORT1,SORT2)) Q:SORT2=""  D  ;
 .. S SORT3="" F  S SORT3=$O(^TMP($J,SORT1,SORT2,SORT3)) Q:SORT3=""  D  ;
 ... I SORTORDR=1 S APPTDTTM=SORT1,DFN=$P(SORT2,U,2),CLINIC=$P(SORT3,U,2) ;
 ... I SORTORDR=2 S CLINIC=$P(SORT1,U,2),APPTDTTM=SORT2,DFN=$P(SORT3,U,2) ;
 ... I SORTORDR=3 S DFN=$P(SORT1,U,2),APPTDTTM=SORT2,CLINIC=$P(SORT3,U,2) ;
 ... ;
 ... S SDECAPPT=$G(^TMP($J,SORT1,SORT2,SORT3,409.84)),SDECIEN=$P(SDECAPPT,U,1),SDECAPPT=$P(SDECAPPT,U,2,999) ;
 ... S PTAPPT=$G(^TMP($J,SORT1,SORT2,SORT3,2)) ;
 ... S SCAPPT=$G(^TMP($J,SORT1,SORT2,SORT3,44)) ;
 ... K VADM D DEM^VADPT ;
 ... ;
 ... I SORTORDR=1 D  ;
 .... I $G(TYPE)="DENTAL" W $$COMMAOUT^EHM13UTIL(6,$$FMTDTTM^EHM13UTIL(APPTDTTM),VADM(1),$P(VADM(3),U,2),$$EDIPI(DFN,$P($$SITE^VASITE(),U,3)),$$GET1^DIQ(44,CLINIC,.01),$$GET1^DIQ(220,DFN,70.01)),! ;
 .... E  W $$COMMAOUT^EHM13UTIL(5,$$FMTDTTM^EHM13UTIL(APPTDTTM),VADM(1),$P(VADM(3),U,2),$$EDIPI(DFN,$P($$SITE^VASITE(),U,3)),$$GET1^DIQ(44,CLINIC,.01)),! ;
 ... I SORTORDR=2 D  ;
 .... I $G(TYPE)="DENTAL" W $$COMMAOUT^EHM13UTIL(6,$$GET1^DIQ(44,CLINIC,.01),$$FMTDTTM^EHM13UTIL(APPTDTTM),VADM(1),$P(VADM(3),U,2),$$EDIPI(DFN,$P($$SITE^VASITE(),U,3)),$$GET1^DIQ(220,DFN,70.01)),! ;
 .... E  W $$COMMAOUT^EHM13UTIL(5,$$GET1^DIQ(44,CLINIC,.01),$$FMTDTTM^EHM13UTIL(APPTDTTM),VADM(1),$P(VADM(3),U,2),$$EDIPI(DFN,$P($$SITE^VASITE(),U,3))),! ;
 ... I SORTORDR=3 D  ;
 .... I $G(TYPE)="DENTAL" W $$COMMAOUT^EHM13UTIL(6,VADM(1),$P(VADM(3),U,2),$$EDIPI(DFN,$P($$SITE^VASITE(),U,3)),$$FMTDTTM^EHM13UTIL(APPTDTTM),$$GET1^DIQ(44,CLINIC,.01),$$GET1^DIQ(220,DFN,70.01)),! ;
 .... E  W $$COMMAOUT^EHM13UTIL(5,VADM(1),$P(VADM(3),U,2),$$EDIPI(DFN,$P($$SITE^VASITE(),U,3)),$$FMTDTTM^EHM13UTIL(APPTDTTM),$$GET1^DIQ(44,CLINIC,.01)),! ;
 ;
 Q  ;
 ;
HEADER(TITLE,CONVDATE,SORTORDR,TYPE,FILTER) ;
 ;
 ;  TITLE    = Report title
 ;  CONVDATE = Conversion date (FM format)
 ;  SORTORDR = Sort order (1,2,3)
 ;  TYPE (see POSTLIST)
 ;  FILTER   = "A" if all clinics selected, "S^ien in #44" if single clinic selected, "C^ien in #40.7 if single stop code selected.
 ;
 W @IOF,$$CENTER^EHM13UTIL(TITLE_" - Station "_$P($$SITE^VASITE(),U,3),$G(IOM,80)),! ;
 I $P($G(FILTER),U,1)="S" W $$CENTER^EHM13UTIL("CLINIC: "_$$GET1^DIQ(44,$P(FILTER,U,2),.01),$G(IOM,80)),! ;
 I $P($G(FILTER),U,1)="C" W $$CENTER^EHM13UTIL("STOP CODE: "_$$GET1^DIQ(40.7,$P(FILTER,U,2),.01),$G(IOM,80)),! ;
 W:$G(CONVDATE)'="" $$CENTER^EHM13UTIL("Conversion Date: "_$$FMTE^XLFDT(CONVDATE),$G(IOM,80)),! W ! ;
 ;
 N HDR S HDR(1)="Patient",HDR(2)="DOB",HDR(3)="EDIPI",HDR(4)="Appt Date/Time",HDR(5)="Clinic" ;
 N WIDTH S WIDTH(1)=30,WIDTH(2)=11,WIDTH(3)=30,WIDTH(4)=14,WIDTH(5)=30 ;
 ;
 I $G(TYPE)="DENTAL" S HDR(6)="Dental Classification",WIDTH(6)=50 ;
 ;
 N IDX ;
 I SORTORDR=1 D  ;
  . S WIDTH=0 ;
  . F IDX=4,1,2,3,5,$S($G(TYPE)'="":6,1:"") I IDX W ?WIDTH,HDR(IDX) S WIDTH=WIDTH+WIDTH(IDX)+2 ;
  . W ! ;
  . S WIDTH=0 ;
  . F IDX=4,1,2,3,5,$S($G(TYPE)'="":6,1:"") I IDX W ?WIDTH,$$DASHES^EHM13UTIL(WIDTH(IDX)) S WIDTH=WIDTH+WIDTH(IDX)+2 ;
  . W ! ;
 ;
 I SORTORDR=2 D  ;
  . S WIDTH=0 ;
  . F IDX=5,4,1,2,3,$S($G(TYPE)'="":6,1:"") I IDX W ?WIDTH,HDR(IDX) S WIDTH=WIDTH+WIDTH(IDX)+2 ;
  . W ! ;
  . S WIDTH=0 ;
  . F IDX=5,4,1,2,3,$S($G(TYPE)'="":6,1:"") I IDX W ?WIDTH,$$DASHES^EHM13UTIL(WIDTH(IDX)) S WIDTH=WIDTH+WIDTH(IDX)+2 ;
  . W ! ;
 ;
 I SORTORDR=3 D  ;
  . S WIDTH=0 ;
  . F IDX=1,2,3,4,5,$S($G(TYPE)'="":6,1:"") I IDX W ?WIDTH,HDR(IDX) S WIDTH=WIDTH+WIDTH(IDX)+2 ;
  . W ! ;
  . S WIDTH=0 ;
  . F IDX=1,2,3,4,5,$S($G(TYPE)'="":6,1:"") I IDX W ?WIDTH,$$DASHES^EHM13UTIL(WIDTH(IDX)) S WIDTH=WIDTH+WIDTH(IDX)+2 ;
  . W ! ;
 ;
 Q  ;
 ;
EDIPI(DFN,SITE) ;
 ;
 ;  Return patient's EDIPI
 ;
 N TFLIST,I,EDIPI ;
 ;
 D TFL^VAFCTFU2(.TFLIST,DFN_U_"PI"_U_"USVHA"_U_SITE) ;  icr #4648
 ;
 S EDIPI="" F I=1:1 Q:'$D(TFLIST(I))  I $P(TFLIST(I),U,2)="NI",$P(TFLIST(I),U,3)="USDOD",$P(TFLIST(I),U,4)="200DOD",$P(TFLIST(I),U,5)="A" S EDIPI=$P(TFLIST(I),U,1) Q  ;
 ;
 Q EDIPI ;
 ;

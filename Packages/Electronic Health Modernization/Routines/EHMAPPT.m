EHMAPPT ;ALB/WTC - EHRM APPOINTMENT MAINTENANCE; Jun 05, 2025@14:49:48
 ;;1.0;ELECTRONIC HEALTH MODERNIZATION;**13**;Apr 19, 2021;Build 27
 ;
 Q  ;
 ;
CNVSELCT(RPTYPE,CONVDATE,SORTORDR,CLINFLTR,CLINICS,FILTER,NONCOUNT) ;
 ;
 ;  Select parameters for list or summary.
 ; 
 ;  RPTYPE   = Report type (LIST, SUMMARY, CLEANUP, OTHER) [REQUIRED]
 ;  CONVDATE = Date of conversion [RETURNED]
 ;  SORTORDR = Sort order (1,2,3) [RETURNED]
 ;  CLINFLTR = Clinic filter (A or S^clinic IEN)
 ;  CLINICS  = Clinics to include/exclude [RETURNED]
 ;  FILTER   = Encounter filter (ALL, WITH or WITHOUT) [RETURNED]
 ;  NONCOUNT = Include/exclude non-count clinics [RETURNED]
 ;
 I $G(RPTYPE)="" Q  ;
 ;
 S (CONVDATE,FILTER)="" ;
 ;
 ;  Conversion date
 ;
 S CONVDATE=$$CONVDATE^EHM13UTIL() Q:CONVDATE=""  ;
 ;
 ;  Sort Order
 ;
 I $G(SORTORDR)="" S SORTORDR=$$SORTORDR^EHM13UTIL() Q:SORTORDR=""  ;
 ;
 ;  Include/exclude noncount clinics
 ;
 S NONCOUNT=$$NONCOUNT^EHM13UTIL() Q:NONCOUNT=""  ;
 ;
 ;  All clinics, All except some clinics, selected clinics.
 ;
 S CLINFLTR=$$CLINICS^EHM13UTIL(.CLINICS) Q:CLINFLTR=""  ;
 ;
 ;  All appointments or with/without encounters only
 ;
 S FILTER="" I RPTYPE="LIST" S FILTER=$$FILTER^EHM13UTIL() Q:FILTER=""  ;
 ;
 Q  ;
 ;
CNVTDAPT(RPTYPE,CONVDATE,SORTORDR,CLINFLTR,CLINICS,FILTER,NONCOUNT,QUEUED,INCLCANC,ACTREQ) ;
 ; 
 ;  QUEUED   = 1 if report queued, 0 otherwise 
 ;  INCLCANC = 1 if cancelled appointments included, 0 otherwise
 ;  ACTREQ   = 1 if only ACTION REQUIRED encounters included, 0 otherwise
 ;
 ;  See CNVSELCT for remaining parameter definitions
 ;
 ;  Converted appointment list.  Select appointments with dates after converted date.  Include only active appointments made less than 2 years before converted date.
 ;  Returns list in ^TMP($J).
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
 N IEN,CTR,APPTDTTM,IEN2,X,DFN,CNCLDTTM,DATENTRD,PTAPPT,ENCNTR,SDECIEN,SDECAPPT ;
 ;
 K ^TMP($J) ;
 I 'QUEUED U 0 W !,"Scanning ",$P(^DIC(44,0),U,1)," file.",! ;
 ;
 ;S IEN=$S($P(CLINFLTR,U,1)="A":0,1:$P(CLINFLTR,U,2)-.000001),CTR=0 ;
 S IEN=0,CTR=0 ;
 ;F  S IEN=$O(^SC(IEN)) Q:'IEN  Q:$P(CLINFLTR,U,1)="S"&(IEN>$P(CLINFLTR,U,2))  I $$GET1^DIQ(44,IEN,2)="CLINIC",'$D(^EHRM(1610,"B",IEN)) D  ;
 F  S IEN=$O(^SC(IEN)) Q:'IEN  I $$GET1^DIQ(44,IEN,2)="CLINIC",'$D(^EHRM(1610,"B",IEN)) D  ;
 . ;
 . I NONCOUNT="E",$$GET1^DIQ(44,IEN,2502)="YES" Q  ;  Exclude non-count clinic
 . I CLINFLTR="X",$D(CLINICS(IEN)) Q:CLINICS(IEN)="EXCLUDE"  ;
 . I CLINFLTR="S" Q:'$D(CLINICS(IEN))  ;
 . ;
 . S APPTDTTM=CONVDATE-.000001 F  S APPTDTTM=$O(^SC(IEN,"S",APPTDTTM)) Q:'APPTDTTM  S IEN2=0 F  S IEN2=$O(^SC(IEN,"S",APPTDTTM,1,IEN2)) Q:'IEN2  S X=$G(^(IEN2,0)) I X'="" D  ;
 .. ;
 .. S DFN=$P(X,U,1) Q:'DFN  ;  Skip if bad data.
 .. I '$G(INCLCANC) Q:$P(X,U,9)="C"  ;  Exclude cancelled appointments - wtc 5/15/2024
 .. S DATENTRD=$P(X,U,7) I DATENTRD'="" Q:DATENTRD<$$FMADD^XLFDT(CONVDATE,-2*365)  Q:DATENTRD>CONVDATE  ;  Skip if entered more than 2 years before conversion date or after conversion date
 .. ;
 .. ;  Find record in Patient file and in SDEC Appointment file (if present)
 .. ;
 .. S PTAPPT=$G(^DPT(DFN,"S",APPTDTTM,0)),ENCNTR=$P(PTAPPT,U,20) ;
 .. I PTAPPT'="" Q:$P(PTAPPT,U,2)="CNV"  ;  Skip if already converted.
 .. ;
 .. S SDECIEN=0 F  S SDECIEN=$O(^SDEC(409.84,"B",APPTDTTM,SDECIEN)) Q:'SDECIEN  S SDECAPPT=$G(^SDEC(409.84,SDECIEN,0)) I $P(SDECAPPT,U,5)=DFN,$P(SDECAPPT,U,12)="" Q  ;
 .. I 'SDECIEN S SDECAPPT="" ;
 .. I SDECAPPT'="" Q:$P(SDECAPPT,U,17)="CNV"  ;  Skip if already converted.
 .. ;
 .. ;  Filter report
 .. ;
 .. I RPTYPE="LIST",FILTER=2,ENCNTR="" Q  ;  Appointments with encounters
 .. I RPTYPE="LIST",FILTER=3,ENCNTR'="" Q  ; Appointment without encounters
 .. I RPTYPE="LIST",FILTER=4,ENCNTR'="",$$ENCTRSTS^EHM13UTIL(ENCNTR)="ACTION REQUIRED",'$$MPTYNCTR^EHM13UTIL(ENCNTR) Q  ; Appointments without ACTION REQUIRED encounters
 .. ;
 .. ;  ACTION REQUIRED Encounters only
 .. ;
 .. I $G(ACTREQ) Q:ENCNTR=""  Q:$$ENCTRSTS^EHM13UTIL(ENCNTR)'="ACTION REQUIRED"  Q:$$MPTYNCTR^EHM13UTIL(ENCNTR)  ;
 .. ;
 .. S CTR=CTR+1 I CTR#100=0,'QUEUED D PROGRESS^EHM13UTIL(CTR) ;
 .. ;
 .. ;  Build ^TMP($J) in sort order
 .. ;
 .. I SORTORDR=1 D  Q  ;
 ... S ^TMP($J,APPTDTTM,$$GET1^DIQ(2,DFN,.01)_U_DFN,$$GET1^DIQ(44,IEN,.01)_U_IEN,44)=IEN2_U_X ;
 ... I PTAPPT'="" S ^TMP($J,APPTDTTM,$$GET1^DIQ(2,DFN,.01)_U_DFN,$$GET1^DIQ(44,IEN,.01)_U_IEN,2)=PTAPPT ;
 ... I SDECIEN S ^TMP($J,APPTDTTM,$$GET1^DIQ(2,DFN,.01)_U_DFN,$$GET1^DIQ(44,IEN,.01)_U_IEN,409.84)=SDECIEN_U_SDECAPPT ;
 .. ;
 .. I SORTORDR=2 D  Q  ;
 ... S ^TMP($J,$$GET1^DIQ(44,IEN,.01)_U_IEN,APPTDTTM,$$GET1^DIQ(2,DFN,.01)_U_DFN,44)=IEN2_U_X ;
 ... I PTAPPT'="" S ^TMP($J,$$GET1^DIQ(44,IEN,.01)_U_IEN,APPTDTTM,$$GET1^DIQ(2,DFN,.01)_U_DFN,2)=PTAPPT ;
 ... I SDECIEN S ^TMP($J,$$GET1^DIQ(44,IEN,.01)_U_IEN,APPTDTTM,$$GET1^DIQ(2,DFN,.01)_U_DFN,409.84)=SDECIEN_U_SDECAPPT ;
 .. ;
 .. I SORTORDR=3 D  Q  ;
 ... S ^TMP($J,$$GET1^DIQ(2,DFN,.01)_U_DFN,APPTDTTM,$$GET1^DIQ(44,IEN,.01)_U_IEN,44)=IEN2_U_X ;
 ... I PTAPPT'="" S ^TMP($J,$$GET1^DIQ(2,DFN,.01)_U_DFN,APPTDTTM,$$GET1^DIQ(44,IEN,.01)_U_IEN,2)=PTAPPT ;
 ... I SDECIEN S ^TMP($J,$$GET1^DIQ(2,DFN,.01)_U_DFN,APPTDTTM,$$GET1^DIQ(44,IEN,.01)_U_IEN,409.84)=SDECIEN_U_SDECAPPT ;
 ;
 Q  ;
 ;
CNVTDLST ;
 ;
 ;  List converted appointments.
 ;
 N RPTYPE,CONVDATE,SORTORDR,DFN,APPTDTTM,CLINIC,X1,X2,X3,LASTFI,SORT1,SORT2,SORT3,OUTPTFMT,Y,POP,%ZIS,DIRUT,QUEUED,OUTPTFMT,TITLE,CLINICS,NONCOUNT ;
 ;
 S RPTYPE="LIST" D CNVSELCT(RPTYPE,.CONVDATE,.SORTORDR,.CLINFLTR,.CLINICS,.FILTER,.NONCOUNT) Q:$D(DIRUT)  Q:CONVDATE=""  Q:SORTORDR=""  Q:CLINFLTR=""  Q:FILTER=""  Q:NONCOUNT=""  ;
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
 . S ZTRTN="CNVTDLS1^EHMAPPT",ZTDESC="Converted Appointment List" ;
 . S ZTSAVE("*")="" ;
 . D ^%ZTLOAD W $S($D(ZTSK):"...Task queued",1:"...Task cancelled"),! ;
 ;
CNVTDLS1 ;  TaskMan start point
 ;
 ;  Build list of converted appointments.
 ;
 U IO D CNVTDAPT(RPTYPE,CONVDATE,SORTORDR,CLINFLTR,.CLINICS,FILTER,NONCOUNT,QUEUED,0,0) ;  Build list of converted appointments.
 ;
 ;  List appointments
 ;
 S TITLE="Converted Appointment List ("_$P("All Appointments^Appointments With Encounters^Appointments Without Encounters^Appointments Without ACTION REQUIRED Encounters",U,FILTER)_")" ;
 I OUTPTFMT="F" D APPTLSTF(TITLE,CONVDATE,SORTORDR,1,QUEUED) ;  Formatted report
 I OUTPTFMT="C" D APPTLSTC(TITLE,SORTORDR,1) ;  Comma-delimited file
 ;
 D ^%ZISC ;
 K ^TMP($J) ;
 Q  ;
 ;
HEADER(TITLE,CONVDATE,SORTORDR,LISTFMT,PAGE) ;
 ;
 ;  TITLE    = Report title
 ;  CONVDATE = Conversion date (FM format)
 ;  SORTORDR = Sort order (1,2,3)
 ;  LISTFMT  = 1 for 5 data fields: Appointment Date/Time, Patient, Clinic, Status, Encounter (DEFAULT)
 ;  LISTFMT  = 2 for 7 data fields: All from LISTFMT=1 plus Date Appointment Made and Made By
 ;
 W @IOF,$$CENTER^EHM13UTIL(TITLE,IOM),?IOM-3-$L(PAGE),"p. ",PAGE,! W:$G(CONVDATE)'="" $$CENTER^EHM13UTIL("Conversion Date: "_$$FMTE^XLFDT(CONVDATE),IOM),! W ! ;
 ;
 I SORTORDR=1 D  ;
 . W "Appointment",?80,"Appt",?88,"[-------------Encounter------------]" W:$G(LISTFMT)=2 ?125,"Appointment" W ! ;
 . W "Date/Time",?16,"Patient",?48,"Clinic",?80,"Status",?88,"Status",?111,"Unique ID" W:$G(LISTFMT)=2 ?125,"Made/Made By" W ! ;
 . W $$DASHES^EHM13UTIL(14),?16,$$DASHES^EHM13UTIL(30),?48,$$DASHES^EHM13UTIL(30),?80,$$DASHES^EHM13UTIL(6),?88,$$DASHES^EHM13UTIL(21),?111,$$DASHES^EHM13UTIL(13) ;
 . W:$G(LISTFMT)=2 ?125,$$DASHES^EHM13UTIL(20) W ! ;
 ;
 I SORTORDR=2 D  ;
 . W ?32,"Appointment",?80,"Appt",?88,"[-------------Encounter------------]" W:$G(LISTFMT)=2 ?125,"Appointment" W ! ;
 . W "Clinic",?32,"Date/Time",?48,"Patient",?80,"Status",?88,"Status",?111,"Unique ID" W:$G(LISTFMT)=2 ?125,"Made/Made By" W ! ;
 . W $$DASHES^EHM13UTIL(30),?32,$$DASHES^EHM13UTIL(14),?48,$$DASHES^EHM13UTIL(30),?80,$$DASHES^EHM13UTIL(6),?88,$$DASHES^EHM13UTIL(21),?111,$$DASHES^EHM13UTIL(13) ;
 . W:$G(LISTFMT)=2 ?125,$$DASHES^EHM13UTIL(20) W ! ;
 ;
 I SORTORDR=3 D  ;
 . W ?32,"Appointment",?80,"Appt",?88,"[-------------Encounter------------]" W:$G(LISTFMT)=2 ?125,"Appointment" W ! ;
 . W "Patient",?32,"Date/Time",?48,"Clinic",?80,"Status",?88,"Status",?111,"Unique ID"  W:$G(LISTFMT)=2 ?125,"Made/Made By" W ! ;
 . W $$DASHES^EHM13UTIL(30),?32,$$DASHES^EHM13UTIL(14),?48,$$DASHES^EHM13UTIL(30),?80,$$DASHES^EHM13UTIL(6),?88,$$DASHES^EHM13UTIL(21),?111,$$DASHES^EHM13UTIL(13) ;
 . W:$G(LISTFMT)=2 ?125,$$DASHES^EHM13UTIL(20) W ! ;
 ;
 Q  ;
 ;
APPTLSTF(TITLE,CONVDATE,SORTORDR,LISTFMT,QUEUED) ;  Formatted Report
 ;
 N LINES,QUIT,SDECIEN,SDECAPPT,PTAPPT,SCAPPT,SORT1,SORT2,SORT3,APPTDTTM,DFN,CLINIC,RECRDCT,ENCNTR,FMTDTTM,ENCTRSTS,VADM,APPTSTS,UNIQUEID,PAGE ;
 ;
 S LINES=0,QUIT=0,RECRDCT=0,PAGE=1 ;
 U IO D HEADER(TITLE,CONVDATE,SORTORDR,LISTFMT,PAGE) ;
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
 ... S PTAPPT=$G(^TMP($J,SORT1,SORT2,SORT3,2)),ENCNTR=$P(PTAPPT,U,20) ;
 ... S SCAPPT=$G(^TMP($J,SORT1,SORT2,SORT3,44)) ;
 ... K VADM D DEM^VADPT ;
 ... ;
 ... ;  If report displayed on screen, stop when screen full and prompt user to continue or stop.
 ... ;
 ... I 'QUEUED D  Q:QUIT  ;
 .... U 0 ;
 .... I IO=$I Q:LINES<(IOSL-7)  S QUIT=$$CONTINUE^EHM13UTIL()=0,PAGE=PAGE+1 Q:QUIT  U IO D HEADER(TITLE,CONVDATE,SORTORDR,LISTFMT,PAGE) S LINES=1 Q  ;
 .... ;
 .... ;  New page header for printed report
 .... ;
 .... I LINES'<IOSL S PAGE=PAGE+1 U IO D HEADER(TITLE,CONVDATE,SORTORDR,LISTFMT,PAGE) S LINES=1 ;
 ... ;
 ... S FMTDTTM=$$FMTDTTM^EHM13UTIL(APPTDTTM),ENCTRSTS=$S(ENCNTR'="":$$ENCTRSTS^EHM13UTIL(ENCNTR),1:"") ;
 ... I ENCTRSTS="ACTION REQUIRED",$$MPTYNCTR^EHM13UTIL(ENCNTR) S ENCTRSTS="EMPTY" ;
 ... I ENCNTR'="",ENCTRSTS="" S ENCTRSTS="blank" ;  Encounter present but status is null.
 ... I ENCNTR="" S ENCTRSTS="none" ;  Encounter is not present.
 ... S APPTSTS=$$GET1^DIQ(2.98,APPTDTTM_","_DFN,3,"I") I APPTSTS="" S APPTSTS="blank" ;  Appointment status is null.
 ... S UNIQUEID="" I ENCNTR'="" S UNIQUEID=$$GET1^DIQ(409.68,ENCNTR,.2) ;
 ... ;
 ... I SORTORDR=1 D  ;
 .... U IO W FMTDTTM,?16,$$LASTFI^EHM13UTIL(,VADM(1))," (",$P($P(VADM(2),U,2),"-",3),")",?48,$$GET1^DIQ(44,CLINIC,.01),?80,APPTSTS,?88,ENCTRSTS,?111,UNIQUEID ;
 .... I $G(LISTFMT)=2 W ?125,$$FMTE^XLFDT($P($P(PTAPPT,U,19),".",1),2),!?125,$$LASTFI^EHM13UTIL(,$$GET1^DIQ(200,$P(PTAPPT,U,18),.01)) ;
 .... W ! ;
 ... I SORTORDR=2 D  ;
 .... U IO W $$GET1^DIQ(44,CLINIC,.01),?32,FMTDTTM,?48,$$LASTFI^EHM13UTIL(,VADM(1))," (",$P($P(VADM(2),U,2),"-",3),")",?80,APPTSTS,?88,ENCTRSTS,?111,UNIQUEID ;
 .... I $G(LISTFMT)=2 W ?125,$$FMTE^XLFDT($P($P(PTAPPT,U,19),".",1),2),!?125,$$LASTFI^EHM13UTIL(,$$GET1^DIQ(200,$P(PTAPPT,U,18),.01)) ;
 .... W ! ;
 ... I SORTORDR=3 D  ;
 .... U IO W $$LASTFI^EHM13UTIL(,VADM(1))," (",$P($P(VADM(2),U,2),"-",3),")",?32,FMTDTTM,?48,$$GET1^DIQ(44,CLINIC,.01),?80,APPTSTS,?88,ENCTRSTS,?111,UNIQUEID ;
 .... I $G(LISTFMT)=2 W ?125,$$FMTE^XLFDT($P($P(PTAPPT,U,19),".",1),2),!?125,$$LASTFI^EHM13UTIL(,$$GET1^DIQ(200,$P(PTAPPT,U,18),.01)) ;
 .... W ! ;
 ... S LINES=LINES+$S($G(LISTFMT)=2:2,1:1),RECRDCT=RECRDCT+1 ;
 W !,"TOTAL RECORDS = ",RECRDCT,! ;
 ;
 U 0 I 'QUEUED,IO=$I R !,"Press [RETURN] to continue",X:$G(DTIME,300) ;
 ;
 Q  ;
 ;
APPTLSTC(TITLE,SORTORDR,LISTFMT) ;  Comma-delimited file
 ;
 N SORT1,SORT2,SORT3,APPTDTTM,DFN,CLINIC,SDECIEN,SDECAPPT,PTAPPT,SCAPPT,ENCNTR,FMTDTTM,ENCTRSTS,VADM,APPTSTS,UNIQUEID ;
 ;
 U IO ;
 ;
 ;  Output first row - list of data fields
 ; 
 I SORTORDR=1 D  ;
 . I $G(LISTFMT)'=2 W $$COMMAOUT^EHM13UTIL(7,"Appt Date/Time","Patient","SSN","Clinic","Appt Status","Encounter Status","Encounter ID"),! ;
 . E  W $$COMMAOUT^EHM13UTIL(9,"Appt Date/Time","Patient","SSN","Clinic","Status","Encounter Status","Encounter ID","Appt Made","Made By"),! ;
 I SORTORDR=2 D  ;
 . I $G(LISTFMT)'=2 W $$COMMAOUT^EHM13UTIL(7,"Clinic","Appt Date/Time","Patient","SSN","Appt Status","Encounter Status","Encounter ID"),! ;
 . E  W $$COMMAOUT^EHM13UTIL(9,"Clinic","Appt Date/Time","Patient","SSN","Status","Encounter Status","Encounter ID","Appt Made","Made By"),! ;
 I SORTORDR=3 D  ;
 . I $G(LISTFMT)'=2 W $$COMMAOUT^EHM13UTIL(7,"Patient","SSN","Appt Date/Time","Clinic","Appt Status","Encounter Status","Encounter ID"),! ;
 . E  W $$COMMAOUT^EHM13UTIL(9,"Patient","SSN","Appt Date/Time","Clinic","Status","Encounter Status","Encounter ID","Appt Made","Made By"),! ;
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
 ... S PTAPPT=$G(^TMP($J,SORT1,SORT2,SORT3,2)),ENCNTR=$P(PTAPPT,U,20) ;
 ... S SCAPPT=$G(^TMP($J,SORT1,SORT2,SORT3,44)) ;
 ... K VADM D DEM^VADPT ;
 ... ;
 ... S FMTDTTM=$$FMTDTTM^EHM13UTIL(APPTDTTM),ENCTRSTS=$S(ENCNTR'="":$$ENCTRSTS^EHM13UTIL(ENCNTR),1:"") ;
 ... I ENCTRSTS="ACTION REQUIRED",$$MPTYNCTR^EHM13UTIL(ENCNTR) S ENCTRSTS="EMPTY" ;
 ... I ENCNTR'="",ENCTRSTS="" S ENCTRSTS="blank" ;  Encounter present but status is null.
 ... I ENCNTR="" S ENCTRSTS="none" ;  Encounter is not present.
 ... S APPTSTS=$$GET1^DIQ(2.98,APPTDTTM_","_DFN,3) I APPTSTS="" S APPTSTS="blank" ;  Appointment status is null.
 ... S UNIQUEID="" I ENCNTR'="" S UNIQUEID=$$GET1^DIQ(409.68,ENCNTR,.2) ;
 ... ;
 ... I SORTORDR=1 D  ;
 .... I $G(LISTFMT)'=2 W $$COMMAOUT^EHM13UTIL(7,FMTDTTM,VADM(1),$P($P(VADM(2),U,2),"-",3),$$GET1^DIQ(44,CLINIC,.01),APPTSTS,ENCTRSTS,UNIQUEID),! ;
 .... E  W $$COMMAOUT^EHM13UTIL(9,FMTDTTM,VADM(1),$P($P(VADM(2),U,2),"-",3),$$GET1^DIQ(44,CLINIC,.01),APPTSTS,ENCTRSTS,UNIQUEID,$$FMTE^XLFDT($P($P(PTAPPT,U,19),".",1),2),$$GET1^DIQ(200,$P(PTAPPT,U,18),.01)),! ;
 ... I SORTORDR=2 D  ;
 .... I $G(LISTFMT)'=2 W $$COMMAOUT^EHM13UTIL(7,$$GET1^DIQ(44,CLINIC,.01),FMTDTTM,VADM(1),$P($P(VADM(2),U,2),"-",3),APPTSTS,ENCTRSTS,UNIQUEID),! ;
 .... E  W $$COMMAOUT^EHM13UTIL(9,$$GET1^DIQ(44,CLINIC,.01),FMTDTTM,VADM(1),$P($P(VADM(2),U,2),"-",3),APPTSTS,ENCTRSTS,UNIQUEID,$$FMTE^XLFDT($P($P(PTAPPT,U,19),".",1),2),$$GET1^DIQ(200,$P(PTAPPT,U,18),.01)),! ;
 ... I SORTORDR=3 D  ;
 .... I $G(LISTFMT)'=2 W $$COMMAOUT^EHM13UTIL(7,VADM(1),$P($P(VADM(2),U,2),"-",3),FMTDTTM,$$GET1^DIQ(44,CLINIC,.01),APPTSTS,ENCTRSTS,UNIQUEID),! ;
 .... E  W $$COMMAOUT^EHM13UTIL(9,VADM(1),$P($P(VADM(2),U,2),"-",3),FMTDTTM,$$GET1^DIQ(44,CLINIC,.01),APPTSTS,ENCTRSTS,UNIQUEID,$$FMTE^XLFDT($P($P(PTAPPT,U,19),".",1),2),$$GET1^DIQ(200,$P(PTAPPT,U,18),.01)),! ;
 ;
 Q  ;
 ;

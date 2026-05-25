EHMAPPT0 ;ALB/WTC - EHRM APPOINTMENT MAINTENANCE; Jun 05, 2025@14:50:14
 ;;1.0;ELECTRONIC HEALTH MODERNIZATION;**13**;Apr 19, 2021;Build 27
 ;
 ;
 Q  ;
 ;
POSTSLCT(RPTYPE,CONVDATE,SORTORDR,CLINFLTR,CLINICS,FILTER,NONCOUNT) ;
 ;
 ;  Select parameters for list or summary.
 ; 
 ;  RPTYPE   = Report type (LIST, SUMMARY or OTHER) [REQUIRED]
 ;  CONVDATE = Date of conversion [RETURNED]
 ;  SORTORDR = Sort order (1,2,3) [RETURNED]
 ;  CLINFLTR = Clinic filter (A or S^clinic IEN)
 ;  CLINICS  = Clinics to include/exclude [RETURNED]
 ;  FILTER   = Encounter filter (ALL, WITH or WITHOUT) [RETURNED]
 ;  NONCOUNT = Include/exclude non-count clinics [RETURNED]
 ;
 I $G(RPTYPE)="" Q  ;
 ;
 S (CONVDATE,CLINFLTR,FILTER)="" ;
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
POSTLIVE(RPTYPE,CONVDATE,SORTORDR,CLINFLTR,CLINICS,FILTER,NONCOUNT,QUEUED,INCLCANC,ACTREQ) ;
 ; 
 ;  QUEUED   = 1 if report queued, 0 otherwise 
 ;  INCLCANC = 1 if cancelled appointments included, 0 otherwise
 ;  ACTREQ   = 1 if only ACTION REQUIRED encounters included, 0 otherwise
 ;
 ;  See POSTSLCT for remaining parameter definitions
 ;
 ;  Post go-live appointment list.  Select appointments after conversion date that were made after the conversion date.
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
 N IEN,CTR,APPTDTTM,IEN2,X,DFN,DATENTRD,PTAPPT,ENCNTR,SDECIEN,SDECAPPT ;
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
 .. I '$G(INCLCANC) Q:$P(X,U,9)="C"  ;  Skip if cancelled.
 .. S DFN=$P(X,U,1) Q:'DFN  ;  Skip if bad data.
 .. S DATENTRD=$P(X,U,7) Q:DATENTRD<CONVDATE  ;  Skip if entered before conversion date
 .. ;
 .. ;  Find record in Patient file and in SDEC Appointment file (if present)
 .. ;
 .. S PTAPPT=$G(^DPT(DFN,"S",APPTDTTM,0)),PTAPPTC=$G(^DPT(DFN,"S",APPTDTTM,"C")),ENCNTR=$P(PTAPPT,U,20) ;
 .. I PTAPPT'="" Q:$P(PTAPPT,U,2)="CNV"  Q:$P(PTAPPT,U,2)="C"  Q:$P(PTAPPT,U,2)="PC"  Q:$P(PTAPPT,U,2)="N"  Q:$P(PTAPPT,U,2)="NA"  Q:$P(PTAPPT,U,9)="C"  Q:$P(PTAPPTC,U,6)'=""  ;  Skip if converted, no-show, cancelled or checked out.
 .. S SDECIEN=0 F  S SDECIEN=$O(^SDEC(409.84,"B",APPTDTTM,SDECIEN)) Q:'SDECIEN  S SDECAPPT=$G(^SDEC(409.84,SDECIEN,0)) I $P(SDECAPPT,U,5)=DFN,$P(SDECAPPT,U,12)="" Q  ;
 .. I 'SDECIEN S SDECAPPT="" ;
 .. I SDECAPPT'="" Q:$P(SDECAPPT,U,17)="CNV"  Q:$P(SDECAPPT,U,12)'=""  Q:$P(SDECAPPT,U,23)'=""  Q:$P(SDECAPPT,U,14)'=""  ;  Skip if converted, cancelled, no-show or checked out
 .. ;
 .. ;  Filter report
 .. ;
 .. I RPTYPE="LIST",FILTER=2,ENCNTR="" Q  ;
 .. I RPTYPE="LIST",FILTER=3,ENCNTR'="" Q  ;
 .. I RPTYPE="LIST",FILTER=4,ENCNTR'="",$$ENCTRSTS^EHM13UTIL(ENCNTR)="ACTION REQUIRED",'$$MPTYNCTR^EHM13UTIL(ENCNTR) Q  ; Appointers without ACTION REQUIRED encounters
 .. ;
 .. ;  ACTION REQUIRED Encounters only
 .. ;
 .. I $G(ACTREQ) Q:ENCNTR=""  Q:$$ENCTRSTS^EHM13UTIL(ENCNTR)'="ACTION REQUIRED"  Q:$$MPTYNCTR^EHM13UTIL(ENCNTR)  ;
 .. ;
 .. ;  Build ^TMP($J) in sort order
 .. ;
 .. S CTR=CTR+1 I CTR#100=0,'QUEUED D PROGRESS^EHM13UTIL(CTR) ;
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
POSTLIST ;
 ;
 ;  List appointments entered after conversion.
 ;
 N RPTYPE,CONVDATE,SORTORDR,DFN,APPTDTTM,CLINIC,X1,X2,X3,LASTFI,SORT1,SORT2,SORT3,OUTPTFMT,Y,POP,%ZIS,DIRUT,QUEUED,OUTPTFMT,TITLE,CLINICS,NONCOUNT ;
 ;
 S RPTYPE="LIST" D POSTSLCT(RPTYPE,.CONVDATE,.SORTORDR,.CLINFLTR,.CLINICS,.FILTER,.NONCOUNT) Q:$D(DIRUT)  Q:CONVDATE=""  Q:SORTORDR=""  Q:CLINFLTR=""  Q:FILTER=""  Q:NONCOUNT=""  ;
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
 . S ZTRTN="POSTLST1^EHMAPPT0",ZTDESC="Post Go-Live Appointment List" ;
 . S ZTSAVE("*")="" ;
 . D ^%ZTLOAD W $S($D(ZTSK):"...Task queued",1:"...Task cancelled"),! ;
 ;
POSTLST1 ;  TaskMan start point
 ;
 ;  Build list of converted appointments.
 ;
 U IO D POSTLIVE(RPTYPE,CONVDATE,SORTORDR,CLINFLTR,.CLINICS,FILTER,NONCOUNT,QUEUED,0,0) ;  Build list of appointments.
 ;
 ;  List appointments
 ;
 S TITLE="Post Go-Live Appointment List ("_$P("All Appointments^Appointments With Encounters^Appointments Without Encounters^Appointments Without ACTION REQUIRED Encounters",U,FILTER)_")" ;
 I OUTPTFMT="F" D APPTLSTF^EHMAPPT(TITLE,CONVDATE,SORTORDR,2,QUEUED) ;  Formatted report
 I OUTPTFMT="C" D APPTLSTC^EHMAPPT(TITLE,SORTORDR,2) ;  Comma-delimited file
 ;
 D ^%ZISC ;
 K ^TMP($J) ;
 Q  ;
 ;
SUMMARY ;
 ;
 ;  Output summary of appointments entered post go-live.
 ;
 N CONVDATE,SORTORDR,APPTDTTM,CLINNAME,SORT1,SORT2,SORT3,YYYYMM,POP,%ZIS,DIRUT,TITLE ;
 ;
 S RPTYPE="SUMMARY" D POSTSLCT(RPTYPE,.CONVDATE,1,.CLINFLTR,.CLINICS,,.NONCOUNT) Q:CONVDATE=""  Q:CLINFLTR=""  Q:NONCOUNT=""  ;
 ;
 S %ZIS="Q" D ^%ZIS I POP K ^TMP($J) Q  ;
 ;
 ;  If report is queued, add to Taskman
 ;
 S QUEUED=0 I $D(IO("Q")) S QUEUED=1 D  Q  ;
 . N ZTDESC,ZTRTN,ZTSAVE,ZTSK ;
 . S ZTRTN="SUMMARY1^EHMAPPT0",ZTDESC="Appointment Summary" ;
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
 U IO D POSTLIVE(RPTYPE,CONVDATE,1,CLINFLTR,.CLINICS,,NONCOUNT,QUEUED,,) ;  Build list of converted appointments.
 S TITLE(1)="POST-CONVERSION APPOINTMENT SUMMARY" ;
 ;
 ;  Output summary report.
 ;
 D SUMOUT^EHMAPPT2(.TITLE,CONVDATE,QUEUED) ;
 Q  ;
 ;
ALLSLCT(RPTYPE,SORTORDR,CLINFLTR,CLINICS,FILTER,NONCOUNT) ;
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
 ;  See ALLSLCT for remaining parameter definitions
 ;
 I $G(RPTYPE)="" Q  ;
 ;
 S (CLINFLTR,FILTER)="" ;
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
 Q  ;
 ;
ALLAPPTS(RPTYPE,SORTORDR,CLINFLTR,CLINICS,FILTER,NONCOUNT,QUEUED,INCLALL,ACTREQ) ;
 ;
 ;  INCLALL  = 1 if all appointments regardless of status included, 0 otherwise
 ;  ACTREQ   = 1 if only ACTION REQUIRED encounters included, 0 otherwise
 ;
 ;  All appointments list.
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
 N IEN,CTR,APPTDTTM,IEN2,X,DFN,PTAPPT,ENCNTR,SDECIEN,SDECAPPT,PTAPPTC ;
 ;
 K ^TMP($J) ;
 I 'QUEUED U 0 W !,"Scanning ",$P(^DIC(44,0),U,1)," file.",! ;
 ;
 ;S IEN=$S($P(CLINFLTR,U,1)="A":0,1:$P(CLINFLTR,U,2)-.000001),CTR=0 ;
 S IEN=0,CTR=0 ;
 ;F  S IEN=$O(^SC(IEN)) Q:'IEN  Q:$P(CLINFLTR,U,1)="S"&(IEN>$P(CLINFLTR,U,2))  I $$GET1^DIQ(44,IEN,2)="CLINIC" S APPTDTTM=0 F  S APPTDTTM=$O(^SC(IEN,"S",APPTDTTM)) Q:'APPTDTTM  D  ;
 ;. S IEN2=0 F  S IEN2=$O(^SC(IEN,"S",APPTDTTM,1,IEN2)) Q:'IEN2  S X=$G(^(IEN2,0)) I X'="" D  ;
 F  S IEN=$O(^SC(IEN)) Q:'IEN  I $$GET1^DIQ(44,IEN,2)="CLINIC",'$D(^EHRM(1610,"B",IEN)) D  ;
 . ;
 . I NONCOUNT="E",$$GET1^DIQ(44,IEN,2502)="YES" Q  ;  Exclude non-count clinic
 . I CLINFLTR="X",$D(CLINICS(IEN)) Q:CLINICS(IEN)="EXCLUDE"  ;
 . I CLINFLTR="S" Q:'$D(CLINICS(IEN))  ;
 . ;
 . S APPTDTTM=0 F  S APPTDTTM=$O(^SC(IEN,"S",APPTDTTM)) Q:'APPTDTTM  S IEN2=0 F  S IEN2=$O(^SC(IEN,"S",APPTDTTM,1,IEN2)) Q:'IEN2  S X=$G(^(IEN2,0)) I X'="" D  ;
 .. ;
 .. I '$G(INCLALL) Q:$P(X,U,9)="C"  ;  Skip if cancelled.
 .. I '$G(INCLALL) Q:$$GET1^DIQ(44.003,IEN2_","_APPTDTTM_","_IEN_",",309)'=""  Q:$$GET1^DIQ(44.003,IEN2_","_APPTDTTM_","_IEN_",",303)'=""  ;  Skip if checked in or out
 .. S DFN=$P(X,U,1) Q:'DFN  ;  Skip if bad data.
 .. ;
 .. ;  Find record in Patient file and in SDEC Appointment file (if present)
 .. ;
 .. S PTAPPT=$G(^DPT(DFN,"S",APPTDTTM,0)),PTAPPTC=$G(^DPT(DFN,"S",APPTDTTM,"C")),ENCNTR=$P(PTAPPT,U,20) ; ;
 .. ;  Skip if converted, no-show, cancelled, checked out or inpatient.
 .. I '$G(INCLALL),PTAPPT'="" Q:$P(PTAPPT,U,2)="CNV"  Q:$P(PTAPPT,U,2)="C"  Q:$P(PTAPPT,U,2)="PC"  Q:$P(PTAPPT,U,2)="N"  Q:$P(PTAPPT,U,2)="NA"  Q:$P(PTAPPT,U,9)="C"  Q:$P(PTAPPTC,U,6)'=""  Q:$P(PTAPPT,U,2)="I"  ;  
 .. S SDECIEN=0 F  S SDECIEN=$O(^SDEC(409.84,"B",APPTDTTM,SDECIEN)) Q:'SDECIEN  S SDECAPPT=$G(^SDEC(409.84,SDECIEN,0)) I $P(SDECAPPT,U,5)=DFN,$P(SDECAPPT,U,12)="" Q  ;
 .. I 'SDECIEN S SDECAPPT="" ;
 .. ;  Skip if converted, no-show, cancelled, checked out or inpatient.
 .. I '$G(INCLALL),SDECAPPT'="" Q:$P(SDECAPPT,U,17)="CNV"  Q:$P(SDECAPPT,U,12)'=""  Q:$P(SDECAPPT,U,23)'=""  Q:$P(SDECAPPT,U,14)'=""  Q:$P(SDECAPPT,U,17)="I"  ;
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
APPTLIST ;
 ;
 ;  List all appointments.
 ;
 N RPTYPE,SORTORDR,DFN,APPTDTTM,CLINIC,X1,X2,X3,LASTFI,SORT1,SORT2,SORT3,OUTPTFMT,Y,POP,%ZIS,DIRUT,QUEUED,OUTPTFMT,TITLE,CLINICS,NONCOUNT ;
 ;
 S RPTYPE="LIST" D ALLSLCT(RPTYPE,.SORTORDR,.CLINFLTR,.CLINICS,.FILTER,.NONCOUNT) Q:SORTORDR=""  Q:CLINFLTR=""  Q:FILTER=""  Q:NONCOUNT=""  ;
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
 . S ZTRTN="APPTLST1^EHMAPPT0",ZTDESC="Appointment List" ;
 . S ZTSAVE("*")="" ;
 . D ^%ZTLOAD W $S($D(ZTSK):"...Task queued",1:"...Task cancelled"),! ;
 ;
APPTLST1 ;  TaskMan start point
 ;
 ;  Build list of converted appointments.
 ;
 U IO D ALLAPPTS(RPTYPE,SORTORDR,CLINFLTR,.CLINICS,FILTER,NONCOUNT,QUEUED) ;  Build list of converted appointments.
 ;
 ;  List appointments
 ;
 S TITLE="All Appointments List" ;
 ;
 I OUTPTFMT="F" D APPTLSTF^EHMAPPT(TITLE,"",SORTORDR,1,QUEUED) ;  Formatted report
 I OUTPTFMT="C" D APPTLSTC^EHMAPPT(TITLE,SORTORDR,1) ;  Comma-delimited file
 ;
 D ^%ZISC ;
 K ^TMP($J) ;
 Q  ;
 ;
APPTSMRY ;
 ;
 ;  Output summary of converted appointments.
 ;
 N RPTYPE,POP,%ZIS,DIRUT,CLINFLTR,QUEUED ;
 ;
 S RPTYPE="SUMMARY" D ALLSLCT(RPTYPE,1,.CLINFLTR,.CLINICS,,.NONCOUNT) Q:CLINFLTR=""  Q:NONCOUNT=""  ;
 ;
 S %ZIS="Q" D ^%ZIS I POP K ^TMP($J) Q  ;
 ;
 ;  If report is queued, add to Taskman
 ;
 S QUEUED=0 I $D(IO("Q")) S QUEUED=1 D  Q  ;
 . N ZTDESC,ZTRTN,ZTSAVE,ZTSK ;
 . S ZTRTN="APTSMRY1^EHMAPPT0",ZTDESC="Appointment Summary" ;
 . S ZTSAVE("*")="" ;
 . D ^%ZTLOAD W $S($D(ZTSK):"...Task queued",1:"...Task cancelled"),! ;
 ;
APTSMRY1 ;  TaskMan entry point
 ;
 ;  Output summary report.
 ;
 N TITLE ;
 ;
 ;  Build list of appointments.
 ;
 U IO D ALLAPPTS(RPTYPE,1,CLINFLTR,.CLINICS,,NONCOUNT,QUEUED) ;  Build list of appointments.
 ;
 ;  Output summary report.
 ;
 S TITLE(1)="ALL APPOINTMENT SUMMARY" ;
 I $P(CLINFLTR,U,1)="S" S TITLE(2)=$$GET1^DIQ(44,$P(CLINFLTR,U,2),.01) ;
 D SUMOUT^EHMAPPT2(.TITLE,,QUEUED) ;
 ;
 D ^%ZISC ;
 K ^TMP($J) ;
 Q  ;
 ;

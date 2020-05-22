SDECSTSQ ; ALB/WTC - VISTA SCHEDULING GUI; 21 Aug 2019  7:10 AM ; 13 Nov 2019  9:28 AM
 ;;5.3;Scheduling;**737**;;Build 13
 ;;Per VHA Directive 2004-038, this routine should not be modified
 Q
 ;
 ;  Report appointment-encounter-appointment status triples from the patient file (#2), the encounter file (#409.68) and the appointment file (#409.84).
 ;
 ;  ICR
 ;  ---
 ;  7030 - #2 patient appointment data
 ;
FIND ;
 ;
 ;  Entry point for report only.
 ;
 W !!,"Generate report showing status of patient appointment, encounter or appointment file entries for a single status triple.",! ;
 ;
 N REPORT,POP,IO,%ZIS ;
 S REPORT="YES" ;
 S %ZIS="Q" D ^%ZIS Q:POP  ;  Added code to output to printer.  wtc 9/17/2019
 ;
FIND0 ;
 ;
 ;  Find patient appointment-encounter-appointment file combinations that match selected criteria
 ;
 N %DT,Y,START,X,DIC,PTSTATUS,ENCSTATUS,APPTSTATUS,NAME,DFN,DTTM,PTDATA,ENCOUNTER,ENCDATA,APPTIEN,APPTDATA,FIRST,COUNT,FIELDS,FIELD,I ;
 ;
 ;  START      = Beginning date of appointments in list
 ;  PTSTATUS   = Status of appointment in patient file
 ;  ENCSTATUS  = Status of encounter
 ;  APPTSTATUS = Status of appointment in appointment file
 ;  NAME       = Patient's name
 ;  DFN        = Patient pointer (#2)
 ;  DTTM       = Appointment date/time (FM format)
 ;  PTDATA     = Data record from patient's appointment (ICR #7030)
 ;  ENCOUNTER  = Encounter pointer (#409.68)
 ;  ENCDATA    = Data record from encounter
 ;  APPTIEN    = Appointment pointer (#409.84)
 ;  APPTDATA   = Data record from appointment
 ;  FIRST      = Flag indicating that the appointment in the appointment file is the first to match the appointment in the patient file
 ;  COUNT      = Total number of appointment-encounter-appointment triples found
 ;  FIELDS     = Set of codes fields from patient appointment multiple or appointment file used to display help text
 ;  FIELD      = Individual set of codes value used to display help text
 ;
 U 0 W !,"Select starting date to check",! ;
 S %DT="AX" D ^%DT Q:Y<0  S START=$P(Y,".",1) W ! ;
 ;
 ;  The user selects the appointment-encounter-appointment triple by identifying the status of the patient appointment (#2), the encounter (#409.68)
 ;  and the appointment file entry (#409.84).  The allowable status values come from the status data fields in each of the files plus NULL for all
 ;  3 files and NONE for the encounter and appointment files.
 ;
FIND1 ;
 R !,"Select patient appointment status: ",X:$S($G(DTIME):DTIME,1:300) Q:'$T  Q:X=""  Q:X="^"  ;
 ;
 I X="?" W !!,"Enter a code from the list below or enter NULL",! D  G FIND1 ;
 . S FIELDS=$P(^DD(2.98,3,0),U,3) ;
 . F I=1:1 S FIELD=$P(FIELDS,";",I) Q:FIELD=""  W $P(FIELD,":",1)," - ",$P(FIELD,":",2),! ;
 ;
 I X="NULL" S PTSTATUS=X ;
 E  I $$SETCODES^SDECSTSR(2.98,3,X)="" W "  ???" G FIND1 ;
 I X'="NULL" W " - ",$$SETCODES^SDECSTSR(2.98,3,X) S PTSTATUS=X ;
FIND2 ;
 R !,"Select encounter status: ",X:$S($G(DTIME):DTIME,1:300) Q:'$T  Q:X=""  Q:X="^"  ;
 I X="?" W !!,"Enter a status from the list below or enter NULL or NONE",! D  G FIND2 ;
 . S X="" F  S X=$O(^SD(409.63,"B",X)) Q:X=""  W X,! ;
 ;
 I X="NULL"!(X="NONE") S ENCSTATUS=X G FIND3 ;
 S DIC=409.63,DIC(0)="EQM" D ^DIC Q:Y<0  S ENCSTATUS=+Y ;
FIND3 ;
 R !,"Select appointment file status: ",X:$S($G(DTIME):DTIME,1:300) Q:'$T  Q:X=""   Q:X="^"  ;
 I X="?" W !!,"Enter a code from the list below or enter NONE or NULL",! D  G FIND3 ;
 . S FIELDS=$P(^DD(409.84,.17,0),U,3) ;
 . F I=1:1 S FIELD=$P(FIELDS,";",I) Q:FIELD=""  W $P(FIELD,":",1)," - ",$P(FIELD,":",2),! ;
 ;
 I X="NULL"!(X="NONE") S APPTSTATUS=X ;
 E  I $$SETCODES^SDECSTSR(409.84,.17,X)="" W "  ???" G FIND3 ;
 I X'="NULL",X'="NONE" W " - ",$$SETCODES^SDECSTSR(409.84,.17,X) S APPTSTATUS=X ;
 ;
 ;  If report is queued, add to Taskman
 ;
 I REPORT="YES",$D(IO("Q")) D  Q  ;
 . S ZTRTN="FIND4^SDECSTSQ",ZTDESC="Appointment-Encounter-Appointment Status Report" ;
 . S ZTSAVE("*")="" ;
 . D ^%ZTLOAD W $S($D(ZTSK):"...Task queued",1:"...Task cancelled"),! K ZTDESC,ZTRTN,ZTSAVE,ZTSK ;
 ;
FIND4 ;  Entry point for queued report printing
 ;
 ;  Scan patient file in name order.  Only process patient file entries that have appointments after the selected start date.
 ;
 U:REPORT="YES" IO W ! S NAME="",COUNT=0 ;
 F  S NAME=$O(^DPT("B",NAME)) Q:NAME=""  S DFN=0 F  S DFN=$O(^DPT("B",NAME,DFN)) Q:'DFN  I $O(^DPT(DFN,"S",START))>0 D  ;  
 . ;
 . ;  Get status from patient file.
 . ;
 . S DTTM=START F  S DTTM=$O(^DPT(DFN,"S",DTTM)) Q:'DTTM  S PTDATA=^(DTTM,0) D  ;  ICR #7030
 .. ;
 .. ;  Skip appointments that do not match the selected status.
 .. ;
 .. I PTSTATUS="NULL" Q:$P(PTDATA,U,2)'=""  ;
 .. E  I $P(PTDATA,U,2)'=PTSTATUS Q  ;
 .. ;
 .. ;  Get status of encounter from file.
 .. ;
 .. S ENCOUNTER=$P(PTDATA,U,20),ENCDATA=$S(ENCOUNTER:$G(^SCE(ENCOUNTER,0)),1:"") ;
 .. ;
 .. ;  Skip encounters that do not match the selected status.
 .. ;
 .. I ENCSTATUS="NULL" Q:$P(ENCDATA,U,12)'=""  ;
 .. I ENCSTATUS="NONE" Q:ENCOUNTER  ;
 .. I ENCSTATUS'="NULL",ENCSTATUS'="NONE" Q:$P(ENCDATA,U,12)'=ENCSTATUS  ;
 .. ;
 .. ;  Scan appointment file for the patient and appointment date/time.  Get status from appointment file
 .. ;
 .. S APPTIEN=0,FIRST=1 F  S APPTIEN=$O(^SDEC(409.84,"APTDT",DFN,DTTM,APPTIEN)) Q:'APPTIEN  S APPTDATA=$G(^SDEC(409.84,APPTIEN,0)) D  ;
 ... ;
 ... ;  Skip encounters that do not match the selected status.
 ... ;
 ... I APPTSTATUS="NULL" Q:$P(APPTDATA,U,17)'=""  ;
 ... I APPTSTATUS'="NULL" Q:$P(APPTDATA,U,17)'=APPTSTATUS  ;
 ... ;
 ... ;  Show patient and encounter data if this is the first matching appointment from the appointment file.
 ... ;
 ... I FIRST D LINE,SHOWPAT^SDECSTSR(DFN,DTTM),SHOWENC^SDECSTSR(ENCOUNTER) S FIRST=0 ;
 ... ;
 ... ;  Show appointment data.
 ... ;
 ... D SHOWAPPT^SDECSTSR(APPTIEN) S COUNT=COUNT+1 ;
 .. ;
 .. ;  If no matching appointment was found in the appointment file and NONE was selected for appointments, display patient and encounter data.
 .. ;
 .. I FIRST,APPTSTATUS="NONE" D  Q  ;
 ... D LINE,SHOWPAT^SDECSTSR(DFN,DTTM),SHOWENC^SDECSTSR(ENCOUNTER),SHOWAPPT^SDECSTSR("") S COUNT=COUNT+1 ;
  ;
 I REPORT="YES" D ^%ZISC K ZTDESC,ZTRTN,ZTSAVE,ZTSK ;
 ;
 Q  ;
 ;
LINE ;
 ;
 W "-------------------------------------------------------------------------------",! ;
 Q  ;
 ;

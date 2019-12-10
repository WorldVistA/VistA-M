SDECDATA ;ALB/WTC - VISTA SCHEDULING GUI ; 01 May 2019  10:52 AM
 ;;5.3;Scheduling;**723,731**;;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified
 Q
 ;
 ;  ICR
 ;  ---
 ;  7030 - #2 Appointment data
 ;  10035 - #2 Patient demographics
 ;
REPORT ;
 ;
 ;  Run report only
 ;
 N AUTO,REPORT,POP,IO,%ZIS ;
 S REPORT="YES",AUTO="NO" ;
 S %ZIS="Q" D ^%ZIS Q:POP  ;  Added code to output to printer.  wtc 9/12/2019
 D APPT1 Q  ;
 ;
AUTO ;
 ;
 ;  Run correction code non-interactively.
 ;
 N AUTO,REPORT S REPORT="NO",AUTO="YES" D APPT1 Q  ;
 ;
APPT ;
 ;
 ;  Scan appointment file (#409.84) for entries without resources.  Identify correct resource using appointment list in patient file (#2).
 ;
 N AUTO,REPORT S REPORT="NO",AUTO="NO" ;
 ;
APPT1 ;
 ;
 N DA,APPTDATA,CNT,STARTTIME,DFN,CANCELLED,APPTMADE,MADEBY,PTDATA,FAILED,CLINICSFND,CLINIC,DA1,RESOURCE,MATCHED,RESPONSE,STOP,FIXED,LOCDATA,D2,%DT,PTR44,Y ;
 ;
 ;  DA        = Appointment (#409.84) pointer
 ;  APPTDATA  = Zero node of appointment file entry (#409.84)
 ;  CNT       = Number of appointments with missing resources found
 ;  STARTTIME = Appointment start time
 ;  DFN       = Patient (#2) pointer
 ;  CANCELLED = Appointment cancelled flag (from #409.84)
 ;  APPTMADE  = Date appointment was made (from #409.84)
 ;  MADEBY    = DUZ of person making appointment (from #409.84)
 ;  PTDATA    = Appointment data record from patient file (#2)
 ;  FAILED    = Total number of appointment records that could not be matched
 ;  CLINICFND = Array indexed by clinic name of appointment records matched with patient appointments
 ;  CLINIC    = Clinic name (.01 field of file #44)
 ;  DA1       = Appointment (#409.84) pointer
 ;  RESOURCE  = Resource (#409.831) pointer
 ;  MATCHED   = 1 if a second appointment for same patient at same time in the same clinic is found, 0 otherwise
 ;  RESPONSE  = User response
 ;  STOP      = 1 if user enters ^ to stop processing or time out occurs
 ;  FIXED     = Count of number of appointment records updated
 ;  LOCDATA   = Appointment data record from the location file (#44)
 ;  D2        = Subscript in appointment multiple in location file (#44)
 ;  PTR44     = Hospital location (pointer to #44)
 ;
 U 0 W !!,"Appointments without resources checker",! ;
 ;
 S CNT=0,FAILED=0,STOP=0,FIXED=0 ;
 ;
 ;  Scan is in date order starting with the user indicated date.
 ;
 U 0 W !,"Select starting date to check",! ;
 S %DT="AX" D ^%DT Q:Y<0  S STARTTIME=$P(Y,".",1) W ! ;
 ;
 ;  If report is queued, set up variables and call Task Manager then quit
 ;
 I REPORT="YES",$D(IO("Q")) D  Q  ;
 . S ZTRTN="APPT2^SDECDATA",ZTDESC="Appointments missing resources starting from "_$$FMTE^XLFDT(STARTTIME) ;
 . S ZTSAVE("*")="" ;
 . D ^%ZTLOAD W $S($D(ZTSK):"...Task queued",1:"...Task cancelled"),! ;
 ;
APPT2 ;  Entry point for queued report printing
 ;
 ;  Scan appointment file in date order.
 ;
 F  S STARTTIME=$O(^SDEC(409.84,"B",STARTTIME)) Q:'STARTTIME  Q:STOP  S DA=0  F  S DA=$O(^SDEC(409.84,"B",STARTTIME,DA)) Q:'DA  S APPTDATA=^SDEC(409.84,DA,0) I $P(APPTDATA,U,7)="" S CNT=CNT+1 D  Q:STOP  ;
 . ;
 . S DFN=$P(APPTDATA,U,5),CANCELLED=$S($P(APPTDATA,U,12)="":0,1:1),APPTMADE=$P(APPTDATA,U,9),MADEBY=$P(APPTDATA,U,8) ;
 . U:REPORT="YES" IO W !,CNT,". ",$$FMTE^XLFDT(STARTTIME)," (",DA,") ",$P(^DPT(DFN,0),U,1) ;  ICR 10035
 . ;
 . ;  Find appointment in patient file.
 . ;
 . I '$D(^DPT(DFN,"S",STARTTIME,0)) W "  *** No matching appointment in Patient file.",! S FAILED=FAILED+1 Q  ;
 . S PTDATA=^DPT(DFN,"S",STARTTIME,0),PTR44=$P(PTDATA,U,1),CLINIC=$P(^SC(PTR44,0),U,1) W "  ",CLINIC,! ;  ICR 7030
 . S CLINICSFND(CLINIC)=$G(CLINICSFND(CLINIC))+1 ;
 . ;
 . ;  Find appointment in location file.
 . ;
 . S D2=0,LOCDATA="" F  S D2=$O(^SC(PTR44,"S",STARTTIME,1,D2)) Q:'D2  I $P(^(D2,0),U,1)=DFN D  Q:LOCDATA'=""  ;
 .. S LOCDATA=^SC(PTR44,"S",STARTTIME,1,D2,0) ;
 .. I $P(LOCDATA,U,6)'=$P(PTDATA,U,18) S LOCDATA="" Q  ;  Appointment made by do not match.  Continue looking.
 .. I $P(LOCDATA,U,7)'=$P(PTDATA,U,19) S LOCDATA="" Q  ;  Date appointment made do not match.  Continue looking.
 .. I $P(PTDATA,U,2)="C"!($P(PTDATA,U,2)="PC"),$P(LOCDATA,U,9)="C" Q  ;  Both appointments are cancelled.  Matching appointment found.
 .. I $P(PTDATA,U,2)'="C",$P(PTDATA,U,2)'="PC",$P(LOCDATA,U,9)'="C" Q  ;  Both appointments are not cancelled.  Matching appointment found.
 .. S LOCDATA="" ;  Not a match.  Continue looking.
 . ;
 . W !,"Source",?15,"Status",?30,"Date Made",?45,"Made by",! ;
 . W "-----------",?15,"---------",?30,"------------",?45,"-----------------------------",! ;
 . W "Patient",?15,$S($P(PTDATA,U,2)="C"!($P(PTDATA,U,2)="PC"):"Cancelled",1:"Active"),?30,$$FMTE^XLFDT($P(PTDATA,U,19)),?45,$$GET1^DIQ(200,$P(PTDATA,U,18)_",",.01),! ;
 . I LOCDATA="" W "Location",?15,"NOT IN FILE",! ;
 . E  W "Location",?15,$S($P(LOCDATA,U,9)="C":"Cancelled",1:"Active"),?30,$$FMTE^XLFDT($P(LOCDATA,U,7)),?45,$$GET1^DIQ(200,$P(LOCDATA,U,6)_",",.01),! ;
 . W "Appointment",?15,$S(CANCELLED:"Cancelled",1:"Active"),?30,$$FMTE^XLFDT(APPTMADE),?45,$$GET1^DIQ(200,MADEBY_",",.01),! ;
 . ;
 . ;  Stop if patient appointment is active but no matching appointment in Location file.
 . ;
 . I $P(PTDATA,U,2)'="C",$P(PTDATA,U,2)'="PC",LOCDATA="" W !,"Active appointment in Patient file not in Location file." S FAILED=FAILED+1 Q  ;
 . ;
 . ;  Determine if another appointment file entry is for the same time
 . ;
 . S DA1=0,MATCHED=0 F  S DA1=$O(^SDEC(409.84,"CPAT",DFN,DA1)) Q:'DA1  I DA1'=DA D  Q:MATCHED  ;
 .. ;
 .. Q:$P(^SDEC(409.84,DA1,0),U,1)'=STARTTIME  W !,"*** Another appointment exists for the patient at the same time.",! S FAILED=FAILED+1,MATCHED=1 ;
 .. ;
 . Q:MATCHED  ;
 . ;
 . ;  If patient appointment and location appointment is cancelled but appointment file entry is NOT cancelled, fix the appointment file entry.  731 wtc 7/25/2019
 . ;
 . ;I $P(PTDATA,U,2)="C"!($P(PTDATA,U,2)="PC"),$P(LOCDATA,U,9)="C",'CANCELLED S FAILED=FAILED+1 Q  ;
 . ;
 . ;  Do not match appointments if not made by same person on same day.
 . ;  Do not match appointments if patient and location file do not agree or patient file is active but location file does not exist.
 . ;
 . I $P(PTDATA,U,2)'="C",$P(PTDATA,U,2)'="PC",LOCDATA=""!($P(LOCDATA,U,9)="C") S FAILED=FAILED+1 Q  ;
 . ;
 . ;  Do not fail matching due to appointment made by and date appointment made.  731 wtc 8/6/2019
 . ;
 . ;I $P(PTDATA,U,19)'=$P(APPTMADE,".",1) S FAILED=FAILED+1 Q  ;
 . ;I $P(PTDATA,U,18)'=MADEBY S FAILED=FAILED+1 Q  ;
 . ;
 . ;  OK to correct if patient file is active but appointment file is cancelled.
 . ;
 . ;I $P(PTDATA,U,2)'="C",$P(PTDATA,U,2)'="PC",CANCELLED S FAILED=FAILED+1 Q  ;
 . ;
 . ;  Stop if report only
 . ;
 . I REPORT="YES" Q  ;
 . ;
 . ;  Check resource file for entry matching the clinic name.  If one does not exist, notify user but do not process a change for the appointment.
 . ;
 . S RESOURCE=$O(^SDEC(409.831,"B",CLINIC,0)) ;
 . I 'RESOURCE W !,"No resource exists with the name '",CLINIC,"'.",!,"Create the required resource before updating this appointment.",! Q  ;
 . I $P($G(^SDEC(409.831,RESOURCE,0)),U,4)'=PTR44 W !,"Resource not associated with ",CLINIC,".  Correct this before updating this appointment.",! Q  ;
 . ;
 . ;  If automatics option selected, update the appointment.
 . ;
 . ;  Added 2 parameters to UPDAPPT call to allow matching if patient file appointment is cancelled but appointment file entry is not.  731 wtc 7/26/2019
 . ;
 . I AUTO="YES" D UPDAPPT(DA,RESOURCE,$P(PTDATA,U,2),CANCELLED) W "...updated",! S FIXED=FIXED+1 Q  ;
 . ;
 . ;  For manual processing, ask user if he/she wants to update Appointment file with resource of same name as clinic.
 . ;
 . W !,"Make '",CLINIC,"' the resource for this appointment?" R " NO// ",RESPONSE:$S($G(DTIME):DTIME,1:180) I '$T!(RESPONSE="^") S STOP=1 Q  ;
 . ;
 . ;  Added 2 parameters to UPDAPPT call to allow matching if patient file appointment is cancelled but appointment file entry is not.  731 wtc 7/26/2019
 . ;
 . I RESPONSE="YES"!(RESPONSE="Y")!(RESPONSE="yes")!(RESPONSE="y") D UPDAPPT(DA,RESOURCE,$P(PTDATA,U,2),CANCELLED) W "...updated",! S FIXED=FIXED+1 Q  ;
 . ;
 . W "... skipped",! Q  ;
 ;
 I 'CNT Q:REPORT="NO"  D ^%ZISC K ZTDESC,ZTRTN,ZTSAVE,ZTSK Q  ;  No bad entries found.  Do not output statistics.
 ;
 ;  Output statistics.  Show total found, number fixed and number that could not be fixed.
 ;
 W !,"TOTAL FOUND: ",CNT,!,"FIXES MADE: ",FIXED,!,"FAILED TO MATCH: ",FAILED,!,"MATCHING PERCENTAGE: ",$J(CNT-FAILED/CNT*100,4,1),"%",! ;
 W !,"MISSING CLINICS MATCHED TO: " ;
 S CLINIC="" F  S CLINIC=$O(CLINICSFND(CLINIC)) Q:CLINIC=""  W ?30,CLINIC,?62,$J(CLINICSFND(CLINIC),$L(CNT))," = ",$J(CLINICSFND(CLINIC)/CNT*100,4,1),"%",! ;
 ;
 I REPORT="YES" D ^%ZISC K ZTDESC,ZTRTN,ZTSAVE,ZTSK ;
 Q  ;
 ;
UPDAPPT(APPT,RESOURCE,PTCANFLG,APPTCAN) ;  Added last 2 parameters - 731 wtc 7/25/2019
 ;
 ;  APPT     = Appointment (pointer to #409.84) [REQUIRED]
 ;  RESOURCE = Resource (pointer to #409.831) [REQUIRED]
 ;  PTCANFLG = Patient appointment status (see field #1 in the appointment multiple in the patient file) [REQUIRED]
 ;  APPTCAN  = Appointment cancelled (1) or active (2). [REQUIRED]
 ;
 Q:$G(APPT)=""  Q:$G(RESOURCE)=""  Q:$G(APPTCAN)=""  ;
 ;  
 N DIE,DA,DR ;
 ;
 ;  Assign resource to appointment file entry
 ;
 S DIE=409.84,DA=APPT,DR=".07///"_RESOURCE ;
 ;
 ;  If patient appointment cancelled but appointment entry not cancelled, cancel the appointment entry.  731 wtc 7/26/2019
 ;
 I PTCANFLG="C"!(PTCANFLG="PC"),'APPTCAN D  ;
 . ;
 . ;  Get cancellation data from patient appointment and file in appointment file.  WTC 9/10/2019
 . ;
 . N DATA,DFN,DTTM ;
 . S DATA=^SDEC(409.84,APPT,0),DFN=$P(DATA,U,5),DTTM=$P(DATA,U,1) ;
 . S DATA=^DPT(DFN,"S",DTTM,0) ;
 . S DR=DR_";.12///"_$S($P(DATA,U,14):"^S X="_$P(DATA,U,14),1:"NOW")_";.121///^S X="_$S($P(DATA,U,12):$P(DATA,U,12),1:DUZ) ;
 . S DR=DR_";.122///^S X="_$S($P(DATA,U,15):$P(DATA,U,15),1:11)_";.17///^S X="_$C(34)_PTCANFLG_$C(34) ;
 ;
 ;  If patient appointment is active but appointment entry is cancelled, activate the appointment entry.  731 wtc 729/2019
 ;
 I PTCANFLG'="C",PTCANFLG'="PC",APPTCAN S DR=DR_";.12///@;.121///@;.122///@;.17///@" ;
 ;
 D ^DIE ;
 Q  ;
 ;
PTAPTINQ ;
 ;
 ;  Display appointments for a patient and date range
 ;
 N DIC,Y,DFN,START,END,%DT ;
 ;
 S DIC(0)="AEQM",DIC=2 D ^DIC Q:Y<0  S DFN=+Y ;
 ;
 K %DT(0) S %DT="AEP",%DT("A")="Start date: " D ^%DT Q:Y<0  S START=Y ;
 S %DT="AEP",%DT("A")="End date: ",%DT(0)=START D ^%DT Q:Y<0  S END=Y+1 ;
 ;
 W !,"Patient: ",$$GET1^DIQ(2,DFN_",",.01)," (",DFN,")",! ;
 W "Appt Date/Time",?20,"Location",?50,"Status",!! ;
 S STARTTIME=START F  S STARTTIME=$O(^DPT(DFN,"S",STARTTIME)) Q:'STARTTIME  Q:STARTTIME>END  S X=^(STARTTIME,0) D  ;  ICR 7030
 . ;
 . W $$FMTE^XLFDT(STARTTIME),?20,$$GET1^DIQ(44,$P(X,U,1)_",",.01),?50,$$SETOFCODES(2.98,3,$P(X,U,2)),! ;
 ;
 Q  ;
 ;
SETOFCODES(FILE,FIELD,VALUE) ;
 ;
 N DD,VALUES,RETURN,I ;
 ;
 S DD=^DD(FILE,FIELD,0),VALUES=$P(DD,U,3),RETURN="" ;
 F I=1:1 Q:$P(VALUES,";",I,99)=""  I $P($P(VALUES,";",I),":",1)=VALUE S RETURN=$P($P(VALUES,";",I),":",2) Q  ;
 Q RETURN ;
 ;
MISMATCH ;
 ;
 ;  Find encounters whose status does not match with the appointment status.
 ;
 N DFN,D1,ENCOUNTER,APPTDATA,ENCDATA,X,Y,START,NAME,COUNT ;
 ;
 K %DT S %DT="AEP",%DT("A")="Start date: " D ^%DT Q:Y<0  S START=Y W !! ;
 ;
 S NAME="" F  S NAME=$O(^DPT("B",NAME)) Q:NAME=""  S DFN=0 F  S DFN=$O(^DPT("B",NAME,DFN)) Q:'DFN  S D1=START-1 F  S D1=$O(^DPT(DFN,"S",D1)) Q:'D1  S APPTDATA=^(D1,0),ENCOUNTER=$P(APPTDATA,U,20) I ENCOUNTER'="" D  ;  ICR 7030
 . ;
 . ;  Compare status
 . ;
 . S X=$P(APPTDATA,U,2),Y=$$GET1^DIQ(409.68,ENCOUNTER_",",.12,"I") ;
 . I X="",Y=1!(Y=2) Q  ;  Checked in or checked out
 . I X="",Y=12 Q  ;  Non-count
 . I X="",Y=14 Q  ;  Action required
 . I X="N",Y=4 Q  ;  No show
 . I X="C",Y=5 Q  ;  Cancelled by clinic
 . I X="NA",Y=6 Q  ;  No show and auto-rebook
 . I X="CA",Y=7 Q  ;  Cancelled by clinic and auto re-book
 . I X="I",Y=8 Q  ;  Inpatient
 . I X="PC",Y=9 Q  ;  Cancelled by patient
 . I X="PCA",Y=10 Q  ;  Cancelled by patient and auto re-book
 . I X="NT",Y=3 Q  ;  No action taken
 . ;W $$GET1^DIQ(2,DFN_",",.01),?30,$$FMTE^XLFDT(D1),?50,"APPT: ",$$SETOFCODES(2.98,3,X),! ;
 . W NAME,?30,$$FMTE^XLFDT(D1),?50,"APPT: " W:X'="" $$SETOFCODES(2.98,3,X) W ! ;
 . W ?50," ENC: " W:Y'="" $$GET1^DIQ(409.63,Y_",",.01) W !! ;
 . I X="" S X="NULL" ;
 . I Y="" S Y="NULL" ;
 . S COUNT(X,Y)=$G(COUNT(X,Y))+1 ;
 ;
TOTALS ;
 W !!,"APPOINTMENT STATUS",?25,"ENCOUNTER STATUS",?50,"COUNT",! ;
 W "------------------",?25,"----------------",?50,"-----",! ;
 S X="" F  S X=$O(COUNT(X)) Q:X=""  W !,$S(X="NULL":X,1:$$SETOFCODES(2.98,3,X)) S Y=0 F  S Y=$O(COUNT(X,Y)) Q:'Y  W ?25,$$GET1^DIQ(409.63,Y_",",.01),?50,COUNT(X,Y),! ;
 Q  ;
 ;

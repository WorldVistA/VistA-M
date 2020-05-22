SDECSTSR ; ALB/WTC - VISTA SCHEDULING GUI; 21 Aug 2019  7:10 AM ; 13 Nov 2019  9:28 AM
 ;;5.3;Scheduling;**737**;;Build 13
 ;;Per VHA Directive 2004-038, this routine should not be modified
 Q
 ;
 ;  Report and fix appointment-encounter-appointment status triples from, respectively, the patient file (#2), the encounter file (#409.68) and
 ;  the appointment file (#409.84).
 ;
 ;  Distinguish encounter status from before and after installation of patch 722 - 9/11/2019
 ;
 ;  ICR
 ;  ---
 ;  7030 - #2 patient appointment data
 ;
DOWNLOAD    ;
 ;
 ;  Generate summary of appointment-encounter-appointment triples in comma-delimited format that can be uploaded to Excel.
 ;
 ;  NOTE:  This download is an analysis tool run by programmers.  It is not linked to an option.
 ;
 W !!,"Generate summary of patient appointment-encounter-appointment file status triples in comma delimited format",! ;
 ;
 N TYPE S TYPE="DOWNLOAD" G SUMMARY1 ;
 ;
SUMMARY ;
 ;
 ;  Generate summary of appointment-encounter-appointment triples in report format.
 ;
 ;  NOTE:  This report is an analysis tool run by programmers.  It is not linked to an option.
 ;
 W !!,"Generate summary of patient appointment-encounter-appointment file status triples in report format",! ;
 ;
 N TYPE S TYPE="REPORT" ;
 ;
SUMMARY1 ;
 ;
 N %DT,START,Y,NAME,DFN,DTTM,PTDATA,PTSTATUS,ENCOUNTER,ENCDATA,ENCSTATUS,APPTDATA,APPTSTATUS,FOUND,I ;
 N PATCH,ENCDATE,LASTDATE ;
 ;
 ;  Determine date that patch 722 was installed.
 ;
 S PATCH=$$PATCH(722) ;
 ;
 ;  Do not look at encounters that are less than a week old.
 ;
 S LASTDATE=$P($$FMADD^XLFDT($$NOW^XLFDT(),-7),".",1) ;
 ;
 ;  Scan is in date order starting with the user indicated date.
 ;
 W !,"Select appointment starting date",! ;
 S %DT="AX" D ^%DT Q:Y<0  S START=$P(Y,".",1) W ! ;
 ;
 K ^TMP($J) ;
 ;
 ;  Scan patient file in alphabetic order.  Process patients that have appointments after the selected start date.
 ;
 S NAME="" F I=1:1 S NAME=$O(^DPT("B",NAME)) Q:NAME=""  S DFN=0 F  S DFN=$O(^DPT("B",NAME,DFN)) Q:'DFN  W:I#1000=0 "." I $O(^DPT(DFN,"S",START))>0 D  ;  
 . ;
 . ;  Scan patient's appointments.
 . ;
 . S DTTM=START F  S DTTM=$O(^DPT(DFN,"S",DTTM)) Q:'DTTM  Q:DTTM>LASTDATE  S PTDATA=^(DTTM,0) D  ;  ICR #7030
 .. ;
 .. ;  Get status of appointment in patient file.
 .. ;
 .. S PTSTATUS=$S($P(PTDATA,U,2)'="":$$SETCODES(2.98,3,$P(PTDATA,U,2)),1:"null") ;  ICR #7030
 .. ;
 .. ;  Get encounter from patient's appointment record and the status of the encounter from file.
 .. ;
 .. S ENCOUNTER=$P(PTDATA,U,20),ENCSTATUS=$S(ENCOUNTER:$P($G(^SCE(ENCOUNTER,0)),U,12),1:""),ENCSTATUS=$S(ENCOUNTER="":"NONE",ENCSTATUS="":"null",1:$$GET1^DIQ(409.63,ENCSTATUS_",",.01)) ;
 .. ;
 .. ;  Flag encounter status as BEFORE or AFTER patch 722 installation.
 .. ;
 .. I ENCSTATUS'="NONE" S ENCDATE=$P($G(^SCE(ENCOUNTER,"USER")),U,4),ENCSTATUS=ENCSTATUS_"-"_$S(ENCDATE="":"NO DATE",ENCDATE<PATCH:"BEFORE",1:"AFTER") ;
 .. ;
 .. ;   Scan appointments in the appointment time for the date/time of the appointment in the patient file.
 .. ;
 .. S DA=0,FOUND=0 F  S DA=$O(^SDEC(409.84,"APTDT",DFN,DTTM,DA)) Q:'DA  S APPTDATA=$G(^SDEC(409.84,DA,0)) I APPTDATA'="" S FOUND=1 D  ;
 ... ;
 ... ;   Get status of appointments in appointment file.  Update count of triple.
 ... ;
 ... S APPTSTATUS=$S($P(APPTDATA,U,17)'="":$$SETCODES(409.84,.17,$P(APPTDATA,U,17)),1:"null") ;
 ... S ^(APPTSTATUS)=$G(^TMP($J,PTSTATUS,ENCSTATUS,APPTSTATUS))+1 ;
 .. ;
 .. ;  If no matching appointments (FOUND=0), update count for "status" of NONE.
 .. ;
 .. I 'FOUND S ^("NONE")=$G(^TMP($J,PTSTATUS,ENCSTATUS,"NONE"))+1 ;
 ;
 ;  If download selected, output results in comma-delimited format
 ;
 I TYPE="DOWNLOAD" D  ;
 . W !,$C(34),"PATIENT"_$C(34),",",$C(34),"ENCOUNTER",$C(34),",",$C(34),"APPOINTMENT",$C(34),",",$C(34)_"COUNT",$C(34),! ;
 . S PTSTATUS="" F  S PTSTATUS=$O(^TMP($J,PTSTATUS)) Q:PTSTATUS=""  D  ;
 .. S ENCSTATUS="" F  S ENCSTATUS=$O(^TMP($J,PTSTATUS,ENCSTATUS)) Q:ENCSTATUS=""  D  ;
 ... S APPTSTATUS="" F  S APPTSTATUS=$O(^TMP($J,PTSTATUS,ENCSTATUS,APPTSTATUS)) Q:APPTSTATUS=""  W $C(34),PTSTATUS,$C(34),",",$C(34),ENCSTATUS,$C(34),",",$C(34),APPTSTATUS,$C(34),",",^(APPTSTATUS),! ;
 . ;
 ;
 ;  If report selected, output formatted report.
 ;
 I TYPE="REPORT" D  ;
 . W !!,"PATIENT",?22,"ENCOUNTER",?44,"APPOINTMENT",?66+8-5,"COUNT",! ;
 . W "--------------------",?22,"--------------------",?44,"--------------------",?66,"--------",! ;
 . S PTSTATUS="" F  S PTSTATUS=$O(^TMP($J,PTSTATUS)) Q:PTSTATUS=""  W PTSTATUS D  ;
 .. S ENCSTATUS="" F  S ENCSTATUS=$O(^TMP($J,PTSTATUS,ENCSTATUS)) Q:ENCSTATUS=""  W ?22,ENCSTATUS D  W ! ;
 ... S APPTSTATUS="" F  S APPTSTATUS=$O(^TMP($J,PTSTATUS,ENCSTATUS,APPTSTATUS)) Q:APPTSTATUS=""  W ?44,APPTSTATUS,?66,$J(^(APPTSTATUS),8),! ;
 . ;
 K ^TMP($J) ;
 ;
 Q  ;
 ;
SETCODES(FILE,FIELD,VALUE) ;
 ;
 ;  Return text associated with a set of codes field in a file or sub-file.
 ;
 ;  FILE  = File number [REQUIRED]
 ;  FIELD = Field number [REQUIRED]
 ;  VALUE = Set of codes internal value [REQUIRED]
 ;
 N DD,VALUES,RETURN,I ;
 ;
 S DD=^DD(FILE,FIELD,0),VALUES=$P(DD,U,3),RETURN="" ;
 F I=1:1 Q:$P(VALUES,";",I,99)=""  I $P($P(VALUES,";",I),":",1)=VALUE S RETURN=$P($P(VALUES,";",I),":",2) Q  ;
 Q RETURN ;
 ;
PATCH(NUMBER) ;
 ;
 ;  Determine if patch has been installed.  Return installation date from Install file (#9.7).
 ;
 N X,DA ;
 S DA=$O(^XPD(9.7,"B","SD*5.3*"_NUMBER,99999),-1) I 'DA Q "" ;
 S X=$P($G(^XPD(9.7,DA,0)),U,9) I X'=3 Q "" ;
 Q $P($P($G(^XPD(9.7,DA,1)),U,3),".",1) ;
 ;
SHOWPAT(DFN,APPTDTTM) ;
 ;
 ;  Display patient data.
 ;
 ;  DFN       = Pointer to #2 [REQUIRED]
 ;  APPTDTTM  = Appointment date/time [REQUIRED]
 ;
 N DATA ;
 ;
 W !?80-27/2,"*** PATIENT APPOINTMENT ***" ;
 W !,"Patient: ",$$GET1^DIQ(2,DFN_",",.01),?40,"Appointment date/time: ",$$FMTE^XLFDT(APPTDTTM,2),! ;
 ;
 S DATA=$G(^DPT(DFN,"S",APPTDTTM,0)) ;  ICR #7030
 W "Clinic: ",$$GET1^DIQ(44,$P(DATA,U,1)_",",.01),?40,"Status: ",$S($P(DATA,U,2)'="":$$SETCODES(2.98,3,$P(DATA,U,2)),1:"null"),! ;
 W "Date appointment made: ",$$FMTE^XLFDT($P($P(DATA,U,19),".",1),2),?40,"By: ",$$GET1^DIQ(200,$P(DATA,U,18)_",",.01),! ;
 Q  ;
 ;
SHOWENC(ENCOUNTER) ;
 ;
 ;  Display encounter data.
 ;
 ;  ENCOUNTER = Pointer to #409.68 [REQUIRED]
 ;
 N DATA,USER,COUNT,DA ;
 ;
 ;  DATA     = Encounter file record
 ;  USER     = "USER" node from Encounter file
 ;  COUNT    = Number of child encounters
 ;
 W !?80-17/2,"*** ENCOUNTER ***" ;
 I 'ENCOUNTER W !,"Encounter date: NO ENCOUNTER",! Q  ;
 ;
 S DATA=$G(^SCE(ENCOUNTER,0)),USER=$G(^SCE(ENCOUNTER,"USER")) ;
 W !,"Encounter date: ",$$FMTE^XLFDT($P(DATA,U,1),2),! ;
 W "Clinic: ",$$GET1^DIQ(44,$P(DATA,U,4)_",",.01),?40,"Status: ",$S($P(DATA,U,12)'="":$$GET1^DIQ(409.63,$P(DATA,U,12)_",",.01),1:"null"),! ;
 W "Date created: ",$$FMTE^XLFDT($P($P(USER,U,4),".",1),2),?40,"By: ",$$GET1^DIQ(200,$P(USER,U,3)_",",.01),! ;
 ;
 ;  Show if encounter is a parent or child encounter.
 ;
 S COUNT=0,DA=0 F  S DA=$O(^SCE("APAR",ENCOUNTER,DA)) Q:'DA  S COUNT=COUNT+1 ;
 ;
 W $S($P(DATA,U,6)'="":"Child encounter",1:"NOT a Child encounter") ;
 W ?40,$S(COUNT:"Parent of "_COUNT_" encounters",1:"NOT a Parent encounter"),! ;
 ;
 ;  Show number of dependent entries.
 ;
 W "Number of dependent entries: ",$$DEPNDENT(ENCOUNTER),! ;
 ;
 Q  ;
 ;
DEPNDENT(ENCOUNTER) ;
 ;
 ;  Return number of dependent entries for an encounter
 ;
 N PXQRECI,X,Y,COUNT ;
 ;
 S PXQRECI=0,X=$$DEC^PXQFE(ENCOUNTER,1,""),Y=$O(^TMP("PXQRECORD",$J,PXQRECI,"")),COUNT=$P(Y,"COUNT= ",2) K ^TMP("PXQRECORD",$J) ;
 Q COUNT ;
 ;
SHOWAPPT(APPTIEN) ;
 ;
 ;  Display appointment data.
 ;
 ;  APPTIEN   = Appointment (pointer to #409.84) [REQUIRED]
 ;
 N DATA ;
 ;
 W !?80-19/2,"*** APPOINTMENT ***" ;
 I 'APPTIEN W !,"No appointment on file",! Q  ;
 ;
 S DATA=$G(^SDEC(409.84,APPTIEN,0)) ;
 W !,"Resource: ",$$GET1^DIQ(409.831,$P(DATA,U,7)_",",.01),?40,"Status: ",$S($P(DATA,U,17)'="":$$SETCODES(409.84,.17,$P(DATA,U,17)),1:"null"),! ;
 W "Date appointment made: ",$$FMTE^XLFDT($P(DATA,U,9),2),?40,"By: ",$$GET1^DIQ(200,$P(DATA,U,8)_",",.01),! ;
 Q  ;
 ;

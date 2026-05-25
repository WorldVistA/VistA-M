EHMAPPT1 ;ALB/WTC - EHRM APPOINTMENT MAINTENANCE; Jun 05, 2025@14:50:54
 ;;1.0;ELECTRONIC HEALTH MODERNIZATION;**13**;Apr 19, 2021;Build 27
 ;
 ;
 Q  ;
 ;
CNVTDCLN ;
 ;
 ;  Cleanup converted appointments.  Change status in #409.84 and in #2 to CNV (CONVERTED TO CERNER) then clean up downstream files.
 ;
 N X I '$$CRNRSITE^VAFCCRNR($P($$SITE^VASITE(),U,3)) W !!,"*** CAN BE RUN ON CONVERTED SITES ONLY ***",! R !,"Pre [RETURN] to continue",X:$G(DTIME,300) Q  ;
 ;
 N CONVDATE,SORT1,SORT2,SORT3,APPTDTTM,DFN,CLINIC,SDECAPPT,PTAPPT,SCAPPT,ENCNTR,RSLT,SDECIEN,IEN2,CLINFLTR,CLINICS,NONCOUNT ;
 ;
 W !!,"*** This option marks all selected appointments CONVERTED and cancels associated downstream file entries. ***",! ;
 I $$CONTINUE()'=1 Q  ;
 ;
 D CNVSELCT^EHMAPPT("CLEANUP",.CONVDATE,1,.CLINFLTR,.CLINICS,,.NONCOUNT) Q:CONVDATE=""  Q:CLINFLTR=""  Q:NONCOUNT=""  ; Build list of converted appointments.
 ;
 D CNVTDAPT^EHMAPPT("CLEANUP",CONVDATE,1,CLINFLTR,.CLINICS,,NONCOUNT,0,0,0) ;  Build list of converted appointments.
 ;
 ;  Scan sorted data in ^TMP($J)
 ;
 S SORT1="" F  S SORT1=$O(^TMP($J,SORT1)) Q:SORT1=""  D  ;
 . S SORT2="" F  S SORT2=$O(^TMP($J,SORT1,SORT2)) Q:SORT2=""  D  ;
 .. S SORT3="" F  S SORT3=$O(^TMP($J,SORT1,SORT2,SORT3)) Q:SORT3=""  D  ;
 ... S APPTDTTM=SORT1,DFN=$P(SORT2,U,2),CLINIC=$P(SORT3,U,2) ;
 ... ;
 ... S SDECAPPT=$G(^TMP($J,SORT1,SORT2,SORT3,409.84)),SDECIEN=$P(SDECAPPT,U,1),SDECAPPT=$P(SDECAPPT,U,2,999) ;
 ... S PTAPPT=$G(^TMP($J,SORT1,SORT2,SORT3,2)),ENCNTR=$P(PTAPPT,U,20) ;
 ... S SCAPPT=$G(^TMP($J,SORT1,SORT2,SORT3,44)) ;
 ... ;
 ... ;  Add appointment to #409.84 if missing.
 ... ;
 ... I 'SDECIEN D  Q:'SDECIEN  ;
 .... ;
 .... S IEN2=$P(SCAPPT,U,1) ;
 .... S SDECIEN=$$ADDAPPT^EHM13UTIL(CLINIC,APPTDTTM,DFN,IEN2) ;
 .... I 'SDECIEN W !,$$FMTDTTM^EHM13UTIL(APPTDTTM),?16,$P(SORT2,U,1),?48,$P(SORT3,U,1)," cannot be automatically converted.  Database entry - file #409.84 - not defined.",! ;
 ... ;
 ... ;  Do not mark appointment converted if it has an ACTION REQUIRED encounter that is not empty.
 ... ;
 ... I ENCNTR'="",$$ENCTRSTS^EHM13UTIL(ENCNTR)="ACTION REQUIRED",'$$MPTYNCTR^EHM13UTIL(ENCNTR) D  Q  ;
 .... W !,$$FMTDTTM^EHM13UTIL(APPTDTTM),?16,$P(SORT2,U,1),?48,$P(SORT3,U,1)," cannot be automatically converted.  Appointment has ACTION REQUIRED encounter.",! ;
 ... ;
 ... ;  Mark appointment converted.
 ... ;
 ... S RSLT=$$APPDEL^EHMSDEC8(SDECIEN,"CNV","CONVERTED TO CERNER") ;
 ... W $$FMTDTTM^EHM13UTIL(APPTDTTM),?16,$P(SORT2,U,1),"...",$S(RSLT:"OK",1:$P(RSLT,U,2)),! ;
 ;
 K ^TMP($J) ;
 Q  ;
 ;
SELCTAPPT(ADDFLAG) ;
 ;
 ;  Select appointment.
 ;
 ;  ADDFLAG = 1 if appointment added to #409.84 if not defined, 0 if not (default = 0)
 ;
 N SCIEN,DFN,APPTDATE,SDECIEN,DIC,X,Y,DIR,APPTDTTM,IEN2,COUNT,N,DIRUT,ENCNTR,ENCTRSTS ;
 ;
 K DIC S DIC(0)="AEQM",DIC("S")="I $P(^(0),U,3)=""C""",DIC=44 D ^DIC Q:Y<0 0 S SCIEN=+Y ;
 K DIC S DIC(0)="AEQM",DIC=2 D ^DIC Q:Y<0 0 S DFN=+Y ;
 K DIR S DIR(0)="D^::EX",DIR("A")="Appointment Date" D ^DIR Q:Y<0 0 Q:$D(DIRUT) 0 S APPTDATE=Y ;
 ;
 S APPTDTTM=APPTDATE,SDECIEN=0,COUNT=0 K ^TMP($J) W !!?5,"Appointment Date/Time",?30,"Encounter Status",!,?5,$$DASHES^EHM13UTIL(21),?30,$$DASHES^EHM13UTIL(30),! ;
 F  S APPTDTTM=$O(^SC(SCIEN,"S",APPTDTTM)) Q:'APPTDTTM  Q:APPTDTTM\1'=APPTDATE  D  ;
 . S IEN2=0 F  S IEN2=$O(^SC(SCIEN,"S",APPTDTTM,1,IEN2)) Q:'IEN2  S X=$G(^(IEN2,0)) I $P(X,U,1)=DFN,$P(X,U,9)="" D  ;
 .. S ENCNTR=$P($G(^DPT(DFN,"S",APPTDTTM,0)),U,20),ENCTRSTS="" ;
 .. I ENCNTR'="" S ENCTRSTS=$$ENCTRSTS^EHM13UTIL(ENCNTR) I ENCTRSTS="ACTION REQUIRED",$$MPTYNCTR^EHM13UTIL(ENCNTR) S ENCTRSTS="" ;
 .. I ENCTRSTS'="ACTION REQUIRED" S COUNT=COUNT+1,^TMP($J,COUNT)=SCIEN_U_DFN_U_APPTDTTM_U_ENCNTR_U_IEN2 W $J(COUNT,2),".",?5,$$FMTE^XLFDT(APPTDTTM),?30,ENCTRSTS,! ;
 .. E  W ?5,$$FMTE^XLFDT(APPTDTTM),?30,ENCTRSTS,! ;
 ;
 I 'COUNT W !,"No eligible appointments on file on ",$$FMTE^XLFDT(APPTDATE)," for ",$$GET1^DIQ(2,DFN,.01),!,"in the ",$$GET1^DIQ(44,SCIEN,.01)," clinic." K ^TMP($J) Q 0 ;
 ;
 K DIR S DIR(0)="N^1:"_COUNT,DIR("A")="Select Appointment" D ^DIR Q:$D(DIRUT) 0 S N=Y ;
 ;
 S DFN=$P(^TMP($J,N),U,2),APPTDTTM=$P(^(N),U,3),IEN2=$P(^(N),U,5) ;
 K ^TMP($J) ;
 ;
 S SDECIEN=0 F  S SDECIEN=$O(^SDEC(409.84,"B",APPTDTTM,SDECIEN)) Q:'SDECIEN  I $P(^SDEC(409.84,SDECIEN,0),U,5)=DFN,$P(^(0),U,12)="" Q  ;
 ;
 I 'ADDFLAG Q SDECIEN ;
 I 'SDECIEN S SDECIEN=$$ADDAPPT^EHM13UTIL(SCIEN,APPTDTTM,DFN,IEN2) I 'SDECIEN W !,"Add appointment for file #409.84 failed" ;  Add missing entry to file #409.84
 ;
 Q SDECIEN ;
 ;
MARKCNVTD ;
 ;
 ;  Select and mark an appointment converted.
 ;
 N X I '$$CRNRSITE^VAFCCRNR($P($$SITE^VASITE(),U,3)) W !!,"*** CAN BE RUN ON CONVERTED SITES ONLY ***",! R !,"Press [RETURN] to continue",X:$G(DTIME,300) Q  ;
 ;
 N SDECIEN,RSLT ;
 W @IOF,$$CENTER^EHM13UTIL("Mark appointment converted",IOM),! ;
 S SDECIEN=$$SELCTAPPT(1) Q:'SDECIEN  ;
 S RSLT=$$APPDEL^EHMSDEC8(SDECIEN,"CNV","CONVERTED TO CERNER") ;
 I RSLT W !,"MARKED CONVERTED",! Q  ;
 W "FAILED.  ERROR MESSAGE: ",$P(RSLT,U,2),! ;
 Q  ;
 ;
MARKCANC ;
 ;
 ;  Select and mark an appointment cancelled - duplicate.
 ;
 N X I '$$CRNRSITE^VAFCCRNR($P($$SITE^VASITE(),U,3)) W !!,"*** CAN BE RUN ON CONVERTED SITES ONLY ***",! R !,"Press [RETURN] to continue",X:$G(DTIME,300) Q  ;
 ;
 N SDECIEN,RSLT ;
 W @IOF,$$CENTER^EHM13UTIL("Mark appointment cancelled - duplicate",IOM),! ;
 S SDECIEN=$$SELCTAPPT(1) Q:'SDECIEN  ;
 S RSLT=$$APPDEL^EHMSDEC8(SDECIEN,"C","DUPLICATE - CERNER") ;  
 I RSLT W !,"MARKED CANCELLED",! Q  ;
 W "FAILED.  ERROR MESSAGE: ",$P(RSLT,U,2),! ;
 Q  ;
 ;
CANCAPPT ;
 ;
 ;  Cancel appointments entered post go-live.
 ;
 N X I '$$CRNRSITE^VAFCCRNR($P($$SITE^VASITE(),U,3)) W !!,"*** CAN BE RUN ON CONVERTED SITES ONLY ***",! R !,"Press [RETURN] to continue",X:$G(DTIME,300) Q  ;
 ;
 W !!,"*** This option CANCELS all of the selected appointments and associated downstream file entries. ***",! ;
 I $$CONTINUE()'=1 Q  ;
 ;
 N CONVDATE,DIRUT,SORT1,SORT2,SORT3,APPTDTTM,DFN,CLINIC,SDECAPPT,PTAPPT,SCAPPT,ENCNTR,RSLT,SDECIEN,CLINFLTR,CLINICS,NONCOUNT ;
 ;
 D POSTSLCT^EHMAPPT0("CLEANUP",.CONVDATE,1,.CLINFLTR,.CLINICS,,.NONCOUNT) Q:CONVDATE=""  Q:CLINFLTR=""  Q:NONCOUNT=""  ;
 D POSTLIVE^EHMAPPT0("CLEANUP",CONVDATE,1,CLINFLTR,.CLINICS,,NONCOUNT,0,0,0) ;  Build list of post-conversion appointments.
 ;
 ;  Scan sorted data in ^TMP($J)
 ;
 S SORT1="" F  S SORT1=$O(^TMP($J,SORT1)) Q:SORT1=""  D  ;
 . S SORT2="" F  S SORT2=$O(^TMP($J,SORT1,SORT2)) Q:SORT2=""  D  ;
 .. S SORT3="" F  S SORT3=$O(^TMP($J,SORT1,SORT2,SORT3)) Q:SORT3=""  D  ;
 ... S APPTDTTM=SORT1,DFN=$P(SORT2,U,2),CLINIC=$P(SORT3,U,2) ;
 ... ;
 ... I $D(^EHRM(1610,"B",CLINIC)) Q  ;  Skip appointment in clinic that is active post go-live.
 ... ;
 ... S SDECAPPT=$G(^TMP($J,SORT1,SORT2,SORT3,409.84)),SDECIEN=$P(SDECAPPT,U,1),SDECAPPT=$P(SDECAPPT,U,2,999) ;
 ... S PTAPPT=$G(^TMP($J,SORT1,SORT2,SORT3,2)),ENCNTR=$P(PTAPPT,U,20) ;
 ... S SCAPPT=$G(^TMP($J,SORT1,SORT2,SORT3,44)) ;
 ... ;
 ... ;  Add appointment to #409.84 if missing.
 ... ;
 ... I 'SDECIEN D  Q:'SDECIEN  ;
 .... ;
 .... S IEN2=$P(SCAPPT,U,1) ;
 .... S SDECIEN=$$ADDAPPT^EHM13UTIL(CLINIC,APPTDTTM,DFN,IEN2) ;
 .... I 'SDECIEN W !,$$FMTDTTM^EHM13UTIL(APPTDTTM),?16,$P(SORT2,U,1),?48,$P(SORT3,U,1)," cannot be automatically cancelled.  Database entry - file #409.84 - not defined.",! ;
 ... ;
 ... ;  Do not mark cancel appointment if it has an ACTION REQUIRED encounter that is not empty.
 ... ;
 ... I ENCNTR'="",$$ENCTRSTS^EHM13UTIL(ENCNTR)="ACTION REQUIRED",'$$MPTYNCTR^EHM13UTIL(ENCNTR) D  Q  ;
 .... W !,$$FMTDTTM^EHM13UTIL(APPTDTTM),?16,$P(SORT2,U,1),?48,$P(SORT3,U,1)," cannot be automatically cancelled.  Appointment has ACTION REQUIRED encounter.",! ;
 ... ;
 ... ;  Cancel appointment.
 ... ;
 ... S RSLT=$$APPDEL^EHMSDEC8(SDECIEN,"C","DUPLICATE - CERNER") ;  
 ... W $$FMTDTTM^EHM13UTIL(APPTDTTM),?16,$P(SORT2,U,1),"...",$S(RSLT:"OK",1:$P(RSLT,U,2)),! ;
 ;
 K ^TMP($J) ;
 Q  ;
 ;
INACTLIST ;
 ;
 ;  List clinics and their eligibility to be inactivated.
 ;
 N %DT,CONVDATE,Y,DIR,RPTFLTR,CLINIC,SCIEN,APPTCNT,SDDATE,IEN2,APPTDTTM,DIRUT,LINES,QUIT,POP,QUEUED,%ZIS,COUNT ;
 ;
 S DIR(0)="S^1:All Clinics;2:All except Inactive Clinics;3:Clinics Eligible for Inactivation;4:Clinics with Future Appointments;",DIR("A")="Report Filter",DIR("B")=1 D ^DIR Q:Y=""  Q:$D(DIRUT)  S RPTFLTR=Y ;
 ;
 S %ZIS="Q" D ^%ZIS I POP Q  ;
 ;
 ;  If report is queued, add to Taskman
 ;
 S QUEUED=0 ;
 I $D(IO("Q")) S QUEUED=1 D  Q  ;
 . N ZTDESC,ZTRTN,ZTSAVE,ZTSK ;
 . S ZTRTN="INACTLS1^EHMAPPT1",ZTDESC="Clinic Inactivation List" ;
 . S ZTSAVE("*")="" ;
 . D ^%ZTLOAD W $S($D(ZTSK):"...Task queued",1:"...Task cancelled"),! ;
 ;
INACTLS1 ;  TaskMan start point
 ;
 S TITLE=$P("All Clinics^All except Inactive Clinics^Clinics Eligible for Inactivation^Clinics with Future Appointments",U,RPTFLTR) ;
 U IO D INACTHDR("Clinic Inactivation List: "_TITLE) ;
 S LINES=0,QUIT=0 ;
 ;
 S CLINIC="",COUNT("ELIGIBLE")=0,COUNT("INACTIVE")=0,COUNT("ACTIVE POST")=0,COUNT("APPOINTMENTS")=0 ;
 F  S CLINIC=$O(^SC("B",CLINIC)) Q:CLINIC=""  D  Q:QUIT  ;
 . S SCIEN=0 F  S SCIEN=$O(^SC("B",CLINIC,SCIEN)) Q:'SCIEN  I $P($G(^SC(SCIEN,0)),U,3)="C" D  Q:QUIT  ;  Exclude locations that aren't clinics. wtc 5/1/24
 .. ;
 .. ;  If report displayed on screen, stop when screen full and prompt user to continue or stop.
 .. ;
 .. I 'QUEUED D  Q:QUIT  ;
 ... U 0 ;
 ... I IO=$I Q:LINES<(IOSL-7)  S QUIT=$$CONTINUE^EHM13UTIL()=0 Q:QUIT  U IO D INACTHDR("Clinic Inactivation List: "_TITLE) S LINES=1 Q  ;
 ... ;
 ... ;  New page header for printed report
 ... ;
 ... I LINES'<IOSL U IO D INACTHDR("Clinic Inactivation List: "_TITLE) S LINES=1 ;
 .. ;
 .. U IO ;
 .. I $D(^EHRM(1610,"B",SCIEN)) Q:RPTFLTR'=1&(RPTFLTR'=2)  W CLINIC,?32,"ACTIVE POST GO-LIVE",! S LINES=LINES+1,COUNT("ACTIVE POST")=COUNT("ACTIVE POST")+1 Q  ;
 .. I $D(^SC(SCIEN,"I")),+^("I")'=0,+^("I")'>DT,+$P(^("I"),"^",2)'>0 Q:RPTFLTR'=1  W CLINIC,?32,"INACTIVE",! S LINES=LINES+1,COUNT("INACTIVE")=COUNT("INACTIVE")+1 Q  ;
 .. ;
 .. S APPTCNT=$$APPTCNT(SCIEN) ;
 .. I APPTCNT>0 Q:RPTFLTR=3  W CLINIC,?32,"CANNOT BE INACTIVATED.  ",APPTCNT," APPOINTMENT",$S(APPTCNT>1:"S",1:"")," PRESENT.",! S LINES=LINES+1,COUNT("APPOINTMENTS")=COUNT("APPOINTMENTS")+1 Q  ;
 .. Q:RPTFLTR=4  W CLINIC,?32,"ELIGIBLE FOR INACTIVATION",! S LINES=LINES+1,COUNT("ELIGIBLE")=COUNT("ELIGIBLE")+1 ;
 ;
 W ! ;
 I RPTFLTR'=4 W "Clinics eligible for inactivation: ",COUNT("ELIGIBLE"),! ;
 I RPTFLTR'=3 W "Clinics with active appointments: ",COUNT("APPOINTMENTS"),! ;
 I RPTFLTR=1 W "Inactive clinics: ",COUNT("INACTIVE"),! ;
 I RPTFLTR=1!(RPTFLTR=2) W "Clinics active post go-live: ",COUNT("ACTIVE POST"),!
 ;
 U 0 I 'QUEUED,IO=$I R !,"Press [RETURN] to continue",X:$G(DTIME,300) ;
 ;
 D ^%ZISC ;
 Q  ;
 ;
APPTCNT(SCIEN) ;
 ;  
 ;  Returns number of active current and future appointments for a clinic.
 ;
 N APPTCNT,APPTDTTM,IEN2 ;
 ;
 S APPTCNT=0,APPTDTTM=DT-.0001 F  S APPTDTTM=$O(^SC(SCIEN,"S",APPTDTTM)) Q:'APPTDTTM  D  ;
 . S IEN2=0 F  S IEN2=$O(^SC(SCIEN,"S",APPTDTTM,1,IEN2)) Q:'IEN2  I $P(^(IEN2,0),"^",9)'="C",$$GET1^DIQ(44.003,IEN2_","_APPTDTTM_","_SCIEN,5)'="CONVERTED TO CERNER" S APPTCNT=APPTCNT+1 ;
 ;
 Q APPTCNT ;
 ;
INACTHDR(TITLE) ;
 ;
 W @IOF,$$CENTER^EHM13UTIL(TITLE,IOM),! ;
 W !,"CLINIC",?32,"STATUS",!,$$DASHES^EHM13UTIL(30),?32,$$DASHES^EHM13UTIL(45),! ;
 Q  ;
 ;
INACTVAT ;
 ;
 ;  Scan clinics and inactivate them.
 ;
 N X I '$$CRNRSITE^VAFCCRNR($P($$SITE^VASITE(),U,3)) W !!,"*** CAN BE RUN ON CONVERTED SITES ONLY ***",! R !,"Press [RETURN] to continue",X:$G(DTIME,300) Q  ;
 ;
 N %DT,Y,I,SCIEN,CONVDATE,RTNCODE,DIQUIET,COUNT,CLINNAME ;
 ;
 K ^TMP($J) S DIQUIET=1 ;
 ;
 ;  Enter date of conversion.
 ;
 K %DT S %DT="A",%DT("A")="DATE OF CONVERSION: " D ^%DT Q:Y<0  S CONVDATE=+Y ;
 ;
 W !!,"*** This option INACTIVATES all eligible clinics. ***",! ;
 I $$CONTINUE()'=1 Q  ;
 ;
 ;  Scan clinics
 ;
 S COUNT("INACTIVATED")=0,COUNT("FAILED")=0,COUNT("FAILED","Inactive")=0,COUNT("FAILED","Future appointments")=0 ;
 ;
 W !,"Inactivating clinics..." ;
 S SCIEN=0 F I=1:1 S SCIEN=$O(^SC(SCIEN)) Q:'SCIEN  W:I#100=0 "." I $$GET1^DIQ(44,SCIEN,2)="CLINIC" D  ;
 . ;
 . I $D(^EHRM(1610,"B",SCIEN)) Q  ;  Skip clinic that is open post go-live.
 . ;
 . I $D(^SC(SCIEN,"I")),+^("I")'=0,+^("I")'>DT,+$P(^("I"),"^",2)'>0 Q  ;  Skip already inactive clinic
 . ;
 . S RTNCODE=$$SDNACT(SCIEN,CONVDATE) ;
 . I RTNCODE S ^TMP($J,$$GET1^DIQ(44,SCIEN,.01),SCIEN)="INACTIVATED",COUNT("INACTIVATED")=COUNT("INACTIVATED")+1 Q  ;
 . S ^TMP($J,$$GET1^DIQ(44,SCIEN,.01),SCIEN)="INACTIVATION FAILED: "_$P(RTNCODE,U,2) ;
 . S COUNT("FAILED")=COUNT("FAILED")+1,COUNT("FAILED",$P(RTNCODE,U,2))=COUNT("FAILED",$P(RTNCODE,U,2))+1 Q  ;
 ;
 W !!,"CLINIC",?32,"STATUS",?46,"REASON",! ;
 W $$DASHES^EHM13UTIL(30),?32,$$DASHES^EHM13UTIL(11),?46,$$DASHES^EHM13UTIL(30),! ;
 S CLINNAME="" F  S CLINNAME=$O(^TMP($J,CLINNAME)) Q:CLINNAME=""  S SCIEN=0 F  S SCIEN=$O(^TMP($J,CLINNAME,SCIEN)) Q:'SCIEN  S X=^(SCIEN) D  ;
 . ;
 . I X["INACTIVATED" W CLINNAME,?32,"INACTIVATED",! Q  ;
 . W CLINNAME,?32,"FAILED",?46,$P(X,": ",2),! ;
 ;
 W ! ;
 W "CLINICS INACTIVATED: ",COUNT("INACTIVATED"),! ;
 W "INACTIVATION FAILED: ",COUNT("FAILED"),! ;
 W ?5,"Future appointments: ",COUNT("FAILED","Future appointments"),! ;
 ;
 K ^TMP($J) ;
 Q  ;
 ;
SDNACT(SC,SDDATE) ;ALB/TMP - INACTIVATE A CLINIC ;Mar 25, 2021@15:05:56
 ;
 ;  SC     = IEN of clinic in file #44
 ;  SDDATE = Conversion date
 ;
 ;  Returns 1 if inactivated or 0^error messaage if not.
 ;
 ;  Cloned from SDNACT.
 ;
 N ERRMSG,A,DA,CNT,D0,DH,DO,DOW,I,I1,J,J1,POP,SD,SD0,SDAY,SDEL,SDFSW,SDN,SDNL,SDOL,SDREACT,SI,SL,STARTDAY,SDX,SDX1,SDZQ,X,X1,X2,Y,Z,DIE,DR,DIC ;
 ;
 S ERRMSG="" ;
 ;
 S SDAY="Sun^Mon^Tues^Wednes^Thurs^Fri^Satur",SDZQ=1
 D DT^DICRW ;
 ;
 S SDX="",SDX1=9999999 ;
 ;
D ;
 ;S POP=0 F I=SDDATE-.0001:0 S I=$O(^SC(SC,"S",I)) Q:'I!(POP)!(SDDATE'<SDX1&(SDX1))  F I1=0:0 S I1=$O(^SC(SC,"S",I,1,I1)) Q:'I1  I $P(^(I1,0),"^",9)'="C",$$GET1^DIQ(44.003,I1_","_I_","_SC,5)="CONVERTED TO CERNER" S POP=1 Q
 S POP=$$APPTCNT(SC) ;
 I POP S ERRMSG="Future appointments" G END ;
 I SDX'="" D CHG1 G OVR
 K SDN S ^SC(SC,"I")="",X=SDDATE D DOW^SDM0 S SDN(Y)=SDDATE F I=1:1:6 S X2=1,X1=X D C^%DTC,DOW^SDM0 S SDN(Y)=X
 F I=0:1:6 S J=$O(^SC(SC,"T"_I,SDN(I))) D GOT
OVR F I=SDDATE-.0001:0 S I=$O(^SC(SC,"ST",I)) Q:'I!(I>SDX1)  K ^(I)
 F I=SDDATE-.0001:0 S I=$O(^SC(SC,"T",I)) Q:'I!(I>SDX1)  K ^(I)
 F I=SDDATE-.0001:0 S I=$O(^SC(SC,"OST",I)) Q:'I!(I>SDX1)  K ^(I)
 S DIE="^SC(",DA=SC,DR="2505///^S X=SDDATE;2506///" D ^DIE  ;  Set inactive date and clear reactive date.  wtc 10.10.23
 D SDEC^SDNACT(SC,SDDATE) ;alb/sat 627
 G END ;
 ;
CHECK ;
 ;
DEL ;
 ;
CHG1 ;;wtc ;K SDN S X1=SDDATE,X2=6 D C^%DTC S SDNL=X,X=SDDATE D DOW^SDM0 S SDN(Y)=X
 F I=1:1:6 S X1=X,X2=1 D C^%DTC,DOW^SDM0 S SDN(Y)=X
 S X1=SDX,X2=6 D C^%DTC S SDOL=X,X1=SDX,X2=-1 D C^%DTC
 F I=0:0 S X2=1,X1=X D C^%DTC Q:X>SDOL  D DOW^SDM0 S:$D(^SC(SC,"T"_Y))&($O(^SC(SC,"T"_Y,0))'=9999999) ^SC(SC,"T"_Y,SDN(Y),1)=$S($D(^SC(SC,"T"_Y,X,1)):^(1),1:""),^(0)=SDN(Y) D A1,A
 I SDDATE<SDX F I=0:1:6 F J=SDNL:0 S J=$O(^SC(SC,"T"_I,J)) Q:'J!(J'<SDX)  K ^SC(SC,"T"_I,J)
 Q
A1 S:'$D(^SC(SC,"T"_Y,9999999,1)) ^(1)="",^(0)=9999999 K:(SDN(Y)-X) ^SC(SC,"T"_Y,X)
 Q
A I $O(^SC(SC,"T"_Y,SDN(Y)))>0 S SD=$O(^SC(SC,"T"_Y,SDN(Y))) S:^SC(SC,"T"_Y,SD,1)]"" ^SC(SC,"T"_Y,SDN(Y),1)=^SC(SC,"T"_Y,SD,1),^(0)=SDN(Y),^SC(SC,"T"_Y,SD,1)=""
 I SDX'>SDDATE,$O(^SC(SC,"ST",SDX-.1))>0 F Z=SDX-.1:0 S Z=$O(^SC(SC,"ST",Z)) Q:'Z!(SDX1&(Z'<SDX1))  K ^SC(SC,"ST",Z)
 K SD,Z Q
GOT S SD=$O(^SC(SC,"T"_I,0))
 I J>0,SD'=9999999,^SC(SC,"T"_I,J,1)'="" S ^SC(SC,"T"_I,SDN(I),1)=^SC(SC,"T"_I,J,1),^(0)=SDN(I) K ^SC(SC,"T"_I,J) F J1=J:0 S J1=$O(^SC(SC,"T"_I,J1)) Q:'J1  K ^SC(SC,"T"_I,J1) ;don't remove if already canceled, SD*5.3*726
 S ^SC(SC,"T"_I,9999999,1)="",^(0)=9999999
 Q
END ;
 I $G(ERRMSG)="" Q 1 ;
 Q 0_U_ERRMSG ;
 ;
CONTINUE() ;
 ;
 ;  Prompt user to continue or quit.
 ;
 N DIR,Y,DIRUT ;
 S DIR(0)="Y",DIR("A")="Are you sure?",DIR("B")="NO" D ^DIR ; 
 I $D(DIRUT) Q 0 ;
 Q Y ;
 ;

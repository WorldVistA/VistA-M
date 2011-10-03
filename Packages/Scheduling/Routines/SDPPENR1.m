SDPPENR1 ;ALB/CAW - Patient Profile - Enrollments ; 5/13/92
 ;;5.3;Scheduling;**6,140**;Aug 13, 1993
 ;
 ;
EN1 ; Enrollments
 N SD,SD1,SDCL,SDEN,SDFLN,SDOPT,SDSTAT,SDSTART,SDSTOP
 S SD=0,SDFST=9,SDSEC=53,SDFLN=7,SDLEN=28,$P(SDASH,"-",IOM+1)="",SDSTART=$S($D(SDBEG):SDBEG,1:SDBD),SDSTOP=$S($D(SDEND):SDEND,1:SDED)
 F  S SD=$O(^DPT(DFN,"DE",SD)) Q:'SD  S SD1=0,SDCL=$G(^(SD,0)) F  S SD1=$O(^DPT(DFN,"DE",SD,1,SD1)) Q:'SD1  S SDEN=$G(^(SD1,0)) D CHECKS
 S SD=-9999999.99 F  S SD=$O(^TMP("SDENR",$J,SD)) Q:'SD  S SD1=0 F  S SD1=$O(^TMP("SDENR",$J,SD,SD1)) Q:'SD1  S SDCL=^(SD1,0),SDEN=^(1),SDDT=$E(SD,2,999) D INFO
 K ^TMP("SDENR",$J) Q
 ;
CHECKS ; Checks
 ; Check for specified clinic
 I $D(SDY),SDY'=+SDCL Q
 ; Add all active enrollments if printing regardless of date range
 I SDPRINT,$P(SDEN,U,3)="" D CHKSET
 ; Check for active enrollments
 I SDACT,$P(SDEN,U,3)'="" Q
 ; Check for date range
 I +SDEN>SDSTOP!(+SDEN<SDSTART) Q
 ; Otherwise file info
CHKSET S ^TMP("SDENR",$J,-$P(SDEN,U),SD1,0)=SDCL,^(1)=SDEN
 Q
INFO ;
 ;
CLINIC ; Enrollment Clinic and Enrollment Date
 S X="",X=$$SETSTR^VALM1("Clinic:",X,1,SDFLN)
 S X=$$SETSTR^VALM1($P($G(^SC(+SDCL,0)),U),X,SDFST,SDLEN)
 S X=$$SETSTR^VALM1("Enroll. Date:",X,39,13)
 S X=$$SETSTR^VALM1($TR($$FMTE^XLFDT(+SDEN,"5DF")," ","0"),X,SDSEC,SDLEN)
 D SET(X)
STATUS ; Current Status and Enrollement Discharge Date
 S X="",X=$$SETSTR^VALM1("Status:",X,1,SDFLN)
 S SDSTAT=$S($P(SDEN,U,3)="":"ACTIVE",1:"INACTIVE")
 S X=$$SETSTR^VALM1(SDSTAT,X,SDFST,SDLEN)
 I $P(SDEN,U,3)'="" D
 .S X=$$SETSTR^VALM1("Disch. Date:",X,40,12)
 .S X=$$SETSTR^VALM1($$FDATE^VALM1($P(SDEN,U,3)),X,SDSEC,SDLEN)
 D SET(X)
OPT ; OPT or AC and Review Date
 S X="",X=$$SETSTR^VALM1("OPT/AC:",X,1,SDFLN)
 S SDOPT=$S($P(SDEN,U,2)="O":"OPT",$P(SDEN,U,2)="A":"AC",1:"UNKNOWN")
 S X=$$SETSTR^VALM1(SDOPT,X,SDFST,SDLEN)
 I $P(SDEN,U,5)'="" D
 .S X=$$SETSTR^VALM1("Review Date:",X,40,12)
 .S X=$$SETSTR^VALM1($$FDATE^VALM1($P(SDEN,U,5)),X,SDSEC,SDLEN)
 D SET(X)
REASON ; Reason for Discharge
 I $P(SDEN,U,4)'="" D
 .S X="",X=$$SETSTR^VALM1("Reason:",X,1,SDFLN)
 .S X=$$SETSTR^VALM1($P(SDEN,U,4),X,SDFST,70)
 .D SET(X)
 D SET("")
 Q
SET(X) ; Set in ^TMP global for display
 ;
 S SDLN=SDLN+1,^TMP("SDPPALL",$J,SDLN,0)=X
 Q

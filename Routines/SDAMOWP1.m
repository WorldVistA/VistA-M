SDAMOWP1 ;ALB/CAW - Appointment Waiting Time Print Routine ; 12/1/91
 ;;5.3;Scheduling;**12,20**;Aug 13, 1993
 ;
HDR ; -- print header
 ;
 N Y
 D HDRD
 ;
 I $D(SDNO) D NO G HDR1
 I SDSORT=1!(SDSORT=2) W !,?70,"   Clinic: ",$E(LEVEL1,1,23)
 I SDSORT=3!(SDSORT=4) W !,?70,"Stop Code: ",$E(LEVEL1,1,23)
 ;
HDR1 W !,"Sorted By: ",$P($T(SORT1+SDSORT),";;",2)
 I SDSORT'=5,$D(^TMP("SDWTTOT",$J,+SDDIV,LEVEL1,"PRIM")) W ?70,"    Total: ",+^("PRIM")
 I SDSORT=5,$D(^TMP("SDWTTOTD",$J,+SDDIV,"DIV")) W ?70,"    Total: ",+^("DIV")
 ;
 W !,SDASH
 I SDSEL=1 W !,"Patient",?20,"ID",?26,$S("^3^4^5^"[(U_SDSORT_U):"Clinic",1:""),?46,"Check-In",?62,"Appointment",?78,"Elapsed",?92,"Check-Out",?109,"Elapsed",?120,"Total"
 I SDSEL=1 W !,?46,"Date/Time",?62,"Date/Time",?78,"Time",?92,"Date/Time",?109,"Time",?120,"Time",!,SDASH
HDRQ Q
 ;
HDRD ; Print header with dates
 ;
 W @IOF,"Appointment Waiting Time Report",?51,"Report Date: ",$P($$NOW^VALM1,":",1,2)
 S SDPAGE=SDPAGE+1 W ?108,"Page: ",SDPAGE
 W !,SDASH
 ;
 W !,"Dates    : ",$$FDATE^VALM1(SDBEG)," to ",$$FDATE^VALM1(SDEND)
 I $D(SDNO) D NODIV G HDRDQ
 S SDDIVNAM=$E($S($D(^DG(40.8,+SDDIV,0)):$P(^(0),U),1:""),1,SDLEN)
 I SDDIVNAM'="" W ?70," Division: ",SDDIVNAM
HDRDQ Q
 ;
HDRT(SORT) ; Print header for totals
 ;
 N SRT S SRT=$G(SORT)
 W !,$S("^1^2^"[(U_SRT_U):"Clinic","^3^4^"[(U_SRT_U):"Stop Code",1:"Division"),?40,"Appointments",?56,"Total CI Time",?71,"Total CO Time",?86,"Average Pre",?101,"Average Post",?116,"Average Total"
 W !,?86,"Waiting Time",?101,"Waiting Time",?116,"Waiting Time"
 W !,SDASH
 Q
TOT(WHAT,LEVEL1,DIV) ; Print totals
 ;
 N TOTAL,TOTAL1,TOTAL2,TOTAL3,TOTAL4
 I WHAT="PRIM" S TOTAL=$G(^TMP("SDWTTOT",$J,+DIV,LEVEL1,"PRIM"))
 I WHAT="DIV" S TOTAL=$G(^TMP("SDWTTOTD",$J,+DIV,"DIV"))
 I WHAT="GRAND" S TOTAL=$G(^TMP("SDWTTOTG",$J,"GRAND"))
 S TOTAL1=$P(TOTAL,U,1),TOTAL2=$P(TOTAL,U,2),TOTAL3=$P(TOTAL,U,3),TOTAL4=$P(TOTAL,U,4)
 W !,$G(LEVEL1)
 W ?40,TOTAL1
 W ?56,$$HRS^SDAMOWP(TOTAL2)
 W ?71,$$HRS^SDAMOWP(TOTAL3)
 W ?86,$$HRS^SDAMOWP($P((TOTAL2/TOTAL1),"."))
 W ?101,$$HRS^SDAMOWP($P((TOTAL3/TOTAL1),"."))
 W ?116,$$HRS^SDAMOWP($P((TOTAL4/TOTAL1),"."))
TOTQ Q
 ;
SORT1 ; -- hdr labels for sort
 ;;DIVISION, CLINIC, PATIENT
 ;;DIVISION, CLINIC, APPOINTMENT DATE/TIME
 ;;DIVISION, STOP CODE, CLINIC
 ;;DIVISION, STOP CODE, PATIENT
 ;;DIVISION, PATIENT, APPOINTMENT DATE/TIME
 ;;$$END
 Q
 ;
TOTP(SORT,DIV,LEVEL1) ; Print totals
 ;
 D HDRD,HDRT(SORT)
 F  S LEVEL1=$O(^TMP("SDWTTOT",$J,+DIV,LEVEL1)) Q:LEVEL1=""!(SDQUIT)  D
 .D CHECK(SORT) Q:SDQUIT
 .D TOT("PRIM",LEVEL1,DIV)
 Q:SDQUIT
 W !,SDASH1
 D TOT("DIV","TOTAL",DIV),LEGEND
 D PAUSE^SDAMOWP
 Q
 ;
CHECK(SORT) ; check to see if header should be printed
 I 'SDPAGE D HDRT(SORT) Q
 I $E(IOST,1,2)="C-",($Y+6)>IOSL D PAUSE^VALM1 I 'Y S SDQUIT=1 Q
 I ($Y+6)>IOSL W @IOF D HDRT(SORT)
 Q
 ;
LEGEND ; Print legend on bottom
 ;
 W !!,?5,"o  Check-In Date/Time - Time the patient first checks in at the clinic reception area."
 W !,?5,"o  Appointment Date/Time - Time of the veteran's scheduled appointment."
 W !,?5,"o  Elapsed Time(s) - 1.  The elapsed period of time from the patient checking in at the clinic to the appointment time. "
 W !,?5,"                         (Appointment time minus Check-In time)"
 W !,?5,"o                    2.  The elapsed period of time from the appointment time to the time the patient checks out."
 W !,?5,"                         (Check-Out time minus Appointment Time)"
 W !,?5,"o  Total Waiting Time - The elapsed period of time from the patient's check-in date/time to the time leaving the clinic"
 W !,?5,"                        after service is completed.  (Check-Out time minus Check-In time)"
LEGENDQ Q 
 ;
NODIV ; Print divisions when no appts found
 ;
 N DIV S DIV="" W !,?70,"Division(s): "
 I VAUTD=1 W "All" G NODIVQ
 F  S DIV=$O(VAUTD(DIV)) Q:DIV=""  W ?83,VAUTD(DIV),!
NODIVQ Q
 ;
NO ; Print stop code or clinic when no appts found
 ;
 N SDWHAT S SDWHAT="" W !,?72,$S(SDSORT=1!(SDSORT=2):"Clinic(s): ",SDSORT=3!(SDSORT=4):"Stop Code(s): ",1:"")
 I SDSORT=1!(SDSORT=2),VAUTC=1 W "All" G NOQ
 I SDSORT=1!(SDSORT=2) F  S SDWHAT=$O(VAUTC(SDWHAT)) Q:SDWHAT=""  W ?83,VAUTC(SDWHAT),!
 I SDSORT=3!(SDSORT=4),VAUTS=1 W "All" G NOQ
 I SDSORT=3!(SDSORT=4) F  S SDWHAT=$O(VAUTS(SDWHAT)) Q:SDWHAT=""  W ?87,VAUTS(SDWHAT),!
NOQ Q

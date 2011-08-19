SDAMOS1 ;ALB/SCK - AM MGT REPORTS STATISTICS OUTPUT ; 5/14/93
 ;;5.3;Scheduling;;Aug 13, 1993
 ;
BLD ;  build report from data stored in TMP global
 N I,SDFIN,STATUS
 S (TC,TA,TI,SDCO,SDAR,SDIP,SDTOT,SDFIN,TCOCNT,TARCNT,TIPCNT)=0,PAGE=1
 S SDLST="",SDLST=$O(^TMP("SDAMS",$J,SDLST)),SDFIN=$$HDR(SDLST)
 S SDNXT="" F  S SDNXT=$O(^TMP("SDAMS",$J,SDNXT)) Q:SDNXT=""  D  G:SDFIN BLDQ
 . I SDNXT'=SDLST S SDFIN=$$HDR(SDNXT) Q:SDFIN  S SDLST=SDNXT,(TC,TI,TA)=0
 . S NXTSC="" F  S NXTSC=$O(^TMP("SDAMS",$J,SDNXT,NXTSC)) Q:NXTSC=""  D  Q:SDFIN
 .. S STATUS=0 F  S STATUS=$O(^TMP("SDAMS",$J,SDNXT,NXTSC,STATUS)) Q:'STATUS  D  Q:SDFIN
 ... S SDFIN=$$STCNT(STATUS,+^(STATUS)) ; ref to tmp(sdams,$j,div,stocode,status)
 .. S SDFIN=$$SUBTOT(NXTSC)
 . D TOTALS
 D TDIV
BLDQ K SDCO,SDAR,SDIP,SDTOT,TCOCNT,TARCNT,TIPCNT,SDLST,LSTSC,SDNXT,NXTSC,ACTION,QFLAG,TC,TI,TA,TOT,PAGE,SDFIN,%
 Q
 ;
STCNT(STAT,COUNT) ; increment action count for stopcode
 ;   sdar = action req by stop code
 ;   sdco = checked out by stop code
 ;   sdip = in-pat by stop code
 ;
 N Y S Y=0
 S:STAT=14 SDAR=SDAR+COUNT
 S:STAT=2 SDCO=SDCO+COUNT
 S:STAT=8 SDIP=SDIP+COUNT
 Q (Y)
 ;
SUBTOT(SDCODE) ;  totals by stopcode
 ;         tcocnt = checked out total by division (per page)
 ;         tarcnt = action req tot by div/page
 ;         tipcnt = In-pat tot by div/page
 ;
 N Y,SDFIN
 S Y=0
 I $Y+5>IOSL D  G:SDFIN SUBTOTQ
 . D TOTALS
 . S SDFIN=$$HDR(SDNXT) Q:SDFIN
 I SDSEL=5 W !,SDCODE,?34,SDCO,?53,SDAR,?64,SDIP,?77,SDCO+SDAR+SDIP
 S TCOCNT=TCOCNT+SDCO,TARCNT=TARCNT+SDAR,TIPCNT=TIPCNT+SDIP
 S (SDCO,SDAR,SDIP)=0
SUBTOTQ Q (Y)
 ;
TOTALS ;  total of actions by stopcode for division
 ;      tc = check out total for division
 ;      ta = action required tot for div.
 ;      ti = in-pat tot for div.
 ;
 N SDIV
 I SDSEL=5 W !,SDTDASH,!,"TOTAL",?34,TCOCNT,?53,TARCNT,?64,TIPCNT,?77,TCOCNT+TARCNT+TIPCNT
 S TC=TC+TCOCNT,TA=TA+TARCNT,TI=TI+TIPCNT
 S TOT(SDNXT)=TC_U_TA_U_TI
 S (TCOCNT,TARCNT,TIPCNT)=0
 Q
 ;
HDR(SDIV) ;  page header
 N Y
 S Y=0
 G:SDSEL'=5 HDRQ
 D PAUSE
 W !!,"Statistics Report by Stop Code"
 W !,"Division: ",SDIV,?40,"Date Range ",$$FDATE^VALM1(SDBEG)_" to "_$$FDATE^VALM1(SDEND)
 D NOW^%DTC W ?95,"Run Date: ",$E($$FDTTM^VALM1(%),1,14),?125,"Page: ",PAGE S PAGE=PAGE+1
 W !,"  Stop Code",?25,"Checked-Out",?40,"Action Required",?58,"Inpatient",?75,"Total",!,SDASH
HDRQ Q (Y)
 ;
TDIV ;  final totals by division for med center
 ;  reuse tc for check out total by med ctr
 ;        ta for action req tot
 ;        ti for in-pat tot
 ;  tcd = check out totals by div
 ;  tad = action req totals by div
 ;  tip = in-pat totals by div
 ;
 N SDIV,TC,TA,TI,TCD,TAD,TID
 S (TC,TA,TI,TCD,TAD,TID)=0
 D PAUSE
 W !!,"Statistics Report Totals by Division"
 W !,"MEDICAL CENTER",?40,"Date Range ",$$FDATE^VALM1(SDBEG)_" to "_$$FDATE^VALM1(SDEND)
 D NOW^%DTC W ?95,"Run Date: ",$E($$FDTTM^VALM1(%),1,14),?125,"Page: ",PAGE S PAGE=PAGE+1
 W !,"  Division",?25,"Checked-Out",?40,"Action Required",?58,"Inpatient",?75,"Total"
 S SDIV="" F  S SDIV=$O(TOT(SDIV)) Q:SDIV=""  D
 . W !,SDASH
 . S TCD=$P(TOT(SDIV),U),TAD=$P(TOT(SDIV),U,2),TID=$P(TOT(SDIV),U,3)
 . W !,SDIV,?34,TCD,?54,TAD,?65,TID,?75,TCD+TAD+TID
 . S TC=TC+TCD,TA=TA+TAD,TI=TI+TID
 W !,SDTDASH
 W !,"TOTAL",?34,TC,?54,TA,?65,TI,?75,TC+TA+TI
 K TCD,TAD,TID
TDIVQ Q
 ;
PAUSE ;
 I $E(IOST,1,2)="C-" D
 . S DIR(0)="FO",DIR("A")="Press RETURN to continue or '^' to exit"
 . D ^DIR K DIR I $D(DUOUT)!($D(DTOUT)) Q
 . W @IOF
 E  W @IOF
PAUSEQ Q
 ;
NOREP ;    report if no data in TMP global
 W !!,"Statistics Report by Stop Code"
 W !,"Date Range ",$$FDATE^VALM1(SDBEG)_" to "_$$FDATE^VALM1(SDEND)
 D NOW^%DTC W ?95,"Run Date: ",$E($$FDTTM^VALM1(%),1,14),?125,"Page: 1"
 W !,SDASH
 W !!?10,"No data found matching sort parameters"
 Q

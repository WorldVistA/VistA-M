EASECEXP ;ALB/LBD - Report of Expiring or Expired LTC Copay Tests; 10-SEP-2003
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**40**;Mar 15, 2001
 ;
 ; This routine is called from menu option EASEC LTC COPAY TEST EXPIRE
 ; and will print a report of LTC Copay Tests that have expired or are
 ; about to expire.
 ;
EN ; Entry point
 N EASRPT,EASUDT,EASSRT
 ; Select which report to print (1=Pending Expiration; 2=Expired)
 S EASRPT=$$RPT Q:'EASRPT
 ; Select number of days (report 1) or start date (report 2)
 I EASRPT=1 S EASUDT=$$DATE1
 E  S EASUDT=$$DATE2
 Q:'EASUDT
 ; Sort by name or date
 S EASSRT=$$SRT Q:EASSRT=""
 ; Run the report
 D QUE
 D ^%ZISC,HOME^%ZIS
 Q
 ;
RPT() ; Select which report to print
 ; Input:   None
 ; Output:  Y - Report Type (1=Pending Expiration; 2=Expired; 0=Quit)
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 W !!,"Report of LTC Copayment Tests"
 S DIR(0)="S^1:Pending Expiration;2:Expired"
 S DIR("A")="Enter 1 or 2"
 S DIR("?",1)="Indicate whether the report should include:"
 S DIR("?",2)="(1) a list of veterans whose LTC Copayment Test is pending expiration (i.e.,"
 S DIR("?",3)="the anniversary date of the test is approaching) within a user-specified"
 S DIR("?",4)="number of days, or"
 S DIR("?",5)="(2) a list of veterans whose LTC Copayment Test has already expired (i.e.,"
 S DIR("?")="the anniversary date of the test has passed) since a user-specified date."
 D ^DIR I 'Y!($D(DTOUT))!($D(DUOUT)) Q 0
 Q Y
DATE1() ; Select number of days for report 1
 ; Input:   None
 ; Output:  Y - Number of days to report (1-60)
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="N^1:60",DIR("A")="Enter number of days to report"
 D ^DIR I 'Y!($D(DTOUT))!($D(DUOUT)) Q 0
 Q Y
DATE2() ; Select start date for report 2
 ; Input:   None
 ; Output:  Y - Report start date
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,SDT,EDT
 S SDT=$$FMADD^XLFDT(DT,-365),EDT=$$FMADD^XLFDT(DT,-1)
 S DIR(0)="D^"_SDT_":"_EDT_":EX",DIR("A")="Enter a start date"
 D ^DIR I 'Y!($D(DTOUT))!($D(DUOUT)) Q 0
 Q Y
SRT() ; Select sort
 ; Input:   None
 ; Output:  Y - Sort (N=Name; D=Date)
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="SB^N:Name;D:Date",DIR("A")="Sort report by Name or Date"
 S DIR("?",1)="Indicate whether the report should be sorted by the"
 S DIR("?")="Veteran's Name or the LTC Copay Test Anniversary Date"
 D ^DIR I $D(DTOUT)!($D(DUOUT)) Q ""
 Q Y
 ;
QUE ; Get the report device, queue if requested
 N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK,POP
 K IOP,%ZIS
 S %ZIS="Q" D ^%ZIS I POP W !!,"Report Cancelled!" Q
 I $D(IO("Q")) D  Q
 .S ZTRTN="START^EASECEXP"
 .S ZTDESC="PRINT"_$S(EASRPT=1:"EXPIRING",1:"EXPIRED")_"LTC COPAY TESTS"
 .S (ZTSAVE("EASRPT"),ZTSAVE("EASUDT"),ZTSAVE("EASSRT"))=""
 .D ^%ZTLOAD
 .W !,"Report ",$S($D(ZTSK):"Queued!",1:"Cancelled!")
 D START
 Q
 ;
START ; Generate report
 ; Input:  EASRPT - Report Type (1=Pending Expiration; 2=Expired)
 ;         EASUDT - Number of Days or Start Date
 ;         EASSRT - Sort (N=Name; D=Date)
 N PG,RPTDT,HDR1,HDR2,HDR3,HDRLN,CRT,LINE,OUT,MXLNE,TMP
 K ^TMP("EASECEXP",$J) S:$G(ZTSK) ZTREQ="@"
 D GETREC
 D PRTVAR
 U IO D HDR
 I '$D(^TMP("EASECEXP",$J)) W !!,?10,"*** No records to print ***" Q
 D PRINT I CRT S OUT=$$PAUSE
 K ^TMP("EASECEXP",$J)
 Q
GETREC ; Loop through Annual Means Test File #408.31 to find LTC Copay Tests
 ; within the date range
 N EASSDT,EASEDT,EDT,ST,DFN,EASIEN
 ; Get start and end dates
 I EASRPT=1 D
 .S EASSDT=$$FMADD^XLFDT(DT,-365)
 .S EASEDT=$$FMADD^XLFDT(EASSDT,EASUDT)
 E  D
 .S EASSDT=$$FMADD^XLFDT(EASUDT,-365)
 .S EASEDT=$$FMADD^XLFDT(DT,-365)
 ; Find records using "AS" x-ref
 S ST=""
 F  S ST=$O(^DGMT(408.31,"AS",3,ST)) Q:ST=""  S EDT=-EASEDT-1 F  S EDT=$O(^DGMT(408.31,"AS",3,ST,EDT)) Q:'EDT!(EDT>-EASSDT)  S DFN=0 F  S DFN=$O(^DGMT(408.31,"AS",3,ST,EDT,DFN)) Q:'DFN  D
 .S EASIEN=$O(^DGMT(408.31,"AS",3,ST,EDT,DFN,0)) Q:'EASIEN
 .Q:'$D(^DGMT(408.31,EASIEN,0))
 .;If record meets criteria, save in ^TMP global
 .I $$CHK(DFN,EASIEN) D SET(DFN,EASIEN,EASSRT)
 Q
 ;
SET(DFN,IEN,SRT) ;Store data to be printed in the ^TMP global
 ; Input:    DFN - Patient IEN
 ;           IEN - LTC Copay Test IEN
 Q:'$G(DFN)  Q:'$G(IEN)
 I $G(SRT)="" S SRT="D"
 N NAME,SSN,STAT,REAS,ANNDT
 S NAME=$$GET1^DIQ(2,DFN_",",.01),SSN=$$GET1^DIQ(2,DFN_",",.09)
 S ANNDT=$$FMADD^XLFDT(+$G(^DGMT(408.31,IEN,0)),365)
 S STAT=$$GET1^DIQ(408.31,IEN_",",.03) S:STAT="" STAT="INCOMPLETE"
 S REAS=$E($$GET1^DIQ(408.31,IEN_",",2.07),1,41)
 I SRT="D" S ^TMP("EASECEXP",$J,ANNDT,NAME,SSN)=STAT_U_REAS
 E  S ^TMP("EASECEXP",$J,NAME,ANNDT,SSN)=STAT_U_REAS
 Q
 ;
CHK(DFN,EASIEN) ;Check if LTC Copay Test meets criteria for the report
 ; Input:    DFN - Patient IEN
 ;           EASIEN - LTC Copay Test IEN
 ; Output:   1 = meets criteria for report
 ;           0 = doesn't meet criteria for report
 I '$G(DFN)!('$G(EASIEN)) Q 0
 N LTC,LTCDT,LTCST,CHKDT
 S CHKDT=+^DGMT(408.31,EASIEN,0)
 ; Don't report if veteran has had another LTC copay test within the year
 S LTC=$$LST^EASECU(DFN),LTCDT=$P(LTC,U,2),LTCST=$P(LTC,U,3)
 I LTCDT,LTCDT>CHKDT,$$FMDIFF^XLFDT(DT,LTCDT)<365,LTCST'="" Q 0
 ; Don't report if veteran is deceased
 I $P($G(^DPT(DFN,.35)),U) Q 0
 ; Don't report if veteran is exempt due to compensable SC disability or
 ; LTC before 11/30/99
 I "^1^4^"[(U_$P($G(^DGMT(408.31,EASIEN,2)),U,7)_U) Q 0
 Q 1
 ;
PRTVAR ; Set up variables needed to print report
 S CRT=$S($E(IOST,1,2)="C-":1,1:0)
 S TMP="^TMP(""EASECEXP"",$J)"
 S (PG,OUT)=0,RPTDT=$$FMTE^XLFDT(DT),MXLNE=$S(CRT:13,1:55)
 S HDR1=$$CJ^XLFSTR("VETERANS WITH LONG TERM CARE COPAYMENT TESTS THAT",80)
 I EASRPT=1 S HDR2=$$CJ^XLFSTR("ARE PENDING EXPIRATION IN "_EASUDT_" DAYS",80)
 E  S HDR2=$$CJ^XLFSTR("HAVE EXPIRED SINCE "_$$FMTE^XLFDT(EASUDT,2),80)
 S HDR3="SORTED BY "_$S(EASSRT="D":"DATE",1:"NAME")
 S HDRLN="",$P(HDRLN,"=",80)=""
 Q
HDR ; Print report header
 S PG=PG+1,LINE=0
 W @IOF
 W ?0,"REPORT DATE: ",RPTDT,?73,"PAGE: ",$$RJ^XLFSTR(PG,3)
 W !!,HDR1,!,HDR2,!,HDR3
 W !?50,"LTC Test",?66,"LTC Test"
 W !,"SSN",?14,"Veteran's Name",?46,"Anniversary Date",?67,"Status"
 W !,HDRLN
 Q
PRINT ; Print report data
 N EASI,EASJ,SSN,REC,NAME,ANNDT,STAT,REAS
 S EASI=""
 F  S EASI=$O(@TMP@(EASI)) Q:EASI=""!OUT  S EASJ="" F  S EASJ=$O(@TMP@(EASI,EASJ)) Q:EASJ=""  S SSN="" F  S SSN=$O(@TMP@(EASI,EASJ,SSN)) Q:SSN=""  D
 .S REC=@TMP@(EASI,EASJ,SSN)
 .S NAME=$S(EASSRT="D":EASJ,1:EASI),NAME=$E(NAME,1,30)
 .S ANNDT=$S(EASSRT="D":EASI,1:EASJ),ANNDT=$$FMTDT(ANNDT)
 .S STAT=$P(REC,U,1)
 .S REAS=$P(REC,U,2)
 .I LINE>MXLNE S OUT=$$PAUSE Q:OUT   D HDR
 .W !,$$SSN(SSN),?14,NAME,?50,ANNDT,?66,STAT
 .S LINE=LINE+1
 .I STAT="EXEMPT" W !,?30,"Reason: ",REAS S LINE=LINE+1
 Q
 ;
FMTDT(X) ;Format date to print on report
 Q $E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
SSN(X) ; Format SSN to print on report
 Q $E(X,1,3)_"-"_$E(X,4,5)_"-"_$E(X,6,9)
 ;
PAUSE() ; Prompt for next page or quit, if report is sent to screen
 N DIR,DIRUT,DUOUT,DTOUT,X,Y
 I 'CRT Q 0
 S DIR(0)="E"
 D ^DIR I 'Y Q 1
 Q 0

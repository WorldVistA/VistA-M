SCRPI01A ;ALB/SCK - IEMM REPORT OF INCOMPLETE ENCOUNTERS PRINT ; 6/24/97
 ;;5.3;Scheduling;**66**;AUG 13, 1993
 Q
PRINT ; Begin printing report
 ;   Variables
 ;     PAGE    - Page Number
 ;     SDIV    - Division Name
 ;     SDCLN   - Clinic Name
 ;     SDNAME  - Patient Name
 ;     SDT     - Encounter Date 
 ;     SCABORT - Abort report flag
 ;
 N DASH,DBLDASH,PAGE,SDIV,SDCLN,SDNAME,SDT,SCABORT,NONAME
 ;
 S $P(DASH,"-",IOM-1)="",$P(DBLDASH,"=",IOM-1)=""
 S PAGE=0,SDIV=""
 ;
 I '$D(^TMP("SCRPI ERR",$J)) D HDR1 Q
 ;
 F  S SDIV=$O(^TMP("SCRPI ERR",$J,SDIV)) Q:SDIV']""  D  Q:$G(SCABORT)
 . S SDCLN=""
 . F  S SDCLN=$O(^TMP("SCRPI ERR",$J,SDIV,SDCLN)) Q:SDCLN']""  D  Q:$G(SCABORT)
 .. D HDR(SDIV,SDCLN)
 .. Q:$G(SCABORT)
 .. S SDNAME=""
 .. F  S SDNAME=$O(^TMP("SCRPI ERR",$J,SDIV,SDCLN,SDNAME)) Q:SDNAME']""  D  Q:$G(SCABORT)
 ... S SDT="",NONAME=0
 ... F  S SDT=$O(^TMP("SCRPI ERR",$J,SDIV,SDCLN,SDNAME,SDT)) Q:'SDT  D  Q:$G(SCABORT)
 .... S SDER=""
 .... F  S SDER=$O(^TMP("SCRPI ERR",$J,SDIV,SDCLN,SDNAME,SDT,SDER)) Q:'SDER  D LINE(^TMP("SCRPI ERR",$J,SDIV,SDCLN,SDNAME,SDT,SDER,0)) Q:$G(SCABORT)
 ;
 D SELPAGE
 Q
 ;
LINE(SDTMP) ;  Print formatted line of the report.  Check if task has been stopped by user.
 ;  Set abort flag to quit if stopped.
 ;    Input
 ;       SDTMP  - formatted line to print
 ;
 ;    Output
 ;       SCABORT - 1 if user aborts report printing
 ;
 ;    Variables
 ;       SCERR  - Error Code form #409.76
 ;       SCERR1 - Error Description from #409.76
 ;
 N X,X1,X2,SCERR,SCERR1,DFN
 ;
 ; ** if task has been stopped, set abort flag and quit.
 I $$S^%ZTLOAD D  Q
 . S SCABORT=1
 . W !!,"Report stopped by user"
 ;
 I $Y>(IOSL-5) D HDR(SDIV,SDCLN)
 ;
 ; **  Check that error is still around and has not been corrected.
 Q:'$G(^SD(409.75,SDER,0))
 S SCERR=^SD(409.76,$P(^SD(409.75,SDER,0),U,2),0)
 S SCERR1=^SD(409.76,$P(^SD(409.75,SDER,0),U,2),1)
 ;
 S DFN=$P(SDTMP,U)
 D PID^VADPT6
 W !,$S('NONAME:$E(SDNAME,1,25),1:" "),?27,$S('NONAME:VA("BID"),1:" ")
 W ?33,$S($P(SDTMP,U,3)]"":$P(SDTMP,U,3),1:" ")," "
 W $$FMTE^XLFDT(SDT,"2FP"),?55,$S($P(SCERR,U,2)="V":"VISTA",$P(SCERR,U,2)="N":"NPCD ",1:"UNK  "),?62,$P(SCERR,U)
 ;
 ;  ** Parse out error description to fit report.  If description length >50, then 
 ;     call parse procedure to break description into two lines.
 S X=$P(SCERR1,U)
 I $L(X)<50 D
 . W ?68,X
 E  D
 . K X1,X2
 . D PARSE^SCRPIUT1(X,.X1,.X2,45,51)
 . W ?68,X1,!?68,X2
 S NONAME=1
 K VA
 Q
 ;
HDR(SDIV,SDCLN) ;  Print report header, if abort flag is set, then quit
 ;   Input
 ;      SDIV  - Division Name
 ;      SDCLN - Clinic Name
 ;
 ;   Variables
 ;      SDL  - Print line
 ;
 N SDL,X
 ;
 I 'PAGE,IOST?1"C-".E W @IOF
 I PAGE,IOST?1"C-".E D  Q:$G(SCABORT)
 . S DIR(0)="E" D ^DIR K DIR S SCABORT='+$G(Y)
 . W @IOF
 E  D
 . I PAGE W @IOF
 ;
 S PAGE=PAGE+1
 W !?2,"Date: ",$$FDATE^VALM1($$DT^XLFDT),?((IOM/2)-22),"Incomplete Encounter Management Error Listing",?(IOM-13),"Page: ",PAGE
 ;
 S X="Division: "_$S($G(SDIV)]"":SDIV,1:"  ---")
 D CTR^SCRPIUT1(.X,IOM)
 W !,X
 ;
 S X="Clinic: "_$S($G(SDCLN)]"":SDCLN,1:"  ---")
 D CTR^SCRPIUT1(.X,IOM)
 W !,X
 ;
 S X="Date Range: "_$$FMTE^XLFDT($P(SDDT,U))_" to "_$$FMTE^XLFDT($P(SDDT,U,2))
 D CTR^SCRPIUT1(.X,IOM)
 W !,X
 ;
 S X="Selection Method by "_$$SELMTHD^SCRPI01(SDSEL1)_" then by "_$$SELMTHD^SCRPI01(SDSEL2)
 D CTR^SCRPIUT1(.X,IOM)
 W !,X
 ;
 W !!!,?35,"Encounter",?54,"Error",?62,"Error"
 W !,"Patient Name",?27,"SSN",?35,"Date/Time",?54,"Srce",?62,"Code",?68,"Description"
 W !,DBLDASH
 S X="[ '*' Indicates Deleted Outpatient Encounter for Transmission ]"
 D CTR^SCRPIUT1(.X,IOM)
 W !,X,!
 Q
 ;
HDR1 ;  Report header for no data found.  Prints modified header.
 ;
 W !?2,"Date: ",$$FDATE^VALM1($$DT^XLFDT),?((IOM/2)-22),"Incomplete Encounter Management Error Listing"
 S X="Date Range: "_$$FMTE^XLFDT($P(SDDT,U))_" to "_$$FMTE^XLFDT($P(SDDT,U,2))
 D CTR^SCRPIUT1(.X,IOM)
 W !,X
 S X="Selection Method by "_$$SELMTHD^SCRPI01(SDSEL1)_" then by "_$$SELMTHD^SCRPI01(SDSEL2)
 D CTR^SCRPIUT1(.X,IOM)
 W !,X,!!
 W !?5,"No errors found"
 D NEXTLEV(SDSEL1)
 D NEXTLEV(SDSEL2)
 Q
 ;
SELPAGE ;  Print on last page the user parameters used for the report.
 N SDIV,SDCLN,SDERR,SDPAT,SDDSS
 ;
 I 'PAGE,IOST?1"C-".E W @IOF
 I PAGE,IOST?1"C-".E D  Q:$G(SCABORT)
 . S DIR(0)="E" D ^DIR K DIR S SCABORT='+$G(Y)
 . W @IOF
 E  D
 . I PAGE W @IOF
 ;
 S PAGE=PAGE+1
 W !?2,"Date: ",$$FDATE^VALM1($$DT^XLFDT),?((IOM/2)-22),"Incomplete Encounter Management Error Listing",?(IOM-13),"Page: ",PAGE
 S X="Report Selection Criteria"
 D CTR^SCRPIUT1(X,IOM)
 S X="Date Range: "_$$FMTE^XLFDT($P(SDDT,U))_" to "_$$FMTE^XLFDT($P(SDDT,U,2))
 D CTR^SCRPIUT1(X,IOM)
 ;
 W !!?10,"Divisions: ",$S(VAUTD:"All",1:"")
 I 'VAUTD S SDIV=""  F  S SDIV=$O(VAUTD(SDIV)) Q:'SDIV  W !?15,VAUTD(SDIV)
 ;
 D NEXTLEV(SDSEL1)
 D NEXTLEV(SDSEL2)
 Q
 ;
NEXTLEV(SRT) ;   Print out any sublevels of the user selection parameters
 N SDITEM
 ;
 I SRT["CLN" D
 . W !!?10,"Clinics: ",$S(VAUTC:"All",1:"")
 . I 'VAUTC S SDITEM=""  F  S SDITEM=$O(VAUTC(SDITEM)) Q:'SDITEM  W !?15,VAUTC(SDITEM)
 ;
 I SRT["PAT" D
 . W !!?10,"Patients: ",$S(VAUTN:"All",1:"")
 . I 'VAUTN S SDITEM=""  F  S SDITEM=$O(VAUTN(SDITEM)) Q:'SDITEM  W !?15,VAUTN(SDITEM)
 ;
 I SRT["ERR" D
 . W !!?10,"Error Codes: ",$S(VAUER:"All",1:"")
 . I 'VAUER S SDITEM=""  F  S SDITEM=$O(VAUER(SDITEM)) Q:'SDITEM  W !?15,VAUER(SDITEM),"   ",$E($P(^SD(409.76,SDITEM,1),U),1,60)
 ;
 I SRT["DSS" D
 . W !!?10,"Clinic Stop Codes: ",$S(VAUDS:"All",1:"")
 . I 'VAUDS S SDITEM=""  F  S SDITEM=$O(VAUDS(SDITEM)) Q:'SDITEM  W !?15,VAUDS(SDITEM)
 Q

SCRPI02A ; ALB/SCK - Print IEMM Statistical Summary Report ; 6/26/97
 ;;5.3;Scheduling;**66,143**;AUG 13, 1993
 ;
PRINT ;  print Summary Report
 ;  Variables
 ;
 N DASH,DBLDASH,PAGE,SDIV,SDNAME,SDT,SCABORT,TOTALS,SDMSG,LINE
 ;
 K ^TMP("SCRPI ERRORS",$J)
 I $G(SDBLT) D
 . S IOM=80
 S $P(DASH,"-",IOM-1)="",$P(DBLDASH,"=",IOM-1)=""
 S PAGE=0
 ;
 I '$D(^TMP("SCRPI SUM",$J)) D  G PRNQ
 . D HDR1
 . S X="No Incomplete Encounters found."
 . D WRT(DBLDASH)
 . D WRT(" "),WRT(X)
 ;
 I SDRTYP["S" D PRNTSUM
 I SDRTYP["D" D PRNTDTL
 ;
 I $D(TOTALS) D
 . D WRT(" "),WRT(" ")
 . S X="            Total Encounters: "_(+$G(TOTALS("TOT"))++$G(TOTALS("DTOT"))) D WRT(X)
 . S X=" Total Incomplete Encounters: "_(+$G(TOTALS("INC"))++$G(TOTALS("DINC"))) D WRT(X)
 ;
PRNQ ;
 D:$G(SDBLT) SENDMSG
 K ^TMP("SCRPI ERRS",$J)
 Q
 ;
PRNTSUM ;  Print encounter summary for each clinic
 ;  Variables
 ;
 N SDDCLN,SDIVN
 ;
 S SDIVN="" F  S SDIVN=$O(^TMP("SCRPI SUM",$J,SDIVN)) Q:SDIVN']""  D  Q:$G(SCABORT)
 . D HDR1 Q:$G(SCABORT)  D HDR2
 . S SDDCLN="" F  S SDDCLN=$O(^TMP("SCRPI SUM",$J,SDIVN,SDDCLN)) Q:SDDCLN']""  D  Q:$G(SCABORT)
 .. D PRNTCLN(SDIVN,SDDCLN)
 .. I '$G(SDBLT),$Y>(IOSL-5) D HDR1 Q:$G(SCABORT)  D HDR2
 Q
 ;
PRNTCLN(SDIVN,SDDCLN) ;
 N INC,TOT,DINC,DTOT,XN,SDPER
 ;
 S INC=+$P($G(^TMP("SCRPI SUM",$J,SDIVN,SDDCLN,0)),U,1)
 S TOT=+$P($G(^TMP("SCRPI SUM",$J,SDIVN,SDDCLN,0)),U,3)
 S DINC=+$P($G(^TMP("SCRPI SUM",$J,SDIVN,SDDCLN,0)),U,2)
 S DTOT=+$P($G(^TMP("SCRPI SUM",$J,SDIVN,SDDCLN,0)),U,4)
 Q:'INC
 S X=SDDCLN
 S X=X_$$SPACE^SCRPIUT1(33-$L(X))_$J(TOT+DTOT,6)
 S XN=" ("_$S(DTOT]"":DTOT,1:0)_")"
 S X=X_XN
 S X=X_$$SPACE^SCRPIUT1(48-$L(X))_$J(INC+DINC,6)
 S XN=" ("_$S(DINC]"":DINC,1:0)_")"
 S X=X_XN
 S SDPER=((INC+DINC)/(TOT+DTOT))*100
 S X=X_$$SPACE^SCRPIUT1(65-$L(X))_$J(SDPER,6,1)_"%"
 D WRT(X)
 S TOTALS("INC")=+$G(TOTALS("INC"))+INC
 S TOTALS("TOT")=+$G(TOTALS("TOT"))+TOT
 S TOTALS("DINC")=+$G(TOTALS("DINC"))+DINC
 S TOTALS("DTOT")=+$G(TOTALS("DTOT"))+DTOT
 Q
 ;
PRNTDTL ; Print error details for each clinic
 ;    Variables
 ;
 N SDDCLN,SDIVN
 ;
 S SDIVN="" F  S SDIVN=$O(^TMP("SCRPI SUM",$J,SDIVN)) Q:SDIVN']""  D  Q:$G(SCABORT)
 . S SDDCLN="" F  S SDDCLN=$O(^TMP("SCRPI SUM",$J,SDIVN,SDDCLN)) Q:SDDCLN']""  D  Q:$G(SCABORT)
 .. Q:'$P(^TMP("SCRPI SUM",$J,SDIVN,SDDCLN,0),U)
 .. D HDR1 Q:$G(SCABORT)  D HDR3
 .. D PRNERRS(SDIVN,SDDCLN)
 Q
 ;
PRNERRS(SDIVN,SDDCLN) ;
 N SDER,SDEC,SDERC,SDPER,SDETOT
 ;
 K ^TMP("SCRPI ERRS",$J)
 ;
 S SDER=0 F  S SDER=$O(^TMP("SCRPI SUM",$J,SDIVN,SDDCLN,SDER)) Q:'SDER  D
 . S SDETOT=+$G(SDETOT)++$G(^TMP("SCRPI SUM",$J,SDIVN,SDDCLN,SDER,0))
 ;
 S SDER=0 F  S SDER=$O(^TMP("SCRPI SUM",$J,SDIVN,SDDCLN,SDER)) Q:'SDER  D  Q:$G(SCABORT)
 . S SDERC=+$G(^TMP("SCRPI SUM",$J,SDIVN,SDDCLN,SDER,0))
 . I +SDETOT>0 S SDPER=(SDERC/SDETOT)*100
 . S ^TMP("SCRPI ERRS",$J,SDERC,SDER)=+SDPER
 . I '$G(SDBLT),$Y>(IOSL-5) D HDR1 Q:$G(SCABORT)  D HDR3
 ;
 S SDERC=999999 F  S SDERC=$O(^TMP("SCRPI ERRS",$J,SDERC),-1) Q:'SDERC  D  Q:$G(SCABORT)
 . S SDER="" F  S SDER=$O(^TMP("SCRPI ERRS",$J,SDERC,SDER)) Q:'SDER  D  Q:$G(SCABORT)
 .. S SDEC=$E($G(^SD(409.76,SDER,1)),1,52)
 .. I $L($G(^SD(409.76,SDER,1)))>52 S SDEC=SDEC_"..."
 .. W !,SDEC,?57,$J(SDERC,6),?70,$J(^TMP("SCRPI ERRS",$J,SDERC,SDER),6,1)_"%"
 .. I '$G(SDBLT),$Y>(IOSL-5) D HDR1 Q:$G(SCABORT)  D HDR3
 D PRNTOT(SDIVN,SDDCLN)
 Q
 ;
PRNTOT(SDIV,SDDCL) ;
 I '$G(SDBLT),$Y>(IOSL-5) D HDR1 Q:$G(SCABORT)  D HDR3
 S INC=+$P($G(^TMP("SCRPI SUM",$J,SDIV,SDDCL,0)),U,1)
 S TOT=+$P($G(^TMP("SCRPI SUM",$J,SDIV,SDDCL,0)),U,3)
 S DINC=+$P($G(^TMP("SCRPI SUM",$J,SDIV,SDDCL,0)),U,2)
 S DTOT=+$P($G(^TMP("SCRPI SUM",$J,SDIV,SDDCL,0)),U,4)
 W !!!,"          Incomplete Encounters: ",$J(INC,6,0)
 W !,"               Total Encounters: ",$J(TOT,6,0)
 W !,"(Deleted) Incomplete Encounters: ",$J(DINC,6,0)
 W !,"     (Deleted) Total Encounters: ",$J(DTOT,6,0)
 ;
 ;
 Q
 ;
HDR1 ;   Print report header
 N SDL,X
 ;
 I $$S^%ZTLOAD S SCABORT=1 Q
 I 'PAGE,IOST?1"C-".E W @IOF
 I PAGE,IOST?1"C-".E D  Q:$G(SCABORT)
 . S DIR(0)="E" D ^DIR K DIR S SCABORT='+$G(Y)
 . W @IOF
 E  D
 . I '$G(SDBLT),PAGE W @IOF
 ;
 S PAGE=PAGE+1
 I $G(SDBLT) D WRT(""),WRT("")
 S X="Date: "_$$FDATE^VALM1($$DT^XLFDT)
 S X=X_$$SPACE^SCRPIUT1(17-$L(X))_"Incomplete Encounter Mgmt Summary Error Report"
 S X=X_$$SPACE^SCRPIUT1((79-$L(X))-$L("PAGE: "_PAGE))_"PAGE: "_PAGE
 D WRT(X)
 S X="Date Range: "_$$FMTE^XLFDT($P(SDDT,U))_" to "_$$FMTE^XLFDT($P(SDDT,U,2))
 D CTR^SCRPIUT1(.X),WRT(X)
 Q
 ;
HDR2 ;
 N X
 S X="Division: "_$S($G(SDIVN)]"":SDIVN,1:"  ---")
 D CTR^SCRPIUT1(.X),WRT(X)
 S X="Clinic Summary - Incomplete Encounters"
 D CTR^SCRPIUT1(.X),WRT(X)
 D WRT(""),WRT("")
 ;
 S X="Clinic"_$$SPACE^SCRPIUT1(30)_"Encounters"_$$SPACE^SCRPIUT1(5)_"Incomplete"_$$SPACE^SCRPIUT1(5)_"Percentage"
        D WRT(X),WRT(DBLDASH)
 S X="Note: (nn) = Number of total encounters which are deleted encounters"
 D CTR^SCRPIUT1(.X),WRT(X),WRT("")
 Q
 ;
HDR3 ;
 S X="Division: "_$S($G(SDIVN)]"":SDIVN,1:"  ---")
 D CTR^SCRPIUT1(.X),WRT(X)
 S X="Clinic: "_$S($G(SDDCLN)]"":SDDCLN,1:"  ---")
 D CTR^SCRPIUT1(.X),WRT(X),WRT("")
 S X=$$SPACE^SCRPIUT1(55)_"Number of"_$$SPACE^SCRPIUT1(8)_"Percent" D WRT(X)
 S X="Error"_$$SPACE^SCRPIUT1(50)_"Occurrences"_$$SPACE^SCRPIUT1(5)_"of Total" D WRT(X)
 D WRT(DBLDASH)
 S X="< Errors in descending order of occurrence >" D CTR^SCRPIUT1(.X),WRT(X),WRT("")
 Q
 ;
WRT(X) ;   Write string to either output device or bulletin array
 I $G(SDBLT) D
 . S LINE=+$G(LINE)+1
 . S SDMSG(LINE)=X
 E  D
 . I $Y>(IOSL-5) D HDR1 Q:$G(SCABORT)
 . W !,X
 Q
 ;
SENDMSG ;  Sends bulletin message
 N XMB,XMDUZ,XMTEXT
 ;
 S XMB="SCDX INCOMPLETE ENCOUNTER MGMT"
 S XMB(1)="IEMM Summary Report"
 S XMDUZ="INCOMPLETE ENCOUNTER MANAGEMENT"
 ;
 S XMTEXT="SDMSG("
 D ^XMB
 Q

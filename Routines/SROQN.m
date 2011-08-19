SROQN ;BIR/ADM - REPORT OF MISSING DATA FOR QUARTERLY REPORT ;07/20/04  9:11 AM
 ;;3.0; Surgery ;**62,77,92,129,142**;24 Jun 93
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure. Local modifications to this routine
 ;**         are prohibited.
 ;
 S SRSOUT=0,SRSPEC="" W @IOF,!,?18,"Report of Missing Quarterly Report Data",!!
 W !,"For surgical cases with an entry in the TIME PAT IN OR field and that are not",!,"aborted, this option generates a report of cases missing any of the following",!,"pieces of information used by the Quarterly Report:"
 W !!,?10,"In/Out-Patient Status",!,?10,"Major/Minor",!,?10,"Case Schedule Type",!,?10,"Attending Code",!,?10,"Time Pat Out OR",!,?10,"Wound Classification",!,?10,"ASA Class",!,?10,"CPT Code (Principal)",!
SEL ; select date range and specialty
 D DATE^SROUTL(.SDATE,.EDATE,.SRSOUT) G:SRSOUT END D SPEC^SROUTL G:SRSOUT END
 N SRINSTP S SRINST=$$INST^SROUTL0() G:SRINST="^" END S SRINSTP=$P(SRINST,"^"),SRINST=$S(SRINST["ALL DIVISIONS":SRINST,1:$P(SRINST,"^",2))
IO W !!,"This report is designed to use a 132 column format.",!
 K %ZIS,IOP,IO("Q"),POP S %ZIS("A")="Print the report to which Printer ? ",%ZIS("B")="",%ZIS="Q" D ^%ZIS I POP S SRSOUT=1 G END
 I $D(IO("Q")) K IO("Q") S ZTDESC="Report of Missing Data for Quarterly Report",(ZTSAVE("EDATE"),ZTSAVE("SDATE"),ZTSAVE("SRINSTP"),ZTSAVE("SRSPEC*"))="",ZTRTN="EN^SROQN" D ^%ZTLOAD S SRSOUT=1 G END
EN U IO S (SRTOT,SRSOUT)=0,(SRHDR,SRPAGE)=1,SRSD=SDATE-.0001,SRED=EDATE+.9999,Y=SDATE X ^DD("DD") S STARTDT=Y,Y=EDATE X ^DD("DD") S ENDATE=Y K ^TMP("SR",$J)
 S SRRPT="Report of Missing Data for Quarterly Report",SRFRTO="From: "_STARTDT_"  To: "_ENDATE
 S SRINST=$S(SRINSTP["ALL DIV":$P($$SITE^SROVAR,"^",2)_" - ALL DIVISIONS",1:$$GET1^DIQ(4,SRINSTP,.01))
 D NOW^%DTC S Y=$E(%,1,12) X ^DD("DD") S SRPRINT="Report Printed: "_Y
 D HDR,AC
 I '$O(^TMP("SR",$J,0)) W !!,"No data for selected date range." G END
 S SRSD=0 F  S SRSD=$O(^TMP("SR",$J,SRSD)) Q:'SRSD!SRSOUT  S SRTN=0 F  S SRTN=$O(^TMP("SR",$J,SRSD,SRTN)) Q:'SRTN!SRSOUT  S SRTOT=SRTOT+1,SRZ=^TMP("SR",$J,SRSD,SRTN) D PRINT
 G:SRSOUT END D:$Y+8>IOSL PAGE G:SRSOUT END W !!,"TOTAL CASES MISSING DATA: ",SRTOT
 D CODES
END W:$E(IOST)="P" @IOF I $D(ZTQUEUED) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 I 'SRSOUT,$E(IOST)'="P" D PRESS
 D ^%ZISC K ^TMP("SR",$J),SRFRTO,SRIO,SRTOT,SRRPT,SRTN D ^SRSKILL W @IOF
 Q
AC F  S SRSD=$O(^SRF("AC",SRSD)) Q:'SRSD!(SRSD>SRED)!SRSOUT  S SRTN=0 F  S SRTN=$O(^SRF("AC",SRSD,SRTN)) Q:'SRTN  I $D(^SRF(SRTN,0)),$$MANDIV^SROUTL0(SRINSTP,SRTN) D CASE
 Q
CASE ; examine case for missing items
 Q:'$P($G(^SRF(SRTN,.2)),"^",10)!($P($G(^SRF(SRTN,"NON")),"^")="Y")!$P($G(^SRF(SRTN,30)),"^")
 S SR(0)=^SRF(SRTN,0),DFN=$P(SR(0),"^"),SRSS=$P(SR(0),"^",4) I SRSPEC Q:SRSS'=SRSPEC
 S SRIO=$P(SR(0),"^",12) I SRIO'="O"&(SRIO'="I") S SRIO=""
 S SRMM=$P(SR(0),"^",3),SRTYPE=$P(SR(0),"^",10),SRASA=$P($G(^SRF(SRTN,1.1)),"^",3),SRATT=$P($G(^SRF(SRTN,.1)),"^",10),SRWC=$P($G(^SRF(SRTN,"1.0")),"^",8) I SRATT="" D RS^SROQ0A
 S SROUT=$P($G(^SRF(SRTN,.2)),"^",12),SRCPT=$P($G(^SRO(136,SRTN,0)),"^",2)
 S (SRMISS,X)="" S:SRIO="" X="A," S:SRMM="" X=X_"B," S:SRTYPE="" X=X_"C," S:SRATT=99 X=X_"D," S:'SROUT X=X_"E," S:SRWC="" X=X_"F," S:SRASA="" X=X_"G," S:'SRCPT X=X_"H,"
 S Y=$L(X),SRMISS=$E(X,1,Y-1) I SRMISS'="" S ^TMP("SR",$J,SRSD,SRTN)=DFN_"^"_SRSS_"^"_SRMISS
 Q
PRINT ; print case information
 D:$Y+9>IOSL PAGE Q:SRSOUT  S DFN=$P(SRZ,"^"),SRSS=$P(SRZ,"^",2),SRSS=$S(SRSS:$P(^SRO(137.45,SRSS,0),"^"),1:"SPECIALTY NOT ENTERED"),Y=SRSD X ^DD("DD") S SRSDATE=Y
 S SRDOC=$P($G(^SRF(SRTN,.1)),"^",4) I SRDOC S SRDOC=$P(^VA(200,SRDOC,0),"^")
 D DEM^VADPT S SRSNM=VADM(1),SRSSN=VA("PID"),X1=$E(SRSD,1,7),X2=$P(VADM(3),"^"),SRAGE=$E(X1,1,3)-$E(X2,1,3)-($E(X1,4,7)<$E(X2,4,7)),SRMISS=$P(SRZ,"^",3)
 K SRPROC S X=$P(^SRF(SRTN,"OP"),"^") I $L(X)<79 S SRPROC(1)=X
 I $L(X)>78 S K=1 F  D  I $L(X)<56 S SRPROC(K)=X Q
 .F I=0:1:54 S J=78-I,Y=$E(X,J) I Y=" " S SRPROC(K)=$E(X,1,J-1),X=$E(X,J+1,$L(X)) S K=K+1 Q
 W !,SRSDATE,?22,SRSNM,?54,$S(SRSPEC:SRDOC,1:SRSS),?97,SRMISS,!,SRTN,?22,SRSSN_"  ("_SRAGE_")",?54,SRPROC(1),!
 W:$D(SRPROC(2)) ?54,SRPROC(2),!
 Q
PRESS W !! K DIR S DIR(0)="E" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
PAGE D CODES I $E(IOST)="P"!SRHDR G HDR
 D PRESS I SRSOUT Q
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 W:$Y @IOF W:$E(IOST)="P" !,?(IOM-$L(SRINST)\2),SRINST W !,?(IOM-$L(SRRPT)\2),SRRPT,?(IOM-10),$J("PAGE "_SRPAGE,9),!,?(IOM-$L(SRFRTO)\2),SRFRTO W:$E(IOST)="P" !,?(IOM-$L(SRPRINT)\2),SRPRINT
 I SRSPEC S X="SURGICAL SPECIALTY: "_SRSPECN W !,?(IOM-$L(X)\2),X
 W !!,"DATE OF OPERATION",?22,"PATIENT NAME",?54,$S(SRSPEC:"SURGEON",1:"SURGICAL SPECIALTY"),?97,"MISSING ITEMS",!,"CASE #",?22,"PATIENT ID  (AGE)",?54,"PRINCIPAL PROCEDURE"
 S SRHDR=0,SRPAGE=SRPAGE+1 W ! F I=1:1:IOM W "="
 Q
CODES ; missing items code definition
 F I=$Y:1:(IOSL-8) W !
 W ! F I=1:1:IOM W "-"
 W !,"MISSING ITEMS CODES:  A-IN/OUT-PATIENT STATUS,   B-MAJOR/MINOR,   C-CASE SCHEDULE TYPE,     D-ATTENDING CODE,"
 W !,"E-TIME PAT OUT OR,    F-WOUND CLASSIFICATION,    G-ASA CLASS,     H-CPT CODE (PRINCIPAL)"
 Q

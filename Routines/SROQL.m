SROQL ;BIR/ADM - LIST OF OPERATIONS FOR QUARTERLY REPORT ;06/15/04  11:46 AM
 ;;3.0; Surgery ;**62,77,50,129,142**;24 Jun 93
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure. Local modifications to this routine
 ;**         are prohibited.
 ;
 S SRSOUT=0,SRSPEC="" W @IOF,!,?17,"List of Operations Included on Quarterly Report",!!
 W !,"This option generates a list of completed operations that are included on the",!,"Quarterly Report and displays the data fields for each case that are checked",!,"by the Quarterly Report."
SEL ; select date range and specialty
 D DATE^SROUTL(.SDATE,.EDATE,.SRSOUT) G:SRSOUT END D SPEC^SROUTL G:SRSOUT END
 N SRINSTP S SRINST=$$INST^SROUTL0() G:SRINST="^" END S SRINSTP=$P(SRINST,"^"),SRINST=$S(SRINST["ALL DIVISIONS":SRINST,1:$P(SRINST,"^",2))
IO W !!,"This report is designed to use a 132 column format.",!
 K %ZIS,IOP,IO("Q"),POP S %ZIS("A")="Print the report to which Printer ? ",%ZIS("B")="",%ZIS="Q" D ^%ZIS I POP S SRSOUT=1 G END
 I $D(IO("Q")) K IO("Q") S ZTDESC="List of Operations Included on Quarterly Report",(ZTSAVE("EDATE"),ZTSAVE("SDATE"),ZTSAVE("SRINSTP"),ZTSAVE("SRSPEC*"))="",ZTRTN="EN^SROQL" D ^%ZTLOAD S SRSOUT=1 G END
EN U IO S (SRTOT,SRSOUT)=0,(SRHDR,SRPAGE)=1,SRSD=SDATE-.0001,SRED=EDATE+.9999,Y=SDATE X ^DD("DD") S STARTDT=Y,Y=EDATE X ^DD("DD") S ENDATE=Y K ^TMP("SR",$J)
 S SRRPT="List of Operations Included on Quarterly Report",SRFRTO="From: "_STARTDT_"  To: "_ENDATE
 S SRINST=$S(SRINSTP["ALL DIV":$P($$SITE^SROVAR,"^",2)_" - ALL DIVISIONS",1:$$GET1^DIQ(4,SRINSTP,.01))
 D NOW^%DTC S Y=$E(%,1,12) X ^DD("DD") S SRPRINT="Report Printed: "_Y
 D HDR,AC I 'SRTOT W $$NODATA^SROUTL0() G END
 G:SRSOUT END D:$Y+8>IOSL PAGE G:SRSOUT END W !!,"TOTAL CASES: ",SRTOT
END W:$E(IOST)="P" @IOF I $D(ZTQUEUED) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 I 'SRSOUT,$E(IOST)'="P" D PRESS
 D ^%ZISC K SRFRTO,SRIO,SRPERI,SRTOT,SRRPT,SRTN D ^SRSKILL W @IOF
 Q
AC F  S SRSD=$O(^SRF("AC",SRSD)) Q:'SRSD!(SRSD>SRED)!SRSOUT  S SRTN=0 F  S SRTN=$O(^SRF("AC",SRSD,SRTN)) Q:'SRTN  I $D(^SRF(SRTN,0)),$$MANDIV^SROUTL0(SRINSTP,SRTN) D CASE
 Q
CASE ; examine case
 Q:'$P($G(^SRF(SRTN,.2)),"^",12)!($P($G(^SRF(SRTN,"NON")),"^")="Y")!$P($G(^SRF(SRTN,30)),"^")
 S SR(0)=^SRF(SRTN,0),DFN=$P(SR(0),"^"),SRSS=$P(SR(0),"^",4) I SRSPEC Q:SRSS'=SRSPEC
 D DEM^VADPT S SRSNM=VADM(1),SRSSN=VA("PID"),X1=$E(SRSD,1,7),X2=$P(VADM(3),"^"),SRAGE=$E(X1,1,3)-$E(X2,1,3)-($E(X1,4,7)<$E(X2,4,7))
 S SRSS=$S(SRSS:$P(^SRO(137.45,SRSS,0),"^"),1:"???"),Y=SRSD X ^DD("DD") S SRSDATE=Y,SRDOC=$P($G(^SRF(SRTN,.1)),"^",4) I SRDOC S SRDOC=$P(^VA(200,SRDOC,0),"^")
 S X=$P(SR(0),"^",12),SRIO=$S(X="I":"INPATIENT",X="O":"OUTPATIENT",1:"???"),X=$P(SR(0),"^",3),SRMM=$S(X="J":"MAJOR",X="N":"MINOR",1:"???")
 S Y=$P(SR(0),"^",10),C=$P(^DD(130,.035,0),"^",2) D Y^DIQ S SRTYPE=$S(Y="":"???",1:Y),Y=$P($G(^SRF(SRTN,1.1)),"^",3),C=$P(^DD(130,1.13,0),"^",2) D Y^DIQ S SRASA=$S(Y="":"???",1:Y)
 S Y=$P($G(^SRF(SRTN,"1.0")),"^",8),C=$P(^DD(130,1.09,0),"^",2) D Y^DIQ S SRWC=$S(Y="":"???",1:Y)
 S SRATT=$P($G(^SRF(SRTN,.1)),"^",10) I SRATT="" D RS^SROQ0A
 S I=SRATT D
 .S SRATT=$S(I=9:"A",I=10:"B",I=11:"C",I=12:"D",I=13:"E",I=14:"F",I=1:"0 (Old)",I=2:"1 (Old)",I=3:"2 (Old)",I=4:"3 (Old)",I=5:"0",I=6:"1",I=7:"2",I=8:"3",1:"???")
 S SRTOT=SRTOT+1,SRL=78,SRSUPCPT=1 D PROC^SROUTL,OCC D:$Y+9>IOSL PAGE Q:SRSOUT
 W !,SRSDATE,?22,SRSNM,?54,SRSSN_"  ("_SRAGE_")",?81,$E(SRASA,1,25),?108,"LEVEL "_SRATT,!,SRTN_"  ("_SRMM_")",?22,$S(SRSPEC:SRDOC,1:$E(SRSS,1,30)),?54,$E(SRTYPE,1,25),?81,SRWC,?108,SRIO,!
 F I=1:1 Q:'$D(SRPERI(I))&('$D(SRPROC(I)))  W:$D(SRPERI(I)) SRPERI(I) W:$D(SRPROC(I)) ?54,SRPROC(I) W !
AAA S SRL=78 D PROC^SROUTLN D:$Y+9>IOSL PAGE Q:SRSOUT  F I=1:1 Q:'$D(SRPROC(I))  D
 .W !,?54,SRPROC(I) W !
 F I=1:1:IOM W "-"
 Q
PRESS W !! K DIR S DIR(0)="E" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
OCC ; get occurrences
 K SRPERI S SROCC=0,SRP=1
 F  S SROCC=$O(^SRF(SRTN,10,SROCC)) Q:'SROCC  S SRCAT=$P(^SRF(SRTN,10,SROCC,0),"^",2) I SRCAT S SRPERI(SRP)="INTRAOP - "_$P(^SRO(136.5,SRCAT,0),"^"),SRP=SRP+1
 S SROCC=0 F  S SROCC=$O(^SRF(SRTN,16,SROCC)) Q:'SROCC  S SRCAT=$P(^SRF(SRTN,16,SROCC,0),"^",2) I SRCAT S SRPERI(SRP)="POSTOP - "_$P(^SRO(136.5,SRCAT,0),"^"),SRP=SRP+1
 Q
PAGE I $E(IOST)="P"!SRHDR G HDR
 D PRESS I SRSOUT Q
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 W:$Y @IOF W:$E(IOST)="P" !,?(IOM-$L(SRINST)\2),SRINST W !,?(IOM-$L(SRRPT)\2),SRRPT,?(IOM-10),$J("PAGE "_SRPAGE,9),!,?(IOM-$L(SRFRTO)\2),SRFRTO W:$E(IOST)="P" !,?(IOM-$L(SRPRINT)\2),SRPRINT
 I SRSPEC S X="SURGICAL SPECIALTY: "_SRSPECN W !,?(IOM-$L(X)\2),X
 W !!,"DATE OF OPERATION",?22,"PATIENT NAME",?54,"PATIENT ID  (AGE)",?81,"ASA CLASS",?108,"RESIDENT SUPERVISION"
 W !,"CASE #  (MAJ/MIN)",?22,$S(SRSPEC:"SURGEON",1:"SURGICAL SPECIALTY"),?54,"CASE SCHEDULE TYPE",?81,"WOUND CLASS",?108,"IN/OUT-PAT STATUS"
 W !,"OCCURENCE(S)",?54,"PROCEDURE(S)" S SRHDR=0,SRPAGE=SRPAGE+1 W ! F I=1:1:IOM W "="
 Q

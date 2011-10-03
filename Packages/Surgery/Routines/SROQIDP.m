SROQIDP ;BIR/ADM - LIST OF INVASIVE DIAGNOSTIC PROCEDURES ;12/16/98  12:11 PM
 ;;3.0; Surgery ;**62,77,50,88,142**;24 Jun 93
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure.  Local modifications to this routine
 ;**         are prohibited.
 ;
 S SRSOUT=0 W @IOF,!,?20,"List of Invasive Diagnostic Procedures",!!,"This report displays the completed surgical cases that meet the selection",!,"criteria and that have a principal CPT code on the list below defined by"
 W !,"Surgical Service at VHA Headquarters as invasive diagnostic procedures.",!!,?3,"Procedure Group",?30,"CPT Code(s)",!,?3,"---------------",?30,"-----------" D SHOW,PRESS^SROQIDP0 G:SRSOUT END
SEL S (SRIO,SRSPEC)="" W @IOF S SRRPT="List of Invasive Diagnostic Procedures",SRB="O" D INOUT^SROUTL G:SRSOUT END D DATE^SROUTL(.SDATE,.EDATE,.SRSOUT) G:SRSOUT END D SPEC^SROUTL G:SRSOUT END
 N SRINSTP S SRINST=$$INST^SROUTL0() G:SRINST="^" END S SRINSTP=$P(SRINST,"^"),SRINST=$S(SRINST["ALL DIVISIONS":SRINST,1:$P(SRINST,"^",2))
IO W !!,"This report is designed to use a 132 column format.",!
 K %ZIS,IOP,IO("Q"),POP S %ZIS("A")="Print the List of Invasive Diagnostic Procedures to which Printer ? ",%ZIS("B")="",%ZIS="Q" D ^%ZIS I POP S SRSOUT=1 G END
 I $D(IO("Q")) K IO("Q") S ZTDESC="List of Invasive Diagnostic Procedures",(ZTSAVE("EDATE"),ZTSAVE("SRIO"),ZTSAVE("SDATE"),ZTSAVE("SRINSTP"),ZTSAVE("SRSPEC*"))="",ZTRTN="EN^SROQIDP" D ^%ZTLOAD S SRSOUT=1 G END
EN D ^SROQIDP0
END W:$E(IOST)="P" @IOF I $D(ZTQUEUED) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 I 'SRSOUT,$E(IOST)'="P" D PRESS^SROQIDP0
 D ^%ZISC K ^TMP("SR",$J),SRFRTO,SRIDP,SRIDPT,SRIO,SRIOSTAT,SRIOT,SRRPT,SRTN D ^SRSKILL W @IOF
 Q
AC F  S SRSD=$O(^SRF("AC",SRSD)) Q:'SRSD!(SRSD>SRED)!SRSOUT  S SRTN=0 F  S SRTN=$O(^SRF("AC",SRSD,SRTN)) Q:'SRTN  I $D(^SRF(SRTN,0)),$$MANDIV^SROUTL0(SRINSTP,SRTN) D CASE Q:SRSOUT
 Q
CASE ; determine if case is invasive procedure
 Q:'$P($G(^SRF(SRTN,.2)),"^",12)!($P($G(^SRF(SRTN,"NON")),"^")="Y")!$P($G(^SRF(SRTN,30)),"^")
 S SR(0)=^SRF(SRTN,0),SRSS=$P(SR(0),"^",4) I SRSPEC Q:SRSS'=SRSPEC
 S SRIOSTAT=$P(SR(0),"^",12) I SRIOSTAT'="I"&(SRIOSTAT'="O") S VAIP("D")=SRSD D IN5^VADPT S SRIOSTAT=$S(VAIP(13):"I",1:"O") K VAIP
 I SRIO'="A" Q:SRIOSTAT'=SRIO
 D IDP I SRIDP S ^TMP("SR",$J,SRSD,SRTN)=$P(SR(0),"^")_"^"_SRSS_"^"_SRIOSTAT,SRIDPT=SRIDPT+1,SRIOT(SRIOSTAT)=SRIOT(SRIOSTAT)+1
 Q
QTR ; entry from quarterly report
 N SROP,SROPER S SRIDP=0 D IDP I SRIDP D ADD
 Q
IDP ; get CPT codes for procedures performed
 N SRCODES,SRCPT,SRMATCH S SRIDP=0 S SROP=$P($G(^SRO(136,SRTN,0)),"^",2) I SROP S SROP=$P($$CPT^ICPTCOD(SROP),"^",2) D CHECK I SRMATCH S SRIDP=1
 I SRIDP S SROPER=0 F  S SROPER=$O(^SRO(136,SRTN,3,SROPER)) Q:'SROPER  S SROP=$P($G(^SRO(136,SRTN,3,SROPER,0)),"^") I SROP D CHECK I 'SRMATCH S SRIDP=0 Q
 Q
CHECK ; compare procedure performed with HQ list
 S SRMATCH=0 F J=1:1:6 Q:SRMATCH  S SRCODES=$P($T(PROC+J),";;",3) F K=1:1 S SRCPT=$P(SRCODES,",",K) Q:'SRCPT  I SRCPT=SROP S SRMATCH=1 Q
 Q
ADD ; increment counters in ^TMP
 S $P(^TMP("SRIDP",$J),"^")=$P(^TMP("SRIDP",$J),"^")+1
 I $P(SR(0),"^",12)="I" S $P(^TMP("SRIDP",$J),"^",2)=$P(^TMP("SRIDP",$J),"^",2)+1 Q
 S $P(^TMP("SRIDP",$J),"^",3)=$P(^TMP("SRIDP",$J),"^",3)+1
 Q
SHOW ; display list of invasive diagnostic procedures
 F I=1:1:6 S X=$T(PROC+I),SRPROC=$P(X,";;",2),SRCODES=$P(X,";;",3) W !,?3,SRPROC,?30,$E(SRCODES,1,48) I $L(SRCODES)>48 W !,?30,$E(SRCODES,49,96)
 Q
PROC ; HQ list of invasive diagnostic procedures
 ;;Urologic;;52000,52005,52007,52010,52204;;
 ;;ENT;;31231;;
 ;;Pulmonary (Respiratory);;31615,31622,31625,31628,31629,31656;;
 ;;Upper Gastrointestinal;;43200,43202,43234,43235,43239,43259,43263;;
 ;;Small Bowel and Stomach;;44360,44361,44376,44377,44380,44382,44385,44386,44388,44389;;
 ;;Colon and Rectum;;45330,45331,45355,45378,45380,46600,46606

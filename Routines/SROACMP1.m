SROACMP1 ;BIR/ADM - M&M VERIFICATION REPORT (CONT'D) ;11/26/07
 ;;3.0; Surgery ;**47,68,77,50,166**;24 Jun 93;Build 6
EN ; entry point
 S (SRSOUT,SRSP)=0,SRINST=$P($$SITE^SROVAR,"^",2) W @IOF,!,?28,"M&M Verification Report"
 W !!,"The M&M Verification Report is a tool to assist in the review of occurrences"
 W !,"and their assignment to operations and in the review of death unrelated or",!,"related assignments to operations."
 W !!,"The full report includes all patients who had operations within the selected"
 W !,"date range who experienced intraoperative occurrences, postoperative"
 W !,"occurrences or death within 90 days of surgery. The pre-transmission report"
 W !,"is similar but includes only operations with completed risk assessments that"
 W !,"have not yet transmitted to the national database.",!
 D SEL G:SRSOUT END I SRFORM=2 G SPEC
 D DATE^SROUTL(.SRSD,.SRED,.SRSOUT) G:SRSOUT END
SPEC I $D(^XUSEC("SROCHIEF",+DUZ)) N SRINSTP S SRINST=$$INST^SROUTL0() G:SRINST="^" END S SRINSTP=$P(SRINST,U),SRINST=$S(SRINST["ALL DIVISIONS":SRINST,1:$P(SRINST,U,2))
 W !! K DIR S DIR("A")="Do you want to print this report for all Surgical Specialties ",DIR("B")="YES",DIR(0)="Y"
 S DIR("?",1)="Enter RETURN to print this report for all surgical specialties, or 'NO' to",DIR("?")="select a specific specialty."
 D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 G END
 I 'Y D SP I SRSOUT G END
DEV K IOP,%ZIS,POP,IO("Q") S %ZIS("A")="Print the Report on which Device: ",%ZIS="QM" W !!,"This report is designed to use a 132 column format.",! D ^%ZIS I POP S SRSOUT=1 G END
 I $D(IO("Q")) K IO("Q") S ZTDESC="M&M Verification Report",ZTRTN="BEG^SROACMP1",(ZTSAVE("SRFORM"),ZTSAVE("SRINST"),ZTSAVE("SRSP*"),ZTSAVE("SRINSTP"))="" S:SRFORM=1 (ZTSAVE("SRED"),ZTSAVE("SRSD"))="" D ^%ZTLOAD G END
BEG U IO S (SRHDR,SRNM,SRSOUT,SRSS)=0,PAGE=1,Y=DT X ^DD("DD") S SRPRINT="Report Generated: "_Y K ^TMP("SR",$J),^TMP("SRPAT",$J)
 N SRFRTO I SRFORM=1 D
 .S Y=SRSD X ^DD("DD") S SRFRTO="From: "_Y S Y=SRED X ^DD("DD") S SRFRTO=SRFRTO_"  To: "_Y
 .S SRSDT=SRSD-.0001,SREDT=SRED+.9999 F  S SRSDT=$O(^SRF("AC",SRSDT)) Q:SRSDT>SREDT!'SRSDT!SRSOUT  S SRTN=0 F  S SRTN=$O(^SRF("AC",SRSDT,SRTN)) Q:'SRTN!SRSOUT  D CASE
 I SRFORM=2 F SRASS="C","N" S DFN=0 F  S DFN=$O(^SRF("ARS",SRASS,"C",DFN)) Q:'DFN!SRSOUT  S SRTN=0 F  S SRTN=$O(^SRF("ARS",SRASS,"C",DFN,SRTN)) Q:'SRTN!SRSOUT  D CASE
 G:SRSOUT END G ^SROACMP
CASE ; examine case
 Q:'$D(^SRF(SRTN,0))
 I $D(^XUSEC("SROCHIEF",+DUZ)) Q:'$$MANDIV^SROUTL0(SRINSTP,SRTN)
 I '$D(^XUSEC("SROCHIEF",+DUZ)) Q:'$$DIV^SROUTL0(SRTN)
 I SRFORM=2,SRSP S Y=$P(^SRF(SRTN,0),"^",4) S:'Y Y="ZZ" I '$D(SRSP(Y)) Q
 I '$P($G(^SRF(SRTN,.2)),"^",12)!$P($G(^SRF(SRTN,30)),"^")!($P($G(^SRF(SRTN,"NON")),"^")="Y") Q
 S DFN=$P(^SRF(SRTN,0),"^") I $O(^SRF(SRTN,10,0))!$O(^SRF(SRTN,16,0)) S ^TMP("SR",$J,DFN,SRTN)=$P(^SRF(SRTN,0),"^",4) Q
 S SRDEATH=$P($G(^DPT(DFN,.35)),"^") I SRDEATH S X1=$P(^SRF(SRTN,0),"^",9),X2=90 D C^%DTC S SRDAY=X I SRDEATH'>SRDAY S ^TMP("SR",$J,DFN,SRTN)=$P(^SRF(SRTN,0),"^",4)
 Q
END Q:'$D(SRSOUT)  W @IOF K ^TMP("SRPAT",$J),^TMP("SRSP",$J) I $D(ZTQUEUED) K ^TMP("SR",$J) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 D ^%ZISC,^SRSKILL K SRTN W @IOF
 Q
SEL ; select report version
 K DIR S DIR("A",1)="Print which report ?",DIR("A",2)=" ",DIR("A",3)="1. Full report for selected date range.",DIR("A",4)="2. Pre-transmission report for completed risk assessments."
 S DIR("A",5)=" ",DIR("A")="Enter selection (1 or 2): ",DIR("B")=1,DIR("?")="Please enter the number (1 or 2) matching your choice of report",DIR(0)="NA^1:2" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 S SRFORM=Y
 Q
SP W !! S SRSP=1 K DIC S DIC("S")="I '$P(^(0),""^"",3)",DIC=137.45,DIC(0)="QEAMZ",DIC("A")="Print the report for which Specialty ?  " D ^DIC I Y<0 S SRSOUT=1 Q
 S SRCT=+Y,SRSP(SRCT)=+Y
MORE ; ask for more surgical specialties
 K DIC S DIC("S")="I '$P(^(0),""^"",3)",DIC=137.45,DIC(0)="QEAMZ",DIC("A")="Select an Additional Specialty:  " D ^DIC I Y>0 S SRCT=+Y,SRSP(SRCT)=+Y G MORE
 Q
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 I SRHDR D HDR2 Q:SRSOUT  S SRHDR=0
 W:$Y @IOF W !,?(132-$L(SRINST)\2),SRINST,?124,"Page ",PAGE,!,?54,"M&M Verification Report"
 W:SRFORM=1 !,?(132-$L(SRFRTO)\2),SRFRTO
 W:SRFORM=2 !,?41,"PRE-TRANSMISSION REPORT FOR COMPLETED ASSESSMENTS"
 W ?100,"REVIEWED BY:",!,?(132-$L(SRPRINT)\2),SRPRINT,?100,"DATE REVIEWED:",!
 W !,"OP DATE",?11,"CASE #",?25,"SURGICAL SPECIALTY",?80,"ASSESSMENT TYPE   STATUS",?116,"DEATH RELATED",!,?11,"PRINCIPAL PROCEDURE",! F LINE=1:1:132 W "="
 I SRNM W !,SRNAME_"   * * Continued from previous page * *"
 S PAGE=PAGE+1,SRHDR=1 I '$D(^TMP("SR",$J))
 Q
HDR2 ; more heading
 ;I $Y+6<IOSL F I=$Y:1:IOSL-5 W !
FOOT ; print footer
 ;W ! F LINE=1:1:IOM W "-"
 ;W !,"Occurrences(s): '*' Denotes Postop Occurrence",! F LINE=1:1:IOM W "-"
 S SRHDR=0 I $E(IOST)'="P" W ! K DIR S DIR(0)="E" D ^DIR K DIR I 'Y S SRSOUT=1
 Q

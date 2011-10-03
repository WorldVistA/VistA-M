SROABCH ;BIR/MAM - BATCH PRINT ASSESSMENTS ;11/28/07
 ;;3.0; Surgery ;**77,166**;24 Jun 93;Build 6
DATE ; get dates
 S (SRSOUT,SRSP)=0 W @IOF,!!,"This report will print all completed or transmitted assessments that have a",!,"date of operation within the date range selected.",!
 D DATE^SROUTL(.SRASTDT,.SRAENDT,.SRSOUT) G:SRSOUT END
 D SPEC
 W !!,"Depending on the date range entered, this report may be very long.  You should",!,"QUEUE this report to the selected printer.",!
 K %ZIS,IOP,POP,IO("Q") S %ZIS="Q",%ZIS("A")="Print on which Device: " D ^%ZIS S:POP SRSOUT=1 G:POP END
 I $D(IO("Q")) K IO("Q") S ZTRTN="EN^SROABCH",(ZTSAVE("SRSITE*"),ZTSAVE("SRASTDT"),ZTSAVE("SRAENDT"),ZTSAVE("SRSP"))="",ZTDESC="Batch Print Risk Assessments" D ^%ZTLOAD S SRSOUT=1 G END
EN ; entry when queued
 S SRSOUT=0,SRABATCH=1
 U IO S SRAENDT=SRAENDT+.9999,SDATE=SRASTDT-.0001 F  S SDATE=$O(^SRF("AC",SDATE)) Q:'SDATE!(SDATE>SRAENDT)!SRSOUT  S SRTN=0 F  S SRTN=$O(^SRF("AC",SDATE,SRTN)) Q:'SRTN!SRSOUT  D STUFF
END I $D(ZTQUEUED) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 D ^%ZISC K SRTN W @IOF D ^SRSKILL
 Q
STUFF ;
 I SRSP,$P(^SRF(SRTN,0),"^",4)'=SRSP Q
 S DATE=$P(^SRF(SRTN,0),"^",9)
 S SR("RA")=$G(^SRF(SRTN,"RA")),X=$P(SR("RA"),"^") I X'="T",X'="C" Q
 I $P(SR("RA"),"^",6)'="Y" Q
 K SRA D ^SROAPAS
 Q
SPEC ; select specialty
 W ! K DIR S DIR(0)="YA",DIR("A")="Print report for ALL surgical specialties ?  ",DIR("B")="YES"
 S DIR("?",1)="Enter YES to print the report for all surgical specialties, or NO to",DIR("?")="print the report for a specific surgical specialty."
 D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 I 'Y W ! K DIC S DIC("S")="I '$P(^(0),""^"",3)",DIC("A")="Print the Report for which Surgical Specialty: ",DIC=137.45,DIC(0)="QEAMZ" D ^DIC K DIC S:Y<0 SRSOUT=1 Q:Y<0  S SRSP=+Y
 Q

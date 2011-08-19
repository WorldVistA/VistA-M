SROADOC ;B'HAM ISC/MAM - ANESTHESIA PROVIDER REPORT; [ 09/22/98  11:23 AM ]
 ;;3.0; Surgery ;**77,50**;24 Jun 93
SETUTL ; set up ^TMP("SR",$J
 Q:'$D(^SRF(SRTN,.3))  Q:$P(^(.3),"^")=""  I SRPROV,$P(^(.3),"^")'=SRPROV Q
 S SRPRIN=$P(^VA(200,$P(^SRF(SRTN,.3),"^"),0),"^"),SRSDT=$P(^SRF(SRTN,0),"^",9) S ^TMP("SR",$J,SRPRIN,SRSDT,SRTN)=""
 Q
END W ! D ^SRSKILL K SRTN D ^%ZISC W @IOF
 Q
CODES ; print technique code at bottom of page
 W ! F LINE=1:1:IOM W "-"
 W !,"SUPERVISOR CODES: 1-STAFF CASE, 2-STAFF ASSISTED BY RESIDENT OR C.R.N.A.,  3-STAFF ASSISTING C.R.N.A.,  4-STAFF ASSISTING RESIDENT"
 W !,?18,"5-STAFF CONSULTING IN OR, 6-STAFF AVAILABLE IN OR SUITE, 7-STAFF AVAILABLE IN HOSP./UNIV. COMPLEX",!,?18,"8-STAFF CALLED FOR EMERGENCY, 9-C.R.N.A. INDEPENDENT DUTY MD/DDS SUP.",!
 Q
EN ;
 W @IOF,!,"Anesthesia Provider Report"
 D DATE^SROUTL(.SRSD,.SRED,.SRSOUT) G:SRSOUT END
SORT W !!!,"Do you want to print the report for all Anesthesia Providers ? YES// " R SRYN:DTIME I '$T!(SRYN["^") G END
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "Yy"[SRYN S SRPROV="" G DEVICE
 I "Nn"'[SRYN W !!,"Enter RETURN to print the report for all anesthesia providers, or 'NO'",!,"to select a specific anesthesia provider." G SORT
 W !! K DIC S DIC=200,DIC(0)="QEAMZ",DIC("A")="Print the report for which Anesthesia Provider ?  " D ^DIC K DIC I Y<0 G END
 S SRPROV=+Y,SRPRO=$P(Y(0),"^")
DEVICE K IOP,%ZIS,POP S %ZIS("A")="Print the Report on which Device: ",%ZIS="QM" W !!,"This report is designed to use a 132 column format.",! D ^%ZIS G:POP END
 I $D(IO("Q")) K IO("Q") S ZTDESC="ANESTHESIA PROVIDER REPORT",ZTRTN="BEG^SROADOC",ZTSAVE("SRSD")=SRSD,ZTSAVE("SRED")=SRED,(ZTSAVE("SRPRO*"),ZTSAVE("SRSITE*"))="" D ^%ZTLOAD G END
BEG ;
 U IO K ^TMP("SR",$J) S SRF=0,PAGE=1,DATE=SRSD-.0001,EDATE=SRED+.9999,SRINST=SRSITE("SITE"),Y=DT X ^DD("DD") S SRPRINT=Y
 N SRFRTO S Y=SRSD X ^DD("DD") S SRFRTO="FROM: "_Y_"  TO: " S Y=SRED X ^DD("DD") S SRFRTO=SRFRTO_Y
 F  S DATE=$O(^SRF("AC",DATE)) Q:DATE>EDATE!(DATE="")!SRF  S SRTN=0 F  S SRTN=$O(^SRF("AC",DATE,SRTN)) Q:SRTN=""  I $D(^SRF(SRTN,0)),$P($G(^SRF(SRTN,.2)),"^",12)'=""!($P($G(^SRF(SRTN,"NON")),"^")="Y"),$$DIV^SROUTL0(SRTN) D SETUTL
 G PR^SROADOC1

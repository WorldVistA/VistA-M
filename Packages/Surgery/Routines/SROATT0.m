SROATT0 ;B'HAM ISC/MAM - ATTENDING SURGEON REPORT (1 SURGEON) ; [ 05/11/04  2:33 PM ]
 ;;3.0; Surgery ;**50,129**;24 Jun 93
 W !! K DIC S DIC=200,DIC(0)="QEAMZ",DIC("A")="Print the Report for which Attending Surgeon ?  " D ^DIC I Y<0 S SRSOUT=1 G END
 S SRATT=+Y
REPORT W !!,"Do you want to view the totals for attending codes only ?  NO//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 S SRYN=$E(SRYN) S:SRYN="" SRYN="N"
 I "YyNn"'[SRYN W !!,"Enter RETURN to dispay individual case information and the total number of",!,"cases for each code.  If you only want to display the totals for the attending",!,"codes, enter 'YES'." G REPORT
 S SRBOTH=1 I "Yy"[SRYN S SRBOTH=0
 W:SRBOTH !!,"This report is designed to use a 132 column format."
 W:'SRBOTH !!,"This report is designed to use an 80 column format."
 W ! K IOP,POP,IO("Q"),%ZIS S %ZIS="QM",%ZIS("A")="Print the report on which Device ?  " D ^%ZIS I POP S SRSOUT=1 G END
 I $D(IO("Q")) K IO("Q") S ZTDESC="Attending Surgeon Report",ZTRTN="EN^SROATT0",(ZTSAVE("SRSD"),ZTSAVE("SRED"),ZTSAVE("SRATT"),ZTSAVE("SRBOTH"),ZTSAVE("SRSITE*"))="" D ^%ZTLOAD G END
EN ; entry when queued
 U IO S SRSOUT=0,SRINST=SRSITE("SITE"),SRINSTP=SRSITE("DIV"),Y=DT X ^DD("DD") S SRPRINT="DATE PRINTED: "_Y S Y=SRSD X ^DD("DD") S SRFRTO="FROM: "_Y_"  TO: ",Y=SRED X ^DD("DD") S SRFRTO=SRFRTO_Y
 K ^TMP("SR",$J),^TMP("SRTOT",$J)
 S ^TMP("SRTOT",$J)=0,^TMP("SRTOT",$J,"ZZ")=0
 S SRSDATE=SRSD-.0001,SREDT=SRED+.9999 F  S SRSDATE=$O(^SRF("AC",SRSDATE)) Q:'SRSDATE!(SRSDATE>SREDT)  S SRTN=0 F  S SRTN=$O(^SRF("AC",SRSDATE,SRTN)) Q:'SRTN  I $D(^SRF(SRTN,0)),$$DIV^SROUTL0(SRTN) D UTIL
 S SRATT="ATTENDING SURGEON: "_$P(^VA(200,SRATT,0),"^"),SRATT1="" F LINE=1:1:$L(SRATT) S SRATT1=SRATT1_"-"
 I SRBOTH D ^SROAT0P G:SRSOUT END
 D ^SROAT0T
END I $E(IOST)'="P",'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME
 W:$E(IOST)="P" @IOF K ^TMP("SRTOT",$J) I $D(ZTQUEUED) K ^TMP("SR",$J) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 D ^%ZISC K SRTN D ^SRSKILL W @IOF
 Q
UTIL I '$D(^SRF(SRTN,.2))!'$D(^SRF(SRTN,.1)) Q
 I '$P(^SRF(SRTN,.2),"^",12) Q
 S X=$P(^SRF(SRTN,.1),"^",13) I X'=SRATT Q
 S SRCODE=$P(^SRF(SRTN,.1),"^",10) S:SRCODE="" SRCODE="ZZ"
 I '$D(^TMP("SRTOT",$J,SRCODE)) S ^TMP("SRTOT",$J,SRCODE)=0
 S ^TMP("SR",$J,SRSDATE,SRTN)="",^TMP("SRTOT",$J)=^TMP("SRTOT",$J)+1,^TMP("SRTOT",$J,SRCODE)=^TMP("SRTOT",$J,SRCODE)+1

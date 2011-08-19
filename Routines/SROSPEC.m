SROSPEC ;B'HAM ISC/MAM - CASES WITHOUT SPECIMENS ; [ 09/22/98  11:36 AM ]
 ;;3.0; Surgery ;**77,50**;24 Jun 93
 S (SRSOUT,SRSP)=0,SRORD=1 W @IOF,!,"Report of Cases Without Specimens",!
DATE D DATE^SROUTL(.SRSD,.SRED,.SRSOUT) G:SRSOUT END
 N SRINSTP S SRINST=$$INST^SROUTL0() G:SRINST="^" END S SRINSTP=$P(SRINST,U),SRINST=$S(SRINST["ALL DIVISIONS":SRINST,1:$P(SRINST,U,2))
SORT G:SRSOUT END W @IOF,!,"Do you want the report sorted by Surgical Specialty ?  NO// " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 S SRYN=$E(SRYN) S:SRYN="" SRYN="N"
 I "YyNn"'[SRYN W !!,"Enter 'YES' to print this report sorted by surgical specialty or enter RETURN",!,"to not sort by surgical specialty.",!!,"Press RETURN to continue, or '^' to quit: " R X:DTIME S:'$T!(X["^") SRSOUT=1 G SORT
 I "Nn"[SRYN S SRORD=0 G DEV
SPEC W !!,"Do you want the report for a specific Surgical Specialty ?  NO//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 S SRYN=$E(SRYN) I SRYN="" S SRYN="N"
 I "YyNn"'[SRYN W !!,"Enter 'YES' to print this report for a specific surgical specialty, or RETURN",!,"to print the report, sorted by the date of operation, for all specialties.",!!,"Press RETURN to continue  " R X:DTIME G SPEC
 I "Yy"[SRYN D SP I SRSOUT G END
DEV W !!,"This report is designed to use a 132 column format."
 W ! K IOP,POP,IO("Q"),%ZIS S %ZIS="QM",%ZIS("A")="Print the Report on which Device ?  " D ^%ZIS I POP S SRSOUT=1 G END
 I $D(IO("Q")) K IO("Q") S ZTDESC="Cases Without Specimens",ZTRTN="EN^SROSPEC",(ZTSAVE("SRSD"),ZTSAVE("SRED"),ZTSAVE("SRORD"),ZTSAVE("SRSP*"),ZTSAVE("SRINST"),ZTSAVE("SRINSTP"))="" D ^%ZTLOAD G END
EN ; entry when queued
 U IO N SRFRTO S Y=DT X ^DD("DD") S SRPRINT="DATE PRINTED: "_Y S Y=SRSD X ^DD("DD") S SRFRTO="FROM: "_Y_"  TO: ",Y=SRED X ^DD("DD") S SRFRTO=SRFRTO_Y
 I SRORD D ^SROSPSS G END
 D ^SROSPC1
END I $E(IOST)'="P",'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME
 W:$E(IOST)="P" @IOF I $D(ZTQUEUED) K ^TMP("SR",$J) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 D ^%ZISC K SRTN D ^SRSKILL W @IOF
 Q
SP ; select specialty
 W ! S SRSP=1 K DIC S DIC("S")="I '$P(^(0),""^"",3)",DIC=137.45,DIC(0)="QEAMZ",DIC("A")="Print the Report of Cases Without Specimens for which Specialty ?  " D ^DIC I Y<0 S SRSOUT=1 Q
 S SRSP(+Y)=+Y
MORE ; more specialties?
 K DIC S DIC("S")="I '$P(^(0),""^"",3)",DIC=137.45,DIC(0)="QEAMZ",DIC("A")="Select An Additional Specialty:  " D ^DIC I Y>0 S SRSP(+Y)=+Y G MORE
 Q

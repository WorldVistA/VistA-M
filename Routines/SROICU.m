SROICU ;B'HAM ISC/MAM - UNSCHEDULED ADMISSIONS TO ICU ; [ 01/08/98   9:54 AM ]
 ;;3.0; Surgery ;**77,106**;24 Jun 93
 S SRINST=SRSITE("SITE"),SRSOUT=0 W @IOF,!,"Report of Unscheduled Admissions to the ICU",!
DATE D DATE^SROUTL(.SRSD,.SRED,.SRSOUT) G:SRSOUT END
SPEC W @IOF,!,"Do you want the report for a specific Surgical Specialty ?  NO//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 S SRSS="",SRYN=$E(SRYN) I SRYN="" S SRYN="N"
 I "YyNn"'[SRYN W !!,"Enter 'YES' to print this report for a specific surgical specialty, or RETURN",!,"to print the report, sorted by the date of operation, for all specialties.",!!,"Press RETURN to continue  " R X:DTIME G SPEC
 I "Yy"[SRYN D SP I SRSOUT G END
 W !!,"This report is designed to use a 132 column format."
 N SRINSTP S SRINST=$$INST^SROUTL0() G:SRINST="^" END S SRINSTP=$P(SRINST,U),SRINST=$S(SRINST["ALL DIVISIONS":SRINST,1:$P(SRINST,U,2))
 W ! K IOP,POP,IO("Q"),%ZIS S %ZIS="QM",%ZIS("A")="Print the Report on which Device ?  " D ^%ZIS I POP S SRSOUT=1 G END
 I $D(IO("Q")) K IO("Q") S ZTDESC="Unscheduled Admissions to ICU",ZTRTN="EN^SROICU",(ZTSAVE("SRSD"),ZTSAVE("SRED"),ZTSAVE("SRSS"),ZTSAVE("SRINST"),ZTSAVE("SRINSTP"))="" D ^%ZTLOAD G END
EN ; entry when queued
 U IO I SRSS D ^SROICU1 G END
 D ^SROICU2
END I $E(IOST)'="P",'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME
 W:$E(IOST)="P" @IOF I $D(ZTQUEUED) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 D ^%ZISC K SRTN D ^SRSKILL W @IOF
 Q
SP ; select specialty
 W ! K DIC S DIC("S")="I '$P(^(0),""^"",3)",DIC=137.45,DIC(0)="QEAMZ",DIC("A")="Print the report for which Surgical Specialty ?  " D ^DIC I Y<0 S SRSOUT=1
 S SRSS=+Y
 Q

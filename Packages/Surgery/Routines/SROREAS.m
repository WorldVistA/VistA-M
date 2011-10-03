SROREAS ;B'HAM ISC/MAM - DELAY REASONS ; [ 04/04/00  11:54 AM ]
 ;;3.0; Surgery ;**77,94**;24 Jun 93
 S (SRSOUT,SROTOT)=0 K %DT W @IOF,!,"Report of Delay Reasons",!
DATE D DATE^SROUTL(.SRSD,.SRED,.SRSOUT) G:SRSOUT END
 N SRINSTP S SRINST=$$INST^SROUTL0() G:SRINST="^" END S SRINSTP=$P(SRINST,U),SRINST=$S(SRINST["ALL DIVISIONS":SRINST,1:$P(SRINST,U,2))
SPEC W !!!,"Do you want to print the Report of Delay Reasons for all Surgical",!,"Specialties ?  YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter RETURN to print this report for all surgical specialties, or 'NO' to",!,"select a specific specialty." G SPEC
 S SRSS="" I "Nn"[SRYN D SP I SRSOUT G END
 I 'SRSS D ALL I SRSOUT G END
 W ! K %ZIS,IOP,IO("Q"),POP S %ZIS="Q",%ZIS("A")="Print the Report on which Device ?  " D ^%ZIS I POP S SRSOUT=1 G END
 I $D(IO("Q")) K IO("Q") S ZTRTN="EN^SROREAS",ZTDESC="Report of Delay Reasons",(ZTSAVE("SRSD"),ZTSAVE("SRED"),ZTSAVE("SRINST"),ZTSAVE("SRINSTP"),ZTSAVE("SRSS"),ZTSAVE("SROTOT"))="" D ^%ZTLOAD G END
EN ; entry when queued
 U IO S SRSOUT=1 K ^TMP("SR",$J) S ^TMP("SR",$J)=0
 I SRSS D ^SROREA1 G END
 D ^SROREA2
END I $E(IOST)'="P",'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME
 I $E(IOST)="P" W @IOF
 K ^TMP("SRT",$J) I $D(ZTQUEUED) K ^TMP("SR",$J) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 D ^%ZISC W @IOF D ^SRSKILL K SRTN
 Q
SP W !! K DIC S DIC=137.45,DIC(0)="QEAMZ",DIC("A")="Print the Report of Delayed Operations for which Specialty ?  " D ^DIC I Y<0 S SRSOUT=1 Q
 S SRSS=+Y
 Q
ALL ; display for each specialty ?
 W !!,"Do you want to display the totals for each Surgical Specialty ?  YES// " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 Q
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter RETURN to display the totals for delay reasons for each specialty.  If",!,"you want to display the totals for all delay reasons for the entire medical",!,"center, enter 'NO'." G ALL
 I "Nn"[SRYN S SROTOT=1

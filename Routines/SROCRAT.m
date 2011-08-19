SROCRAT ;B'HAM ISC/MAM - CANCELLATION RATES ; [ 04/06/00  10:19 AM ]
 ;;3.0; Surgery ;**77,94**;24 Jun 93
 S (SRSOUT,SROTOT)=0 K %DT W @IOF,!,"Report of Cancellation Rates",!
DATE D DATE^SROUTL(.SRSD,.SRED,.SRSOUT) G:SRSOUT END
 N SRINSTP S SRINST=$$INST^SROUTL0() G:SRINST="^" END S SRINSTP=$P(SRINST,U),SRINST=$S(SRINST["ALL DIVISIONS":SRINST,1:$P(SRINST,U,2))
SPEC W !!!,"Do you want to print the report for all Surgical Specialties ?  YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter RETURN to print this report for all surgical specialties, or 'NO' to",!,"select a specific specialty." G SPEC
 S SRSS="" I "Nn"[SRYN D SP I SRSOUT G END
 I 'SRSS D ALL I SRSOUT G END
 W ! K %ZIS,IOP,IO("Q"),POP S %ZIS="Q",%ZIS("A")="Print the Report on which Device ?  " D ^%ZIS I POP S SRSOUT=1 G END
 I $D(IO("Q")) K IO("Q") S ZTRTN="EN^SROCRAT",ZTDESC="Cancellation Rate Report",(ZTSAVE("SRSD"),ZTSAVE("SRED"),ZTSAVE("SRINST"),ZTSAVE("SRINSTP"),ZTSAVE("SRSS*"),ZTSAVE("SROTOT"))="" D ^%ZTLOAD G END
EN ; entry when queued
 U IO S SRSOUT=1 K ^TMP("SR",$J)
 I SRSS D ^SRORAT1 G END
 D ^SRORAT2
END I $E(IOST)'="P",'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME
 I $E(IOST)="P" W @IOF
 K ^TMP("SRT",$J) I $D(ZTQUEUED) K ^TMP("SR",$J) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 D ^%ZISC W @IOF D ^SRSKILL K SRTN
 Q
SP W !! S SRSS=1 K DIC S DIC("S")="I '$P(^(0),""^"",3)",DIC=137.45,DIC(0)="QEAMZ",DIC("A")="Print the report for which Specialty ?  " D ^DIC I Y<0 S SRSOUT=1 Q
 S SRCT=+Y,SRSS(SRCT)=+Y D MORE
 Q
ALL ; display for each specialty ?
 W !!,"Do you want to display the cancellation reasons for each Surgical",!,"Specialty ?  YES// " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 Q
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter RETURN to display cancellation rates for each specialty along with the",!,"cancellation rates for the entire medical center.  If you only want to display"
 I "YyNn"'[SRYN W !,"the rates for the entire medical center, enter 'NO'." G ALL
 I "Nn"[SRYN S SROTOT=1
 Q
MORE ; ask for more surgical specialties
 K DIC S DIC("S")="I '$P(^(0),""^"",3)",DIC=137.45,DIC(0)="QEAMZ",DIC("A")="Select An Additional Specialty:  " D ^DIC I Y>0 S SRCT=+Y,SRSS(SRCT)=+Y G MORE
 Q

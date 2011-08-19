SROCAN ;B'HAM ISC/MAM - REPORT OF CANCELLATIONS; [ 04/06/00   9:54 AM ]
 ;;3.0; Surgery ;**77,94**;24 Jun 93
EN S (SRSOUT,SRSP)=0
 W @IOF,!,"Report of Cancellations",!!,"NOTE: This report contains all cancelled cases, including those that were",!,"      cancelled after the patient had entered the operating room.  Aborted "
 W !,"      cases are identified by an '*' next to the procedure name.",!
DATE D DATE^SROUTL(.SRSD,.SRED,.SRSOUT) G:SRSOUT END
 N SRINSTP S SRINST=$$INST^SROUTL0() G:SRINST="^" END S SRINSTP=$P(SRINST,U),SRINST=$S(SRINST["ALL DIVISIONS":SRINST,1:$P(SRINST,U,2))
SPEC W !!!,"Do you want to print the report for all Surgical Specialties ?  YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter RETURN to print this report for all surgical specialties, or 'NO' to",!,"select a specific specialty." G SPEC
 I "Nn"[SRYN D SP I SRSOUT G END
DEVICE K IOP,%ZIS,POP,IO("Q") S %ZIS="QM",%ZIS("A")="Print the Report on which Device: " W !!,"This report is designed to use a 132 column format.",! D ^%ZIS G:POP END
 I $D(IO("Q")) K IO("Q") S ZTDESC="REPORT OF CANCELLATIONS",ZTRTN="EN1^SROCAN",(ZTSAVE("SRSD"),ZTSAVE("SRED"),ZTSAVE("SRINST"),ZTSAVE("SRINSTP"),ZTSAVE("SRSP*"))="" D ^%ZTLOAD G END
EN1 G ^SROCAN0
 Q
SP W !! S SRSP=1 K DIC S DIC("S")="I '$P(^(0),""^"",3)",DIC=137.45,DIC(0)="QEAMZ",DIC("A")="Print the report for which Specialty ?  " D ^DIC I Y<0 S SRSOUT=1 Q
 S SRCT=+Y,SRSP(SRCT)=+Y
MORE ; ask for more surgical specialties
 K DIC S DIC("S")="I '$P(^(0),""^"",3)",DIC=137.45,DIC(0)="QEAMZ",DIC("A")="Select An Additional Specialty:  " D ^DIC I Y>0 S SRCT=+Y,SRSP(SRCT)=+Y G MORE
 Q
END I 'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME
 D ^SRSKILL,^%ZISC W @IOF
 Q

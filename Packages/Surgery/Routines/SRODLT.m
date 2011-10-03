SRODLT ;B'HAM ISC/MAM - REPORT OF DELAY TIME ; [ 04/05/00  2:37 PM ]
 ;;3.0; Surgery ;**77,94**;24 Jun 93
 S (SRDL,SRSP,SRSOUT)=0 K %DT W @IOF,!,"Report of Delay Time",!
DATE D DATE^SROUTL(.SRSD,.SRED,.SRSOUT) G:SRSOUT END
 N SRINSTP S SRINST=$$INST^SROUTL0() G:SRINST="^" END S SRINSTP=$P(SRINST,U),SRINST=$S(SRINST["ALL DIVISIONS":SRINST,1:$P(SRINST,U,2))
REAS W !!!,"Do you want to print the Report of Delay Time for all delay reasons ?  YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter RETURN to print this report for all delay reasons, or 'NO' to select",!,"a specific delay reason." G REAS
 I "Nn"[SRYN D DELAY I SRSOUT G END
SPEC W !!!,"Do you want to print the Report of Delayed Operations for all Surgical",!,"Specialties ?  YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter RETURN to print this report for all surgical specialties, or 'NO' to",!,"select a specific specialty." G SPEC
 S SRSS="" I "Nn"[SRYN D SP I SRSOUT G END
DEVICE W ! K %ZIS,IOP,IO("Q"),POP S %ZIS="Q",%ZIS("A")="Print the Report on which Device ?  " D ^%ZIS I POP S SRSOUT=1 G END
 I $D(IO("Q")) K IO("Q") S ZTRTN="SRODLT0",ZTDESC="Report of Delay Times",(ZTSAVE("SRSD"),ZTSAVE("SRED"),ZTSAVE("SRINST"),ZTSAVE("SRINSTP"),ZTSAVE("SRSP*"),ZTSAVE("SRDL*"))="" D ^%ZTLOAD G END
 G ^SRODLT0
 Q
END I $E(IOST)'="P",'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME
 D ^%ZISC W @IOF D ^SRSKILL K SRTN
 Q
SP W !! S SRSP=1 K DIC S DIC("S")="I '$P(^(0),""^"",3)",DIC=137.45,DIC(0)="QEAMZ",DIC("A")="Print the Report of Delay Times for which Specialty ?  " D ^DIC I Y<0 S SRSOUT=1 Q
 S SRCT=+Y,SRSP(SRCT)=+Y
MORE ; ask for more surgical specialties
 K DIC S DIC("S")="I '$P(^(0),""^"",3)",DIC=137.45,DIC(0)="QEAMZ",DIC("A")="Select An Additional Specialty:  " D ^DIC I Y>0 S SRCT=+Y,SRSP(SRCT)=+Y G MORE
 Q
DELAY W !! S SRDL=1 K DIC S DIC=132.4,DIC(0)="QEAMZ",DIC("A")="Print the report for which Delay Reason ?  " D ^DIC I Y<0 S SRSOUT=1 Q
 S SRCT=+Y,SRDL(SRCT)=+Y
ADD ; ask for additional delay reasons
 K DIC S DIC=132.4,DIC(0)="QEAMZ",DIC("A")="Select An Additional Delay Reason:  " D ^DIC I Y>0 S SRCT=+Y,SRDL(SRCT)=+Y G ADD
 Q

SRONOR ;B'HAM ISC/MAM - REPORT OF NON-O.R. PROCEDURES ; [ 09/22/98  11:35 AM ]
 ;;3.0; Surgery ;**77,50**;24 Jun 93
 S SRSOUT=0,SRINST=SRSITE("SITE")
 W @IOF,!,"Report of Non-OR Procedures",!
DATE D DATE^SROUTL(.SRSD,.SRED,.SRSOUT) G:SRSOUT END
SORT W @IOF,!,"How do you want the report sorted ? ",!!,"1. By Specialty",!,"2. By Provider",!,"3. By Location",!!,"Select Number:  1// " R X:DTIME I '$T!(X["^") S SRSOUT=1 G END
 S:X="" X=1 I X<1!(X>3) W !!,"Enter '1' to sort this report by specialty,  '2' to list ",!,"procedures sorted by provider, or '3' to list procedures sorted by location.",!!,"Press RETURN to continue  " R X:DTIME G SORT
 I X=1 G ^SRONOR1
 I X=3 G ^SRONOR6
ALL W @IOF,!,"Do you want to print the report for all Providers ?  YES// " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "Yy"[SRYN S SRSUR="ALL" G DEVICE
 I "Nn"'[SRYN W !!,"Enter RETURN to print the report for all providers, or 'NO'",!,"to select a specific provider.",!!,"Press RETURN to continue  " R X:DTIME G ALL
 W !! K DIC S DIC=200,DIC(0)="QEAMZ",DIC("A")="Print the Report for which Provider ?  " D ^DIC K DIC I Y<0 S SRSOUT=1 G END
 S SRSUR=+Y,SRSURG=$P(Y(0),"^")
DEVICE W ! K IOP,%ZIS,POP,IO("Q") S %ZIS="QM",%ZIS("A")="Print the report on which Device: " W !!,"This report is designed to use a 132 column format.",! D ^%ZIS I POP S SRSOUT=1 G END
 I $D(IO("Q")) K IO("Q") S ZTDESC="REPORT OF NON-O.R. PROCEDURES",ZTRTN="EN^SRONOR",(ZTSAVE("SRSD"),ZTSAVE("SRED"),ZTSAVE("SRINST"),ZTSAVE("SRSITE*"),ZTSAVE("SRSUR*"))="" D ^%ZTLOAD G END
EN ; entry when queued
 U IO N SRFRTO S Y=SRSD X ^DD("DD") S SRFRTO="FROM: "_Y_"  TO: ",Y=SRED X ^DD("DD") S SRFRTO=SRFRTO_Y
 S SRSD=SRSD-.0001,SRED=SRED+.9999
 I SRSUR="ALL" D ^SRONOR4 G END
 D ^SRONOR5
END W:$E(IOST)="P" @IOF I $D(ZTQUEUED) K ^TMP("SR",$J) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 I $E(IOST)'="P",'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME
 D ^%ZISC,^SRSKILL W @IOF
 Q

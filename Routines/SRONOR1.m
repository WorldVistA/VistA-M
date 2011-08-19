SRONOR1 ;B'HAM ISC/MAM - REPORT OF NON-O.R. PROCEDURES ; [ 07/27/98   2:33 PM ]
 ;;3.0; Surgery ;**50**;24 Jun 93
ALL W @IOF,!,"Do you want to print the report for all Specialties ?  YES// " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "Yy"[SRYN S SRSPEC="ALL" G DEVICE
 I "Nn"'[SRYN W !!,"Enter RETURN to print the report for all Specialties, or 'NO'",!,"to select a specific specialty.",!!,"Press RETURN to continue  " R X:DTIME G ALL
 W !! K DIC S DIC=723,DIC(0)="QEAMZ",DIC("A")="Print the Report for which Specialty ?  " D ^DIC K DIC I Y<0 S SRSOUT=1 G END
 S SRSPEC=+Y,SRSPECN=$P(Y(0),"^")
DEVICE W ! K IOP,%ZIS,POP,IO("Q") S %ZIS="QM",%ZIS("A")="Print on Device: " W !!,"This report is designed to use a 132 column format.",! D ^%ZIS I POP S SRSOUT=1 G END
 I $D(IO("Q")) K IO("Q") S ZTDESC="REPORT OF NON-O.R. PROCEDURES",ZTRTN="EN^SRONOR1",(ZTSAVE("SRSD"),ZTSAVE("SRED"),ZTSAVE("SRINST"),ZTSAVE("SRSPEC*"),ZTSAVE("SRSITE*"))="" D ^%ZTLOAD G END
EN ; entry when queued
 U IO N SRFRTO S Y=SRSD X ^DD("DD") S SRFRTO="FROM: "_Y_"  TO: ",Y=SRED X ^DD("DD") S SRFRTO=SRFRTO_Y
 S SRSD=SRSD-.0001,SRED=SRED+.9999
 I SRSPEC="ALL" D ^SRONOR2 G END
 D ^SRONOR3
END W:$E(IOST)="P" @IOF I $D(ZTQUEUED) K ^TMP("SR",$J) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 I 'SRSOUT,$E(IOST)'="P" W !!,"Press RETURN to continue  " R X:DTIME
 D ^%ZISC,^SRSKILL W @IOF
 Q

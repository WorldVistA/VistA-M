SROAR ;B'HAM ISC/MAM - ANNUAL REPORT OF SURGICAL PROCEDURES ; [ 09/22/98  11:28 AM ]
 ;;3.0; Surgery ;**77,50**;24 Jun 93
BEG S SRSOUT=0
 W @IOF,!,"Annual Report of Surgical Procedures"
DATE D DATE^SROUTL(.SDATE,.EDATE,.SRSOUT) G:SRSOUT END
ALL W !!,"Do you want to print the Annual Report of Surgical Procedures for all",!,"Surgical Specialties ?  YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter RETURN if you want to print the report for all specialties, or 'NO'",!,"to select a specific Surgical Specialty.",!!,"Press RETURN to continue  " R X:DTIME G ALL
 S SRSS="ALL" I "Nn"[SRYN W !! K DIC S DIC("S")="I '$P(^(0),""^"",3)",DIC=137.45,DIC(0)="QEAMZ",DIC("A")="Print the Annual Report for which Specialty ?  " D ^DIC S:Y<0 SRSOUT=1 G:Y<0 END S SRSS=+Y
 W !!,"This report is designed to use a 132 column format, and must be run",!,"on a printer.",!!
PTR K IOP,%ZIS,POP,IO("Q") S %ZIS("A")="Select Printer: ",%ZIS="QM" D ^%ZIS I POP S SRSOUT=1 G END
 I $E(IOST)'="P" W !!,"This report must be run on a printer.  Please select another device.",! D PRESS G:SRSOUT END D ^%ZISC W @IOF G PTR
 I $D(IO("Q")) K IO("Q") S ZTRTN="EN^SROAR",(ZTSAVE("SDATE"),ZTSAVE("EDATE"),ZTSAVE("SRSS"),ZTSAVE("SRSITE*"))="",ZTDESC="ANNUAL REPORT OF SURGICAL PROCEDURES" D ^%ZTLOAD G END
EN U IO N SRFRTO S Y=SDATE X ^DD("DD") S SRFRTO="FROM: "_Y_"  TO: ",Y=EDATE X ^DD("DD") S SRFRTO=SRFRTO_Y,Y=DT X ^DD("DD") S SRPRINT="DATE PRINTED: "_Y
 S SDATE1=SDATE-.0001,EDATE1=EDATE+.9999,SRINST=SRSITE("SITE"),SRHALT=0,SRSOUT=1 I SRSS="ALL" D ^SROAR1 G END
 D ^SROAR2
END W ! I 'SRSOUT,$E(IOST)'="P" W !!,"Press RETURN to continue  " R X:DTIME
 W:$E(IOST)="P" @IOF I $D(ZTQUEUED) K ^TMP("SR",$J) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 D ^%ZISC W @IOF K SRTN D ^SRSKILL
 Q
PRESS W ! K DIR  S DIR("A")="  Press RETURN to continue or '^' to quit. ",DIR(0)="FOA" D ^DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q

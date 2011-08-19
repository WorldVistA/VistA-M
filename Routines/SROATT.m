SROATT ;B'HAM ISC/MAM - ATTENDING SURGEON REPORT ; [ 09/22/98  11:30 AM ]
 ;;3.0; Surgery ;**77,50**;24 Jun 93
 S (SRB,SRSOUT)=0 W @IOF,!,"Attending Surgeon Report",!
DATE D DATE^SROUTL(.SRSD,.SRED,.SRSOUT) G:SRSOUT END
ATT W @IOF,!,"Do you want to print the report for all Attending Surgeons ?  YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 S SRYN=$E(SRYN) I SRYN="" S SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter RETURN to print the report for all attending surgeons, or 'NO' to select",!,"a specific person.",!!,"Press RETURN to continue  " R X:DTIME G ATT
 I "Nn"[SRYN G ^SROATT0
REPORT S SRBOTH=0 W @IOF,!,"Attending Surgeon Reports",!!,"1.  Attending Surgeon Report",!,"2.  Attending Surgeon Cumulative Report",!,"3.  Attending Surgeon Report and Attending Surgeon Cumulative Report"
 W !!!,"Select the number corresponding with the desired report(s):  " R X:DTIME I '$T!("^"[X) S SRSOUT=1 G END
 I X<1!(X>3)!(X'=(X\1)) D HELP W !!,"Press RETURN to continue  " R X:DTIME G REPORT
 S SRBOTH=X
BREAK I SRBOTH'=2 W ! K DIR S DIR("A")="Start report for each attending surgeon on a new page ? ",DIR("B")="NO",DIR(0)="YA" D ^DIR K DIR S:Y SRB=1 I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 G END
SPEC W @IOF,!,"Do you want the report for all Surgical Specialties ?  YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 S SRSS="",SRYN=$E(SRYN) I SRYN="" S SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter 'YES' to print this report for all Surgical Specialties, or 'NO' to ",!,"select a specific specialty.",!!,"Press RETURN to continue  " R X:DTIME G SPEC
 I "Nn"[SRYN D SP I SRSOUT G END
 I SRBOTH'=2 W !!,"The Attending Surgeon Report was designed to use a 132 column format."
 I SRBOTH=2 W !!,"The Attending Surgeon Cumulative Report was designed to use an 80 column format."
 W ! K IOP,POP,IO("Q"),%ZIS S %ZIS="QM",%ZIS("A")="Print the report on which Device ?  " D ^%ZIS I POP S SRSOUT=1 G END
 I $D(IO("Q")) K IO("Q") S ZTDESC="Attending Surgeon Report",ZTRTN="EN^SROATT",(ZTSAVE("SRB"),ZTSAVE("SRSD"),ZTSAVE("SRED"),ZTSAVE("SRSS"),ZTSAVE("SRSITE*"),ZTSAVE("SRBOTH"))="" D ^%ZTLOAD G END
EN ; entry when queued
 U IO S SRSOUT=0,SRINST=SRSITE("SITE"),SRINSTP=SRSITE("DIV"),Y=DT X ^DD("DD") S SRPRINT="DATE PRINTED: "_Y S Y=SRSD X ^DD("DD") S SRFRTO="FROM: "_Y_"  TO: ",Y=SRED X ^DD("DD") S SRFRTO=SRFRTO_Y
 I SRSS D ^SROATT1 G END
 D ^SROATT2
END I $E(IOST)'="P",'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME
 W:$E(IOST)="P" @IOF K ^TMP("SRTOT",$J),^TMP("SRTC",$J) I $D(ZTQUEUED) K ^TMP("SR",$J) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 D ^%ZISC K SRTN W @IOF D ^SRSKILL
 Q
SP ; select specialty
 W ! K DIC S DIC("S")="I '$P(^(0),""^"",3)",DIC=137.45,DIC(0)="QEAMZ",DIC("A")="Print the Report for which Surgical Specialty ?  " D ^DIC I Y<0 S SRSOUT=1
 S SRSS=+Y
 Q
HELP ; print help message
 I X<1!(X>3)!(X'=(X\1)) W !!,"Enter '1' if you want to print the Attending Surgeon Report only.  If you only want to print the Attending Surgeon Cumulative Report, enter '2'.  Enter '3' to",!,"print both reports."
 Q

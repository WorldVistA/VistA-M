SRODLAY ;B'HAM ISC/MAM - REPORT OF DELAYS ; [ 04/04/00  11:36 AM ]
 ;;3.0; Surgery ;**77,94**;24 Jun 93
 S SRSOUT=0 K %DT W @IOF,!,"Report of Delayed Operations",!
DATE D DATE^SROUTL(.SRSD,.SRED,.SRSOUT) G:SRSOUT END
 N SRINSTP S SRINST=$$INST^SROUTL0() G:SRINST="^" END S SRINSTP=$P(SRINST,U),SRINST=$S(SRINST["ALL DIVISIONS":SRINST,1:$P(SRINST,U,2))
SPEC W !!!,"Do you want to print the Report of Delayed Operations for all Surgical",!,"Specialties ?  YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter RETURN to print this report for all surgical specialties, or 'NO' to",!,"select a specific specialty." G SPEC
 S SRSS="" I "Nn"[SRYN D SP I SRSOUT G END
 W !!,"This report is designed to use a 132 column format."
 W ! K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("A")="Print the Report on which Device ?  " D ^%ZIS I POP S SRSOUT=1 G END
 I $D(IO("Q")) K IO("Q") S ZTRTN="EN^SRODLAY",ZTDESC="Report of Delayed Operations",(ZTSAVE("SRSD"),ZTSAVE("SRED"),ZTSAVE("SRINST"),ZTSAVE("SRINSTP"),ZTSAVE("SRSS"))="" D ^%ZTLOAD G END
EN ; entry when queued
 U IO N SRFRTO,SRPRNT S SRSOUT=1 K ^TMP("SR",$J)
 S Y=SRSD X ^DD("DD") S SRFRTO="FROM: "_Y_"  TO: ",Y=SRED X ^DD("DD") S SRFRTO=SRFRTO_Y,Y=DT X ^DD("DD") S SRPRNT="DATE PRINTED: "_Y
 I SRSS D ^SRODLA1 G END
 D ^SRODLA2
END I $E(IOST)'="P",'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME
 I $E(IOST)="P" W @IOF
 K ^TMP("SRF",$J),^TMP("SRT",$J) I $D(ZTQUEUED) K ^TMP("SR",$J) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 D ^%ZISC W @IOF D ^SRSKILL K SRTN
 Q
SP W !! K DIC S DIC("S")="I '$P(^(0),""^"",3)",DIC=137.45,DIC(0)="QEAMZ",DIC("A")="Print the Report of Delayed Operations for which Specialty ?  " D ^DIC I Y<0 S SRSOUT=1 Q
 S SRSS=+Y
 Q
PAGE I 'SRHDR S SRHDR=1 G HDR
 S X="" I $E(IOST)'="P" W !!,"Press RETURN to continue, or '^' to quit:  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 I X["?" W !!,"Enter RETURN to continue printing this report, or '^' to exit from this option." G PAGE
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 S PAGE=PAGE+1 I $Y W @IOF
 I $E(IOST)="P" W !,?(132-$L(SRINST)\2),SRINST,?120,"PAGE: "_PAGE,!,?58,"SURGICAL SERVICE",?100,"REVIEWED BY:",!,?52,"REPORT OF DELAYED OPERATIONS",?100,"DATE REVIEWED:"
 W:$D(SPEC) !,?(132-$L(SPEC)\2),SPEC W !,?(132-$L(SRFRTO)\2),SRFRTO I $E(IOST)="P" W ?100,SRPRNT
 W !!,"DATE",?12,"PATIENT",?44,"ATTENDING SURGEON",?84,"DELAY COMMENTS",!,"DELAY TIME",?14,"ID #",?44,"OPERATION(S)"
 W ! F LINE=1:1:132 W "="
 S SRHDR=1
 Q

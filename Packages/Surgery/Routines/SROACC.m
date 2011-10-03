SROACC ;B'HAM ISC/MAM - CPT ACCURACY ; [ 09/22/98  11:19 AM ]
 ;;3.0; Surgery ;**77,50,127**;24 Jun 93
BEG S (SRFLG,SRSOUT)=0
 W @IOF,!,"Report to Check CPT Coding Accuracy"
START D DATE^SROUTL(.SDATE,.EDATE,.SRSOUT) G:SRSOUT END
 S SDATE1=SDATE-.0001,EDATE1=EDATE+.9999
ASK W @IOF,!,"Print the Report of CPT Coding Accuracy for which cases ?",!!,"1. O.R. Surgical Procedures",!,"2. Non-O.R. Procedures",!,"3. Both O.R. Surgical Procedures and Non-O.R. Procedures (All Specialties)"
 W !!,"Select Number:  1// " R X:DTIME I '$T!(X["^") G END
 S:X="" X=1 I X>3!(X<1)!(X'?.N) D HELP G:SRSOUT END G ASK
 S SRFLG=X
ALL W !!,"Do you want to print the Report of CPT Coding Accuracy for all",!,"CPT Codes ?  YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter RETURN if you want to print the report for all codes, or 'NO'",!,"to select a specific CPT Code.",!!,"Press RETURN to continue  " R X:DTIME G ALL
 S SRCPT="ALL"
 I "Nn"[SRYN W !! K DIC S DIC=81,DIC(0)="QEAMZ",DIC("A")="Print the Coding Accuracy Report for which CPT Code ?  ",DIC("S")="I $$CTD^SROACC()" D ^DIC S:Y<0 SRSOUT=1 G:Y<0 END S SRCPT=+Y
 I SRFLG=1 G SPEC
 I SRFLG=2!(SRFLG=3) G MSP
DEV W !!,"This report is designed to use a 132 column format.",!!
 K IOP,%ZIS,POP,IO("Q") S %ZIS("A")="Select Device: ",%ZIS="QM" D ^%ZIS I POP S SRSOUT=1 G END
 I $D(IO("Q")) K IO("Q") S ZTRTN="EN^SROACC",(ZTSAVE("SDATE*"),ZTSAVE("EDATE*"),ZTSAVE("SRCPT"),ZTSAVE("SRFLG"),ZTSAVE("SRSITE*"))="",ZTDESC="REPORT TO CHECK CPT CODING ACCURACY" D ^%ZTLOAD G END
EN ; entry when queued
 K ^TMP("SR",$J) U IO S SRSOUT=0,SRPAGE=1,SRINST=SRSITE("SITE")
 N SRFRTO S Y=SDATE X ^DD("DD") S SRFRTO="FROM: "_Y_"  TO: " S Y=EDATE X ^DD("DD") S SRFRTO=SRFRTO_Y
 I SRCPT="ALL" D ^SROACC5 G END
 D ^SROACC6
END W:$E(IOST)="P" @IOF I $D(ZTQUEUED) K ^TMP("SR",$J) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 I 'SRSOUT,$E(IOST)'="P" W !!,"Press RETURN to continue  " R X:DTIME
 D ^%ZISC W @IOF K SRTN D ^SRSKILL
 Q
HELP W !!,"Enter '1' or press <RET> to include only OR surgical procedure cases on the",!,"report.  Enter '2' to include only non-OR procedure cases on the report."
 W !,"Enter '3' to include cases for both OR surgical procedures and non-OR",!,"procedures on the report."
 W !!,"Press <RET> to continue, or '^' to quit.  " R X:DTIME I '$T!(X["^") S SRSOUT=1
 Q
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 I SRHDR,$E(IOST)'="P" W !!,"Press RETURN to continue, or '^' to quit:  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 W:$Y @IOF W !,?(132-$L(SRINST)\2),SRINST,?126,"PAGE",!,?58,"SURGICAL SERVICE",?126,$J(SRPAGE,4),!,?51,"REPORT OF CPT CODING ACCURACY",?100,"REVIEWED BY:"
 W !,?(132-$L(SRFRTO)\2),SRFRTO,?100,"DATE REVIEWED:"
 W !,$S(SRFLG=1:"O.R. SURGICAL PROCEDURES",SRFLG=2:"NON-O.R. PROCEDURES",1:"O.R. SURGICAL PROCEDURES AND NON-O.R. PROCEDURES")
 W !!,?1,"PROCEDURE DATE",?20,"PATIENT",?60,"PROCEDURES",?111,"SURGEON/PROVIDER",!,?3,"CASE #",?22,"ID#",?111,"ATTEND SURG/PROV",!,?20,"SPECIALTY"
 S SRHDR=1,SRPAGE=SRPAGE+1 Q
SPEC W @IOF,!,"Do you want to sort the Report of CPT Coding Accuracy by",!,"Surgical Specialty ?  YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter RETURN if you want to sort the report by specialty, or 'NO'",!,"to sort the report by date only.",!!,"Press RETURN to continue  " R X:DTIME G SPEC
 I "Yy"[SRYN G SPEC^SROACC0
 G DEV
MSP W @IOF,!,"Do you want to sort the Report of CPT Coding Accuracy by",!,$S(SRFLG=2:"Medical",1:"Medical/Surgical")," Specialty ?  YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter RETURN if you want to sort the report by specialty, or 'NO'",!,"to sort the report by date only.",!!,"Press RETURN to continue  " R X:DTIME G MSP
 I "Yy"[SRYN G MSP^SROACC0
 G DEV
 Q
CTD() K ICPTVDT
 N SRSDATE S SROK=1,SRSDATE=DT
 I (EDATE) S SRSDATE=EDATE
 S SROK=$P($$CPT^ICPTCOD(Y,SRSDATE),"^",7),ICPTVDT=SRSDATE
 Q SROK

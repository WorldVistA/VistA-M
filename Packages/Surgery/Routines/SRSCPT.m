SRSCPT ;B'HAM ISC/MAM - CASES MISSING CPT CODES ; [ 09/22/98  11:36 AM ]
 ;;3.0; Surgery ;**77,50**;24 Jun 93
 S (SRFLG,SRSOUT)=0,SRSPEC=""
ASK W @IOF,!,"Print list of Completed Cases Missing CPT Codes for",!!,"1. O.R. Surgical Procedures",!,"2. Non-O.R. Procedures",!,"3. Both O.R. Surgical Procedures and Non-O.R. Procedures (All Specialties)"
 W !!,"Select Number:  1// " R X:DTIME I '$T!(X["^") G END
 S:X="" X=1 I X>3!(X<1)!(X'?.N) D HELP G:SRSOUT END G ASK
 S SRFLG=X I SRFLG=1 D SPEC G:SRSOUT END
 I SRFLG=2 D MSP G:SRSOUT END
DATE D DATE^SROUTL(.SDATE,.EDATE,.SRSOUT) G:SRSOUT END
 S SRINST=SRSITE("SITE")
 W ! K %ZIS,IOP,IO("Q"),POP S %ZIS("A")="Print the List of Cases Missing CPT codes to which Printer ? ",%ZIS="Q" D ^%ZIS I POP S SRSOUT=1 G END
 I $D(IO("Q")) K IO("Q") S ZTDESC="CASES MISSING CPT CODES",(ZTSAVE("EDATE"),ZTSAVE("SDATE"),ZTSAVE("SRINST"),ZTSAVE("SRSPEC*"),ZTSAVE("SRFLG"),ZTSAVE("SRSITE*"))="",ZTRTN="EN^SRSCPT" D ^%ZTLOAD S SRSOUT=1 G END
EN U IO N SRFRTO S Y=SDATE X ^DD("DD") S SRFRTO="From: "_Y_"  To: ",Y=EDATE X ^DD("DD") S SRFRTO=SRFRTO_Y
 K ^TMP("SR",$J) S SRSDT=SDATE-.0001,SRSEDT=EDATE+.9999
 I SRSPEC D ^SRSCPT1 G END
 D ^SRSCPT2
END W:$E(IOST)="P" @IOF I $D(ZTQUEUED) K ^TMP("SR",$J) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 I 'SRSOUT,$E(IOST)'="P" W !!,"Press RETURN to continue  " R X:DTIME
 D ^%ZISC K SRTN D ^SRSKILL W @IOF
 Q
HELP W !!,"Enter '1' or press <RET> to print the list for surgical procedures performed",!,"in the OR.  Enter '2' to print the list for non-OR procedures.  Enter '3' to"
 W !,"print the list for both OR surgical procedures and non-OR procedures."
 W !!,"Press <RET> to continue, or '^' to quit. " R X:DTIME I '$T!(X["^") S SRSOUT=1
 Q
SPEC W @IOF,!,"Do you want the list for all Surgical Specialties ?  YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 Q
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter RETURN if you would like to list completed cases missing CPT codes for",!,"all Surgical Specialties, or 'NO' to select a specific specialty.",!!,"Press RETURN to continue  " R X:DTIME G SPEC
 I "Yy"'[SRYN W ! K DIC S DIC=137.45,DIC(0)="QEAMZ",DIC("A")="Select Surgical Specialty: ",DIC("S")="I '$P(^(0),""^"",3)" D ^DIC K DIC S:Y<0 SRSOUT=1 Q:Y<0  S SRSPEC=+Y,SRSPECN=$P(Y(0),"^")
 Q
MSP W @IOF,!,"Do you want the list for all Specialties ?  YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 Q
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter RETURN if you would like to list completed cases missing CPT codes for",!,"all Specialties, or 'NO' to select a specific specialty.",!!,"Press RETURN to continue  " R X:DTIME G SPEC
 I "Yy"'[SRYN W ! K DIC S DIC=723,DIC(0)="QEAMZ",DIC("A")="Select Specialty: " D ^DIC K DIC S:Y<0 SRSOUT=1 Q:Y<0  S SRSPEC=+Y,SRSPECN=$P(Y(0),"^")
 Q

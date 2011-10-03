SRONUR ;B'HAM ISC/MAM - NURSE STAFF REPORT ; [ 07/27/98   2:33 PM ]
 ;;3.0; Surgery ;**50**;24 Jun 93
 S SRINST=SRSITE("SITE")
ALL S SRSOUT=0 W @IOF,"Surgical Nurse Staffing Report",!!,"Do you want the report for all nurses ?  YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter RETURN to print the Surgical Nurse Staffing Report for all nurses, or ",!,"'NO' to select a specific person.",!!,"Press RETURN to continue  " R X:DTIME G ALL
 I "Yy"[SRYN D ^SRONUR1 G END
 W ! K DIC S DIC=200,DIC(0)="QEAMZ",DIC("A")="Print the Nurse Staffing Report for which Nurse ?  " D ^DIC I Y<0 S SRSOUT=1 G END
 S SRONUR=+Y,SRONUR("NAME")=$P(Y(0),"^")
 D ^SRONUR2
END W ! S:$E(IOST)="P" SRSOUT=1 I 'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME
 D ^%ZISC K SRTN D ^SRSKILL W @IOF
 Q

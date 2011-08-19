SROPREQ ;BIR/MAM - OPERATION REQUESTS FOR A DAY ; [ 12/09/99  11:54 AM ]
 ;;3.0; Surgery ;**77,92**;24 Jun 93
 W @IOF,! S SRSOUT=0 K %DT S %DT("A")="Print Requests for which date ? ",%DT="AEFX" D ^%DT I Y<0 S SRSOUT=1 G END
 S SRSDATE=Y
ASK R !!,"Would you like the long or short form ?  SHORT// ",TYPE:DTIME S:'$T TYPE="^" I TYPE["^" S SRSOUT=1 G END
 S:TYPE="" TYPE="S" S TYPE=$E(TYPE) I "SsLl"'[TYPE W !!,"Enter RETURN to view requests in a short form, or 'LONG' to see more detailed",!,"information on each request.",! G ASK
 I "Ll"[TYPE G ^SROREQ
SPEC W @IOF,!,"Do you want the requests for all surgical specialties ?  YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 S SRYN=$E(SRYN) I SRYN="" S SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter 'YES' to print the requests for all surgical specialties, or 'NO'",!,"to select a specific specialty.",!!,"Press RETURN to continue  " R X:DTIME G SPEC
 I "Nn"[SRYN G ^SROREQ3
 W ! K IOP,%ZIS,POP,IO("Q") S %ZIS("A")="Print the Report on which Device: ",%ZIS="Q" D ^%ZIS G:POP END
 I $D(IO("Q")) K IO("Q") S ZTDESC="REQUEST FOR A DAY - SHORT FORM",ZTRTN="BEG^SROREQ4",ZTSAVE("SRSDATE")=SRSDATE,ZTSAVE("SRSITE*")="" D ^%ZTLOAD G END
 G BEG^SROREQ4
END K SRPRINT I $E(IOST)="P" S SRSOUT=1,SRPRINT=1
 I 'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME
 W @IOF D ^%ZISC K SRTN I $D(SRPRINT) W @IOF
 D ^SRSKILL
 Q

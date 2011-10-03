SROREQ ;BIR/MAM - REQUEST FOR A DAY (LONG FORM) ; [ 12/09/99  11:54 AM ]
 ;;3.0; Surgery ;**92**;24 Jun 93
SPEC W @IOF,!,"Do you want the requests for all surgical specialties ?  YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 S SRYN=$E(SRYN) I SRYN="" S SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter 'YES' to print the requests for all surgical specialties, or 'NO'",!,"to select a specific specialty.",!!,"Press RETURN to continue  " R X:DTIME G SPEC
 I "Yy"[SRYN S (SRSS,SRSNM)="ALL" G ZIS
 W ! K DIC S DIC("S")="I '$P(^(0),""^"",3)",DIC=137.45,DIC(0)="QEAMZ",DIC("A")="Print Requests for which Surgical Specialty ?  " D ^DIC I Y<0 S SRSOUT=1 G END
 S SRSS=+Y,SRSNM=$P(Y(0),"^")
ZIS W ! K IOP,%ZIS,POP,IO("Q") S %ZIS="Q",%ZIS("A")="Print the Requests on which Device: " D ^%ZIS I POP S SRSOUT=1 G END
 I $D(IO("Q")) K IO("Q") S ZTDESC="OPERATION REQUESTS",(ZTSAVE("SRSS"),ZTSAVE("SRSNM"),ZTSAVE("SRSDATE"),ZTSAVE("SRSITE*"))="",ZTRTN=$S(SRSS="ALL":"BEG^SROREQ1",1:"BEG^SROREQ2") D ^%ZTLOAD G END
 I SRSS="ALL" G ^SROREQ1
 G BEG^SROREQ2
END W ! D ^%ZISC W @IOF K SRTN D ^SRSKILL
 Q
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 W:$Y @IOF W ! F LINE=1:1:80 W "="
 W !,"OPERATION REQUESTS FOR "_SRSNM,!,"ON "_SRSDT S SRHDR=1
 Q

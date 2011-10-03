SROALESS ;BIR/ADM-List of Assessments Missing Information ; [ 01/11/95  3:21 PM ]
 ;;3.0; Surgery ;**38**;24 Jun 93
 S (SRSOUT,SRT)=0,SRP=1,X=$$SITE^SROVAR,SRINST=$P(X,"^",2),SRSTATN=+$P(X,"^",3)
START G:SRSOUT END W @IOF,!,"Report of Monthly Case Workload Totals",!!,"This option provides a report of the monthly risk assessment surgical case",!,"workload totals for the following categories:",!
 W ?5,"1. All cases performed",!,?5,"2. Excluded cases",!,?5,"3. Assessed cases",!,?5,"4. Non-assessed cases",!,?5,"5. Cardiac cases",!,?5,"6. Non-cardiac cases",!,?5,"7. Assessed cases per day (based on 20 days/month)"
 W !!,"This report may be printed and/or transmitted to the national database."
DATE S X=+$E(DT,4,5) S:X'=1 Z=X-1 S:X=1 Z=12 D MONTH S X=$E(DT,1,3) S:Z=12 X=X-1 S SRY=X+1700,SRD=X_Z_"00"
 W !! K DIR S DIR("A")="Compile workload totals for which month and year? ",DIR(0)="DA",DIR("B")=SRM_" "_SRY,DIR("?",1)="Enter the month and year for which to run this report,"
 S DIR("?")="for example, 'MAY 94', 'MAY 1994', '5/94' or '5 94'." D ^DIR I $D(DTOUT)!$D(DUOUT)!'Y S SRSOUT=1 G END
 S SRDT=Y D  G:SRSOUT END G:'$D(SRDT) DATE S SRDT=$E(SRDT,1,5)_"00"
 .Q:SRDT=SRD  S SRY=$E(Y,1,3)+1700,Z=+$E(Y,4,5) D MONTH
 .W !! K DIR S DIR("A")="Compile totals for "_SRM_" "_SRY,DIR(0)="Y",DIR("B")="YES" D ^DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 .I 'Y K SRDT
TRAN W !! K DIR S DIR("A")="Do you want this report to be transmitted to the central database",DIR("B")="NO",DIR("?",1)="Enter YES to have this report automatically transmitted to the central"
 S DIR("?")="database.  Enter NO if you do NOT want this report transmitted.",DIR(0)="Y" D ^DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 G END
 I 'Y G IO
PRT S SRT=1,SRP=0 W !! K DIR S DIR("A")="Do you also want to print this report",DIR("B")="YES",DIR("?",1)="Enter NO if you want to have this report transmitted, but do not want to"
 S DIR("?",2)="have it printed.  Enter YES if you do want to print the report as well as",DIR("?")="have it transmitted.",DIR(0)="Y" D ^DIR S:Y SRP=1 I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 G END
 I 'SRP G QUE
IO W ! K %ZIS,IO("Q"),POP S %ZIS("A")="Print report on which Device: ",%ZIS="Q" D ^%ZIS I POP S SRSOUT=1 G END
 I $D(IO("Q")) K IO("Q") S ZTDESC="Report of Surgical Case Workload",(ZTSAVE("SRDT"),ZTSAVE("SRP"),ZTSAVE("SRT"),ZTSAVE("SRINST"),ZTSAVE("SRSTATN"))="",ZTRTN="RUN^SROAWL" D ^%ZTLOAD S SRSOUT=1 G END
RUN ; entry point when queued
 D ^SROAWL1
END I 'SRSOUT,$E(IOST)="C" W !! K DIR S DIR(0)="FOA",DIR("A")="Press RETURN to continue" D ^DIR
 W:$E(IOST)="P" @IOF I $D(ZTQUEUED) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 D ^%ZISC K SRTN W @IOF D ^SRSKILL
 Q
MONTH ; get name of month
 S SRM=$S(Z=2:"FEB",Z=3:"MAR",Z=4:"APR",Z=5:"MAY",Z=6:"JUN",Z=7:"JUL",Z=8:"AUG",Z=9:"SEP",Z=10:"OCT",Z=11:"NOV",Z=12:"DEC",1:"JAN")
 Q
QUE ; queue transmission of report to national database
 W ! K %DT S %DT("A")="Queue report to run at what date/time? ",%DT(0)="NOW",%DT("B")="NOW",%DT="AEFXT" D ^%DT I 'Y S SRSOUT=1 G END
 S ZTDTH=Y,ZTIO="",ZTDESC="Report of Surgical Case Workload",(ZTSAVE("SRDT"),ZTSAVE("SRP"),ZTSAVE("SRT"),ZTSAVE("SRINST"),ZTSAVE("SRSTATN"))="",ZTRTN="RUN^SROAWL" D ^%ZTLOAD G END
 Q

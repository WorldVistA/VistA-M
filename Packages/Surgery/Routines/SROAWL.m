SROAWL ;BIR/ADM - REPORT OF MONTHLY CASE WORKLOAD TOTALS ;02/12/07
 ;;3.0; Surgery ;**38,47,50,86,141,153,160**;24 Jun 93;Build 7
 N SRINSTP,SRSEL S (SRSOUT,SRT)=0,SRP=1,SRINST=SRSITE("SITE"),SRINSTP=SRSITE("DIV")
START G:SRSOUT END W @IOF,!,"Report of Monthly Case Workload Totals",!!
 K DIR S DIR("A",1)="Print which report?",DIR("A",2)="",DIR("A",3)="1. Report for Single Month"
 S DIR("A",4)="2. Report for Range of Months",DIR("A",5)="",DIR("A")="Select Number (1 or 2): ",DIR("B")="1"
 S DIR(0)="NA^1:2:0" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 G END
 S SRSEL=Y I SRSEL=2 D TWO Q
 W @IOF,"This option provides a report of the monthly risk assessment surgical case",!,"workload totals which include the following categories:",!
 W ?5,"1. All cases performed",!,?5,"2. Eligible cases",!,?5,"3. Eligible cases meeting exclusion criteria"
 W !,?5,"4. Assessed cases",!,?5,"5. Not logged eligible cases"
 W !,?5,"6. Cardiac cases",!,?5,"7. Non-cardiac cases",!,?5,"8. Assessed cases per day (based on 20 days/month)"
 W !!,"The second part of this report provides the total number of incomplete",!,"assessments remaining for the month selected and the prior 12 months."
DATE D GETDT W ! K DIR S DIR("A")="Compile workload totals for which month and year? ",DIR(0)="DA^::MX",DIR("B")=SRM_" "_SRY,DIR("?",1)="Enter the month and year for which to run this report,"
 S DIR("?")="for example, 'MAY 94', 'MAY 1994', '5/94' or '5 94'." D ^DIR I $D(DTOUT)!$D(DUOUT)!'Y S SRSOUT=1 G END
 S SRDT=Y D  G:SRSOUT END G:'$D(SRDT) DATE S SRDT=$E(SRDT,1,5)_"00"
 .Q:SRDT=SRD  S SRY=$E(Y,1,3)+1700,Z=+$E(Y,4,5) D MONTH
 .W !! K DIR S DIR("A")="Compile totals for "_SRM_" "_SRY,DIR(0)="Y",DIR("B")="YES" D ^DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 .I 'Y K SRDT
DIV S (SRCNT,X)=0 F  S X=$O(^SRO(133,X)) Q:'X  I '$P(^SRO(133,X,0),"^",21) S SRCNT=SRCNT+1
 I SRCNT=1,SRSEL=1 G TRAN
 S SRINST=$$INST^SROUTL0() G:SRINST="^" END S SRINSTP=$P(SRINST,"^"),SRINST=$S(SRINST["ALL DIVISIONS":SRINST,1:$P(SRINST,"^",2))
 I SRINST'["ALL DIVISIONS"!(SRSEL=2) G IO
TRAN W ! K DIR S DIR("A",1)="This report may be printed and/or transmitted to the national database.",DIR("A",2)=""
 S DIR("A")="Do you want this report to be transmitted to the central database",DIR("B")="NO",DIR("?",1)="Enter YES to have this report automatically transmitted to the central"
 S DIR("?")="database.  Enter NO if you do NOT want this report transmitted.",DIR(0)="Y" D ^DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 G END
 I 'Y G IO
PRT S SRT=1,SRP=0 W ! K DIR S DIR("A")="Do you also want to print this report",DIR("B")="YES",DIR("?",1)="Enter NO if you want to have this report transmitted, but do not want to"
 S DIR("?",2)="have it printed.  Enter YES if you do want to print the report as well as",DIR("?")="have it transmitted.",DIR(0)="Y" D ^DIR S:Y SRP=1 I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 G END
 I 'SRP G QUE
IO W ! K %ZIS,IO("Q"),POP S %ZIS("A")="Print report on which Device: ",%ZIS="Q" D ^%ZIS I POP S SRSOUT=1 G END
 I $D(IO("Q")) K IO("Q") S ZTDESC="Report of Surgical Case Workload" D  S ZTRTN="RUN^SROAWL" D ^%ZTLOAD S SRSOUT=1 G END
 .S (ZTSAVE("SRDT"),ZTSAVE("SRP"),ZTSAVE("SRT"),ZTSAVE("SRINST"),ZTSAVE("SRINSTP"),ZTSAVE("SRSEL"))=""
 .I SRSEL=2 S ZTSAVE("SREDT")=""
RUN ; entry point when queued
 D ^SROAWL1
END I 'SRSOUT,$E(IOST)="C" W ! K DIR S DIR(0)="FOA",DIR("A")="Press RETURN to continue" D ^DIR
 W:$E(IOST)="P" @IOF K ^TMP("SRM",$J) I $D(ZTQUEUED) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 D ^%ZISC K SRTN W @IOF D ^SRSKILL
 Q
TWO S X=$E(DT,1,3)-1,SRD=X_"1000",SRY=X+1700,SRM="OCT "_SRY
 W ! K DIR S DIR("A")="Start with which month and year? "
 S DIR(0)="DA^::EMX",DIR("B")=SRM,DIR("?",1)="Enter the starting month and year for this report, for example,"
 S DIR("?")="'OCT 2005', 'OCT 05', '10/05' or '10 05'." D ^DIR I $D(DTOUT)!$D(DUOUT)!'Y S SRSOUT=1 G END
 S SRDT=Y D GETDT
DT2 W ! K DIR S DIR("A")="End with which month and year? ",DIR(0)="DA^::EMX",DIR("B")=SRM_" "_SRY
 S DIR("?",1)="Enter the ending month and year for this report, for example,"
 S DIR("?")="'OCT 2005', 'OCT 05', '10/05' or '10 05'." D ^DIR I $D(DTOUT)!$D(DUOUT)!'Y S SRSOUT=1 G END
 S SREDT=Y G:'$G(SREDT) DT2 S SREDT=$E(SREDT,1,5)_"00"
 I SREDT<SRDT W !!,"Ending date must not be earlier than starting date!" K SREDT G TWO
 G DIV
 Q
GETDT S X=+$E(DT,4,5) S:X'=1 Z=X-1 S:X=1 Z=12 D MONTH S X=$E(DT,1,3) S:Z=12 X=X-1 S Z=$S($L(Z)=1:"0"_Z,1:Z) S SRY=X+1700,SRD=X_Z_"00"
 Q
MONTH ; get name of month
 S SRM=$S(Z=2:"FEB",Z=3:"MAR",Z=4:"APR",Z=5:"MAY",Z=6:"JUN",Z=7:"JUL",Z=8:"AUG",Z=9:"SEP",Z=10:"OCT",Z=11:"NOV",Z=12:"DEC",1:"JAN")
 Q
QUE ; queue transmission of report to national database
 W ! K %DT S %DT("A")="Queue report to run at what date/time? ",%DT(0)="NOW",%DT("B")="NOW",%DT="AEFXT" D ^%DT I 'Y S SRSOUT=1 G END
 S ZTDTH=Y,ZTIO="",ZTDESC="Report of Surgical Case Workload",(ZTSAVE("SRDT"),ZTSAVE("SRP"),ZTSAVE("SRT"),ZTSAVE("SRINST"),ZTSAVE("SRINSTP"),ZTSAVE("SRSTATN"),ZTSAVE("SRSEL"))="",ZTRTN="RUN^SROAWL" D ^%ZTLOAD G END
 Q
TASK ; automatic transmission of workload report called by nightly process
 D NOW^%DTC Q:+%I(2)<26  S SRDAY=+%I(2),SRNOW=$E(%,1,12) D GETDT S SRDT=SRD
 S SRS=$O(^SRO(133,0)) Q:'SRS  S SRL=$P(^SRO(133,SRS,0),"^",13) I SRL=SRD G STOP
 S SRP=0,SRT=1,X=$$SITE^SROVAR,SRINST=$P(X,"^",2),SRINSTP="ALL DIVISIONS",SRSEL=1
 D ^SROAWL1 S SRS=$O(^SRO(133,0)),$P(^SRO(133,SRS,0),"^",13)=SRDT
STOP D ^SRSKILL K SRTN
 Q

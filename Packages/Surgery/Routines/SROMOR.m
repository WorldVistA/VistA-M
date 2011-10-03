SROMOR ;B'HAM ISC/MAM - MORTALITY REPORT ; [ 09/22/98  11:33 AM ]
 ;;3.0; Surgery ;**38,77,50**;24 Jun 93
EN ; entry point
 N SRINSTP
 W @IOF,!,"The Morbidity and Mortality Reports include the Perioperative Occurrences",!,"Report and the Mortality Report.  Each report will provide information",!,"from cases completed within the date range selected."
REPORT ; select report
 K DIR W !! S DIR(0)="YO",DIR("A")="Do you want to generate both reports",DIR("B")="YES",DIR("?")="Enter '1' to print the Perioperative Occurrences Report, or '2' to print the Mortality Report" D ^DIR S SRYN=$G(Y(0))
 I SRYN="" G END
 S:SRYN="YES" SRBOTH=1
SEL I SRYN="NO" W @IOF,!,"1. Perioperative Occurrences Report",!,"2. Mortality Report",!! D  I SRBOTH="" G END
 .K DIR S DIR(0)="NO^1:2",DIR("A")="Select Number",DIR("?")="Enter '1' to print the Perioperative Occurrences Report, or '2' to print the Mortality Report" D ^DIR S SRBOTH=$S(+Y=1:"C",+Y=2:"M",1:"")
DATE D DATE^SROUTL(.SRSD,.SRED,.SRQ) G:SRQ END
 S SRINST=$$INST^SROUTL0() G:SRINST="^" END S SRINSTP=$P(SRINST,U),SRINST=$S(SRINST["ALL DIVISIONS":SRINST,1:$P(SRINST,U,2))
 I SRBOTH'="M" D ^SROCMP1 Q
 I SRBOTH="M" D ZIS
END W @IOF D ^SRSKILL
 Q
ZIS W ! K IOP,%ZIS,IO("Q"),POP S %ZIS="QM",%ZIS("A")="Print the Report on which Device: " W !!,"This report is designed to use a 132 column format.",! D ^%ZIS I POP Q
 I $D(IO("Q")) K IO("Q") S ZTDESC="MORTALITY REPORT",ZTRTN="BEG^SROMORT",(ZTSAVE("SRINST"),ZTSAVE("SRINSTP"),ZTSAVE("SRED"),ZTSAVE("SRSD"))="" D ^%ZTLOAD Q
 D BEG^SROMORT Q

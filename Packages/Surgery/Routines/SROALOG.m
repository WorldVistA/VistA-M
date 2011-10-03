SROALOG ;BIR/MAM - ASSESSMENT LOG ;01/24/08
 ;;3.0; Surgery ;**38,55,62,77,50,153,160,166**;24 Jun 93;Build 6
 K SRMNA S (SRSOUT,SRFLG,SRSP,SRAST)=0,SRSRT=1
START G:SRSOUT END W @IOF K DIR S DIR("A",1)="List of Surgery Risk Assessments",DIR("A",2)="",DIR("A",3)="  1. List of Incomplete Assessments"
 S DIR("A",4)="  2. List of Completed Assessments",DIR("A",5)="  3. List of Transmitted Assessments"
 S DIR("A",6)="  4. List of Non-Assessed Major Surgical Cases",DIR("A",7)="  5. List of All Major Surgical Cases"
 S DIR("A",8)="  6. List of All Surgical Cases",DIR("A",9)="  7. List of Completed/Transmitted Assessments Missing Information"
 S DIR("A",10)="  8. List of 1-Liner Cases Missing Information",DIR("A",11)="  9. List of Eligible Cases"
 S DIR("A",12)=" 10. List of Cases With No CPT Codes",DIR("A",13)=" 11. Summary List of Assessed Cases"
 S DIR("A",14)="",DIR("A")="Select the Number of the Report Desired"
 S DIR(0)="NO^1:11" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT)!'Y S SRSOUT=1 G END
 S SREPORT=X
DATE I SREPORT=3 D DSORT G:SRSOUT END
 D DATE^SROUTL(.SRSD,.SRED,.SRSOUT) G:SRSOUT END
 I SREPORT=9 D TYPE9 I SRSOUT G END
 I SREPORT=3 D TYPE3 I SRSOUT G END
 D SEL G:SRSOUT END
 N SRINSTP S SRINST=$$INST^SROUTL0() G:SRINST="^" END S SRINSTP=$P(SRINST,"^"),SRINST=$S(SRINST["ALL DIVISIONS":SRINST,1:$P(SRINST,"^",2))
 I SREPORT<7 W @IOF,!,"This report is designed to print to your terminal screen or a printer. When",!,"using a printer, a 132 column format is used.",!
 K IOP,%ZIS,POP,IO("Q") S %ZIS("A")="Print the List of Assessments to which Device: ",%ZIS="QM" D ^%ZIS I POP S SRSOUT=1 G END
 I $D(IO("Q")) K IO("Q") D  S ZTREQ="@" D ^%ZTLOAD G END
 .S ZTRTN="EN^SROALOG",ZTDESC="List of Surgery Risk Assessments"
 .S (ZTSAVE("SRSD"),ZTSAVE("SRED"),ZTSAVE("SREPORT"),ZTSAVE("SRASP"),ZTSAVE("SRFLG"),ZTSAVE("SRSP"),ZTSAVE("SRINSTP"),ZTSAVE("SRAST"),ZTSAVE("SRSRT"))=""
EN ; entry when queued
 N SRFRTO S Y=SRSD X ^DD("DD") S SRFRTO="FROM: "_Y_"  TO: ",Y=SRED X ^DD("DD") S SRFRTO=SRFRTO_Y
 U IO S SRSD=SRSD-.0001,SRED=SRED_".9999",Y=DT X ^DD("DD") S SRPRINT="DATE PRINTED: "_Y
 S SRINST=$S(SRINSTP["ALL DIV":$P($$SITE^SROVAR,"^",2)_" - ALL DIVISIONS",1:$$GET1^DIQ(4,SRINSTP,.01))
 I SREPORT=1 D:SRSP ^SROANTS D:'SRSP ^SROANT G END
 I SREPORT=2 D:SRSP ^SROALCS D:'SRSP ^SROALC G END
 I SREPORT=3 D:SRSP ^SROALTS D:'SRSP ^SROALT G END
 I SREPORT=4 S SRMNA=1 D:SRSP ^SROALLS D:'SRSP ^SROALL G END
 I SREPORT=5 D:SRSP ^SROALLS D:'SRSP ^SROALL G END
 I SREPORT=7 D ^SROALM G END
 I SREPORT=8 D ^SROALMN G END
 I SREPORT=9 D ^SROALEC G END
 I SREPORT=10 D ^SROALNC G END
 I SREPORT=11 D ^SROALSL G END
 D:SRSP ^SROALSS D:'SRSP ^SROALST
END I 'SRSOUT,$E(IOST)'="P" W !!,"Press ENTER to continue  " R X:DTIME
 W:$E(IOST)="P" @IOF K ^TMP("SRA",$J) I $D(ZTQUEUED) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 D ^%ZISC K SRTN,SRAST,SRSRT W @IOF D ^SRSKILL
 Q
TYPE3 ; select type of eligible cases
 W ! K DIR S DIR("A",1)="Print which Transmitted Cases ?",DIR("A",2)="",DIR("A",3)="   1. Assessed Cases Only"
 S DIR("A",4)="   2. Excluded Cases Only",DIR("A",5)="   3. Both Assessed and Excluded",DIR("A",6)=""
 S DIR("A")="Select Number",DIR("B")=1,DIR(0)="N^1:3" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 S SRAST=Y
 Q
TYPE9 ; select type of transmitted case
 W ! K DIR S DIR("A",1)="Print which Eligible Cases ?",DIR("A",2)="",DIR("A",3)="   1. Assessed Cases Only"
 S DIR("A",4)="   2. Excluded Cases Only",DIR("A",5)="   3. Non-Assessed Cases only",DIR("A",6)="   4. All Cases",DIR("A",7)=""
 S DIR("A")="Select Number",DIR("B")=1,DIR(0)="N^1:4" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 S SRAST=Y
 Q
DSORT ; sort by op date or transmit date
 W ! K DIR S DIR("A",1)="Print by Date of Operation or by Date of Transmission ?",DIR("A",2)="",DIR("A",3)="   1. Date of Operation"
 S DIR("A",4)="   2. Date of Transmission",DIR("A",5)="",DIR("A")="Select Number",DIR("B")=1,DIR(0)="N^1:2"
 D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 S SRSRT=Y
 Q
SEL ; select specialty
 W ! K DIR S DIR(0)="YA",DIR("A")="Print by Surgical Specialty ?  ",DIR("B")="YES"
 S DIR("?",1)="Enter YES to print the report by surgical specialty, or NO to print",DIR("?")="the report listing all surgical cases."
 D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 Q:'Y
SEL1 S SRSP=1 W ! K DIR S DIR(0)="YA",DIR("A")="Print report for ALL specialties ?  ",DIR("B")="YES"
 S DIR("?",1)="Enter YES to print the report for all surgical specialties, or NO to",DIR("?")="print the report for a specific surgical specialty."
 D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 I 'Y W ! S DIC("S")="I '$P(^(0),""^"",3)",DIC("A")="Print the Report for which Surgical Specialty: ",DIC=137.45,DIC(0)="QEAMZ" D ^DIC K DIC I Y>0 S SRASP=+Y,SRFLG=1 Q
 I Y'>0 S SRSOUT=1 Q
 Q

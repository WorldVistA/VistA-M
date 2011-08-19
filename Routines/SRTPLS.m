SRTPLS ;BIR/SJA - LIST ASSESSMENTS ;04/11/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 S (SRSOUT,SRFLG,SRSP,SRAST)=0,SRSRT=1
DATE D DATE^SROUTL(.SRSD,.SRED,.SRSOUT) G:SRSOUT END
 D STATUS G:SRSOUT END D TYPE G:SRSOUT END
 N SRINSTP S SRINST=$$INST^SROUTL0() G:SRINST="^" END S SRINSTP=$P(SRINST,"^"),SRINST=$S(SRINST["ALL DIVISIONS":SRINST,1:$P(SRINST,"^",2))
 W @IOF,!,"This report is designed to print to your terminal screen or a printer. When",!,"using a printer, a 132 column format is used.",!
 K IOP,%ZIS,POP,IO("Q") S %ZIS("A")="Print the List of Transplant Assessments to which Device: ",%ZIS="QM" D ^%ZIS I POP S SRSOUT=1 G END
 I $D(IO("Q")) K IO("Q") D  S ZTREQ="@" D ^%ZTLOAD G END
 .S ZTRTN="EN^SRTPLS",ZTDESC="List of Transplant Assessments"
 .S (ZTSAVE("SRSD"),ZTSAVE("SRED"),ZTSAVE("SRAST"),ZTSAVE("SRTYPE"),ZTSAVE("SRSRT"))="",ZTSAVE("SRINSTP")=""
EN ; entry when queued
 N SRFRTO S Y=SRSD X ^DD("DD") S SRFRTO="FROM: "_Y_"  TO: ",Y=SRED X ^DD("DD") S SRFRTO=SRFRTO_Y
 U IO S SRSD=SRSD-.0001,SRED=SRED_".9999",Y=DT X ^DD("DD") S SRPRINT="DATE PRINTED: "_Y
 S SRINST=$S(SRINSTP["ALL DIV":$P($$SITE^SROVAR,"^",2)_" - ALL DIVISIONS",1:$$GET1^DIQ(4,SRINSTP,.01))
 D ^SRTPLST G END
 Q
END I 'SRSOUT,$E(IOST)'="P" W !!,"Press ENTER to continue  " R X:DTIME
 W:$E(IOST)="P" @IOF K ^TMP("SRA",$J) I $D(ZTQUEUED) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 D ^%ZISC K SRTPP,SRAST W @IOF D ^SRSKILL
 Q
STATUS ; select type of Assessment Status
 W ! K DIR S DIR("A",1)="Print which Assessment Status ?",DIR("A",2)="",DIR("A",3)="   1. Incomplete Only"
 S DIR("A",4)="   2. Complete/Transmitted",DIR("A",5)="   3. ALL",DIR("A",6)=""
 S DIR("A")="Select Number",DIR("B")=3,DIR(0)="N^1:3" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 S SRAST=$S(Y=1:"I",Y=2:"CT",1:"ALL")
 Q
TYPE W ! K DIR S DIR("A",1)="Select Type of Transplant ?",DIR("A",2)="",DIR("A",3)="   1. Kidney"
 S DIR("A",4)="   2. Liver",DIR("A",5)="   3. Lung",DIR("A",6)="   4. Heart",DIR("A",7)="   5. ALL",DIR("A",8)=""
 S DIR("A")="Select Number",DIR("B")=5,DIR(0)="N^1:5" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 S SRTYPE=$S(Y=1:"K",Y=2:"LI",Y=3:"LU",Y=4:"H",1:"ALL")
 Q

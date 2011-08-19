SRTPCOM ;BIR/SJA - COMPLETE/TRANSMIT/PRINT ASSESSMENT ;09/12/08
 ;;3.0; Surgery ;**167**;24 Jun 93;Build 27
 S SRSOUT=0 I '$D(SRTPP) Q
 S (SRSFLG,SRSOUT,SROVER)=0,SRA=$G(^SRT(SRTPP,"RA")),Y=$P(SRA,"^"),SRTYPE=$P(SRA,"^",2),SRNOVA=$S($P(SRA,"^",5)="N":1,1:0)
 I Y'="I" W !!,"This assessment has a "_$S(Y="C":"'COMPLETE'",1:"'TRANSMITTED'")_" status.",!!,"No action taken." G END
 W ! S SRFLD="" K DIR S DIR("A")="Are you ready to complete and transmit this transplant assessment? ",DIR("B")="NO",DIR(0)="YA"
 S DIR("?",1)="Enter YES to complete and transmit this assessment, or enter NO to leave the",DIR("?")="status unchanged." D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 G END
 I 'Y W !!,"No action taken." G END
 D CHK^SRTPUTLC
 S SRFLD="" I $O(SRX(SRFLD))'="" D LIST
 S SRFLD="" I $O(SRX(SRFLD))="" G COMPLT
 W ! K DIR S DIR("A")="Are you sure that you want to transmit with missing information ",DIR("B")="NO",DIR(0)="Y"
 S DIR("?",1)="Enter YES to complete and transmit this assessment, or enter NO to leave the",DIR("?")="status unchanged." D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 G END
 I 'Y W !!,"No action taken." G END
COMPLT K DR,DIE S DA=SRTPP,DIE=139.5,DR="181///C" D ^DIE K STATUS
 W !,"Assessment completed and queued to transmit..." D TX
 K DIR W ! S DIR("A")="Do you want to print the completed assessment",DIR("B")="NO",DIR(0)="Y"
 S DIR("?",1)="Enter YES to print the completed assessment, or NO to return to the menu."
 D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 I 'Y S SRSOUT=1 Q
 K %ZIS,IO("Q"),POP S %ZIS("A")="Print the Completed Assessment on which Device: ",%ZIS="Q" D ^%ZIS I POP S SRSOUT=1 Q
 I $D(IO("Q")) K IO("Q") S ZTDESC="Completed Surgery Transplant Assessment",(ZTSAVE("SRSITE*"),ZTSAVE("SRTPP"))="",ZTRTN="EN^SRTPCOM" D ^%ZTLOAD S SRSOUT=1 G END
 D EN,END
 Q
PRINT S SRPRINT=1 D ^SRTPSS I '$D(SRTPP) S SRSOUT=1 G END
 W ! K %ZIS,IO("Q"),POP S %ZIS("A")="Print the Transplant Assessment on which Device: ",%ZIS="Q" D ^%ZIS I POP S SRSOUT=1 G ED
 I $D(IO("Q")) K IO("Q") S ZTDESC="Completed Surgery Risk Assessment",ZTSAVE("SRSITE*")="",ZTSAVE("SRTPP")="",ZTRTN="EN^SRTPCOM" D ^%ZTLOAD S SRSOUT=1 G ED
 D EN
ED D ^%ZISC W @IOF K SRTPP D ^SRSKILL
 Q
LIST W @IOF,!,"This assessment is missing the following items:",! S SRZ=0,SRCNT=1
 F  S SRZ=$O(SRX(SRZ)) Q:SRZ=""  S SRZ1=0 F  S SRZ1=$O(SRX(SRZ,SRZ1)) Q:SRZ1=""  D:$Y+5>IOSL RET Q:SRSOUT  D
 .I $G(SRTYPE)="H",$G(SRVA)="N",$P(SRX(SRZ,SRZ1),"^",2)=145 W !,?5,$J(SRCNT,2)_". Hypertension" S SRCNT=SRCNT+1 Q
 .W !,?5,$J(SRCNT,2)_". "_$P(SRX(SRZ,SRZ1),"^") S SRCNT=SRCNT+1
 S SRSOUT=0
 ;W ! K DIR S DIR(0)="Y",DIR("A")="Do you want to enter the missing items at this time",DIR("B")="NO" D ^DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 ;Q:'Y  D PRT
 Q
PRT S SRSOUT=0,(SRMD,SRMDD,SRODD)="",SRCNT=0 F  S SRMDD=$O(SRX(SRMDD)) Q:SRMDD=""  S SRODD=0 F  S SRODD=$O(SRX(SRMDD,SRODD)) Q:SRODD=""  S SRMD=$P($G(SRX(SRMDD,SRODD)),"^",2) D  Q:$G(SRSFLG)
 .I SRMD=44 D ^SRTPRACE Q
 .K DR,DIE S DA=SRTPP,DIE=139.5,DR=SRMD_"T" D ^DIE K DR I $D(Y) S SRSFLG=1
 S:'$G(SRSOUT) SRSOUT=0
 Q
EN U IO S SRABATCH=1 D ^SRTPPAS Q
END I 'SRSOUT,$E(IOST)'="P" D RET
 W @IOF I $E(IOST)="P" D ^%ZISC W @IOF
 D ^%ZISC W @IOF K SRTPP D ^SRSKILL
 Q
TX ; transplant assessment transmissions
 S ZTDESC="Transmit Transplant Assessments",SRRTN="ONE^SRTPTMIT",ZTRTN="JOB^SRTPCOM",ZTIO="",ZTSAVE("SRRTN")="",ZTSAVE("SRTPP")="",ZTDTH=$H D ^%ZTLOAD
 I $D(ZTSK) W !!,"Queued as task #"_ZTSK
 D RET,^SRSKILL K SRRTN W @IOF
 Q
JOB D @SRRTN S ZTREQ="@"
 Q
RET W !! K DIR S DIR(0)="E" D ^DIR K DIR W @IOF I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
PAGE I $E(IOST)'="P" D RET Q
 W @IOF,!!!
 Q

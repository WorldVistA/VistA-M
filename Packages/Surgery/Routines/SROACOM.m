SROACOM ;BIR/MAM - COMPLETE ASSESSMENT ;05/05/10
 ;;3.0; Surgery ;**38,55,63,65,88,93,95,102,100,125,134,142,160,166,174**;24 Jun 93;Build 8
 I '$D(SRTN) Q
 I $P($G(^SRF(SRTN,"RA")),"^",2)="C" G ^SROACOM1
 S (SRSFLG,SRSOUT,SROVER)=0,SRA=$G(^SRF(SRTN,"RA")),Y=$P(SRA,"^") I Y'="I" W !!,"This assessment has a "_$S(Y="C":"'COMPLETE'",1:"'TRANSMITTED'")_" status.",!!,"No action taken." G END
 I $P(SRA,"^",2)="N",$P(SRA,"^",6)="Y" D CHK^SROAUTL
 I $P(SRA,"^",2)="N",$P(SRA,"^",6)="N" D CHK^SROAUTL3
 S SRFLD="" I $O(SRX(SRFLD))'="" D LIST
YEP I '$P($G(^SRO(136,SRTN,10)),"^")!('$P($G(^SRO(136,SRTN,0)),"^",2))!('$P($G(^SRO(136,SRTN,0)),"^",3)) W !!,?6,"The coding for Procedure and Diagnosis is not complete."
 W ! S SRFLD="" K DIR S DIR("A")="Are you sure you want to complete this assessment ? ",DIR("B")=$S($O(SRX(SRFLD)):"NO",1:"YES"),DIR(0)="YA"
 S DIR("?",1)="Enter YES to complete this assessment, or enter NO to leave the status",DIR("?")="unchanged." D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 G END
 I 'Y W !!,"No action taken." G END
 I $$LOCK^SROUTL(SRTN) D COMPLT Q
 E  W !!,"No action taken." G END
 Q
COMPLT W !!,"Updating the current status to 'COMPLETE'..." K DR,DIE S DA=SRTN,DIE=130,DR="235///C;272.1////"_DUZ D ^DIE K STATUS
 I $P(SRA,"^",5)="" K DR,DIE S DA=SRTN,DIE=130,DR="272///"_DT D ^DIE K STATUS
 I $P(SRA,"^",2)="C" K DA,DIE,DIK,DR S DIK="^SRF(",DIK(1)=".232^AQ",DA=SRTN D EN1^DIK K DA,DIK
 D UNLOCK^SROUTL(SRTN)
PRINT W !!,"Do you want to print the completed assessment ?  YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 Q
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y" I "Nn"[SRYN S SRSOUT=1 Q
 I "Yy"'[SRYN W !!,"Enter <RET> to print the completed assessment, or 'NO' to return to the menu." G PRINT
 W ! K %ZIS,IO("Q"),POP S %ZIS("A")="Print the Completed Assessment on which Device: ",%ZIS="Q" D ^%ZIS I POP S SRSOUT=1 Q
 I $D(IO("Q")) K IO("Q") S ZTDESC="Completed Surgery Risk Assessment",(ZTSAVE("SRSITE*"),ZTSAVE("SRTN"))="",ZTRTN="EN^SROACOM" D ^%ZTLOAD S SRSOUT=1 G END
 D EN,END
 Q
EN U IO S SRABATCH=1 D ^SROAPAS Q
END I 'SRSOUT,$E(IOST)'="P" D RET
 W @IOF I $E(IOST)="P" D ^%ZISC W @IOF
 D ^SRSKILL K SRMD,SRMD1,SRSFLG
 Q
LIST W @IOF,!,"This assessment is missing the following items:",! S SRZ="",SRCNT=1
 F  S SRZ=$O(SRX(SRZ)) Q:SRZ=""  D:$Y+5>IOSL RET Q:SRSOUT  W !,?5,$J(SRCNT,2)_". "_$P(SRX(SRZ),"^") S SRCNT=SRCNT+1
 S SRSOUT=0 W ! K DIR S DIR(0)="Y",DIR("A")="Do you want to enter the missing items at this time",DIR("B")="NO" D ^DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 Q:'Y  I $$LOCK^SROUTL(SRTN) D PRT,UNLOCK^SROUTL(SRTN)
 Q
PRT S SRSOUT=0,(SRMD,SRMD1)="",SRCNT=0 F  S SRMD=$O(SRX(SRMD)) Q:SRMD=""  S SRMD1=$P(SRX(SRMD),"^",2) D  Q:$G(SRSFLG)
 .I $E(SRMD,1,10)="ANESTHESIA" D ANES Q
 .I $E(SRMD,1,6)="POSTOP"!($E(SRMD,1,6)="SEPSIS") D POST^SROCMPS Q
 .K DR,DIE S DA=SRTN,DIE=130,DR=$S($G(SRMD1):SRMD1,1:SRMD)_"T" D ^DIE K DR I $D(Y) S SRSFLG=1
 S:'$G(SRSOUT) SRSOUT=0
 Q
ANES K DR,DIE,DA S DA=SRTN,DR=.37,DR(2,130.06)=".01T;.05T;42T",DIE=130 D ^DIE S:$D(Y) SRSFLG=1 K DR
 Q
RET W !! K DIR S DIR(0)="E" D ^DIR K DIR W @IOF I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
PAGE I $E(IOST)'="P" D RET Q
 W @IOF,!!!
 Q

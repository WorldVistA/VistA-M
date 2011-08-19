SROACOM1 ;BIR/MAM - COMPLETE ASSESSMENT ;05/05/10
 ;;3.0; Surgery ;**166,174**;24 Jun 93;Build 8
 I '$D(SRTN) Q
 S (SRSFLG,SRSOUT,SROVER)=0,SRA=$G(^SRF(SRTN,"RA")),Y=$P(SRA,"^") I Y'="I" W !!,"This assessment has a "_$S(Y="C":"'COMPLETE'",1:"'TRANSMITTED'")_" status.",!!,"No action taken." G END
 I $P(SRA,"^",2)="C" D CHK^SROAUTLC
 S SRFLD="" I $O(SRX(SRFLD))'="" D LIST
 I $P(SRA,"^",2)="C" D CHCK G:SRSOUT END
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
 I $D(IO("Q")) K IO("Q") S ZTDESC="Completed Surgery Risk Assessment",(ZTSAVE("SRSITE*"),ZTSAVE("SRTN"))="",ZTRTN="EN^SROACOM1" D ^%ZTLOAD S SRSOUT=1 G END
 D EN,END
 Q
EN U IO S SRABATCH=1 D ^SROAPAS Q
END I 'SRSOUT,$E(IOST)'="P" D RET
 W @IOF I $E(IOST)="P" D ^%ZISC W @IOF
 D ^SRSKILL K SRMD,SRMD1,SRMDD,SRSFLG
 Q
LIST W @IOF,!,"This assessment is missing the following items:",! S SRZ="",SRCNT=1
 F  S SRZ=$O(SRX(SRZ)) Q:SRZ=""  D:$Y+5>IOSL RET Q:SRSOUT  W !,?5,$J(SRCNT,2)_". "_$P($P(SRX(SRZ),":"),"^") S SRCNT=SRCNT+1
 S SRSOUT=0 W ! K DIR S DIR(0)="Y",DIR("A")="Do you want to enter the missing items at this time",DIR("B")="NO" D ^DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 Q
 Q:'Y  I $$LOCK^SROUTL(SRTN) D PRT,UNLOCK^SROUTL(SRTN)
 Q
PRT S SRSOUT=0,(SRMD,SRMDD,SRMD1)="",SRCNT=0 F  S SRMDD=$O(SRX(SRMDD)) Q:SRMDD=""  S SRMD=$P($G(SRX(SRMDD)),":",2),SRMD1=$P($G(SRX(SRMDD)),"^",2) D  Q:$G(SRSFLG)
 .I SRMD=485 W @IOF,! D PRIOR^SROACL2 K DR,DIE S DA=SRTN,DR="485///"_$S(X="@":"@",1:$P(Y,"^")),DIE=130 D ^DIE K DR S:$D(Y) SRSFLG=1 Q
 .K DR,DIE S DA=SRTN,DIE=130,DR=$S($G(SRMD1):SRMD1,1:SRMD)_"T" D ^DIE K DR I $D(Y) S SRSFLG=1
 S:'$G(SRSOUT) SRSOUT=0
 Q
CHCK ; cardiac checks added by SR*3*93
 N SRADM,SRDIS,SRISCH,SRCPB,SRRET S SRRET=0,X=$G(^SRF(SRTN,208)),SRADM=$P(X,"^",14),SRDIS=$P(X,"^",15),X=$G(^SRF(SRTN,206)),SRISCH=$P(X,"^",36),SRCPB=$P(X,"^",37)
 I SRADM,SRDIS,SRADM'<SRDIS W !!,"  ***  NOTE: Discharge Date precedes Admission Date!!  Please check.  ***" S SRRET=1,SRZZ(418)="",SRX($P(SRZZ(418),"^",2))=""
 I SRISCH,SRCPB,SRISCH>SRCPB W !!,"  ***  NOTE: Ischemic Time is greater than CPB Time!!  Please check.  ***",! S SRRET=1,SRZZ(450)="",SRX($P(SRZZ(450),"^",2))=""
 I SRRET W ! K DIR S DIR(0)="E" D ^DIR K DIR S:$D(DTOUT)!$D(DUOUT) SRSOUT=1 W !
 Q
RET W !! K DIR S DIR(0)="E" D ^DIR K DIR W @IOF I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
PAGE I $E(IOST)'="P" D RET Q
 W @IOF,!!!
 Q

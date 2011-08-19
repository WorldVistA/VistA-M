SROASSP ;BIR/MAM - PRINT A COMPLETED ASSESSMENT ;12/05/07
 ;;3.0; Surgery ;**38,94,166**;24 Jun 93;Build 6
BATCH ;
 W ! K DIR S DIR("?",1)="Enter YES to batch print all completed or transmitted assessments for a",DIR("?",2)="selected date range.  Enter NO or press return to print one specific",DIR("?")="assessment."
 S DIR("A")="Do you want to batch print assessments for a specific date range ? ",DIR(0)="YA",DIR("B")="NO" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 G END
 I Y D ^SROABCH Q
 S SRPRINT=1 K SRNEW D ^SROASS I '$D(SRTN) S SRSOUT=1 G END
 W ! K %ZIS,IO("Q"),POP S %ZIS("A")="Print the Completed Assessment on which Device: ",%ZIS="Q" D ^%ZIS I POP S SRSOUT=1 G END
 I $D(IO("Q")) K IO("Q") S ZTDESC="Completed Surgery Risk Assessment",ZTSAVE("SRSITE*")="",ZTSAVE("SRTN")="",ZTRTN=$S($P($G(^SRF(SRTN,"RA")),"^",2)="C":"EN^SROACOM1",1:"EN^SROACOM") D ^%ZTLOAD G END
 D @($S($P($G(^SRF(SRTN,"RA")),"^",2)="C":"EN^SROACOM1",1:"EN^SROACOM"))
END D ^%ZISC W @IOF K SRTN D ^SRSKILL
 Q

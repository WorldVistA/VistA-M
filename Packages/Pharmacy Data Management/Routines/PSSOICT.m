PSSOICT ;BIR/RTR-Orderable Item status ; 09/02/97 8:41
 ;;1.0;PHARMACY DATA MANAGEMENT;;9/30/97
 N PSSITE,QFLAG,AA,FF,FFFF,MMM,PSDATE,A,AA,APP,B,SS,ZZ,ZZZ
 S PSSITE=+$O(^PS(59.7,0)) I $P($G(^PS(59.7,PSSITE,80)),"^",2)'=2 W !!?3,$S($P($G(^(80)),"^",2)<2:"Orderable Item Auto-Create has not been completed!",1:"Manual Matching process complete!"),!! K PSSITE G EXIT
 W !,"This option looks at the 3 files that must be matched to the Orderable Item",!,"File, and tells you how many more need to be matched. The 3 files are:"
 W !!?5,"IV ADDITIVES File",!?5,"IV SOLUTIONS File",!?5,"DRUG File"
 W !!,"(Lists will not include drugs that do not require matching.)"
 W ! S %ZIS="QM" D ^%ZIS I POP G EXIT
 I $D(IO("Q")) D  Q
 .S ZTRTN="BEG^PSSOICT",ZTDESC="Pharmacy Orderable Item Status Report" D ^%ZTLOAD K IO("Q") W !,"Report queued to print!",!
BEG U IO
 S QFLAG=0
 ;I $E(IOST)="C" D DIRX I $G(Y)'=1 G EXIT
 S X1=DT,X2=-365 D C^%DTC S PDATE=X
 I $E(IOST)="C" W !!,"Finding IV ADDITIVES that aren't matched, hold on:" F II=1:1:3 W "." H 1
 I $E(IOST)'="C" D ADDHEAD
 S MM=0
 I $E(IOST)="C" W !
 F AA=0:0 S AA=$O(^PS(52.6,AA)) Q:'AA!($G(QFLAG))  I '$P($G(^PS(52.6,AA,0)),"^",11) D
 .S DD=$P($G(^PS(52.6,AA,0)),"^",2)
 .I 'DD Q
 .S FFFF=$P($G(^PS(52.6,AA,"I")),"^") I FFFF,FFFF<PDATE Q
 .D:MM=0  W !,$P($G(^PS(52.6,AA,0)),"^"),?41,"Still needs to be matched." S MM=MM+1 I ($Y+4)>IOSL D:$E(IOST)="C" DIRX D:$E(IOST)'="C" ADDHEAD S:$G(Y)'=1&($E(IOST)="C") QFLAG=1 I '$G(QFLAG)&($E(IOST)="C") W @IOF
 ..I $E(IOST)="C" W @IOF W !?5,"IV ADDITIVES that need matched:",!
 I $G(QFLAG) G EXIT
 I 'MM W !,"All IV ADDITIVES are matched that should be matched!",!
 I MM W $C(7),!!?3,MM," IV ADDITIVE(S) still need to be matched!",! H 1
 I $E(IOST)="C" D DIRX I $G(Y)'=1 G EXIT
 G ^PSSOICT1
 ;
EXIT D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" K ^TMP($J,"PSSLIST") Q
DIRX ;
 W ! K DIR S DIR(0)="E",DIR("A")="Press Return to Continue, '^' to Exit" D ^DIR K DIR Q
ADDHEAD W @IOF W !,"IV ADDITIVE(S) THAT AREN'T MATCHED",!,"________________________________",! Q

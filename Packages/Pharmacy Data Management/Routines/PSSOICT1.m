PSSOICT1 ;BIR/RTR-ORDERABLE ITEM STATUS continued ; 09/02/97 8:41
 ;;1.0;PHARMACY DATA MANAGEMENT;;9/30/97
 S X1=DT,X2=-365 D C^%DTC S PDATE=X
 S QFLAG=0
 I $E(IOST)="C" W !!,"Finding IV SOLUTIONS that aren't matched, hold on:" F II=1:1:3 W "." H 1
 I $E(IOST)'="C" D SOLHEAD
 S MM=0
 I $E(IOST)="C" W !
 F AA=0:0 S AA=$O(^PS(52.7,AA)) Q:'AA!($G(QFLAG))  I '$P($G(^PS(52.7,AA,0)),"^",11) D
 .S DD=$P(^PS(52.7,AA,0),"^",2)
 .I 'DD Q
 .S FFFF=$P($G(^PS(52.7,AA,"I")),"^") I FFFF,FFFF<PDATE Q
 .D:MM=0  W !,$P($G(^PS(52.7,AA,0)),"^"),?35,$P($G(^(0)),"^",3),?55,"Still needs matched." S MM=MM+1 I ($Y+4)>IOSL D:$E(IOST)="C" DIRX^PSSOICT D:$E(IOST)'="C" SOLHEAD S:$G(Y)'=1&($E(IOST)="C") QFLAG=1 I '$G(QFLAG)&($E(IOST)="C") W @IOF
 ..I $E(IOST)="C" W @IOF W !?5,"IV SOLUTION(S) that need matched:",!
 I $G(QFLAG) G EXIT^PSSOICT
 I 'MM W !,"All IV SOLUTIONS are matched that should be matched!",!
 I MM W $C(7),!!?3,MM," IV SOLUTION(S) still need to be matched!",! H 1
 I $E(IOST)="C" D DIRX^PSSOICT I $G(Y)'=1 G EXIT^PSSOICT
 I $E(IOST)="C" W !!,"Finding DISPENSE Drug(s) that aren't matched, hold on:" W ! H 1 F II=1:1:4 W "."
 S A=1,B=0
 K ^TMP($J,"PSSLIST")
 S ZZZ="" F  S ZZZ=$O(^PSDRUG("B",ZZZ)) Q:ZZZ=""!($G(QFLAG))  S ZZ=$O(^PSDRUG("B",ZZZ,0)) I ZZ,$D(^PSDRUG(ZZ,0)),'$P($G(^PSDRUG(ZZ,2)),"^") D
 .S APP=$P($G(^PSDRUG(ZZ,2)),"^",3) I APP'["O",APP'["I",APP'["U" Q
 .S SS=$P($G(^PSDRUG(ZZ,"I")),"^") I SS,SS<PDATE Q
 .I $E(IOST)="C" I ZZ>99,$E(ZZ,($L(ZZ)-1),($L(ZZ)))="00" W "."
 .I '$P($G(^PSDRUG(ZZ,"ND")),"^") S B=B+1
 .S ^TMP($J,"PSSLIST",A)=$P($G(^PSDRUG(ZZ,0)),"^") S A=A+1 I $E(IOST)="C" W "."
 I $E(IOST)'="C" D DH
 I A=1 W !!,"All DISPENSE Drugs are matched that should be matched!" H 2 W ! G EXIT^PSSOICT
 W !!,(A-1)," DISPENSE drugs still need to be matched!" H 1
 I B W !!,B," because Drug is not matched to National Drug File",! H 1
 I $E(IOST)="C" K DIR S DIR(0)="Y",DIR("B")="Y",DIR("A")="Do you want to see these Drugs" D ^DIR K DIR I $G(Y)'=1 G EXIT^PSSOICT
 I $E(IOST)="C" W @IOF
 I $E(IOST)'="C" D DH
 F XXX=0:0 S XXX=$O(^TMP($J,"PSSLIST",XXX)) Q:'XXX!($G(QFLAG))  W !,$G(^(XXX)),?43,"Still needs to be matched." I ($Y+4)>IOSL D:$E(IOST)="C" DIRX^PSSOICT D:$E(IOST)'="C" DH S:$G(Y)'=1&($E(IOST)="C") QFLAG=1 I '$G(QFLAG)&($E(IOST)="C") W @IOF
 I '$G(QFLAG) W !!,"END OF LIST",!
END ;
 G EXIT^PSSOICT
SOLHEAD W @IOF W !,"IV SOLUTION(S) THAT AREN'T MATCHED",!,"________________________________",! Q
DH W @IOF W !,"DISPENSE DRUG(S) THAT AREN'T MATCHED",!,"__________________________________",! Q

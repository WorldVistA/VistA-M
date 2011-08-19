PSSUTLPR ;BIR/RTR-Pre release utility routine ;02/14/00
 ;;1.0;PHARMACY DATA MANAGEMENT;**34,47**;9/30/97
 ;
TEXT ;Text for pre-release report
 W !!,"The current Orderable Item structure keeps Additives and Solutions matched to",!,"Orderable Items flagged for IV use. All Dispense Drugs are currently matched to",!,"Orderable Items that are not flagged for IV Use. This was done"
 W " to control "
 W !,"the finishing process of IV and Unit Dose orders entered through CPRS.",!,"The new Orderable Item structure will inactivate all IV flagged Orderable",!,"Items. All Additives and Solutions will be re-matched to non-IV flagged"
 W !,"Orderable Items, based on their Dispense Drug links.",!
 W ! K DIR S DIR(0)="E" D ^DIR K DIR I Y["^"!($D(DIRUT)) K Y S PSSOUT=1 Q
 K PSSTYPE
 K DIR S DIR(0)="S^A:ADDITIVES;S:SOLUTIONS;B:BOTH",DIR("A")="Print report for Additives, Solutions, or Both",DIR("B")="B"
 S DIR("?")=" ",DIR("?",1)="Enter 'A' to see how the Additives will be re-matched in the new Orderable"
 S DIR("?",2)="Item structure, enter 'S' to see how the Solutions will be re-matched in the",DIR("?",3)="new Orderable Item structure, enter 'B' to see both, enter '^' to exit."
 Q
INS ;Convert non-numeric Instructions to Nouns
 D CHECK I $G(PSSNOCON) K PSSNOCON Q
 K PSSNOCON
 W !!,"This option will move all non-numeric Instructions to the Noun field in the",!,"Dosage Form file. If you do this, you will then need to review the Nouns and decide to mark them for Inpatient, Outpatient or both."
 W ! K DIR S DIR(0)="Y",DIR("A")="Convert all non-numeric Instructions to Nouns",DIR("B")="Y" D ^DIR I Y'=1 W !!,"Nothing converted.",! G INSQ
 W !,"Converting.." H 1
 N PSSD,PSSI,PSSINS
 F PSSD=0:0 S PSSD=$O(^PS(50.606,PSSD)) Q:'PSSD  D:$O(^PS(50.606,PSSD,"INS",0))
 .F PSSI=0:0 S PSSI=$O(^PS(50.606,PSSD,"INS",PSSI)) Q:'PSSI  S PSSINS=$P($G(^PS(50.606,PSSD,"INS",PSSI,0)),"^") I PSSINS'="" D
 ..I PSSINS?.N!(PSSINS?.N1".".N) Q
 ..I $O(^PS(50.606,PSSD,"NOUN","B",PSSINS,0)) Q
 ..K DIC,DD,DO S DA(1)=PSSD,DIC="^PS(50.606,"_DA(1)_",""NOUN"",",DIC(0)="L",X=PSSINS D FILE^DICN W "." K DD,DO,DIC
 W !,"Finished converting Instructions to Nouns!"
INSQ W !
 Q
NOUN ;Enter/edit Nouns
 D CHECK I $G(PSSNOCON) K PSSNOCON G NOUNQ
 K PSSNOCON
 W ! K DIC S DIC(0)="QEAMZ",DIC="^PS(50.606," D ^DIC I Y<1!($D(DTOUT))!($D(DUOUT)) G NOUNQ
 S PSSDOSE=+Y
NOUNA W !!?2,"Dosage Form => ",$P($G(^PS(50.606,+PSSDOSE,0)),"^"),! K DIC S DA(1)=PSSDOSE,DIC="^PS(50.606,"_PSSDOSE_",""NOUN"",",DIC(0)="QEAMLZ" D  D ^DIC I Y<1!($D(DUOUT))!($D(DTOUT)) G NOUNC
 .S DIC("W")="W ""  ""_$P($G(^PS(50.606,PSSDOSE,""NOUN"",+Y,0)),""^"",2)"
 S PSSNOUN=+Y,PSSOTH=$S($P($G(^PS(59.7,1,40.2)),"^"):1,1:0)
 K DIE S DA(1)=PSSDOSE,DA=PSSNOUN,DR=".01;S:'$G(PSSOTH) Y=""@1"";3;@1;1;2",DIE="^PS(50.606,"_PSSDOSE_",""NOUN"","
 D ^DIE K DIE,PSSOTH G:'$D(Y)&('$D(DTOUT)) NOUNA
NOUNC W ! K DIE,PSSOTH S DA=PSSDOSE,DIE="^PS(50.606,",DR="10" D ^DIE K DIE G NOUN
NOUNQ W ! K DIC,DR,DIE,PSSDOSE,PSSNOUN,PSSOTH
 Q
CHECK ;Check for running conversion
 S PSSNOCON=0
 S PSSYSIEN=$O(^PS(59.7,0))
 I $P($G(^PS(59.7,+$G(PSSYSIEN),80)),"^",3)=2 S PSSNOCON=1
 K PSSYSIEN I PSSNOCON W $C(7) W !!,"Cannot use this option, Dosage conversion is currently running!",!
 Q
TRAC ;
 N PSZZ,PSZZ1,PSZZ2,PSZSTA,PSZSTO,PSZWHO
 S PSZZ1=$O(^PS(59.7,0)),PSZZ2=$P($G(^PS(59.7,+$G(PSZZ1),80)),"^",3)
 I PSZZ2 D
 .S Y=$P($G(^PS(59.7,+$G(PSZZ1),80)),"^",4) I Y D DD^%DT S PSZSTA=$G(Y)
 .S Y=$P($G(^PS(59.7,+$G(PSZZ1),80)),"^",5) I Y D DD^%DT S PSZSTO=$G(Y)
 .K PSZWHOAR S DA=+$P($G(^PS(59.7,+$G(PSZZ1),80)),"^",6) I DA S DIC=200,DR=".01",DIQ(0)="E",DIQ="PSZWHOAR" D EN^DIQ1 S PSZWHO=$G(PSZWHOAR(200,DA,.01,"E")) K DIQ,PSZWHOAR,DR,DIC,DA
 H 1 W @IOF W !,?15,"Dosage Conversion Tracker Status",! F PSZZ=1:1:77 W "="
 I 'PSZZ2 W !,"The Dosage conversion has never been run!",! G TRACQ
 I PSZZ2=1 W !,"The Dosage conversion is queued to run at "_$G(PSZSTA),!,"It was queued by "_$G(PSZWHO),! G TRACQ
 I PSZZ2=2 W !,"The Dosage conversion is currently running.",!,"It started at "_$G(PSZSTA),! G TRACQ
 I PSZZ2=3 W !,"The Dosage conversion was last run by "_$G(PSZWHO),!,"It started on "_$G(PSZSTA)_" and ended on "_$G(PSZSTO),!
TRACQ W ! K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR W ! K DIR
 Q
FRE ;
 W ! K DIC S DIC(0)="QEAMZ",DIC("A")="Select Medication Instruction: ",DIC="^PS(51," D ^DIC K DIC I Y<1!($D(DTOUT))!($D(DUOUT)) G FREQ
 K DIE W ! S DA=+Y,DIE="^PS(51,",DR="31" D ^DIE G:$D(Y)!($D(DTOUT)) FREQ
 G FRE
FREQ W ! K DA,DIE,DR,DIC
 Q
FRRP ;
 W !!,"This report shows the MEDICATION INSTRUCTION file entries, along with the",!,"Synonym, Frequency and Expansion. Use the Edit Medication Instruction",!,"Frequency option to enter appropriate frequencies.",!
 K IOP,%ZIS,POP S %ZIS="QM" D ^%ZIS I $G(POP) W !!,"Nothing queued to print.",!! Q
 I $D(IO("Q")) S ZTRTN="ENF^PSSUTLPR",ZTDESC="Med Instruction Frequency report" D ^%ZTLOAD K %ZIS W !,"Report queued to print." Q
ENF ;
 U IO
 S PSSOUT=0,PSSDV=$S($E(IOST)="C":"C",1:"P"),PSSCT=1
 K PSSLINE,PSSF,PSSFR S $P(PSSLINE,"-",79)=""
 D ENFH
 S PSSF="" F  S PSSF=$O(^PS(51,"B",PSSF)) Q:PSSF=""!($G(PSSOUT))  F PSSFR=0:0 S PSSFR=$O(^PS(51,"B",PSSF,PSSFR)) Q:'PSSFR!($G(PSSOUT))  I $G(^PS(51,"B",PSSF,PSSFR))="" D
 .I ($Y+5)>IOSL D ENFH Q:$G(PSSOUT)
 .S PSSFNODE=$G(^PS(51,PSSFR,0)) Q:PSSFNODE=""
 .W !,$P(PSSFNODE,"^"),?11,$P(PSSFNODE,"^",3),?22,$P(PSSFNODE,"^",8),?30,$P(PSSFNODE,"^",2)
 I '$G(PSSOUT),$G(PSSDV)="C" W !!,"End of Report." K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 I $G(PSSDV)="C" W !
 E  W @IOF
 K PSSLINE,PSSOUT,PSSF,PSSFR,PSSCT,PSSDV D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
ENFH ;
 I $G(PSSDV)="C",$G(PSSCT)'=1 W ! K DIR S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit" D ^DIR K DIR I 'Y S PSSOUT=1 Q
 W @IOF W !?5,"MEDICATION INSTRUCTION FREQUENCY REPORT"_$S($G(PSSCT)=1:"",1:"  (cont.)"),?68,"PAGE: "_$G(PSSCT) S PSSCT=PSSCT+1
 W !!,"NAME",?10,"SYNONYM",?21,"FREQUENCY",?34,"EXPANSION",!,PSSLINE,!
 Q
SLS ;Called from PSSORUTL
 K PSSJZUNT
 I $P($G(PSSX(PSSA,PL3)),"^",2)'["/" S $P(PSSX(PSSA,PL3),"^",5)=$P($G(PSSX(PSSA,PL3)),"^")_$P($G(PSSX(PSSA,PL3)),"^",2) Q
 N PSSJ,PSSJ1,PSSJ2,PSSI,PSSJA,PSSJA1,PSSJB,PSSJB1,PSSWZI,PSSWZSL,PSSWZND,PSSWZSL1,PSSWZSL2,PSSWZSL3,PSSWZSL4,PSSWZSL5,PSSWZ50
 S PSSJ=$P($G(PSSX(PSSA,PL3)),"^"),PSSI=$P($G(PSSX(PSSA,PL3)),"^",2)
 S PSSWZSL=0,PSSWZI=+$P($G(PSSX(PSSA,PL3)),"^",6),PSSWZ50=$P($G(^PSDRUG(PSSWZI,"DOS")),"^")
 S PSSWZND=$$PSJST^PSNAPIS(+$P($G(^PSDRUG(PSSWZI,"ND")),"^"),+$P($G(^PSDRUG(PSSWZI,"ND")),"^",3)) S PSSWZND=+$P($G(PSSWZND),"^",2) ;I $G(PSSWZND),$G(PSSWZ50),+$G(PSSWZND)'=+$G(PSSWZ50) S PSSWZSL=1
 S PSSJA=$P(PSSI,"/"),PSSJB=$P(PSSI,"/",2),PSSJA1=+$G(PSSJA),PSSJB1=+$G(PSSJB)
 I '$G(PSSWZND) S $P(PSSX(PSSA,PL3),"^",5)=$P(PSSX(PSSA,PL3),"^") G SLSQ
 S PSSWZSL2=PSSWZ50/PSSWZND,PSSWZSL3=PSSWZSL2*+$P($G(PSSX(PSSA,PL3)),"^",3) S PSSWZSL4=PSSWZSL3*$S($G(PSSJB1):PSSJB1,1:1) S PSSWZSL5=$S('$G(PSSJB1):PSSWZSL4_$G(PSSJB),1:PSSWZSL4_$P(PSSJB,PSSJB1,2))
 S PSSJ2=$S('$G(PSSJA1):PSSJ,1:($G(PSSJA1)*PSSJ))_$S($G(PSSJA1):$P(PSSJA,PSSJA1,2),1:PSSJA)_"/"_$G(PSSWZSL5)
 S PSSJZUNT=$P(PSSI,"/")_"/"_$G(PSSWZSL4)_$S('$G(PSSJB1):$G(PSSJB),1:$P(PSSJB,PSSJB1,2)) S $P(PSSX(PSSA,PL3),"^",2)=PSSJZUNT
 S $P(PSSX(PSSA,PL3),"^",5)=PSSJ2
SLSQ Q
 ;
ADDRP ;
 D ^DIR K DIR S PSSTYPE=Y I Y["^"!($D(DIRUT)) K PSSTYPE W ! Q
 W !!?3,"*** THIS REPORT IS DESIGNED FOR 132 COLUMNS ***",!
 K IOP,%ZIS,POP S %ZIS="QM" D ^%ZIS I $G(POP) W !,"Nothing queued to print.",! K PSSTYPE W ! Q
 I '$G(DT) S DT=$$DT^XLFDT
 S X1=DT,X2=-365 D C^%DTC S PSSYRX=$G(X) K X,X1,X2
 I $D(IO("Q")) S ZTRTN="ADD^PSSREMCH",ZTDESC="Orderable Item re-matching report",ZTSAVE("PSSTYPE")="",ZTSAVE("PSSYRX")="" D ^%ZTLOAD K %ZIS W !,"Report queued to print." G END^PSSREMCH
 G ADD^PSSREMCH

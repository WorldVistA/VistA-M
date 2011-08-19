PSSMIRPT ;BIR/RTR-Medication Instruction Report ;07/03/07
 ;;1.0;PHARMACY DATA MANAGEMENT;**129**;9/30/07;Build 67
 ;
 ;
EN ;Prompts for Medication Instruction File Report
 W !!,"This report displays entries from the MEDICATION INSTRUCTION (#51) File. It"
 W !,"can be run for all Medication Instructions or only Medication Instructions"
 W !,"without a FREQUENCY (IN MINUTES). If a FREQUENCY (IN MINUTES) cannot be"
 W !,"determined for an order, the daily dosage check cannot occur for that order."
 N DIR,PSSMXRP,PSSMXLNG,Y,X,DTOUT,DUOUT,DIRUT,DIROUT,IOP,%ZIS,POP,ZTRTN,ZTDESC,ZTSAVE,ZTSK
 K DIR,Y S DIR(0)="SO^A:All Medication Instructions;O:Only Medication Instructions with a missing frequency",DIR("A",1)="Print All Medication Instructions, or Only Medication Instructions",DIR("A")="without a frequency",DIR("B")="A"
 S DIR("?")=" ",DIR("?",1)=" ",DIR("?",2)="Enter 'A' to see all Medication Instructions, enter 'O' to see only",DIR("?",3)="those Medication Instructions without data in the FREQUENCY (IN MINUTES)"
 S DIR("?",4)="(#31) Field. A FREQUENCY (IN MINUTES) must be derived from a Schedule",DIR("?",5)="for the daily dosage check to occur for an order."
 W ! D ^DIR K DIR I $D(DUOUT)!($D(DTOUT)) D MESS K DIR,Y S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR Q
 I Y'="A",Y'="O" D MESS K DIR,Y S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR Q
 S PSSMXRP=Y
 K DIR,Y S DIR(0)="SO^80:80 Column;132:132 Column",DIR("A")="Print report in 80 or 132 column format",DIR("B")="80"
 S DIR("?")=" ",DIR("?",1)="Enter 80 to print the report in an 80 column format,",DIR("?",2)="Enter 132 to print the report in an 132 column format."
 W ! D ^DIR K DIR I $D(DUOUT)!($D(DTOUT)) D MESS K DIR,Y S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR Q
 I Y'="80",Y'="132" D MESS K DIR,Y S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR Q
 S PSSMXLNG=Y W !
 K IOP,%ZIS,POP S %ZIS="QM" D ^%ZIS I $G(POP)>0 D MESS K DIR,Y S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR,IOP,%ZIS,POP Q
 I $D(IO("Q")) S ZTRTN="START^PSSMIRPT",ZTDESC="Medication Instruction File Report",ZTSAVE("PSSMXRP")="",ZTSAVE("PSSMXLNG")="" D ^%ZTLOAD K %ZIS W !!,"Report queued to print.",! D  Q
 .K DIR,Y S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 ;
 ;
START ;Print Medication Instruction File report
 U IO
 N PSSMXOUT,PSSMXNOF,PSSMXDEV,PSSMXCT,PSSMXLIN,PSSMXQ,PSSMXQEN,PSSMXRA,PSSMXRAA,PSSMXREP,PSSMXROO
 S (PSSMXOUT,PSSMXNOF)=0,PSSMXDEV=$S($E(IOST,1,2)'="C-":"P",1:"C"),PSSMXCT=1
 K PSSMXLIN S:PSSMXLNG=132 $P(PSSMXLIN,"-",130)="" S:PSSMXLNG=80 $P(PSSMXLIN,"-",78)=""
 D HD
 S PSSMXQ="" F  S PSSMXQ=$O(^PS(51,"B",PSSMXQ)) Q:PSSMXQ=""!(PSSMXOUT)  D
 .F PSSMXQEN=0:0 S PSSMXQEN=$O(^PS(51,"B",PSSMXQ,PSSMXQEN)) Q:'PSSMXQEN!(PSSMXOUT)  I '$G(^PS(51,"B",PSSMXQ,PSSMXQEN)) D
 ..K PSSMXRA,PSSMXRAA,PSSMXREP,PSSMXROO
 ..S PSSMXRA=PSSMXQEN_","
 ..D GETS^DIQ(51,PSSMXRA,".01;.5;1;1.1;9;30;31","E","PSSMXRAA")
 ..I PSSMXRP="O",$G(PSSMXRAA(51,PSSMXRA,31,"E"))'="" Q
 ..S PSSMXNOF=1
 ..W !!,$G(PSSMXRAA(51,PSSMXRA,.01,"E"))
 ..I ($Y+5)>IOSL D HD Q:PSSMXOUT
 ..W !?19,"SYNONYM: "_$G(PSSMXRAA(51,PSSMXRA,.5,"E"))
 ..I ($Y+5)>IOSL D HD Q:PSSMXOUT
 ..W !?17,"EXPANSION: " D
 ...S PSSMXREP=$G(PSSMXRAA(51,PSSMXRA,1,"E"))
 ...I PSSMXLNG=132 D  Q
 ....I $L(PSSMXREP)<104 W PSSMXREP,! Q
 ....N X,DIWL,DIWR,DIWF S X=PSSMXREP,DIWL=29,DIWR=131,DIWF="W" K ^UTILITY($J,"W") D ^DIWP D ^DIWW K ^UTILITY($J,"W")
 ...I $L(PSSMXREP)<52 W PSSMXREP,! Q
 ...N X,DIWL,DIWR,DIWF S X=PSSMXREP,DIWL=29,DIWR=79,DIWF="W" K ^UTILITY($J,"W") D ^DIWP D ^DIWW K ^UTILITY($J,"W")
 ..I ($Y+5)>IOSL D HD Q:PSSMXOUT  W !
 ..W ?2,"OTHER LANGUAGE EXPANSION: " D
 ...S PSSMXROO=$G(PSSMXRAA(51,PSSMXRA,1.1,"E"))
 ...I PSSMXLNG=132 D  Q
 ....I $L(PSSMXROO)<104 W PSSMXROO,! Q
 ....N X,DIWL,DIWR,DIWF S X=PSSMXROO,DIWL=29,DIWR=131,DIWF="W" K ^UTILITY($J,"W") D ^DIWP D ^DIWW K ^UTILITY($J,"W")
 ...I $L(PSSMXROO)<52 W PSSMXROO,! Q
 ...N X,DIWL,DIWR,DIWF S X=PSSMXROO,DIWL=29,DIWR=79,DIWF="W" K ^UTILITY($J,"W") D ^DIWP D ^DIWW K ^UTILITY($J,"W")
 ..I ($Y+5)>IOSL D HD Q:PSSMXOUT  W !
 ..W ?20,"PLURAL: "_$G(PSSMXRAA(51,PSSMXRA,9,"E"))
 ..I ($Y+5)>IOSL D HD Q:PSSMXOUT
 ..W !?14,"INTENDED USE: "_$G(PSSMXRAA(51,PSSMXRA,30,"E"))
 ..I ($Y+5)>IOSL D HD Q:PSSMXOUT
 ..W !?4,"FREQUENCY (IN MINUTES): "_$G(PSSMXRAA(51,PSSMXRA,31,"E"))
 ..I ($Y+5)>IOSL D HD Q:PSSMXOUT
 ;
END ;
 I '$G(PSSMXOUT),PSSMXRP="O",'$G(PSSMXNOF) W !!,"No Medication Instructions found without frequencies.",!
 I $G(PSSMXDEV)="P"  W !!,"End of Report.",!
 I '$G(PSSMXOUT),$G(PSSMXDEV)="C" W !!,"End of Report." K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 I $G(PSSMXDEV)="C" W !
 E  W @IOF
 K PSSMXRP,PSSMXLNG
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
HD ;Report Header
 I $G(PSSMXDEV)="C",$G(PSSMXCT)'=1 W ! K DIR,Y S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit" D ^DIR K DIR I 'Y S PSSMXOUT=1 Q
 W @IOF
 I PSSMXRP="A" W !,"MEDICATION INSTRUCTION FILE REPORT (All)"
 I PSSMXRP="O" W !,"MEDICATION INSTRUCTIONS WITHOUT FREQUENCY REPORT"
 W ?$S(PSSMXLNG=80:68,1:120),"PAGE: "_PSSMXCT,!,PSSMXLIN,! S PSSMXCT=PSSMXCT+1
 Q
 ;
MESS ;
 W !!,"Nothing queued to print.",!
 Q

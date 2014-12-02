PSSIIRPT ;BIR/JCH-Infusion Instruction Report ;10/26/12
 ;;1.0;PHARMACY DATA MANAGEMENT;**172**;9/30/07;Build 28
 ;
 ;
EN ;Prompts for Infusion Instruction File Report
 W !!,"This report displays entries from the INFUSION INSTRUCTION (#53.47) File."
 ;
 N DIR,PSSMXLNG,Y,X,DTOUT,DUOUT,DIRUT,DIROUT,IOP,%ZIS,POP,ZTRTN,ZTDESC,ZTSAVE,ZTSK
 K DIR,Y S DIR(0)="SO^80:80 Column;132:132 Column",DIR("A")="Print report in 80 or 132 column format",DIR("B")="80"
 S DIR("?")=" ",DIR("?",1)="Enter 80 to print the report in an 80 column format,",DIR("?",2)="Enter 132 to print the report in an 132 column format."
 W ! D ^DIR K DIR I $D(DUOUT)!($D(DTOUT)) D MESS K DIR,Y S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR Q
 I Y'="80",Y'="132" D MESS K DIR,Y S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR Q
 S PSSMXLNG=Y W !
 K IOP,%ZIS,POP S %ZIS="QM" D ^%ZIS I $G(POP)>0 D MESS K DIR,Y S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR,IOP,%ZIS,POP Q
 I $D(IO("Q")) S ZTRTN="START^PSSIIRPT",ZTDESC="Infusion Instruction File Report",ZTSAVE("PSSMXLNG")="" D ^%ZTLOAD K %ZIS W !!,"Report queued to print.",! D  Q
 .K DIR,Y S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 ;
 ;
START ;Print Medication Instruction File report
 U IO
 N PSSMXOUT,PSSMXNOF,PSSMXDEV,PSSMXCT,PSSMXLIN,PSSMXQ,PSSMXQEN,PSSMXRA,PSSMXRAA,PSSMXREP,PSSMXROO
 S (PSSMXOUT,PSSMXNOF)=0,PSSMXDEV=$S($E(IOST,1,2)'="C-":"P",1:"C"),PSSMXCT=1
 K PSSMXLIN S:PSSMXLNG=132 $P(PSSMXLIN,"-",130)="" S:PSSMXLNG=80 $P(PSSMXLIN,"-",78)=""
 D HD
 S PSSMXQ="" F  S PSSMXQ=$O(^PS(53.47,"B",PSSMXQ)) Q:PSSMXQ=""!(PSSMXOUT)  D
 .F PSSMXQEN=0:0 S PSSMXQEN=$O(^PS(53.47,"B",PSSMXQ,PSSMXQEN)) Q:'PSSMXQEN!(PSSMXOUT)  I '$G(^PS(53.47,"B",PSSMXQ,PSSMXQEN)) D
 ..K PSSMXRA,PSSMXRAA,PSSMXREP,PSSMXROO
 ..S PSSMXRA=PSSMXQEN_","
 ..D GETS^DIQ(53.47,PSSMXRA,".01;1","E","PSSMXRAA")
 ..S PSSMXNOF=1
 ..W !!,$G(PSSMXRAA(53.47,PSSMXRA,.01,"E"))
 ..I ($Y+5)>IOSL D HD Q:PSSMXOUT
 ..W !?17,"EXPANSION: " D
 ...S PSSMXREP=$G(PSSMXRAA(53.47,PSSMXRA,1,"E"))
 ...I PSSMXLNG=132 D  Q
 ....I $L(PSSMXREP)<104 W PSSMXREP,! Q
 ....N X,DIWL,DIWR,DIWF S X=PSSMXREP,DIWL=29,DIWR=131,DIWF="W" K ^UTILITY($J,"W") D ^DIWP D ^DIWW K ^UTILITY($J,"W")
 ...I $L(PSSMXREP)<52 W PSSMXREP,! Q
 ...N X,DIWL,DIWR,DIWF S X=PSSMXREP,DIWL=29,DIWR=79,DIWF="W" K ^UTILITY($J,"W") D ^DIWP D ^DIWW K ^UTILITY($J,"W")
 ..I ($Y+5)>IOSL D HD Q:PSSMXOUT  W !
 ..I ($Y+5)>IOSL D HD Q:PSSMXOUT  W !
 ;
END ;
 I $G(PSSMXDEV)="P"  W !!,"End of Report.",!
 I '$G(PSSMXOUT),$G(PSSMXDEV)="C" W !!,"End of Report." K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 I $G(PSSMXDEV)="C" W !
 E  W @IOF
 K PSSMXLNG
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
HD ;Report Header
 I $G(PSSMXDEV)="C",$G(PSSMXCT)'=1 W ! K DIR,Y S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit" D ^DIR K DIR I 'Y S PSSMXOUT=1 Q
 W @IOF
 W !,"INFUSION INSTRUCTION FILE REPORT"
 W ?$S(PSSMXLNG=80:68,1:120),"PAGE: "_PSSMXCT,!,PSSMXLIN,! S PSSMXCT=PSSMXCT+1
 Q
 ;
MESS ;
 W !!,"Nothing queued to print.",!
 Q

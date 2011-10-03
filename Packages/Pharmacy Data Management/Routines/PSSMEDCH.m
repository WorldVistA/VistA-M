PSSMEDCH ;BIR/RTR-Med Route Mapping Change Report ;07/03/07
 ;;1.0;PHARMACY DATA MANAGEMENT;**129**;9/30/07;Build 67
 ;
DRIVER ;
 ;Med Route Mapping History Report
 W !!!,"This report displays changes made to the mapping of Medication Routes in the"
 W !,"MEDICATION ROUTES (#51.2) File to Medication Routes in the STANDARD"
 W !,"MEDICATION ROUTES (#51.23) File.",!
 N DIR,PSSHTYPE,PSSMDONE,DIC,Y,PSSMHRSI,PSSMHRSE,PSSMHREI,PSSMHREE,PSSMHRXX,X,X1,X2,DUOUT,DTOUT,DIRUT,DIROUT,%H,IOP,%ZIS,POP,ZTRTN,ZTSAVE,ZTDESC,ZTSK
 K DIR S DIR(0)="SO^S:Single Med Route;A:All Med Routes",DIR("A")="Print report for a Single Med Route, or All Med Routes",DIR("B")="S"
 S DIR("?")=" ",DIR("?",1)="Enter 'S' to see a Standard Medication Route mapping history",DIR("?",2)="of one local Medication Route, enter 'A' to see a Standard Medication"
 S DIR("?",3)="Route mapping history of all the local Medication Routes."
 D ^DIR K DIR I $D(DUOUT)!($D(DTOUT)) D MESS Q
 I Y'="S",Y'="A" D MESS Q
 S PSSHTYPE=Y
 I PSSHTYPE="A" G DATE
 K DIC W ! S DIC="^PS(51.2,",DIC(0)="QEAM",DIC("A")="Select Med Route: " D ^DIC K DIC I Y<1!($D(DUOUT))!($D(DTOUT)) D MESS Q
 S PSSMDONE=+Y
DATE ;
 W !
 K DIR W ! S DIR(0)="DAO^:DT:APEX",DIR("A")="Beginning Date: ",DIR("?")=" ",DIR("?",1)="Enter the date to begin searching for Medication Route mapping changes.",DIR("?",2)="A future date cannot be entered." D ^DIR K DIR
 I 'Y!($D(DTOUT))!($D(DUOUT)) D MESS Q
 S (PSSMHRSI,PSSMHRXX)=Y D DD^%DT S PSSMHRSE=Y
 K X S X1=PSSMHRSI,X2=-1 D C^%DTC S PSSMHRSI=X_".9999"
 W ! K DIR S DIR(0)="DAO^"_PSSMHRXX_"::APEX",DIR("A")="Ending Date: ",DIR("?")=" ",DIR("?",1)="Enter the ending date of the search for Medication Route mapping changes.",DIR("?",2)="This date cannot be before the beginning date." D ^DIR K DIR
 I 'Y!($D(DTOUT))!($D(DUOUT)) D MESS Q
 S PSSMHREI=Y D DD^%DT S PSSMHREE=Y
 K X S X1=PSSMHREI,X2=+1 D C^%DTC S PSSMHREI=X
 W ! K IOP,%ZIS,POP S %ZIS="QM" D ^%ZIS I $G(POP) D MESS Q
 I $D(IO("Q")) D  K IOP,%ZIS,POP,DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR Q
 .S ZTRTN="START^PSSMEDCH",ZTDESC="Medication Route Mapping History report",ZTSAVE("PSSHTYPE")="",ZTSAVE("PSSMDONE")="",ZTSAVE("PSSMHRSI")="",ZTSAVE("PSSMHRSE")="",ZTSAVE("PSSMHREI")="",ZTSAVE("PSSMHREE")="" D ^%ZTLOAD D
 .W !!,"Report queued to print.",!
START ;
 U IO
 N PSSMHRLN,PSSMHOUT,PSSMHDEV,PSSMHCT,PSSMHLEN,PSSMHNAM
 N PSSMHRG1,PSSMHRG2,PSSMHRG3,PSSMHRG4,PSSMHRG5,PSSMHRG7,PSSMHRG9
 S PSSMHRG9=0
 I PSSHTYPE="S" S PSSMHNAM=$P($G(^PS(51.2,+PSSMDONE,0)),"^"),PSSMHLEN=$L(PSSMHNAM)
 S PSSMHOUT=0,PSSMHDEV=$S($E(IOST,1,2)'="C-":"P",1:"C"),PSSMHCT=1
 K PSSMHRLN S $P(PSSMHRLN,"-",79)=""
 D HD
 I PSSHTYPE="S" D  G END
 .F PSSMHRG1=PSSMHRSI:0 S PSSMHRG1=$O(^PS(51.2,PSSMDONE,2,"B",PSSMHRG1)) Q:'PSSMHRG1!(PSSMHRG1'<PSSMHREI)!(PSSMHOUT)  D
 ..F PSSMHRG2=0:0 S PSSMHRG2=$O(^PS(51.2,PSSMDONE,2,"B",PSSMHRG1,PSSMHRG2)) Q:'PSSMHRG2!(PSSMHOUT)  D
 ...S PSSMHRG7=$G(^PS(51.2,PSSMDONE,2,PSSMHRG2,0)) Q:PSSMHRG7=""
 ...S PSSMHRG4=PSSMHRG2_","_PSSMDONE_","
 ...D PRINT
 F PSSMHRG1=PSSMHRSI:0 S PSSMHRG1=$O(^PS(51.2,"D",PSSMHRG1)) Q:'PSSMHRG1!(PSSMHRG1'<PSSMHREI)!(PSSMHOUT)  D
 .F PSSMHRG2=0:0 S PSSMHRG2=$O(^PS(51.2,"D",PSSMHRG1,PSSMHRG2)) Q:'PSSMHRG2!(PSSMHOUT)  D
 ..F PSSMHRG3=0:0 S PSSMHRG3=$O(^PS(51.2,"D",PSSMHRG1,PSSMHRG2,PSSMHRG3)) Q:'PSSMHRG3!(PSSMHOUT)  D
 ...S PSSMHRG7=$G(^PS(51.2,PSSMHRG2,2,PSSMHRG3,0)) Q:PSSMHRG7=""
 ...S PSSMHRG4=PSSMHRG3_","_PSSMHRG2_","
 ...S PSSMHNAM=$P($G(^PS(51.2,PSSMHRG2,0)),"^")
 ...D PRINT
END ;
 I '$G(PSSMHOUT),'$G(PSSMHRG9) W !!,?2,"No mapping changes to report.",!
 I $G(PSSMHDEV)="P" W !!,"End of Report.",!
 I '$G(PSSMHOUT),$G(PSSMHDEV)="C" W !!,"End of Report.",! K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 I $G(PSSMHDEV)="C" W !
 E  W @IOF
 K PSSHTYPE,PSSMDONE,PSSMHRSI,PSSMHRSE,PSSMHREI,PSSMHREE D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
PRINT ;
 S PSSMHRG9=1
 K PSSMHRG5 D GETS^DIQ(51.27,PSSMHRG4,".01;1;2;3","E","PSSMHRG5")
 W !!,?2,"Medication Route: "_$G(PSSMHNAM)
 W !?9,"Date/Time: "_$G(PSSMHRG5(51.27,PSSMHRG4,.01,"E"))
 I ($Y+5)>IOSL D HD Q:PSSMHOUT
 W !?9,"Edited By: "_$S($G(PSSMHRG5(51.27,PSSMHRG4,1,"E"))'="":$G(PSSMHRG5(51.27,PSSMHRG4,1,"E")),1:"AUTOMAPPED")
 I ($Y+5)>IOSL D HD Q:PSSMHOUT
 W !?9,"Old Value: "_$S($G(PSSMHRG5(51.27,PSSMHRG4,2,"E"))'="":$G(PSSMHRG5(51.27,PSSMHRG4,2,"E")),1:"<no previous value>")
 I ($Y+5)>IOSL D HD Q:PSSMHOUT
 W !?9,"New Value: "_$S($G(PSSMHRG5(51.27,PSSMHRG4,3,"E"))'="":$G(PSSMHRG5(51.27,PSSMHRG4,3,"E")),1:"<no new value>")
 I ($Y+5)>IOSL D HD Q:PSSMHOUT
 Q
 ;
HD ;
 I $G(PSSMHDEV)="C",$G(PSSMHCT)'=1 W ! K DIR S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit" D ^DIR K DIR I 'Y S PSSMHOUT=1 Q
 W @IOF
 I PSSHTYPE="A" W !,"Medication Route mapping changes for ALL Medication Routes"
 I PSSHTYPE="S" W !,"Medication Route mapping changes for " D
 .I +PSSMHLEN<43 W PSSMHNAM Q
 .W !,?34,PSSMHNAM
 W !,"made between "_PSSMHRSE_" and "_PSSMHREE,?68,"PAGE: "_PSSMHCT,!,PSSMHRLN,! S PSSMHCT=PSSMHCT+1
 Q
MESS ;
 W !!,"Nothing queued to print.",!
 K DIR W ! S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 Q

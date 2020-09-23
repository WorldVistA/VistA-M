PSSINSTR ;HPS/RTR-Medication Route Utilities ; 4/23/20 3:36pm
 ;;1.0;PHARMACY DATA MANAGEMENT;**245**;;Build 4
 Q
REP ;Med Instruction Med Route Report
 W !!,"This report displays matches between the Medication Instruction file (#51)"
 W !,"and the Medication Routes file (#51.2) when a Name in the Medication"
 W !,"Instruction file matches an Abbreviation in the Medication Routes file."
 ;
 N DIR,Y,X,DTOUT,DUOUT,DIRUT,DIROUT,IOP,%ZIS,POP,ZTRTN,ZTDESC,ZTSAVE,ZTSK
 K IOP,%ZIS,POP S %ZIS="QM" D ^%ZIS I $G(POP)>0 W !!,"No Action taken.",! K DIR,Y S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR,IOP,%ZIS,POP Q
 I $D(IO("Q")) S ZTRTN="START^PSSINSTR",ZTDESC="Med Instruction Med Route Report" D ^%ZTLOAD K %ZIS W !!,"Report queued to print.",! K DIR,Y S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR Q
START ;
 U IO
 N DIR,DUOUT,DTOUT,Y,X,DIRUT,DIROUT
STARTX ;
 N PSSTLINE,PSSTOUT,PSSTDV,PSSTCT,DIR,DUOUT,DTOUT,Y,X,DIRUT,DIROUT
 N PSSIIEN,PSSINAM,PSSINS,PSSRIEN,PSSRNAM
 S PSSTOUT=0,PSSTDV=$S($E(IOST,1,2)'="C-":"P",1:"C"),PSSTCT=1
 K PSSTLINE S $P(PSSTLINE,"-",75)=""
 D HD
 S PSSINS="" F  S PSSINS=$O(^PS(51,"B",PSSINS)) Q:PSSINS=""!(PSSTOUT)  D
 . Q:'$D(^PS(51.2,"C",PSSINS))
 . S PSSIIEN=$O(^PS(51,"B",PSSINS,0)),PSSRIEN=$O(^PS(51.2,"C",PSSINS,0))
 . S PSSINAM=$E($P(^PS(51,PSSIIEN,0),U,2),1,30) ;Instruction Name
 . S PSSRNAM=$P(^PS(51.2,PSSRIEN,0),U,1) ;Route Abbreviation
 . W !,PSSINS,?12,$E(PSSINAM,1,30),?43,$E(PSSRNAM,1,30)
 . I ($Y+5)>IOSL D HD Q:PSSTOUT
END ;
 I $G(PSSTDV)="P" W !!,"End of Report."
 I '$G(PSSTOUT),$G(PSSTDV)="C" W !!,"End of Report." K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 I $G(PSSTDV)="C" W !
 E  W @IOF
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
HD ;
 I $G(PSSTDV)="C",$G(PSSTCT)'=1 W ! K DIR S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit" D ^DIR K DIR I 'Y S PSSTOUT=1 Q
 W @IOF W !,"MED INSTRUCTION MED ROUTE REPORT",?65,"Page: "_$G(PSSTCT) S PSSTCT=PSSTCT+1
 W !!,"NAME/ABBR",?12,"INSTR EXPANSION",?43,"ROUTE NAME"
 W !,PSSTLINE
 Q

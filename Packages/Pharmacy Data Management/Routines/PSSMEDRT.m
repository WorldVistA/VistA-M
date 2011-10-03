PSSMEDRT ;BIR/RTR-Medication Route Utilities ;06/14/07
 ;;1.0;PHARMACY DATA MANAGEMENT;**129**;9/30/97;Build 67
 ;
MATCH ;Match File 51.2 Med Routes to Standard Med Routes
 ;Mainly for use only for the initial set up of the 0.5 Order Checks
 W !!,"This option will find local Medication Routes marked for 'ALL PACKAGES' not",!,"mapped to a Standard Medication Route, and prompt you to map the local route.",!
 W "This mapping is necessary to perform Dosage checks.",!!,"Searching for unmapped Med Routes..."
 N PSSMRLP,PSSMRLNN,PSSMRLFL,PSSMRLND,PSSMRLOK,PSSMRLAA,DIC,DIE,DA,DR,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S PSSMRLFL=0
 S PSSMRLP="" F  S PSSMRLP=$O(^PS(51.2,"B",PSSMRLP)) Q:PSSMRLP=""!(PSSMRLFL)  F PSSMRLNN=0:0 S PSSMRLNN=$O(^PS(51.2,"B",PSSMRLP,PSSMRLNN)) Q:'PSSMRLNN!(PSSMRLFL)  D
 .K PSSMRLND,PSSMRLOK,PSSMRLAA,DIC,DIE,DA,DR,DIR,X,Y
 .S PSSMRLND=$G(^PS(51.2,PSSMRLNN,0))
 .I '$P(PSSMRLND,"^",4) Q
 .I $P($G(^PS(51.2,PSSMRLNN,1)),"^") Q
 .W !!!,"Mapping local Med Route of '"_$P(PSSMRLND,"^")_"'",!
 .L +^PS(51.2,PSSMRLNN):$S($G(DILOCKTM)>0:DILOCKTM,1:3)
 .I '$T W !!,"Another person is editing this Med Route." D  Q
 ..W ! K DIR,DTOUT,DUOUT S DIR(0)="Y",DIR("B")="Y",DIR("A")="Do you want to continue mapping Med Routes",DIR("?")="Enter 'Y' to continue mapping Med Routes, enter 'N' or '^' to exit"
 ..D ^DIR K DIR I Y'=1!($D(DTOUT))!($D(DUOUT)) S PSSMRLFL=1
 .K DIC,DTOUT,DUOUT S DIC=51.23,DIC(0)="AEMQZ",DIC("W")="W ""  FDB Route: ""_$P(^(0),""^"",2)"
 .S DIC("S")="I '$$SCREEN^XTID(51.23,.01,+Y_"","")"
 .D ^DIC K DIC
 .I $D(DTOUT)!($D(DUOUT)) D  D UNL Q
 ..W !! K DIR,DTOUT,DUOUT S DIR(0)="Y",DIR("B")="Y",DIR("A")="Do you want to continue mapping Med Routes",DIR("?")="Enter 'Y' to continue mapping Med Routes, enter 'N' or '^' to exit"
 ..D ^DIR K DIR I Y'=1!($D(DTOUT))!($D(DUOUT)) S PSSMRLFL=1
 .I +Y'>0 D UNL Q
 .S PSSMRLOK=+Y
 .K DIE,DA,DR S DIE=51.2,DA=PSSMRLNN,DR="10////^S X=+PSSMRLOK" D ^DIE K DA,DIE,DR
 .S PSSMRLAA=$P($G(^PS(51.2,PSSMRLNN,1)),"^")
 .I 'PSSMRLAA W !!!,"Unable to make this match!!" D  D UNL Q
 ..W ! K DIR,DTOUT,DUOUT S DIR(0)="Y",DIR("B")="Y",DIR("A")="Do you want to continue mapping Med Routes",DIR("?")="Enter 'Y' to continue mapping Med Routes, enter 'N' or '^' to exit"
 ..D ^DIR K DIR I Y'=1!($D(DTOUT))!($D(DUOUT)) S PSSMRLFL=1
 .W !!!,"Local Route: '"_$P(PSSMRLND,"^")_"' has been mapped to",!,"Stnd Route: '"_$P($G(^PS(51.23,PSSMRLAA,0)),"^")_"'   FDB Route: '"_$P($G(^(0)),"^",2)_"'"
 .D UNL
 W !!!,"Checking for any remaining unmapped Local Med Routes..."
 S (PSSMRLFL,PSSMRLNN)=0
 S PSSMRLP="" F  S PSSMRLP=$O(^PS(51.2,"B",PSSMRLP)) Q:PSSMRLP=""!(PSSMRLFL)  F PSSMRLNN=0:0 S PSSMRLNN=$O(^PS(51.2,"B",PSSMRLP,PSSMRLNN)) Q:'PSSMRLNN!(PSSMRLFL)  D
 .K PSSMRLND
 .S PSSMRLND=$G(^PS(51.2,PSSMRLNN,0))
 .I '$P(PSSMRLND,"^",4) Q
 .I '$P($G(^PS(51.2,PSSMRLNN,1)),"^") S PSSMRLFL=1
 I PSSMRLFL W !!!,"There are still local Med Routes marked for 'ALL PACKAGES' not yet mapped,",!,"see the 'Medication Route Mapping Report' option for more details.",!
 I 'PSSMRLFL W !!!,"All Local Med Routes are mapped!",!
 W ! K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 Q
UNL ;Unlock Med Route
 Q:'$G(PSSMRLNN)
 L -^PS(51.2,PSSMRLNN)
 Q
 ;
ONE ;Map one Local Medication Routes to Standard Route
 N DIC,PSSMRB,PSSMRBA,PSSMRBAX,PSSMRBAZ,DA,DIQ,DIR,DIE,DR,PSSMRB1,PSSMRB2,PSSMRB3,PSSONEXT,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
ONEX ;
 K DIC,PSSMRB,PSSMRBA,PSSMRBAX,PSSMRBAZ,DA,DIQ,DIR,DIE,DR,PSSMRB1,PSSMRB2,PSSMRB3,PSSONEXT
 W ! K DIC,DTOUT,DUOUT S DIC=51.2,DIC(0)="QEAMZ",DIC("S")="I $P($G(^PS(51.2,+Y,0)),""^"",4)" D ^DIC K DIC
 I $D(DTOUT)!($D(DUOUT))!(+Y'>0) W ! Q
 S (DA,PSSMRB)=+Y
 K ^UTILITY("DIQ1",$J) K DIQ,PSSMRBA S DIC=51.2,DR="10",DIQ="PSSMRBA",DIQ(0)="EI" D EN^DIQ1
 K ^UTILITY("DIQ1",$J) K DIQ
 W !!!,$P($G(^PS(51.2,PSSMRB,0)),"^")
 S PSSMRB1=$G(PSSMRBA(51.2,PSSMRB,10,"I"))
 I $G(PSSMRBA(51.2,PSSMRB,10,"E"))'="" D  I $G(PSSONEXT) G ONEX
 .W !!,"Already mapped to:",!,"Stnd Route: '"_$G(PSSMRBA(51.2,PSSMRB,10,"E"))_"'  FDB Route: '"_$P($G(^PS(51.23,+$G(PSSMRBA(51.2,PSSMRB,10,"I")),0)),"^",2)_"'"
 .W ! K DIR,PSSONEXT S DIR(0)="Y",DIR("B")="N",DIR("A")="Do you want to remap to a different Standard Med Route"
 .S DIR("?")=" ",DIR("?",1)="Enter 'Y' to map to a different Standard Med Route,",DIR("?",2)="enter 'N' or Press <ret> to not change this mapping."
 .K DTOUT,DUOUT D ^DIR K DIR I Y'=1!($D(DTOUT))!($D(DUOUT)) S PSSONEXT=1
 L +^PS(51.2,PSSMRB):$S($G(DILOCKTM)>0:DILOCKTM,1:3)
 I '$T W !!,"Another person is editing this Med Route." D  G ONEX
 .W ! K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 W ! K DIC,DTOUT,DUOUT S DIC=51.23,DIC(0)="AEMQZ",DIC("W")="W ""  FDB Route: ""_$P(^(0),""^"",2)"
 S DIC("S")="I '$$SCREEN^XTID(51.23,.01,+Y_"","")"
 D ^DIC K DIC
 I $D(DTOUT)!($D(DUOUT))!(+Y'>0) D  D ONEUL G ONEX
 .I $G(PSSMRBA(51.2,PSSMRB,10,"E"))'="" W !!,"Mapping remains unchanged.",! Q
 .W !!,"Nothing mapped - No dosing checks will be performed on orders containing this",!,"local medication route until it is mapped to a standard medication route.",!
 S (PSSMRBAX,PSSMRB2)=+Y
 K DIE,DR,DA S DIE=51.2,DA=PSSMRB,DR="10////^S X=+PSSMRBAX" D ^DIE K DA,DIE,DR
 S PSSMRBAZ=$P($G(^PS(51.2,PSSMRB,1)),"^")
 I 'PSSMRBAZ W !!!,"Unable to make this match, Med Route is unmatched",! D  D ONEUL G ONEX
 .W !,"Nothing mapped - No dosing checks will be performed on orders containing this",!,"local medication route until it is mapped to a standard medication route.",!
 S PSSMRB3=0 I PSSMRB1,PSSMRB2,PSSMRB1'=PSSMRB2 S PSSMRB3=1
 W !!!,"Local Route: '"_$P($G(^PS(51.2,PSSMRB,0)),"^")_"' has been "_$S(PSSMRB3:"remapped",1:"mapped")_" to",!,"Stnd Route: '"_$P($G(^PS(51.23,PSSMRBAZ,0)),"^")_"'   FDB Route: '"_$P($G(^(0)),"^",2)_"'",!
 D ONEUL
 G ONEX
 Q
ONEUL ;Unlock Med route
 Q:'$G(PSSMRB)
 L -^PS(51.2,PSSMRB)
 Q
REP ;Med Route Report
 W !!!,"This report will print Medication Route mapping information for Medication",!,"Routes marked for ALL PACKAGES in the PACKAGE USE (#3) Field of the MEDICATION"
 W !,"ROUTES (#51.2) File.",!
 N DIR,PSSPTYPE,DUOUT,DTOUT,Y,IOP,%ZIS,POP,ZTRTN,ZTDESC,ZTSAVE,X,DIRUT,DIROUT,ZTSK
 K DIR,DUOUT,DTOUT S DIR(0)="SO^A:ALL MEDICATION ROUTES;O:ONLY UNMAPPED MEDICATION ROUTES",DIR("A")="Enter 'A' for All Routes, 'O' for Only Unmapped Routes",DIR("B")="O"
 S DIR("?")=" ",DIR("?",1)="Enter 'A' to see All Medication Routes from the Medication Routes (#51.2) File",DIR("?",2)="along with the mapping information for the Routes that are mapped."
 S DIR("?",3)="Enter 'O' to see a list of Only those Routes that have not yet been mapped."
 D ^DIR K DIR I $D(DUOUT)!($D(DTOUT)) W !!,"No Action taken.",! K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR Q
 I Y'="A",Y'="O" W !!,"No Action taken.",! K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR Q
 S PSSPTYPE=Y
 W !!?3,"This report is designed for 132 column format!",!
 K IOP,%ZIS,POP S %ZIS="QM" D ^%ZIS I $G(POP)>0 W !!,"No Action taken.",! K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR,IOP,%ZIS,POP Q
 I $D(IO("Q")) S ZTRTN="START^PSSMEDRT",ZTDESC="Medication Routes Mapping Report",ZTSAVE("PSSPTYPE")="" D ^%ZTLOAD W !!,"Report queued to print.",! K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR,IOP,%ZIS,POP Q
 U IO G STARTX
START ;
 U IO
 N DIR,DUOUT,DTOUT,Y,X,DIRUT,DIROUT
STARTX ;
 N PSSTLINE,PSSTOUT,PSSTDV,PSSTCT,PSSMT,PSSMTI,PSSMTNAM,PSSMTMAP,PSSMTEXP,PSSMTCTA,PSSMTCTB,DIR,DUOUT,DTOUT,Y,X,DIRUT,DIROUT
 S (PSSMTCTA,PSSMTCTB)=0
 S PSSTOUT=0,PSSTDV=$S($E(IOST,1,2)'="C-":"P",1:"C"),PSSTCT=1
 K PSSTLINE S $P(PSSTLINE,"-",130)=""
 D HD
 S PSSMT="" F  S PSSMT=$O(^PS(51.2,"B",PSSMT)) Q:PSSMT=""!(PSSTOUT)  D
 .F PSSMTI=0:0 S PSSMTI=$O(^PS(51.2,"B",PSSMT,PSSMTI)) Q:'PSSMTI!(PSSTOUT)  D
 ..I '$P($G(^PS(51.2,PSSMTI,0)),"^",4) Q
 ..S PSSMTNAM=$P($G(^PS(51.2,PSSMTI,0)),"^"),PSSMTEXP=$P($G(^PS(51.2,PSSMTI,0)),"^",2),PSSMTMAP=$P($G(^PS(51.2,PSSMTI,1)),"^")
 ..I PSSPTYPE="O",PSSMTMAP Q
 ..S PSSMTCTA=PSSMTCTA+1 I 'PSSMTMAP S PSSMTCTB=PSSMTCTB+1
 ..I PSSPTYPE="O" W !!,PSSMTNAM I PSSMTEXP'="" W !,?4,PSSMTEXP
 ..I PSSPTYPE'="O" W !!,PSSMTNAM,?47,$P($G(^PS(51.23,+PSSMTMAP,0)),"^"),?100,$P($G(^PS(51.23,+PSSMTMAP,0)),"^",2) I PSSMTEXP'="" W !,?4,PSSMTEXP
 ..K PSSMTNAM,PSSMTEXP,PSSMTMAP
 ..I ($Y+5)>IOSL D HD Q:PSSTOUT
 I 'PSSTOUT D
 .D HD
 .I PSSTOUT Q
 .I PSSPTYPE="O" W !!,"TOTAL UNMAPPED MEDICATION ROUTES = "_$G(PSSMTCTB)
 .I PSSPTYPE'="O" W !!,"TOTAL LOCAL MEDICATION ROUTES = "_$G(PSSMTCTA),!,"TOTAL UNMAPPED LOCAL MEDICATION ROUTES = "_$G(PSSMTCTB)
END ;
 K PSSPTYPE
 I $G(PSSTDV)="P" W !!,"End of Report."
 I '$G(PSSTOUT),$G(PSSTDV)="C" W !!,"End of Report." K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 I $G(PSSTDV)="C" W !
 E  W @IOF
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
HD ;
 I $G(PSSTDV)="C",$G(PSSTCT)'=1 W ! K DIR S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit" D ^DIR K DIR I 'Y S PSSTOUT=1 Q
 W @IOF W !,$S(PSSPTYPE="O":"MEDICATION ROUTES MAPPING EXCEPTION REPORT",1:"MEDICATION ROUTES MAPPING REPORT"),?114,"Page: "_$G(PSSTCT) S PSSTCT=PSSTCT+1
 I PSSPTYPE="O" W !!,"MEDICATION ROUTES (File 51.2)"
 I PSSPTYPE'="O" W !!,"MEDICATION ROUTES (File 51.2)",?47,"STANDARD ROUTE",?100,"FDB ROUTE"
 W !?4,"OUTPATIENT EXPANSION",!,PSSTLINE
 Q

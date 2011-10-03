PSSDFEE ;BIR/ASJ-VARIOUS FILES ENTER EDIT ROUTINE ;01/21/00
 ;;1.0;PHARMACY DATA MANAGEMENT;**38,48,125,129**;9/30/97;Build 67
DF ;Dosage File Enter/Edit
 D ^PSSDEE2 N DIC,PSSDF,DLAYGO,PSSREC,X,Y,D,%,%X,%Y,DIE,DA,DR,DIR,DTOUT,DUOUT,DIROUT,DIRUT,D0
 F  W !! S DIC(0)="QEAMZ",DIC="^PS(50.606,",DIC("S")="I '$P(^(0),""^"",2)!($P(^(0),""^"",2)>DT)" D ^DIC S PSSREC=+Y Q:PSSREC<0  W !!,"NAME: ",Y(0,0) D EDT(DIC,PSSREC,"[PSS DOSAGE FORM]",50.606)
 W ! Q
MR ;Medication Routes File Enter/Edit
 D ^PSSDEE2 N DIC,PSSDF,DLAYGO,PSSDMRA,PSSREC,X,Y,D,%,%X,%Y,PSSDMRQT,DIE,DA,DR,DIR,DTOUT,DUOUT,DIROUT,DIRUT,PSSDMREN,D0
 S PSSDMRQT=0 F  Q:PSSDMRQT  W !! S DIC(0)="QEAMZIL",DIC="^PS(51.2,",DLAYGO=51.2 D ^DIC Q:Y<0  S (PSSREC,PSSDMREN)=+Y  S PSSDMRA=$P($G(^PS(51.2,PSSREC,1)),"^") D EDT(DIC,PSSREC,"[PSS MEDICATION ROUTES]",51.2)
 W ! Q
CF ;Rx Consult File
 Q
 ; It was decided not to put this functionality in PSS*1*38
 D ^PSSDEE2 N DIC,PSSDF,DLAYGO
 F  W !! S DIC(0)="QEAMZIL",DIC="^PS(54,",DLAYGO=54 D ^DIC Q:Y<0  S PSSREC=+Y D EDT(DIC,PSSREC,"[PSS RX CONSULT]",54)
 W @IOF Q
 ;
EDT(DIE,DA,DR,PSFILE)    ;
 N PSREC S PSREC=DA
 L +^PS(PSFILE,PSREC):$S($G(DILOCKTM)>0:DILOCKTM,1:3)
 I '$T W !!,$C(7),"Another person is editing this entry." Q
 K DTOUT D ^DIE
 I PSFILE=51.2 I $D(Y)!($D(DTOUT)) D:'$P($G(^PS(51.2,PSSDMREN,1)),"^")&($P($G(^PS(51.2,PSSDMREN,0)),"^",4)) MESS L -^PS(PSFILE,PSREC) Q
 K DIE,DR,DA,Y
 I PSFILE=51.2 D STN
 L -^PS(PSFILE,PSREC)
 Q
 ;
STN ;Standard Med Route Mapping
 N PSSDMRX,PSSDMRNW,PSSDMRFL
 I '$P($G(^PS(51.2,PSSDMREN,0)),"^",4) Q
 I PSSDMRA S PSSDMRX=0 D  I PSSDMRX Q:PSSDMRQT  W !!,"Mapping Remains Unchanged.",! K DIR S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit" D ^DIR K DIR S:$D(DTOUT)!($D(DUOUT)) PSSDMRQT=1 Q
 .W !!,"Already mapped to:",!,"Stnd Route: '"_$P($G(^PS(51.23,PSSDMRA,0)),"^")_"'  FDB Route: '"_$P($G(^PS(51.23,PSSDMRA,0)),"^",2)_"'"
 .W ! K DIR,Y S DIR(0)="Y",DIR("B")="N",DIR("A")="Do you want to remap to a different Standard Med Route"
 .S DIR("?")=" ",DIR("?",1)="Enter 'Y' to map to a different Standard Med Route,",DIR("?",2)="enter 'N' or Press <ret> to not change this mapping."
 .K DTOUT,DUOUT D ^DIR K DIR S:$D(DTOUT)!($D(DUOUT)) PSSDMRQT=1 I Y'=1!($D(DTOUT))!($D(DUOUT)) S PSSDMRX=1
 W ! S DA=PSSDMREN,DIE="^PS(51.2,",DR=10 D ^DIE I $D(Y)!($D(DTOUT)) D:'$P($G(^PS(51.2,PSSDMREN,1)),"^") MESSA W ! K DIR S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit" D ^DIR K DIR S:$D(DTOUT)!($D(DUOUT)) PSSDMRQT=1 Q
 S PSSDMRNW=$P($G(^PS(51.2,PSSDMREN,1)),"^")
 I 'PSSDMRNW D MESS Q
 S PSSDMRFL=0 I PSSDMRA,PSSDMRNW,PSSDMRA'=PSSDMRNW S PSSDMRFL=1
 I PSSDMRA,PSSDMRNW,'PSSDMRFL D  W ! K DIR S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit" D ^DIR S:$D(DTOUT)!($D(DUOUT)) PSSDMRQT=1 K DIR Q
 .W !!,"No mapping changes made.",!
 .W !,"Local Route: '"_$P($G(^PS(51.2,PSSDMREN,0)),"^")_"' remains mapped to",!,"Stnd Route: '"_$P($G(^PS(51.23,PSSDMRNW,0)),"^")_"'   FDB Route: '"_$P($G(^(0)),"^",2)_"'"
 W !!!,"Local Route: '"_$P($G(^PS(51.2,PSSDMREN,0)),"^")_"' has been "_$S(PSSDMRFL:"remapped",1:"mapped")_" to",!,"Stnd Route: '"_$P($G(^PS(51.23,PSSDMRNW,0)),"^")_"'   FDB Route: '"_$P($G(^(0)),"^",2)_"'",!
 W ! K DIR S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit" D ^DIR S:$D(DTOUT)!($D(DUOUT)) PSSDMRQT=1 K DIR
 Q
 ;
MESS ;
 W !!!," *** No dosing checks will be performed on orders containing this local",!,"  medication route until it is mapped to a standard medication route.***",!
 W ! K DIR S DIR(0)="E",DIR("A")="Press Return to continue, '^' to exit" D ^DIR S:$D(DTOUT)!($D(DUOUT)) PSSDMRQT=1 K DIR
 Q
MESSA ;
 W !!!," *** No dosing checks will be performed on orders containing this local",!,"  medication route until it is mapped to a standard medication route.***",!
 Q

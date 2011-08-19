PSAWARD ;BIR/LTL,JMB-Set Up/Edit a Pharmacy Location ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;; 10/24/97
 ;This routine links wards to the pharmacy location.
 ;
 N DIC,DIE,D0,D1,DLAYGO,DR,DIR,DIRUT,DTOUT,DUOUT,DA,PSAW,PSADR,X,Y,PSAOUT
 W @IOF,!?5,"For the purpose of collecting Unit Dose and IV dispensing data,",!,"any ward at which such dispensing might ever occur should be added."
 W !,"The ONLY reason to NOT add a ward would be if the dispensing at that ward",!,"should NOT update ",$G(PSALOCN),"."
 W !!,"There is NO harm in adding inactive wards."
 I '$D(^PSD(58.8,+PSALOC,3,0)) S ^(0)="^58.842P^^"
ALL I $G(PSA(2))=1 S PSA(3)=0,DIC="^PSD(58.8,+PSALOC,3,",DA(1)=PSALOC,DIC(0)="LNX" W !!,PSALOCN," is linked to " F  S (DA,DINUM,X,PSA(3))=$O(^DIC(42,PSA(3))) Q:'PSA(3)  K DD,DO D:'$G(^PSD(58.8,+PSALOC,3,+PSA(3),0)) FILE^DICN D
 .W $P($G(^DIC(42,+PSA(3),0)),U) W:$O(^DIC(42,PSA(3))) ", "
 .I '$O(^DIC(42,PSA(3))) W ".",!
 .W:$X+10>IOM !!
 K DINUM
 G:$G(PSA(2))=1 QUIT
MUL I $O(^PSD(58.8,+PSALOC,3,0)) D  G:$G(PSAOUT) QUIT
 .S PSA(3)=0
 .W !!,"The following wards are currently connected to ",PSALOCN,":",!!
 .F  S PSA(3)=$O(^PSD(58.8,+PSALOC,3,+PSA(3))) Q:'PSA(3)  W:$X+10>IOM !! W $P($G(^DIC(42,+PSA(3),0)),U),$S($O(^PSD(58.8,+PSALOC,3,+PSA(3))):", ",1:".")
 .S DIR(0)="Y",DIR("A")="Do you wish to change this",DIR("B")="No",DIR("?")="Any dispensing to these wards by the UD or IV modules will update this location"
 .W ! D ^DIR K DIR I Y'=1 S PSAOUT=1 Q
 .S DIR(0)="SBOA^A:ADD;D:DELETE",DIR("A")="Do you wish to ADD or DELETE WARDS?  (A/D): "
 .S DIR("?",1)="Enter 'A' to ADD a Ward, 'D' to DELETE a Ward"
 .S DIR("?")="or '^' to quit" D ^DIR K DIR S PSAOUT(1)=Y I $D(DIRUT) S PSAOUT=1 Q
 .I Y="D" S DIC="^PSD(58.8,+PSALOC,3,",DIC(0)="AEMQ",DA(1)=PSALOC,DIC("A")="Select "_$G(PSALOCN)_" WARD: " F  D ^DIC Q:Y<0!(Y="")  S PSAW=+Y,PSAW(1)=$P($G(^DIC(42,+PSAW,0)),U) D  I $D(DIRUT) S PSAOUT=1 Q
 ..S DIR(0)="Y",DIR("A")="OK to delete "_$G(PSAW(1))
 ..S DIR("B")="No",DIR("?")="If yes, I'll remove it from "_$G(PSALOCN)
 ..D ^DIR I Y'=1 S PSAOUT=1 Q
 ..S DIK=DIC,DA(1)=PSALOC,DA=PSAW D ^DIK W !,$G(PSAW(1))," deleted."
 .K DIC,DIK,DA,PSAW S:PSAOUT(1)'="A" PSAOUT=1
 S DIR(0)="SBOA^A:ALL;R:RANGE",DIR("A")="Do you wish to add ALL wards or select a RANGE of wards?  (A/R): "
 S DIR("?",1)="Enter 'A' to add ALL wards, 'R' to select a range"
 S DIR("?")="or '^' to quit" D ^DIR K DIR I $D(DIRUT) S PSAOUT=1 Q
 I Y="A" S PSA(2)=1 G ALL
 S PSAW=0,(PSA,PSA(3))=1,PSA(2)=20
LOOP F PSA=PSA:1:PSA(2) S PSAW=$O(^DIC(42,PSAW)) Q:'PSAW  S PSA=PSA-1 I '$O(^PSD(58.8,"AB",+PSAW,0)) S PSA=PSA+1 W !,PSA,?10,$P($G(^DIC(42,PSAW,0)),U) S PSADR(PSA)=PSAW W:$D(^DIC(42,+PSAW,"I")) ?40,"***INACTIVE***"
 I PSA=1 W !!,"Sorry, you've already added all the wards that you can." G QUIT
 S:$O(PSADR(PSA)) PSA=$O(PSADR(PSA))
 I $G(PSAW) F PSAW(1)=PSAW:0 S PSAW(1)=$O(^DIC(42,PSAW(1))) Q:'PSAW(1)!($G(PSAW(2))>19)  I '$O(^PSD(58.8,"AB",+PSAW(1),0)) S PSAW(2)=$G(PSAW(2))+1
 I $G(PSA)'>$G(PSA(3)) G QUIT
 S PSA(2)=$G(PSA(2))+$G(PSAW(2))
 S DIR("?")="You can only select wards that are not yet linked to a location"
 S DIR(0)="LA^"_PSA(3)_":"_$S($O(PSADR((PSA-1))):PSA,1:PSA-1),DIR("A",1)="Select the ward(s) or range of wards from which you want "_PSALOCN,DIR("A")="to collect dispensing data: " D ^DIR K DIR G:$D(DIRUT) QUIT S PSAC=Y
 S DIC="^PSD(58.8,"_+PSALOC_",3,",DIC(0)="LNX",DA(1)=PSALOC
 F PSAB=1:1:PSA I $P($G(PSAC),",",PSAB) K DD,DO S (DA,DINUM,X)=$G(PSADR($P(PSAC,",",PSAB))) D FILE^DICN W "." K DINUM,PSA(1) Q:$G(PSAOUT)
 K PSAB I $G(PSAW(2)) W @IOF S (PSA,PSA(3))=$G(PSA)+1 G LOOP
 K DIC,PSA,PSADR G MUL
QUIT I '$D(DIRUT) W ! S DIE="^PS(59.7,",DA=$O(^PS(59.7,0)),DR="72Inpatient Dispensing Update?" D ^DIE K DIE,DA S:$D(Y) PSAOUT=1
 Q

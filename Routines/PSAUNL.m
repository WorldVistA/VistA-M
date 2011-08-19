PSAUNL ;BIR/LTL-Connect Unlinked DRUG/ITEM MASTER file Entries ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**21**; 10/24/97
 ;
 ;References to ^PS(59.7 are covered by IA #3034
 ;References to ^PSDRUG( are covered by IA #2095
 D DT^DICRW
STOR ;to store and retrieve a restart drug
 N D0,D1,DA,DIC,DIE,DIR,DIRUT,DLAYGO,DR,DTOUT,DUOUT,PSASTOP,PSAIT,PSAS,X,Y S PSAS=+$O(^PS(59.7,0)) G:'$D(^PS(59.7,PSAS,70)) START
CHEC W !!,$S($P($G(^VA(200,+$P(^PS(59.7,PSAS,70),U,2),0)),U)]"":$P(^(0),U),1:"Someone")_" was last scanning on "
 S Y=$S($P(^PS(59.7,PSAS,70),U,3):$P(^(70),U,3),1:"sometime") X ^DD("DD") W Y_".",!!,"He/she stopped at "_$S($P($G(^PSDRUG(+$P(^PS(59.7,PSAS,70),U),0)),U)]"":$P(^(0),U),1:"... gee, I'm not sure")_".",! D  G:$D(DIRUT) QUIT
 .S DIR(0)="Y",DIR("A")="Would you like to start from there" D ^DIR K DIR S:Y=1&($P(^PS(59.7,+PSAS,70),U)) PSAIT=+$P(^PS(59.7,PSAS,70),U)-1
START ;compiles edit loop
 S:'$D(PSAIT) PSAIT=0
 ;DAVE B (PSA*3*23) PSAIT is killed in PSATI if no drug is
 ;selected at the Select Drug prompt. This causes an undefined
 ;and killed the loop process.
LOOP F  S PSAIT=$O(^PSDRUG(PSAIT)) Q:'PSAIT  S PSASTOP=PSAIT I '$O(^PSDRUG(PSAIT,441,0)),'$D(^PSDRUG(PSAIT,"I")) D START^PSATI Q:$D(DIRUT)  I $G(PSAIT)="",$G(PSASTOP)'="" S PSAIT=PSASTOP
 W:$G(PSAIT) !,"OK, done with "_$P(^PSDRUG(PSAIT,0),U),!
STOP I $G(PSAIT),$D(PSAS),$D(PSASTOP) S DIE="^PS(59.7,",DA=PSAS,DR="70///^S X=PSASTOP;70.1///^S X=""`""_DUZ;70.2///^S X=DT" D ^DIE K DIE W !!,"I'll store this last drug in case you want to resume at this point next time.",!!
 W:'$G(PSAIT) !,"**Congratulations, you've reached the end of your DRUG file.**",!
QUIT Q

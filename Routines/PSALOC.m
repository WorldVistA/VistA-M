PSALOC ;BIR/MNT,DB-Set Up/Edit a Pharmacy Location ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**21**; 10/24/97
 ;
 ;References to ^PS(59, are covered under IA #212
 ;References to ^PS(59.4, are covered under IA #2505
 ;Due to merging facilities, this functionality is being 
 K PSALOC,PSALOCA,PSAMNU
 S PSALOC=+$O(^PSD(58.8,"ADISP","P",0))
 I 'PSALOC W !!?5,"No Drug Accountability location has been created yet." G ADD
 D HDR
 ;
ORDER ;If more than one pharmacy location, collect them in alpha order.
 S (PSACNT,PSALOC)=0 W !
 F  S PSALOC=+$O(^PSD(58.8,"ADISP","P",PSALOC)) Q:'PSALOC  D
 .Q:'$D(^PSD(58.8,PSALOC,0))!($P($G(^PSD(58.8,PSALOC,0)),"^")="")
 .I +$G(^PSD(58.8,PSALOC,"I")),+^PSD(58.8,PSALOC,"I")'>DT Q
 .D SITES^PSAUTL1
 .K PSAISIT,PSAOSIT
 .S PSACNT=PSACNT+1,PSAONE=+PSALOC
 .S PSALOCA($P(^PSD(58.8,PSALOC,0),"^"),PSALOC)=$P(^(0),"^",3)_"^"_$P(^(0),"^",10) I $D(^PSD(58.8,PSALOC,7)) D
 ..;OP multiple has data
 ..S X2=0 F  S X2=$O(^PSD(58.8,PSALOC,7,X2)) Q:X2'>0  I $P(^PSD(58.8,PSALOC,0),"^",10)'=X2,$P($G(^PSD(58.8,PSALOC,7,X2,0)),"^",2)="" S PSALOCA($P(^PSD(58.8,PSALOC,0),"^"),PSALOC)=PSALOCA($P(^PSD(58.8,PSALOC,0),"^"),PSALOC)_"^"_X2
 S PSACHK=$O(PSALOCA("")) I PSACHK="" G ADD
 I $G(PSACNT)=1 G DISP
 G DISP
 ;
ONE ;only one
 S PSALOC=PSAONE
 I '$D(^PSD(58.8,PSALOC,0))!($P($G(^PSD(58.8,PSALOC,0)),"^")="") W !,"There are no Drug Accountability pharmacy locations with data." Q
 S PSALOCN="",PSALOCN=$O(PSALOCA(PSALOCN)) Q:PSALOCN=""  S PSALOC=0,PSALOC=+$O(PSALOCA(PSALOCN,PSALOC)) Q:'PSALOC
 G EXIT
 ;
DISP ;Displays the available pharmacy locations.
 S PSACNT=0,PSALOCN=""
 F  S PSALOCN=$O(PSALOCA(PSALOCN)) Q:PSALOCN=""  D
 .S PSALOC=0 F  S PSALOC=+$O(PSALOCA(PSALOCN,PSALOC)) Q:'PSALOC  D
 ..S PSACNT=PSACNT+1,PSAMNU(PSACNT,PSALOCN,PSALOC)=PSALOCA(PSALOCN,PSALOC)
 ..W !,$J(PSACNT,2),?5,PSALOCN S DATA=PSAMNU(PSACNT,PSALOCN,PSALOC) W:$P(DATA,"^",1)'="" ?25,$P($G(^PS(59.4,$P(DATA,"^",1),0)),"^") W:$P(DATA,"^",2)'="" ?50,$P($G(^PS(59,$P(DATA,"^",2),0)),"^")
 ..I $P(DATA,"^",3)'="" F X3=3:1 Q:$P(DATA,"^",X3)=""  W:$P(DATA,"^",2)'="" "," W !,?50,$P($G(^PS(59,$P(DATA,"^",X3),0)),"^")
 ..;I $D(^PSD(58.8,PSALOC,"I")) W !,"*****   INACTIVE   *****"
 ;S PSACNT=$G(PSACNT)+1 W !,$J(PSACNT,2),?5,"New Pharmacy Location",! S PSANEW=PSACNT
 ;
SELECT S DIR(0)="L^1:"_PSACNT,DIR("A")="Select PHARMACY LOCATION",DIR("??")="^D HELP^PSAUTL3"
 K PSALOC
 S DIR("?")="Enter the number of the pharmacy location"
 D ^DIR K DIR I 'Y S PSAOUT=1 G EXIT
 S PSANUM=+Y
 ;I +Y=PSANEW G ADD
 S PSALOCN=$O(PSAMNU(+Y,"")),PSALOC=+$O(PSAMNU(+Y,PSALOCN,0)),PSAITY=$S($E(PSALOCN)="C":3,$E(PSALOCN)="I":1,$E(PSALOCN)="O":2,1:"")
 Q
 ;
EXIT ;Kills all variables except PSALOC array & PSAOUT
 K AN,AN1,CNT,CNT1,CNT2,DA,DATA,DIC,DIE,DIR,PSA,PSAB,PSAC,PSACHK,PSACOMB,PSADEL,PSADRUG,PSADT,PSAERR,PSAI,PSAII,PSAINV,PSAIPS,PSAISIT,PSAISITN
 K PSAIT,PSAITY,PSAIV,PSAIVCHG,PSAIVLOC,PSALEN,PSALOC,PSALOCA,PSALOCI,PSALOCN,PSAMNU,PSANEW,PSANLN,PSANLN1,PSANLN2,PSANOW,PSANUM,PSAO,PSAOC,PSAOK,PSAONE,PSAOP,PSAOSIT,PSAOSITN,PSAOU,PSAOUT,PSAPVMEN
 K PSAQTY,PSASL,PSASTO,PSAT,PSATYP,PSAWARD,PSAY,X,X2,X3,XX,Y
 Q
 Q
 ;
ADD ;add locations
 W !,"New location set-up"
 S DIR(0)="S^1:INPATIENT;2:OUTPATIENT;3:COMBINED (IP/OP)",DIR("A")="Select Pharmacy type",DIR("?")="You can separate Inpatient and Outpatient or Combine into one location.",DIR("??")="PSA LOCATION EDIT"
 D ^DIR I $G(DIRUT)=1!($G(DUOUT)=1) W !,"bye" G EXIT
 S PSAITY=+Y,PSALOCN=Y(0) I $D(^PSD(58.8,"B",PSALOCN)) W !,"There is at least one entry setup with this name. Could we expand the name ?",!,"Something like "_PSALOCN_" (WEST WING) ?" D
NEWNM .;new Name
 .R !!,"Please add text for a more descriptive name: ",AN1:DTIME I AN1["^"!('$T)!(AN1="") S PSAOUT=1 Q
 .S AN=PSALOCN_" "_AN1
 .I AN=PSALOCN W !,"Sorry that is what I have already" S PSAOUT=1 Q
 .W !,"New name: "_AN
 .I AN'=PSALOCN S PSALOCN=AN D
 ..W !,"Are you sure ? YES// " R AN:DTIME I AN["^" S PSAOUT=1 Q
 ..I AN="" S AN="Y"
 ..S AN=$E(AN,1) I "Nn"[AN S PSAOUT=1 Q
 ..I '$D(^PSD(58.8,"B",AN)) S PSANEW=1 Q
 ..I $D(^PSD(58.8,"B",AN)) W "sorry, this one exists" S PSAOUT=1 Q
 I $G(PSAOUT)=1 G EXIT
 I '$D(^PSD(58.8,"B",PSALOCN)) S PSANEW=1
 I $G(PSANEW) S X=PSALOCN,DIC(0)="AEQMLZ",DLAYGO="58.8",DIC="^PSD(58.8," D FILE^DICN K DIC,DA S PSALOC=+Y,DIE="^PSD(58.8,",DA=+Y,DR="1////P" D ^DIE K DIE,DR,DA Q
 Q
HDR W @IOF,?20,"<<<<< PHARMACY LOCATION SETUP SCREEN  >>>>>  ",!!,"LOCATION TYPES : INPATIENT, OUTPATIENT & COMBINED (IP/OP)",!!,"#",?5,"LOCATION ",?25,"INPATIENT SITE",?50,"OUTPATIENT SITE(s)",! F X=1:1:(IOM-4) W "="
 Q

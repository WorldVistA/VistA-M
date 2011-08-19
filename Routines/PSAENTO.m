PSAENTO ;BIR/LTL,JMB-Set Up/Edit a Pharmacy Location - CONT'D ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**12,21,43,63**; 10/24/97;Build 10
 ;This routines is called by PSAENT.
 ;
 ;References to global ^PRC(441 are covered by IA #214
 ;References to global ^PRCP(445 are covered by IA #214
 ;References to global ^PS(52.6, are covered by IA #270
 ;References to global ^PS(52.7 are covered by IA #770
 ;References to global ^PS(59, are covered by IA #212
 ;References to global ^PS(59.5 are covered by IA #1884
 ;References to global ^PSDRUG( are covered by IA #2095
 ;References to global ^PSDRUG("AB" are covered by IA #2095
 ;
 ;External references to $$DESCR^PRCPUX1 are covered by IA #259
 ;External references to $$INVNAME^PRCPUX1 are covered by IA #259
 ;
 ;
 ;
OP G:$P($G(^PSD(58.8,+$G(PSALOC),0)),U,10) OPC
 S Y=1 S PSA=$O(^PS(59,0)) D:$O(^PS(59,PSA))  G:Y<0 QUIT
 .;more than one OP site
 .W !!,"Because there is more than one Outpatient Site at this facility, I need you to "
 .S DIC="^PS(59,",DIC(0)="AEMQ",DIC("A")="select an Outpatient Site: " D ^DIC K DIC S PSAOSIT=+Y
 S:'$D(PSAOSIT) PSAOSIT=+$O(^PS(59,0))
 ;if IP changed to combined, check for existing OP and zap
 I +$G(PSALOC),+$G(PSAOC),$O(^PSD(58.8,"AOP",+PSAOSIT,"")),($O(^PSD(58.8,"AOP",+PSAOSIT,""))'=$G(PSALOC)) S DIE="^PSD(58.8,",DA=$O(^PSD(58.8,"AOP",+PSAOSIT,"")),DR="20////@" D ^DIE K DIE
 I $G(PSALOC),'$O(^PSD(58.8,"AOP",+PSAOSIT,"")) S DIE="^PSD(58.8,",DA=PSALOC,DR="20////^S X=+PSAOSIT" D ^DIE K DIE
DAVEB I '$O(^PSD(58.8,"AOP",+PSAOSIT,"")) D  G:Y<0 QUIT
 .;DAVE B (PSA*3*12) dic(0) was AEMQLZ; *43 added back Z
 .S DIC="^PSD(58.8,",DIC(0)="AELXZ",DLAYGO=58.8,DIC("A")="Please select Location: ",DIC("B")=$S(PSAITY=2:"OUTPATIENT",PSAITY=3:"COMBINED (IP/OP)",1:"")
 .S DIC("DR")="1////P;20////^S X=+PSAOSIT",DIC("S")="I $P($G(^(0)),U,2)=""P"",$S($P($G(^(0)),U,10):$P($G(^(0)),U,10)=+PSAOSIT,1:1)"
 .S:PSAITY=3 DIC("W")="W ?30,""IP SITE: "",$P($G(^PS(59.4,+$P($G(^(0)),U,3),0)),U)"
 .D ^DIC K DIC,DLAYGO S:Y>0 PSALOC=+Y,PSALOCN=Y(0,0)
 S:'$D(PSALOC) PSALOC=$O(^PSD(58.8,"AOP",+PSAOSIT,"")),PSALOCN=$P($G(^PSD(58.8,+PSALOC,0)),U)
OPC W !!,"Outpatient site selection affects the collection of dispensing data.",!
 S DIE="^PSD(58.8,",DA=PSALOC,DR="20//^S X=$P($G(^PS(59,+PSAOSIT,0)),U)" D ^DIE K DIE I $D(DTOUT)!($D(Y)) G QUIT  ;; <3*63 RJS>
 S PSAOSIT=+$P($G(^PSD(58.8,PSALOC,0)),"^",10)
 G:'PSALOC QUIT
 N PSADT,PSAT,PSAQTY,PSAY
 G:$G(PSAPVMEN) DRUGS
ED S DIE=58.8,DA=PSALOC,DR="[PSAENT]" D ^DIE K DIE,DA G:$D(Y) QUIT G:'$D(PSAINV) DRUGS D:$O(^PRCP(445,PSAINV,1,0))   G:$D(DIRUT) QUIT
QUES .S DIR(0)="Y",DIR("A",1)="Would you like to loop through "_$$INVNAME^PRCPUX1($G(PSAINV))_"'S",DIR("A")="items to check for any new entries that are ready to load"
 .S DIR("?")="I will check for items that are linked to the DRUG file but not yet stocked."
 .W ! D ^DIR K DIR Q:'Y  S PSAIT=0 D
 ..S DIR(0)="Y",DIR("A")="Load inventory quantities also",DIR("B")="Yes",DIR("?")="Inventory quantities will be multiplied by the dispensing unit conversion factor." D ^DIR K DIR Q:$D(DIRUT)  S:Y=1 PSAY=1
 ..S:'$D(^PSD(58.8,+PSALOC,1,0)) ^(0)="^58.8001IP^^"
LOOP ..F  S PSAIT=$O(^PRCP(445,+PSAINV,1,PSAIT)) Q:'PSAIT  I '$G(^PRC(441,PSAIT,3)),$O(^PSDRUG("AB",+PSAIT,0)) S PSADRUG=$O(^PSDRUG("AB",PSAIT,0)) D:'$D(^PSD(58.8,+PSALOC,1,+PSADRUG,0))  Q:$D(DIRUT)
 ...Q:'$S('$D(^PSDRUG(PSADRUG,"I")):1,+^("I")>DT:1,1:0)
 ...S DIR(0)="Y",DIR("A",1)="OK to load "_$P($G(^PSDRUG(PSADRUG,0)),U)_" from the DRUG file",DIR("A")="linked to inventory item: "_$$DESCR^PRCPUX1($G(PSAINV),$G(PSAIT)),DIR("B")="Yes" D ^DIR K DIR Q:Y<1  S X=PSADRUG
 ...S:$G(PSAY) DIC("DR")="3//^S X=PSAQTY;S PSAQTY=X"
ITEM ...S DA(1)=PSALOC,DIC="^PSD(58.8,PSALOC,1,",DIC(0)="EMQL",DLAYGO=58.8,PSAQTY=$P($G(^PRCP(445,+PSAINV,1,PSAIT,0)),U,7)*$S($P($G(^(0)),U,29):$P(^(0),U,29),1:1) D ^DIC K DIC,DLAYGO Q:Y<0
 ...Q:'$G(PSAY)
 ...W !,"Updating Beginning balance and transaction history.",!
 ...D NOW^%DTC S PSADT=+$E(%,1,12) K %
 ...S ^PSD(58.8,+PSALOC,1,+PSADRUG,5,0)="^58.801A^^"
 ...S DIC="^PSD(58.8,+PSALOC,1,+PSADRUG,5,",DIC(0)="LM",(X,DINUM)=$E(DT,1,5)*100,DA(2)=PSALOC,DA(1)=PSADRUG,DIC("DR")="1////^S X=$G(PSAQTY);5////^S X=$G(PSAQTY)",DLAYGO=58.8 D ^DIC K DIC,DLAYGO
 ...F  L +^PSD(58.81,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
FIND ...S PSAT=$P(^PSD(58.81,0),U,3)+1 I $D(^PSD(58.81,PSAT)) S $P(^PSD(58.81,0),U,3)=$P(^PSD(58.81,0),U,3)+1 G FIND
 ...S DIC="^PSD(58.81,",DIC(0)="L",DLAYGO=58.81,(DINUM,X)=PSAT D ^DIC K DIC,DLAYGO L -^PSD(58.81,0)
 ...S DIE="^PSD(58.81,",DA=PSAT,DR="1////11;2////^S X=PSALOC;3////^S X=PSADT;4////^S X=PSADRUG;5////^S X=PSAQTY;6////^S X=DUZ;9////0" D ^DIE K DIE
 ...S:'$D(^PSD(58.8,+PSALOC,1,+PSADRUG,4,0)) ^(0)="^58.800119PA^^"
 ...S DIC="^PSD(58.8,+PSALOC,1,+PSADRUG,4,",DLAYGO=58.8,DIC(0)="L",(X,DINUM)=PSAT
 ...S DA(2)=PSALOC,DA(1)=PSADRUG D ^DIC K DA,DIC,DLAYGO
 ...I $O(^PS(52.6,"AC",+PSADRUG,0))!($O(^PS(52.7,"AC",+PSADRUG,0))) S PSAIT(1)=PSAIT,PSAIT(2)=$P($G(^PSDRUG(+PSADRUG,0)),U),PSAIT(4)=$G(^PSDRUG(+PSADRUG,660)),PSAIT=PSADRUG D ^PSAPSI4 S PSAIT=PSAIT(1)
DRUGS W ! S DIR(0)="Y",DIR("A")="Add/edit drugs",DIR("B")="No" D ^DIR K DIR D:Y=1 ^PSADRUG
 Q:'+$G(PSAOSIT)
IV I '$O(^PSD(58.8,PSALOC,3.5,0)) W ! S DIR(0)="Y",DIR("A")="Does the outpatient site dispense IVs to IV rooms",DIR("B")="No" D ^DIR K DIR G:Y=0 QUIT
 S PSALEN=$L($P($G(^PS(59,+PSAOSIT,0)),"^")),PSALEN=PSALEN+16
IV1 W @IOF,!?((80-PSALEN)/2),$P($G(^PS(59,+PSAOSIT,0)),"^")_" Outpatient Site",!!
 I $O(^PSD(58.8,PSALOC,3.5,0)) D
 .W "Currently linked IV Rooms:" S PSANOW=0
 .F  S PSANOW=$O(^PSD(58.8,PSALOC,3.5,PSANOW)) Q:'PSANOW  S PSANOW($P($G(^PS(59.5,PSANOW,0)),"^"))=""
 .S PSANOW="" F  S PSANOW=$O(PSANOW(PSANOW)) Q:PSANOW=""  W ?27,PSANOW,!
 S DIR(0)="SAO^L:Link;U:Unlink",DIR("A")="Link or unlink IV rooms (L/U): " D ^DIR K DIR G:$G(DIRUT) QUIT G:Y="U" UNLINK
 W !!,"Enter the IV rooms that receive IVs from the outpatient site.",!
 K DIC S DIC="^PS(59.5,",DIC(0)="AEQZ"
 F  D ^DIC Q:$G(DTOUT)!($G(DUOUT))!(Y<0)  D
 .S PSAIVLOC=+$O(^PSD(58.8,"AIV",+Y,0))
 .I PSAIVLOC,PSAIVLOC'=PSALOC W !!,"<< "_Y(0,0)_" is already linked to the "_$P($G(^PS(59,+$P($G(^PSD(58.8,PSALOC,0)),"^",10),0)),"^"),!?4,"outpatient site in the "_$P($G(^PSD(58.8,PSALOC,0)),"^")_" pharmacy location. >>",! K Y Q
 .I PSAIVLOC,PSAIVLOC=PSALOC W !!,"<< "_Y(0,0)_" is already linked to this outpatient site. >>",! K Y Q
 .S:$D(Y(0,0)) PSAIV(Y(0,0))=+Y
 K DIC S PSAIV=$O(PSAIV("")) I PSAIV="" W !!,"<< No IV rooms were selected to be linked to the Outpatient site. >>",! G QUIT
 W @IOF W !?((80-PSALEN)/2),$P($G(^PS(59,+PSAOSIT,0)),"^")_" Outpatient Site",!!,"IV rooms to be linked:"
 S PSAIV="" F  S PSAIV=$O(PSAIV(PSAIV)) Q:PSAIV=""  W ?23,PSAIV,!
 S DIR(0)="Y",DIR("A")="Should the IV rooms be linked",DIR("B")="N" D ^DIR K DIR I 'Y K PSAIV G IV1
 S:'$D(^PSD(58.8,PSALOC,3.5,0)) ^PSD(58.8,PSALOC,3.5,0)="^58.831P^^"
 W ! S DIC="^PSD(58.8,"_PSALOC_",3.5,",DIC(0)="ML",PSAIV="" K DD,DO
 W !,"Linking IV rooms"
 F  S PSAIV=$O(PSAIV(PSAIV)) Q:PSAIV=""  K DD,DO S (X,DINUM)=PSAIV(PSAIV),DA(1)=PSALOC D FILE^DICN W "."
 W !,"The IV rooms were linked successfully."
 K DIC,PSAIV,DINUM,X
QUIT Q
UNLINK ;Unlink IV Rooms
 S DIR(0)="Y",DIR("B")="N",PSANOW="" W !
 F  S PSANOW=$O(PSANOW(PSANOW)) Q:PSANOW=""  S DIR("A")="Unlink "_PSANOW D ^DIR Q:$G(DIRUT)  I Y S PSANOW(PSANOW)=Y,PSADEL(PSANOW)=""
 S PSANOW="",PSADEL=$O(PSADEL(PSANOW))
 W @IOF,!?((80-PSALEN)/2),$P($G(^PS(59,+PSAOSIT,0)),"^")_" Outpatient Site",!!
 I PSADEL'="" W !,"To be unlinked:" S PSANOW="" D
 .F  S PSANOW=$O(PSADEL(PSANOW)) Q:PSANOW=""  W ?16,PSANOW,!
 .W ! S DIR(0)="Y",DIR("B")="N",DIR("A")="Okay to unlink the IV Rooms" D ^DIR K DIR Q:$G(DIRUT)  I 'Y W !,"No IV rooms were unlinked." Q
 .W !,"Unlinking IV rooms"
 .S PSANOW="",DIE="^PSD(58.8,"_PSALOC_",3.5,",DA(1)=PSALOC F  S PSANOW=$O(PSADEL(PSANOW)) Q:PSANOW=""  S DA=$O(^PS(59.5,"B",PSANOW,0)),DR=".01///@" D ^DIE W "."
 .K DIE W !,"IV rooms unlinked."
 Q

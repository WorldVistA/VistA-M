PSADRUG ;BIR/LTL-Add/edit Pharmacy Location drugs ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**64**; 10/24/97;Build 4
 ;
 ;References to ^PSDRUG( are covered by IA #2095
 ;
 N DIC,DA,DIE,DLAYGO,DINUM,DR,DIR,DIRUT,PSA,PSAINV,PSAIT,X,Y
 D ^PSADA G:'$G(PSALOC) QUIT
NOINV S:'$D(^PSD(58.8,PSALOC,1,0)) ^(0)="^58.8001IP^^"
 S DA(1)=PSALOC,DIC="^PSD(58.8,PSALOC,1,",DIC(0)="AEMQL",DIC("W")="I $S($P($G(^(0)),U,14):$P($G(^(0)),U,14)'>DT,1:0) W $C(7),""   *** INACTIVE ***""",DLAYGO=58.8 W ! D ^DIC K DIC,DLAYGO G:Y<1 QUIT S PSAIT=+Y
 S PSAIT(2)=$P($G(^PSDRUG(+PSAIT,0)),U)
NOT I '$O(^PSDRUG(PSAIT,441,0)) W !?10,"**This drug is not linked to the ITEM MASTER file**",!?12,"To automate receiving, a link is needed.",! D
 .S DIR(0)="Y",DIR("A")="Attempt link now",DIR("B")="Yes" D ^DIR K DIR Q:$D(DIRUT)!(Y<1)  D START^PSATI
 I $O(^PSD(58.8,+PSALOC,4,0)),$O(^PSDRUG(+PSAIT,441,0)) S PSA(1)=0 D
 .N PSAINV
 .F  S PSA(1)=$O(^PSDRUG(+PSAIT,441,PSA(1))) Q:'PSA(1)  D
 ..S PSAINV=0,PSA(1)=$G(^PSDRUG(+PSAIT,441,+PSA(1),0))
 ..F  S PSAINV=$O(^PRCP(445,"AE",+PSA(1),PSAINV)) Q:'PSAINV!($O(^PSD(58.8,"P",+PSAINV,+PSALOC,0)))
 ..I 'PSAINV W !!,"**",PSAIT(2),", from the DRUG file is linked to",!!,$$DESCR^PRCPUX1($G(PSAINV),PSA(1))," from the ITEM MASTER file",!!," but has NOT been added to a linked Inventory Point.**" Q
 ..S PSAIT(1)=$G(PSAIT(1))+1
 ..W:PSAIT(1)=1 !!,PSAIT(2),", from the DRUG file is linked to",!!
 ..W $$DESCR^PRCPUX1(PSAINV,PSA(1))," from the ITEM MASTER file.",!!
 ..W $$INVNAME^PRCPUX1(PSAINV)," shows a current balance of",!!
 ..S PSAIT(3)=$G(^PRCP(445,+PSAINV,1,+PSA(1),0))
 ..W $S($P(PSAIT(3),U,7):$P(PSAIT(3),U,7),1:0)," ",$$UNITCODE^PRCPUX1($P(PSAIT(3),U,5))
 ..W " times dispensing unit conv factor = "
 ..W $P(PSAIT(3),U,7)*$S($P(PSAIT(3),U,29):$P(PSAIT(3),U,29),1:1)
 ..W " ",$P(PSAIT(3),U,28),!
 S PSAIT(4)=$G(^PSDRUG(+PSAIT,660))
 K PSA G:$P($G(^PSD(58.8,+PSALOC,1,+PSAIT,0)),U,4)]"" DISP
DRUG S DIE="^PSD(58.8,PSALOC,1,",DA=PSAIT,DR="3Please enter total "_$P(PSAIT(4),U,8)_" currently on hand: ;S PSA(2)=X",DA(1)=PSALOC
 D:$P(PSAIT(4),U,2)]""
 .W !!?30,"DRUG FILE info:",!
 .W ?20,"Order unit: "_$P(^DIC(51.5,+$P(PSAIT(4),U,2),0),U,2),!?20,"Dispense units per order unit: "_$P(PSAIT(4),U,5),!?20,"Dispense unit: "_$P(PSAIT(4),U,8)
 .W !!,"Current Inventory from the DRUG file = "_$P($G(^PSDRUG(PSAIT,660.1)),U),!
 W:'$P(^PSD(58.8,PSALOC,1,PSAIT,0),U,4) !,"Once an initial quantity is entered it can only be updated by receiving,",!,"dispensing or adjusting.",!!,"Updating will occur to the balance in ",$G(PSALOCN),".",!!,"The Current Inventory "
 W "from the DRUG file is only offered as an initial balance",!,"and is NOT updated."
 F  L +^PSD(58.8,+PSALOC,1,+PSAIT,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 D ^DIE L -^PSD(58.8,+PSALOC,1,+PSAIT,0) G:$D(Y) QUIT
DISP W !!,"Current balance:  "_$P(^PSD(58.8,PSALOC,1,PSAIT,0),U,4)," ",$P(PSAIT(4),U,8),!
 G:$G(PSA(2))']"" AGAIN
 N PSAT,PSADT
 D NOW^%DTC S PSADT=+$E(%,1,12) K %
MON S:'$D(^PSD(58.8,+PSALOC,1,+PSAIT,5,0)) ^(0)="^58.801A^^"
 I '$D(^PSD(58.8,+PSALOC,1,+PSAIT,5,$E(DT,1,5)*100,0)) S DIC="^PSD(58.8,+PSALOC,1,+PSAIT,5,",DIC(0)="LM",(X,DINUM)=$E(DT,1,5)*100,DA(2)=PSALOC,DA(1)=PSAIT,DLAYGO=58.8 D ^DIC K DIC,DLAYGO
 S DIE="^PSD(58.8,+PSALOC,1,+PSAIT,5,",DA(2)=PSALOC,DA(1)=PSAIT,DA=$E(DT,1,5)*100,DR="1////^S X=PSA(2);7////^S X=PSA(2)" D ^DIE K DIE
 W !,"Updating beginning balance and transaction history.",!
 F  L +^PSD(58.81,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
FIND S PSAT=$P(^PSD(58.81,0),U,3)+1 I $D(^PSD(58.81,PSAT)) S $P(^PSD(58.81,0),U,3)=$P(^PSD(58.81,0),U,3)+1 G FIND
 S DIC="^PSD(58.81,",DIC(0)="L",DLAYGO=58.81,(DINUM,X)=PSAT D ^DIC
 L -^PSD(58.81,0) K DIC,DLAYGO
 S DIE="^PSD(58.81,",DA=PSAT,DR="1////11;2////^S X=PSALOC;3////^S X=PSADT;4////^S X=PSAIT;5////^S X=PSA(2);6////^S X=DUZ;9////0" D ^DIE K DIE
 S:'$D(^PSD(58.8,+PSALOC,1,+PSAIT,4,0)) ^(0)="^58.800119PA^^"
 S DIC="^PSD(58.8,+PSALOC,1,+PSAIT,4,",DIC(0)="L",(X,DINUM)=PSAT
 S DA(2)=PSALOC,DA(1)=PSAIT,DLAYGO=58.8 D ^DIC K DA,DIC,DLAYGO
AGAIN D:$O(^PS(52.6,"AC",+PSAIT,0))!($O(^PS(52.7,"AC",+PSAIT,0))) ^PSAPSI4 S DIR(0)="Y",DIR("A")="Another Drug",DIR("B")="No" W ! D ^DIR K DIR G:Y=1 NOINV
QUIT Q

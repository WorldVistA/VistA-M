PSADRUGP ;BIR/LTL,JMB-Enter/Edit a Drug ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**3,21,60,64**; 10/24/97;Build 4
 ;
 ;References to ^PSDRUG( are covered by IA #2095
 ;References to ^PS(52.6, are covered by IA #270
 ;References to ^DIC(51.5 are covered by IA #1931
 ;References to ^PS(52.7 are covered by IA #770
LOC G:+$G(PSAOUT)&($G(PSACNT)=1) EXIT
 S (PSADD,PSACNT,PSAOUT)=0,PSASLN="",$P(PSASLN,"-",80)=""
 D ^PSAUTL3 G:PSAOUT EXIT S PSACHK=$O(PSALOC(""))
 I PSACHK="",'PSALOC W !,"There are no active pharmacy locations." G EXIT
 I $O(PSALOC(PSACHK))="" W !,PSALOCN
 ;
GETDRUG S PSAQTY=0
 S:'$D(^PSD(58.8,PSALOC,1,0)) ^(0)="^58.8001IP^^"
 S DA(1)=PSALOC,DIC="^PSD(58.8,"_PSALOC_",1,",DIC(0)="AEMQL",DIC("W")="I $S($P($G(^(0)),U,14):$P($G(^(0)),U,14)'>DT,1:0) W $C(7),""   *** INACTIVE ***""",DLAYGO=58.8 W ! D ^DIC K DIC,DLAYGO
 I Y<0!($G(DTOUT))!($G(DUOUT)) S PSAOUT=1 Q:$G(PSAOPT)="PSALOC"  G LOC
 S PSADRG=+Y,PSADRGN=$P($G(^PSDRUG(PSADRG,0)),"^")
 I $D(^PSD(58.8,PSALOC,1,PSADRG,0)),+$P(^(0),"^",14),$P(^(0),"^",14)'>DT W !,$C(7),"   *** INACTIVE ***" G DISP ;PSA*3*21 (Allow re-activation)
 S PSA660=$G(^PSDRUG(PSADRG,660))
 I '$D(^PSD(58.8,PSALOC,1,PSADRG,0)) G NOINV
 I $D(^PSD(58.8,PSALOC,1,PSADRG,0)),$P(^(0),"^",4)="" G DRUG
 G DISP
 ;
NOINV I '$D(^PSD(58.8,PSALOC,1,PSADRG,0)) D
 .S:'$D(^PSD(58.8,PSALOC,1,0)) ^(0)="^58.8001IP^^"
 .K DA,DD,DO S DIC="^PSD(58.8,"_PSALOC_",1,",DIC(0)="LM",DA(1)=PSALOC,(X,DINUM)=PSADRG,DLAYGO=58.8 D ^DIC K DIC,DINUM,DLAYGO
DRUG S DIE="^PSD(58.8,"_PSALOC_",1,",DA(1)=PSALOC,DA=PSADRG,DR="3Enter total "_$P(PSA660,"^",8)_" currently on hand: "
 W @IOF,!,$G(PSALOCN),!,"DRUG: "_PSADRGN
 D:+$P(PSA660,"^",2)
 .W !!?30,"DRUG FILE info:",!
 .W ?20,"Order unit: "_$P(^DIC(51.5,$P(PSA660,"^",2),0),"^",1),!?20,"Dispense units per order unit: "_$P(PSA660,"^",5),!?20,"Dispense unit: "_$P(PSA660,"^",8)
 .W !!,"Current Inventory from the DRUG file = "_$P($G(^PSDRUG(PSADRG,660.1)),"^")
 I '$P(^PSD(58.8,PSALOC,1,PSADRG,0),"^",4) D
 .W !!,"Once an initial quantity is entered, it can only be updated by receiving,",!,"dispensing, adjusting, or transferring."
 .W:+$P(PSA660,"^",2) " The Current Inventory from the",!,"DRUG file is only offered as an initial balance and and is NOT updated."
 F  L +^PSD(58.8,PSALOC,1,PSADRG,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 W ! D ^DIE L -^PSD(58.8,PSALOC,1,PSADRG,0) K DA,DIE G:$D(Y) LOC
 S PSAQTY=X
 I +$P($G(^PSD(58.8,PSALOC,0)),"^",14) D
 .S DIE="^PSD(58.8,"_PSALOC_",1,",DA(1)=PSALOC,DA=PSADRG,DR="2Stock Level: ;4Reorder Level: "
 .F  L +^PSD(58.8,PSALOC,1,PSADRG,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 .D ^DIE L -^PSD(58.8,PSALOC,1,PSADRG,0) K DA,DIE
DISP ;
 S:'$D(PSA660) PSA660=$G(^PSDRUG(PSADRG,660)) ;*60
 W !!,"Current balance:  "_+$P($G(^PSD(58.8,PSALOC,1,PSADRG,0)),"^",4)," ",$P(PSA660,"^",8)
 ;PSA*3*21 (Give option of inactivation - Dave B)
 S DIE="^PSD(58.8,"_PSALOC_",1,",DA(1)=PSALOC,DA=PSADRG,DR="13;14" D ^DIE K DIE,DR
 S PSAIT=PSADRG,PSAIT(2)=PSADRGN,PSAIT(4)=$G(^PSDRUG(PSAIT,660)) D:$O(^PS(52.6,"AC",PSADRG,0))!($O(^PS(52.7,"AC",PSADRG,0))) ^PSAPSI4
 G:'$G(PSAQTY) GETDRUG
 D NOW^%DTC S PSADT=+$E(%,1,12)
MON S:'$D(^PSD(58.8,PSALOC,1,PSADRG,5,0)) ^PSD(58.8,PSALOC,1,PSADRG,5,0)="^58.801A^^"
 I '$D(^PSD(58.8,PSALOC,1,PSADRG,5,+($E(DT,1,5)*100),0)) S DIC="^PSD(58.8,"_PSALOC_",1,"_PSADRG_",5,",DIC(0)="LM",(X,DINUM)=($E(DT,1,5)*100),DA(2)=PSALOC,DA(1)=PSADRG,DLAYGO=58.8 D ^DIC K DA,DIC,DLAYGO
 S DIE="^PSD(58.8,"_PSALOC_",1,"_PSADRG_",5,",DA(2)=PSALOC,DA(1)=PSADRG,DA=($E(DT,1,5)*100),DR="1////^S X=PSAQTY;7////^S X=PSAQTY" D ^DIE K DA,DIE
 W !!,"Updating beginning balance and transaction history."
 F  L +^PSD(58.81,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
FIND S PSAT=$P(^PSD(58.81,0),"^",3)+1 I $D(^PSD(58.81,PSAT)) S $P(^PSD(58.81,0),"^",3)=$P(^PSD(58.81,0),"^",3)+1 G FIND
 S DIC="^PSD(58.81,",DIC(0)="L",DLAYGO=58.81,(DINUM,X)=PSAT D ^DIC
 L -^PSD(58.81,0) K DIC,DLAYGO
 S DIE="^PSD(58.81,",DA=PSAT,DR="1////11;2////^S X=PSALOC;3////^S X=PSADT;4////^S X=PSADRG;5////^S X=PSAQTY;6////^S X=DUZ;9////0" D ^DIE K DIE,DA
 S:'$D(^PSD(58.8,PSALOC,1,PSADRG,4,0)) ^PSD(58.8,PSALOC,1,PSADRG,4,0)="^58.800119PA^^"
 S DIC="^PSD(58.8,"_PSALOC_",1,"_PSADRG_",4,",DIC(0)="LM",(X,DINUM)=PSAT
 S DA(2)=PSALOC,DA(1)=PSADRG,DLAYGO=58.8 D ^DIC K DA,DIC,DLAYGO
 G GETDRUG
EXIT K %,DA,DIC,DIE,DINUM,DR,DTOUT,DUOUT,PSA660,PSACHK,PSACNT,PSADD,PSADRG,PSADRGN,PSADT,PSALOC,PSALOCA,PSALOCN,PSAOUT,PSAQTY,PSASLN,PSAT,X,Y
 Q

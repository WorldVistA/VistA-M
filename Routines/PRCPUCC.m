PRCPUCC ;WISC/RFJ-update distr history file 446 (cost center)      ;11 Dec 91
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
COSTCNTR(TOINVPT,FROMINPT,COSTCNTR,COST) ;  add/update distribution cost (446)
 ;  toinvpt=primary   and frominpt=whse    and costcntr=primary
 ;  toinvpt=secondary and frominpt=primary and costcntr=primary
 ;  secondaries do not have costcenters -------------------^
 I 'COST!(COSTCNTR="")!('$D(^PRCP(445,+TOINVPT,0)))!('$D(^PRCP(445,+FROMINPT))) Q
 N %,%H,%I,D,D0,DA,DI,DIC,DIE,DISYS,DLAYGO,DQ,DR,I,X,Y
 L +^PRCP(446)
 S DIC="^PRCP(446,",DIC(0)="L",DLAYGO=446
 S DIC("S")="I +$P(^(0),U,2)=$E(DT,1,5),$P(^(0),U,3)="_FROMINPT_",+$P(^(0),U,4)="_COSTCNTR
 S X=$P($G(^PRCP(445,TOINVPT,0)),"^"),PRCPPRIV=1 D ^DIC K PRCPPRIV
 I Y<1 L -^PRCP(446) Q
 S DA=+Y
 I $P(Y,"^",3) S DIE="^PRCP(446,",DR="1////"_$E(DT,1,5)_";2////"_FROMINPT_";3///"_COSTCNTR D ^DIE
 S $P(^PRCP(446,DA,0),"^",7)=$P(^PRCP(446,DA,0),"^",7)+COST
 L -^PRCP(446)
 Q
 ;
 ;
EDIT ;  edit distribution costs
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 I "WP"'[PRCP("DPTYPE") W !,"THIS OPTION CAN ONLY BE USED BY WAREHOUSE AND PRIMARY INVENTORY POINTS." Q
 N %,%DT,D0,DA,DI,DIE,DLAYGO,DQ,DR,I,PRCPFLAG,X,Y
 S X="" W ! D ESIG^PRCUESIG(DUZ,.X) I X'>0 Q
 F  D  Q:$G(PRCPFLAG)
 .   S DIC="^PRCP(446,",DLAYGO=446,DIC(0)="QEALM",DIC("A")="Select DISTRIBUTION INVENTORY POINT: ",DIC("S")="I $P(^(0),U,3)=PRCP(""I"")",DIC("DR")="1;3;2////"_PRCP("I"),PRCPPRIV=1 W ! D ^DIC K PRCPPRIV,DIC I +Y<0 S PRCPFLAG=1 Q
 .   S DA=+Y,D=^PRCP(446,+Y,0),Y=$P(D,"^",2) D DD^%DT
 .   W !!?5,"Distribution TO  : ",$$INVNAME^PRCPUX1(+$P(D,"^")),!?5,"Distribution DATE: ",Y,!?5,"Distribution CC  : ",$E($P(D,"^",4),1,55),!?24,$E($P(D,"^",4),56,100)
 .   S DIE="^PRCP(446,",DR=6 D ^DIE
 Q
 ;
 ;
SELCOSTS(INVPT)    ;  select distribution cost entry for inventory point
 N %,DIC,I,PRCPPRIV,X,Y
 S DIC="^PRCP(446,",DIC(0)="QEAM",DIC("S")="I $P(^(0),U,3)="_INVPT,PRCPPRIV=1
 D ^DIC
 Q $S(Y'>1:0,1:+Y)

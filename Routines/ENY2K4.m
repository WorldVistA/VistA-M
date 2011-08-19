ENY2K4 ;(WASH ISC)/DH-Delete Y2K Work Orders ;6.16.98
 ;;7.0;ENGINEERING;**51**;Aug 17, 1993
 ;
DEL ;  delete Y2K worklist
 W !!,"Which do you wish to delete?",!,?7,"1. Individual work order(s), or",!,?7,"2. An entire Y2K work list."
 R !,"Select 1 or 2: ",X:DTIME Q:X="^"!(X="")  G:X["?" DELH1 I X?1N,X>0,X<3 G:X=1 DEL1 G DEL2
 W "??",*7 G DEL
 ;
DEL1 ;  delete individual work orders
 N DIC,DIK,DA
 S DIC="^ENG(6920,",DIC(0)="AEQM",DIC("A")="Enter first Y2K work order to be deleted: ",DIC("S")="I $E($P(^(0),U,1),1,3)=""Y2-""" D ^DIC K DIC("S") G:Y'>0 OUT1 S DA=+Y,ENY2WO=$P(^ENG(6920,DA,0),U)
 W !,ENY2WO,"   Are you sure" S %=1 D YN^DICN G:%'=1 DEL1
 S DIK="^ENG(6920,",EQDA=$P($G(^ENG(6920,DA,3)),U,8)
 I EQDA?1.N,$D(^ENG(6914,EQDA,0)) S $P(^ENG(6914,EQDA,11),U,8)=""
 D ^DIK K DIK
 ;
DEL10 S ENY2WO(1)=$O(^ENG(6920,"B",ENY2WO)) G:$P(ENY2WO(1),"-",2)'=$P(ENY2WO,"-",2) OUT1
 ;
DEL11 W !!,"Next work order: ",ENY2WO(1),"// " R X:DTIME G:X="^" OUT1 I X?1.3N S X=$S($L(X)=1:"00"_X,$L(X)=2:"0"_X,1:X),X=$P(ENY2WO,"-",1,2)_"-"_X
 I X="" S X=ENY2WO(1)
 I $E(X,1,3)'="Y2-" D DELH0 G DEL11
 S ENY2WO=X,DIC(0)="X",DIC("S")="I $E($P(^(0),U),1,3)=""Y2-""" D ^DIC K DIC("S") S DA=+Y I Y'>0 W "??",*7 D DELH0 G DEL11
 W !,ENY2WO,"   Are you sure" S %=1 D YN^DICN G:%'=1 DEL10
 S DIK="^ENG(6920,",EQDA=$P($G(^ENG(6920,DA,3)),U,8)
 I EQDA?1.N,$D(^ENG(6914,EQDA,0)) S $P(^ENG(6914,EQDA,11),U,8)=""
 D ^DIK K DIK
 G DEL10
 ;
DEL2 ;  delete an entire Y2K work list
 L +^ENG("Y2KLIST"):1 I '$T W !!,"Another user is processing a Y2K worklist. Please try again later.",*7 Q
 K ^TMP($J)
 N SHOPS,COUNT,DIC,DIK,DA
 S DIR(0)="Y",DIR("A")="Shall we delete Y2K worklists for ALL shops",DIR("B")="YES"
 D ^DIR K DIR G:$D(DIRUT) OUT S:Y SHOPS="ALL"
 I '$D(SHOPS) S DIC="^DIC(6922,",DIC(0)="AEMQ" D ^DIC G:Y'>0 OUT S ENSHKEY=+Y,ENSHABR=$P(^DIC(6922,ENSHKEY,0),U,2),ENSHOP=$P(^(0),U)
DEL22 W @IOF,!!
 W "This option will delete the entire Y2K worklist of "_$S($G(SHOPS)="ALL":"ALL shops.",1:"the "_ENSHOP_" shop.")
 W !!,"Just a moment, please..."
 S ENY2K="Y2-",COUNT=0 F  S ENY2K=$O(^ENG(6920,"B",ENY2K)) Q:$E(ENY2K,1,3)'="Y2-"  S DA=$O(^(ENY2K,0)) D:DA
 . I '$D(SHOPS),$P($G(^ENG(6920,DA,2)),U)'=ENSHKEY Q
 . S COUNT=COUNT+1,^TMP($J,DA)=""
 I 'COUNT W !!,"No Y2K work orders to delete." D MSG G OUT
 W !!,"You have selected "_COUNT_" Y2K work orders. Deletion of these work orders",!,"will not affect equipment histories. Are you sure you want to proceed" S %=1 D YN^DICN
 I %'=1 W !,"Nothing deleted.",*7 D MSG G OUT
 S DA=0,DIK="^ENG(6920," F  S DA=$O(^TMP($J,DA)) Q:'DA  D
 . S EQDA=$P($G(^ENG(6920,DA,3)),U,8) I EQDA?1.N,$D(^ENG(6914,EQDA,0)) S $P(^ENG(6914,EQDA,11),U,8)=""
 . D ^DIK W:'(DA#10) "."
 K DIK
 ;
OUT L -^ENG("Y2KLIST")
OUT1 ;
 K ENY2,ENY2WO,ENINN,ENWON,ENSHKEY,ENSHOP,ENSHABR,EQDA
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
MSG R !,"Press <RETURN> to continue...",X:DTIME Q
DELH0 W !,"Entry must be an existing work order, beginning with 'Y2-', or the",!,"sequential (numeric) portion thereof. Enter '^' to exit." Q
DELH1 W !,"Enter '1' to delete individual Y2K work orders or '2' to delete an entire",!,"Y2K worklist."
 W !,"Deletion of Y2K work orders which have been closed out does NOT remove them",!,"from the equipment history."
 G DEL
 ;
 ;ENY2K4

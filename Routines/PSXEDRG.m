PSXEDRG ;BIR/BAB-Drug Enter/Edit for HOST ; 30 Oct 95 / 3:16 PM [ 04/08/97   2:06 PM ]
 ;;2.0;CMOP;;11 Apr 97
 S PSXJ=1
 W ! S DIC="^PSDRUG(",DIC(0)="QEALMO",DLAYGO=50 D ^DIC G END:Y<0!($D(DTOUT))!($D(DUOUT)) S DA=+Y
 L +^PSDRUG(DA):1 I '$T W !!,"Drug is being edited by another process, try again later...",!! G PSXEDRG
 S PSIUX="O^Outpatient Pharmacy" D PSIU I PSIUA["^" G PSXEDRG
 S DR=$S('$G(^PSDRUG(+Y,"I"))!(+$G(^("I"))>DT):"[PSX DRUG]",1:"D CHECK^PSXEDRG;100///@;W !,""Drug is now re-activated"" S Y=""@2"";@1;W !!,""No change"";@2") S DA=+Y,DIE=DIC D ^DIE L -^PSDRUG(DA) K DA G PSXEDRG
CHECK N DP,DQ S DIR("A")="THIS DRUG IS INACTIVE - DO YOU WISH TO REACTIVATE IT",DIR("B")="N",DIR(0)="Y" D ^DIR K DIR I "^N"[X S Y="@1" Q
 S Y=100
 Q
 ;
PSIU ;
 Q:$S('$D(DA):1,'$D(PSIUX):1,PSIUX'?1E1"^"1.E:1,1:'$D(^PSDRUG(DA,0)))  S PSIUO=$S($D(^(2)):$P(^(2),"^",3),1:"") S PSIUT=$P(PSIUX,"^",2),PSIUT=$E("N","AEIOU"[$E(PSIUT))_" "_PSIUT,(%,PSIUQ)=PSIUO'[$E(PSIUX)+1
 F PSIU=0:0 W !!,"DO YOU WANT TO MARK THIS DRUG AS A"_PSIUT_" ITEM" D YN^DICN Q:%  D MQ S %=PSIUQ
 I %<0 S PSIUA="^" G DONE
 S PSIUA=$E("YN",%) G:%=PSIUQ DONE I %=1 S PSIUY=PSIUO_$P(PSIUX,"^"),$P(^PSDRUG(DA,2),"^",3)=PSIUY I $P(^(0),"^")]"" S ^PSDRUG("AIU"_$P(PSIUX,"^"),$P(^(0),"^"),DA)=""
 I %=2 S PSIUY=$P(PSIUO,$P(PSIUX,"^"))_$P(PSIUO,$P(PSIUX,"^"),2),$P(^PSDRUG(DA,2),"^",3)=PSIUY I $P(^(0),"^")]"" K ^PSDRUG("AIU"_$P(PSIUX,"^"),$P(^(0),"^"),DA)
 K:PSIUO]"" ^PSDRUG("IU",PSIUO,DA) S:PSIUY]"" ^PSDRUG("IU",PSIUY,DA)=""
 W ! Q
DONE ;
 K PSIU,PSIUQ,PSIUT,PSIUY Q
 ;
MQ ;
 W !!,"  Enter `Y' to mark this drug as a"_$S($E(PSIUT)="N":"n"_$E(PSIUT,2,99),1:PSIUT)_" item.",!,"  or `N' to unmark as a"_$S($E(PSIUT)="N":"n"_$E(PSIUT,2,99),1:PSIUT)_" item." Q
 ;
END K X,Y,DIR,DR,DIC,DIE,PSIUA,PSIUX,%,D0,D1,DA,DQ,I,Z,DTOUT,DUOUT,DIRUT,DIROUT,PSXJ Q

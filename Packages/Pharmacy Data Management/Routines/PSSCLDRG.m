PSSCLDRG ;BIR/SAB,WRT-CLOZAPINE DRUG ENTER AND EDIT ; 09/05/97 14:30
 ;;1.0;PHARMACY DATA MANAGEMENT;**16,19**;9/30/97
 I $P($G(^PSDRUG(DISPDRG,"CLOZ1")),"^",2)=1 W $C(7),$C(7),!!,"This drug is marked for Lab Monitor purposes. You must unmark it as a",!,"Lab Monitor before you can mark it as a Clozapine drug." G MONCLOZ^PSSDEE
ASK W ! S DA=DISPDRG I $D(^PSDRUG("ACLOZ",DISPDRG)) D:CLFLAG UNMARK^PSSCLDRG
 Q:LMFLAG  Q:NFLAG  Q:$D(DIRUT)  Q:$D(DUOUT)  Q:$D(DTOUT)
 N PSSFLG
 I '$G(^PSDRUG(DISPDRG,"I"))!(+$G(^("I"))>DT) S PSSFLG=1 D ^PSSCLOZ
 I '$D(PSSFLG) S DR="D CHECK^PSSCLDRG;100///@;W !,""Drug is now re-activated"" S Y=""@2"";@1;W !!,""No change"";@2" S DA=DISPDRG,DIE=DIC D ^DIE S:$G(Y)=1 DUOUT=1
 I '$D(DUOUT),('$D(DIRUT)),('$D(DTOUT)) D PSIU W !,$P(^PSDRUG(DA,0),"^")_" is now marked as a Clozapine drug",! S CLFLAG=1,NFLAG=1
END K X,Y,DIR,DR,DIC,DIE,PSIUA,PSIUX,%,D0,D1,DQ,I,Z,DTOUT,DUOUT,DIROUT,DIROUT
 Q
CHECK N DP,DQ S DIR("A")="THIS DRUG IS INACTIVE - DO YOU WISH TO REACTIVATE IT",DIR("B")="N",DIR(0)="Y" D ^DIR I "^N"[X S Y="@1" Q
 S Y=100
 Q
PSIU ;
 S PSIUO=$P($G(^PSDRUG(DA,2)),"^",3),PSIUY=$S("O"[PSIUO:PSIUO,1:PSIUO_"O"),$P(^PSDRUG(DA,2),"^",3)=PSIUY
 I $P(^PSDRUG(DA,0),"^")]"" S ^PSDRUG("AIUO",$P(^(0),"^"),DA)=""
 K:PSIUO]"" ^PSDRUG("IU",PSIUO,DA) S:$G(PSIUY)]"" ^PSDRUG("IU",PSIUY,DA)=""
 K PSIUO,PSIUY W !
 Q
UNMARK I $D(^PSDRUG("ACLOZ",DISPDRG)) S DA=DISPDRG
 I DA S DIR(0)="Y",DIR("A",1)="",DIR("A",2)="Are you sure you want to unmark "_$P(^PSDRUG(DISPDRG,0),"^"),DIR("A")="as a Clozapine drug",DIR("B")="N" D ^DIR
 I "Yy"[X S CLFLAG=0 S DR="17.5///@",DIE=DIC D ^DIE W:CLFLAG=0 !!,$P(^PSDRUG(DA,0),"^")_" is now unmarked as a Clozapine drug",! D ASKIT
 W !
 Q
ASKIT K DIR W !,"Do you wish to mark this drug as a Lab Monitor drug?" S DIR(0)="Y" D ^DIR
 Q:$D(DIRUT)  Q:$D(DTOUT)  Q:$D(DUOUT)
 I "Nn"[X S NFLAG=1 K X,Y,DIR Q
 I "Yy"[X D ^PSSLAB
 Q

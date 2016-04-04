DIBT1 ;SFISC/GFT,TKW-STORE A SORT TEMPLATE ;25JULY2014
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1050**
 ;
S1 K DIR S DIR(0)="O",DIR("A")="STORE IN 'SORT' TEMPLATE",DIR("?")="^D H1^DIBT1"
 D SAV Q:$D(DIRUT)  D DIC Q
 ;
S2 K DIR S DIR(0)="O",DIR("A")="STORE THESE ENTRY ID'S IN TEMPLATE",DIR("?")="^D H2^DIBT1"
 D SAV Q:$D(DIRUT)  D MRG Q
 ;
S3 K DIR S DIR(0)="O",DIR("A")="STORE RESULTS OF SEARCH IN TEMPLATE",DIR("?")="^D H3^DIBT1"
 S:$D(DIAR) DIR(0)=""
 D SAV Q:$D(DIRUT)  D MRG Q
 ;
SAV S DIR(0)="F"_DIR(0)_"^1,30"
 D ^DIR K DIR Q:$D(DIRUT)
 I $E(X)="[" S X=$P($E(X,2,99),"]",1)
 Q
 ;
H1 N A,B S A="sort criteria",B="SORT" D H,DIC Q
 ;
H2 N A,B S A="list of entries",B="SEARCH/SORT" D H,MRG Q
 ;
H3 N A,B S A="list of entries from the search",B="SEARCH/SORT"
 W:$D(DIAR) !!,"You must store the results in a template.",!,"Otherwise you will have to rerun this search to archive the entries."
 D H,MRG Q
 ;
H W !!,"If you wish to save this "_A_" for later re-use",!,"enter the name of a "_B_" TEMPLATE here (1-30 characters)." Q
 ;
 ;
MRG ;
 S DIBT1=1
DIC K DIC S DIC="^DIBT(",DLAYGO=0,DIC(0)="QELSZ",DIOVRD=1,DIC("S")="I "_$S($D(DIAR)&('$D(DIARI)):"",1:"'")_"$P(^(0),U,8)"
 S DIC("S")=DIC("S")_",$P(^(0),U,4)=DK,$P(^(0),U,5)=DUZ!'$P(^(0),U,5)!$D(DIEDT)",D="F"_DK
 D IX^DIC S DIBTY=Y K DIC,DLAYGO,DIEDT,DIOVRD G QDIC:Y'>0
 N X,DIBTSEC S DIBTSEC="" I $O(^DIBT(+Y,0))]"" S DIBTSEC=Y(0) D ALR
 I $D(DIRUT)!(Y'>0) G QDIC
 D NOW^%DTC
 S ^DIBT("F"_DK,$P(Y,U,2),+Y)=1,^DIBT(+Y,0)=$P(Y,U,2)_U_+$J(%,0,4)_U_$S(DIBTSEC]"":$P(DIBTSEC,U,3),1:DUZ(0))_U_DK_U_DUZ_U_$S(DIBTSEC]"":$P(DIBTSEC,U,6),1:DUZ(0)) I $D(DIAR),'$D(DIARI) S $P(^(0),U,8)=1
 K DIBTSEC N DIE,DA,DI,DK,DR,Y S DIE="^DIBT(",DA=+DIBTY,DR=10,DIOVRD=1 D ^DIE K DUOUT,DIROUT,DIRUT ;EDIT SORT TEMPLATE DESCRIPTION
QDIC K DIBT1,DIBTY,DIOVRD,%,%X,%Y Q
 ;
ALR W !,$C(7) I $D(DIBT),+Y=DIBT W "NO!! YOU ARE USING THAT TEMPLATE FOR YOUR LIST OF ENTRIES!" S Y=-1 Q
 I $D(DISV),+Y=DISV W "NO!! YOU ARE GOING TO STORE SEARCH RESULTS IN THAT TEMPLATE!" S Y=-1 Q
 N DIR S DIR(0)="Y",DIR("B")="NO",DIR("A")="DATA ALREADY STORED THERE....OK TO PURGE" D ^DIR Q:$D(DIRUT)
CLN I Y=1 D  S Y=DIBTY Q  ;CLEAN OUT THE TEMPLATE
 .N F S %Y="",F=+$P($G(^DIBT(+DIBTY,0)),U,4) K ^DIBT("CANONIC",F,+DIBTY)
 .F  S %Y=$O(^DIBT(+DIBTY,%Y)) Q:%Y=""  I %Y'="%D",%Y'="ROU",%Y'="ROUOLD",%Y'="DIPT" K ^DIBT(+DIBTY,%Y)
 .Q
 S %Y=-1 I $O(^DIBT(+DIBTY,1,0))'>0!'$D(DIBT1) S Y=-1 Q
 F %=0:0 S %=$O(^(%)),%Y=%Y+1 Q:%'>0
 K DIR S DIR(0)="Y",DIR("B")="NO",DIR("A",1)="WANT TO MERGE THESE ENTRIES",DIR("A")="WITH THE "_%Y_" ALREADY IN '"_$P(DIBTY,U,2)_"' TEMPLATE"
 D ^DIR S Y=$S(Y=0:-1,1:DIBTY) W ! Q

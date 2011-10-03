XQ33 ;SEA/AMF/JLI/MJM - REMOVE UNREFERENCED OPTIONS ;04/13/98  13:29
 ;;8.0;KERNEL;**49,73,46**;Jul 10, 1995
DUO ; Entry point to delete unreferenced options from the option file.
 W !!,*7,"Do you want to delete unreferenced options" S %=2 D YN^DICN Q:%<0!(%=2)  I '% W !,"Enter a 'Y' if you want an opportunity to delete orphan options which are not",!,"primary menus, secondary menus, or tasked." G DUO
 K ^TMP($J) S IOP="HOME" D ^%ZIS K IOP S XQENT=0
 R !!,"Select PACKAGE/OPTION name: ALL// ",X:DTIME S:'$T X=U S DIC=9.4,DIC(0)="EMZ" Q:X[U  S:'$L(X) X="ALL"
 I X="ALL" S XQS="@z",XQE="zzz" G GET
 D ^DIC I Y>0 S XQS=$P(Y(0),U,2),XQE=XQS_"zzz" G GET
 S DIC=19,DIC(0)="QEMZ" D ^DIC G:Y<0 DUO S XQE=$P(Y(0),U,1),XQS=$E(XQE,1,$L(XQE)-1)_$C($A($E(XQE,$L(XQE))-1))_"zzz"
GET W !,"Getting the list of unreferenced options..." D LP W ! I '$D(^TMP($J)) W "...NONE FOUND",! G OUT
 S XQI=0 F XQII=0:1 S DIC="^DIC(19,",DR="",XQI=$O(^TMP($J,XQI)) Q:XQI'>0  S DA=XQI W @IOF K S D EN^DIQ D DUO1 Q:XQSTOP
 G OUT
DUO1 ;
 W !!,"Want to delete this option" S %=2,XQSTOP=0 D YN^DICN S:%<0 XQSTOP=1 Q:%<0!(%=2)  I '% W !,"Enter a 'Y' if you want to remove this option from the option file" G DUO1
 S DIK="^DIC(19," D ^DIK ;S DIE=19,DR=".01///@" D ^DIE
 Q
LP S XQUI=0,XQJ=XQS F  S XQJ=$O(^DIC(19,"B",XQJ)) Q:XQJ=""!XQUI!(XQJ]XQE)  D LP1
 Q
LP1 S XQI=0 F  S XQI=$O(^DIC(19,"B",XQJ,XQI)) Q:XQI'>0!XQUI  D LP2
 Q
LP2 I "BOQSX"[$P(^DIC(19,XQI,0),U,4) K XQFL Q  ;Special options
 S XQFL="" W:XQENT !,XQJ,?31 I '$D(^DIC(19,"AD",XQI)) W:XQENT "** no parents **" G PRI
 K XQFL S (XQK,XQLEN,XQNM)=0
 I XQENT F  S XQK=$O(^DIC(19,"AD",XQI,XQK)) Q:XQK'>0  I $D(^DIC(19,XQK,0)) S L=$P(^DIC(19,XQK,0),U,1) S:XQLEN+$L(L)+2>34 XQLEN=0 W:'XQLEN&XQNM !?31 W:XQNM&XQLEN ", " W $P(^DIC(19,XQK,0),U,1) S XQLEN=XQLEN+$L(L)+2,XQNM=XQNM+1
PRI ;
 I $D(^VA(200,"AP",XQI)) W:XQENT ?65,"-P-" K XQFL ;Primary Menu
 I $D(^VA(200,"AD",XQI)) W:XQENT ?70,"-S-" K XQFL ;Secondary Menu
 I $D(^DIC(19,XQI,200.9)),^(200.9)["y" W:XQENT&($P(^(200.9),U)["y") ?75,"-T-" K XQFL ;Taskman or don't delete
 E  I $D(^DIC(19.2,"B",XQI)) W:XQENT ?75,"-T-" K XQFL ;Taskman
 I $D(XQFL) S ^TMP($J,XQI)=""
 Q
 ;
OUT D ^%ZISC
 K XQUI,XQJ,XQS,XQE,XQK,XQLEN,XQNM,XQI,I,J,K,C,L,DIC,POP,X,XQDSH,XQENT,XQHDR,XQP,Y,ZISI,ZTDTH,ZTSAVE,ZTRTN,ZTDESC,%A1,S,XQFL
 K %Y,A,D0,D1,DA,DIW,DIWF,DIWL,DIWR,DIWT,DK,DL,DN,DR,DX,XQSTOP
 Q

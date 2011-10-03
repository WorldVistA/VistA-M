GMRAPED1 ;HIRMFO/RM-EDIT DRUG CLASS FIELD ;11/16/07  10:06
 ;;4.0;Adverse Reaction Tracking;**41**;Mar 29, 1996;Build 8
 ;DBIA Section
 ;PSN50P65 - 4543
 ;XLFDT    - 10103
 ;PSNDI    - 4554
 ;DIC      - 10006
 ;DIE      - 10018
DRGCLS ; EDIT VA DRUG CLASS MULTIPLE
 K ^TMP($J,"GMRACLASS") ;41 clean out before using
 S GMRAB=$S($D(^GMR(120.8,GMRAPA,3,0)):$P(^(0),"^",3),1:""),GMRAB=$S($D(^GMR(120.8,GMRAPA,3,+GMRAB,0)):+^(0),1:0) D C^PSN50P65(GMRAB,,"GMRACLASS") S GMRAB=$S($D(^TMP($J,"GMRACLASS",GMRAB,1)):$P(^(1),U),1:"") ;41 added C^PSN50P65
RDCLS W !,"Select VA DRUG CLASS: ",$S(GMRAB'="":GMRAB_"// ",1:"") R X:DTIME S:'$T X="^^" I "^^"[X S:X'="" GMRAOUT=1 Q
 I "@"[X W !,"YOU CAN NOT DELETE A VA DRUG CLASS.",$C(7)
 S:'$D(^GMR(120.8,GMRAPA,3,0)) ^(0)="^120.803PA^^" ;41 separated out command
 I X?1"?".E D  W ! ;41 List existing drug class for allergy, entire section added w/ patch 41
 .N SUB,IEN K ^TMP($J,"GMRACLASS")
 .I $O(^GMR(120.8,GMRAPA,3,0)) W !!?3,"Choose from:",!
 .S SUB=0 F  S SUB=$O(^GMR(120.8,GMRAPA,3,SUB)) Q:'+SUB  S IEN=^(SUB,0) D C^PSN50P65(IEN,,"GMRACLASS") W !,?3,$G(^TMP($J,"GMRACLASS",IEN,.01)),?$X+5,$G(^TMP($J,"GMRACLASS",IEN,1))
DGDIC S:X?1"?".E X="?" S DIC="^PS(50.605,",DIC(0)="EQMZ",DIC("W")="W ?$X+5,$P(^(0),U,2)" K DTOUT,DUOUT D DIC^PSNDI(50.605,"GMRA",.DIC,.X,,$$DT^XLFDT) K DIC I +Y'>0 G RDCLS ;41
 S DA(1)=GMRAPA,DA=$O(^GMR(120.8,GMRAPA,3,"B",+Y,0)) I DA'>0 D  S DA=+Y G:DA'>0 RDCLS
 .S DIC="^GMR(120.8,"_GMRAPA_",3,",DLAYGO=120.8,DIC(0)="EQL",X=$P(Y(0),"^") D ^DIC K DIC,DLAYGO
 .Q
EDDC S DIE="^GMR(120.8,"_GMRAPA_",3,",DR=".01  VA DRUG CLASS" D ^DIE S:$D(Y) GMRAOUT=1 S GMRAB=""
 Q:GMRAOUT  G RDCLS

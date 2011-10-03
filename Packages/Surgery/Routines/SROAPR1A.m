SROAPR1A ;B'HAM ISC/MAM - EDIT PREOP INFO ; [ 03/16/04  2:44 PM ]
 ;;3.0; Surgery ;**38,125**;24 Jun 93
 K DA D @EMILY Q
4 ; edit gastrointestinal information
 W ! K DIR S X=$P(SRAO(4),"^") I X'="" S DIR("B")=X
 S DIR(0)="130,486",DIR("A")="GASTROINTESTINAL" D ^DIR K DIR I $D(DUOUT) S SRSOUT=1 Q
 I X="@" S SRCAT="Gastrointestinal" D SURE Q:SRSOUT  G:'SRYN 4 S (SRAX,X)="",$P(^SRF(SRTN,200.1),"^")="" D NOGAST Q
 S SRAX=Y,$P(^SRF(SRTN,200.1),"^")=SRAX I Y["N" D NOGAST Q
 I Y["Y" D GAST
 Q
5 ; edit cardiac information
 W ! K DIR S X=$P(SRAO(5),"^") I X'="" S DIR("B")=X
 S DIR(0)="130,242",DIR("A")="CARDIAC" D ^DIR K DIR I $D(DUOUT) S SRSOUT=1 Q
 I X="@" S SRCAT="Cardiac" D SURE Q:SRSOUT  G:'SRYN 5 S (SRAX,X)="",$P(^SRF(SRTN,200),"^",30)="" D NOCARD Q
 S SRAX=Y,$P(^SRF(SRTN,200),"^",30)=SRAX I Y["N" D NOCARD Q
 I Y["Y" D CARD
 Q
6 ; edit vascular information
 W ! K DIR S X=$P(SRAO(6),"^") I X'="" S DIR("B")=X
 S DIR(0)="130,206",DIR("A")="VASCULAR" D ^DIR K DIR I $D(DUOUT) S SRSOUT=1 Q
 I X="@" S SRCAT="Vascular" D SURE Q:SRSOUT  G:'SRYN 6 S $P(^SRF(SRTN,200),"^",40)="" S (SRAX,X)="" D NOVAS Q
 S SRAX=Y,$P(^SRF(SRTN,200),"^",40)=SRAX I Y["N" D NOVAS Q
 I Y["Y" D VAS
 Q
GAST ; gastointectinal
 K DIE S DA=SRTN,DIE=130,DR="213////Y" D ^DIE K DR
 S SRACLR=0
 Q
NOGAST ; no gastointectinal problems
 S $P(^SRF(SRTN,200),"^",16)=SRAX
 Q
CARD ; cardiac
 W ! K DR,DIE S DA=SRTN,DIE=130,DR="396T;394T;220T;266T;395T;208T" D ^DIE K DR
 S SRACLR=0
 Q
NOCARD ; no cardiac problems
 F I=31:1:36 S $P(^SRF(SRTN,200),"^",I)=SRAX
 Q
VAS ; vascular
 W ! K DR,DIE S DA=SRTN,DIE=130,DR="329T;330T" D ^DIE K DR
 S SRACLR=0
 Q
NOVAS ; no vascular problems
 F I=41,42 S $P(^SRF(SRTN,200),"^",I)=SRAX
 Q
RET W !! K DIR S DIR(0)="E" D ^DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
SURE W ! K DIR S DIR("A")="   Sure you want to delete all "_SRCAT_" information ? ",DIR("B")="NO",DIR(0)="YA" D ^DIR K DIR S SRYN=Y I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q

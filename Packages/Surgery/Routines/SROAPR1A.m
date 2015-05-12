SROAPR1A ;B'HAM ISC/MAM - EDIT PREOP INFO ; [ 03/16/04  2:44 PM ]
 ;;3.0;Surgery;**38,125,182**;24 Jun 93;Build 49
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
 W ! K DR,DIE S DA=SRTN,DIE=130,DR="207T;205T;640T" D ^DIE K DR
 S X="5D" D ^SROACL2  S SRYY=Y D
 .K DR,DIE S DA=SRTN,DR="485///"_$P(SRYY,"^"),DIE=130 D ^DIE K DR
 W ! K DR,DIE S DA=SRTN,DIE=130,DR="267T;643T;641T" D ^DIE K DR
 S SRACLR=0
 Q
NOCARD ; no cardiac problems
 F I=32,36 S $P(^SRF(SRTN,200),"^",I)=SRAX
 S $P(^SRF(SRTN,206),"^",19)="N",$P(^SRF(SRTN,206),"^",18)="N"
 S $P(^SRF(SRTN,206),"^",42)=0
 S $P(^SRF(SRTN,206),"^",14)=0
 S $P(^SRF(SRTN,200),"^",56)=1,$P(^SRF(SRTN,200),"^",57)=1
 S $P(^SRF(SRTN,200),"^",59)=1
 Q
VAS ; vascular
 W ! K DR,DIE S DA=SRTN,DIE=130,DR="265T;330T" D ^DIE K DR
 S SRACLR=0
 Q
NOVAS ; no vascular problems
 S $P(^SRF(SRTN,200),"^",42)=SRAX
 S $P(^SRF(SRTN,206),"^",16)=1
 Q
RET W !! K DIR S DIR(0)="E" D ^DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
SURE W ! K DIR S DIR("A")="   Sure you want to delete all "_SRCAT_" information ? ",DIR("B")="NO",DIR(0)="YA" D ^DIR K DIR S SRYN=Y I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q

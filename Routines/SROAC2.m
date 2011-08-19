SROAC2 ;B'HAM ISC/MAM - ENTER COMPLICATIONS ; 4 MAR 1992  11:00 am
 ;;3.0; Surgery ;;24 Jun 93
 D @EMILY Q
1 ; postop wound complications
 I SRSOUT Q
 S X=$P(SRA(205),"^",5) I X'="" S DIR("B")=$S(X="N":"NO",X="NS":"NS",1:"YES")
 S DIR(0)="130,403",DIR("A")="Postoperative Wound Complications" D ^DIR K DIR I $D(DUOUT) S SRSOUT=1 Q
 I X="@" S (SRAX,X)="" W "     Deleting information...  " F I=5:1:8 S $P(^SRF(SRTN,205),"^",I)=""
 S $P(^SRF(SRTN,205),"^",5)=$S(X="NS":"NS",1:$E(X)) I X["N" F I=6,7,8 S $P(^SRF(SRTN,205),"^",I)=$S(X="NS":"NS",1:"N")
 I X["Y" K DR S DIE=130,DA=SRTN,DR="248T;249T;404T" D ^DIE K DR W !
 Q
2 ; respiratory complications
 I SRSOUT Q
 S X=$P(SRA(205),"^",9) I X'="" S DIR("B")=$S(X="N":"NO",X="NS":"NS",1:"YES")
 S DIR(0)="130,318",DIR("A")="Respiratory Complications" D ^DIR K DIR I $D(DUOUT) S SRSOUT=1 Q
 I X="@" S (SRAX,X)="",$P(^SRF(SRTN,205),"^",9)="" W !!,"Deleting all Respiratory Complications...",! D RESP^SROAC1 Q
 S $P(^SRF(SRTN,205),"^",9)=$S(X="NS":"NS",1:$E(X)) I X["N" D RESP^SROAC1
 I X["Y" K DR S DIE=130,DA=SRTN,DR="251T;412T;252T;285T;253T" D ^DIE K DR W !
 Q
3 ; urinary tract complications
 I SRSOUT Q
 S X=$P(SRA(205),"^",15) I X'="" S DIR("B")=$S(X="N":"NO",X="NS":"NS",1:"YES")
 S DIR(0)="130,319",DIR("A")="Urinary Tract Complications" D ^DIR K DIR I $D(DUOUT) S SRSOUT=1 Q
 I X="@" S (SRAX,X)="",$P(^SRF(SRTN,205),"^",15)="" W !!,"Deleting all Urinary Tract complications...",! D URINE^SROAC1 Q
 S $P(^SRF(SRTN,205),"^",15)=$S(X="NS":"NS",1:$E(X)) I X["N" D URINE^SROAC1
 I X["Y" K DR S DIE=130,DA=SRTN,DR="409T;254T;255T;286T" D ^DIE K DR W !
 Q
4 ; CNS complications
 I SRSOUT Q
 S X=$P(SRA(205),"^",20) I X'="" S DIR("B")=$S(X="N":"NO",X="NS":"NS",1:"YES")
 S DIR(0)="130,320",DIR("A")="CNS Complications" D ^DIR K DIR I $D(DUOUT) S SRSOUT=1 Q
 I X="@" S (SRAX,X)="",$P(^SRF(SRTN,205),"^",20)="" W "     Deleting CNS Complications..." D CNS^SROAC1 Q
 S $P(^SRF(SRTN,205),"^",20)=$S(X="NS":"NS",1:$E(X)) I X["N" D CNS^SROAC1
 I X["Y" K DR S DA=SRTN,DIE=130,DR="256T;410T;287T;343T" D ^DIE K DR W !
 Q
5 ; cardiac complications
 I SRSOUT Q
 S X=$P(SRA(205),"^",25) I X'="" S DIR("B")=$S(X="N":"NO",X="NS":"NS",1:"YES")
 S DIR(0)="130,321",DIR("A")="Cardiac Complications" D ^DIR K DIR I $D(DUOUT) S SRSOUT=1 Q
 I X="@" S (SRAX,X)="",$P(^SRF(SRTN,205),"^",25)="" W "     Deleting Cardiac Complications..." D CARD^SROAC1 Q
 S $P(^SRF(SRTN,205),"^",25)=$S(X="NS":"NS",1:$E(X)) I X["N" D CARD^SROAC1
 I X["Y" K DR S DIE=130,DA=SRTN,DR="411T;258T;259T;344T" D ^DIE K DR W !
 Q
6 ; other complications
 I SRSOUT Q
 S X=$P(SRA(205),"^",30) I X'="" S DIR("B")=$S(X="N":"NO",X="NS":"NS",1:"YES")
 S DIR(0)="130,322",DIR("A")="Other Postoperative Complications" D ^DIR K DIR I $D(DUOUT) S SRSOUT=1 Q
 I X="@" S (SRAX,X)="",$P(^SRF(SRTN,205),"^",30)="" W "     Deleting Other Complications...  " D OTHER^SROAC1 Q
 S $P(^SRF(SRTN,205),"^",30)=$S(X="NS":"NS",1:$E(X)) I X["N" D OTHER^SROAC1
 I X["Y" K DR S DA=SRTN,DIE=130,DR="345T;257T;261T;263T;250T;392T" D ^DIE K DR
 Q

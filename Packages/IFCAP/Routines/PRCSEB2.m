PRCSEB2 ;SF-ISC/LJP-CONTROL POINT ACTIVITY EDITS CON'T ;10-29-91/15:23
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
ENDR ;ENTER 1358 DAILY RECORD
 W ! D EN3^PRCSUT G W1:'$D(PRC("SITE")),EXIT:Y<0
ENDRR Q:'$D(PRC("SITE"))  S DIC="^PRCS(410,",DIC(0)="AEQ",DIC("A")="Select OBLIGATION NUMBER: ",D="D"
 S DIC("S")="S Z=$P(^(0),U,1,4) I $P(Z,U,4)=1,$P(Z,U,2)=""O"",+Z=PRC(""SITE""),+$P(Z,""-"",4)=+PRC(""CP""),$D(^(10)),$P(^(10),U,3) I $D(^PRC(420,""A"",DUZ,PRC(""SITE""),+PRC(""CP""),1))!($D(^(2)))"
 D ^PRCSDIC G EXIT:Y<0 K DIC("S"),DIC("A") S PRCSDA=+Y,PRCSON=$S($D(^PRCS(410,+Y,10)):$P(^(10),"^",3),1:"") I PRCSON']"" G W4
 I $D(^PRC(442,PRCSON,7)) S X=$P(^(7),"^") I $O(^PRCD(442.3,"AC",+X,0))=40 W $C(7),!!,"This 1358 transaction is complete.  No further action can be taken on it.",!,"Contact Fiscal Service for further information." G ENDR
 G:'$D(^PRC(442,PRCSON,0)) W4 W:$D(^(8)) !?35,"1358 Balances",!?35,"Estimated: $ ",$J($P(^(8),U,3),9,2),"  Actual: $ ",$J($P(^(8),U,1),9,2) S (PRCFA("PODA"),PRCSX,Z)=$P(^(0),U,1) Q:$D(PRCSCK)  G W5
ENDR2 W ! S DIC="^PRC(424,",DIC(0)="AEQZ",DIC("A")="Select DAILY RECORD REFERENCE: ",D="C",DIC("S")="I $D(^PRC(424,""AE"",PRCSDA,+Y)),$P(^PRC(424,+Y,0),U,4)=""S"",$D(^PRC(424,+$O(^PRC(424,""B"",PRCSX_""-0001"",0)),0)) I '$P(^(0),U,15)"
 D IX^DIC K DIC("S"),DIC("A") G:Y<0 EXIT S PRCSDA1=Y S PRCSDES=$P(^PRC(424,+PRCSDA1,0),U,7) Q:$D(PRCSCK)  G ENDR1
ENNEW S:'$D(Z) Z=PRCSX I $D(^PRC(424,"AC",PRCSX)) S X=PRCSX D EN1^PRCSUT3 Q:'X  S X1=X,DLAYGO=424,DIC="^PRC(424,",DIC(0)="LXZ" D ^DIC K DLAYGO G W2:Y<0 S PRCSDA1=+Y D W3
 S $P(^PRC(424,+PRCSDA1,0),"^",2,4)=PRCSON_"^"_PRCSDA_"^S",^PRC(424,"AD",PRCSON,+PRCSDA1)="",^PRC(424,"AE",PRCSDA,+PRCSDA1)=""
ENDR1 I $D(PRCSDES),(PRCSDES'="") S $P(^PRC(424,+PRCSDA1,0),U,7)=PRCSDES,^PRC(424,"C",PRCSDES,+PRCSDA1)=""
 S DA=+PRCSDA1,DR="[PRCS1358ENDR]",DIE=DIC S:$D(PRCSED) DR="[PRCS1358EDDR]" D ^DIE K PRCSOLD,PRCSXX,PRCSED W ! G W5
EDDR ;EDIT 1358 DAILY RECORD ENTRY
 S PRCSED="" G ENDR2
W1 W !!,"You are not an authorized control point user.",!,"Contact your control point official." R X:5 G EXIT
W2 W !!,"Sorry, another user is accessing the file.  Please try later.",$C(7) R X:5 G EXIT
W3 W !!,"This new 1358 Daily Record is ",X1,! Q
W4 W !!,"Fiscal Service has not yet established an obligation for this 1358 request.",!,"Contact Fiscal Service." R X:5 G EXIT
W5 I $D(^PRC(424,+$O(^PRC(424,"B",PRCSX_"-0001",0)),0)),$P(^(0),U,15) W !,"This 1358 Daily Record has been stamped as complete." G EXIT
 I '$D(^PRC(424,"AC",PRCSX)) W !,"This 1358 has not been obligated by Fiscal." G EXIT
 W !,"Would you like to create a new 1358 Daily",!,"Record entry for this "_PRCSX_" Obligation" S %=1 D YN^DICN D:%=0 W G W5:%=0,ENNEW:%=1,EDDR:%=2 Q
W6 W !!,"Would you like to select Obligation" S %=2 D YN^DICN D:%=0 W G W6:%=0,ENDR:%=1 G EXIT
W7 W !!,"There is not a Reference entry to stamp completed." R X:5 G EXIT
W W !?5,"Answer 'Y' for Yes or 'N' for No" Q
EXIT K %,DA,DIC,DIE,DR,PRCSCK,PRCSON,PRCSDES,PRCSDA,PRCSDA1,PRCSED,PRCSOLD,PRCSX,PRCSXX,X,X1 Q
COMP ;SET COMPLETED FLAG ON REFERENCE OR PAT NUMBER
 S PRCSCK=1 D ENDR I '$D(PRCSDA) G EXIT
ASK2 S %=1 W !,"Do you wish to stamp all Obligation References as complete" D YN^DICN D:%=0 W G ASK2:%=0,EXIT:%=-1,COMP1:%=1 D ENDR2:%=2
 G:'$D(PRCSDA1) EXIT I '$D(PRCSDES),PRCSDES="" G W7
 S DA="",DA=$O(^PRC(424,"C",PRCSDES,0)) G:DA'>0 W7 I $D(^PRC(424,DA,0)) S DIE="^PRC(424,",DR=16 D ^DIE G EXIT
COMP1 G:'$D(PRCSX) W7 S DA="",DA=$O(^PRC(424,"B",PRCSX_"-0001",0)) G:DA'>0 W4 I $D(^PRC(424,DA,0)) S DIE="^PRC(424,",DR=16 D ^DIE G EXIT
 Q

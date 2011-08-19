LREPIPI ;DALOI/CKA - Local Pathogens Input;7/2/03
 ;;5.2;LAB SERVICE;**281**;Sep 27, 1994
 ; Reference to $$SITE^VASITE supported by IA #10112
 ; Reference to ^ORD(101 supported by IA #872
EN ;
 S LRNO="",SITE=$P($$SITE^VASITE,U)
 S DIR(0)="FO^3:30",DIR("A")="LOCAL PATHOGEN NAME",DIR("?")="Enter the name of the local pathogen [3-30 characters].  You may also enter part of the name for look up purposes."
 S DIR("??")="^S D=""B"",DIC=""^LAB(69.5,"",DIC(0)=""EZ"",DIC(""S"")=""I Y>99"" D DQ^DICQ K DIC"
 D ^DIR K DIR I $D(DIRUT) G EXIT
 S LRX=Y
LKUP ;
 S DIC="^LAB(69.5,",DIC("S")="I Y>99",DIC(0)="EMZ" D ^DIC K DIC S LREPIFN=+Y
 I $G(LRDEL) Q
 I Y="" D EXIT G EN
 I $D(DTOUT) G NOU
 I Y'<0 D FND
 I Y<0 D ADD D EXIT G EN
 G:$G(Y)["^"!($D(DTOUT)) NOU
 G:LRNO EN D:LRY EDIT G EN
 G EN
 Q
 ;
ADD ;
 S DIR(0)="Y",DIR("A")="Do you want to add this local pathogen",DIR("B")="YES" D ^DIR G:$D(DTOUT) NOU K DIR
 I 'Y Q
 S LRNUM=99
 F  S LRNUM1=$O(^LAB(69.5,LRNUM)) Q:'LRNUM1  S LRNUM=LRNUM+1
 S LRDA=LRNUM+1
 K DD,DO
 S DIC="^LAB(69.5,"
 S DIC(0)="L"
 S DLAYGO=69.5
 S DINUM=LRDA
 S X=LRX_SITE
 D FILE^DICN
 I Y=-1 D NOU G EN
 S $P(^LAB(69.5,LRDA,0),U,2)=0
 S $P(^LAB(69.5,LRDA,0),U,9)=LRDA
 S LRPROT=0,LRPROT=$O(^ORD(101,"B","LREPI",LRPROT))
 S $P(^LAB(69.5,LRDA,0),U,7)=LRPROT
 S LREPIFN=LRDA
EDIT S DA=LREPIFN
 S DDSFILE="^LAB(69.5,"
 S DR="[LREPI9]"
 D ^DDS
 K DDSFILE(1)
 W !!
 D EXIT
 Q
EXIT K DA,DD,DDSFILE,DLAYGO,DIC,DIK,DINUM,DIR,DO,DR,DTOUT,DUOUT,L,LRDA,LRDEL,LRNO,LRNUM,LRNUM1,LREPIFN,LRPROT,LRX,LRXX,LRY,SITE,X,Y Q
FND W !,"This pathogen is already entered as a local pathogen.",!
 S DIC="^LAB(69.5,",DA=+Y,DR="0:6;8:9" D EN^DIQ
 S DIR(0)="Y",DIR("A")="Is this the correct one" D ^DIR K DIR
 I 'Y S LRNO=1 W !! Q
YN1 S DIR(0)="Y",DIR("A")="Do you want to edit this local pathogen",DIR("B")="NO"
 D ^DIR
 K DIR
 S LRY=Y
 W !! Q
 Q
NOU W !!,$C(7),?20,"NO UPDATING HAS OCCURRED!!!" K DIR G:$D(DTOUT) EXIT W !! G EN
DELETE ;DELETE LOCAL PATHOGEN
 S LRDEL=1
 D EN
 I '$D(Y) G EXIT
 S LRXX=Y
 G:$D(DTOUT)!($D(DUOUT))!(Y="") EXIT
 S DIC="^LAB(69.5,"
 S DIC(0)="EMZ"
 S DIC("S")="I $P(^(0),U,9)>99"
 D ^DIC
 K DIC
 I Y=-1 W !,"NO MATCH FOUND." G DELETE
 S LRY=Y
 S DIR(0)="Y",DIR("A")="Do you really want to delete this pathogen"
 D ^DIR
 K DIR
 G:$D(DTOUT)!($D(DUOUT)) EXIT
 I 'Y G DELETE
 I LRY>99 S DA=+LRY D KILL G DELETE
 G DELETE
 ;
KILL S DIK="^LAB(69.5,"
 D ^DIK
 W !!,"Entry ",$P(LRY,U,2)," deleted."
 K DIK
 Q
INQUIRY S DIC="^LAB(69.5,",DIC("A")="Select Pathogen: ",DIC(0)="AEMQ" D ^DIC K DIC
 I Y<0 K DIC,DA,D0,DR,Y Q
INQ1 S DIC="^LAB(69.5,",DA=+Y,DR="0:6" D EN^DIQ
 D PAUSE^LREPIRS2
 I $G(LRQUIT) K DIC,DA,D0,DR,LRQUIT,Y Q
 S DR="8:9" D EN^DIQ
 K DIC,DA,DO,DR,LRQUIT,Y
 G INQUIRY
PRINT S L=0,DIC="^LAB(69.5,"
 D EN1^DIP
 Q

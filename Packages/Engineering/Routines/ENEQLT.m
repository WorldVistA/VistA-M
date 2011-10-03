ENEQLT ;;(WASHIRMFO)/DH-Control Status of LOCKOUT REQUIRED flags ;2.12.97
 ;;7.0;ENGINEERING;**35**;August 17,1993
 ;If field set to YES then equipment must be isolated and rendered
 ;inoperative prior to service.
 ;     No input data expected
 ;     Edits Equipment File (6914) and prints reports
 ;     Fictitious global ^ENG("ENEQLT") is LOCKED to insure that only
 ;       one user at a time can edit LOCKOUT REQUIRED Flags
 ;     Edits are not individually LOCKED
EN N METHOD,ESCAPE,CATEGORY,CAT,DA,DIC,DIE,DR
 L +^ENG("ENEQLT"):1 I '$T W !!,"Sorry, but another user is editing 'LOCKOUT REQUIRED?' flags.",*7 G EXIT
 ;
ACTION ;   SET or CLEAR?
 S DIR("A")="Should 'LOCKOUT REQUIRED?' Flag be SET or CLEARED"
 S DIR("B")="Set",DIR(0)="S^S:Set;C:Cleared"
 D ^DIR K DIR S ENACT=$E(Y) I $D(DIRUT) G EXIT
 ;
METHOD W @IOF S DIR("A")=$S(ENACT="S":"SET",1:"CLEAR")_" 'LOCKOUT REQUIRED?' Flag by"
 S DIR("B")=1
 S DIR(0)="S^1:Equipment Categories;2:Equipment Entries"
 S DIR("?",1)="This utility is to manage (SET or CLEAR) the LOCKOUT REQUIRED field in the"
 S DIR("?",2)="Equipment File. You may specify changes to all equipment belonging to"
 S DIR("?",3)="selected EQUIPMENT CATEGORIES (Option 1) or you may select Equipment Records"
 S DIR("?",4)="individually (Option 2)."
 S DIR("?",5)=" "
 S DIR("?")="Please enter '1' or '2' or '^' to escape."
 S ESCAPE=0 D ^DIR K DIR S METHOD=Y I $D(DIRUT) G EXIT
 ;
GETLIST ;   Create a list in '^XUTL("ENLT",ENDATE("I"),' of records to be edited
 D NOW^%DTC S (Y,ENDATE("I"))=% X ^DD("DD") S ENDATE=$P(Y,":")_":"_$P(Y,":",2)
 K ^XUTL("ENLT",ENDATE("I")) S ESCAPE=0
 I METHOD=1 D ECAT I ESCAPE K ^XUTL("ENLT",ENDATE("I")) G EXIT
 ;
EDITEC I $D(CATEGORY) S DA=0,DIE="^ENG(6911,",DR="2///^S X="_$S(ENACT="S":1,1:0) F  S DA=$O(CATEGORY(DA)) Q:'DA  D ^DIE
 I METHOD=2 D ELIST I $D(DTOUT)!($D(DUOUT)) K ^XUTL("ENLT",ENDATE("I")) G EXIT
 I '$D(^XUTL("ENLT",ENDATE("I"))) W !!,?20,"Equipment File unchanged." D HOLD G EXIT
 ;
EDITER S DIE="^ENG(6914,",DR="9///^S X="_$S(ENACT="S":1,1:0)
 S DA=0 F  S DA=$O(^XUTL("ENLT",ENDATE("I"),DA)) Q:'DA  D ^DIE
 D REPAT^ENEQLT1 ;Summary of action taken
 G EXIT ;Design EXIT POINT
 Q
 ;
ECAT ;   Build Equipment List by Equipment Category
 W ! S DIC="^ENG(6911,",DIC(0)="AEQM"
 F  D SELCT Q:ESCAPE!(Y'>0)
 Q:'$D(CATEGORY)!(ESCAPE)
 D BUILD
 Q
 ;
SELCT ;   Select Equipment Categories
 D ^DIC I Y'>0 S:$D(DTOUT)!($D(DUOUT)) ESCAPE=1 Q
 I $O(^ENG(6914,"G",+Y,0))'>0 W !,"There are no Equipment Entries on file for this Equipment Category, but the",!,"Equipment Category File will be updated."
 I '$D(CATEGORY(+Y)) S CATEGORY(+Y)=$P(^ENG(6911,+Y,0),U)
SELCT1 S DIR(0)="SBM^Y:YES;N:NO;L:LIST",DIR("A")="Would you like to add another Equipment Category",DIR("B")="NO"
 S DIR("?",1)="Please indicate whether or not you want to add another Equipment Category"
 S DIR("?",2)="to your processing list. You may also enter 'L' for a list of Equipment"
 S DIR("?")="Categories already selected or '^' to escape without changing anything."
 W ! D ^DIR K DIR I $D(DIRUT) S ESCAPE=1 Q
 I Y="Y" G SELCT
 I Y="L" D LST^ENEQLT1 Q:ESCAPE  G SELCT1
 Q
 ;
BUILD ;   Build equipment list from selected EQUIPMENT CATEGORIES
 S CAT=0 F  S CAT=$O(CATEGORY(CAT)) Q:'CAT  D
 . S DA=0 F  S DA=$O(^ENG(6914,"G",CAT,DA)) Q:'DA  S ^XUTL("ENLT",ENDATE("I"),DA)=""
 Q
 ;
ELIST ;   Build Equipment List directly from EQUIPMENT FILE
 W ! F  D  Q:Y'>0
 . D GETEQ^ENUTL I Y'>0 S:$D(DTOUT)!($D(DUOUT)) ESCAPE=1 Q
 . S ^XUTL("ENLT",ENDATE("I"),+Y)=""
 Q
HOLD Q:$E(IOST,1,2)'="C-"
 W !!,"Press <RETURN> to continue, or '^' to escape..." R X:DTIME
 S:$E(X)="^" ESCAPE=1
 Q
 ;
EXIT L -^ENG("ENEQLT")
 K ENDATE,ENACT
 Q
 ;ENEQLT

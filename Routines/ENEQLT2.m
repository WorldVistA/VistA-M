ENEQLT2 ;(WIRMFO)/DH-LOCKOUT FLAG REPORTS ;4.9.97
 ;;7.0;ENGINEERING;**35**;Aug 17, 1993
 ;==================================================================
PRTEC ;   Print equipment categories with 'LOCKOUT REQUIRED?' field
 ;   set to 'YES'.
 ;
 K IO("Q") S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) S ZTRTN="DQEC^ENEQLT2" D  G EXIT
 . S ZTDESC="LOCKOUT flag by Equipment Category"
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
DQEC N DATE,CAT,DA,COUNT,PAGE,LINE,ESCAPE,X S (CAT,DA,PAGE)=0
 K ^TMP($J) D NOW^%DTC S Y=% X ^DD("DD") S DATE=$P(Y,":")_":"_$P(Y,":",2)
 D TABS
 F  S CAT=$O(^ENG(6911,"AC",1,CAT)) Q:'CAT  D
 . S COUNT=0 F  S DA=$O(^ENG(6914,"G",CAT,DA)) Q:'DA  S COUNT=COUNT+1
 . S ^TMP($J,CAT)=COUNT
PRTEC1 ;   Physical printing of EQUIPMENT CATEGORIES
 U IO D HDREC I '$D(^TMP($J)) W !,?5,"No EQUIPMENT CATEGORIES have 'LOCKOUT REQUIRED?' Flag SET"
 S CAT=0 F  S CAT=$O(^TMP($J,CAT)) Q:'CAT  D
 . W !,?5,$$GET1^DIQ(6911,CAT,.01)_"  ("_^TMP($J,CAT)_" Equipment Records)"
 . S LINE=LINE+1
 . I LINE>(IOSL-3),$O(^TMP($J,CAT)) D HOLD,HDREC
 D HOLD,EXIT
 Q  ;Design EXIT POINT
 ;
HDREC ;   Header for EQUIPMENT CATEGORY List
 W:PAGE>0!($E(IOST,1,2)="C-") @IOF S PAGE=PAGE+1,LINE=3,$X=0
 W "EQUIPMENT CATEGORIES with 'LOCKOUT REQUIRED?' Flag set to 'YES'"
 W ?(IOM-7),"Page "_PAGE,!,DATE
 K X S $P(X,"-",IOM-1)="-" W !,X,!
 Q
 ;======================================================================
 ;
PRTER ;   Print Equipment Records with 'LOCKOUT REQUIRED?' flag set to 'YES'
 ;     Sortable by EQUIPMENT CATEGORY
 ;
 S DIR(0)="Y",DIR("A")="Sort Report by EQUIPMENT CATEGORY",DIR("B")="YES"
 D ^DIR K DIR Q:$D(DIRUT)  S ENSORT=Y
 K IO("Q") S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) S ZTRTN="DQER^ENEQLT2" D  G EXIT
 . S ZTDESC="'LOCKOUT REQUIRED?' Flag by Equipment Record"
 . S ZTLOAD("ENSORT")=""
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
DQER N DATE,PAGE,LINE,CAT,ESCAPE,DA,X,T S (PAGE,CAT,ESCAPE,DA)=0
 D NOW^%DTC S Y=% X ^DD("DD") S DATE=$P(Y,":")_":"_$P(Y,":",2)
 U IO D TABS
 I '$D(^ENG(6914,"AJ",1)) D HDRER W !,?5,"No Equipment Records have 'LOCKOUT REQUIRED?' Flag set to 'YES'." D HOLD G EXIT
 ;
 ;     Sort by EQUIPMENT CATEGORY
 I ENSORT K ^TMP($J) D  D:'ESCAPE HOLD G EXIT ;Design EXIT POINT
 . F  S DA=$O(^ENG(6914,"AJ",1,DA)) Q:'DA  D
 .. S CAT("I")=$P($G(^ENG(6914,DA,1)),U)
 .. I CAT("I")'>0 S CAT("E")=0
 .. E  S CAT("E")=$P($G(^ENG(6911,CAT("I"),0)),U) S:CAT("E")="" CAT("E")=0
 .. S ^TMP($J,CAT("E"),DA)=""
 . D HDRER F  S CAT=$O(^TMP($J,CAT)) Q:CAT=""!(ESCAPE)  S DA=0 F  S DA=$O(^TMP($J,CAT,DA)) Q:'DA!(ESCAPE)  D
 .. D PRTDAT
 .. I LINE>(IOSL-4),($O(^TMP($J,CAT,DA))!($O(^TMP($J,CAT)))) D HOLD Q:ESCAPE  D HDRER
 ;
 ;     No sort by EQUIPMENT CATEGORY
 D HDRER F  S DA=$O(^ENG(6914,"AJ",1,DA)) Q:'DA!(ESCAPE)  D
 . D PRTDAT
 . I LINE>(IOSL-4),$O(^ENG(6914,"AJ",1,DA)) D HOLD Q:ESCAPE  D HDRER
 D:'ESCAPE HOLD
 G EXIT  ;Design EXIT POINT
 ;
HDRER ;   Header for Equipment Records
 W:PAGE>0!($E(IOST,1,2)="C-") @IOF S PAGE=PAGE+1,LINE=5,$X=0
 W "EQUIPMENT with 'LOCKOUT REQUIRED?' Flag 'SET'    "_DATE,?(IOM-8),"Page "_PAGE
 W !,"ENTRY #",?T(1),"Equipment Category",?T(2),"Manufacturer Equipment Name",?T(3),"Location"
 W !,?T(11),"Manufacturer",?T(12),"Model",?T(13),"Serial Number"
 K X S $P(X,"-",(IOM-1))="-" W !,X,!
 Q
 ;
 ;======================================================================
 ;
PRTEX ;   Print Equipment Records for which 'LOCKOUT REQUIRED?' Flag is CLEAR
 ;     while their EQUIPMENT CATEGORY 'LOCKOUT REQUIRED?' Flag is SET
 K IO("Q") S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) S ZTRTN="DQEX^ENEQLT2" D  G EXIT
 . S ZTDESC="'LOCKOUT REQUIRED?' Exception List"
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
DQEX N DATE,PAGE,LINE,ESCAPE,CAT,DA,X,T S (PAGE,ESCAPE,CAT)=0
 D NOW^%DTC S Y=% X ^DD("DD") S DATE=$P(Y,":")_":"_$P(Y,":",2)
 U IO D TABS
 I '$D(^ENG(6911,"AC",1)) D HDREX W !!,?10,"There are no EQUIPMENT CATEGORIES with",!,?10,"'LOCKOUT REQUIRED?' Flag SET." D HOLD G EXIT
 F  S CAT=$O(^ENG(6911,"AC",1,CAT)) Q:'CAT  S DA=0 F  S DA=$O(^ENG(6914,"G",CAT,DA)) Q:'DA  I '$D(^ENG(6914,"AJ",1,DA)) S ^TMP($J,DA)=""
 I '$D(^TMP($J)) D HDREX W !!,?10,"There are no exceptions to report." D HOLD G EXIT
 D HDREX S DA=0 F  S DA=$O(^TMP($J,DA)) Q:'DA!(ESCAPE)  D
 . D PRTDAT
 . I LINE>(IOSL-4),$O(^TMP($J,DA)) D HOLD Q:ESCAPE  D HDREX
 D:'ESCAPE HOLD
 G EXIT ;Design EXIT POINT
 ;
HDREX ;   Header for 'LOCKOUT REQUIRED?' Exception List
 W:PAGE>0!($E(IOST,1,2)="C-") @IOF S PAGE=PAGE+1,LINE=6,$X=0
 W "'LOCKOUT REQUIRED?' Flag Exception List          "_DATE,?(IOM-8),"Page ",PAGE
 W !,"(Flag is CLEAR for these ENTRIES, but their EQUIPMENT CATEGORY Flag is SET)"
 W !,"ENTRY #",?T(1),"Equipment Category",?T(2),"Manufacturer Equipment Name",?T(3),"Location"
 W !,?T(11),"Manufacturer",?T(12),"Model",?T(13),"Serial Nummber"
 K X S $P(X,"-",(IOM-1))="-" W !,X,!
 Q
 ;==================================================================
 ;
PRTDAT ;   Get and print equipment data
 S X(1)=$$GET1^DIQ(6914,DA,6),X(2)=$$GET1^DIQ(6914,DA,3)
 S X(3)=$$GET1^DIQ(6914,DA,24),X(4)=$$GET1^DIQ(6914,DA,1)
 S X(5)=$$GET1^DIQ(6914,DA,4),X(6)=$$GET1^DIQ(6914,DA,5)
 I T(13)=59 D
 . S X(1)=$E(X(1),1,20),X(2)=$E(X(2),1,30),X(4)=$E(X(4),1,32)
 . S X(5)=$E(X(5),1,21)
 . I $L(X(6))>21 S X(6)=$E(X(6),1,20)_"*"
 I T(13)=66 S X(1)=$E(X(1),1,30),X(2)=$E(X(2),1,36),X(4)=$E(X(4),1,32)
 I T(13)=94 S X(4)=$E(X(4),1,60)
 W !,DA,?T(1),X(1),?T(2),X(2),?T(3),X(3)
 W !,?T(11),X(4),?T(12),X(5),?T(13),X(6)
 S LINE=LINE+2
 Q
 ;
TABS ; Store tabs in local array T
 I IOM<96 S T(1)=12,T(2)=33,T(3)=64,T(11)=4,T(12)=37,T(13)=59
 I IOM>95,IOM<128 S T(1)=12,T(2)=43,T(3)=80,T(11)=2,T(12)=35,T(13)=66
 I IOM>127 S T(1)=12,T(2)=43,T(3)=112,T(11)=2,T(12)=63,T(13)=94
 Q
 ;
HOLD Q:$E(IOST,1,2)'="C-"
 W !!,"Press <RETURN> to continue, '^' to escape..." R X:DTIME
 S:$E(X)="^" ESCAPE=1
 Q
 ;
EXIT K ^TMP($J) D ^%ZISC
 I $D(ZTQUEUED) S ZTREQ="@"
 K ENSORT
 ;ENEQLT2

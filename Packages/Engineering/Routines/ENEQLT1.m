ENEQLT1 ;;(WIRMFO)/DH-LOCKOUT FLAG ;12.18.97
 ;;7.0;ENGINEERING;**35,47**;Aug 17, 1993
LST ;Listing is done interactively (upon request) as part of the
 ;equipment selection process. Reporting is done when changes are
 ;actually made.
 ;
 ;   NOTE: This is a list of Equipment Categories,
 ;         not Equipment Records
 N LINE,COUNT,PAGE
 S PAGE=0 D HDRLST
 S CAT=0 F  S CAT=$O(CATEGORY(CAT)) Q:'CAT  D  Q:ESCAPE
 . W !,?10,CATEGORY(CAT) S LINE=LINE+1 D
 .. S (COUNT,DA)=0 F  S DA=$O(^ENG(6914,"G",CAT,DA)) Q:'DA  S COUNT=COUNT+1
 .. W "  (",COUNT," Equipment Records)"
 . I LINE>(IOSL-3),$O(CATEGORY(CAT)) D HOLD Q:ESCAPE  D HDRLST
 D HOLD
 Q
 ;
HDRLST W:PAGE>0!($E(IOST,1,2)="C-") @IOF S PAGE=PAGE+1,LINE=3,$X=0
 W "EQUIPMENT CATEGORIES SELECTED",?40,ENDATE,?65,"Page ",PAGE,!
 Q
 ;
REPAT ;   Report of edited Equipment Records (Action Taken)
 ;   Called by ^ENEQLT
 K %IS("Q") S %ZIS="QM",%ZIS("A")="Select DEVICE for Action Taken Report: "
 D ^%ZIS K %ZIS Q:POP  I $D(IO("Q")) D  D ^%ZISC Q
 . S ZTRTN="DQAT^ENEQLT1",ZTSAVE("EN*")="",ZTDESC="Lockout/Tagout Report"
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
DQAT N PAGE,LINE,ESCAPE,DA,X,T S (PAGE,ESCAPE)=0
 U IO D TABS,HDRAT
 I $D(ZTQUEUED),'$D(^XUTL("ENLT",ENDATE("I"))) D  D ^%ZISC G EXIT
 . W !!,?20,"No list to process."
 S DA=0 F  S DA=$O(^XUTL("ENLT",ENDATE("I"),DA)) Q:'DA  D
 . D PRTAT
 . I LINE>(IOSL-4),$O(^XUTL("ENLT",ENDATE("I"),DA)) D HOLD,HDRAT
 D HOLD,^%ZISC
 G EXIT ;Design EXIT POINT
 ;
PRTAT ;   Get and print equipment data
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
HDRAT ; Header for Activity Report
 W:PAGE>0!($E(IOST,1,2)="C-") @IOF S PAGE=PAGE+1,LINE=6,$X=0
 W "'LOCKOUT REQUIRED?' Flag "_$S(ENACT="S":"SET",1:"CLEARED")_" for ...       ",?(IOM-38),ENDATE,?(IOM-8),"Page "_PAGE
 W !,"ENTRY #",?T(1),"Equipment Category",?T(2),"Manufacturer Equipment Name",?T(3),"Location"
 W !,?T(11),"Manufacturer",?T(12),"Model",?T(13),"Serial Number"
 K X S $P(X,"-",IOM)="-" W !,X,!
 Q
 ;
HOLD Q:$E(IOST,1,2)'="C-"
 W !!,"Press <RETURN> to continue, or '^' to escape..." R X:DTIME
 S:$E(X)="^" ESCAPE=1
 Q
 ;
EXIT K ^XUTL("ENLT",ENDATE("I"))
 I $D(ZTQUEUED) S ZTREQ="@"
 K ENACT,ENDATE
 ;ENEQLT1
